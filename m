Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 406F93F9783
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 11:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245062AbhH0JpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 05:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245005AbhH0Joz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 05:44:55 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241A0C0617A8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 02:44:07 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id e16so4795649pfc.6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 02:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wayLOd5wtu3dJzrv0vfB7W5+rCLS0oWQSMlaWOVxFrU=;
        b=fPzM/e13yE1Wk4X/95AnCYs1gtoOcunar3esJ1Lu7NfNAHPOzKErHPpS2OMUFgsHMY
         4VSHA525OeEgwisSKsLyFKtjzk/Le0cFip7879FC5t0ZpcSrJAJBLMu7YRfDWc4fmtRC
         fkCM7RyPFq8tPvC2yUz0TE9ZTIwCds35V0xyrzfhFCgoIC0BeeLsTfG84In43ldbMwNP
         qJ2yDn+oGsBpbfbdxYuIQbI0zPplf54RMvshamhSHlmvUYTC+l3NTUccTGgpHVUeCVXR
         NzlPAdLMClm9dmlXpZ38Ugz03xDgQgm8CzIAJB5IJHBdsbajebSCJWTsxrPpQsaIOQGi
         RFmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wayLOd5wtu3dJzrv0vfB7W5+rCLS0oWQSMlaWOVxFrU=;
        b=HjtuDE6q1hXsvCpta/1XZa5liUM8w4IXMC/b2V40qQ/IRjYU8+Hn9SkLil0vc9o/Ll
         120A5epVtFR9MASQ/DqL7AbN/+PSJgqPlM1Dlaqu6mC7NxwhQHFbvGqv+qye42lJN9TN
         HsQVsPGPxDnz1muydcgy2xZAiFfNQ9KycptLRSPc3W2H2xkkLIg3M+AEoMC4eaV7Uw5P
         nfwKucyc5cD2CvWBqpleAMNSwWXjsYnyjBhnb9LWpWS573hW7++KaDco5fEAPc/hipzX
         EBXYKkndHvkdQgChTJ1JMyN03JFXKwMkE4DHHXDSefO69QfdroN++mq/pdhu0nTgbJD8
         cPsA==
X-Gm-Message-State: AOAM532+wfRMmDMn07LS4i27o/7WhOEdU2k9Yt0MiMpti3wy6SZlzf5M
        WO5/pBguoAiD1dJQWwbVGxo=
X-Google-Smtp-Source: ABdhPJwh5DAORO+Hs5SuilH9ywntGjERJdBR+uqwKGqP9zqVoeRz0x6jq2Mc8hJU/VUOR/uc01Q++w==
X-Received: by 2002:a63:4e65:: with SMTP id o37mr7196198pgl.202.1630057446618;
        Fri, 27 Aug 2021 02:44:06 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.92])
        by smtp.gmail.com with ESMTPSA id m2sm6619217pgu.15.2021.08.27.02.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 02:44:06 -0700 (PDT)
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
Subject: [PATCH] ipack: tpci200: change pci_iounmap to iounmap
Date:   Fri, 27 Aug 2021 17:43:47 +0800
Message-Id: <20210827094351.203328-1-mudongliangabcd@gmail.com>
X-Mailer: git-send-email 2.25.1
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
index cbfdadecb23b..bf2ae2be5eb5 100644
--- a/drivers/ipack/carriers/tpci200.c
+++ b/drivers/ipack/carriers/tpci200.c
@@ -88,7 +88,7 @@ static void tpci200_unregister(struct tpci200_board *tpci200)
 {
 	free_irq(tpci200->info->pdev->irq, (void *) tpci200);
 
-	pci_iounmap(tpci200->info->pdev, tpci200->info->interface_regs);
+	iounmap(tpci200->info->interface_regs);
 
 	pci_release_region(tpci200->info->pdev, TPCI200_IP_INTERFACE_BAR);
 	pci_release_region(tpci200->info->pdev, TPCI200_IO_ID_INT_SPACES_BAR);
@@ -347,7 +347,7 @@ static int tpci200_register(struct tpci200_board *tpci200)
 	return 0;
 
 err_interface_regs:
-	pci_iounmap(tpci200->info->pdev, tpci200->info->interface_regs);
+	iounmap(tpci200->info->interface_regs);
 err_mem16_space_bar:
 	pci_release_region(tpci200->info->pdev, TPCI200_MEM16_SPACE_BAR);
 err_mem8_space_bar:
@@ -596,7 +596,7 @@ static int tpci200_pci_probe(struct pci_dev *pdev,
 err_tpci200_install:
 	tpci200_uninstall(tpci200);
 err_cfg_regs:
-	pci_iounmap(tpci200->info->pdev, tpci200->info->cfg_regs);
+	iounmap(tpci200->info->cfg_regs);
 err_request_region:
 	pci_release_region(pdev, TPCI200_CFG_MEM_BAR);
 err_tpci200_info:
@@ -612,7 +612,7 @@ static void __tpci200_pci_remove(struct tpci200_board *tpci200)
 	ipack_bus_unregister(tpci200->info->ipack_bus);
 	tpci200_uninstall(tpci200);
 
-	pci_iounmap(tpci200->info->pdev, tpci200->info->cfg_regs);
+	iounmap(tpci200->info->cfg_regs);
 
 	pci_release_region(tpci200->info->pdev, TPCI200_CFG_MEM_BAR);
 
-- 
2.25.1

