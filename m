Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBDFD30D68C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 10:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbhBCJp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 04:45:27 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:44370 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233385AbhBCJoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 04:44:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1612345494; x=1643881494;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=qzmORu6TPDMtpaBxAL0UiJI+S5JTnIvY28f0uCb5OQA=;
  b=rpgBl3YM73uqjBQV/PLJyAC9ow+QS9xVxY0mHlRPyYOPzpTZ1VfF2kzm
   xmh0FBgveR26PJPrGSGh+e0WuDBt77+7J7XK1iTsZSkdJB8uFZNJpbSjS
   TcKrb2WbJutTunS+hJm8AuQXAAEubO/IEgXy5z9ADGCSGttwKpNbCkLEl
   k=;
X-IronPort-AV: E=Sophos;i="5.79,398,1602547200"; 
   d="scan'208";a="79372647"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-8cc5d68b.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 03 Feb 2021 09:44:05 +0000
Received: from EX13D02EUC001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2b-8cc5d68b.us-west-2.amazon.com (Postfix) with ESMTPS id 25F95A185A;
        Wed,  3 Feb 2021 09:44:04 +0000 (UTC)
Received: from u2196cf9297dc59.ant.amazon.com (10.43.160.66) by
 EX13D02EUC001.ant.amazon.com (10.43.164.92) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 3 Feb 2021 09:43:59 +0000
From:   Filippo Sironi <sironi@amazon.de>
To:     <serebrin@amazon.com>, <dwmw@amazon.co.uk>, <kbusch@kernel.org>,
        <axboe@fb.com>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     Filippo Sironi <sironi@amazon.de>
Subject: [PATCH] nvme: Add 48-bit DMA address quirk
Date:   Wed, 3 Feb 2021 10:43:38 +0100
Message-ID: <20210203094338.19473-1-sironi@amazon.de>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.66]
X-ClientProxiedBy: EX13D04UWA001.ant.amazon.com (10.43.160.47) To
 EX13D02EUC001.ant.amazon.com (10.43.164.92)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Certain NVMe controllers don't support 64-bit DMA addresses.  Instead,
they are limited to 48-bit DMA addresses.  Let's add a quirk to use them
properly.

Signed-off-by: Filippo Sironi <sironi@amazon.de>
---
 drivers/nvme/host/nvme.h |  5 +++++
 drivers/nvme/host/pci.c  | 12 +++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 88a6b97247f5..dae747b4ac35 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -144,6 +144,11 @@ enum nvme_quirks {
 	 * NVMe 1.3 compliance.
 	 */
 	NVME_QUIRK_NO_NS_DESC_LIST		= (1 << 15),
+
+	/*
+	 * The controller supports up to 48-bit DMA address.
+	 */
+	NVME_QUIRK_DMA_ADDRESS_BITS_48		= (1 << 16),
 };
 
 /*
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 81e6389b2042..5716ae16c7a7 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2362,13 +2362,16 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 {
 	int result = -ENOMEM;
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
+	int dma_address_bits = 64;
 
 	if (pci_enable_device_mem(pdev))
 		return result;
 
 	pci_set_master(pdev);
 
-	if (dma_set_mask_and_coherent(dev->dev, DMA_BIT_MASK(64)))
+	if (dev->ctrl.quirks & NVME_QUIRK_DMA_ADDRESS_BITS_48)
+		dma_address_bits = 48;
+	if (dma_set_mask_and_coherent(dev->dev, DMA_BIT_MASK(dma_address_bits)))
 		goto disable;
 
 	if (readl(dev->bar + NVME_REG_CSTS) == -1) {
@@ -3259,6 +3262,13 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x1d97, 0x2263),   /* SPCC */
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
+	{ .vendor = PCI_VENDOR_ID_AMAZON,
+	  .device = PCI_ANY_ID,
+	  .subvendor = PCI_ANY_ID,
+	  .subdevice = PCI_ANY_ID,
+	  .class = PCI_CLASS_STORAGE_EXPRESS,
+	  .class_mask = 0xffffff,
+	  .driver_data = NVME_QUIRK_DMA_ADDRESS_BITS_48 },
 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2001),
 		.driver_data = NVME_QUIRK_SINGLE_VECTOR },
 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2003) },
-- 
2.17.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



