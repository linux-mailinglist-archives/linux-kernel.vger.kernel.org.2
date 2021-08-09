Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3007A3E4794
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 16:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235210AbhHIOcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 10:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235106AbhHIObq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 10:31:46 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F09EC061796
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 07:31:08 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id z3so16508992plg.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 07:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9KPwHLP2TIeqi7sHV+xL15XVmrHicKr0odVFpp2Zg6s=;
        b=MDkuGMRr4OFLx5chQf563kLDR5GLpI7zL/x6UwtpltwPIGo+itIUL6r9dMsxF2Wgkp
         /15USxvymFIxWrRHhDkOpQpcO+tpopR/EW05q8LztBilVAv/jJeBdbjb5xU32P3uOFFB
         9DYM9oWixIFMdb72exgM8UfxRqfsIy/5/A81ekEDeafyV91wWXQ6AheNEOtlt5MvnGRx
         CGcSFu+kP+PCtb/a/F2u+7SVHus9/RWEKMnhCpiIXEsIBUFFFNKDVdWikHalgxNiVLWF
         4GPQYM8+2JWVGarn70V/cbcLK70oTLf0WwQHnPYx/M/wk2wiC6V4kIie0aC3kokjhKCl
         OTAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9KPwHLP2TIeqi7sHV+xL15XVmrHicKr0odVFpp2Zg6s=;
        b=CUI3QXoqfwYcLD3QGciw38Q+XHMM9AXOIiq3hpl2k6i3ov2QEMPQ3oZLOyszD/bMzQ
         jWua/S/+3HagkcUVKC2ZnwKDR92beTfBNBv8e4Zvyl2+cgkStURkqGykDJsZ5Ya6wn4q
         VfRm/0Cp7Nr61X4vTkYlrnAnzFD5VtRNka9ItCNRR+Pio9q3n4XUqDZVeHxn0mJAsz+9
         J9xjyKTT2WrwKaSVf9P07dXMF03ZzJNu64KpEx9BiyoKiAdENfi84pdl7MWf5YWiLVSC
         1H2L+m+EY1rc9b0o/pWG5Ixh0jZkmp12pLJXj5W4oEni7zA93V0v7x8T1wOf+w+yHETw
         kJ6w==
X-Gm-Message-State: AOAM531Z1+e9YQu8izsSxvhxQLGv35htbrZycT1z3mR6EUgqD00OBgsY
        soW98TEqvxa9d5yO6gmBOjU=
X-Google-Smtp-Source: ABdhPJzR+1ovd1u+rZLYGtEcdERCOhXTGWlhCf2zDRnPdxqstEb8Lz4hwUjmWR5KVqF7bThCly3Qsg==
X-Received: by 2002:a05:6a00:1903:b029:3b6:7918:7ddf with SMTP id y3-20020a056a001903b02903b679187ddfmr18577306pfi.53.1628519467951;
        Mon, 09 Aug 2021 07:31:07 -0700 (PDT)
Received: from localhost.localdomain ([154.16.166.217])
        by smtp.gmail.com with ESMTPSA id g19sm9369747pfc.168.2021.08.09.07.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 07:31:07 -0700 (PDT)
From:   Dongliang Mu <mudongliangabcd@gmail.com>
To:     Samuel Iglesias Gonsalvez <siglesias@igalia.com>,
        Jens Taprogge <jens.taprogge@taprogge.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dongliang Mu <mudongliangabcd@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Aditya Srivastava <yashsri421@gmail.com>,
        Lv Yunlong <lyl2019@mail.ustc.edu.cn>
Cc:     industrypack-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] ipack: tpci200: fix many double free issues in tpci200_pci_probe
Date:   Mon,  9 Aug 2021 22:30:26 +0800
Message-Id: <20210809143049.3531188-1-mudongliangabcd@gmail.com>
X-Mailer: git-send-email 2.25.1
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
the previous commit 9272e5d0028d ("ipack/carriers/tpci200:
Fix a double free in tpci200_pci_probe").

Reported-by: Dongliang Mu <mudongliangabcd@gmail.com>
Fixes: 9272e5d0028d ("ipack/carriers/tpci200: Fix a double free in tpci200_pci_probe")
Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
---
v1->v2: revise PATCH 2/3, 3/3, not depending on PATCH 1/3; move the
location change of tpci_unregister into one separate patch;
 drivers/ipack/carriers/tpci200.c | 35 ++++++++++++++++----------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/ipack/carriers/tpci200.c b/drivers/ipack/carriers/tpci200.c
index 3461b0a7dc62..3f198b2405e3 100644
--- a/drivers/ipack/carriers/tpci200.c
+++ b/drivers/ipack/carriers/tpci200.c
@@ -89,16 +89,13 @@ static void tpci200_unregister(struct tpci200_board *tpci200)
 	free_irq(tpci200->info->pdev->irq, (void *) tpci200);
 
 	pci_iounmap(tpci200->info->pdev, tpci200->info->interface_regs);
-	pci_iounmap(tpci200->info->pdev, tpci200->info->cfg_regs);
 
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
+	pci_iounmap(tpci200->info->cfg_regs);
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
 
+	pci_iounmap(tpci200->info->cfg_regs);
+	pci_release_region(tpci200->info->pdev, TPCI200_CFG_MEM_BAR);
+
+	pci_dev_put(tpci200->info->pdev);
+
 	kfree(tpci200->info);
 	kfree(tpci200);
 }
-- 
2.25.1

