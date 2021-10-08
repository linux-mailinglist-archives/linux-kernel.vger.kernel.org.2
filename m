Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37C8E426FB5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 19:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237070AbhJHRrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 13:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbhJHRrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 13:47:16 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DD4C061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 10:45:21 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id t2so32043169wrb.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 10:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NhZIKSl99b3rJCmOtrCxLsBnbbwrUR85VN1YJ/hrO1I=;
        b=oJTqJLC6SGQk19PW+PwRiVXN+GKywtpO325delzTsvTSFew3rBbRlW//onRPeUdTVD
         h6E2Qcq0PTpb82dc/YIiX/JMu5VV0nHJfN/u8e3dUT90yIIL4p5qhw30bf4VzXYM+H8d
         qhULs2JhhTul/L+MNMpN9zLrdl6UZsVcm34DDD8r9SkoTZ6Bb1UA1gp6jd0xgeJ2fRLC
         /Bgn2dd9nu6Qxj1chRS/8bdTq8p5YHcLZAr1PqBNTWdnpOMPyVLHUkLJvOmicaO8saLM
         nLbPWv9Gwas7N0wuC/2cn3lLZbt8Kg5gXFPBw1ABWUt5HLXzN4QE/z/nNKShpThtKTW1
         4QBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NhZIKSl99b3rJCmOtrCxLsBnbbwrUR85VN1YJ/hrO1I=;
        b=fqL2OGr34TARD0rbTyY1rb5kumaxvzsIY305/n2skCtgQ+wKol6tZ6VMMQ5NgXXK3x
         gjB3KAqHnUBo9T/J75AkaeV8uT7dtvNAhvq5tDLkvpJP2vIp5vO99ImM3bf5vHyzFyGZ
         0DyxJg9mCvZEEKlswQw3xLQV9sqOP8aFDTzJrCgLCPN8vvYfiitCpW744Kw6dFhG6aiT
         Cm27pkWCk5FWL8s63ohQtBUUZgTnPhzrqzJ4amguI3/tRTLRCSCCtj86iOrj69HeuCXi
         hqsCdD9Cqqdmryl/O6Jff/svqCWHosGR3FyXiDwE7wMQ6j+TdndgMciBuerJqDP+NrXl
         9mDQ==
X-Gm-Message-State: AOAM533U5UvT1ko9K5IjbKnzQrNSnpwswncR3Ij6WPFNj7vvLO5xhkO+
        dmg9A0JcOaNEthg0qicPLI4=
X-Google-Smtp-Source: ABdhPJw5n+J3Swujsw7j8iOlJODzKdGldgHt3JeXpvQq/5O2F7hc7Nn0fThZbim2JgUoqeqhKLylRQ==
X-Received: by 2002:a1c:27c3:: with SMTP id n186mr4968119wmn.192.1633715119689;
        Fri, 08 Oct 2021 10:45:19 -0700 (PDT)
Received: from tom-desktop.station (net-188-153-110-208.cust.vodafonedsl.it. [188.153.110.208])
        by smtp.gmail.com with ESMTPSA id q12sm3022153wmj.6.2021.10.08.10.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 10:45:19 -0700 (PDT)
From:   Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     tomm.merciai@gmail.com, Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        Lucas Henneman <lucas.henneman@linaro.org>,
        Yujia Qiao <rapiz@foxmail.com>,
        Marcos Antonio de Jesus Filho <mdejesusfilho@gmail.com>,
        Edmundo Carmona Antoranz <eantoranz@gmail.com>,
        =?UTF-8?q?Aldas=20Tara=C5=A1kevi=C4=8Dius?= <aldas60@gmail.com>,
        Deepak R Varma <mh12gx2825@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: vt6655: fix camelcase in byLocalID
