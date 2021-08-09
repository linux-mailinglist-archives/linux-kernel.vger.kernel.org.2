Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 588E33E4791
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 16:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235090AbhHIOcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 10:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235133AbhHIObw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 10:31:52 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A440BC061798
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 07:31:24 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id hv22-20020a17090ae416b0290178c579e424so158734pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 07:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vo3py+e+BgwTahiTV//vXLvMC8Sj2tczhU/uqnpWeaI=;
        b=i7vMCM8DpLZgE/84dWMs2sqUdL74i01PXAKaGu0Z0kHXgfqwezHnTe9IA1ogMFRzmP
         NewV6loWd/z29r2q/euZBLTYLoNrilUE8RNm4ZoC7jxWsudqRsk55Co1haochrqJqtOu
         zPnL1yOSGD1+fVD0Y+tpOSXaf/RtrNrRBA2sZO7rqqjcVKUCUQp+JTEd3sYCcyxPzUPf
         XU314WhYeyeqiv32scT0h+c7qmdXtHm0JqUdrvVEVa6131+C7TvaXnC+eIg2OxPbEbo2
         dMgOB/1zXD4hblyXFPSOc6eohdRpMVLXNaeQ0Wv/vVQcX90EijensuBv4moL5ieqPPW0
         B6+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vo3py+e+BgwTahiTV//vXLvMC8Sj2tczhU/uqnpWeaI=;
        b=eqYQl25ARLgqyxxOLAOArEvReN6B+uLehAyKGHHQwPzMOwTy4J/XSKNLBJinYAdUPn
         eYVCFN2kefLUt7saW75EcJMrKaFskw6kObPwZnMyd57HLJ3INj8bEmnDgUdarwQ5ZeBK
         1OWLHPbhjv8YR7JpKHLTsHm0h1V0cGFHrW+RDH1hvSjsdoMc7NB7/8OQ/PeQvHrP1RKL
         dHSbudxEtlEvtDLV4uzmYG3sJVAQo/3fWxudVFl5IbWbQc3XSnlgKq3Dflflyx4VSMt9
         NkI2nEeH0UN0GC4Agto1GrCqjhbGB7Sxgudhtlr2Fu85k5duM7lVrcoNycXJWVZp08ZJ
         oD3w==
X-Gm-Message-State: AOAM533HdMNSEr8FpKIz68SoDnU9Hvvt3yntH9PAvPp2r5WSrgltudZg
        GTpqa5ofB4XU6QYweZOCqd0=
X-Google-Smtp-Source: ABdhPJxrDS/Eu3C3+2rMr//2QwRJsmW9hEsaR/OhyuqF9uIowSyXyrq8WKIAuFmTaIqEKaAx6lySTw==
X-Received: by 2002:a65:5ace:: with SMTP id d14mr45382pgt.235.1628519484188;
        Mon, 09 Aug 2021 07:31:24 -0700 (PDT)
Received: from localhost.localdomain ([154.16.166.217])
        by smtp.gmail.com with ESMTPSA id g19sm9369747pfc.168.2021.08.09.07.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 07:31:23 -0700 (PDT)
From:   Dongliang Mu <mudongliangabcd@gmail.com>
To:     Samuel Iglesias Gonsalvez <siglesias@igalia.com>,
        Jens Taprogge <jens.taprogge@taprogge.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dongliang Mu <mudongliangabcd@gmail.com>,
        Aditya Srivastava <yashsri421@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Lv Yunlong <lyl2019@mail.ustc.edu.cn>,
        Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     industrypack-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] ipack: tpci200: fix memory leak in the tpci200_register
Date:   Mon,  9 Aug 2021 22:30:27 +0800
Message-Id: <20210809143049.3531188-2-mudongliangabcd@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210809143049.3531188-1-mudongliangabcd@gmail.com>
References: <20210809143049.3531188-1-mudongliangabcd@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The error handling code in tpci200_register does not free interface_regs
allocated by ioremap and the current version of error handling code is
problematic.

