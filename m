Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8323308267
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 01:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbhA2Ad2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 19:33:28 -0500
Received: from relay.smtp-ext.broadcom.com ([192.19.221.30]:42644 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231361AbhA2Ac4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 19:32:56 -0500
Received: from lbrmn-lnxub113.broadcom.net (lbrmn-lnxub113.ric.broadcom.net [10.136.13.65])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 5D59E7FF8;
        Thu, 28 Jan 2021 16:30:53 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 5D59E7FF8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1611880255;
        bh=FZaCZ09Ra7MXy78uk4ySMUne80gk9tszphdysPIchZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DvFtO3W3n0skP0CAxNrPMypwfqNrlx7sLJN7Mm3LlsfLFZKNz6LvaKQ0hsxWBtPFU
         BpMveZeKQFjjuq7vP0PlsqxjqyUVdpCc5uLaIpsiUkUrJ7zWS0wakf9wBTgG231TM0
         djka3cpCnF0GxLDh7zPHfpDrM+mbTmjxMuIyYXJM=
From:   Scott Branden <scott.branden@broadcom.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Olof Johansson <olof@lixom.net>,
        Desmond Yan <desmond.yan@broadcom.com>
Subject: [PATCH v10 05/13] misc: bcm-vk: add triggers when host panic or reboots to notify card
Date:   Thu, 28 Jan 2021 16:30:21 -0800
Message-Id: <20210129003029.10672-6-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210129003029.10672-1-scott.branden@broadcom.com>
References: <20210129003029.10672-1-scott.branden@broadcom.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pass down an interrupt to card in case of panic or reboot so
that card can take appropriate action to perform a clean reset.
Uses kernel notifier block either directly (register on panic list),
or implicitly (add shutdown method for PCI device).

Co-developed-by: Desmond Yan <desmond.yan@broadcom.com>
Signed-off-by: Desmond Yan <desmond.yan@broadcom.com>
Signed-off-by: Scott Branden <scott.branden@broadcom.com>
Acked-by: Olof Johansson <olof@lixom.net>
---
 drivers/misc/bcm-vk/bcm_vk.h     |  2 ++
 drivers/misc/bcm-vk/bcm_vk_dev.c | 29 ++++++++++++++++++++++++++++-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/bcm-vk/bcm_vk.h b/drivers/misc/bcm-vk/bcm_vk.h
index 0a366db693c8..f428ad9a0c3d 100644
--- a/drivers/misc/bcm-vk/bcm_vk.h
+++ b/drivers/misc/bcm-vk/bcm_vk.h
@@ -223,6 +223,8 @@ struct bcm_vk {
 	unsigned long wq_offload[1]; /* various flags on wq requested */
 	void *tdma_vaddr; /* test dma segment virtual addr */
 	dma_addr_t tdma_addr; /* test dma segment bus addr */
+
+	struct notifier_block panic_nb;
 };
 
 /* wq offload work items bits definitions */
diff --git a/drivers/misc/bcm-vk/bcm_vk_dev.c b/drivers/misc/bcm-vk/bcm_vk_dev.c
index 4ecd5b5f80d3..09d99bd36e8a 100644
--- a/drivers/misc/bcm-vk/bcm_vk_dev.c
+++ b/drivers/misc/bcm-vk/bcm_vk_dev.c
@@ -635,6 +635,16 @@ static int bcm_vk_trigger_reset(struct bcm_vk *vk)
 	return 0;
 }
 
+static int bcm_vk_on_panic(struct notifier_block *nb,
+			   unsigned long e, void *p)
+{
+	struct bcm_vk *vk = container_of(nb, struct bcm_vk, panic_nb);
+
+	bcm_to_v_reset_doorbell(vk, VK_BAR0_RESET_DB_HARD);
+
+	return 0;
+}
+
 static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	int err;
@@ -748,6 +758,15 @@ static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* sync other info */
 	bcm_vk_sync_card_info(vk);
 
+	/* register for panic notifier */
+	vk->panic_nb.notifier_call = bcm_vk_on_panic;
+	err = atomic_notifier_chain_register(&panic_notifier_list,
+					     &vk->panic_nb);
+	if (err) {
+		dev_err(dev, "Fail to register panic notifier\n");
+		goto err_destroy_workqueue;
+	}
+
 	/*
 	 * lets trigger an auto download.  We don't want to do it serially here
 	 * because at probing time, it is not supposed to block for a long time.
@@ -756,7 +775,7 @@ static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (auto_load) {
 		if ((boot_status & BOOT_STATE_MASK) == BROM_RUNNING) {
 			if (bcm_vk_trigger_autoload(vk))
-				goto err_destroy_workqueue;
+				goto err_unregister_panic_notifier;
 		} else {
 			dev_err(dev,
 				"Auto-load skipped - BROM not in proper state (0x%x)\n",
@@ -768,6 +787,10 @@ static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	return 0;
 
+err_unregister_panic_notifier:
+	atomic_notifier_chain_unregister(&panic_notifier_list,
+					 &vk->panic_nb);
+
 err_destroy_workqueue:
 	destroy_workqueue(vk->wq_thread);
 
@@ -818,6 +841,10 @@ static void bcm_vk_remove(struct pci_dev *pdev)
 	bcm_vk_trigger_reset(vk);
 	usleep_range(BCM_VK_UCODE_BOOT_US, BCM_VK_UCODE_BOOT_MAX_US);
 
+	/* unregister panic notifier */
+	atomic_notifier_chain_unregister(&panic_notifier_list,
+					 &vk->panic_nb);
+
 	if (vk->tdma_vaddr)
 		dma_free_coherent(&pdev->dev, nr_scratch_pages * PAGE_SIZE,
 				  vk->tdma_vaddr, vk->tdma_addr);
-- 
2.17.1

