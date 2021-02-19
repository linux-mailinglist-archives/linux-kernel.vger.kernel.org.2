Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 635DB31F73B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 11:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhBSKTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 05:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbhBSKS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 05:18:58 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C05EC061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 02:18:17 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id o24so7012103wmh.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 02:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xbN851RonAVLbAx/p1XGSAbi2fYwb/WrJuyOCajm1sU=;
        b=p5qd9GZIhN2zPT0F9JdpiWY1xZ7V9Ea/Fd7hG1x1nmz3iwZ/wIZqRHPybhRRp0CGlA
         1oy14c+QJktkyIJlwtiKrkxukvRh8+yYvCK+NK/R69IwFuRw6ue23mv6oB7y2Di8VQ93
         +Fx6/ODtHR2zo50X5MRC6hQcXBxuRj8edOVAju+wmCQOaT5xUG7qBotAJzhR4mzF9OAR
         sgKluyuSXjOJsviml0bt8/bvYLcbzVe2sjQH5+VSaykHSATRWFQREly2uMxainQytuuj
         7QslS/9xeqtE7F23k5EmR+Nf0BphXH8HuWBO9ENhU1gEBk11mG2E+s4W0m0o1I4g/MxE
         I7HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xbN851RonAVLbAx/p1XGSAbi2fYwb/WrJuyOCajm1sU=;
        b=iS4AsXf+SVkRDJWiZT94VTo9GwpfftX1/Frgfh6+dG2xf6POga5bdMomTTz0lmepHQ
         1mFTmPPtp6o6Wxdcohv8fPG0IMtR1YT84fH0NHipI+GD9w9sYZyZzySwNBkEFJyMfdDH
         3tVDFq0mn5MIsXEGdpuj8nDnIDOxgNlzWgEzACL1/vJoGWvApGr7YobYmSTBNNPLnUJ5
         gEqtvGHK1q53rjFiYigSPkynVX9U5n9cGYsl5R7OTQsP3PJkfZTEfTRzck/gbquW9LgO
         RdZBqBhfq33Mt9+toyhE5ipjzapprwcJxa45pk52zhZ+SuTUEQEODr40kjsUhuLLUcak
         ULjA==
X-Gm-Message-State: AOAM5334zNZXEWyjxjIgedcXcRZCWMVDBeHhcOjT94fB7u/0i23AyXRq
        1piF1l0uqBe/CZZXqDzPA0U=
X-Google-Smtp-Source: ABdhPJw2XcoICr+A/+sSsYk6LBdKzw2bJJuuszozjsTFN15TKBsWcrqsfynXuySCT6XuG6osBakV5w==
X-Received: by 2002:a1c:730a:: with SMTP id d10mr7344060wmb.53.1613729896294;
        Fri, 19 Feb 2021 02:18:16 -0800 (PST)
Received: from alaa ([197.57.169.127])
        by smtp.gmail.com with ESMTPSA id y62sm13661208wmy.9.2021.02.19.02.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 02:18:15 -0800 (PST)
From:   Alaa Emad <alaaemadhossney.ae@gmail.com>
To:     mchehab+huawei@kernel.org, gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Alaa Emad <alaaemadhossney.ae@gmail.com>
Subject: [PATCH] staging: hikey9xx: fix warning styling issues
Date:   Fri, 19 Feb 2021 12:18:12 +0200
Message-Id: <20210219101812.3483-1-alaaemadhossney.ae@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix "WARNING: please, no space before tabs" styling issue in
hi6421-spmi-pmic.c for lines 51,52,53 and 69.

Signed-off-by: Alaa Emad <alaaemadhossney.ae@gmail.com>
---
 drivers/staging/hikey9xx/hi6421-spmi-pmic.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
index 4ebcfea9f3bf..626140cb96f2 100644
--- a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
+++ b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
@@ -48,9 +48,9 @@ enum hi6421_spmi_pmic_irq_list {
 /*
  * The IRQs are mapped as:
  *
- * 	======================  =============   ============	=====
- *	IRQ			MASK REGISTER 	IRQ REGISTER	BIT
- * 	======================  =============   ============	=====
+ *	======================  =============   ============	=====
+ *	IRQ			MASK REGISTER	IRQ REGISTER	BIT
+ *	======================  =============   ============	=====
  *	OTMP			0x0202		0x212		bit 0
  *	VBUS_CONNECT		0x0202		0x212		bit 1
  *	VBUS_DISCONNECT		0x0202		0x212		bit 2
@@ -66,7 +66,7 @@ enum hi6421_spmi_pmic_irq_list {
  *	SIM0_HPD_F		0x0203		0x213		bit 3
  *	SIM1_HPD_R		0x0203		0x213		bit 4
  *	SIM1_HPD_F		0x0203		0x213		bit 5
- * 	======================  =============   ============	=====
+ *	======================  =============   ============	=====
  */
 #define SOC_PMIC_IRQ_MASK_0_ADDR	0x0202
 #define SOC_PMIC_IRQ0_ADDR		0x0212
-- 
2.25.1

