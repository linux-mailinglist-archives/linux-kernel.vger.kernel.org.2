Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A65A423280
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 22:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236641AbhJEU7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 16:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235679AbhJEU7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 16:59:08 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11678C061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 13:57:17 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id v25so1823894wra.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 13:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iUXJIDZOCYYDZ09JggG4RaA50jyl4SQ1xeulUvGhLlE=;
        b=LURt0f6F1s5YYIB+JvOjAtPWeXij8b/Ty3HhzzMi9lLsaFMSwU6M/PI7D8ubiHmTfo
         f0HgvZBA9NDMfDrEHkLiz15M4q2ikC+klgP1FbdRZtY5ZWVybajXppXhhhGYd0mu5QQ8
         bhi32CiZpOY7ldh555Sghl7B2BYgl5eJIt8PuujhBX2zHU7uLzuMsdC5QGYJmZW+1wap
         vu10YSFSJfUJ6je03OYqIxQ3sUvzXjSoYqqdxBNMDYIPsSr2zxsarh4n/HI7yV6WwDD2
         6KNC71OZQCazMVfX2aa9td7qKsYTEPEnpqxmFGaQ+LvBhmD4za0bxxOn96lhsUceGbM7
         SblA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iUXJIDZOCYYDZ09JggG4RaA50jyl4SQ1xeulUvGhLlE=;
        b=X7AEthMtpdtD0sr5BtKWRdJM4tIBQWPMRA5T2eiDpIMT4hJT2Y8qKm3+Pwy8S0+uIH
         EWsIx9cOHswfcEHsWgNvfa7Ld/JVoYELeUmOnZ4JTD9iGx37pcUlF82WGvOz95BuRe0f
         DkHLsNGnTnColeElTddrIS0s9GlnWZu+/QcH+rsggH2kxCO2sZtXaOQbCfX3DNEsO7cQ
         /Rw1vMCzWvo64NLwz5s35LnomTKNpBvhwqo0QuP0tz7kK8HEf4Cud28C5gDuf0oCcVnE
         AaNEfNqVay6xIGSQwO79yKXu0u3UOESbIPT2UALD/YgF0uT5pXZ8NyT+6NPSB+Dk+0pb
         mckA==
X-Gm-Message-State: AOAM530uhxu1qqafp7ewJSsqjPfnOfiGQ8ekRGv6czxMjRy23hDw1nsp
        wyUSYU2O7ywxNteBWVzaBLQ=
X-Google-Smtp-Source: ABdhPJxkAzDIjzC03mOIChTYgjaSEJXS2oo31Ru9cjmIoPxyLXcBJdpUxn6fNqN7l59KJ+6p9+3NDg==
X-Received: by 2002:adf:a184:: with SMTP id u4mr24486774wru.69.1633467435709;
        Tue, 05 Oct 2021 13:57:15 -0700 (PDT)
Received: from tom-desktop.station (net-2-42-54-217.cust.vodafonedsl.it. [2.42.54.217])
        by smtp.gmail.com with ESMTPSA id p14sm2944109wmc.18.2021.10.05.13.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 13:57:15 -0700 (PDT)
From:   Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     tomm.merciai@gmail.com, Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas Henneman <lucas.henneman@linaro.org>,
        Yujia Qiao <rapiz@foxmail.com>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        Marcos Antonio de Jesus Filho <mdejesusfilho@gmail.com>,
        =?UTF-8?q?Aldas=20Tara=C5=A1kevi=C4=8Dius?= <aldas60@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Deepak R Varma <mh12gx2825@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v7 1/3] staging: vt6655: fix camelcase in bShortSlotTime
Date:   Tue,  5 Oct 2021 22:56:57 +0200
Message-Id: <20211005205702.14029-2-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211005205702.14029-1-tomm.merciai@gmail.com>
References: <20211005205702.14029-1-tomm.merciai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace camel case variable bShortSlotTime with snake case variable
short_slot_time. bShortSlotTime is a boolean variable, if true short
slot time is enabled, false not. Short Slot Time reduces the slot time
from 20 microseconds to 9 microseconds, where the slot time is
the maximum theoretical time for a frame to travel a network.

