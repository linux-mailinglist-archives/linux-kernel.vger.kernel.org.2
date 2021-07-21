Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C92173D0D56
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 13:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238656AbhGUKjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 06:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237360AbhGUKb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 06:31:28 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9A1C061768
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 04:12:04 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id t9so1541079pgn.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 04:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SkUFnpammR5qvmmLHDM1ByQe5aFgJKOnL20lxerjN0g=;
        b=eatqqXWt9IMsyrAuhAdryp8H88XHBHdmV6LZ493T7P4EKWzqZUtd9p8OCR685LQzLe
         ncckTLF/VPsESOZkB5eH/Vr5YzcftTn+mVGhLZHjAhASeqRxI2qoauzj48pOixoTbKR+
         YtQ1hFr1xyNbyJyHkyNXOocBK7DiMH8eM1wHLKtLMaE1rO5QBFMGjCGUKJQMItAWcci9
         v8JSYwNqmj3xxAy3D9Es44YXinrokkTQX0Ig3RT6TDLzwfnfjXx3yebIJcc3fKdjec9b
         LXCLYpI8mO2sZFHzr4kaaSZTzirxyRnHzYRJT+9MH/v+JoGqqMCahy/YtRq+FAsQP17j
         6A0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SkUFnpammR5qvmmLHDM1ByQe5aFgJKOnL20lxerjN0g=;
        b=EdaZdmUyo8/tbvgclDFGS0CTMEixNFh3kySDI4aRqjvl1nfe96YTBoGciNDA9uHj80
         sp/OAdRCT+IvgTVDfIrvx911GIoRgUHgwabY/xQNdoW+EgPkTewFsZdD8So1VoK814zC
         rz0pUtbzmfNRtoMEIiFPUPc1Etfb4V3s7PTC9M4bEDEB8F5NMpDYhZqFE7Lyz3b54O4Q
         DGbi5RPd0rzfnfPVSgZe7HdbNRJh9d/iNusChu4kS6yTJrDjseFkTffacARJZXJ8Z3Xm
         vkEwLRs35+hwEDpB+uIvNZOQ3CrfTAeNMz4yhM14br3wPeSgmIx9VkhEYzLBEXqzkrZ0
         /VHg==
X-Gm-Message-State: AOAM532RjAp6MW3fjuvLVLVyA8zimH7ZQ8UeseeM7C7ntF2oU4ERxqNM
        bgyuLpHH6LOMNpGWg6UZBxE=
X-Google-Smtp-Source: ABdhPJzFuzf18okSE9r+UwbqGdLtfSKzcfNkxknTB9072EePP+sZWKwZVfRsSD6kHFA+YCOKEYgetA==
X-Received: by 2002:aa7:86d9:0:b029:32b:5ec8:c87b with SMTP id h25-20020aa786d90000b029032b5ec8c87bmr36317846pfo.1.1626865924291;
        Wed, 21 Jul 2021 04:12:04 -0700 (PDT)
Received: from localhost.localdomain ([154.16.166.166])
        by smtp.gmail.com with ESMTPSA id d3sm2996679pfj.17.2021.07.21.04.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 04:12:03 -0700 (PDT)
From:   Dongliang Mu <mudongliangabcd@gmail.com>
To:     Samuel Iglesias Gonsalvez <siglesias@igalia.com>,
        Jens Taprogge <jens.taprogge@taprogge.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dongliang Mu <mudongliangabcd@gmail.com>,
        Lv Yunlong <lyl2019@mail.ustc.edu.cn>,
        Aditya Srivastava <yashsri421@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        industrypack-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] ipack: tpci200: fix many double free issues in tpci200_pci_probe
Date:   Wed, 21 Jul 2021 19:11:31 +0800
Message-Id: <20210721111137.1523229-2-mudongliangabcd@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210721111137.1523229-1-mudongliangabcd@gmail.com>
References: <20210721111137.1523229-1-mudongliangabcd@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function tpci200_register called by tpci200_install and
tpci200_unregister called by tpci200_uninstall are in pair. However,
tpci200_unregister has some cleanup operations not in the
tpci200_register. So the error handling code of tpci200_pci_probe has
many different double free issues.

Fix this problem by moving those cleanup operations out of
tpci200_unregister, into tpci200_pci_remove and reverting
the previous commit 9272e5d0028d

Reported-by: Dongliang Mu <mudongliangabcd@gmail.com>
Fixes: 9272e5d0028d ("ipack/carriers/tpci200: Fix a double free in tpci200_pci_probe")
Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
---
 drivers/ipack/carriers/tpci200.c | 35 ++++++++++++++++----------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/ipack/carriers/tpci200.c b/drivers/ipack/carriers/tpci200.c