Date:   Fri,  8 Oct 2021 19:44:57 +0200
Message-Id: <20211008174512.36617-1-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace camel case variable name for variable byLocalID
with snake case equivalent.

Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
---
 drivers/staging/vt6655/baseband.c    | 2 +-
 drivers/staging/vt6655/card.c        | 2 +-
 drivers/staging/vt6655/channel.c     | 2 +-
 drivers/staging/vt6655/device.h      | 2 +-
 drivers/staging/vt6655/device_main.c | 6 +++---
 drivers/staging/vt6655/dpc.c         | 2 +-
 drivers/staging/vt6655/key.c         | 2 +-
 drivers/staging/vt6655/mac.c         | 4 ++--
 drivers/staging/vt6655/mac.h         | 2 +-
 drivers/staging/vt6655/rxtx.c        | 2 +-
 10 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/vt6655/baseband.c b/drivers/staging/vt6655/baseband.c
index f73f3fad3e05..6afb571cac63 100644
--- a/drivers/staging/vt6655/baseband.c
+++ b/drivers/staging/vt6655/baseband.c
@@ -1994,7 +1994,7 @@ bool bb_vt3253_init(struct vnt_private *priv)
 	int        ii;
 	void __iomem *iobase = priv->PortOffset;
 	unsigned char by_rf_type = priv->byRFType;
