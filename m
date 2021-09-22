Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1516A41530E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 23:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238193AbhIVVwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 17:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238066AbhIVVwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 17:52:02 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD71C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 14:50:31 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id dj4so15673181edb.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 14:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QvtzOdpFtI51DTz/KDaMACdOOmAd5rcG9hZcUr+ctzs=;
        b=l12/yQOUcuuLQ/1w27SqnA8lss7R678Q3b36tkhI/QN6/Hm1sLhyJ1JKcw+wFCVtpX
         KGR6MM03faGfVGpR1ik5/7M6PtSPub3Wdy62Skj8T9QXQ/3sP3wffo/lyk7bZ+WjqGLW
         idjKhKuvW4T95k1ZEdHIyBz2WkS4Xkdj8Zxe0O6B0hnhPNUvKCpLppRcQn8xh+Gl52hc
         8q1BAXlxzAX+zFO7n8TG/a2iNPRy4Az5Lj78FnYMtqPHyARQ0W2MskYhz5DqwTSoGsnh
         BuCCUVswGJ90ZNtDOCokxwwK//1JokpfUuzjBK3AxeqVyHFRjsqaDF72FFQFi3GgkZ0C
         TEFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QvtzOdpFtI51DTz/KDaMACdOOmAd5rcG9hZcUr+ctzs=;
        b=zfTsVz+tWSPqMvOm3wOft9ofImnhRu1dBTmKSXlRbpxhZ4st3GiK3A3u2k1dkaJKP2
         y8Uwe508JoDXxKM4rFcz8QZA4m03lZebwvgrDfeg3qjv/0Wz+BIrP6QzGZ6vBvrq4IHN
         ZO++u/oPQ+FIi9TsTBZ2ncITJcmJqh3g6TEKhNA2iOi11gHzV7/b64unXEQ61k65Ev0X
         /qVnU2SV8AuYJvIetZIliBxIJb0QdDhXF/LJQFYLYJoJ7pO1AwZaDAqWnUaDF9qhr34u
         I56gE5T/ls+RkkjIDxz62B6t04az3jDd+47zIo4B8cM4DTwHj/8tgMDetQbgWuPwYMlb
         m0iQ==
X-Gm-Message-State: AOAM533XunwtaPnwbjaElrM/euQSlXPkQWRn67kURsJo2GOFC/UGs/vI
        BgMMjw3mzDP9GMegkn659/DXISitgCg=
X-Google-Smtp-Source: ABdhPJyPtWVDJwK7nvMy8GslkwNVGzEEnJzLyDB/8MCJUucQDM2jmigtP4XvVqncSV6w1yP44zUZBw==
X-Received: by 2002:a17:906:7217:: with SMTP id m23mr1535341ejk.466.1632347430390;
        Wed, 22 Sep 2021 14:50:30 -0700 (PDT)
Received: from tom-desktop.station (net-93-71-218-228.cust.vodafonedsl.it. [93.71.218.228])
        by smtp.gmail.com with ESMTPSA id a4sm1960203edb.79.2021.09.22.14.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 14:50:29 -0700 (PDT)
From:   Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     tomm.merciai@gmail.com, Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yujia Qiao <rapiz@foxmail.com>,
        Lucas Henneman <lucas.henneman@linaro.org>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: vt6655: Replace camel case variables
Date:   Wed, 22 Sep 2021 23:50:24 +0200
Message-Id: <20210922215026.572424-1-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Work in progress: replace camel case variables.

Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
---
 drivers/staging/vt6655/baseband.c | 50 +++++++++++++++----------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/staging/vt6655/baseband.c b/drivers/staging/vt6655/baseband.c
index f73f3fad3e05..93640311f8e3 100644
--- a/drivers/staging/vt6655/baseband.c
+++ b/drivers/staging/vt6655/baseband.c
@@ -500,7 +500,7 @@ static const unsigned char by_vt3253_init_tab_rfmd[CB_VT3253_INIT_FOR_RFMD][2] =
 };
 
 #define CB_VT3253B0_INIT_FOR_RFMD 256