index ca302a87bc22..7fbfb17c341b 100644
--- a/drivers/ipack/carriers/tpci200.c
+++ b/drivers/ipack/carriers/tpci200.c
@@ -89,16 +89,13 @@ static void tpci200_unregister(struct tpci200_board *tpci200)
 	free_irq(tpci200->info->pdev->irq, (void *) tpci200);
 
 	iounmap(tpci200->info->interface_regs);
-	iounmap(tpci200->info->cfg_regs);
 
 	pci_release_region(tpci200->info->pdev, TPCI200_IP_INTERFACE_BAR);
 	pci_release_region(tpci200->info->pdev, TPCI200_IO_ID_INT_SPACES_BAR);
 	pci_release_region(tpci200->info->pdev, TPCI200_MEM16_SPACE_BAR);
 	pci_release_region(tpci200->info->pdev, TPCI200_MEM8_SPACE_BAR);
-	pci_release_region(tpci200->info->pdev, TPCI200_CFG_MEM_BAR);
 
 	pci_disable_device(tpci200->info->pdev);
-	pci_dev_put(tpci200->info->pdev);
 }
 
 static void tpci200_enable_irq(struct tpci200_board *tpci200,
@@ -527,7 +524,7 @@ static int tpci200_pci_probe(struct pci_dev *pdev,
 	tpci200->info = kzalloc(sizeof(struct tpci200_infos), GFP_KERNEL);
 	if (!tpci200->info) {
 		ret = -ENOMEM;
-		goto out_err_info;
+		goto err_tpci200;
 	}
 
 	pci_dev_get(pdev);
@@ -538,7 +535,7 @@ static int tpci200_pci_probe(struct pci_dev *pdev,
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to allocate PCI Configuration Memory");
 		ret = -EBUSY;
-		goto out_err_pci_request;
+		goto err_tpci200_info;
 	}
 	tpci200->info->cfg_regs = ioremap(
 			pci_resource_start(pdev, TPCI200_CFG_MEM_BAR),
@@ -546,7 +543,7 @@ static int tpci200_pci_probe(struct pci_dev *pdev,
 	if (!tpci200->info->cfg_regs) {
 		dev_err(&pdev->dev, "Failed to map PCI Configuration Memory");
 		ret = -EFAULT;
-		goto out_err_ioremap;
+		goto err_request_region;
 	}
 
 	/* Disable byte swapping for 16 bit IP module access. This will ensure
@@ -569,7 +566,7 @@ static int tpci200_pci_probe(struct pci_dev *pdev,
 	if (ret) {
 		dev_err(&pdev->dev, "error during tpci200 install\n");
 		ret = -ENODEV;
-		goto out_err_install;
+		goto err_cfg_regs;
 	}
 
 	/* Register the carrier in the industry pack bus driver */
@@ -581,7 +578,7 @@ static int tpci200_pci_probe(struct pci_dev *pdev,
 		dev_err(&pdev->dev,
 			"error registering the carrier on ipack driver\n");
 		ret = -EFAULT;
-		goto out_err_bus_register;
+		goto err_tpci200_install;
 	}
 
 	/* save the bus number given by ipack to logging purpose */
@@ -592,19 +589,16 @@ static int tpci200_pci_probe(struct pci_dev *pdev,
 		tpci200_create_device(tpci200, i);
 	return 0;
 
-out_err_bus_register:
+err_tpci200_install:
 	tpci200_uninstall(tpci200);
-	/* tpci200->info->cfg_regs is unmapped in tpci200_uninstall */
-	tpci200->info->cfg_regs = NULL;
-out_err_install:
-	if (tpci200->info->cfg_regs)
-		iounmap(tpci200->info->cfg_regs);
-out_err_ioremap:
+err_cfg_regs:
+	iounmap(tpci200->info->cfg_regs);
+err_request_region:
 	pci_release_region(pdev, TPCI200_CFG_MEM_BAR);
-out_err_pci_request:
-	pci_dev_put(pdev);
+err_tpci200_info:
 	kfree(tpci200->info);
-out_err_info:
+	pci_dev_put(pdev);
+err_tpci200:
 	kfree(tpci200);
 	return ret;
 }
@@ -614,6 +608,11 @@ static void __tpci200_pci_remove(struct tpci200_board *tpci200)
 	ipack_bus_unregister(tpci200->info->ipack_bus);
 	tpci200_uninstall(tpci200);
 
+	iounmap(tpci200->info->cfg_regs);
+	pci_release_region(tpci200->info->pdev, TPCI200_CFG_MEM_BAR);
+
+	pci_dev_put(tpci200->info->pdev);
+
 	kfree(tpci200->info);
 	kfree(tpci200);
 }
-- 
2.25.1

