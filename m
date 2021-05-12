Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17BA237B6FE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 09:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbhELHkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 03:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbhELHkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 03:40:06 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1771C061574
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 00:38:57 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id u21so33474138ejo.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 00:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N9lhNSkhlyUhXIO2O+gz6kztxq/n6XYJjAIx1T19amQ=;
        b=NCVUjbwJyi4J8KMUagQgUhYcUdm/bOEs57Z4W8zkTyVfrMs81FmSAoTxTqCedjKOse
         cglM0y0DP2muX3kEQzaZAYs98P5m7EslPZPYgFbnnfLnpKx8AYSvEXu9yxj0U3yA1wqI
         biPBYqP2gD6g6OhfMiwpPQWBbe69T8GawEJU++3Mpu0YlYPsVP/7tkhb88HAPlFyvwwy
         N2QhQx1BNP/e7IGjUpT3ZGcdnq2ecU1ipnHepX1BwabKagSSYabYNq0uLJAnbOfWv4Et
         JdwFr1G0/GH73uZQ0GosBDDO9SuJpSaCgnicVXgyrROX9DFKkrb0WMzXazK3Z8v4lNva
         jP/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N9lhNSkhlyUhXIO2O+gz6kztxq/n6XYJjAIx1T19amQ=;
        b=WDASKPSqX2qVxGl3TBXr+UszrA2lwPPhJNzO7/XB3rAuXKzEkgiktCs0VRuxX1LcOw
         XRkwdRv0MLM9lSlCvGiSxDpam9KYjE1vCo5Hh3gvOUxFK7I95JBYa5TCrEs5eaMeghH3
         k9015Oy9z5jlmGA1hUfymFJ51+nx+rfY5HY0Hca6ZHXYxUQoJKo/z9Gd8ppFpdbTpgJd
         eG5ru0zGXSPFzdWSYBKB9D/r7A3jDQ41oPsk+sjBBo/KsV4ekK+Ut0xO8FID909CrBIw
         IBO/ZbcWlrg95ZS7Xt2cPjIwqmPNrdX+uNc4eM3yHZiUhX3PHrFE1qb3EgEYCSXc7CTd
         Rdag==
X-Gm-Message-State: AOAM531zdHomuE24rJNbhedE/VqcPZiULazjQW0hcIt1sl84QFEjEHNN
        DCaX/4F0X5IJP7BzIHWxBI8=
X-Google-Smtp-Source: ABdhPJwjfxUxccgq1TPii8sjiTaDSYEYfOYqvpyT74mqGOvwHpwD90ju0JkbubJNS1684x8GT9gsaw==
X-Received: by 2002:a17:906:268c:: with SMTP id t12mr5761291ejc.441.1620805136528;
        Wed, 12 May 2021 00:38:56 -0700 (PDT)
Received: from linux.local (host-79-52-107-152.retail.telecomitalia.it. [79.52.107.152])
        by smtp.gmail.com with ESMTPSA id g16sm5691854ejw.42.2021.05.12.00.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 00:38:55 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     outreachy-kernel@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev (open list:STAGING SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [Outreachy kernel] [PATCH] staging: rtl8723bs: hal: Remove set but unused variable
Date:   Wed, 12 May 2021 09:38:52 +0200
Message-Id: <20210512073852.14085-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed "delta_IQK" and its occurrences in comments
and code because the variable is set but not used.
Issue detected by GCC.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/rtl8723bs/hal/HalPhyRf.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/HalPhyRf.c b/drivers/staging/rtl8723bs/hal/HalPhyRf.c
index b8e385fdda89..365e1195b5e5 100644
--- a/drivers/staging/rtl8723bs/hal/HalPhyRf.c
+++ b/drivers/staging/rtl8723bs/hal/HalPhyRf.c
@@ -76,7 +76,7 @@ void ODM_TXPowerTrackingCallback_ThermalMeter(struct adapter *Adapter)
 	struct hal_com_data *pHalData = GET_HAL_DATA(Adapter);
 	struct dm_odm_t *pDM_Odm = &pHalData->odmpriv;
 
-	u8 ThermalValue = 0, delta, delta_LCK, delta_IQK, p = 0, i = 0;
+	u8 ThermalValue = 0, delta, delta_LCK, p = 0, i = 0;
 	u8 ThermalValue_AVG_count = 0;
 	u32 ThermalValue_AVG = 0;
 
@@ -137,7 +137,7 @@ void ODM_TXPowerTrackingCallback_ThermalMeter(struct adapter *Adapter)
 		ThermalValue = (u8)(ThermalValue_AVG / ThermalValue_AVG_count);
 	}
 
-	/* 4 5. Calculate delta, delta_LCK, delta_IQK. */
+	/* 4 5. Calculate delta, delta_LCK */
 	/* delta" here is used to determine whether thermal value changes or not. */
 	delta =
 		(ThermalValue > pDM_Odm->RFCalibrateInfo.ThermalValue) ?
@@ -147,10 +147,6 @@ void ODM_TXPowerTrackingCallback_ThermalMeter(struct adapter *Adapter)
 		(ThermalValue > pDM_Odm->RFCalibrateInfo.ThermalValue_LCK) ?
 		(ThermalValue - pDM_Odm->RFCalibrateInfo.ThermalValue_LCK) :
 		(pDM_Odm->RFCalibrateInfo.ThermalValue_LCK - ThermalValue);
-	delta_IQK =
-		(ThermalValue > pDM_Odm->RFCalibrateInfo.ThermalValue_IQK) ?
-		(ThermalValue - pDM_Odm->RFCalibrateInfo.ThermalValue_IQK) :
-		(pDM_Odm->RFCalibrateInfo.ThermalValue_IQK - ThermalValue);
 
 	/* 4 6. If necessary, do LCK. */
 	/*  Delta temperature is equal to or larger than 20 centigrade. */
-- 
2.31.1

