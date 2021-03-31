Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFDE34FD40
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 11:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235022AbhCaJls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 05:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234819AbhCaJk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 05:40:57 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4AEC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:40:57 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id o19so21531332edc.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1qPVs0bYVxCxR2wysk604dzz6mqKNkseUVOBA1IKBLI=;
        b=P9bMVX2AirHfF52VCFczou7wj5jHDqehADOyldoHp0aLPw+s/FaYkJIMKwHK/Qgao1
         O41bRs+CLhqg15Boee2MsW+9Mfo+k0K6YiBEAu02z8tI3d3rMO2Wlp4ujuU0m6Gl9Pd7
         keApeIc3rAEhZaf+MEGCoKjNUA5OoP/wl3djugbLWxGauYGpP8lLMGQMnVV0dB61qyhx
         Ji/8qInAEJAhvR2eesROEI8GuanRCSdRW+tZvCdpOM78On83yCCl4CJPLt3ADPMepj1I
         q4AYv4fkFvDZZyih4Bctnb6I03dYnwssytkP8OXuFzyh54ffe2hWnVNXARa+i/YZYac2
         3fIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1qPVs0bYVxCxR2wysk604dzz6mqKNkseUVOBA1IKBLI=;
        b=f9YKkPVnFx4EVV+Nt/Vn6ZDAWaI7QSdCnJEUkzjSDFGJu9AohsLsSxatc+SZbUuGKh
         5JER3K0RjBVIErIft9DLG4S3zSdpOf0qD/DV0uhB2eXUamxIuLWzJhnwfIvHw29LR4E/
         mW/IPr+vUKzT2QApZi0EOWT/2pjlqycaN1eUJcdaKAIvkP1QgqyFEU9zkM7XsNuxG74A
         wxZalAL5g4SfDp2cYn0wZ+E4+DmdE8xF7AQQKQ/Cs2hzraR/AFjW9t9yU6wrvONNxjDa
         hdpCvvSltDW2qqkTYjKuyyVCRVCkwDn2rZ5D8l6kr5Esfk+KgtfBhWddvjVlrLyMddqB
         ijtw==
X-Gm-Message-State: AOAM532ys8ZOrOTyYE9a1DGoZZTa33PTPBXwNl0ZzjgniFfg53jkAVtj
        Yj1AIcI5F6cs9su9BdVFYoE=
X-Google-Smtp-Source: ABdhPJy03OWjcphV3Cf/FAt7S8MDSEhuUF1WYHleWBYlKCXWKu42ZWgezSsT72KB4KynRffTpjy/Yw==
X-Received: by 2002:aa7:db53:: with SMTP id n19mr2641911edt.330.1617183656081;
        Wed, 31 Mar 2021 02:40:56 -0700 (PDT)
Received: from agape ([5.171.73.44])
        by smtp.gmail.com with ESMTPSA id cf4sm1114510edb.19.2021.03.31.02.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 02:40:55 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 23/40] staging: rtl8723bs: replace RT_TRACE with public printk wrappers in hal/rtl8723b_phycfg.c
Date:   Wed, 31 Mar 2021 11:39:51 +0200
Message-Id: <2f7810b574e66949890cbfea9c99042daec9f044.1617183374.git.fabioaiuto83@gmail.com>
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
 .../staging/rtl8723bs/hal/rtl8723b_phycfg.c   | 48 +++++++++----------
 1 file changed, 22 insertions(+), 26 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c b/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
index 2abff4673be2..59a659b76995 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
@@ -551,7 +551,7 @@ void PHY_SetTxPowerIndex(
 			break;
 		}
 	} else {
-		RT_TRACE(_module_hal_init_c_, _drv_err_, ("Invalid RFPath!!\n"));
+		pr_err("%s Invalid RFPath!!\n", DRIVER_PREFIX);
 	}
 }
 
@@ -604,11 +604,11 @@ void PHY_SetTxPowerLevel8723B(struct adapter *Adapter, u8 Channel)
 		RFPath = pHalData->ant_path;
 	}
 
-	RT_TRACE(_module_hal_init_c_, _drv_info_, ("==>PHY_SetTxPowerLevel8723B()\n"));
+	pr_info("%s ==> %s\n", DRIVER_PREFIX, __func__);
 
 	PHY_SetTxPowerLevelByPath(Adapter, Channel, RFPath);
 
