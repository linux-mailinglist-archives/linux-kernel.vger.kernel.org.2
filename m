Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67711421A17
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 00:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236034AbhJDWeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 18:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235064AbhJDWeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 18:34:07 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991D2C061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 15:32:17 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id b8so36167750edk.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 15:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iUXJIDZOCYYDZ09JggG4RaA50jyl4SQ1xeulUvGhLlE=;
        b=QjwWMJ1C1S7POJcdkcebWU9eX6CruDch3yDyoDmjv2y9O/qwtjtp+rKnVqq0/gKyh/
         sQ8ntA16OqGhisMPmgwdSU8jUm/J+E3LyBGUi6CRG4rh3B8D/8QewzJWx8CPs9T+2tFt
         DN/+zNdsbJfp4BuwdqnKujmAZn/uwPSNtNLVqTDULXelZsRD1ywzs0nr4XBW3Oz5Fg+t
         X5v8JcwTcY25ajayCVwktcK8IB2QgM0W6E8g2gLWNVkqRsn3uQrdh/9sAZrpPv1r4YUd
         CwN1cRG96ZouNgtcxutai8dXONuPhgNmLNtC6sYhQnlzn+Y/Xke5pj9F/eNdcoX3PoGN
         27bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iUXJIDZOCYYDZ09JggG4RaA50jyl4SQ1xeulUvGhLlE=;
        b=oEoKRJXa3hJURv93vcxj2Oka+NhriKBtcopX1p2ph17nyUFdGsXAX59YZb6zMfdNwq
         9sZlJrnqIxfPKUkzBZqbM4OAwmT2t4T7kxRsaeyHRaHDRvEGNvEZPr2hm7QKcYx0q1Db
         2a4relFtg4ojfQebDo/wIG7n2LeYcBetyQGspq3eH14IDenJ+TGOvNrsK2LYnozznxxU
         Xg5x1493BTuwuxxzBfx6XtxhS7oQG/AosL9tk3vBBD5E0za16oAgFOqP4WYnAKKt2OyM
         hOaSDKYMsADV9eFfcG4dMkjrcz7w3IDHVYDjl1G72G/Kzwjg4a8nbk/KGDcV5i0d+kJa
         PqOA==
X-Gm-Message-State: AOAM530z1qiK5IvTuXdGlE5Ovg0J1FPa/95PcL1I52zowwNNR9baX84S
        soNffmPf7b1qZIqNOzuP4PM=
X-Google-Smtp-Source: ABdhPJzEJKE3OTJxnvumu4446U+Hm8D/IuIqaPExZqbhcJPTCAoumsHdxa0pTGQmkLc3WB+Rj0tgGA==
X-Received: by 2002:a50:ec08:: with SMTP id g8mr17984875edr.303.1633386736253;
        Mon, 04 Oct 2021 15:32:16 -0700 (PDT)
Received: from tom-desktop.station (net-2-42-54-217.cust.vodafonedsl.it. [2.42.54.217])
        by smtp.gmail.com with ESMTPSA id dc8sm7780919edb.28.2021.10.04.15.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 15:32:15 -0700 (PDT)
From:   Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     tomm.merciai@gmail.com, Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas Henneman <lucas.henneman@linaro.org>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        Yujia Qiao <rapiz@foxmail.com>,
        Marcos Antonio de Jesus Filho <mdejesusfilho@gmail.com>,
        =?UTF-8?q?Aldas=20Tara=C5=A1kevi=C4=8Dius?= <aldas60@gmail.com>,
        Deepak R Varma <mh12gx2825@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/3] staging: vt6655: fix camelcase in bShortSlotTime
Date:   Tue,  5 Oct 2021 00:31:56 +0200
Message-Id: <20211004223200.70524-2-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211004223200.70524-1-tomm.merciai@gmail.com>
References: <20211004223200.70524-1-tomm.merciai@gmail.com>
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

