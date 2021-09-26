Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75608418A25
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 18:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbhIZQ1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 12:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbhIZQ1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 12:27:36 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33D8C061714
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 09:25:59 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id ee50so58531030edb.13
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 09:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=doJVy0cq4BLRkopPldgH5fW9iudLJB7gkjMw95czSyE=;
        b=iodbVOxYZRwBrZffAdWwBqiNsRhJRzeBOLsGUB2lv73Gv/zJg5f++xWYYl+FVT3Om2
         D/URzkqm4nJeggJ1GUv/ch7VG4Fu0Sjq2W+F+E6PTheftyYjJ41tg/ISNS0HCGn0/ko/
         6qT1lH/6QeUYDhhRIHCczGOKFp9IbsupsIn/+x+PkeWWr1pm9RnP5+Fg7Q5TH9BmNg0J
         bpEr11LB0Gkx2JqdWUoiLtJYRUK0zsrk3hS0z3JhlCW80Df52HH/MTYSyoJ/RssaNyg1
         +0oauTk/IhDwM67gdr0BktLf0x5569sKGaEfTwmk3FlfMs/AlrHSlM+sV5WS34fLhhnO
         hrFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=doJVy0cq4BLRkopPldgH5fW9iudLJB7gkjMw95czSyE=;
        b=UeNcy1PEyNqHJSCDb+Ynp4JAuBGV/AlppDxXnqmbC+4nAwHOsIF9LS0b5pXieMEAf2
         6gU/yiwQx6befVoBy9LeR9UDOmKsJi1F2pzwFdxPiY+zpOrbzTBTJHu4GTBAREMn51ES
         FONRd3tKCrBGWMnh4i411PZe8gKSaFlhckKka2ZEaci/vDApi5+0g64udA3kfc37ET4B
         oco9RGsUt6/pigwsezmuqn9owhC8g3zuztzwsPaHQIuqPmXYF8qqx73qC3B3dIn8C8gN
         RLqtW9Q/0X8mMJUUaodi1qqnJ2YbMu7h8oFJ6oK5+h/UJV0mugeoKF9TB3cXkl0MqR9Z
         8UPg==
X-Gm-Message-State: AOAM531/ZCcb9hHjTciv03ExqOiqZCbstc5J9ASi2V7kznRFBj5gJZUS
        NO3cHO159fM46Z4OJMdvRS0=
X-Google-Smtp-Source: ABdhPJyAjWhzWpDJV4neCQKv3fea6PqPKLnPLchVolRRDocZC8k1vjmFlCOdRW/uQFrSKVkXvJi7lw==
X-Received: by 2002:a50:e18f:: with SMTP id k15mr12620322edl.45.1632673558358;
        Sun, 26 Sep 2021 09:25:58 -0700 (PDT)
Received: from tom-desktop.station (net-93-71-218-228.cust.vodafonedsl.it. [93.71.218.228])
        by smtp.gmail.com with ESMTPSA id z18sm8983208edq.29.2021.09.26.09.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 09:25:58 -0700 (PDT)
From:   Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     tomm.merciai@gmail.com, Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        Yujia Qiao <rapiz@foxmail.com>,
        Lucas Henneman <lucas.henneman@linaro.org>,
        Marcos Antonio de Jesus Filho <mdejesusfilho@gmail.com>,
        =?UTF-8?q?Aldas=20Tara=C5=A1kevi=C4=8Dius?= <aldas60@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Deepak R Varma <mh12gx2825@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/3] staging: vt6655: fix camelcase in ldBmThreshold
Date:   Sun, 26 Sep 2021 18:25:19 +0200
Message-Id: <20210926162527.21462-3-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210926162527.21462-1-tomm.merciai@gmail.com>
References: <20210926162527.21462-1-tomm.merciai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace camel case variable ldBmThreshold with snake case
variable ld_bm_threshold.

Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
---
Changes since v4:
 - Make the commit body message more clearer.

Changes since v3:
 - Fix patch changelog.

Changes since v2:
 - Add patch changelog.

Changes since v1:
 - Make the commit message more clearer.

 drivers/staging/vt6655/baseband.c    | 48 ++++++++++++++--------------
 drivers/staging/vt6655/device.h      |  2 +-
 drivers/staging/vt6655/device_main.c |  2 +-
 3 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/staging/vt6655/baseband.c b/drivers/staging/vt6655/baseband.c
index 170c4056946f..55bddbda50cd 100644
--- a/drivers/staging/vt6655/baseband.c
+++ b/drivers/staging/vt6655/baseband.c
@@ -2021,10 +2021,10 @@ bool bb_vt3253_init(struct vnt_private *priv)
 		priv->abyBBVGA[1] = 0x0A;
 		priv->abyBBVGA[2] = 0x0;
 		priv->abyBBVGA[3] = 0x0;
