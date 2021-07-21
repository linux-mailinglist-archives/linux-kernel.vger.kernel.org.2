Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDD53D0D57
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 13:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238888AbhGUKkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 06:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233818AbhGUKcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 06:32:15 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99191C0613DB
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 04:12:14 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id bt15so1457059pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 04:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bAqxaWmRBbvBfwuN5ASS6Uh0iJY+nOJwOMZ0keYIQDw=;
        b=qt67IGjTPJZS6aaVp8yIpa0wU+6sFCjAyFY5RSfft5+W4JO4dGf+LU3ABswiLiD6L6
         Bm0w3ut+uaWNbM2s+9Lx3cCCFYMJdC+a+JMeF9l0/UkSKIvqXOdTTJTD4xz0GS+d/shP
         FlQgtq36QOHmvLsxbhC5vXIEEOj4VNBFMCr3vWDJUb050fn2q5wP8sdyaFy54rcv8u++
         naqK9lhFmoaWEK+JLap8jSQaTYtiWo88rFjQgro4JdsSvwJJj06qmSroSl9omr+46gtQ
         QNgJE8gCcfXnTcrcBkR5lnLX4C+V4Qz2qqmWBaHLLf0VWnBS052VG/lrjAWlJESUzO0a
         Z0LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bAqxaWmRBbvBfwuN5ASS6Uh0iJY+nOJwOMZ0keYIQDw=;
        b=jCNqA8mo7Mi6xZNRKWX82vjkT9v3lEvIV3OL98Xma/vauelmi4htl6vUhE9sVFwxgH
         /DN9gLqOUiQOcgXb5eUpl7KlPzFNCNbx2Vq2yAzzbc4Kqd8oYTf0lqC+ae9Dx2fIXsyc
         yhsVYLJVEdich6X7HW1SxQNyngrdoW4EVjZ1AnR0Yih/opesbKgu5mPERtK8dHsA5nws
         LAf0D9F05hVhQicp6OEEVo6NDU2UiB99Rmsr4kP2OIEOJAVsYQMuQAlmL9nD2Thx5fzg
         sTcrVQ+Oon/rqrpTxbb7XJuWRmEYt6Jut8ZJbAhdlyDucOPpUowgWCHMXMWIVVbLwThU
         WKWQ==
X-Gm-Message-State: AOAM533tFLUJ1C+gBNgtiApjg2c1UmUvp3tdR1J0DWekf3LXG02Zjn1M
        /rB8gaU26XRAKiTHEkP22x0=
X-Google-Smtp-Source: ABdhPJydG9fKfnTDWkaV9pJzrkP9wFBteirSAxx44ckK1orQbNo3gLC8X9n8ArZjAeaLSQ3PEYyQJg==
X-Received: by 2002:a17:902:ecce:b029:12b:1c81:2741 with SMTP id a14-20020a170902ecceb029012b1c812741mr27286593plh.3.1626865934058;
        Wed, 21 Jul 2021 04:12:14 -0700 (PDT)
Received: from localhost.localdomain ([154.16.166.166])
        by smtp.gmail.com with ESMTPSA id d3sm2996679pfj.17.2021.07.21.04.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 04:12:13 -0700 (PDT)
From:   Dongliang Mu <mudongliangabcd@gmail.com>
To:     Samuel Iglesias Gonsalvez <siglesias@igalia.com>,
        Jens Taprogge <jens.taprogge@taprogge.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dongliang Mu <mudongliangabcd@gmail.com>,
        Aditya Srivastava <yashsri421@gmail.com>,
        Lv Yunlong <lyl2019@mail.ustc.edu.cn>,
        Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        industrypack-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] ipack: tpci200: fix memory leak in the tpci200_register
Date:   Wed, 21 Jul 2021 19:11:32 +0800
Message-Id: <20210721111137.1523229-3-mudongliangabcd@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210721111137.1523229-1-mudongliangabcd@gmail.com>
References: <20210721111137.1523229-1-mudongliangabcd@gmail.com>
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
 drivers/ipack/carriers/tpci200.c | 52 +++++++++++++++++---------------
 1 file changed, 28 insertions(+), 24 deletions(-)

diff --git a/drivers/ipack/carriers/tpci200.c b/drivers/ipack/carriers/tpci200.c
index 7fbfb17c341b..a4e5883321df 100644
--- a/drivers/ipack/carriers/tpci200.c
+++ b/drivers/ipack/carriers/tpci200.c
@@ -84,20 +84,6 @@ static void tpci200_set_mask(struct tpci200_board *tpci200,
 	spin_unlock_irqrestore(&tpci200->regs_lock, flags);
 }
 
