Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF614417CC0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 23:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348455AbhIXVCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 17:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348491AbhIXVCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 17:02:47 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783FBC06173F
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 14:01:13 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id bx4so40997016edb.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 14:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CK7l7ElWWWG/aFN5fSTWszA4+wJrr/9Jp+cjgyCq438=;
        b=Y1SH9VijhbYpC5X5B9VN6XZDy2uQhshPxEgsnymM73q6w1rw+4tyMpfuzkyQEm/07I
         xT25IExXpjBsfjRyU0JJ3G4BsJ//gk7ueV9+O1DY5rPhVRLFVSwQksMHiMe811hsWkS9
         A5PFPnxibtKwBvCWEfYfhzZR8hWpEqBq4YtO0W7/3u6IE7qjk7I6CXDO7NNqs2GCV+R/
         hjWaVVVfVVAyoKmFIoBfSZTNyQ0AUs1Qs44PDxm/CIERMK1C6py0hGGNjpPSdydk1Ou7
         Ds9Cf/tYc8hIl2Ejxp0Id81kHksQLxUUJBP3F4UUt7G8Z0CKVhlxEqb8llVCq4ZUKgsa
         YXtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CK7l7ElWWWG/aFN5fSTWszA4+wJrr/9Jp+cjgyCq438=;
        b=rRm12i97Ne1EBgYB4JklPWBGJcXLqXz3y3k77B/Pnio/m7Pe9ByDKfxvwrJITCha8X
         Hbjlpz2egnhGJ+01z2uhJjFlYU9JQ4OJvD/3KH2u5xsYxauyWxbklQbJosB0eVfFFlCD
         X9VDvL4SV73D9Otvo73kCf70ac58EY1o1UO0bW+2jWGJ4x4/jr8A14CQigAarZ0mP0M7
         fsAuZeObq47rbDWY/vWVLKjkqMA5ueOYNyVXpZdpNkZXa1r5B0/V2r3m095IcP1Paj5s
         1ib0OkJUA/5uYT/oDvQfQoUXXN6Eqvzq3ZmKD939cutNKYl4zRfDt614NUjl/OUBd2QN
         u9Ew==
X-Gm-Message-State: AOAM5310XnEL7R4086Rx8p5XISaVNWA8AHTpsOEvkCLnxWNjW2G/FIr7
        N0+JQuXvFYMekTjxkcxmUiw=
X-Google-Smtp-Source: ABdhPJywZHP99p6MGOXeAFNPI2B6z6iF4aA1dl+vD+4k7f7kqIZHeLzANuzG6ksjNdm9WcQ55rjeHw==
X-Received: by 2002:a17:906:dbe9:: with SMTP id yd9mr12912911ejb.184.1632517272087;
        Fri, 24 Sep 2021 14:01:12 -0700 (PDT)
Received: from tom-desktop.station (net-93-71-218-228.cust.vodafonedsl.it. [93.71.218.228])
        by smtp.gmail.com with ESMTPSA id 11sm5456109ejw.50.2021.09.24.14.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 14:01:11 -0700 (PDT)
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
Subject: [PATCH v2 2/3] staging: vt6655: replace camel case ld_bm_threshold instead of ldBmThreshold.
Date:   Fri, 24 Sep 2021 23:00:01 +0200
Message-Id: <20210924210008.106355-3-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210924210008.106355-1-tomm.merciai@gmail.com>
References: <20210924210008.106355-1-tomm.merciai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
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