-	RT_TRACE(_module_hal_init_c_, _drv_info_, ("<==PHY_SetTxPowerLevel8723B()\n"));
+	pr_info("%s <== %s\n", DRIVER_PREFIX, __func__);
 }
 
 void PHY_GetTxPowerLevel8723B(struct adapter *Adapter, s32 *powerlevel)
@@ -648,23 +648,20 @@ static u8 phy_GetSecondaryChnl_8723B(struct adapter *Adapter)
 	u8 SCSettingOf40 = 0, SCSettingOf20 = 0;
 	struct hal_com_data *pHalData = GET_HAL_DATA(Adapter);
 
-	RT_TRACE(
-		_module_hal_init_c_,
-		_drv_info_,
-		(
-			"SCMapping: VHT Case: pHalData->CurrentChannelBW %d, pHalData->nCur80MhzPrimeSC %d, pHalData->nCur40MhzPrimeSC %d\n",
-			pHalData->CurrentChannelBW,
-			pHalData->nCur80MhzPrimeSC,
-			pHalData->nCur40MhzPrimeSC
-		)
-	);
+	pr_info("%s SCMapping: VHT Case: pHalData->CurrentChannelBW %d, "
+		"pHalData->nCur80MhzPrimeSC %d, pHalData->nCur40MhzPrimeSC %d\n",
+		DRIVER_PREFIX,
+		pHalData->CurrentChannelBW,
+		pHalData->nCur80MhzPrimeSC,
+		pHalData->nCur40MhzPrimeSC);
+
 	if (pHalData->CurrentChannelBW == CHANNEL_WIDTH_80) {
 		if (pHalData->nCur80MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_LOWER)
 			SCSettingOf40 = VHT_DATA_SC_40_LOWER_OF_80MHZ;
 		else if (pHalData->nCur80MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_UPPER)
 			SCSettingOf40 = VHT_DATA_SC_40_UPPER_OF_80MHZ;
 		else
-			RT_TRACE(_module_hal_init_c_, _drv_err_, ("SCMapping: Not Correct Primary40MHz Setting\n"));
+			pr_err("%s SCMapping: Not Correct Primary40MHz Setting\n", DRIVER_PREFIX);
 
 		if (
 			(pHalData->nCur40MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_LOWER) &&
@@ -687,27 +684,26 @@ static u8 phy_GetSecondaryChnl_8723B(struct adapter *Adapter)
 		)
 			SCSettingOf20 = VHT_DATA_SC_20_UPPERST_OF_80MHZ;
 		else
-			RT_TRACE(_module_hal_init_c_, _drv_err_, ("SCMapping: Not Correct Primary40MHz Setting\n"));
+			pr_err("%s SCMapping: Not Correct Primary40MHz Setting\n",
+			       DRIVER_PREFIX);
 	} else if (pHalData->CurrentChannelBW == CHANNEL_WIDTH_40) {
-		RT_TRACE(
-			_module_hal_init_c_,
-			_drv_info_,
-			(
-				"SCMapping: VHT Case: pHalData->CurrentChannelBW %d, pHalData->nCur40MhzPrimeSC %d\n",
-				pHalData->CurrentChannelBW,
-				pHalData->nCur40MhzPrimeSC
-			)
-		);
+		pr_info("%s SCMapping: VHT Case: pHalData->CurrentChannelBW %d, "
+			"pHalData->nCur40MhzPrimeSC %d\n",
+			DRIVER_PREFIX, pHalData->CurrentChannelBW,
+			pHalData->nCur40MhzPrimeSC);
 
 		if (pHalData->nCur40MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_UPPER)
 			SCSettingOf20 = VHT_DATA_SC_20_UPPER_OF_80MHZ;
 		else if (pHalData->nCur40MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_LOWER)
 			SCSettingOf20 = VHT_DATA_SC_20_LOWER_OF_80MHZ;
 		else
-			RT_TRACE(_module_hal_init_c_, _drv_err_, ("SCMapping: Not Correct Primary40MHz Setting\n"));
+			pr_err("%s SCMapping: Not Correct Primary40MHz Setting\n",
+			       DRIVER_PREFIX);
 	}
 
-	RT_TRACE(_module_hal_init_c_, _drv_info_, ("SCMapping: SC Value %x\n", ((SCSettingOf40 << 4) | SCSettingOf20)));
+	pr_info("%s SCMapping: SC Value %x\n",
+		DRIVER_PREFIX, ((SCSettingOf40 << 4) | SCSettingOf20));
+
 	return  (SCSettingOf40 << 4) | SCSettingOf20;
 }
 
-- 
2.20.1

