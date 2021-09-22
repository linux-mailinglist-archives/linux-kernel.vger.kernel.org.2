Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABF2F415339
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 00:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238245AbhIVWPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 18:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbhIVWPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 18:15:23 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498CFC061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 15:13:52 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id x7so1613056edd.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 15:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uiyd5emhTLLsGWjHfRfiee/EFk982GLkYo1Jk79nKU8=;
        b=gR/nAeubBx9PM3vHJpsKTJ7k7DgKk/eVd7+bWb3SziBMax7o9WamCAe9FXtWBr13tg
         7ajTu1kiiwGuh/pi4LTnT2T198ChWhaHFYIzGh+5xPq4bnSDx1qdIBnHfUylhNeVDFuW
         UgduwTYAX4h9DVK2AbAAMhsDo1TnGWEH0OjK48h0OyYEeqIURJQvM3AO5K2agtM8eyQv
         NejMefxCVPv9L2giq3i23WBxuHQAvWhEmCAYn7mb5lXPHFdSw2nQfZEArqjYA/5AxPIf
         D9AqKUEOVrAt8s1tsE6naZIOs58JzVx8EBrEHpgV0wK69gPPUqA5Rk6eUcwY/z98tyjh
         ZLJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uiyd5emhTLLsGWjHfRfiee/EFk982GLkYo1Jk79nKU8=;
        b=OlyE4SYbl+B4DoRuTjONS18PHruScSI2Ob3oXJ2oor7Y8X7I7W6OLzrCRTk1vYtgEu
         1mYYNvqHrDTIqbo+rcv8FNCe2XVVPAk9vpcxzkhMSQqXisLqkVxK7WJwQD9YzrIWZv6V
         c6YPZU7qxdmksxOOpu4hBjECAbpm8ZtGMxOifyxBNIh2XL6vsfx6wbsIU2EV1y2vwFvy
         YnqsLKcK3Tf22yI1PIgVl45rAb21hVXTJ9lz86SYdSp6phVvO1mQD2tUD8AXFDxqDiVT
         bkR2+isyos/VyrrlhnAKbBDzGCx7L1KDJWm36FIitZcd80Aldfw6es0vn0fJnShzUEYb
         LghQ==
X-Gm-Message-State: AOAM533xBqMfH0qmaDtzgLGm5uxhUq3KsY/TNWkpdfpItHkul3DKV9CM
        +PS+NQ9v1keMuHN/FRnA2FY=
X-Google-Smtp-Source: ABdhPJwRvCDcaG5O75HW/RbZdU83E/DClU5uyiZLoiR77EeMXFgKryZuE9duZmdf6vt9vByBmX8kcg==
X-Received: by 2002:a17:906:25db:: with SMTP id n27mr1692850ejb.108.1632348830802;
        Wed, 22 Sep 2021 15:13:50 -0700 (PDT)
Received: from tom-desktop.station (net-93-71-218-228.cust.vodafonedsl.it. [93.71.218.228])
        by smtp.gmail.com with ESMTPSA id di4sm1956155edb.34.2021.09.22.15.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 15:13:50 -0700 (PDT)
From:   Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     tomm.merciai@gmail.com, Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas Henneman <lucas.henneman@linaro.org>,
        Yujia Qiao <rapiz@foxmail.com>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        =?UTF-8?q?Aldas=20Tara=C5=A1kevi=C4=8Dius?= <aldas60@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Deepak R Varma <mh12gx2825@gmail.com>,
        Marcos Antonio de Jesus Filho <mdejesusfilho@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: vt6655: Replace camel case variable name
Date:   Thu, 23 Sep 2021 00:13:40 +0200
Message-Id: <20210922221346.586346-1-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Work in progress: replace camel case variables

byPreambleType -> by_preamble_type

Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
---
 drivers/staging/vt6655/baseband.c    |  2 +-
 drivers/staging/vt6655/device.h      |  2 +-
 drivers/staging/vt6655/device_main.c |  8 ++---
 drivers/staging/vt6655/rxtx.c        | 50 ++++++++++++++--------------
 4 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/drivers/staging/vt6655/baseband.c b/drivers/staging/vt6655/baseband.c
