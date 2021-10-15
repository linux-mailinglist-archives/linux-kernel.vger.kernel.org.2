Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49F6D42EEBA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 12:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237973AbhJOK1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 06:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbhJOK1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 06:27:19 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16D5C061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 03:25:12 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id y3so25786422wrl.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 03:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mOeWi5xlnFBCPH8jc/sRj3hBmUj29//1OlvUdvjSAE8=;
        b=nuEN8rNjdWBltTDQVyfRBNyAJhEKcMcm7+qpr/o6hzeZuYt6ADY7X7a/q1tY+v1umf
         zuHgPtJzzLznAWjIotWOKZYVhu8T6QvrF+n8BcOYuHC5nXui5WYGJ0mAL6q3ORjuMyD/
         Ne8OhgFfwyKMf+Ie2I2E8jLnyEXuiYm05YT6VMITcIUC+E021BPVNELKLkx2X4517H6E
         xLxFW3Okl+sgYb7P6Rs5GHLnIZmObN4Hyg6Ac2K5BQN4p5wAjnh0F3Y82lZO3/uIZ8ir
         H+xkkBDhn1dLQEHztzQLeMBVgZVTBNjYORQgXATDEsAWdhCES1CdEhhF7zEUWXyYJG7T
         Vdvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mOeWi5xlnFBCPH8jc/sRj3hBmUj29//1OlvUdvjSAE8=;
        b=K8kgtqDLScy8uK/cW9YGEKGCxzfxdaw15lpZ8st1XT1nzwm0+/1wNSai3w2S80Z6hn
         gxr2qouh/cRhEBnvOKWWoS+/4BaNgLqcAj4x0A8VDdKK3VbrZk9FV2Ras3d+QnodDmyG
         Ow7ezsa35Ign0So4Ec4aDR1NFLWptAxkR+CdpkEz7otBRYrKEik/x1cOZd7bw/J5kxkv
         9TbYDquXKHRgBMircwbQKzOunyLghg+w3y71Ce8ussLEmJFG3CY5RpaejdTrEnDvk9lm
         KB3uTyOAvZPrzAO1TH8+wed3GILvNtuAmDdz0CnanqsGjOPFO29Pmc+ZCp26g/agppuJ
         Ut9Q==
X-Gm-Message-State: AOAM532ZY31A+aajUeJDg2NrygDBcCC9mF3+AemPtvAOygUMzxufCBMw
        ancQMFLDOWmL4T2iW0tMc8sm6R645QjiECfq
X-Google-Smtp-Source: ABdhPJxdhaUzHO6LgewogIoSNm8ck61Jl4xucFiS46/EMBLjYjWgJ6hLfiRxE1QBuQvC1TE8doSYMQ==
X-Received: by 2002:adf:fd4d:: with SMTP id h13mr12919823wrs.391.1634293511073;
        Fri, 15 Oct 2021 03:25:11 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4b00:f411:e700:e085:8cb7:7bf6:5d62])
        by smtp.gmail.com with ESMTPSA id o23sm4541024wms.18.2021.10.15.03.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 03:25:10 -0700 (PDT)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, forest@alittletooquiet.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH v2] staging: vt6655: Rename byPreambleType field
Date:   Fri, 15 Oct 2021 11:24:44 +0100
Message-Id: <20211015102444.90753-1-karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop Hungarian notation prefix in `byPreambleType` member of
struct vnt_private. Change it to use snake case. Update
comment for `bb_get_frame_time` to reflect that change.

Fix issue detected by checkpatch.pl:
  CHECK: Avoid CamelCase: <byPreambleType>

Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
---
 drivers/staging/vt6655/baseband.c    |  8 ++---
 drivers/staging/vt6655/baseband.h    |  2 +-
 drivers/staging/vt6655/device.h      |  2 +-
 drivers/staging/vt6655/device_main.c |  8 ++---
 drivers/staging/vt6655/rxtx.c        | 50 ++++++++++++++--------------
 5 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/staging/vt6655/baseband.c b/drivers/staging/vt6655/baseband.c
