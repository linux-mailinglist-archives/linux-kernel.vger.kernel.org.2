Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A65D3AD997
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 12:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233098AbhFSKt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 06:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232690AbhFSKtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 06:49:42 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F44FC061574
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 03:47:30 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso10298069wmh.4
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 03:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bE0/IBysZYE/ZXL1p5rQU1Kbefc1vevyehuv3S/iCqk=;
        b=ARfMJNYpueqovvBvEAbLTsJH+v8edhLspra0FOcpNbC7jqyJaC16/stxx5l/cuj7BK
         X1tvJLVCzH9/ZyoUneCAM46KrI3EE8qJ19Y7OBzNoGOhsejcp0Lk80vBXsPfYoVi/RAH
         YLYfc4/nQk380ZHJaf16Y0kbwMowLAISj53/sfcbNwvH6Y2SRl0QDRbOWUu9DjEf7f3a
         zulpxMFwYY2/+9mUJl2gH6nSwmTcfomGqGUpfWU6kMoQsuLqdFfRYpCzNmt85gAQpe/m
         m64iQfI6MRwloSrFG0cLbQ5s56+XkV+nTf2YnCJEem21Kt+WGjN1rr64YUiNa0ULZIKZ
         BxcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bE0/IBysZYE/ZXL1p5rQU1Kbefc1vevyehuv3S/iCqk=;
        b=VDPL7ahbfuQs2n0XhjAGKzIPx+nq5Xb+7yxSGNvyrL3BWNnWWnkbnO81OI0EQEwmcR
         VtAXyk5jVZyS7g4Dk+bmLa9ktwJCuHcQ3royOGIrx0ZbuiQkGmNcQLZRguxiJgepfaeV
         wbDuoQOYRG/UgzAYPKrzClCowFbkeHeMka4c678cg/AuNm2XKrmVSZ3RNgQPOz4UwRAe
         /AVrf6LOoAUjzTydlZO2iU+qLmL2FJdEZzyVDVJkrwDQN7G7DVPz3whlC2t13lgIGXll
         jwAH5EwiRi6ineXb8j/KiOZlekGoYuE57Hh9WYBHtdaqOaV63qgYiRDJeB5LOTPPzS7Y
         ld0Q==
X-Gm-Message-State: AOAM5338mnzOx0raQ0Uaflf90/FhjjcrCv+6ykuS/CMTupLMAarJClMu
        rHpC4gnSpYdX/w1OHq+W2ENKv8Bi8aOFbg==
X-Google-Smtp-Source: ABdhPJz6quShqvTy8D6PSVaMoT2nuQVDBsWC2LN9gVasC5S9bGR3DX1DC2Dr0dpqJW4DZisSNWvTDg==
X-Received: by 2002:a1c:7901:: with SMTP id l1mr15174735wme.95.1624099648793;
        Sat, 19 Jun 2021 03:47:28 -0700 (PDT)
Received: from agape ([5.171.81.81])
        by smtp.gmail.com with ESMTPSA id 62sm11991719wrm.1.2021.06.19.03.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jun 2021 03:47:28 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 04/18] staging: rtl8723bs: rename enum items related to channel bonding
Date:   Sat, 19 Jun 2021 12:47:07 +0200
Message-Id: <b8a0d7f41583de6574889a3cd05e3d58a0723417.1624099125.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1624099125.git.fabioaiuto83@gmail.com>
References: <cover.1624099125.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

since rtl8723bs card allows only 20Mhz and 40Mhz channels,
rename enum items related to channel bonding accordingly to
the only composite channel bandwidth allowed in 2.4Ghz
(i.e. 40Mhz) in a HT context (since VHT isn't supported)

Example:

VHT_DATA_SC_20_LOWER_OF_80MHZ ->
	HT_DATA_SC_LOWER_OF_40MHZ

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 10 +++++-----
 drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c   |  4 ++--
 drivers/staging/rtl8723bs/include/rtw_rf.h        |  6 +++---
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 3ecd034342ec..059d3050acc6 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -2530,18 +2530,18 @@ u8 SCMapping_8723B(struct adapter *Adapter, struct pkt_attrib *pattrib)
 
 	if (pHalData->CurrentChannelBW == CHANNEL_WIDTH_40) {
 		if (pattrib->bwmode == CHANNEL_WIDTH_40) {
-			SCSettingOfDesc = VHT_DATA_SC_DONOT_CARE;
+			SCSettingOfDesc = HT_DATA_SC_DONOT_CARE;
 		} else if (pattrib->bwmode == CHANNEL_WIDTH_20) {
 			if (pHalData->nCur40MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_UPPER) {
-				SCSettingOfDesc = VHT_DATA_SC_20_UPPER_OF_80MHZ;
+				SCSettingOfDesc = HT_DATA_SC_20_UPPER_OF_40MHZ;
 			} else if (pHalData->nCur40MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_LOWER) {
-				SCSettingOfDesc = VHT_DATA_SC_20_LOWER_OF_80MHZ;
+				SCSettingOfDesc = HT_DATA_SC_20_LOWER_OF_40MHZ;
 			} else {
-				SCSettingOfDesc = VHT_DATA_SC_DONOT_CARE;
+				SCSettingOfDesc = HT_DATA_SC_DONOT_CARE;
 			}
 		}
 	} else {
-		SCSettingOfDesc = VHT_DATA_SC_DONOT_CARE;
+		SCSettingOfDesc = HT_DATA_SC_DONOT_CARE;
 	}
 
 	return SCSettingOfDesc;
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c b/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
index 275460865719..23435dcc5537 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
@@ -621,9 +621,9 @@ static u8 phy_GetSecondaryChnl_8723B(struct adapter *Adapter)
 
 	if (pHalData->CurrentChannelBW == CHANNEL_WIDTH_40) {
 		if (pHalData->nCur40MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_UPPER)
-			SCSettingOf20 = VHT_DATA_SC_20_UPPER_OF_80MHZ;
+			SCSettingOf20 = HT_DATA_SC_20_UPPER_OF_40MHZ;
 		else if (pHalData->nCur40MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_LOWER)
-			SCSettingOf20 = VHT_DATA_SC_20_LOWER_OF_80MHZ;
+			SCSettingOf20 = HT_DATA_SC_20_LOWER_OF_40MHZ;
 	}
 
 	return  (SCSettingOf40 << 4) | SCSettingOf20;
diff --git a/drivers/staging/rtl8723bs/include/rtw_rf.h b/drivers/staging/rtl8723bs/include/rtw_rf.h
index 550471637315..48ff15a38bb0 100644
--- a/drivers/staging/rtl8723bs/include/rtw_rf.h
+++ b/drivers/staging/rtl8723bs/include/rtw_rf.h
@@ -95,9 +95,9 @@ enum extchnl_offset {
 };
 
 enum {
-	VHT_DATA_SC_DONOT_CARE = 0,
-	VHT_DATA_SC_20_UPPER_OF_80MHZ = 1,
-	VHT_DATA_SC_20_LOWER_OF_80MHZ = 2,
+	HT_DATA_SC_DONOT_CARE = 0,
+	HT_DATA_SC_20_UPPER_OF_40MHZ = 1,
+	HT_DATA_SC_20_LOWER_OF_40MHZ = 2,
 };
 
 /* 2007/11/15 MH Define different RF type. */
-- 
2.20.1