-static void tpci200_unregister(struct tpci200_board *tpci200)
-{
-	free_irq(tpci200->info->pdev->irq, (void *) tpci200);
-
-	iounmap(tpci200->info->interface_regs);
-
-	pci_release_region(tpci200->info->pdev, TPCI200_IP_INTERFACE_BAR);
-	pci_release_region(tpci200->info->pdev, TPCI200_IO_ID_INT_SPACES_BAR);
-	pci_release_region(tpci200->info->pdev, TPCI200_MEM16_SPACE_BAR);
-	pci_release_region(tpci200->info->pdev, TPCI200_MEM8_SPACE_BAR);
-
-	pci_disable_device(tpci200->info->pdev);
-}
-
 static void tpci200_enable_irq(struct tpci200_board *tpci200,
 			       int islot)
 {
@@ -254,7 +240,7 @@ static int tpci200_register(struct tpci200_board *tpci200)
 			"(bn 0x%X, sn 0x%X) failed to allocate PCI resource for BAR 2 !",
 			tpci200->info->pdev->bus->number,
 			tpci200->info->pdev->devfn);
-		goto out_disable_pci;
+		goto err_enable_device;
 	}
 
 	/* Request IO ID INT space (Bar 3) */
@@ -266,7 +252,7 @@ static int tpci200_register(struct tpci200_board *tpci200)
 			"(bn 0x%X, sn 0x%X) failed to allocate PCI resource for BAR 3 !",
 			tpci200->info->pdev->bus->number,
 			tpci200->info->pdev->devfn);
-		goto out_release_ip_space;
+		goto err_ip_interface_bar;
 	}
 
 	/* Request MEM8 space (Bar 5) */
@@ -277,7 +263,7 @@ static int tpci200_register(struct tpci200_board *tpci200)
 			"(bn 0x%X, sn 0x%X) failed to allocate PCI resource for BAR 5!",
 			tpci200->info->pdev->bus->number,
 			tpci200->info->pdev->devfn);
-		goto out_release_ioid_int_space;
+		goto err_io_id_int_spaces_bar;
 	}
 
 	/* Request MEM16 space (Bar 4) */
@@ -288,7 +274,7 @@ static int tpci200_register(struct tpci200_board *tpci200)
 			"(bn 0x%X, sn 0x%X) failed to allocate PCI resource for BAR 4!",
 			tpci200->info->pdev->bus->number,
 			tpci200->info->pdev->devfn);
-		goto out_release_mem8_space;
+		goto err_mem8_space_bar;
 	}
 
 	/* Map internal tpci200 driver user space */
@@ -302,7 +288,7 @@ static int tpci200_register(struct tpci200_board *tpci200)
 			tpci200->info->pdev->bus->number,
 			tpci200->info->pdev->devfn);
 		res = -ENOMEM;
-		goto out_release_mem8_space;
+		goto err_mem16_space_bar;
 	}
 
 	/* Initialize lock that protects interface_regs */
@@ -341,22 +327,40 @@ static int tpci200_register(struct tpci200_board *tpci200)
 			"(bn 0x%X, sn 0x%X) unable to register IRQ !",
 			tpci200->info->pdev->bus->number,
 			tpci200->info->pdev->devfn);
-		goto out_release_ioid_int_space;
+		goto err_interface_regs;
 	}
 
 	return 0;
 
-out_release_mem8_space:
+err_interface_regs:
+	iounmap(tpci200->info->interface_regs);
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
+err_enable_device:
 	pci_disable_device(tpci200->info->pdev);
 	return res;
 }
 
+static void tpci200_unregister(struct tpci200_board *tpci200)
+{
+	free_irq(tpci200->info->pdev->irq, (void *) tpci200);
+
+	iounmap(tpci200->info->interface_regs);
+
+	pci_release_region(tpci200->info->pdev, TPCI200_IP_INTERFACE_BAR);
+	pci_release_region(tpci200->info->pdev, TPCI200_IO_ID_INT_SPACES_BAR);
+	pci_release_region(tpci200->info->pdev, TPCI200_MEM16_SPACE_BAR);
+	pci_release_region(tpci200->info->pdev, TPCI200_MEM8_SPACE_BAR);
+
+	pci_disable_device(tpci200->info->pdev);
+}
+
 static int tpci200_get_clockrate(struct ipack_device *dev)
 {
 	struct tpci200_board *tpci200 = check_slot(dev);
-- 
2.25.1