index 20f1a839ba50..9bd1ff36f9af 100644
--- a/drivers/staging/vt6655/baseband.c
+++ b/drivers/staging/vt6655/baseband.c
@@ -1764,7 +1764,7 @@ void vnt_get_phy_field(struct vnt_private *priv, u32 frame_length,
 	u32 count = 0;
 	u32 tmp;
 	int ext_bit;
-	u8 preamble_type = priv->byPreambleType;
+	u8 preamble_type = priv->by_preamble_type;
 
 	bit_count = frame_length * 8;
 	ext_bit = false;
diff --git a/drivers/staging/vt6655/device.h b/drivers/staging/vt6655/device.h
index 3045b2c19362..2b50cf4e2406 100644
--- a/drivers/staging/vt6655/device.h
+++ b/drivers/staging/vt6655/device.h
@@ -203,7 +203,7 @@ struct vnt_private {
 	unsigned char byMinChannel;
 	unsigned char byMaxChannel;
 
-	unsigned char byPreambleType;
+	unsigned char by_preamble_type;
 	unsigned char byShortPreamble;
 
 	unsigned short wCurrentRate;
diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 910a689c574b..cae666ed548f 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -177,11 +177,11 @@ device_set_options(struct vnt_private *priv)
 	priv->byPacketType = priv->byBBType;
 	priv->byAutoFBCtrl = AUTO_FB_0;
 	priv->bUpdateBBVGA = true;
-	priv->byPreambleType = 0;
+	priv->by_preamble_type = 0;
 
 	pr_debug(" byShortRetryLimit= %d\n", (int)priv->byShortRetryLimit);
 	pr_debug(" byLongRetryLimit= %d\n", (int)priv->byLongRetryLimit);
-	pr_debug(" byPreambleType= %d\n", (int)priv->byPreambleType);
+	pr_debug(" by_preamble_type= %d\n", (int)priv->by_preamble_type);
 	pr_debug(" byShortPreamble= %d\n", (int)priv->byShortPreamble);
 	pr_debug(" byBBType= %d\n", (int)priv->byBBType);
 }
@@ -1423,11 +1423,11 @@ static void vnt_bss_info_changed(struct ieee80211_hw *hw,
 
 	if (changed & BSS_CHANGED_ERP_PREAMBLE) {
 		if (conf->use_short_preamble) {
-			priv->byPreambleType = true;
 			MACvEnableBarkerPreambleMd(priv->port_off_set);
+			priv->by_preamble_type = true;
 		} else {
-			priv->byPreambleType = false;
 			MACvDisableBarkerPreambleMd(priv->port_off_set);
+			priv->by_preamble_type = false;
 		}
 	}
 
diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
index 109339d801c1..05068c81070d 100644
--- a/drivers/staging/vt6655/rxtx.c
+++ b/drivers/staging/vt6655/rxtx.c
@@ -142,7 +142,7 @@ s_uFillDataHead(
 
 static __le16 vnt_time_stamp_off(struct vnt_private *priv, u16 rate)
 {
-	return cpu_to_le16(wTimeStampOff[priv->byPreambleType % 2]
+	return cpu_to_le16(wTimeStampOff[priv->by_preamble_type % 2]
 							[rate % MAX_RATE]);
 }
 
@@ -163,7 +163,7 @@ s_uGetTxRsvTime(
 {
 	unsigned int uDataTime, uAckTime;
 
-	uDataTime = bb_get_frame_time(pDevice->byPreambleType, byPktType, cbFrameLength, wRate);
+	uDataTime = bb_get_frame_time(pDevice->by_preamble_type, byPktType, cbFrameLength, wRate);
 
 	if (!bNeedAck)
 		return uDataTime;
@@ -172,7 +172,7 @@ s_uGetTxRsvTime(
 	 * CCK mode  - 11b
 	 * OFDM mode - 11g 2.4G & 11a 5G
 	 */
-	uAckTime = bb_get_frame_time(pDevice->byPreambleType, byPktType, 14,
+	uAckTime = bb_get_frame_time(pDevice->by_preamble_type, byPktType, 14,
 				     byPktType == PK_TYPE_11B ?
 				     pDevice->byTopCCKBasicRate :
 				     pDevice->byTopOFDMBasicRate);
@@ -200,22 +200,22 @@ static __le16 get_rtscts_time(struct vnt_private *priv,
 	unsigned int ack_time = 0;
 	unsigned int data_time = 0;
 
-	data_time = bb_get_frame_time(priv->byPreambleType, pkt_type, frame_length, current_rate);
+	data_time = bb_get_frame_time(priv->by_preamble_type, pkt_type, frame_length, current_rate);
 	if (rts_rsvtype == 0) { /* RTSTxRrvTime_bb */
-		rts_time = bb_get_frame_time(priv->byPreambleType, pkt_type, 20, priv->byTopCCKBasicRate);
-		ack_time = bb_get_frame_time(priv->byPreambleType, pkt_type, 14, priv->byTopCCKBasicRate);
+		rts_time = bb_get_frame_time(priv->by_preamble_type, pkt_type, 20, priv->byTopCCKBasicRate);
+		ack_time = bb_get_frame_time(priv->by_preamble_type, pkt_type, 14, priv->byTopCCKBasicRate);
 		cts_time = ack_time;
 	} else if (rts_rsvtype == 1) { /* RTSTxRrvTime_ba, only in 2.4GHZ */
-		rts_time = bb_get_frame_time(priv->byPreambleType, pkt_type, 20, priv->byTopCCKBasicRate);
-		cts_time = bb_get_frame_time(priv->byPreambleType, pkt_type, 14, priv->byTopCCKBasicRate);
-		ack_time = bb_get_frame_time(priv->byPreambleType, pkt_type, 14, priv->byTopOFDMBasicRate);
+		rts_time = bb_get_frame_time(priv->by_preamble_type, pkt_type, 20, priv->byTopCCKBasicRate);
+		cts_time = bb_get_frame_time(priv->by_preamble_type, pkt_type, 14, priv->byTopCCKBasicRate);
+		ack_time = bb_get_frame_time(priv->by_preamble_type, pkt_type, 14, priv->byTopOFDMBasicRate);
 	} else if (rts_rsvtype == 2) { /* RTSTxRrvTime_aa */
-		rts_time = bb_get_frame_time(priv->byPreambleType, pkt_type, 20, priv->byTopOFDMBasicRate);
-		ack_time = bb_get_frame_time(priv->byPreambleType, pkt_type, 14, priv->byTopOFDMBasicRate);
+		rts_time = bb_get_frame_time(priv->by_preamble_type, pkt_type, 20, priv->byTopOFDMBasicRate);
+		ack_time = bb_get_frame_time(priv->by_preamble_type, pkt_type, 14, priv->byTopOFDMBasicRate);
 		cts_time = ack_time;
 	} else if (rts_rsvtype == 3) { /* CTSTxRrvTime_ba, only in 2.4GHZ */
-		cts_time = bb_get_frame_time(priv->byPreambleType, pkt_type, 14, priv->byTopCCKBasicRate);
-		ack_time = bb_get_frame_time(priv->byPreambleType, pkt_type, 14, priv->byTopOFDMBasicRate);
+		cts_time = bb_get_frame_time(priv->by_preamble_type, pkt_type, 14, priv->byTopCCKBasicRate);
+		ack_time = bb_get_frame_time(priv->by_preamble_type, pkt_type, 14, priv->byTopOFDMBasicRate);
 		rrv_time = cts_time + ack_time + data_time + 2 * priv->uSIFS;
 		return cpu_to_le16((u16)rrv_time);
 	}
@@ -255,7 +255,7 @@ s_uGetDataDuration(
 	switch (byDurType) {
 	case DATADUR_B:    /* DATADUR_B */
 		if (bNeedAck) {
-			uAckTime = bb_get_frame_time(pDevice->byPreambleType,
+			uAckTime = bb_get_frame_time(pDevice->by_preamble_type,
 						     byPktType, 14,
 						     pDevice->byTopCCKBasicRate);
 		}
@@ -273,7 +273,7 @@ s_uGetDataDuration(
 
 	case DATADUR_A:    /* DATADUR_A */
 		if (bNeedAck) {
-			uAckTime = bb_get_frame_time(pDevice->byPreambleType,
+			uAckTime = bb_get_frame_time(pDevice->by_preamble_type,
 						     byPktType, 14,
 						     pDevice->byTopOFDMBasicRate);
 		}
@@ -292,7 +292,7 @@ s_uGetDataDuration(
 	case DATADUR_A_F0:    /* DATADUR_A_F0 */
 	case DATADUR_A_F1:    /* DATADUR_A_F1 */
 		if (bNeedAck) {
-			uAckTime = bb_get_frame_time(pDevice->byPreambleType,
+			uAckTime = bb_get_frame_time(pDevice->by_preamble_type,
 						     byPktType, 14,
 						     pDevice->byTopOFDMBasicRate);
 		}
@@ -344,17 +344,17 @@ s_uGetRTSCTSDuration(
 
 	switch (byDurType) {
 	case RTSDUR_BB:    /* RTSDuration_bb */
-		uCTSTime = bb_get_frame_time(pDevice->byPreambleType, byPktType, 14, pDevice->byTopCCKBasicRate);
+		uCTSTime = bb_get_frame_time(pDevice->by_preamble_type, byPktType, 14, pDevice->byTopCCKBasicRate);
 		uDurTime = uCTSTime + 2 * pDevice->uSIFS + s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength, wRate, bNeedAck);
 		break;
 
 	case RTSDUR_BA:    /* RTSDuration_ba */
-		uCTSTime = bb_get_frame_time(pDevice->byPreambleType, byPktType, 14, pDevice->byTopCCKBasicRate);
+		uCTSTime = bb_get_frame_time(pDevice->by_preamble_type, byPktType, 14, pDevice->byTopCCKBasicRate);
 		uDurTime = uCTSTime + 2 * pDevice->uSIFS + s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength, wRate, bNeedAck);
 		break;
 
 	case RTSDUR_AA:    /* RTSDuration_aa */
-		uCTSTime = bb_get_frame_time(pDevice->byPreambleType, byPktType, 14, pDevice->byTopOFDMBasicRate);
+		uCTSTime = bb_get_frame_time(pDevice->by_preamble_type, byPktType, 14, pDevice->byTopOFDMBasicRate);
 		uDurTime = uCTSTime + 2 * pDevice->uSIFS + s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength, wRate, bNeedAck);
 		break;
 
@@ -363,7 +363,7 @@ s_uGetRTSCTSDuration(
 		break;
 
 	case RTSDUR_BA_F0: /* RTSDuration_ba_f0 */
-		uCTSTime = bb_get_frame_time(pDevice->byPreambleType, byPktType, 14, pDevice->byTopCCKBasicRate);
+		uCTSTime = bb_get_frame_time(pDevice->by_preamble_type, byPktType, 14, pDevice->byTopCCKBasicRate);
 		if ((byFBOption == AUTO_FB_0) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
 			uDurTime = uCTSTime + 2 * pDevice->uSIFS + s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength, wFB_Opt0[FB_RATE0][wRate - RATE_18M], bNeedAck);
 		else if ((byFBOption == AUTO_FB_1) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
@@ -372,7 +372,7 @@ s_uGetRTSCTSDuration(
 		break;
 
 	case RTSDUR_AA_F0: /* RTSDuration_aa_f0 */
-		uCTSTime = bb_get_frame_time(pDevice->byPreambleType, byPktType, 14, pDevice->byTopOFDMBasicRate);
+		uCTSTime = bb_get_frame_time(pDevice->by_preamble_type, byPktType, 14, pDevice->byTopOFDMBasicRate);
 		if ((byFBOption == AUTO_FB_0) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
 			uDurTime = uCTSTime + 2 * pDevice->uSIFS + s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength, wFB_Opt0[FB_RATE0][wRate - RATE_18M], bNeedAck);
 		else if ((byFBOption == AUTO_FB_1) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
@@ -381,7 +381,7 @@ s_uGetRTSCTSDuration(
 		break;
 
 	case RTSDUR_BA_F1: /* RTSDuration_ba_f1 */
-		uCTSTime = bb_get_frame_time(pDevice->byPreambleType, byPktType, 14, pDevice->byTopCCKBasicRate);
+		uCTSTime = bb_get_frame_time(pDevice->by_preamble_type, byPktType, 14, pDevice->byTopCCKBasicRate);
 		if ((byFBOption == AUTO_FB_0) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
 			uDurTime = uCTSTime + 2 * pDevice->uSIFS + s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength, wFB_Opt0[FB_RATE1][wRate - RATE_18M], bNeedAck);
 		else if ((byFBOption == AUTO_FB_1) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
@@ -390,7 +390,7 @@ s_uGetRTSCTSDuration(
 		break;
 
 	case RTSDUR_AA_F1: /* RTSDuration_aa_f1 */
-		uCTSTime = bb_get_frame_time(pDevice->byPreambleType, byPktType, 14, pDevice->byTopOFDMBasicRate);
+		uCTSTime = bb_get_frame_time(pDevice->by_preamble_type, byPktType, 14, pDevice->byTopOFDMBasicRate);
 		if ((byFBOption == AUTO_FB_0) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
 			uDurTime = uCTSTime + 2 * pDevice->uSIFS + s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength, wFB_Opt0[FB_RATE1][wRate - RATE_18M], bNeedAck);
 		else if ((byFBOption == AUTO_FB_1) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
@@ -1289,9 +1289,9 @@ int vnt_generate_fifo_header(struct vnt_private *priv, u32 dma_idx,
 		tx_buffer_head->fifo_ctl |= cpu_to_le16(FIFOCTL_LRETRY);
 
 	if (tx_rate->flags & IEEE80211_TX_RC_USE_SHORT_PREAMBLE)
-		priv->byPreambleType = PREAMBLE_SHORT;
+		priv->by_preamble_type = PREAMBLE_SHORT;
 	else
-		priv->byPreambleType = PREAMBLE_LONG;
+		priv->by_preamble_type = PREAMBLE_LONG;
 
 	if (tx_rate->flags & IEEE80211_TX_RC_USE_RTS_CTS)
 		tx_buffer_head->fifo_ctl |= cpu_to_le16(FIFOCTL_RTS);
-- 
2.25.1

