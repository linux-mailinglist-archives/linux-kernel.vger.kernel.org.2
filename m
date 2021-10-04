Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C78BB4210D6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 15:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235865AbhJDN6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 09:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238910AbhJDN6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 09:58:22 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86405C04AEF0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 06:54:07 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id x4so11147834pln.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 06:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6pWZxY1yQdsUwMEG6Is0voI7d8xdXhwobuZZscOdeBw=;
        b=GEPnpVfVlvIMaa15IDrdstFCMhwgZRFdbQv5+Ese4TaXfcnzb8DUsdK+lLmMohOYBz
         dMvGXI3KMUoKzWc22yZzSmOFn1Iim2snCmm61DQ0QD/YCGKx7m7xah2wEt4U4cSQhwpd
         4P3J6tGT/c5xXB0qZbYd1yGLEhUbvtISZ8urAhZijVsN8iV2Gg49QblQ88XzBg2XpVtx
         kB/0C2ROjpQTn+gfG7xJP9ZCrn/bdTYqKYJUru/lK+WfZrp70Tyk3go7v1o+gntoZprO
         mLC/etQtJ7o2ec+x/CPUDFeU9v8gR6il4yu9icl309kDfDR3Olbty/oSGOr2O6PWJ4oM
         nk0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6pWZxY1yQdsUwMEG6Is0voI7d8xdXhwobuZZscOdeBw=;
        b=jkyZbyIZ1DUYj5duMqFr6JKqwaJgUulxQjbKCh5VxB/T+i+n8GzYO2FUG8Yh+7xR3/
         B/pwQClQm9TQYe5oBue4Lg8n7SLzE2lTQ31/LcTviBQ1QajrZ66GclFq+O68Bejf30V9
         aIsRkq5YmfXPJEpQJMxpK5gVkR9ipUVoD0uHFlF/T1MQNbxLIOLvhTT9XD3cWuQ64kYY
         MnKhMmnt6Wwiwp6bc7gBHKZ17bMuk2rbSv0PEi2312hKYlmyn+SbRKSCx0/ijYb9889v
         J75hrC3/1+ql4AuoBDxdo+yTBH4ClNuxpv1DoGmROLkF1GSJDQojQC8ABQUGk+NIC2ex
         7a0A==
X-Gm-Message-State: AOAM531sm6uhMkDd7LPdKaCOy/45t3UXHIyvhFJkUDPzB09tszWqfz0R
        kdB7ScYvdgoSFpuu6O1RDV61Vk8mFuaCMZd+
X-Google-Smtp-Source: ABdhPJw1jCD2kuezA7hXQsEBL/XXP1JvlA4weed4pnGBvJ8bxSlzpmzJ645eesGWKLrB6T1ZUZ9pzA==
X-Received: by 2002:a17:90a:86:: with SMTP id a6mr36432880pja.190.1633355647092;
        Mon, 04 Oct 2021 06:54:07 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:e8f0:c2a7:3579:5fe8:31d9])
        by smtp.gmail.com with ESMTPSA id k17sm12209548pfu.82.2021.10.04.06.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 06:54:06 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com, ruscur@russell.cc, oohall@gmail.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 8/8] PCI/AER: Include DEVCTL in aer_print_error()
Date:   Mon,  4 Oct 2021 19:22:43 +0530
Message-Id: <e39df4392e514bae8dbd373a3c92d994d8c2ae49.1633353468.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1633353468.git.naveennaidu479@gmail.com>
References: <cover.1633353468.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Print the contents of Device Control Register of the device which
detected the error. This might help in faster error diagnosis.

Sample output from dummy error injected by aer-inject:

  pcieport 0000:00:03.0: AER: Corrected error received: 0000:00:03.0
  pcieport 0000:00:03.0: PCIe Bus Error: severity=Corrected, type=Data Link Layer, (Receiver)
  pcieport 0000:00:03.0:   device [1b36:000c] error status/mask=00000040/0000e000, devctl=0x000f
  pcieport 0000:00:03.0:    [ 6] BadTLP

Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/pci.h      |  2 ++
 drivers/pci/pcie/aer.c | 10 ++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index eb88d8bfeaf7..48ed7f91113b 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -437,6 +437,8 @@ struct aer_err_info {
 	u32 status;		/* COR/UNCOR Error Status */
 	u32 mask;		/* COR/UNCOR Error Mask */
 	struct aer_header_log_regs tlp;	/* TLP Header */
+
+	u16 devctl;
 };
 
 /* Preliminary AER error information processed from Root port */
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 91f91d6ab052..42cae01b6887 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -729,8 +729,8 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 		   aer_error_severity_string[info->severity],
 		   aer_error_layer[layer], aer_agent_string[agent]);
 
-	pci_printk(level, dev, "  device [%04x:%04x] error status/mask=%08x/%08x\n",
-		   dev->vendor, dev->device, info->status, info->mask);
+	pci_printk(level, dev, "  device [%04x:%04x] error status/mask=%08x/%08x, devctl=%#06x\n",
+		   dev->vendor, dev->device, info->status, info->mask, info->devctl);
 
 	__aer_print_error(dev, info);
 
@@ -1083,6 +1083,12 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
 	if (!aer)
 		return 0;
 
+	/*
+	 * Cache the value of Device Control Register now, because later the
+	 * device might not be available
+	 */
+	pcie_capability_read_word(dev, PCI_EXP_DEVCTL, &info->devctl);
+
 	if (info->severity == AER_CORRECTABLE) {
 		pci_read_config_dword(dev, aer + PCI_ERR_COR_STATUS,
 			&info->status);
-- 
2.25.1

