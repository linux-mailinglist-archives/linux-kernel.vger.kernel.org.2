Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9173E4792
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 16:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235143AbhHIOcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 10:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232741AbhHIObz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 10:31:55 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D1FC0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 07:31:35 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d1so16542460pll.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 07:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OpS0RexRhBFi/o7x/p5/cbSv6COvk+NYumE2BqGvbf0=;
        b=dE+pu7up8tanVcJHNXGHLTVKwMAp8AxjHa/1pLtdf7HeP5DjB4diHI7JU1w6EO2Afr
         Erh7dplk++AbcbWTNhGNfUVzY/jjy5PIcm2rUDaGjDtaObPj7W9+wKCYRk7m/X/yBISM
         1hcLkbAL+EAd61o/9pBefAb7pVdjXY48zvlBTehOG0mtg3VEx2GRgwwKPYMJ3GDJubby
         ISRignXQZeVjEGFXeOqMNUEGppsjSma8o/9NTNCV9Rzp24xJBKNsLGDoz8y6OhkPxekq
         05mx1ly6nAXLOEf5LnXavpgdFj8qQKZiu5KoOh2G4RsyiQpjl9M6KU6t2/cB2yGo9V91
         7Yrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OpS0RexRhBFi/o7x/p5/cbSv6COvk+NYumE2BqGvbf0=;
        b=BjZqrHIswjCmB/1zA/5ddVGYkp7GBvI31+Xd+iXHg7Djws9yrV6tNUh6uhQgmOuo0j
         Xxi6ty1HByI8McyWb1CbsxTh3ZT16IfR7VtanP/1WoWY0oXaXAXqldWRJPu0nl3n786u
         AfMB9KDItEiXe7CB1DpSXhE1HLUf2EGyREcPKSFH2LLrf+S+ENI4SFGj61likda8k7Ms
         EkggoDnIBOyXCddkmjNnb3LMzxE6gOimFiz7uUdC+BzND6y3eEL2TnGFyzZpc9uoZ7Do
         zitn2HWkCLg5kgrpsjhrsZMVZ1BegopKC0kb52SDLKHSemR2k7Z3sHyjgXfTP6noV7wM
         8dbg==
X-Gm-Message-State: AOAM531/VawiY38yYFGjaluv29ElitMGSeotAVPNnGoWSTHiDLKNRY7P
        8+DCTYL04hwoTCDQbPVQ9RE=
X-Google-Smtp-Source: ABdhPJxKMDgnioIJ7Ib9/Cmn0sku1hKv5sHNFJ6yCmbgS4x94EOtyuvpioz8bA8R/XajZSkXWTiP1Q==
X-Received: by 2002:a17:90a:e651:: with SMTP id ep17mr25750610pjb.85.1628519494631;
        Mon, 09 Aug 2021 07:31:34 -0700 (PDT)
Received: from localhost.localdomain ([154.16.166.217])
        by smtp.gmail.com with ESMTPSA id g19sm9369747pfc.168.2021.08.09.07.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 07:31:34 -0700 (PDT)
From:   Dongliang Mu <mudongliangabcd@gmail.com>
To:     Samuel Iglesias Gonsalvez <siglesias@igalia.com>,
        Jens Taprogge <jens.taprogge@taprogge.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dongliang Mu <mudongliangabcd@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Lv Yunlong <lyl2019@mail.ustc.edu.cn>,
        Aditya Srivastava <yashsri421@gmail.com>
Cc:     industrypack-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] ipack: tpci200: change pci_iounmap to iounmap
Date:   Mon,  9 Aug 2021 22:30:28 +0800
Message-Id: <20210809143049.3531188-3-mudongliangabcd@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210809143049.3531188-1-mudongliangabcd@gmail.com>
References: <20210809143049.3531188-1-mudongliangabcd@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The deallocation api for ioremap should be iounmap, other than
pci_iounmap.

Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
---
 drivers/ipack/carriers/tpci200.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ipack/carriers/tpci200.c b/drivers/ipack/carriers/tpci200.c
index b1562b881cd1..307f94f59c18 100644
--- a/drivers/ipack/carriers/tpci200.c
+++ b/drivers/ipack/carriers/tpci200.c
@@ -88,7 +88,7 @@ static void tpci200_unregister(struct tpci200_board *tpci200)
 {
 	free_irq(tpci200->info->pdev->irq, (void *) tpci200);
 
-	pci_iounmap(tpci200->info->pdev, tpci200->info->interface_regs);
+	iounmap(tpci200->info->pdev, tpci200->info->interface_regs);
 
 	pci_release_region(tpci200->info->pdev, TPCI200_IP_INTERFACE_BAR);
 	pci_release_region(tpci200->info->pdev, TPCI200_IO_ID_INT_SPACES_BAR);
@@ -347,7 +347,7 @@ static int tpci200_register(struct tpci200_board *tpci200)
 	return 0;
 
 err_interface_regs:
-	pci_iounmap(tpci200->info->interface_regs);
+	iounmap(tpci200->info->interface_regs);
 err_mem16_space_bar:
 	pci_release_region(tpci200->info->pdev, TPCI200_MEM16_SPACE_BAR);
 err_mem8_space_bar:
@@ -596,7 +596,7 @@ static int tpci200_pci_probe(struct pci_dev *pdev,
 err_tpci200_install:
 	tpci200_uninstall(tpci200);
 err_cfg_regs:
-	pci_iounmap(tpci200->info->cfg_regs);
+	iounmap(tpci200->info->cfg_regs);
 err_request_region:
 	pci_release_region(pdev, TPCI200_CFG_MEM_BAR);
 err_tpci200_info:
@@ -612,7 +612,7 @@ static void __tpci200_pci_remove(struct tpci200_board *tpci200)
 	ipack_bus_unregister(tpci200->info->ipack_bus);
 	tpci200_uninstall(tpci200);
 
-	pci_iounmap(tpci200->info->cfg_regs);
+	iounmap(tpci200->info->cfg_regs);
 	pci_release_region(tpci200->info->pdev, TPCI200_CFG_MEM_BAR);
 
 	pci_dev_put(tpci200->info->pdev);
-- 
2.25.1