Fix this by refactoring the error handling code and free interface_regs
when necessary.

Reported-by: Dongliang Mu <mudongliangabcd@gmail.com>
Fixes: 43986798fd50 ("ipack: add error handling for ioremap_nocache")
Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
---
 drivers/ipack/carriers/tpci200.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/ipack/carriers/tpci200.c b/drivers/ipack/carriers/tpci200.c
index 3f198b2405e3..b1562b881cd1 100644
--- a/drivers/ipack/carriers/tpci200.c
+++ b/drivers/ipack/carriers/tpci200.c
@@ -254,7 +254,7 @@ static int tpci200_register(struct tpci200_board *tpci200)
 			"(bn 0x%X, sn 0x%X) failed to allocate PCI resource for BAR 2 !",
 			tpci200->info->pdev->bus->number,
 			tpci200->info->pdev->devfn);
-		goto out_disable_pci;
+		goto err_disable_device;
 	}
 
 	/* Request IO ID INT space (Bar 3) */
@@ -266,7 +266,7 @@ static int tpci200_register(struct tpci200_board *tpci200)
 			"(bn 0x%X, sn 0x%X) failed to allocate PCI resource for BAR 3 !",
 			tpci200->info->pdev->bus->number,
 			tpci200->info->pdev->devfn);
-		goto out_release_ip_space;
+		goto err_ip_interface_bar;
 	}
 
 	/* Request MEM8 space (Bar 5) */
@@ -277,7 +277,7 @@ static int tpci200_register(struct tpci200_board *tpci200)
 			"(bn 0x%X, sn 0x%X) failed to allocate PCI resource for BAR 5!",
 			tpci200->info->pdev->bus->number,
 			tpci200->info->pdev->devfn);
-		goto out_release_ioid_int_space;
+		goto err_io_id_int_spaces_bar;
 	}
 
 	/* Request MEM16 space (Bar 4) */
@@ -288,7 +288,7 @@ static int tpci200_register(struct tpci200_board *tpci200)
 			"(bn 0x%X, sn 0x%X) failed to allocate PCI resource for BAR 4!",
 			tpci200->info->pdev->bus->number,
 			tpci200->info->pdev->devfn);
-		goto out_release_mem8_space;
+		goto err_mem8_space_bar;
 	}
 
 	/* Map internal tpci200 driver user space */
@@ -302,7 +302,7 @@ static int tpci200_register(struct tpci200_board *tpci200)
 			tpci200->info->pdev->bus->number,
 			tpci200->info->pdev->devfn);
 		res = -ENOMEM;
-		goto out_release_mem8_space;
+		goto err_mem16_space_bar;
 	}
 
 	/* Initialize lock that protects interface_regs */
@@ -341,18 +341,22 @@ static int tpci200_register(struct tpci200_board *tpci200)
 			"(bn 0x%X, sn 0x%X) unable to register IRQ !",
 			tpci200->info->pdev->bus->number,
 			tpci200->info->pdev->devfn);
-		goto out_release_ioid_int_space;
+		goto err_interface_regs;
 	}
 
 	return 0;
 
-out_release_mem8_space:
+err_interface_regs:
+	pci_iounmap(tpci200->info->interface_regs);
+err_mem16_space_bar:
+	pci_release_region(tpci200->info->pdev, TPCI200_MEM16_SPACE_BAR);
+err_mem8_space_bar:
 	pci_release_region(tpci200->info->pdev, TPCI200_MEM8_SPACE_BAR);
-out_release_ioid_int_space:
+err_io_id_int_spaces_bar:
 	pci_release_region(tpci200->info->pdev, TPCI200_IO_ID_INT_SPACES_BAR);
-out_release_ip_space:
+err_ip_interface_bar:
 	pci_release_region(tpci200->info->pdev, TPCI200_IP_INTERFACE_BAR);
-out_disable_pci:
+err_disable_device:
 	pci_disable_device(tpci200->info->pdev);
 	return res;
 }
-- 
2.25.1