index 0bae35af6e0f..7a5f186f2598 100644
--- a/drivers/staging/vt6655/baseband.c
+++ b/drivers/staging/vt6655/baseband.c
@@ -1691,7 +1691,7 @@ static const unsigned short awc_frame_time[MAX_RATE] = {
  *
  * Parameters:
  *  In:
- *      by_preamble_type  - Preamble Type
+ *      preamble_type     - Preamble Type
  *      by_pkt_type        - PK_TYPE_11A, PK_TYPE_11B, PK_TYPE_11GB, PK_TYPE_11GA
  *      cb_frame_length   - Baseband Type
  *      tx_rate           - Tx Rate
@@ -1700,7 +1700,7 @@ static const unsigned short awc_frame_time[MAX_RATE] = {
  * Return Value: FrameTime
  *
  */
-unsigned int bb_get_frame_time(unsigned char by_preamble_type,
+unsigned int bb_get_frame_time(unsigned char preamble_type,
 			       unsigned char by_pkt_type,
 			       unsigned int cb_frame_length,
 			       unsigned short tx_rate)
@@ -1717,7 +1717,7 @@ unsigned int bb_get_frame_time(unsigned char by_preamble_type,
 	rate = (unsigned int)awc_frame_time[rate_idx];
 
 	if (rate_idx <= 3) {		    /* CCK mode */
-		if (by_preamble_type == 1) /* Short */
+		if (preamble_type == 1)     /* Short */
 			preamble = 96;
 		else
 			preamble = 192;
@@ -1764,7 +1764,7 @@ void vnt_get_phy_field(struct vnt_private *priv, u32 frame_length,
 	u32 count = 0;
 	u32 tmp;
 	int ext_bit;
-	u8 preamble_type = priv->byPreambleType;
+	u8 preamble_type = priv->preamble_type;
 
 	bit_count = frame_length * 8;
 	ext_bit = false;
diff --git a/drivers/staging/vt6655/baseband.h b/drivers/staging/vt6655/baseband.h
index 0a30afaa7cc3..15b2802ed727 100644
--- a/drivers/staging/vt6655/baseband.h
+++ b/drivers/staging/vt6655/baseband.h
@@ -44,7 +44,7 @@
 #define TOP_RATE_2M         0x00200000
 #define TOP_RATE_1M         0x00100000
 
-unsigned int bb_get_frame_time(unsigned char by_preamble_type,
+unsigned int bb_get_frame_time(unsigned char preamble_type,
 			       unsigned char by_pkt_type,
 			       unsigned int cb_frame_length,
 			       unsigned short w_rate);
diff --git a/drivers/staging/vt6655/device.h b/drivers/staging/vt6655/device.h
index 92d6f82f939f..4706bde1ec1d 100644
--- a/drivers/staging/vt6655/device.h
+++ b/drivers/staging/vt6655/device.h
@@ -203,7 +203,7 @@ struct vnt_private {
 	unsigned char byMinChannel;
 	unsigned char byMaxChannel;
 
-	unsigned char byPreambleType;
+	unsigned char preamble_type;
 	unsigned char byShortPreamble;
 
 	unsigned short wCurrentRate;
diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 24f0e346da12..212d2a287b2c 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -177,11 +177,11 @@ device_set_options(struct vnt_private *priv)
 	priv->byPacketType = priv->byBBType;
 	priv->byAutoFBCtrl = AUTO_FB_0;
 	priv->bUpdateBBVGA = true;
-	priv->byPreambleType = 0;
+	priv->preamble_type = 0;
 
 	pr_debug(" byShortRetryLimit= %d\n", (int)priv->byShortRetryLimit);
 	pr_debug(" byLongRetryLimit= %d\n", (int)priv->byLongRetryLimit);
-	pr_debug(" byPreambleType= %d\n", (int)priv->byPreambleType);
+	pr_debug(" preamble_type= %d\n", (int)priv->preamble_type);
 	pr_debug(" byShortPreamble= %d\n", (int)priv->byShortPreamble);
 	pr_debug(" byBBType= %d\n", (int)priv->byBBType);
 }
@@ -1424,10 +1424,10 @@ static void vnt_bss_info_changed(struct ieee80211_hw *hw,
 	if (changed & BSS_CHANGED_ERP_PREAMBLE) {
 		if (conf->use_short_preamble) {
 			MACvEnableBarkerPreambleMd(priv->port_offset);
-			priv->byPreambleType = true;
+			priv->preamble_type = true;
 		} else {
 			MACvDisableBarkerPreambleMd(priv->port_offset);
-			priv->byPreambleType = false;
+			priv->preamble_type = false;
 		}
 	}
 
diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
index ff0b5391ea0b..0de801b666da 100644
--- a/drivers/staging/vt6655/rxtx.c
+++ b/drivers/staging/vt6655/rxtx.c
@@ -142,7 +142,7 @@ s_uFillDataHead(
 
 static __le16 vnt_time_stamp_off(struct vnt_private *priv, u16 rate)
 {
-	return cpu_to_le16(wTimeStampOff[priv->byPreambleType % 2]
+	return cpu_to_le16(wTimeStampOff[priv->preamble_type % 2]
 							[rate % MAX_RATE]);
 }
 
@@ -163,7 +163,7 @@ s_uGetTxRsvTime(
 {
 	unsigned int uDataTime, uAckTime;
 
-	uDataTime = bb_get_frame_time(pDevice->byPreambleType, byPktType, cbFrameLength, wRate);
+	uDataTime = bb_get_frame_time(pDevice->preamble_type, byPktType, cbFrameLength, wRate);
 
 	if (!bNeedAck)
 		return uDataTime;
@@ -172,7 +172,7 @@ s_uGetTxRsvTime(
 	 * CCK mode  - 11b
 	 * OFDM mode - 11g 2.4G & 11a 5G
 	 */
-	uAckTime = bb_get_frame_time(pDevice->byPreambleType, byPktType, 14,
+	uAckTime = bb_get_frame_time(pDevice->preamble_type, byPktType, 14,
 				     byPktType == PK_TYPE_11B ?
 				     pDevice->byTopCCKBasicRate :
 				     pDevice->byTopOFDMBasicRate);
@@ -200,22 +200,22 @@ static __le16 get_rtscts_time(struct vnt_private *priv,
 	unsigned int ack_time = 0;
 	unsigned int data_time = 0;
 
-	data_time = bb_get_frame_time(priv->byPreambleType, pkt_type, frame_length, current_rate);
+	data_time = bb_get_frame_time(priv->preamble_type, pkt_type, frame_length, current_rate);
 	if (rts_rsvtype == 0) { /* RTSTxRrvTime_bb */
-		rts_time = bb_get_frame_time(priv->byPreambleType, pkt_type, 20, priv->byTopCCKBasicRate);
-		ack_time = bb_get_frame_time(priv->byPreambleType, pkt_type, 14, priv->byTopCCKBasicRate);
+		rts_time = bb_get_frame_time(priv->preamble_type, pkt_type, 20, priv->byTopCCKBasicRate);
+		ack_time = bb_get_frame_time(priv->preamble_type, pkt_type, 14, priv->byTopCCKBasicRate);
 		cts_time = ack_time;
 	} else if (rts_rsvtype == 1) { /* RTSTxRrvTime_ba, only in 2.4GHZ */
-		rts_time = bb_get_frame_time(priv->byPreambleType, pkt_type, 20, priv->byTopCCKBasicRate);
-		cts_time = bb_get_frame_time(priv->byPreambleType, pkt_type, 14, priv->byTopCCKBasicRate);
-		ack_time = bb_get_frame_time(priv->byPreambleType, pkt_type, 14, priv->byTopOFDMBasicRate);
+		rts_time = bb_get_frame_time(priv->preamble_type, pkt_type, 20, priv->byTopCCKBasicRate);
+		cts_time = bb_get_frame_time(priv->preamble_type, pkt_type, 14, priv->byTopCCKBasicRate);
+		ack_time = bb_get_frame_time(priv->preamble_type, pkt_type, 14, priv->byTopOFDMBasicRate);
 	} else if (rts_rsvtype == 2) { /* RTSTxRrvTime_aa */
-		rts_time = bb_get_frame_time(priv->byPreambleType, pkt_type, 20, priv->byTopOFDMBasicRate);
-		ack_time = bb_get_frame_time(priv->byPreambleType, pkt_type, 14, priv->byTopOFDMBasicRate);
+		rts_time = bb_get_frame_time(priv->preamble_type, pkt_type, 20, priv->byTopOFDMBasicRate);
+		ack_time = bb_get_frame_time(priv->preamble_type, pkt_type, 14, priv->byTopOFDMBasicRate);
 		cts_time = ack_time;
 	} else if (rts_rsvtype == 3) { /* CTSTxRrvTime_ba, only in 2.4GHZ */
-		cts_time = bb_get_frame_time(priv->byPreambleType, pkt_type, 14, priv->byTopCCKBasicRate);
-		ack_time = bb_get_frame_time(priv->byPreambleType, pkt_type, 14, priv->byTopOFDMBasicRate);
+		cts_time = bb_get_frame_time(priv->preamble_type, pkt_type, 14, priv->byTopCCKBasicRate);
+		ack_time = bb_get_frame_time(priv->preamble_type, pkt_type, 14, priv->byTopOFDMBasicRate);
 		rrv_time = cts_time + ack_time + data_time + 2 * priv->uSIFS;
 		return cpu_to_le16((u16)rrv_time);
 	}
@@ -255,7 +255,7 @@ s_uGetDataDuration(
 	switch (byDurType) {
 	case DATADUR_B:    /* DATADUR_B */
 		if (bNeedAck) {
-			uAckTime = bb_get_frame_time(pDevice->byPreambleType,
+			uAckTime = bb_get_frame_time(pDevice->preamble_type,
 						     byPktType, 14,
 						     pDevice->byTopCCKBasicRate);
 		}
@@ -273,7 +273,7 @@ s_uGetDataDuration(
 
 	case DATADUR_A:    /* DATADUR_A */
 		if (bNeedAck) {
-			uAckTime = bb_get_frame_time(pDevice->byPreambleType,
+			uAckTime = bb_get_frame_time(pDevice->preamble_type,
 						     byPktType, 14,
 						     pDevice->byTopOFDMBasicRate);
 		}
@@ -292,7 +292,7 @@ s_uGetDataDuration(
 	case DATADUR_A_F0:    /* DATADUR_A_F0 */
 	case DATADUR_A_F1:    /* DATADUR_A_F1 */
 		if (bNeedAck) {
-			uAckTime = bb_get_frame_time(pDevice->byPreambleType,
+			uAckTime = bb_get_frame_time(pDevice->preamble_type,
 						     byPktType, 14,
 						     pDevice->byTopOFDMBasicRate);
 		}
@@ -344,17 +344,17 @@ s_uGetRTSCTSDuration(
 
 	switch (byDurType) {
 	case RTSDUR_BB:    /* RTSDuration_bb */
-		uCTSTime = bb_get_frame_time(pDevice->byPreambleType, byPktType, 14, pDevice->byTopCCKBasicRate);
+		uCTSTime = bb_get_frame_time(pDevice->preamble_type, byPktType, 14, pDevice->byTopCCKBasicRate);
 		uDurTime = uCTSTime + 2 * pDevice->uSIFS + s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength, wRate, bNeedAck);
 		break;
 
 	case RTSDUR_BA:    /* RTSDuration_ba */
-		uCTSTime = bb_get_frame_time(pDevice->byPreambleType, byPktType, 14, pDevice->byTopCCKBasicRate);
+		uCTSTime = bb_get_frame_time(pDevice->preamble_type, byPktType, 14, pDevice->byTopCCKBasicRate);
 		uDurTime = uCTSTime + 2 * pDevice->uSIFS + s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength, wRate, bNeedAck);
 		break;
 
 	case RTSDUR_AA:    /* RTSDuration_aa */
-		uCTSTime = bb_get_frame_time(pDevice->byPreambleType, byPktType, 14, pDevice->byTopOFDMBasicRate);
+		uCTSTime = bb_get_frame_time(pDevice->preamble_type, byPktType, 14, pDevice->byTopOFDMBasicRate);
 		uDurTime = uCTSTime + 2 * pDevice->uSIFS + s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength, wRate, bNeedAck);
 		break;
 
@@ -363,7 +363,7 @@ s_uGetRTSCTSDuration(
 		break;
 
 	case RTSDUR_BA_F0: /* RTSDuration_ba_f0 */
-		uCTSTime = bb_get_frame_time(pDevice->byPreambleType, byPktType, 14, pDevice->byTopCCKBasicRate);
+		uCTSTime = bb_get_frame_time(pDevice->preamble_type, byPktType, 14, pDevice->byTopCCKBasicRate);
 		if ((byFBOption == AUTO_FB_0) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
 			uDurTime = uCTSTime + 2 * pDevice->uSIFS + s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength, wFB_Opt0[FB_RATE0][wRate - RATE_18M], bNeedAck);
 		else if ((byFBOption == AUTO_FB_1) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
@@ -372,7 +372,7 @@ s_uGetRTSCTSDuration(
 		break;
 
 	case RTSDUR_AA_F0: /* RTSDuration_aa_f0 */
-		uCTSTime = bb_get_frame_time(pDevice->byPreambleType, byPktType, 14, pDevice->byTopOFDMBasicRate);
+		uCTSTime = bb_get_frame_time(pDevice->preamble_type, byPktType, 14, pDevice->byTopOFDMBasicRate);
 		if ((byFBOption == AUTO_FB_0) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
 			uDurTime = uCTSTime + 2 * pDevice->uSIFS + s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength, wFB_Opt0[FB_RATE0][wRate - RATE_18M], bNeedAck);
 		else if ((byFBOption == AUTO_FB_1) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
@@ -381,7 +381,7 @@ s_uGetRTSCTSDuration(
 		break;
 
 	case RTSDUR_BA_F1: /* RTSDuration_ba_f1 */
-		uCTSTime = bb_get_frame_time(pDevice->byPreambleType, byPktType, 14, pDevice->byTopCCKBasicRate);
+		uCTSTime = bb_get_frame_time(pDevice->preamble_type, byPktType, 14, pDevice->byTopCCKBasicRate);
 		if ((byFBOption == AUTO_FB_0) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
 			uDurTime = uCTSTime + 2 * pDevice->uSIFS + s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength, wFB_Opt0[FB_RATE1][wRate - RATE_18M], bNeedAck);
 		else if ((byFBOption == AUTO_FB_1) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
@@ -390,7 +390,7 @@ s_uGetRTSCTSDuration(
 		break;
 
 	case RTSDUR_AA_F1: /* RTSDuration_aa_f1 */
-		uCTSTime = bb_get_frame_time(pDevice->byPreambleType, byPktType, 14, pDevice->byTopOFDMBasicRate);
+		uCTSTime = bb_get_frame_time(pDevice->preamble_type, byPktType, 14, pDevice->byTopOFDMBasicRate);
 		if ((byFBOption == AUTO_FB_0) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
 			uDurTime = uCTSTime + 2 * pDevice->uSIFS + s_uGetTxRsvTime(pDevice, byPktType, cbFrameLength, wFB_Opt0[FB_RATE1][wRate - RATE_18M], bNeedAck);
 		else if ((byFBOption == AUTO_FB_1) && (wRate >= RATE_18M) && (wRate <= RATE_54M))
@@ -1289,9 +1289,9 @@ int vnt_generate_fifo_header(struct vnt_private *priv, u32 dma_idx,
 		tx_buffer_head->fifo_ctl |= cpu_to_le16(FIFOCTL_LRETRY);
 
 	if (tx_rate->flags & IEEE80211_TX_RC_USE_SHORT_PREAMBLE)
-		priv->byPreambleType = PREAMBLE_SHORT;
+		priv->preamble_type = PREAMBLE_SHORT;
 	else
-		priv->byPreambleType = PREAMBLE_LONG;
+		priv->preamble_type = PREAMBLE_LONG;
 
 	if (tx_rate->flags & IEEE80211_TX_RC_USE_RTS_CTS)
 		tx_buffer_head->fifo_ctl |= cpu_to_le16(FIFOCTL_RTS);
-- 
2.30.2

