Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7CEF36F6AB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 09:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbhD3Hr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 03:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbhD3HqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 03:46:07 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BBF1C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:45:17 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id n25so9413079edr.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O0vgVpcNkS4mAjfiGNcrsQkfchPH8sG7BBuJp5aFS/s=;
        b=BC6vKBS+h6XM3Y5viRelBP+RHX23Q57MTTWaYERsDlSpnfF6w7iB924a8n0ew+Q2tH
         nGqk6R6eU4PcyxnhJ5FHVpKZA+MKYIUHo2g1BSRciP0vH+neJyd0xqdqLRq+hhn2O0TB
         TjX9DgeOI2JZDvW6zR1/njRj4nWMGw9aJ/uNijOqZqIWu6yzFIuzIUgjxCUhbBEbsp2E
         c0leGZj8V0TwC1Zn0W9PJanQNBiaNMvbdHILzW3tt7mkIXvxxwA2PAJ2M7G0vtrg6Lkd
         byc193NX2EFxgUey8WarYbTHS+sO2B9udHjAZOdOrXEkK1LbifFQoFfPzhVbKjCESjnY
         LS9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O0vgVpcNkS4mAjfiGNcrsQkfchPH8sG7BBuJp5aFS/s=;
        b=DopHA9CW+NKLsazA4pcsohC3XLNm2TI77UB8WkNTtp6c04EZKbFiUsFFFUBgXrlQ2L
         OUDnlrxO0uiORsxj7FKgty/6eZg1AOT4Fcxenbf0EXthmJeLED4Hq2CkG/vxHTXQkZXr
         K35acDHREnUuXpSph0agjamGZT7T+a5s+7rqlne7oqdvteewhHJnWmQNjled2l4bgITO
         HD6siMab5HUQH3Agp030FkRdB1TpRi+STsdHfT0KJ+ELhdnLw0MooHh+V+P968zhDEs6
         vjhA67WoDtjND0GTSsFS4PKMAckWtLQfzCVnJ0m6gOM6Ghh6f6Prw/VYUCPWOKRUGJhe
         SJ/w==
X-Gm-Message-State: AOAM531b7RRW+eddEaoa7cSYtPXs9AYtTQUHBc39ZDlnWwut1QsZvJ8x
        aiM65KROxgogkcrIdlpp/092NnxFibS4rw==
X-Google-Smtp-Source: ABdhPJwUQ8wKL88ODO6ABT1EDbcGjdzfFu9wh3ut3pM/iZRWAdcczP3D1QBZ9ozk+oFikho42/g8pw==
X-Received: by 2002:a05:6402:35c8:: with SMTP id z8mr4336751edc.210.1619768716025;
        Fri, 30 Apr 2021 00:45:16 -0700 (PDT)
Received: from agape ([5.171.81.86])
        by smtp.gmail.com with ESMTPSA id n17sm651810eds.72.2021.04.30.00.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 00:45:15 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 42/43] staging: rtl8723bs: remove DebugLevel member in dm_odm_t struct
Date:   Fri, 30 Apr 2021 09:44:00 +0200
Message-Id: <fac0a882d453f24e423ccc76e494d09207ff9ccd.1619768150.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619768150.git.fabioaiuto83@gmail.com>
References: <cover.1619768150.git.fabioaiuto83@gmail.com>
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

