Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5185935E69B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 20:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbhDMSm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 14:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhDMSms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 14:42:48 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6E9C061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 11:42:28 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id sd23so18907546ejb.12
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 11:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=onqd5io8gO8TF2jNxNjVt3EUovwErpIeRRu6nXL6B/A=;
        b=Mhxg0jTNUUWW03BOheyo6id20xNDkcrvWCMKt2165RjRwTyHtQp6TIkWXBk8zsflT5
         1XBreAGHlLjubA6lUe3j5DD178ipOCTyVm9G2ZUEJS7sj0OvMG13oAJiVyjq1v1msG10
         AWJP1ztgBcnq59m1OU1UErs+VaipKPyOOYfOkWUysiO1R3CTO8wGJo3MHe/IlN0yZeMP
         x6lswigNafMCbF5QTg+Q6Tpe8ruS0BoUSfgkn4P8XLKMGK+BJk4jOK/8CRaT/XgKVU4W
         0VOvqR+xGIKG3g+a0ySDQDDNrZHI5PQEQBRMm3GM9VUV6zV6xTmFawDcAh+afTM0PjjH
         mtvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=onqd5io8gO8TF2jNxNjVt3EUovwErpIeRRu6nXL6B/A=;
        b=EbjEeunbzc3wqqH+ABgj9g735MNqSj2PiRZViJ87OSed0AW2cHNUiQLHPDJtvJRLmg
         sqH5Xm+o39YyRiosx1U3tOSAW+orzVwkPGFSfyUeKvq6PJwlJ6JKGj9GFyduZMNXkesj
         e3mPd8mTpf8A9+MtWG852qDD4MWYlJ1rmqBqkZLTjGaXUkjFiCPfQV/ntJhrvlMEOX8p
         xSmNqwW4G0li3Wt5QUxBtSP18JWQR3qkXPS2cD52gL7PBiXYlWAZSnzxDaUXttrgtrpH
         TyVVI0d0jXUQvs7adETo8RzAkKscOGSB2EV4Qw67TpqF6QiBTeq5spdS2tQQWYsoL1zk
         iZYw==
X-Gm-Message-State: AOAM532b27zc9crdkdQgyA/RkuJ0TGvZ8Gmcc8Y7mqmTR4kcHtOZxAdp
        pDOPXQ32hhHERQIAsm8yP3o=
X-Google-Smtp-Source: ABdhPJxOvKDGycPU7RpUJ6yUTmQVz7G609IgKGxIH4ynRWjTNTnGNN2Iz5LPZRsPejRQWyJ5xF1akg==
X-Received: by 2002:a17:906:3f88:: with SMTP id b8mr34519778ejj.36.1618339347135;
        Tue, 13 Apr 2021 11:42:27 -0700 (PDT)
Received: from linux.local (host-95-237-55-30.retail.telecomitalia.it. [95.237.55.30])
        by smtp.gmail.com with ESMTPSA id d15sm8339776ejj.42.2021.04.13.11.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 11:42:26 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     outreachy-kernel@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [Outreachy kernel] [PATCH] staging: rtl8723bs: hal: Remove four set but not used variables
Date:   Tue, 13 Apr 2021 20:42:22 +0200
Message-Id: <20210413184222.19539-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed four variables that were set but not used.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 77f8353c5ce5..fad6a3bfe07c 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -3199,12 +3199,10 @@ static void hw_var_set_mlme_join(struct adapter *padapter, u8 variable, u8 *val)
 
 void CCX_FwC2HTxRpt_8723b(struct adapter *padapter, u8 *pdata, u8 len)
 {
-	u8 seq_no;
 
 #define	GET_8723B_C2H_TX_RPT_LIFE_TIME_OVER(_Header)	LE_BITS_TO_1BYTE((_Header + 0), 6, 1)
 #define	GET_8723B_C2H_TX_RPT_RETRY_OVER(_Header)	LE_BITS_TO_1BYTE((_Header + 0), 7, 1)
 
-	seq_no = *(pdata+6);
 
 	if (GET_8723B_C2H_TX_RPT_RETRY_OVER(pdata) | GET_8723B_C2H_TX_RPT_LIFE_TIME_OVER(pdata)) {
 		rtw_ack_tx_done(&padapter->xmitpriv, RTW_SCTX_DONE_CCX_PKT_FAIL);
@@ -3357,17 +3355,15 @@ void SetHwReg8723B(struct adapter *padapter, u8 variable, u8 *val)
 	case HW_VAR_BASIC_RATE:
 	{
 		struct mlme_ext_info *mlmext_info = &padapter->mlmeextpriv.mlmext_info;
-		u16 input_b = 0, masked = 0, ioted = 0, BrateCfg = 0;
+		u16 BrateCfg = 0;
 		u16 rrsr_2g_force_mask = (RRSR_11M|RRSR_5_5M|RRSR_1M);
 		u16 rrsr_2g_allow_mask = (RRSR_24M|RRSR_12M|RRSR_6M|RRSR_CCK_RATES);
 
 		HalSetBrateCfg(padapter, val, &BrateCfg);
-		input_b = BrateCfg;
 
 		/* apply force and allow mask */
 		BrateCfg |= rrsr_2g_force_mask;
 		BrateCfg &= rrsr_2g_allow_mask;
-		masked = BrateCfg;
 
 		/* IOT consideration */
 		if (mlmext_info->assoc_AP_vendor == HT_IOT_PEER_CISCO) {
@@ -3375,7 +3371,6 @@ void SetHwReg8723B(struct adapter *padapter, u8 variable, u8 *val)
 			if ((BrateCfg & (RRSR_24M|RRSR_12M|RRSR_6M)) == 0)
 				BrateCfg |= RRSR_6M;
 		}
-		ioted = BrateCfg;
 
 		pHalData->BasicRateSet = BrateCfg;
 
-- 
2.31.1

