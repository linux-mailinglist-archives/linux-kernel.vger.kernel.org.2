Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E13F41532F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 00:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238246AbhIVWJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 18:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238197AbhIVWJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 18:09:37 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F446C061756
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 15:08:06 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id u27so15527690edi.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 15:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mud1J3LjDRPdD+jvwQMmvG1QpPLwvdDGqgmQYm5zAxI=;
        b=CJCiAH0qFpi6hDbHKWPxPlbwtwsLPlJPJ9JR1/A5MzCv3rVqqWRQy9APsY9y0gIufG
         tOdet3U3B1K4CueKvPUWcLpJuqK8wrDLnxhppNqtLFzTGqSIlUUHDfOuDK9UQL64vFIj
         gwsBj9DXCd7MSWmF+Ym2/97HcJarovIFdanD2lTMBQYsAQw0VNiJced/Lbap0P1Powno
         LSEBAszBfpQyS3aFYxnmOEGaBxoAQ46oXTDUNuBeb1s/pPgLKaFUfW2+pwI6pnFIfDKi
         mf6L4MPQJnANCb4JvEN3zyhAWkIDUpdKXKL9CVChnSkLmKJhFMxjJO5UkSb+KN1wg5yG
         pVtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mud1J3LjDRPdD+jvwQMmvG1QpPLwvdDGqgmQYm5zAxI=;
        b=qT8PRTO5hJLjT6qfhLy7u2j4IbEGo19xNuEqWs18dQyKe8C2C/IL//TKuItJlfG8ZJ
         P+yfHN5h1+b1bav3hGuHvUyy6HNA7KY+aB7LKXJ93FFBzTm1tloeGNOmTdjmXl5nkWjL
         PHo3f0z86mfS3CF0uI0DfS2aCESwFXC7yHZpEHnZqyuT8XX5XTkJKuUlPYulSDYI323R
         iTqChQGr7IPgclGWCoDO5WzEZ4xPP5CijEHwa12XbVt+kIdxCRxMXvYuf28TIQg+VqkD
         pIbygQOTMvUXZNNEGcMvgVjQPPxq5KYnJQu001UTJysASaFPaHZ3hqy3QxM42X65HRiF
         KoXg==
X-Gm-Message-State: AOAM530IotkK1g63gSmQh1a5mxji/RMDIF6eOCVAJDcXVJdOT26W4A7A
        U2iQpL2ZC/QZsdjah9OeoruhaTB1VLI=
X-Google-Smtp-Source: ABdhPJyNuwvpk4PAfoycUeuCAa2a8mpj8bt6sAo1BQUh0j8Oer6RN3d9llfk/m/9cD8XzGuK0oh8JA==
X-Received: by 2002:a05:6402:886:: with SMTP id e6mr1826993edy.41.1632348484416;
        Wed, 22 Sep 2021 15:08:04 -0700 (PDT)
Received: from tom-desktop.station (net-93-71-218-228.cust.vodafonedsl.it. [93.71.218.228])
        by smtp.gmail.com with ESMTPSA id kt19sm1705347ejb.26.2021.09.22.15.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 15:08:04 -0700 (PDT)
From:   Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     tomm.merciai@gmail.com, Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        Yujia Qiao <rapiz@foxmail.com>,
        Lucas Henneman <lucas.henneman@linaro.org>,
        Marcos Antonio de Jesus Filho <mdejesusfilho@gmail.com>,
        Edmundo Carmona Antoranz <eantoranz@gmail.com>,
        =?UTF-8?q?Aldas=20Tara=C5=A1kevi=C4=8Dius?= <aldas60@gmail.com>,
        Deepak R Varma <mh12gx2825@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] Staging: vt6655: Replace camel case variable name
Date:   Thu, 23 Sep 2021 00:07:49 +0200
Message-Id: <20210922220802.584952-1-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Work in progress: replace camel case variables

PortOffset -> port_off_set

Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
---
 drivers/staging/vt6655/baseband.c    |   6 +-
 drivers/staging/vt6655/card.c        |  88 ++++++++--------
 drivers/staging/vt6655/channel.c     |  10 +-
 drivers/staging/vt6655/device.h      |   2 +-
 drivers/staging/vt6655/device_main.c | 144 +++++++++++++--------------
 drivers/staging/vt6655/mac.c         |  46 ++++-----
 drivers/staging/vt6655/power.c       |  24 ++---
 drivers/staging/vt6655/rf.c          |  12 +--
 drivers/staging/vt6655/rxtx.c        |  12 +--
 9 files changed, 172 insertions(+), 172 deletions(-)

