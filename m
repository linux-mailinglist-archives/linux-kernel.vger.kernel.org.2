Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53D7F41803A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 09:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233268AbhIYHro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 03:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233126AbhIYHrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 03:47:42 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD44C061740
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 00:46:08 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id g8so45318091edt.7
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 00:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U5x9/NbiHsv2lpp8dq++p9sKQU3QkuVj5ZUo+XqA34c=;
        b=llgCPq32hSl+JYNrEBfqnbOSEMTRKIgJygquF8E0dlmDilnANeM4roNYrlgiy7Ixfy
         hk+X5ITCaJMsrqpDfMmV1b+B+tD+K2rcokcKhT7f84QVdphU5PKw63OByZvkC9dll3b3
         tuM0kW+r0Jm6EaLUj91S1qZb93/6Yrvj51PWwh7d+Vhc5ZF9K9AKHKFx6xvTW7h0Ptvx
         NLm7ktDvf+dW2obQDTMALULa1J+DziE53u/fxvGiSiD4BO5h/I+b9LeqgtnaZJLpn3V8
         S+De715yICm3Moez5miSdXSL2xWD493kMMH3xHI9Dctz6+ZRfTmmqZj0ZI8qWrOvvenP
         exBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U5x9/NbiHsv2lpp8dq++p9sKQU3QkuVj5ZUo+XqA34c=;
        b=M7r6fGHEP9kxzj+9cQSCsbO1N+agfoeEB+S0VIyxN9JWRtDWiv+a8LOuqiLdebKQoi
         bKb572BgOj4V80SBTzWFyOQivwAhfdZnUmyC8S8vrHkRV7kygtqv4OfzQSlTIo2iu9M2
         z4oCZDX9Li+ouyCM3OP99hOuOkATBszr5I6Ml07z3DVSQyg2aaIR/eOF/rKZOrAwHiyj
         AOQ3sA/UnI7mtn2Q8gVruoJkmHYvehVKoq/RbRbFxhMCXx5iLjUabB98Avh3OTwHQ/1u
         f694PnNf2qz/PXoIhpSjFJHKu2uYj+O/+Ks09YETOIPxVdgqYo0WjfHxWVqboMbdRgdN
         hebQ==
X-Gm-Message-State: AOAM531DP0exBQr4DAXv3qkqa/0hrCXyPM/nR4bUkeBZAcVGlQLFP0tk
        vrTzCLsjJ6O0KrFmb8VeUes=
X-Google-Smtp-Source: ABdhPJzY2KtdmR43WReRabot9fQPT86jE2UAr8BQdttMoHER6MKi93lHueJQD83/MciugHlSZB8RvA==
X-Received: by 2002:a17:906:a246:: with SMTP id bi6mr852200ejb.389.1632555966750;
        Sat, 25 Sep 2021 00:46:06 -0700 (PDT)
Received: from tom-desktop.station (net-93-71-218-228.cust.vodafonedsl.it. [93.71.218.228])
        by smtp.gmail.com with ESMTPSA id m14sm5949900ejl.74.2021.09.25.00.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Sep 2021 00:46:06 -0700 (PDT)
From:   Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     tomm.merciai@gmail.com, Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yujia Qiao <rapiz@foxmail.com>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        Lucas Henneman <lucas.henneman@linaro.org>,
        =?UTF-8?q?Aldas=20Tara=C5=A1kevi=C4=8Dius?= <aldas60@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Deepak R Varma <mh12gx2825@gmail.com>,
        Marcos Antonio de Jesus Filho <mdejesusfilho@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] staging: vt6655: replace camel case ld_bm_threshold instead of ldBmThreshold.
Date:   Sat, 25 Sep 2021 09:45:23 +0200
Message-Id: <20210925074531.10446-3-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210925074531.10446-1-tomm.merciai@gmail.com>
References: <20210925074531.10446-1-tomm.merciai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
---
Changes since v2:
 - Add changelog.

Changes since v1:
 - Make the commit message more clearer.
---
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