-	unsigned char by_local_id = priv->byLocalID;
+	unsigned char by_local_id = priv->local_id;
 
 	if (by_rf_type == RF_RFMD2959) {
 		if (by_local_id <= REV_ID_VT3253_A1) {
diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index 2b2255b3147c..94d5fa8ea3c5 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -427,7 +427,7 @@ void CARDbRadioPowerOff(struct vnt_private *priv)
 
 	MACvRegBitsOff(priv->PortOffset, MAC_REG_HOSTCR, HOSTCR_RXON);
 
-	bb_set_deep_sleep(priv, priv->byLocalID);
+	bb_set_deep_sleep(priv, priv->local_id);
 
 	priv->bRadioOff = true;
 	pr_debug("chester power off\n");
diff --git a/drivers/staging/vt6655/channel.c b/drivers/staging/vt6655/channel.c
index 52b6538a201a..59a3c4990f12 100644
--- a/drivers/staging/vt6655/channel.c
+++ b/drivers/staging/vt6655/channel.c
@@ -193,7 +193,7 @@ bool set_channel(struct vnt_private *priv, struct ieee80211_channel *ch)
 
 	bb_software_reset(priv);
 
-	if (priv->byLocalID > REV_ID_VT3253_B1) {
+	if (priv->local_id > REV_ID_VT3253_B1) {
 		unsigned long flags;
 
 		spin_lock_irqsave(&priv->lock, flags);
diff --git a/drivers/staging/vt6655/device.h b/drivers/staging/vt6655/device.h
index 2af769174e33..afdcf2cfcca0 100644
--- a/drivers/staging/vt6655/device.h
+++ b/drivers/staging/vt6655/device.h
@@ -154,7 +154,7 @@ struct vnt_private {
 	u32                         rx_bytes;
 
 	/* Version control */
-	unsigned char byLocalID;
+	unsigned char local_id;
 	unsigned char byRFType;
 
 	unsigned char byMaxPwrLevel;
diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index d40c2ac14928..9b772e4747fd 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -219,7 +219,7 @@ static void device_init_registers(struct vnt_private *priv)
 	MACvInitialize(priv);
 
 	/* Get Local ID */
-	VNSvInPortB(priv->PortOffset + MAC_REG_LOCALID, &priv->byLocalID);
+	VNSvInPortB(priv->PortOffset + MAC_REG_LOCALID, &priv->local_id);
 
 	spin_lock_irqsave(&priv->lock, flags);
 
@@ -331,7 +331,7 @@ static void device_init_registers(struct vnt_private *priv)
 					   (unsigned char)(ii + EEP_OFS_OFDMA_PWR_dBm));
 	}
 
-	if (priv->byLocalID > REV_ID_VT3253_B1) {
+	if (priv->local_id > REV_ID_VT3253_B1) {
 		MACvSelectPage1(priv->PortOffset);
 
 		VNSvOutPortB(priv->PortOffset + MAC_REG_MSRCTL + 1,
@@ -398,7 +398,7 @@ static void device_init_registers(struct vnt_private *priv)
 	/* reset Rx pointer */
 	CARDvSafeResetTx(priv);
 
-	if (priv->byLocalID <= REV_ID_VT3253_A1)
+	if (priv->local_id <= REV_ID_VT3253_A1)
 		MACvRegBitsOn(priv->PortOffset, MAC_REG_RCR, RCR_WPAERR);
 
 	/* Turn On Rx DMA */
diff --git a/drivers/staging/vt6655/dpc.c b/drivers/staging/vt6655/dpc.c
index 2d06cecc0307..a7d1d35de5d4 100644
--- a/drivers/staging/vt6655/dpc.c
+++ b/drivers/staging/vt6655/dpc.c
@@ -100,7 +100,7 @@ static bool vnt_rx_data(struct vnt_private *priv, struct sk_buff *skb,
 	rx_status.rate_idx = rate_idx;
 
 	if (ieee80211_has_protected(fc)) {
-		if (priv->byLocalID > REV_ID_VT3253_A1)
+		if (priv->local_id > REV_ID_VT3253_A1)
 			rx_status.flag |= RX_FLAG_DECRYPTED;
 
 		/* Drop packet */
diff --git a/drivers/staging/vt6655/key.c b/drivers/staging/vt6655/key.c
index 20881cf2f394..f843966a3ea4 100644
--- a/drivers/staging/vt6655/key.c
+++ b/drivers/staging/vt6655/key.c
@@ -81,7 +81,7 @@ static int vnt_set_keymode(struct ieee80211_hw *hw, u8 *mac_addr,
 	}
 
 	MACvSetKeyEntry(priv, key_mode, entry, key_inx,
-			bssid, (u32 *)key->key, priv->byLocalID);
+			bssid, (u32 *)key->key, priv->local_id);
 
 	return 0;
 }
diff --git a/drivers/staging/vt6655/mac.c b/drivers/staging/vt6655/mac.c
index 9721c2234bf2..4d5fec897d23 100644
--- a/drivers/staging/vt6655/mac.c
+++ b/drivers/staging/vt6655/mac.c
@@ -763,14 +763,14 @@ bool MACbPSWakeup(struct vnt_private *priv)
 void MACvSetKeyEntry(struct vnt_private *priv, unsigned short wKeyCtl,
 		     unsigned int uEntryIdx, unsigned int uKeyIdx,
 		     unsigned char *pbyAddr, u32 *pdwKey,
-		     unsigned char byLocalID)
+		     unsigned char local_id)
 {
 	void __iomem *io_base = priv->PortOffset;
 	unsigned short offset;
 	u32 data;
 	int     ii;
 
-	if (byLocalID <= 1)
+	if (local_id <= 1)
 		return;
 
 	offset = MISCFIFO_KEYETRY0;
diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index 9797eddaea01..bd8deff7f206 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -921,7 +921,7 @@ bool MACbPSWakeup(struct vnt_private *priv);
 void MACvSetKeyEntry(struct vnt_private *priv, unsigned short wKeyCtl,
 		     unsigned int uEntryIdx, unsigned int uKeyIdx,
 		     unsigned char *pbyAddr, u32 *pdwKey,
-		     unsigned char byLocalID);
+		     unsigned char local_id);
 void MACvDisableKeyEntry(struct vnt_private *priv, unsigned int uEntryIdx);
 
 #endif /* __MAC_H__ */
diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
index 5395c3a3e35a..89b88dbef77f 100644
--- a/drivers/staging/vt6655/rxtx.c
+++ b/drivers/staging/vt6655/rxtx.c
@@ -1012,7 +1012,7 @@ s_cbFillTxBufHead(struct vnt_private *pDevice, unsigned char byPktType,
 
 		cbFrameSize += info->control.hw_key->icv_len;
 
-		if (pDevice->byLocalID > REV_ID_VT3253_A1) {
+		if (pDevice->local_id > REV_ID_VT3253_A1) {
 			/* MAC Header should be padding 0 to DW alignment. */
 			uPadding = 4 - (ieee80211_get_hdrlen_from_skb(skb) % 4);
 			uPadding %= 4;
-- 
2.25.1

