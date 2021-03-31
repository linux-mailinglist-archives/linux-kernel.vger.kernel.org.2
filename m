Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5767634FD30
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 11:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234979AbhCaJlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 05:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234848AbhCaJko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 05:40:44 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37888C061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:40:44 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id b7so29096889ejv.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VVbef4RIKTJWs/6WO58+KVReeYM2u8NS17xKjC429X8=;
        b=KbjTqW1uP1ZQV/Bs03D0BorkP8raa7IAKlp1ApwRm2PB5SKLOOYaHMmX1Tt5/gDaly
         8Dcz0U5+gurKtzA5irq7If8hA3VeRZomUU9p99t3EYXmB61zhcvCbQUr9gsQnMmmWpr9
         KZgWxwyK8/N5OV0jwsfxldETDkVXY9imXXZBwTaL0btdCRY6K1chtuN0M3niioob/cE3
         wT9wbpHARcqOqKHL+nbR7nAu3fQNErgPYYVc4ynipdqsgXsMtoMoY65CUT8oOU5yWN8Y
         91CccZ6LGMVBzhfL+apcm6ETvm98yuEndWTPc+oRhV6BcRUBBg7d49ijIR/vTcrmqkvP
         xH0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VVbef4RIKTJWs/6WO58+KVReeYM2u8NS17xKjC429X8=;
        b=SD0TH75MSogYWpuZlej4TWaGqgZOAT5fEL4aX39vtldCl5/8hu49G1DwqoRXyGnVWT
         DR8LbYMA8ocHRH8qMyrb1+EeNnSMTcg25QLt5SUry12MpZrjBkd89BgIMskBiZhbp/P2
         DDUR9Ux1QOrOPj6+Zo3elzl6gVVbl3LleZjKwVWCtWfj++wsoUT/yC8cgIjCPEbI8o3Q
         NzV+oulQhVurGU5uRQJW5fxAa2sMET+/hlb++qWKFERLLURmXCOSuDGcBDyBy4TVYG7V
         dYWxuBfHpdbTiv5zqESghcXPONA/pwjRP73P755NrqwEd0OPT8+kRHjGik3H5PhGU38j
         CYqQ==
X-Gm-Message-State: AOAM532MXC+b7m+SDfkEX5sJfUppaX5VTaWomVy8Nld5N7rfgVvwnB+X
        ++3tgaUHiSlkHpXtDoC2Bq1iZjbCd+wB0g==
X-Google-Smtp-Source: ABdhPJxwqoEMgiUKDKpgH7tNKpChw6T+2OITkZ+tmEVRxmlXN2wZXA/kD92kfjaoDAk1NIdAnVX/Rg==
X-Received: by 2002:a17:906:aac5:: with SMTP id kt5mr2635890ejb.548.1617183642996;
        Wed, 31 Mar 2021 02:40:42 -0700 (PDT)
Received: from agape ([5.171.73.44])
        by smtp.gmail.com with ESMTPSA id z17sm851957eju.27.2021.03.31.02.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 02:40:42 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 16/40] staging: rtl8723bs: replace RT_TRACE with public printk wrappers in hal/HalPwrSeqCmd.c
Date:   Wed, 31 Mar 2021 11:39:44 +0200
Message-Id: <47073bd5ab9de71997aabd3a10c7a1a4aa268c47.1617183374.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617183374.git.fabioaiuto83@gmail.com>
References: <cover.1617183374.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

replace private macro RT_TRACE for tracing with in-kernel
pr_* printk wrappers

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/HalPwrSeqCmd.c | 61 +++++---------------
 1 file changed, 16 insertions(+), 45 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/HalPwrSeqCmd.c b/drivers/staging/rtl8723bs/hal/HalPwrSeqCmd.c