-static const unsigned char byVT3253B0_RFMD[CB_VT3253B0_INIT_FOR_RFMD][2] = {
+static const unsigned char by_vt3253b0_rfmd[CB_VT3253B0_INIT_FOR_RFMD][2] = {
 	{0x00, 0x31},
 	{0x01, 0x00},
 	{0x02, 0x00},
@@ -762,7 +762,7 @@ static const unsigned char byVT3253B0_RFMD[CB_VT3253B0_INIT_FOR_RFMD][2] = {
 #define CB_VT3253B0_AGC_FOR_RFMD2959 195
 /* For RFMD2959 */
 static
-unsigned char byVT3253B0_AGC4_RFMD2959[CB_VT3253B0_AGC_FOR_RFMD2959][2] = {
+unsigned char by_vt3253b0_agc4_rfmd2959[CB_VT3253B0_AGC_FOR_RFMD2959][2] = {
 	{0xF0, 0x00},
 	{0xF1, 0x3E},
 	{0xF0, 0x80},
@@ -963,7 +963,7 @@ unsigned char byVT3253B0_AGC4_RFMD2959[CB_VT3253B0_AGC_FOR_RFMD2959][2] = {
 #define CB_VT3253B0_INIT_FOR_AIROHA2230 256
 /* For AIROHA */
 static
-unsigned char byVT3253B0_AIROHA2230[CB_VT3253B0_INIT_FOR_AIROHA2230][2] = {
+unsigned char by_vt3253b0_airoha2230[CB_VT3253B0_INIT_FOR_AIROHA2230][2] = {
 	{0x00, 0x31},
 	{0x01, 0x00},
 	{0x02, 0x00},
@@ -1224,7 +1224,7 @@ unsigned char byVT3253B0_AIROHA2230[CB_VT3253B0_INIT_FOR_AIROHA2230][2] = {
 
 #define CB_VT3253B0_INIT_FOR_UW2451 256
 /* For UW2451 */
-static unsigned char byVT3253B0_UW2451[CB_VT3253B0_INIT_FOR_UW2451][2] = {
+static unsigned char by_vt3253b0_uw2451[CB_VT3253B0_INIT_FOR_UW2451][2] = {
 	{0x00, 0x31},
 	{0x01, 0x00},
 	{0x02, 0x00},
@@ -1485,7 +1485,7 @@ static unsigned char byVT3253B0_UW2451[CB_VT3253B0_INIT_FOR_UW2451][2] = {
 
 #define CB_VT3253B0_AGC 193
 /* For AIROHA */
-static unsigned char byVT3253B0_AGC[CB_VT3253B0_AGC][2] = {
+static unsigned char by_vt3253b0_agc[CB_VT3253B0_AGC][2] = {
 	{0xF0, 0x00},
 	{0xF1, 0x00},
 	{0xF0, 0x80},
@@ -2006,13 +2006,13 @@ bool bb_vt3253_init(struct vnt_private *priv)
 		} else {
 			for (ii = 0; ii < CB_VT3253B0_INIT_FOR_RFMD; ii++)
 				result &= bb_write_embedded(priv,
-					byVT3253B0_RFMD[ii][0],
-					byVT3253B0_RFMD[ii][1]);
+					by_vt3253b0_rfmd[ii][0],
+					by_vt3253b0_rfmd[ii][1]);
 
 			for (ii = 0; ii < CB_VT3253B0_AGC_FOR_RFMD2959; ii++)
 				result &= bb_write_embedded(priv,
-					byVT3253B0_AGC4_RFMD2959[ii][0],
-					byVT3253B0_AGC4_RFMD2959[ii][1]);
+					by_vt3253b0_agc4_rfmd2959[ii][0],
+					by_vt3253b0_agc4_rfmd2959[ii][1]);
 
 			VNSvOutPortD(iobase + MAC_REG_ITRTMSET, 0x23);
 			MACvRegBitsOn(iobase, MAC_REG_PAPEDELAY, BIT(0));
@@ -2028,12 +2028,12 @@ bool bb_vt3253_init(struct vnt_private *priv)
 	} else if ((by_rf_type == RF_AIROHA) || (by_rf_type == RF_AL2230S)) {
 		for (ii = 0; ii < CB_VT3253B0_INIT_FOR_AIROHA2230; ii++)
 			result &= bb_write_embedded(priv,
-				byVT3253B0_AIROHA2230[ii][0],
-				byVT3253B0_AIROHA2230[ii][1]);
+				by_vt3253b0_airoha2230[ii][0],
+				by_vt3253b0_airoha2230[ii][1]);
 
 		for (ii = 0; ii < CB_VT3253B0_AGC; ii++)
 			result &= bb_write_embedded(priv,
-				byVT3253B0_AGC[ii][0], byVT3253B0_AGC[ii][1]);
+				by_vt3253b0_agc[ii][0], by_vt3253b0_agc[ii][1]);
 
 		priv->abyBBVGA[0] = 0x1C;
 		priv->abyBBVGA[1] = 0x10;
@@ -2046,13 +2046,13 @@ bool bb_vt3253_init(struct vnt_private *priv)
 	} else if (by_rf_type == RF_UW2451) {
 		for (ii = 0; ii < CB_VT3253B0_INIT_FOR_UW2451; ii++)
 			result &= bb_write_embedded(priv,
-				byVT3253B0_UW2451[ii][0],
-				byVT3253B0_UW2451[ii][1]);
+				by_vt3253b0_uw2451[ii][0],
+				by_vt3253b0_uw2451[ii][1]);
 
 		for (ii = 0; ii < CB_VT3253B0_AGC; ii++)
 			result &= bb_write_embedded(priv,
-				byVT3253B0_AGC[ii][0],
-				byVT3253B0_AGC[ii][1]);
+				by_vt3253b0_agc[ii][0],
+				by_vt3253b0_agc[ii][1]);
 
 		VNSvOutPortB(iobase + MAC_REG_ITRTMSET, 0x23);
 		MACvRegBitsOn(iobase, MAC_REG_PAPEDELAY, BIT(0));
@@ -2068,8 +2068,8 @@ bool bb_vt3253_init(struct vnt_private *priv)
 	} else if (by_rf_type == RF_UW2452) {
 		for (ii = 0; ii < CB_VT3253B0_INIT_FOR_UW2451; ii++)
 			result &= bb_write_embedded(priv,
-				byVT3253B0_UW2451[ii][0],
-				byVT3253B0_UW2451[ii][1]);
+				by_vt3253b0_uw2451[ii][0],
+				by_vt3253b0_uw2451[ii][1]);
 
 		/* Init ANT B select,
 		 * TX Config CR09 = 0x61->0x45,
@@ -2101,7 +2101,7 @@ bool bb_vt3253_init(struct vnt_private *priv)
 
 		for (ii = 0; ii < CB_VT3253B0_AGC; ii++)
 			result &= bb_write_embedded(priv,
-				byVT3253B0_AGC[ii][0], byVT3253B0_AGC[ii][1]);
+				by_vt3253b0_agc[ii][0], by_vt3253b0_agc[ii][1]);
 
 		priv->abyBBVGA[0] = 0x14;
 		priv->abyBBVGA[1] = 0x0A;
@@ -2116,12 +2116,12 @@ bool bb_vt3253_init(struct vnt_private *priv)
 	} else if (by_rf_type == RF_VT3226) {
 		for (ii = 0; ii < CB_VT3253B0_INIT_FOR_AIROHA2230; ii++)
 			result &= bb_write_embedded(priv,
-				byVT3253B0_AIROHA2230[ii][0],
-				byVT3253B0_AIROHA2230[ii][1]);
+				by_vt3253b0_airoha2230[ii][0],
+				by_vt3253b0_airoha2230[ii][1]);
 
 		for (ii = 0; ii < CB_VT3253B0_AGC; ii++)
 			result &= bb_write_embedded(priv,
-				byVT3253B0_AGC[ii][0], byVT3253B0_AGC[ii][1]);
+				by_vt3253b0_agc[ii][0], by_vt3253b0_agc[ii][1]);
 
 		priv->abyBBVGA[0] = 0x1C;
 		priv->abyBBVGA[1] = 0x10;
@@ -2137,8 +2137,8 @@ bool bb_vt3253_init(struct vnt_private *priv)
 	} else if (by_rf_type == RF_AIROHA7230) {
 		for (ii = 0; ii < CB_VT3253B0_INIT_FOR_AIROHA2230; ii++)
 			result &= bb_write_embedded(priv,
-				byVT3253B0_AIROHA2230[ii][0],
-				byVT3253B0_AIROHA2230[ii][1]);
+				by_vt3253b0_airoha2230[ii][0],
+				by_vt3253b0_airoha2230[ii][1]);
 
 		/* {{ RobertYu:20050223, request by JerryChung */
 		/* Init ANT B select,TX Config CR09 = 0x61->0x45,
@@ -2155,7 +2155,7 @@ bool bb_vt3253_init(struct vnt_private *priv)
 
 		for (ii = 0; ii < CB_VT3253B0_AGC; ii++)
 			result &= bb_write_embedded(priv,
-				byVT3253B0_AGC[ii][0], byVT3253B0_AGC[ii][1]);
+				by_vt3253b0_agc[ii][0], by_vt3253b0_agc[ii][1]);
 
 		priv->abyBBVGA[0] = 0x1C;
 		priv->abyBBVGA[1] = 0x10;
-- 
2.25.1

