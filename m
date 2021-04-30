Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0ED836FCD7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 16:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233734AbhD3Or2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233792AbhD3Oqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:46:32 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D997C061344
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:45:18 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id y7so6763247ejj.9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O0vgVpcNkS4mAjfiGNcrsQkfchPH8sG7BBuJp5aFS/s=;
        b=VL9d4OW7Ec+AxC0j591mngRP1Zhir8y5RQ525/Z4ws7TQXKjxQ8YnsXynR1SEXHpQ6
         y74dcPFpsgUfGPmE3iB+vixdmSiDUyYOuirHC+xyomuVF+P2BktwX8Ll+nrtuJpamfq1
         g2Tt7OBuBxzRck3Jv8c8eHUX1IzVP+JyfKQvgmEBqwkZ9UO1T3qnXsWmMiNXXu14EZIV
         RXHG41erkWG5QGqxGRaieYvkk1OTe9yX21UzovDaWKAEvbSbMyFXgy3+HJBXka47vwAa
         +PdowRtbtIiPMAa0q4K3on4LHOkR8SUtfoVdj783WqfdhsFOcXMS41Sjqw/ORXVAH49p
         kggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O0vgVpcNkS4mAjfiGNcrsQkfchPH8sG7BBuJp5aFS/s=;
        b=TKreHXbzeuxzi0GtVx+lmupeIN70Kla4eOh6YEjbkmkPWwSuo+gl9/wlTQlfbLJNxg
         HeSVrF+bX08NWeL0Z9LJrtPBB2iF01+H3ISmSjSxWwUlWGwaepOMxgdUKuPrnsqVmf4J
         pDZNDyj/OaBKcIQopnWUHtZfcIUVLWeXwm5r3rgVa0g5Hl9TL4h0B5MULteTWsAo5jBC
         eTW61ojk0ZqWG/w3q3Lwb8odeS3J+7KhvYegZQHkzFWWm/JXSgIoygRTjcqSfChEL9Ei
         WNb32oGWNQgORQRIT6W8rizqyN47qwx5Awnodn5M5SlYaWofDHJOwvoHIdFBRe0ggVAE
         UWBA==
X-Gm-Message-State: AOAM533TPCWh992G2bT83ScN9wAUwwetY8Xys/BvUAKOboTe+fKi6BX3
        vzSfCM8CZqHbmAiTaSutwJ1vQNBOBNE=
X-Google-Smtp-Source: ABdhPJy4dPXkx8/vy3AQ1bgikAlV9uZU1ChSgjFpuMoWiUBvHa5hJc0rO/68AU1Z4WBlLFHZVSAUMA==
X-Received: by 2002:a17:906:f283:: with SMTP id gu3mr4711371ejb.91.1619793916980;
        Fri, 30 Apr 2021 07:45:16 -0700 (PDT)
Received: from agape ([109.52.244.36])
        by smtp.gmail.com with ESMTPSA id bm13sm2091592ejb.75.2021.04.30.07.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:45:16 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 42/43] staging: rtl8723bs: remove DebugLevel member in dm_odm_t struct
Date:   Fri, 30 Apr 2021 16:44:12 +0200
Message-Id: <dd309268a37747559728335a4b4ce8108e538030.1619793406.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619793405.git.fabioaiuto83@gmail.com>
References: <cover.1619793405.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove DebugLevel in dm_odm_t struct,
remove private debug level tracing.

remove unused variable as well to suppress compiler warning.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_com.c | 4 ----
 drivers/staging/rtl8723bs/hal/odm.c     | 3 ---
 drivers/staging/rtl8723bs/hal/odm.h     | 2 --
 3 files changed, 9 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_com.c b/drivers/staging/rtl8723bs/hal/hal_com.c
index 8d1a18b5f914..5eb3bd45a959 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com.c
@@ -1159,7 +1159,6 @@ u8 GetHalDefVar(
 )
 {
 	struct hal_com_data *hal_data = GET_HAL_DATA(adapter);
-	struct dm_odm_t *odm = &(hal_data->odmpriv);
 	u8 bResult = _SUCCESS;
 
 	switch (variable) {
@@ -1176,9 +1175,6 @@ u8 GetHalDefVar(
 				*((int *)value) = psta->rssi_stat.UndecoratedSmoothedPWDB;
 		}
 		break;
-	case HW_DEF_ODM_DBG_LEVEL:
-		*((u32 *)value) = odm->DebugLevel;
-		break;
 	case HAL_DEF_DBG_DM_FUNC:
 		*((u32 *)value) = hal_data->odmpriv.SupportAbility;
 		break;
diff --git a/drivers/staging/rtl8723bs/hal/odm.c b/drivers/staging/rtl8723bs/hal/odm.c
index b867629a577b..fa275138c983 100644
--- a/drivers/staging/rtl8723bs/hal/odm.c
+++ b/drivers/staging/rtl8723bs/hal/odm.c
@@ -1172,9 +1172,6 @@ void ODM_CmnInfoUpdate(struct dm_odm_t *pDM_Odm, u32 CmnInfo, u64 Value)
 		pDM_Odm->RSSI_Min = (u8)Value;
 		break;
 
-	case ODM_CMNINFO_DBG_LEVEL:
-		pDM_Odm->DebugLevel = (u32)Value;
-		break;
 	case ODM_CMNINFO_RA_THRESHOLD_HIGH:
 		pDM_Odm->RateAdaptive.HighRSSIThresh = (u8)Value;
 		break;
diff --git a/drivers/staging/rtl8723bs/hal/odm.h b/drivers/staging/rtl8723bs/hal/odm.h
index 6b9865f5f283..950e7850bac2 100644
--- a/drivers/staging/rtl8723bs/hal/odm.h
+++ b/drivers/staging/rtl8723bs/hal/odm.h
@@ -709,8 +709,6 @@ struct dm_odm_t { /* DM_Out_Source_Dynamic_Mechanism_Structure */
 	enum phy_reg_pg_type PhyRegPgValueType;
 	u8 PhyRegPgVersion;
 
-	u32 DebugLevel;
-
 	u32 NumQryPhyStatusAll;	/* CCK + OFDM */
 	u32 LastNumQryPhyStatusAll;
 	u32 RxPWDBAve;
-- 
2.20.1

