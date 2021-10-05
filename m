Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 710C9423281
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 22:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236625AbhJEU7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 16:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhJEU7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 16:59:16 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC79C061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 13:57:25 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id v17so1778913wrv.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 13:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xCuvKeW0NYJTiY5Y824IKqe1cCkizCPFvphNKMA3Vyc=;
        b=SLkXS2/judIhxA0bdB9PVshXFZxfk1epb90f7YxxDoSg4TCgvHuN10+tyYirMcOb/i
         oGEwcKV26pWqZOWTQR9weBanYeifRkfONDuhiNoDpTm0LhmD41BzEA30hZM6sImeQHNA
         /GTJ0/wMhS//xiTH1FMKnfD29ToUB/im0QkkEN9lYrw9PLoq07+320LZgjtATEdGYxqt
         v5z66P8Dm5Tga8GdN58Kq3THMeYM58sfB3HnutaTDyZWY5PoGjozvP7GCsk0zLldeftI
         e7vgHsJ8psKVcObO6pCFcrQkHjzG/ewhM1aeuY8OvKaGE1XpzY29tdJXvuIFYDA94he7
         auug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xCuvKeW0NYJTiY5Y824IKqe1cCkizCPFvphNKMA3Vyc=;
        b=NVTxxQXOITTbdN5u5OFB/iQ/djfvTIxG9oPWOoX2NGzqjB8VNzMozQrotNW+XDzN4L
         NpqZQLoRQOAgjgi4L68S2JarDsl19G5q2hdtxt0x3l8rfzGnhbuYdedv84FxtgOHHXBD
         ZF8kVnVDxeceyKIZpmFgesKHn2xdU1T829q3f1tnzSyk8brbf7jqP3BM+31cUWyb5rme
         7h7+FqrFZkAzAtP4oNmQ/ULA0xtaxcwlqLsw2eUzKf5Fvhc7jvGdC8CmkoJt7FLqF0dt
         buQ6c5HZafU82rvN9xuRsrfDZxtN6rB9l6rjWAJ3GMg16kGqbSe0/Yaa5g/OKu6ruasN
         QfRQ==
X-Gm-Message-State: AOAM530oIKngTmN1sn+MuV032Hm6rhfKcC8IeffCaih/wfMfmy/jOJ+X
        XvBifgHHKBLHN3MRt1KN3mI=
X-Google-Smtp-Source: ABdhPJx3vkRzltrVPTkPH0flDOnE8afLaShWFzIMZQA0mtbc9IJSCZP94gIQq87f0S1NJTZqSYl0fQ==
X-Received: by 2002:a1c:3b06:: with SMTP id i6mr5900370wma.172.1633467444286;
        Tue, 05 Oct 2021 13:57:24 -0700 (PDT)
Received: from tom-desktop.station (net-2-42-54-217.cust.vodafonedsl.it. [2.42.54.217])
        by smtp.gmail.com with ESMTPSA id p14sm2944109wmc.18.2021.10.05.13.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 13:57:23 -0700 (PDT)
From:   Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     tomm.merciai@gmail.com, Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas Henneman <lucas.henneman@linaro.org>,
        Yujia Qiao <rapiz@foxmail.com>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        =?UTF-8?q?Aldas=20Tara=C5=A1kevi=C4=8Dius?= <aldas60@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Deepak R Varma <mh12gx2825@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v7 2/3] staging: vt6655: fix camelcase in ldBmThreshold
Date:   Tue,  5 Oct 2021 22:56:58 +0200
Message-Id: <20211005205702.14029-3-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211005205702.14029-1-tomm.merciai@gmail.com>
References: <20211005205702.14029-1-tomm.merciai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace camel case variable ldBmThreshold with snake case
variable dbm_threshold. ldBmThreshold is in hungarian notation, where
"l" is for long and "dbm" is for decibel-milliwatt (signal strenght).
This variable contain's signal strenght threshold in dbm.

References:
 - https://en.wikipedia.org/wiki/Hungarian_notation
 - https://www.rapidtables.com/electric/dBm.html

Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
---
Changes since v6:
 - Fix wrong commit

Changes since v5:
 - Fix variable name dbm_threshold instead of ld_bm_threshold
 - Add more details in commit message

Changes since v4:
 - Make the commit body message more clearer

Changes since v3:
 - Fix patch changelog

Changes since v2:
 - Add patch changelog

Changes since v1:
 - Make the commit message more clearer

 drivers/staging/vt6655/baseband.c    | 48 ++++++++++++++--------------
 drivers/staging/vt6655/device.h      |  2 +-
 drivers/staging/vt6655/device_main.c |  2 +-
 3 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/staging/vt6655/baseband.c b/drivers/staging/vt6655/baseband.c
index 491cf4d8bc6c..7ae6ae984e2d 100644
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
+		priv->dbm_threshold[0] = -70;
+		priv->dbm_threshold[1] = -50;
+		priv->dbm_threshold[2] = 0;
+		priv->dbm_threshold[3] = 0;
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
+		priv->dbm_threshold[0] = -70;
+		priv->dbm_threshold[1] = -48;
+		priv->dbm_threshold[2] = 0;
+		priv->dbm_threshold[3] = 0;
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
+		priv->dbm_threshold[0] = -60;
+		priv->dbm_threshold[1] = -50;
+		priv->dbm_threshold[2] = 0;
+		priv->dbm_threshold[3] = 0;
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
+		priv->dbm_threshold[0] = -60;
+		priv->dbm_threshold[1] = -50;
+		priv->dbm_threshold[2] = 0;
+		priv->dbm_threshold[3] = 0;
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
+		priv->dbm_threshold[0] = -70;
+		priv->dbm_threshold[1] = -48;
+		priv->dbm_threshold[2] = 0;
+		priv->dbm_threshold[3] = 0;
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
+		priv->dbm_threshold[0] = -70;
+		priv->dbm_threshold[1] = -48;
+		priv->dbm_threshold[2] = 0;
+		priv->dbm_threshold[3] = 0;
 		/* }} RobertYu */
 	} else {
 		/* No VGA Table now */
diff --git a/drivers/staging/vt6655/device.h b/drivers/staging/vt6655/device.h
index 49e3d09480f2..307a36222c78 100644
--- a/drivers/staging/vt6655/device.h
+++ b/drivers/staging/vt6655/device.h
@@ -253,7 +253,7 @@ struct vnt_private {
 	unsigned char byBBVGANew;
 	unsigned char byBBVGACurrent;
 	unsigned char abyBBVGA[BB_VGA_LEVEL];
-	long                    ldBmThreshold[BB_VGA_LEVEL];
+	long                    dbm_threshold[BB_VGA_LEVEL];
 
 	unsigned char byBBPreEDRSSI;
 	unsigned char byBBPreEDIndex;
diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 52c2a6651bc9..ff6c59e198a4 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -986,7 +986,7 @@ static void vnt_check_bb_vga(struct vnt_private *priv)
 	RFvRSSITodBm(priv, (u8)priv->uCurrRSSI, &dbm);
 
 	for (i = 0; i < BB_VGA_LEVEL; i++) {
-		if (dbm < priv->ldBmThreshold[i]) {
+		if (dbm < priv->dbm_threshold[i]) {
 			priv->byBBVGANew = priv->abyBBVGA[i];
 			break;
 		}
-- 
2.25.1

