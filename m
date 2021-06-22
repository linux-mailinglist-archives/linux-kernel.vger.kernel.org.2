Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 268833B046C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 14:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbhFVMc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 08:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbhFVMcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 08:32:10 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3E7C061767
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 05:29:51 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id n7so23453112wri.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 05:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bE0/IBysZYE/ZXL1p5rQU1Kbefc1vevyehuv3S/iCqk=;
        b=GhVEq7rhPl7NjI+2W1YMuWsjVTJhGJd+P9Xp73VRCGVQhVo/fSfBTTWdMdyEXnWo7C
         fDNKav1Rnmyw/l1KGCq8yjJueArymVAt7NzwzSj+6PLialdVAPLFxau2Uo9WNNqoaXQ6
         DT7CJCcv7ET4LGl/wKzLTm5v9YePLM5ME/UPaVbcuYC/wCmDhWoFl9Y2krsDHUl4uhz2
         iTQwSX7YIfi3aya+BW/YuV021S0wIjOceYhmdur5kCzSzgBj7AaVXNCJWPjHb75Mmnz8
         i3EZQ2w/GmQrC2yihna+v56UsWvNjMtYNwc/Gy+FqmGYQUJ1nYl3+UsjTkE9GPTZg8Ed
         ZGtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bE0/IBysZYE/ZXL1p5rQU1Kbefc1vevyehuv3S/iCqk=;
        b=GlmrZ/wrqX0MkS/Vliz5UJlfBdjvhjiw3z4DTWsFH+hzaPuhWaQy+OxypT95dZzxZY
         HmQ0uIRIsLNK1S5bU1h8D+8FJHj6lQn/3PgyC6s30oIhSSRAj+mOptu4w2gWZwMSpi4S
         HgRL2T9SbKu9WJqSJfXwXQJt8532VUvkc8jUCBFB4INSWQUC8gxXiEyGOWQjlCFU4vZV
         WnvYfVpyciFptsODeLc2qDGXNa3jSvE2mS1VwJMmYQQz6EdCBFgvhaq+98yQKEd4kE2r
         YKcQIuxcz0bDe1KuJdAooDsv3TnltZcHuNEW/j+lmt+AVAqBWESqhVxfiYbW6HD9zZgv
         FkIQ==
X-Gm-Message-State: AOAM532+cBH/Wix8R6gW2ovErzfnkWN6p/Myt0B3qU2Bf2luocxQB2ya
        bYnjI4O1LPU1gTUbXFH8hIdtu9A3m0tSpg==
X-Google-Smtp-Source: ABdhPJw6KLak52fEqxH6DvIZoJvkV+Tx+34ktmurYsivL6rlY5peuGqX7gFkMJ4BdsGhY7FgdUh0OA==
X-Received: by 2002:a5d:60c2:: with SMTP id x2mr4505623wrt.254.1624364990265;
        Tue, 22 Jun 2021 05:29:50 -0700 (PDT)
Received: from agape ([5.171.73.108])
        by smtp.gmail.com with ESMTPSA id c12sm2665385wmr.27.2021.06.22.05.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 05:29:50 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/17] staging: rtl8723bs: rename enum items related to channel bonding
Date:   Tue, 22 Jun 2021 14:29:29 +0200
Message-Id: <b8a0d7f41583de6574889a3cd05e3d58a0723417.1624364582.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1624364582.git.fabioaiuto83@gmail.com>
References: <cover.1624364582.git.fabioaiuto83@gmail.com>
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