index 932b31fda6ad..9abe37bf318f 100644
--- a/drivers/staging/rtl8723bs/hal/HalPwrSeqCmd.c
+++ b/drivers/staging/rtl8723bs/hal/HalPwrSeqCmd.c
@@ -53,21 +53,16 @@ u8 HalPwrSeqCmdParsing(
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
+		pr_info("%s %s: offset(%#x) cut_msk(%#x) fab_msk(%#x) interface_msk(%#x) base(%#x) cmd(%#x) msk(%#x) value(%#x)\n",
+			DRIVER_PREFIX, __func__,
+			GET_PWR_CFG_OFFSET(PwrCfgCmd),
+			GET_PWR_CFG_CUT_MASK(PwrCfgCmd),
+			GET_PWR_CFG_FAB_MASK(PwrCfgCmd),
+			GET_PWR_CFG_INTF_MASK(PwrCfgCmd),
+			GET_PWR_CFG_BASE(PwrCfgCmd),
+			GET_PWR_CFG_CMD(PwrCfgCmd),
+			GET_PWR_CFG_MASK(PwrCfgCmd),
+			GET_PWR_CFG_VALUE(PwrCfgCmd));
 
 		/* 2 Only Handle the command whose FAB, CUT, and Interface are matched */
 		if (
@@ -77,19 +72,11 @@ u8 HalPwrSeqCmdParsing(
 		) {
 			switch (GET_PWR_CFG_CMD(PwrCfgCmd)) {
 			case PWR_CMD_READ:
-				RT_TRACE(
-					_module_hal_init_c_,
-					_drv_info_,
-					("HalPwrSeqCmdParsing: PWR_CMD_READ\n")
-				);
+				pr_info("%s %s: PWR_CMD_READ\n", DRIVER_PREFIX, __func__);
 				break;
 
 			case PWR_CMD_WRITE:
-				RT_TRACE(
-					_module_hal_init_c_,
-					_drv_info_,
-					("HalPwrSeqCmdParsing: PWR_CMD_WRITE\n")
-				);
+				pr_info("%s %s: PWR_CMD_WRITE\n", DRIVER_PREFIX, __func__);
 				offset = GET_PWR_CFG_OFFSET(PwrCfgCmd);
 
 				/*  */
@@ -124,11 +111,7 @@ u8 HalPwrSeqCmdParsing(
 				break;
 
 			case PWR_CMD_POLLING:
-				RT_TRACE(
-					_module_hal_init_c_,
-					_drv_info_,
-					("HalPwrSeqCmdParsing: PWR_CMD_POLLING\n")
-				);
+				pr_info("%s %s: PWR_CMD_POLLING\n", DRIVER_PREFIX, __func__);
 
 				bPollingBit = false;
 				offset = GET_PWR_CFG_OFFSET(PwrCfgCmd);
@@ -160,11 +143,7 @@ u8 HalPwrSeqCmdParsing(
 				break;
 
 			case PWR_CMD_DELAY:
-				RT_TRACE(
-					_module_hal_init_c_,
-					_drv_info_,
-					("HalPwrSeqCmdParsing: PWR_CMD_DELAY\n")
-				);
+				pr_info("%s %s: PWR_CMD_DELAY\n", DRIVER_PREFIX, __func__);
 				if (GET_PWR_CFG_VALUE(PwrCfgCmd) == PWRSEQ_DELAY_US)
 					udelay(GET_PWR_CFG_OFFSET(PwrCfgCmd));
 				else
@@ -173,19 +152,11 @@ u8 HalPwrSeqCmdParsing(
 
 			case PWR_CMD_END:
 				/*  When this command is parsed, end the process */
-				RT_TRACE(
-					_module_hal_init_c_,
-					_drv_info_,
-					("HalPwrSeqCmdParsing: PWR_CMD_END\n")
-				);
+				pr_info("%s %s: PWR_CMD_END\n", DRIVER_PREFIX, __func__);
 				return true;
 
 			default:
-				RT_TRACE(
-					_module_hal_init_c_,
-					_drv_err_,
-					("HalPwrSeqCmdParsing: Unknown CMD!!\n")
-				);
+				pr_err("%s %s: Unknown CMD!!\n", DRIVER_PREFIX, __func__);
 				break;
 			}
 		}
-- 
2.20.1

