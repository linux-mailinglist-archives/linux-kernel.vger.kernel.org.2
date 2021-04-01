Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE93351214
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234350AbhDAJXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233880AbhDAJWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:22:11 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0518C0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 02:22:05 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id x21so1161231eds.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 02:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6naPNcvu5QVkT6Y8CwxzupUotzs3n7U/uiWqq+f+W48=;
        b=NTMukDVNjGnPUhtHu61ZP4v0o1SzsA3fJWbJwIu1+HXdYwRakPlneVuirjWPWZZOBk
         XRmmF6AhRjWyyH1kZRrrF4S+6ux57eGVnVL0vgSAsqWd9aeFRRKpuP3EmmPdVkXrcB3a
         0Y20EMDAJw6WnmUnpbUG09FAYGCr3Y2UyeTwtFMvCWTJxgLDop48enn130p8jRY6K03P
         CFG94+qFkeAB7gD+6PhpuzWuR17wt5NBJPYrWHFWhL4KoHTQ2Vm8rvGexu2VmwOop7eM
         3TL8ESpCa3HhU3AogIze9l4p6GJDg36IrbDj5zvlV8/TLZ3028lyVr4AL2bDYaqJMIa1
         xpPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6naPNcvu5QVkT6Y8CwxzupUotzs3n7U/uiWqq+f+W48=;
        b=Kl8oje7UGwyydRlgnZZo4CoI1nHya/bM1JEC2XLCV1NNxxcv+Pnod2UpAWpg4RaIno
         snaHrUxZYa9TR1FaUTxab/Xb01gba0DlKNNWrONmR5eDUbe4nTfJScwDHoykU6uf5/HB
         pmdARbi5HtAHdXN0jKEK33SJ0vu9dvsmBcgYESI+2VKjQhrNpkln5dOneiodc9gYCvMk
         m1mFjyyaVFwKUsfpZ2XVUUaMhTl/qvOSLF0BZ1Rk/Kjb4fSjoBOYCDRjHyxiKfV0rifr
         hJdNL5LLsrAGaxXHC/ze3+dlEgeX1KGCqwOu67op32nhFgApOvv7IwYnNrWgS3Rk58Gn
         725w==
X-Gm-Message-State: AOAM530BRCWt4pUV8Sj25K74evA/0Jltb4lr6Ibzu45PH4UzS06Sd3hS
        oOmGPHUjrfQZRbhWWBwOOiY=
X-Google-Smtp-Source: ABdhPJwm8JtI2s0tVmOeqGnF3qnKis00RB9lXbmu74k+/g3br7urylvOSFdEI1Ie/dI6cAV1Br3aFg==
X-Received: by 2002:a05:6402:614:: with SMTP id n20mr8616571edv.58.1617268924645;
        Thu, 01 Apr 2021 02:22:04 -0700 (PDT)
Received: from agape ([5.171.80.247])
        by smtp.gmail.com with ESMTPSA id k26sm2473876ejx.81.2021.04.01.02.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 02:22:04 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, dan.carpenter@oracle.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 25/49] staging: rtl8723bs: remove RT_TRACE logs in hal/HalPwrSeqCmd.c
Date:   Thu,  1 Apr 2021 11:20:55 +0200
Message-Id: <cc4469f689d4e123945c51191cbabff93f456560.1617268327.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617268327.git.fabioaiuto83@gmail.com>
References: <cover.1617268327.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove all RT_TRACE logs

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/HalPwrSeqCmd.c | 47 --------------------
 1 file changed, 47 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/HalPwrSeqCmd.c b/drivers/staging/rtl8723bs/hal/HalPwrSeqCmd.c
index 932b31fda6ad..4b54c6ac8cc2 100644
--- a/drivers/staging/rtl8723bs/hal/HalPwrSeqCmd.c
+++ b/drivers/staging/rtl8723bs/hal/HalPwrSeqCmd.c
@@ -53,22 +53,6 @@ u8 HalPwrSeqCmdParsing(
 	do {
 		PwrCfgCmd = PwrSeqCmd[AryIdx];
 
-		RT_TRACE(
-			_module_hal_init_c_,
-			_drv_info_,
-			(
-				"HalPwrSeqCmdParsing: offset(%#x) cut_msk(%#x) fab_msk(%#x) interface_msk(%#x) base(%#x) cmd(%#x) msk(%#x) value(%#x)\n",
-				GET_PWR_CFG_OFFSET(PwrCfgCmd),
-				GET_PWR_CFG_CUT_MASK(PwrCfgCmd),
-				GET_PWR_CFG_FAB_MASK(PwrCfgCmd),
-				GET_PWR_CFG_INTF_MASK(PwrCfgCmd),
-				GET_PWR_CFG_BASE(PwrCfgCmd),
-				GET_PWR_CFG_CMD(PwrCfgCmd),
-				GET_PWR_CFG_MASK(PwrCfgCmd),
-				GET_PWR_CFG_VALUE(PwrCfgCmd)
-			)
-		);
-
 		/* 2 Only Handle the command whose FAB, CUT, and Interface are matched */
 		if (
 			(GET_PWR_CFG_FAB_MASK(PwrCfgCmd) & FabVersion) &&
@@ -77,19 +61,9 @@ u8 HalPwrSeqCmdParsing(
 		) {
 			switch (GET_PWR_CFG_CMD(PwrCfgCmd)) {
 			case PWR_CMD_READ:
-				RT_TRACE(
-					_module_hal_init_c_,
-					_drv_info_,
-					("HalPwrSeqCmdParsing: PWR_CMD_READ\n")
-				);
 				break;
 
 			case PWR_CMD_WRITE:
-				RT_TRACE(
-					_module_hal_init_c_,
-					_drv_info_,
-					("HalPwrSeqCmdParsing: PWR_CMD_WRITE\n")
-				);
 				offset = GET_PWR_CFG_OFFSET(PwrCfgCmd);
 
 				/*  */
@@ -124,12 +98,6 @@ u8 HalPwrSeqCmdParsing(
 				break;
 
 			case PWR_CMD_POLLING:
-				RT_TRACE(
-					_module_hal_init_c_,
-					_drv_info_,
-					("HalPwrSeqCmdParsing: PWR_CMD_POLLING\n")
-				);
-
 				bPollingBit = false;
 				offset = GET_PWR_CFG_OFFSET(PwrCfgCmd);
 				do {
@@ -160,11 +128,6 @@ u8 HalPwrSeqCmdParsing(
 				break;
 
 			case PWR_CMD_DELAY:
-				RT_TRACE(
-					_module_hal_init_c_,
-					_drv_info_,
-					("HalPwrSeqCmdParsing: PWR_CMD_DELAY\n")
-				);
 				if (GET_PWR_CFG_VALUE(PwrCfgCmd) == PWRSEQ_DELAY_US)
 					udelay(GET_PWR_CFG_OFFSET(PwrCfgCmd));
 				else
@@ -173,19 +136,9 @@ u8 HalPwrSeqCmdParsing(
 
 			case PWR_CMD_END:
 				/*  When this command is parsed, end the process */
-				RT_TRACE(
-					_module_hal_init_c_,
-					_drv_info_,
-					("HalPwrSeqCmdParsing: PWR_CMD_END\n")
-				);
 				return true;
 
 			default:
-				RT_TRACE(
-					_module_hal_init_c_,
-					_drv_err_,
-					("HalPwrSeqCmdParsing: Unknown CMD!!\n")
-				);
 				break;
 			}
 		}
-- 
2.20.1

