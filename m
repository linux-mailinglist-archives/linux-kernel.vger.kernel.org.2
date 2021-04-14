Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1FA335ED08
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 08:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349134AbhDNGOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 02:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349109AbhDNGO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 02:14:29 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91833C061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 23:13:52 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id z1so22229513edb.8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 23:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2OU2KfPs5ZLY9/eANVVEMxuGk0nOH0alcTehz44zqd4=;
        b=Q34+3UVvVMeRO2pDc0ZhkM5C6ptR6G9eG5qsdyekgxQftdiVVd9V1+4urI+xWpCQ8A
         PQUKFFxiX+TBAT78SVeiB4ByyQsmxu6zuco2JbD8ltFg1sfaQ1Vk4/aaHgj316KJD5mh
         mh25SVYcMnveSSdl9la2RpzBmyosmp2an4lWmAmXZxlTvpdRkEf1HE+aa5qyXCUFTR0h
         1GqX3v57HXeeFnxM8cAkVpRsXigpbrx3zhznG6qmPeD/+g0oMXKq9qD5BP7qhRBX7zFv
         B3LuPWFrKPCOYunZPAj5KzunwgJMmVOiczPYbMXlS20dJ8K7MMCVhQBbq88yTGAboJqi
         W5vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2OU2KfPs5ZLY9/eANVVEMxuGk0nOH0alcTehz44zqd4=;
        b=VNZ08toxJawFv99doJFcm/cxEexzXSfFh8Kwq7h6iNf8u+MfFjBofidJJ5lCQuRkOe
         CnV3PSabOBoEesIl4/eRtv9Rlse7wkMzvB7cIYx4nHDvYNu0Nn7bi2YvZZ/3Ol70+xwC
         OVp1nq0BElTTgptURLYFZot3TN6PNbxrtn/Edg8pe5zdiuGRF5AyZZwhZN4BYWSHgRb2
         Z9zGm1JwCc9zL1jx+AMiaVEo+TT9WCp4DK9bfiJj6acWu5Rxjjn8FJwFIcgwTemSY6j5
         WUQP84Bo1ZwoKeGIzfOGJyJ3E0d98GjSlto2f12ClOj+YfzOBD8gnrnpDrHlqK0aZz6Y
         JBhg==
X-Gm-Message-State: AOAM531E1q6V/kZZXv0k8YECDo2y5PY69NAtCBCoFHDRFTgLtwksE3jO
        pz0oObHPfgRfvviVY0+iwFk=
X-Google-Smtp-Source: ABdhPJwwJG66A7j7zmHDI6pADLthTYyzZVxvACfPBEUHMVkq/XFP0e4jorqTX76bRg7iDMQ+0CbQ6Q==
X-Received: by 2002:aa7:cc15:: with SMTP id q21mr40158512edt.140.1618380831272;
        Tue, 13 Apr 2021 23:13:51 -0700 (PDT)
Received: from linux.local (host-95-237-55-30.retail.telecomitalia.it. [95.237.55.30])
        by smtp.gmail.com with ESMTPSA id w1sm11384312edt.89.2021.04.13.23.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 23:13:50 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     outreachy-kernel@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [Outreachy kernel] [PATCH v2] staging: rtl8723bs: hal: Remove four set but not used variables
Date:   Wed, 14 Apr 2021 08:13:46 +0200
Message-Id: <20210414061346.11423-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed four variables that were set but not used.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

Changes from v1: deleted one blank line.

 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 77f8353c5ce5..63f7f673aefb 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -3199,13 +3199,10 @@ static void hw_var_set_mlme_join(struct adapter *padapter, u8 variable, u8 *val)
 
 void CCX_FwC2HTxRpt_8723b(struct adapter *padapter, u8 *pdata, u8 len)
 {
-	u8 seq_no;
 
 #define	GET_8723B_C2H_TX_RPT_LIFE_TIME_OVER(_Header)	LE_BITS_TO_1BYTE((_Header + 0), 6, 1)
 #define	GET_8723B_C2H_TX_RPT_RETRY_OVER(_Header)	LE_BITS_TO_1BYTE((_Header + 0), 7, 1)
 
-	seq_no = *(pdata+6);
-
 	if (GET_8723B_C2H_TX_RPT_RETRY_OVER(pdata) | GET_8723B_C2H_TX_RPT_LIFE_TIME_OVER(pdata)) {
 		rtw_ack_tx_done(&padapter->xmitpriv, RTW_SCTX_DONE_CCX_PKT_FAIL);
 	}
@@ -3357,17 +3354,15 @@ void SetHwReg8723B(struct adapter *padapter, u8 variable, u8 *val)
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
@@ -3375,7 +3370,6 @@ void SetHwReg8723B(struct adapter *padapter, u8 variable, u8 *val)
 			if ((BrateCfg & (RRSR_24M|RRSR_12M|RRSR_6M)) == 0)
 				BrateCfg |= RRSR_6M;
 		}
-		ioted = BrateCfg;
 
 		pHalData->BasicRateSet = BrateCfg;
 
-- 
2.31.1