References:
 - http://cciew.blogspot.com/2011/02/short-slot-time.html
 - https://www.cse.wustl.edu/~jain/cse574-16/ftp/j_05lan4.pdf
 - https://www.networkdatapedia.com/post/2013/09/16/ \
   configuring-short-slot-time-to-improve-wifi-performance
 - https://en.wikipedia.org/wiki/Slot_time

Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
---
Changes since v5:
 - Fix variable name short_slot_time instead of b_short_slot_time
 - Add more details in commit message

Changes since v4:
 - Make the commit body message more clearer

Changes since v3:
 - Fix patch changelog

Changes since v2:
 - Add patch changelog

Changes since v1:
 - Make the commit message more clearer

 drivers/staging/vt6655/baseband.c    | 4 ++--
 drivers/staging/vt6655/card.c        | 2 +-
 drivers/staging/vt6655/device.h      | 2 +-
 drivers/staging/vt6655/device_main.c | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/vt6655/baseband.c b/drivers/staging/vt6655/baseband.c
index f73f3fad3e05..491cf4d8bc6c 100644
--- a/drivers/staging/vt6655/baseband.c
+++ b/drivers/staging/vt6655/baseband.c
@@ -2200,7 +2200,7 @@ bb_set_short_slot_time(struct vnt_private *priv)
 
 	bb_read_embedded(priv, 0x0A, &by_bb_rx_conf); /* CR10 */
 
-	if (priv->bShortSlotTime)
+	if (priv->short_slot_time)
 		by_bb_rx_conf &= 0xDF; /* 1101 1111 */
 	else
 		by_bb_rx_conf |= 0x20; /* 0010 0000 */
@@ -2223,7 +2223,7 @@ void bb_set_vga_gain_offset(struct vnt_private *priv, unsigned char by_data)
 	/* patch for 3253B0 Baseband with Cardbus module */
 	if (by_data == priv->abyBBVGA[0])
 		by_bb_rx_conf |= 0x20; /* 0010 0000 */
-	else if (priv->bShortSlotTime)
+	else if (priv->short_slot_time)
 		by_bb_rx_conf &= 0xDF; /* 1101 1111 */
 	else
 		by_bb_rx_conf |= 0x20; /* 0010 0000 */
diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index 3ef3a6e0e6e1..7fb8a74e2a78 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -258,7 +258,7 @@ bool CARDbSetPhyParameter(struct vnt_private *priv, u8 bb_type)
 		bb_write_embedded(priv, 0x88, 0x08);
 		bySIFS = C_SIFS_BG;
 
-		if (priv->bShortSlotTime) {
+		if (priv->short_slot_time) {
 			bySlot = C_SLOT_SHORT;
 			byDIFS = C_SIFS_BG + 2 * C_SLOT_SHORT;
 		} else {
diff --git a/drivers/staging/vt6655/device.h b/drivers/staging/vt6655/device.h
index 2af769174e33..49e3d09480f2 100644
--- a/drivers/staging/vt6655/device.h
+++ b/drivers/staging/vt6655/device.h
@@ -215,7 +215,7 @@ struct vnt_private {
 
 	bool bEncryptionEnable;
 	bool bLongHeader;
-	bool bShortSlotTime;
+	bool short_slot_time;
 	bool bProtectMode;
 	bool bNonERPPresent;
 	bool bBarkerPreambleMd;
diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index d40c2ac14928..52c2a6651bc9 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -1440,9 +1440,9 @@ static void vnt_bss_info_changed(struct ieee80211_hw *hw,
 
 	if (changed & BSS_CHANGED_ERP_SLOT) {
 		if (conf->use_short_slot)
-			priv->bShortSlotTime = true;
+			priv->short_slot_time = true;
 		else
-			priv->bShortSlotTime = false;
+			priv->short_slot_time = false;
 
 		CARDbSetPhyParameter(priv, priv->byBBType);
 		bb_set_vga_gain_offset(priv, priv->abyBBVGA[0]);
-- 
2.25.1