-		priv->ldBmThreshold[0] = -70;
-		priv->ldBmThreshold[1] = -50;
-		priv->ldBmThreshold[2] = 0;
-		priv->ldBmThreshold[3] = 0;
+		priv->ld_bm_threshold[0] = -70;
+		priv->ld_bm_threshold[1] = -50;
+		priv->ld_bm_threshold[2] = 0;
+		priv->ld_bm_threshold[3] = 0;
 	} else if ((by_rf_type == RF_AIROHA) || (by_rf_type == RF_AL2230S)) {
 		for (ii = 0; ii < CB_VT3253B0_INIT_FOR_AIROHA2230; ii++)
 			result &= bb_write_embedded(priv,
@@ -2039,10 +2039,10 @@ bool bb_vt3253_init(struct vnt_private *priv)
 		priv->abyBBVGA[1] = 0x10;
 		priv->abyBBVGA[2] = 0x0;
 		priv->abyBBVGA[3] = 0x0;
-		priv->ldBmThreshold[0] = -70;
-		priv->ldBmThreshold[1] = -48;
-		priv->ldBmThreshold[2] = 0;
-		priv->ldBmThreshold[3] = 0;
+		priv->ld_bm_threshold[0] = -70;
+		priv->ld_bm_threshold[1] = -48;
+		priv->ld_bm_threshold[2] = 0;
+		priv->ld_bm_threshold[3] = 0;
 	} else if (by_rf_type == RF_UW2451) {
 		for (ii = 0; ii < CB_VT3253B0_INIT_FOR_UW2451; ii++)
 			result &= bb_write_embedded(priv,
@@ -2061,10 +2061,10 @@ bool bb_vt3253_init(struct vnt_private *priv)
 		priv->abyBBVGA[1] = 0x0A;
 		priv->abyBBVGA[2] = 0x0;
 		priv->abyBBVGA[3] = 0x0;
-		priv->ldBmThreshold[0] = -60;
-		priv->ldBmThreshold[1] = -50;
-		priv->ldBmThreshold[2] = 0;
-		priv->ldBmThreshold[3] = 0;
+		priv->ld_bm_threshold[0] = -60;
+		priv->ld_bm_threshold[1] = -50;
+		priv->ld_bm_threshold[2] = 0;
+		priv->ld_bm_threshold[3] = 0;
 	} else if (by_rf_type == RF_UW2452) {
 		for (ii = 0; ii < CB_VT3253B0_INIT_FOR_UW2451; ii++)
 			result &= bb_write_embedded(priv,
@@ -2107,10 +2107,10 @@ bool bb_vt3253_init(struct vnt_private *priv)
 		priv->abyBBVGA[1] = 0x0A;
 		priv->abyBBVGA[2] = 0x0;
 		priv->abyBBVGA[3] = 0x0;
-		priv->ldBmThreshold[0] = -60;
-		priv->ldBmThreshold[1] = -50;
-		priv->ldBmThreshold[2] = 0;
-		priv->ldBmThreshold[3] = 0;
+		priv->ld_bm_threshold[0] = -60;
+		priv->ld_bm_threshold[1] = -50;
+		priv->ld_bm_threshold[2] = 0;
+		priv->ld_bm_threshold[3] = 0;
 		/* }} RobertYu */
 
 	} else if (by_rf_type == RF_VT3226) {
@@ -2127,10 +2127,10 @@ bool bb_vt3253_init(struct vnt_private *priv)
 		priv->abyBBVGA[1] = 0x10;
 		priv->abyBBVGA[2] = 0x0;
 		priv->abyBBVGA[3] = 0x0;
-		priv->ldBmThreshold[0] = -70;
-		priv->ldBmThreshold[1] = -48;
-		priv->ldBmThreshold[2] = 0;
-		priv->ldBmThreshold[3] = 0;
+		priv->ld_bm_threshold[0] = -70;
+		priv->ld_bm_threshold[1] = -48;
+		priv->ld_bm_threshold[2] = 0;
+		priv->ld_bm_threshold[3] = 0;
 		/* Fix VT3226 DFC system timing issue */
 		MACvSetRFLE_LatchBase(iobase);
 		/* {{ RobertYu: 20050104 */
@@ -2161,10 +2161,10 @@ bool bb_vt3253_init(struct vnt_private *priv)
 		priv->abyBBVGA[1] = 0x10;
 		priv->abyBBVGA[2] = 0x0;
 		priv->abyBBVGA[3] = 0x0;
-		priv->ldBmThreshold[0] = -70;
-		priv->ldBmThreshold[1] = -48;
-		priv->ldBmThreshold[2] = 0;
-		priv->ldBmThreshold[3] = 0;
+		priv->ld_bm_threshold[0] = -70;
+		priv->ld_bm_threshold[1] = -48;
+		priv->ld_bm_threshold[2] = 0;
+		priv->ld_bm_threshold[3] = 0;
 		/* }} RobertYu */
 	} else {
 		/* No VGA Table now */
diff --git a/drivers/staging/vt6655/device.h b/drivers/staging/vt6655/device.h
index 63aa62e483c8..876472862520 100644
--- a/drivers/staging/vt6655/device.h
+++ b/drivers/staging/vt6655/device.h
@@ -253,7 +253,7 @@ struct vnt_private {
 	unsigned char byBBVGANew;
 	unsigned char byBBVGACurrent;
 	unsigned char abyBBVGA[BB_VGA_LEVEL];
-	long                    ldBmThreshold[BB_VGA_LEVEL];
+	long                    ld_bm_threshold[BB_VGA_LEVEL];
 
 	unsigned char byBBPreEDRSSI;
 	unsigned char byBBPreEDIndex;
diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 8ae0fbfd134f..c4384b232c33 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -986,7 +986,7 @@ static void vnt_check_bb_vga(struct vnt_private *priv)
 	RFvRSSITodBm(priv, (u8)priv->uCurrRSSI, &dbm);
 
 	for (i = 0; i < BB_VGA_LEVEL; i++) {
-		if (dbm < priv->ldBmThreshold[i]) {
+		if (dbm < priv->ld_bm_threshold[i]) {
 			priv->byBBVGANew = priv->abyBBVGA[i];
 			break;
 		}
-- 
2.25.1

