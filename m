Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41AAE3E549B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 09:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237633AbhHJHuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 03:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237608AbhHJHux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 03:50:53 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF32C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 00:50:31 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id s22-20020a17090a1c16b0290177caeba067so3217436pjs.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 00:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/RHeBPTuOMxB10H6QZkslWb0rJLIRK93hbSSClhcm2c=;
        b=ELBxyAiyhial+XdZRe4CukGpbRGgUfzu8RW5qurEYbKiGBBovD4fpwwx2Lwo0TgWY0
         Y9aUsHt626k5Jq5mKqqCxxjb34+LDJgb+WZ5tMtlxT95pShg9X/lW9l8F72cpkfd14FY
         +ugFK1VgP1L5v+L7OtDkOK+gvOKPJgdjJGL/MpjJ0rjqqDlMjJxazReSfp8eO7U9+jnp
         SGMTYPvmmvySX8agubpnAS3telRxMQkHy1naMIWb2o8lzM0LEqua3Q3KkcmDBxzmQpPN
         tr1dODJUsj9YXWZ+VT9pT6DiTPdZKxf0qqwKO8d6YPNbAqSmPUDOumfsnbtWZ4fmFrkN
         dMvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/RHeBPTuOMxB10H6QZkslWb0rJLIRK93hbSSClhcm2c=;
        b=kiv3bJxB/pAdLKUjzaZQ1CKNC5oaVHPN8TSJ0lpNhWalbBnOmVoqEe/QTXgxA/LVN0
         ZX6h0JUq6lSGK6ExQRADvQkJKYAyMo2++wDGe/pUGZpObOrYkKLW/dqGkDeuH+QXZEY7
         eI/Tv3O9xvqoqHSXtr4vmuH0Q0YqE4q0O3+QmJpVYaaVbsSla+vS6ZcVc11wA3RKlGrc
         x1lEsCe4/gJmWxKNRBGNv+nOgP63RuByU6VgaxeWqlw+1rTZF1wos4OV7CXYAoa7eLl3
         nTggUIy2YWzpawqK0LQz6Sse29b6R6mN2tFAgvXpO5mCUcJQMlCx54wQzTYg/67NXLPG
         tPOg==
X-Gm-Message-State: AOAM532DeGxcvyhS45D7+hQO60rg8rPTF/FxA+1FFHRI9mOrP+5EVOph
        WZRBMKX+zcz60Vpx8lmJbyM=
X-Google-Smtp-Source: ABdhPJwk/CJIBfRMYphQLGWisEQwdQf5Xl8xNLjc1KmK4pAbpF/4wK8EJgyd38Mz6r01yDpjzWB0dA==
X-Received: by 2002:a17:902:da8a:b029:12c:6f0:fe3c with SMTP id j10-20020a170902da8ab029012c06f0fe3cmr24573627plx.41.1628581830921;
        Tue, 10 Aug 2021 00:50:30 -0700 (PDT)
Received: from localhost.localdomain ([154.16.166.217])
        by smtp.gmail.com with ESMTPSA id v30sm26812765pgk.25.2021.08.10.00.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 00:50:30 -0700 (PDT)
From:   Dongliang Mu <mudongliangabcd@gmail.com>
To:     Samuel Iglesias Gonsalvez <siglesias@igalia.com>,
        Jens Taprogge <jens.taprogge@taprogge.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dongliang Mu <mudongliangabcd@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Aditya Srivastava <yashsri421@gmail.com>,
        Lv Yunlong <lyl2019@mail.ustc.edu.cn>,
        Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     industrypack-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] ipack: tpci200: fix memory leak in the tpci200_register
Date:   Tue, 10 Aug 2021 15:49:22 +0800
Message-Id: <20210810074932.3934499-2-mudongliangabcd@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210810074932.3934499-1-mudongliangabcd@gmail.com>
References: <20210810074932.3934499-1-mudongliangabcd@gmail.com>
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
v1->v2: revise PATCH 2/3, 3/3, not depending on PATCH 1/3; move the
location change of tpci_unregister into one separate patch;
v2->v3: double check all pci_iounmap api invocations
 drivers/ipack/carriers/tpci200.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/ipack/carriers/tpci200.c b/drivers/ipack/carriers/tpci200.c
index 92795a0230ca..cbfdadecb23b 100644
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
+	pci_iounmap(tpci200->info->pdev, tpci200->info->interface_regs);
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