diff --git a/drivers/staging/vt6655/baseband.c b/drivers/staging/vt6655/baseband.c
index 93640311f8e3..20f1a839ba50 100644
--- a/drivers/staging/vt6655/baseband.c
+++ b/drivers/staging/vt6655/baseband.c
@@ -1905,7 +1905,7 @@ void vnt_get_phy_field(struct vnt_private *priv, u32 frame_length,
 bool bb_read_embedded(struct vnt_private *priv, unsigned char by_bb_addr,
 		      unsigned char *pby_data)
 {
-	void __iomem *iobase = priv->PortOffset;
+	void __iomem *iobase = priv->port_off_set;
 	unsigned short ww;
 	unsigned char by_value;
 
@@ -1948,7 +1948,7 @@ bool bb_read_embedded(struct vnt_private *priv, unsigned char by_bb_addr,
 bool bb_write_embedded(struct vnt_private *priv, unsigned char by_bb_addr,
 		       unsigned char by_data)
 {
-	void __iomem *iobase = priv->PortOffset;
+	void __iomem *iobase = priv->port_off_set;
 	unsigned short ww;
 	unsigned char by_value;
 
@@ -1992,7 +1992,7 @@ bool bb_vt3253_init(struct vnt_private *priv)
 {
 	bool result = true;
 	int        ii;
-	void __iomem *iobase = priv->PortOffset;
+	void __iomem *iobase = priv->port_off_set;
 	unsigned char by_rf_type = priv->byRFType;
 	unsigned char by_local_id = priv->byLocalID;
 
diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index 3ef3a6e0e6e1..e048216ef6c7 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -190,7 +190,7 @@ bool CARDbSetPhyParameter(struct vnt_private *priv, u8 bb_type)
 	if (bb_type == BB_TYPE_11A) {
 		if (priv->byRFType == RF_AIROHA7230) {
 			/* AL7230 use single PAPE and connect to PAPE_2.4G */
-			MACvSetBBType(priv->PortOffset, BB_TYPE_11G);
+			MACvSetBBType(priv->port_off_set, BB_TYPE_11G);
 			priv->abyBBVGA[0] = 0x20;
 			priv->abyBBVGA[2] = 0x10;
 			priv->abyBBVGA[3] = 0x10;
@@ -199,7 +199,7 @@ bool CARDbSetPhyParameter(struct vnt_private *priv, u8 bb_type)
 				bb_write_embedded(priv, 0xE7, priv->abyBBVGA[0]);
 
 		} else if (priv->byRFType == RF_UW2452) {
-			MACvSetBBType(priv->PortOffset, BB_TYPE_11A);
+			MACvSetBBType(priv->port_off_set, BB_TYPE_11A);
 			priv->abyBBVGA[0] = 0x18;
 			bb_read_embedded(priv, 0xE7, &byData);
 			if (byData == 0x14) {
@@ -207,7 +207,7 @@ bool CARDbSetPhyParameter(struct vnt_private *priv, u8 bb_type)
 				bb_write_embedded(priv, 0xE1, 0x57);
 			}
 		} else {
-			MACvSetBBType(priv->PortOffset, BB_TYPE_11A);
+			MACvSetBBType(priv->port_off_set, BB_TYPE_11A);
 		}
 		bb_write_embedded(priv, 0x88, 0x03);
 		bySlot = C_SLOT_SHORT;
@@ -215,7 +215,7 @@ bool CARDbSetPhyParameter(struct vnt_private *priv, u8 bb_type)
 		byDIFS = C_SIFS_A + 2 * C_SLOT_SHORT;
 		byCWMaxMin = 0xA4;
 	} else if (bb_type == BB_TYPE_11B) {
-		MACvSetBBType(priv->PortOffset, BB_TYPE_11B);
+		MACvSetBBType(priv->port_off_set, BB_TYPE_11B);
 		if (priv->byRFType == RF_AIROHA7230) {
 			priv->abyBBVGA[0] = 0x1C;
 			priv->abyBBVGA[2] = 0x00;
@@ -238,7 +238,7 @@ bool CARDbSetPhyParameter(struct vnt_private *priv, u8 bb_type)
 		byDIFS = C_SIFS_BG + 2 * C_SLOT_LONG;
 		byCWMaxMin = 0xA5;
 	} else { /* PK_TYPE_11GA & PK_TYPE_11GB */
-		MACvSetBBType(priv->PortOffset, BB_TYPE_11G);
+		MACvSetBBType(priv->port_off_set, BB_TYPE_11G);
 		if (priv->byRFType == RF_AIROHA7230) {
 			priv->abyBBVGA[0] = 0x1C;
 			priv->abyBBVGA[2] = 0x00;
@@ -292,25 +292,25 @@ bool CARDbSetPhyParameter(struct vnt_private *priv, u8 bb_type)
 
 	if (priv->bySIFS != bySIFS) {
 		priv->bySIFS = bySIFS;
-		VNSvOutPortB(priv->PortOffset + MAC_REG_SIFS, priv->bySIFS);
+		VNSvOutPortB(priv->port_off_set + MAC_REG_SIFS, priv->bySIFS);
 	}
 	if (priv->byDIFS != byDIFS) {
 		priv->byDIFS = byDIFS;
-		VNSvOutPortB(priv->PortOffset + MAC_REG_DIFS, priv->byDIFS);
+		VNSvOutPortB(priv->port_off_set + MAC_REG_DIFS, priv->byDIFS);
 	}
 	if (priv->byEIFS != C_EIFS) {
 		priv->byEIFS = C_EIFS;
-		VNSvOutPortB(priv->PortOffset + MAC_REG_EIFS, priv->byEIFS);
+		VNSvOutPortB(priv->port_off_set + MAC_REG_EIFS, priv->byEIFS);
 	}
 	if (priv->bySlot != bySlot) {
 		priv->bySlot = bySlot;
-		VNSvOutPortB(priv->PortOffset + MAC_REG_SLOT, priv->bySlot);
+		VNSvOutPortB(priv->port_off_set + MAC_REG_SLOT, priv->bySlot);
 
 		bb_set_short_slot_time(priv);
 	}
 	if (priv->byCWMaxMin != byCWMaxMin) {
 		priv->byCWMaxMin = byCWMaxMin;
-		VNSvOutPortB(priv->PortOffset + MAC_REG_CWMAXMIN0,
+		VNSvOutPortB(priv->port_off_set + MAC_REG_CWMAXMIN0,
 			     priv->byCWMaxMin);
 	}
 
@@ -348,11 +348,11 @@ bool CARDbUpdateTSF(struct vnt_private *priv, unsigned char byRxRate,
 		qwTSFOffset = CARDqGetTSFOffset(byRxRate, qwBSSTimestamp,
 						local_tsf);
 		/* adjust TSF, HW's TSF add TSF Offset reg */
-		VNSvOutPortD(priv->PortOffset + MAC_REG_TSFOFST,
+		VNSvOutPortD(priv->port_off_set + MAC_REG_TSFOFST,
 			     (u32)qwTSFOffset);
-		VNSvOutPortD(priv->PortOffset + MAC_REG_TSFOFST + 4,
+		VNSvOutPortD(priv->port_off_set + MAC_REG_TSFOFST + 4,
 			     (u32)(qwTSFOffset >> 32));
-		MACvRegBitsOn(priv->PortOffset, MAC_REG_TFTCTL,
+		MACvRegBitsOn(priv->port_off_set, MAC_REG_TFTCTL,
 			      TFTCTL_TSFSYNCEN);
 	}
 	return true;
@@ -381,13 +381,13 @@ bool CARDbSetBeaconPeriod(struct vnt_private *priv,
 	qwNextTBTT = CARDqGetNextTBTT(qwNextTBTT, wBeaconInterval);
 
 	/* set HW beacon interval */
-	VNSvOutPortW(priv->PortOffset + MAC_REG_BI, wBeaconInterval);
+	VNSvOutPortW(priv->port_off_set + MAC_REG_BI, wBeaconInterval);
 	priv->wBeaconInterval = wBeaconInterval;
 	/* Set NextTBTT */
-	VNSvOutPortD(priv->PortOffset + MAC_REG_NEXTTBTT, (u32)qwNextTBTT);
-	VNSvOutPortD(priv->PortOffset + MAC_REG_NEXTTBTT + 4,
+	VNSvOutPortD(priv->port_off_set + MAC_REG_NEXTTBTT, (u32)qwNextTBTT);
+	VNSvOutPortD(priv->port_off_set + MAC_REG_NEXTTBTT + 4,
 		     (u32)(qwNextTBTT >> 32));
-	MACvRegBitsOn(priv->PortOffset, MAC_REG_TFTCTL, TFTCTL_TBTTSYNCEN);
+	MACvRegBitsOn(priv->port_off_set, MAC_REG_TFTCTL, TFTCTL_TBTTSYNCEN);
 
 	return true;
 }
@@ -409,29 +409,29 @@ void CARDbRadioPowerOff(struct vnt_private *priv)
 
 	switch (priv->byRFType) {
 	case RF_RFMD2959:
-		MACvWordRegBitsOff(priv->PortOffset, MAC_REG_SOFTPWRCTL,
+		MACvWordRegBitsOff(priv->port_off_set, MAC_REG_SOFTPWRCTL,
 				   SOFTPWRCTL_TXPEINV);
-		MACvWordRegBitsOn(priv->PortOffset, MAC_REG_SOFTPWRCTL,
+		MACvWordRegBitsOn(priv->port_off_set, MAC_REG_SOFTPWRCTL,
 				  SOFTPWRCTL_SWPE1);
 		break;
 
 	case RF_AIROHA:
 	case RF_AL2230S:
 	case RF_AIROHA7230:
-		MACvWordRegBitsOff(priv->PortOffset, MAC_REG_SOFTPWRCTL,
+		MACvWordRegBitsOff(priv->port_off_set, MAC_REG_SOFTPWRCTL,
 				   SOFTPWRCTL_SWPE2);
-		MACvWordRegBitsOff(priv->PortOffset, MAC_REG_SOFTPWRCTL,
+		MACvWordRegBitsOff(priv->port_off_set, MAC_REG_SOFTPWRCTL,
 				   SOFTPWRCTL_SWPE3);
 		break;
 	}
 
-	MACvRegBitsOff(priv->PortOffset, MAC_REG_HOSTCR, HOSTCR_RXON);
+	MACvRegBitsOff(priv->port_off_set, MAC_REG_HOSTCR, HOSTCR_RXON);
 
 	bb_set_deep_sleep(priv, priv->byLocalID);
 
 	priv->bRadioOff = true;
 	pr_debug("chester power off\n");
-	MACvRegBitsOn(priv->PortOffset, MAC_REG_GPIOCTL0,
+	MACvRegBitsOn(priv->port_off_set, MAC_REG_GPIOCTL0,
 		      LED_ACTSET);  /* LED issue */
 }
 
@@ -467,7 +467,7 @@ void CARDvSafeResetTx(struct vnt_private *priv)
 	MACvSetCurrTXDescAddr(TYPE_AC0DMA, priv, priv->td1_pool_dma);
 
 	/* set MAC Beacon TX pointer */
-	MACvSetCurrBCNTxDescAddr(priv->PortOffset,
+	MACvSetCurrBCNTxDescAddr(priv->port_off_set,
 				 (priv->tx_beacon_dma));
 }
 
@@ -509,8 +509,8 @@ void CARDvSafeResetRx(struct vnt_private *priv)
 	}
 
 	/* set perPkt mode */
-	MACvRx0PerPktMode(priv->PortOffset);
-	MACvRx1PerPktMode(priv->PortOffset);
+	MACvRx0PerPktMode(priv->port_off_set);
+	MACvRx1PerPktMode(priv->port_off_set);
 	/* set MAC RD pointer */
 	MACvSetCurrRx0DescAddr(priv, priv->rd0_pool_dma);
 
@@ -599,7 +599,7 @@ void CARDvSetRSPINF(struct vnt_private *priv, u8 bb_type)
 	spin_lock_irqsave(&priv->lock, flags);
 
 	/* Set to Page1 */
-	MACvSelectPage1(priv->PortOffset);
+	MACvSelectPage1(priv->port_off_set);
 
 	/* RSPINF_b_1 */
 	vnt_get_phy_field(priv, 14,
@@ -609,7 +609,7 @@ void CARDvSetRSPINF(struct vnt_private *priv, u8 bb_type)
 	 /* swap over to get correct write order */
 	swap(phy.swap[0], phy.swap[1]);
 
-	VNSvOutPortD(priv->PortOffset + MAC_REG_RSPINF_B_1, phy.field_write);
+	VNSvOutPortD(priv->port_off_set + MAC_REG_RSPINF_B_1, phy.field_write);
 
 	/* RSPINF_b_2 */
 	vnt_get_phy_field(priv, 14,
@@ -618,7 +618,7 @@ void CARDvSetRSPINF(struct vnt_private *priv, u8 bb_type)
 
 	swap(phy.swap[0], phy.swap[1]);
 
-	VNSvOutPortD(priv->PortOffset + MAC_REG_RSPINF_B_2, phy.field_write);
+	VNSvOutPortD(priv->port_off_set + MAC_REG_RSPINF_B_2, phy.field_write);
 
 	/* RSPINF_b_5 */
 	vnt_get_phy_field(priv, 14,
@@ -627,7 +627,7 @@ void CARDvSetRSPINF(struct vnt_private *priv, u8 bb_type)
 
 	swap(phy.swap[0], phy.swap[1]);
 
-	VNSvOutPortD(priv->PortOffset + MAC_REG_RSPINF_B_5, phy.field_write);
+	VNSvOutPortD(priv->port_off_set + MAC_REG_RSPINF_B_5, phy.field_write);
 
 	/* RSPINF_b_11 */
 	vnt_get_phy_field(priv, 14,
@@ -636,42 +636,42 @@ void CARDvSetRSPINF(struct vnt_private *priv, u8 bb_type)
 
 	swap(phy.swap[0], phy.swap[1]);
 
-	VNSvOutPortD(priv->PortOffset + MAC_REG_RSPINF_B_11, phy.field_write);
+	VNSvOutPortD(priv->port_off_set + MAC_REG_RSPINF_B_11, phy.field_write);
 
 	/* RSPINF_a_6 */
 	s_vCalculateOFDMRParameter(RATE_6M,
 				   bb_type,
 				   &byTxRate,
 				   &byRsvTime);
-	VNSvOutPortW(priv->PortOffset + MAC_REG_RSPINF_A_6,
+	VNSvOutPortW(priv->port_off_set + MAC_REG_RSPINF_A_6,
 		     MAKEWORD(byTxRate, byRsvTime));
 	/* RSPINF_a_9 */
 	s_vCalculateOFDMRParameter(RATE_9M,
 				   bb_type,
 				   &byTxRate,
 				   &byRsvTime);
-	VNSvOutPortW(priv->PortOffset + MAC_REG_RSPINF_A_9,
+	VNSvOutPortW(priv->port_off_set + MAC_REG_RSPINF_A_9,
 		     MAKEWORD(byTxRate, byRsvTime));
 	/* RSPINF_a_12 */
 	s_vCalculateOFDMRParameter(RATE_12M,
 				   bb_type,
 				   &byTxRate,
 				   &byRsvTime);
-	VNSvOutPortW(priv->PortOffset + MAC_REG_RSPINF_A_12,
+	VNSvOutPortW(priv->port_off_set + MAC_REG_RSPINF_A_12,
 		     MAKEWORD(byTxRate, byRsvTime));
 	/* RSPINF_a_18 */
 	s_vCalculateOFDMRParameter(RATE_18M,
 				   bb_type,
 				   &byTxRate,
 				   &byRsvTime);
-	VNSvOutPortW(priv->PortOffset + MAC_REG_RSPINF_A_18,
+	VNSvOutPortW(priv->port_off_set + MAC_REG_RSPINF_A_18,
 		     MAKEWORD(byTxRate, byRsvTime));
 	/* RSPINF_a_24 */
 	s_vCalculateOFDMRParameter(RATE_24M,
 				   bb_type,
 				   &byTxRate,
 				   &byRsvTime);
-	VNSvOutPortW(priv->PortOffset + MAC_REG_RSPINF_A_24,
+	VNSvOutPortW(priv->port_off_set + MAC_REG_RSPINF_A_24,
 		     MAKEWORD(byTxRate, byRsvTime));
 	/* RSPINF_a_36 */
 	s_vCalculateOFDMRParameter(CARDwGetOFDMControlRate((void *)priv,
@@ -679,7 +679,7 @@ void CARDvSetRSPINF(struct vnt_private *priv, u8 bb_type)
 				   bb_type,
 				   &byTxRate,
 				   &byRsvTime);
-	VNSvOutPortW(priv->PortOffset + MAC_REG_RSPINF_A_36,
+	VNSvOutPortW(priv->port_off_set + MAC_REG_RSPINF_A_36,
 		     MAKEWORD(byTxRate, byRsvTime));
 	/* RSPINF_a_48 */
 	s_vCalculateOFDMRParameter(CARDwGetOFDMControlRate((void *)priv,
@@ -687,7 +687,7 @@ void CARDvSetRSPINF(struct vnt_private *priv, u8 bb_type)
 				   bb_type,
 				   &byTxRate,
 				   &byRsvTime);
-	VNSvOutPortW(priv->PortOffset + MAC_REG_RSPINF_A_48,
+	VNSvOutPortW(priv->port_off_set + MAC_REG_RSPINF_A_48,
 		     MAKEWORD(byTxRate, byRsvTime));
 	/* RSPINF_a_54 */
 	s_vCalculateOFDMRParameter(CARDwGetOFDMControlRate((void *)priv,
@@ -695,7 +695,7 @@ void CARDvSetRSPINF(struct vnt_private *priv, u8 bb_type)
 				   bb_type,
 				   &byTxRate,
 				   &byRsvTime);
-	VNSvOutPortW(priv->PortOffset + MAC_REG_RSPINF_A_54,
+	VNSvOutPortW(priv->port_off_set + MAC_REG_RSPINF_A_54,
 		     MAKEWORD(byTxRate, byRsvTime));
 	/* RSPINF_a_72 */
 	s_vCalculateOFDMRParameter(CARDwGetOFDMControlRate((void *)priv,
@@ -703,10 +703,10 @@ void CARDvSetRSPINF(struct vnt_private *priv, u8 bb_type)
 				   bb_type,
 				   &byTxRate,
 				   &byRsvTime);
-	VNSvOutPortW(priv->PortOffset + MAC_REG_RSPINF_A_72,
+	VNSvOutPortW(priv->port_off_set + MAC_REG_RSPINF_A_72,
 		     MAKEWORD(byTxRate, byRsvTime));
 	/* Set to Page0 */
-	MACvSelectPage0(priv->PortOffset);
+	MACvSelectPage0(priv->port_off_set);
 
 	spin_unlock_irqrestore(&priv->lock, flags);
 }
@@ -796,7 +796,7 @@ u64 CARDqGetTSFOffset(unsigned char byRxRate, u64 qwTSF1, u64 qwTSF2)
  */
 bool CARDbGetCurrentTSF(struct vnt_private *priv, u64 *pqwCurrTSF)
 {
-	void __iomem *iobase = priv->PortOffset;
+	void __iomem *iobase = priv->port_off_set;
 	unsigned short ww;
 	unsigned char byData;
 
@@ -857,7 +857,7 @@ u64 CARDqGetNextTBTT(u64 qwTSF, unsigned short wBeaconInterval)
 void CARDvSetFirstNextTBTT(struct vnt_private *priv,
 			   unsigned short wBeaconInterval)
 {
-	void __iomem *iobase = priv->PortOffset;
+	void __iomem *iobase = priv->port_off_set;
 	u64 qwNextTBTT = 0;
 
 	CARDbGetCurrentTSF(priv, &qwNextTBTT); /* Get Local TSF counter */
@@ -886,7 +886,7 @@ void CARDvSetFirstNextTBTT(struct vnt_private *priv,
 void CARDvUpdateNextTBTT(struct vnt_private *priv, u64 qwTSF,
 			 unsigned short wBeaconInterval)
 {
-	void __iomem *iobase = priv->PortOffset;
+	void __iomem *iobase = priv->port_off_set;
 
 	qwTSF = CARDqGetNextTBTT(qwTSF, wBeaconInterval);
 	/* Set NextTBTT */
diff --git a/drivers/staging/vt6655/channel.c b/drivers/staging/vt6655/channel.c
index 52b6538a201a..8f2ea280d4c1 100644
--- a/drivers/staging/vt6655/channel.c
+++ b/drivers/staging/vt6655/channel.c
@@ -173,7 +173,7 @@ bool set_channel(struct vnt_private *priv, struct ieee80211_channel *ch)
 	}
 
 	/* clear NAV */
-	MACvRegBitsOn(priv->PortOffset, MAC_REG_MACCR, MACCR_CLRNAV);
+	MACvRegBitsOn(priv->port_off_set, MAC_REG_MACCR, MACCR_CLRNAV);
 
 	/* TX_PE will reserve 3 us for MAX2829 A mode only,
 	 * it is for better TX throughput
@@ -199,14 +199,14 @@ bool set_channel(struct vnt_private *priv, struct ieee80211_channel *ch)
 		spin_lock_irqsave(&priv->lock, flags);
 
 		/* set HW default power register */
-		MACvSelectPage1(priv->PortOffset);
+		MACvSelectPage1(priv->port_off_set);
 		RFbSetPower(priv, RATE_1M, priv->byCurrentCh);
-		VNSvOutPortB(priv->PortOffset + MAC_REG_PWRCCK,
+		VNSvOutPortB(priv->port_off_set + MAC_REG_PWRCCK,
 			     priv->byCurPwr);
 		RFbSetPower(priv, RATE_6M, priv->byCurrentCh);
-		VNSvOutPortB(priv->PortOffset + MAC_REG_PWROFDM,
+		VNSvOutPortB(priv->port_off_set + MAC_REG_PWROFDM,
 			     priv->byCurPwr);
-		MACvSelectPage0(priv->PortOffset);
+		MACvSelectPage0(priv->port_off_set);
 
 		spin_unlock_irqrestore(&priv->lock, flags);
 	}
diff --git a/drivers/staging/vt6655/device.h b/drivers/staging/vt6655/device.h
index 2af769174e33..3045b2c19362 100644
--- a/drivers/staging/vt6655/device.h
+++ b/drivers/staging/vt6655/device.h
@@ -124,7 +124,7 @@ struct vnt_private {
 	unsigned char *tx1_bufs;
 	unsigned char *tx_beacon_bufs;
 
-	void __iomem                *PortOffset;
+	void __iomem                *port_off_set;
 	u32                         memaddr;
 	u32                         ioaddr;
 
diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index d40c2ac14928..910a689c574b 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -219,11 +219,11 @@ static void device_init_registers(struct vnt_private *priv)
 	MACvInitialize(priv);
 
 	/* Get Local ID */
-	VNSvInPortB(priv->PortOffset + MAC_REG_LOCALID, &priv->byLocalID);
+	VNSvInPortB(priv->port_off_set + MAC_REG_LOCALID, &priv->byLocalID);
 
 	spin_lock_irqsave(&priv->lock, flags);
 
-	SROMvReadAllContents(priv->PortOffset, priv->abyEEPROM);
+	SROMvReadAllContents(priv->port_off_set, priv->abyEEPROM);
 
 	spin_unlock_irqrestore(&priv->lock, flags);
 
@@ -232,7 +232,7 @@ static void device_init_registers(struct vnt_private *priv)
 	priv->byMaxChannel = CB_MAX_CHANNEL;
 
 	/* Get Antena */
-	byValue = SROMbyReadEmbedded(priv->PortOffset, EEP_OFS_ANTENNA);
+	byValue = SROMbyReadEmbedded(priv->port_off_set, EEP_OFS_ANTENNA);
 	if (byValue & EEP_ANTINV)
 		priv->bTxRxAntInv = true;
 	else
@@ -292,20 +292,20 @@ static void device_init_registers(struct vnt_private *priv)
 
 	/* Get Desire Power Value */
 	priv->byCurPwr = 0xFF;
-	priv->byCCKPwr = SROMbyReadEmbedded(priv->PortOffset, EEP_OFS_PWR_CCK);
-	priv->byOFDMPwrG = SROMbyReadEmbedded(priv->PortOffset,
+	priv->byCCKPwr = SROMbyReadEmbedded(priv->port_off_set, EEP_OFS_PWR_CCK);
+	priv->byOFDMPwrG = SROMbyReadEmbedded(priv->port_off_set,
 					      EEP_OFS_PWR_OFDMG);
 
 	/* Load power Table */
 	for (ii = 0; ii < CB_MAX_CHANNEL_24G; ii++) {
 		priv->abyCCKPwrTbl[ii + 1] =
-			SROMbyReadEmbedded(priv->PortOffset,
+			SROMbyReadEmbedded(priv->port_off_set,
 					   (unsigned char)(ii + EEP_OFS_CCK_PWR_TBL));
 		if (priv->abyCCKPwrTbl[ii + 1] == 0)
 			priv->abyCCKPwrTbl[ii + 1] = priv->byCCKPwr;
 
 		priv->abyOFDMPwrTbl[ii + 1] =
-			SROMbyReadEmbedded(priv->PortOffset,
+			SROMbyReadEmbedded(priv->port_off_set,
 					   (unsigned char)(ii + EEP_OFS_OFDM_PWR_TBL));
 		if (priv->abyOFDMPwrTbl[ii + 1] == 0)
 			priv->abyOFDMPwrTbl[ii + 1] = priv->byOFDMPwrG;
@@ -323,25 +323,25 @@ static void device_init_registers(struct vnt_private *priv)
 	/* Load OFDM A Power Table */
 	for (ii = 0; ii < CB_MAX_CHANNEL_5G; ii++) {
 		priv->abyOFDMPwrTbl[ii + CB_MAX_CHANNEL_24G + 1] =
-			SROMbyReadEmbedded(priv->PortOffset,
+			SROMbyReadEmbedded(priv->port_off_set,
 					   (unsigned char)(ii + EEP_OFS_OFDMA_PWR_TBL));
 
 		priv->abyOFDMDefaultPwr[ii + CB_MAX_CHANNEL_24G + 1] =
-			SROMbyReadEmbedded(priv->PortOffset,
+			SROMbyReadEmbedded(priv->port_off_set,
 					   (unsigned char)(ii + EEP_OFS_OFDMA_PWR_dBm));
 	}
 
 	if (priv->byLocalID > REV_ID_VT3253_B1) {
-		MACvSelectPage1(priv->PortOffset);
+		MACvSelectPage1(priv->port_off_set);
 
-		VNSvOutPortB(priv->PortOffset + MAC_REG_MSRCTL + 1,
+		VNSvOutPortB(priv->port_off_set + MAC_REG_MSRCTL + 1,
 			     (MSRCTL1_TXPWR | MSRCTL1_CSAPAREN));
 
-		MACvSelectPage0(priv->PortOffset);
+		MACvSelectPage0(priv->port_off_set);
 	}
 
 	/* use relative tx timeout and 802.11i D4 */
-	MACvWordRegBitsOn(priv->PortOffset,
+	MACvWordRegBitsOn(priv->port_off_set,
 			  MAC_REG_CFG, (CFG_TKIPOPT | CFG_NOTXTIMEOUT));
 
 	/* set performance parameter by registry */
@@ -349,9 +349,9 @@ static void device_init_registers(struct vnt_private *priv)
 	MACvSetLongRetryLimit(priv, priv->byLongRetryLimit);
 
 	/* reset TSF counter */
-	VNSvOutPortB(priv->PortOffset + MAC_REG_TFTCTL, TFTCTL_TSFCNTRST);
+	VNSvOutPortB(priv->port_off_set + MAC_REG_TFTCTL, TFTCTL_TSFCNTRST);
 	/* enable TSF counter */
-	VNSvOutPortB(priv->PortOffset + MAC_REG_TFTCTL, TFTCTL_TSFCNTREN);
+	VNSvOutPortB(priv->port_off_set + MAC_REG_TFTCTL, TFTCTL_TSFCNTREN);
 
 	/* initialize BBP registers */
 	bb_vt3253_init(priv);
@@ -371,13 +371,13 @@ static void device_init_registers(struct vnt_private *priv)
 
 	priv->bRadioOff = false;
 
-	priv->byRadioCtl = SROMbyReadEmbedded(priv->PortOffset,
+	priv->byRadioCtl = SROMbyReadEmbedded(priv->port_off_set,
 					      EEP_OFS_RADIOCTL);
 	priv->bHWRadioOff = false;
 
 	if (priv->byRadioCtl & EEP_RADIOCTL_ENABLE) {
 		/* Get GPIO */
-		MACvGPIOIn(priv->PortOffset, &priv->byGPIO);
+		MACvGPIOIn(priv->port_off_set, &priv->byGPIO);
 
 		if (((priv->byGPIO & GPIO0_DATA) &&
 		     !(priv->byRadioCtl & EEP_RADIOCTL_INV)) ||
@@ -390,7 +390,7 @@ static void device_init_registers(struct vnt_private *priv)
 		CARDbRadioPowerOff(priv);
 
 	/* get Permanent network address */
-	SROMvReadEtherAddress(priv->PortOffset, priv->abyCurrentNetAddr);
+	SROMvReadEtherAddress(priv->port_off_set, priv->abyCurrentNetAddr);
 	pr_debug("Network address = %pM\n", priv->abyCurrentNetAddr);
 
 	/* reset Tx pointer */
@@ -399,21 +399,21 @@ static void device_init_registers(struct vnt_private *priv)
 	CARDvSafeResetTx(priv);
 
 	if (priv->byLocalID <= REV_ID_VT3253_A1)
-		MACvRegBitsOn(priv->PortOffset, MAC_REG_RCR, RCR_WPAERR);
+		MACvRegBitsOn(priv->port_off_set, MAC_REG_RCR, RCR_WPAERR);
 
 	/* Turn On Rx DMA */
-	MACvReceive0(priv->PortOffset);
-	MACvReceive1(priv->PortOffset);
+	MACvReceive0(priv->port_off_set);
+	MACvReceive1(priv->port_off_set);
 
 	/* start the adapter */
-	MACvStart(priv->PortOffset);
+	MACvStart(priv->port_off_set);
 }
 
 static void device_print_info(struct vnt_private *priv)
 {
 	dev_info(&priv->pcid->dev, "MAC=%pM IO=0x%lx Mem=0x%lx IRQ=%d\n",
 		 priv->abyCurrentNetAddr, (unsigned long)priv->ioaddr,
-		 (unsigned long)priv->PortOffset, priv->pcid->irq);
+		 (unsigned long)priv->port_off_set, priv->pcid->irq);
 }
 
 static void device_free_info(struct vnt_private *priv)
@@ -424,8 +424,8 @@ static void device_free_info(struct vnt_private *priv)
 	if (priv->mac_hw)
 		ieee80211_unregister_hw(priv->hw);
 
-	if (priv->PortOffset)
-		iounmap(priv->PortOffset);
+	if (priv->port_off_set)
+		iounmap(priv->port_off_set);
 
 	if (priv->pcid)
 		pci_release_regions(priv->pcid);
@@ -1029,7 +1029,7 @@ static void vnt_interrupt_process(struct vnt_private *priv)
 	u32 isr;
 	unsigned long flags;
 
-	MACvReadISR(priv->PortOffset, &isr);
+	MACvReadISR(priv->port_off_set, &isr);
 
 	if (isr == 0)
 		return;
@@ -1042,7 +1042,7 @@ static void vnt_interrupt_process(struct vnt_private *priv)
 	spin_lock_irqsave(&priv->lock, flags);
 
 	/* Read low level stats */
-	MACvReadMIBCounter(priv->PortOffset, &mib_counter);
+	MACvReadMIBCounter(priv->port_off_set, &mib_counter);
 
 	low_stats->dot11RTSSuccessCount += mib_counter & 0xff;
 	low_stats->dot11RTSFailureCount += (mib_counter >> 8) & 0xff;
@@ -1056,12 +1056,12 @@ static void vnt_interrupt_process(struct vnt_private *priv)
 	 * update ISR counter
 	 */
 	while (isr && priv->vif) {
-		MACvWriteISR(priv->PortOffset, isr);
+		MACvWriteISR(priv->port_off_set, isr);
 
 		if (isr & ISR_FETALERR) {
 			pr_debug(" ISR_FETALERR\n");
-			VNSvOutPortB(priv->PortOffset + MAC_REG_SOFTPWRCTL, 0);
-			VNSvOutPortW(priv->PortOffset +
+			VNSvOutPortB(priv->port_off_set + MAC_REG_SOFTPWRCTL, 0);
+			VNSvOutPortW(priv->port_off_set +
 				     MAC_REG_SOFTPWRCTL, SOFTPWRCTL_SWPECTI);
 			device_error(priv, isr);
 		}
@@ -1116,10 +1116,10 @@ static void vnt_interrupt_process(struct vnt_private *priv)
 		    ieee80211_queue_stopped(priv->hw, 0))
 			ieee80211_wake_queues(priv->hw);
 
-		MACvReadISR(priv->PortOffset, &isr);
+		MACvReadISR(priv->port_off_set, &isr);
 
-		MACvReceive0(priv->PortOffset);
-		MACvReceive1(priv->PortOffset);
+		MACvReceive0(priv->port_off_set);
+		MACvReceive1(priv->port_off_set);
 
 		if (max_count > priv->opts.int_works)
 			break;
@@ -1136,7 +1136,7 @@ static void vnt_interrupt_work(struct work_struct *work)
 	if (priv->vif)
 		vnt_interrupt_process(priv);
 
-	MACvIntEnable(priv->PortOffset, IMR_MASK_VALUE);
+	MACvIntEnable(priv->port_off_set, IMR_MASK_VALUE);
 }
 
 static irqreturn_t vnt_interrupt(int irq,  void *arg)
@@ -1145,7 +1145,7 @@ static irqreturn_t vnt_interrupt(int irq,  void *arg)
 
 	schedule_work(&priv->interrupt_work);
 
-	MACvIntDisable(priv->PortOffset);
+	MACvIntDisable(priv->port_off_set);
 
 	return IRQ_HANDLED;
 }
@@ -1201,9 +1201,9 @@ static int vnt_tx_packet(struct vnt_private *priv, struct sk_buff *skb)
 	wmb(); /* second memory barrier */
 
 	if (head_td->td_info->flags & TD_FLAGS_NETIF_SKB)
-		MACvTransmitAC0(priv->PortOffset);
+		MACvTransmitAC0(priv->port_off_set);
 	else
-		MACvTransmit0(priv->PortOffset);
+		MACvTransmit0(priv->port_off_set);
 
 	priv->iTDUsed[dma_idx]++;
 
@@ -1255,7 +1255,7 @@ static int vnt_start(struct ieee80211_hw *hw)
 	device_init_registers(priv);
 
 	dev_dbg(&priv->pcid->dev, "call MACvIntEnable\n");
-	MACvIntEnable(priv->PortOffset, IMR_MASK_VALUE);
+	MACvIntEnable(priv->port_off_set, IMR_MASK_VALUE);
 
 	ieee80211_wake_queues(hw);
 
@@ -1305,15 +1305,15 @@ static int vnt_add_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	case NL80211_IFTYPE_STATION:
 		break;
 	case NL80211_IFTYPE_ADHOC:
-		MACvRegBitsOff(priv->PortOffset, MAC_REG_RCR, RCR_UNICAST);
+		MACvRegBitsOff(priv->port_off_set, MAC_REG_RCR, RCR_UNICAST);
 
-		MACvRegBitsOn(priv->PortOffset, MAC_REG_HOSTCR, HOSTCR_ADHOC);
+		MACvRegBitsOn(priv->port_off_set, MAC_REG_HOSTCR, HOSTCR_ADHOC);
 
 		break;
 	case NL80211_IFTYPE_AP:
-		MACvRegBitsOff(priv->PortOffset, MAC_REG_RCR, RCR_UNICAST);
+		MACvRegBitsOff(priv->port_off_set, MAC_REG_RCR, RCR_UNICAST);
 
-		MACvRegBitsOn(priv->PortOffset, MAC_REG_HOSTCR, HOSTCR_AP);
+		MACvRegBitsOn(priv->port_off_set, MAC_REG_HOSTCR, HOSTCR_AP);
 
 		break;
 	default:
@@ -1334,16 +1334,16 @@ static void vnt_remove_interface(struct ieee80211_hw *hw,
 	case NL80211_IFTYPE_STATION:
 		break;
 	case NL80211_IFTYPE_ADHOC:
-		MACvRegBitsOff(priv->PortOffset, MAC_REG_TCR, TCR_AUTOBCNTX);
-		MACvRegBitsOff(priv->PortOffset,
+		MACvRegBitsOff(priv->port_off_set, MAC_REG_TCR, TCR_AUTOBCNTX);
+		MACvRegBitsOff(priv->port_off_set,
 			       MAC_REG_TFTCTL, TFTCTL_TSFCNTREN);
-		MACvRegBitsOff(priv->PortOffset, MAC_REG_HOSTCR, HOSTCR_ADHOC);
+		MACvRegBitsOff(priv->port_off_set, MAC_REG_HOSTCR, HOSTCR_ADHOC);
 		break;
 	case NL80211_IFTYPE_AP:
-		MACvRegBitsOff(priv->PortOffset, MAC_REG_TCR, TCR_AUTOBCNTX);
-		MACvRegBitsOff(priv->PortOffset,
+		MACvRegBitsOff(priv->port_off_set, MAC_REG_TCR, TCR_AUTOBCNTX);
+		MACvRegBitsOff(priv->port_off_set,
 			       MAC_REG_TFTCTL, TFTCTL_TSFCNTREN);
-		MACvRegBitsOff(priv->PortOffset, MAC_REG_HOSTCR, HOSTCR_AP);
+		MACvRegBitsOff(priv->port_off_set, MAC_REG_HOSTCR, HOSTCR_AP);
 		break;
 	default:
 		break;
@@ -1407,7 +1407,7 @@ static void vnt_bss_info_changed(struct ieee80211_hw *hw,
 
 		spin_lock_irqsave(&priv->lock, flags);
 
-		MACvWriteBSSIDAddress(priv->PortOffset, (u8 *)conf->bssid);
+		MACvWriteBSSIDAddress(priv->port_off_set, (u8 *)conf->bssid);
 
 		spin_unlock_irqrestore(&priv->lock, flags);
 	}
@@ -1423,19 +1423,19 @@ static void vnt_bss_info_changed(struct ieee80211_hw *hw,
 
 	if (changed & BSS_CHANGED_ERP_PREAMBLE) {
 		if (conf->use_short_preamble) {
-			MACvEnableBarkerPreambleMd(priv->PortOffset);
 			priv->byPreambleType = true;
+			MACvEnableBarkerPreambleMd(priv->port_off_set);
 		} else {
-			MACvDisableBarkerPreambleMd(priv->PortOffset);
 			priv->byPreambleType = false;
+			MACvDisableBarkerPreambleMd(priv->port_off_set);
 		}
 	}
 
 	if (changed & BSS_CHANGED_ERP_CTS_PROT) {
 		if (conf->use_cts_prot)
-			MACvEnableProtectMD(priv->PortOffset);
+			MACvEnableProtectMD(priv->port_off_set);
 		else
-			MACvDisableProtectMD(priv->PortOffset);
+			MACvDisableProtectMD(priv->port_off_set);
 	}
 
 	if (changed & BSS_CHANGED_ERP_SLOT) {
@@ -1459,10 +1459,10 @@ static void vnt_bss_info_changed(struct ieee80211_hw *hw,
 		if (conf->enable_beacon) {
 			vnt_beacon_enable(priv, vif, conf);
 
-			MACvRegBitsOn(priv->PortOffset, MAC_REG_TCR,
+			MACvRegBitsOn(priv->port_off_set, MAC_REG_TCR,
 				      TCR_AUTOBCNTX);
 		} else {
-			MACvRegBitsOff(priv->PortOffset, MAC_REG_TCR,
+			MACvRegBitsOff(priv->port_off_set, MAC_REG_TCR,
 				       TCR_AUTOBCNTX);
 		}
 	}
@@ -1477,9 +1477,9 @@ static void vnt_bss_info_changed(struct ieee80211_hw *hw,
 
 			CARDvSetFirstNextTBTT(priv, conf->beacon_int);
 		} else {
-			VNSvOutPortB(priv->PortOffset + MAC_REG_TFTCTL,
+			VNSvOutPortB(priv->port_off_set + MAC_REG_TFTCTL,
 				     TFTCTL_TSFCNTRST);
-			VNSvOutPortB(priv->PortOffset + MAC_REG_TFTCTL,
+			VNSvOutPortB(priv->port_off_set + MAC_REG_TFTCTL,
 				     TFTCTL_TSFCNTREN);
 		}
 	}
@@ -1513,7 +1513,7 @@ static void vnt_configure(struct ieee80211_hw *hw,
 
 	*total_flags &= FIF_ALLMULTI | FIF_OTHER_BSS | FIF_BCN_PRBRESP_PROMISC;
 
-	VNSvInPortB(priv->PortOffset + MAC_REG_RCR, &rx_mode);
+	VNSvInPortB(priv->port_off_set + MAC_REG_RCR, &rx_mode);
 
 	dev_dbg(&priv->pcid->dev, "rx mode in = %x\n", rx_mode);
 
@@ -1524,24 +1524,24 @@ static void vnt_configure(struct ieee80211_hw *hw,
 			spin_lock_irqsave(&priv->lock, flags);
 
 			if (priv->mc_list_count > 2) {
-				MACvSelectPage1(priv->PortOffset);
+				MACvSelectPage1(priv->port_off_set);
 
-				VNSvOutPortD(priv->PortOffset +
+				VNSvOutPortD(priv->port_off_set +
 					     MAC_REG_MAR0, 0xffffffff);
-				VNSvOutPortD(priv->PortOffset +
+				VNSvOutPortD(priv->port_off_set +
 					    MAC_REG_MAR0 + 4, 0xffffffff);
 
-				MACvSelectPage0(priv->PortOffset);
+				MACvSelectPage0(priv->port_off_set);
 			} else {
-				MACvSelectPage1(priv->PortOffset);
+				MACvSelectPage1(priv->port_off_set);
 
-				VNSvOutPortD(priv->PortOffset +
+				VNSvOutPortD(priv->port_off_set +
 					     MAC_REG_MAR0, (u32)multicast);
-				VNSvOutPortD(priv->PortOffset +
+				VNSvOutPortD(priv->port_off_set +
 					     MAC_REG_MAR0 + 4,
 					     (u32)(multicast >> 32));
 
-				MACvSelectPage0(priv->PortOffset);
+				MACvSelectPage0(priv->port_off_set);
 			}
 
 			spin_unlock_irqrestore(&priv->lock, flags);
@@ -1561,7 +1561,7 @@ static void vnt_configure(struct ieee80211_hw *hw,
 			rx_mode |= RCR_BSSID;
 	}
 
-	VNSvOutPortB(priv->PortOffset + MAC_REG_RCR, rx_mode);
+	VNSvOutPortB(priv->port_off_set + MAC_REG_RCR, rx_mode);
 
 	dev_dbg(&priv->pcid->dev, "rx mode out= %x\n", rx_mode);
 }
@@ -1621,7 +1621,7 @@ static void vnt_reset_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	struct vnt_private *priv = hw->priv;
 
 	/* reset TSF counter */
-	VNSvOutPortB(priv->PortOffset + MAC_REG_TFTCTL, TFTCTL_TSFCNTRST);
+	VNSvOutPortB(priv->port_off_set + MAC_REG_TFTCTL, TFTCTL_TSFCNTRST);
 }
 
 static const struct ieee80211_ops vnt_mac_ops = {
@@ -1698,9 +1698,9 @@ vt6655_probe(struct pci_dev *pcid, const struct pci_device_id *ent)
 
 	priv->memaddr = pci_resource_start(pcid, 0);
 	priv->ioaddr = pci_resource_start(pcid, 1);
-	priv->PortOffset = ioremap(priv->memaddr & PCI_BASE_ADDRESS_MEM_MASK,
+	priv->port_off_set = ioremap(priv->memaddr & PCI_BASE_ADDRESS_MEM_MASK,
 				   256);
-	if (!priv->PortOffset) {
+	if (!priv->port_off_set) {
 		dev_err(&pcid->dev, ": Failed to IO remapping ..\n");
 		device_free_info(priv);
 		return -ENODEV;
@@ -1729,10 +1729,10 @@ vt6655_probe(struct pci_dev *pcid, const struct pci_device_id *ent)
 	}
 	/* initial to reload eeprom */
 	MACvInitialize(priv);
-	MACvReadEtherAddress(priv->PortOffset, priv->abyCurrentNetAddr);
+	MACvReadEtherAddress(priv->port_off_set, priv->abyCurrentNetAddr);
 
 	/* Get RFType */
-	priv->byRFType = SROMbyReadEmbedded(priv->PortOffset, EEP_OFS_RFTYPE);
+	priv->byRFType = SROMbyReadEmbedded(priv->port_off_set, EEP_OFS_RFTYPE);
 	priv->byRFType &= RF_MASK;
 
 	dev_dbg(&pcid->dev, "RF Type = %x\n", priv->byRFType);
diff --git a/drivers/staging/vt6655/mac.c b/drivers/staging/vt6655/mac.c
index 9721c2234bf2..fd30a9646fa5 100644
--- a/drivers/staging/vt6655/mac.c
+++ b/drivers/staging/vt6655/mac.c
@@ -57,7 +57,7 @@
 bool MACbIsRegBitsOff(struct vnt_private *priv, unsigned char byRegOfs,
 		      unsigned char byTestBits)
 {
-	void __iomem *io_base = priv->PortOffset;
+	void __iomem *io_base = priv->port_off_set;
 
 	return !(ioread8(io_base + byRegOfs) & byTestBits);
 }
@@ -77,7 +77,7 @@ bool MACbIsRegBitsOff(struct vnt_private *priv, unsigned char byRegOfs,
  */
 bool MACbIsIntDisable(struct vnt_private *priv)
 {
-	void __iomem *io_base = priv->PortOffset;
+	void __iomem *io_base = priv->port_off_set;
 
 	if (ioread32(io_base + MAC_REG_IMR))
 		return false;
@@ -102,7 +102,7 @@ bool MACbIsIntDisable(struct vnt_private *priv)
 void MACvSetShortRetryLimit(struct vnt_private *priv,
 			    unsigned char byRetryLimit)
 {
-	void __iomem *io_base = priv->PortOffset;
+	void __iomem *io_base = priv->port_off_set;
 	/* set SRT */
 	iowrite8(byRetryLimit, io_base + MAC_REG_SRT);
 }
@@ -124,7 +124,7 @@ void MACvSetShortRetryLimit(struct vnt_private *priv,
 void MACvSetLongRetryLimit(struct vnt_private *priv,
 			   unsigned char byRetryLimit)
 {
-	void __iomem *io_base = priv->PortOffset;
+	void __iomem *io_base = priv->port_off_set;
 	/* set LRT */
 	iowrite8(byRetryLimit, io_base + MAC_REG_LRT);
 }
@@ -145,7 +145,7 @@ void MACvSetLongRetryLimit(struct vnt_private *priv,
  */
 void MACvSetLoopbackMode(struct vnt_private *priv, unsigned char byLoopbackMode)
 {
-	void __iomem *io_base = priv->PortOffset;
+	void __iomem *io_base = priv->port_off_set;
 
 	byLoopbackMode <<= 6;
 	/* set TCR */
@@ -168,7 +168,7 @@ void MACvSetLoopbackMode(struct vnt_private *priv, unsigned char byLoopbackMode)
  */
 void MACvSaveContext(struct vnt_private *priv, unsigned char *cxt_buf)
 {
-	void __iomem *io_base = priv->PortOffset;
+	void __iomem *io_base = priv->port_off_set;
 
 	/* read page0 register */
 	memcpy_fromio(cxt_buf, io_base, MAC_MAX_CONTEXT_SIZE_PAGE0);
@@ -198,7 +198,7 @@ void MACvSaveContext(struct vnt_private *priv, unsigned char *cxt_buf)
  */
 void MACvRestoreContext(struct vnt_private *priv, unsigned char *cxt_buf)
 {
-	void __iomem *io_base = priv->PortOffset;
+	void __iomem *io_base = priv->port_off_set;
 
 	MACvSelectPage1(io_base);
 	/* restore page1 */
@@ -249,7 +249,7 @@ void MACvRestoreContext(struct vnt_private *priv, unsigned char *cxt_buf)
  */
 bool MACbSoftwareReset(struct vnt_private *priv)
 {
-	void __iomem *io_base = priv->PortOffset;
+	void __iomem *io_base = priv->port_off_set;
 	unsigned short ww;
 
 	/* turn on HOSTCR_SOFTRST, just write 0x01 to reset */
@@ -312,7 +312,7 @@ bool MACbSafeSoftwareReset(struct vnt_private *priv)
  */
 bool MACbSafeRxOff(struct vnt_private *priv)
 {
-	void __iomem *io_base = priv->PortOffset;
+	void __iomem *io_base = priv->port_off_set;
 	unsigned short ww;
 
 	/* turn off wow temp for turn off Rx safely */
@@ -366,7 +366,7 @@ bool MACbSafeRxOff(struct vnt_private *priv)
  */
 bool MACbSafeTxOff(struct vnt_private *priv)
 {
-	void __iomem *io_base = priv->PortOffset;
+	void __iomem *io_base = priv->port_off_set;
 	unsigned short ww;
 
 	/* Clear TX DMA */
@@ -422,7 +422,7 @@ bool MACbSafeTxOff(struct vnt_private *priv)
  */
 bool MACbSafeStop(struct vnt_private *priv)
 {
-	void __iomem *io_base = priv->PortOffset;
+	void __iomem *io_base = priv->port_off_set;
 
 	MACvRegBitsOff(io_base, MAC_REG_TCR, TCR_AUTOBCNTX);
 
@@ -457,7 +457,7 @@ bool MACbSafeStop(struct vnt_private *priv)
  */
 bool MACbShutdown(struct vnt_private *priv)
 {
-	void __iomem *io_base = priv->PortOffset;
+	void __iomem *io_base = priv->port_off_set;
 	/* disable MAC IMR */
 	MACvIntDisable(io_base);
 	MACvSetLoopbackMode(priv, MAC_LB_INTERNAL);
@@ -485,7 +485,7 @@ bool MACbShutdown(struct vnt_private *priv)
  */
 void MACvInitialize(struct vnt_private *priv)
 {
-	void __iomem *io_base = priv->PortOffset;
+	void __iomem *io_base = priv->port_off_set;
 	/* clear sticky bits */
 	MACvClearStckDS(io_base);
 	/* disable force PME-enable */
@@ -517,7 +517,7 @@ void MACvInitialize(struct vnt_private *priv)
  */
 void MACvSetCurrRx0DescAddr(struct vnt_private *priv, u32 curr_desc_addr)
 {
-	void __iomem *io_base = priv->PortOffset;
+	void __iomem *io_base = priv->port_off_set;
 	unsigned short ww;
 	unsigned char org_dma_ctl;
 
@@ -551,7 +551,7 @@ void MACvSetCurrRx0DescAddr(struct vnt_private *priv, u32 curr_desc_addr)
  */
 void MACvSetCurrRx1DescAddr(struct vnt_private *priv, u32 curr_desc_addr)
 {
-	void __iomem *io_base = priv->PortOffset;
+	void __iomem *io_base = priv->port_off_set;
 	unsigned short ww;
 	unsigned char org_dma_ctl;
 
@@ -586,7 +586,7 @@ void MACvSetCurrRx1DescAddr(struct vnt_private *priv, u32 curr_desc_addr)
 void MACvSetCurrTx0DescAddrEx(struct vnt_private *priv,
 			      u32 curr_desc_addr)
 {
-	void __iomem *io_base = priv->PortOffset;
+	void __iomem *io_base = priv->port_off_set;
 	unsigned short ww;
 	unsigned char org_dma_ctl;
 
@@ -622,7 +622,7 @@ void MACvSetCurrTx0DescAddrEx(struct vnt_private *priv,
 void MACvSetCurrAC0DescAddrEx(struct vnt_private *priv,
 			      u32 curr_desc_addr)
 {
-	void __iomem *io_base = priv->PortOffset;
+	void __iomem *io_base = priv->port_off_set;
 	unsigned short ww;
 	unsigned char org_dma_ctl;
 
@@ -666,7 +666,7 @@ void MACvSetCurrTXDescAddr(int iTxType, struct vnt_private *priv,
  */
 void MACvTimer0MicroSDelay(struct vnt_private *priv, unsigned int uDelay)
 {
-	void __iomem *io_base = priv->PortOffset;
+	void __iomem *io_base = priv->port_off_set;
 	unsigned char byValue;
 	unsigned int uu, ii;
 
@@ -703,7 +703,7 @@ void MACvTimer0MicroSDelay(struct vnt_private *priv, unsigned int uDelay)
 void MACvOneShotTimer1MicroSec(struct vnt_private *priv,
 			       unsigned int uDelayTime)
 {
-	void __iomem *io_base = priv->PortOffset;
+	void __iomem *io_base = priv->port_off_set;
 
 	iowrite8(0, io_base + MAC_REG_TMCTL1);
 	iowrite32(uDelayTime, io_base + MAC_REG_TMDATA1);
@@ -713,7 +713,7 @@ void MACvOneShotTimer1MicroSec(struct vnt_private *priv,
 void MACvSetMISCFifo(struct vnt_private *priv, unsigned short offset,
 		     u32 data)
 {
-	void __iomem *io_base = priv->PortOffset;
+	void __iomem *io_base = priv->port_off_set;
 
 	if (offset > 273)
 		return;
@@ -724,7 +724,7 @@ void MACvSetMISCFifo(struct vnt_private *priv, unsigned short offset,
 
 bool MACbPSWakeup(struct vnt_private *priv)
 {
-	void __iomem *io_base = priv->PortOffset;
+	void __iomem *io_base = priv->port_off_set;
 	unsigned int ww;
 	/* Read PSCTL */
 	if (MACbIsRegBitsOff(priv, MAC_REG_PSCTL, PSCTL_PS))
@@ -765,7 +765,7 @@ void MACvSetKeyEntry(struct vnt_private *priv, unsigned short wKeyCtl,
 		     unsigned char *pbyAddr, u32 *pdwKey,
 		     unsigned char byLocalID)
 {
-	void __iomem *io_base = priv->PortOffset;
+	void __iomem *io_base = priv->port_off_set;
 	unsigned short offset;
 	u32 data;
 	int     ii;
@@ -830,7 +830,7 @@ void MACvSetKeyEntry(struct vnt_private *priv, unsigned short wKeyCtl,
  */
 void MACvDisableKeyEntry(struct vnt_private *priv, unsigned int uEntryIdx)
 {
-	void __iomem *io_base = priv->PortOffset;
+	void __iomem *io_base = priv->port_off_set;
 	unsigned short offset;
 
 	offset = MISCFIFO_KEYETRY0;
diff --git a/drivers/staging/vt6655/power.c b/drivers/staging/vt6655/power.c
index aac021e983d1..5bbe649b97be 100644
--- a/drivers/staging/vt6655/power.c
+++ b/drivers/staging/vt6655/power.c
@@ -52,30 +52,30 @@ void PSvEnablePowerSaving(struct vnt_private *priv,
 	u16 wAID = priv->current_aid | BIT(14) | BIT(15);
 
 	/* set period of power up before TBTT */
-	VNSvOutPortW(priv->PortOffset + MAC_REG_PWBT, C_PWBT);
+	VNSvOutPortW(priv->port_off_set + MAC_REG_PWBT, C_PWBT);
 	if (priv->op_mode != NL80211_IFTYPE_ADHOC) {
 		/* set AID */
-		VNSvOutPortW(priv->PortOffset + MAC_REG_AIDATIM, wAID);
+		VNSvOutPortW(priv->port_off_set + MAC_REG_AIDATIM, wAID);
 	}
 
 	/* Set AutoSleep */
-	MACvRegBitsOn(priv->PortOffset, MAC_REG_PSCFG, PSCFG_AUTOSLEEP);
+	MACvRegBitsOn(priv->port_off_set, MAC_REG_PSCFG, PSCFG_AUTOSLEEP);
 
 	/* Set HWUTSF */
-	MACvRegBitsOn(priv->PortOffset, MAC_REG_TFTCTL, TFTCTL_HWUTSF);
+	MACvRegBitsOn(priv->port_off_set, MAC_REG_TFTCTL, TFTCTL_HWUTSF);
 
 	if (wListenInterval >= 2) {
 		/* clear always listen beacon */
-		MACvRegBitsOff(priv->PortOffset, MAC_REG_PSCTL, PSCTL_ALBCN);
+		MACvRegBitsOff(priv->port_off_set, MAC_REG_PSCTL, PSCTL_ALBCN);
 		/* first time set listen next beacon */
-		MACvRegBitsOn(priv->PortOffset, MAC_REG_PSCTL, PSCTL_LNBCN);
+		MACvRegBitsOn(priv->port_off_set, MAC_REG_PSCTL, PSCTL_LNBCN);
 	} else {
 		/* always listen beacon */
-		MACvRegBitsOn(priv->PortOffset, MAC_REG_PSCTL, PSCTL_ALBCN);
+		MACvRegBitsOn(priv->port_off_set, MAC_REG_PSCTL, PSCTL_ALBCN);
 	}
 
 	/* enable power saving hw function */
-	MACvRegBitsOn(priv->PortOffset, MAC_REG_PSCTL, PSCTL_PSEN);
+	MACvRegBitsOn(priv->port_off_set, MAC_REG_PSCTL, PSCTL_PSEN);
 	priv->bEnablePSMode = true;
 
 	priv->bPWBitOn = true;
@@ -98,13 +98,13 @@ void PSvDisablePowerSaving(struct vnt_private *priv)
 	MACbPSWakeup(priv);
 
 	/* clear AutoSleep */
-	MACvRegBitsOff(priv->PortOffset, MAC_REG_PSCFG, PSCFG_AUTOSLEEP);
+	MACvRegBitsOff(priv->port_off_set, MAC_REG_PSCFG, PSCFG_AUTOSLEEP);
 
 	/* clear HWUTSF */
-	MACvRegBitsOff(priv->PortOffset, MAC_REG_TFTCTL, TFTCTL_HWUTSF);
+	MACvRegBitsOff(priv->port_off_set, MAC_REG_TFTCTL, TFTCTL_HWUTSF);
 
 	/* set always listen beacon */
-	MACvRegBitsOn(priv->PortOffset, MAC_REG_PSCTL, PSCTL_ALBCN);
+	MACvRegBitsOn(priv->port_off_set, MAC_REG_PSCTL, PSCTL_ALBCN);
 
 	priv->bEnablePSMode = false;
 
@@ -135,7 +135,7 @@ bool PSbIsNextTBTTWakeUp(struct vnt_private *priv)
 
 		if (priv->wake_up_count == 1) {
 			/* Turn on wake up to listen next beacon */
-			MACvRegBitsOn(priv->PortOffset,
+			MACvRegBitsOn(priv->port_off_set,
 				      MAC_REG_PSCTL, PSCTL_LNBCN);
 			wake_up = true;
 		}
diff --git a/drivers/staging/vt6655/rf.c b/drivers/staging/vt6655/rf.c
index 0dae593c6944..3b72dad861fd 100644
--- a/drivers/staging/vt6655/rf.c
+++ b/drivers/staging/vt6655/rf.c
@@ -406,7 +406,7 @@ static const unsigned long dwAL7230ChannelTable2[CB_MAX_CHANNEL] = {
  */
 static bool s_bAL7230Init(struct vnt_private *priv)
 {
-	void __iomem *iobase = priv->PortOffset;
+	void __iomem *iobase = priv->port_off_set;
 	int     ii;
 	bool ret;
 
@@ -455,7 +455,7 @@ static bool s_bAL7230Init(struct vnt_private *priv)
  */
 static bool s_bAL7230SelectChannel(struct vnt_private *priv, unsigned char byChannel)
 {
-	void __iomem *iobase = priv->PortOffset;
+	void __iomem *iobase = priv->port_off_set;
 	bool ret;
 
 	ret = true;
@@ -494,7 +494,7 @@ static bool s_bAL7230SelectChannel(struct vnt_private *priv, unsigned char byCha
  */
 bool IFRFbWriteEmbedded(struct vnt_private *priv, unsigned long dwData)
 {
-	void __iomem *iobase = priv->PortOffset;
+	void __iomem *iobase = priv->port_off_set;
 	unsigned short ww;
 	unsigned long dwValue;
 
@@ -527,7 +527,7 @@ bool IFRFbWriteEmbedded(struct vnt_private *priv, unsigned long dwData)
  */
 static bool RFbAL2230Init(struct vnt_private *priv)
 {
-	void __iomem *iobase = priv->PortOffset;
+	void __iomem *iobase = priv->port_off_set;
 	int     ii;
 	bool ret;
 
@@ -572,7 +572,7 @@ static bool RFbAL2230Init(struct vnt_private *priv)
 
 static bool RFbAL2230SelectChannel(struct vnt_private *priv, unsigned char byChannel)
 {
-	void __iomem *iobase = priv->PortOffset;
+	void __iomem *iobase = priv->port_off_set;
 	bool ret;
 
 	ret = true;
@@ -679,7 +679,7 @@ bool RFbSelectChannel(struct vnt_private *priv, unsigned char byRFType,
 bool RFvWriteWakeProgSyn(struct vnt_private *priv, unsigned char byRFType,
 			 u16 uChannel)
 {
-	void __iomem *iobase = priv->PortOffset;
+	void __iomem *iobase = priv->port_off_set;
 	int   ii;
 	unsigned char byInitCount = 0;
 	unsigned char bySleepCount = 0;
diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
index 5395c3a3e35a..109339d801c1 100644
--- a/drivers/staging/vt6655/rxtx.c
+++ b/drivers/staging/vt6655/rxtx.c
@@ -1422,13 +1422,13 @@ static int vnt_beacon_xmit(struct vnt_private *priv,
 
 	priv->wBCNBufLen = sizeof(*short_head) + skb->len;
 
-	MACvSetCurrBCNTxDescAddr(priv->PortOffset, priv->tx_beacon_dma);
+	MACvSetCurrBCNTxDescAddr(priv->port_off_set, priv->tx_beacon_dma);
 
-	MACvSetCurrBCNLength(priv->PortOffset, priv->wBCNBufLen);
+	MACvSetCurrBCNLength(priv->port_off_set, priv->wBCNBufLen);
 	/* Set auto Transmit on */
-	MACvRegBitsOn(priv->PortOffset, MAC_REG_TCR, TCR_AUTOBCNTX);
+	MACvRegBitsOn(priv->port_off_set, MAC_REG_TCR, TCR_AUTOBCNTX);
 	/* Poll Transmit the adapter */
-	MACvTransmitBCN(priv->PortOffset);
+	MACvTransmitBCN(priv->port_off_set);
 
 	return 0;
 }
@@ -1452,9 +1452,9 @@ int vnt_beacon_make(struct vnt_private *priv, struct ieee80211_vif *vif)
 int vnt_beacon_enable(struct vnt_private *priv, struct ieee80211_vif *vif,
 		      struct ieee80211_bss_conf *conf)
 {
-	VNSvOutPortB(priv->PortOffset + MAC_REG_TFTCTL, TFTCTL_TSFCNTRST);
+	VNSvOutPortB(priv->port_off_set + MAC_REG_TFTCTL, TFTCTL_TSFCNTRST);
 
-	VNSvOutPortB(priv->PortOffset + MAC_REG_TFTCTL, TFTCTL_TSFCNTREN);
+	VNSvOutPortB(priv->port_off_set + MAC_REG_TFTCTL, TFTCTL_TSFCNTREN);
 
 	CARDvSetFirstNextTBTT(priv, conf->beacon_int);
 
-- 
2.25.1

