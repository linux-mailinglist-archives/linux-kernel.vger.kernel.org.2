Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B01B415379
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 00:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238321AbhIVWbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 18:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238297AbhIVWbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 18:31:45 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D03C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 15:30:14 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id y89so5152178ede.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 15:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wXC6LYNz8AXWFQhSRKFE1AFMEvwwQlC/Sl6fleL8KZ0=;
        b=VufFyAV64PL+EgdP7RsUCgsqFby83tF5bKUW6pTBCKNx75SDzIHMXbgxfbi3tAs1+G
         xs0QSgTSWQW9pvrQ0sw2l+khhcnPlhBONlqeZGWFllU7Y4/udbbOGJ81kYwXxfQeRZzd
         hSrlMJDzdg5yKqY6rdJ4Rgausk2rVwNLyGrY4UmZagKamFs7hd75shFFY9s1RR85qANd
         XOFOpYuYA76Py8vxyin9r5VBPZMDSn9i01WYU8uPU8iEWKI5nnGxyHImO79gxFF7wNkc
         qra4GgrPAoSQME/AQy1OEAqCrsDpCIkbOidz6MUGZquzNGpfc8M6PIWneoN22saqVlLY
         eWlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wXC6LYNz8AXWFQhSRKFE1AFMEvwwQlC/Sl6fleL8KZ0=;
        b=QJXzFmJQ1ygY0o/sNBXHp1mrucx/eLTkrXWpUN2GNEUV5suTsZggoaGX/9r9fJ+/ie
         hfUz8IetwTKcFh4+H87XgxVqdJ9W0Z8AuC0IAPGB+zSlMEjf1h3d+EyOj630Y2hjo+zf
         lwe/8R2SdrCMdV0VBN1n8L7diHLGgqKLfnyOKZE1dkd9gYBh2NOeEp/DjnRS7zxmZ013
         B83Qo5q4Ek/dzamtc1aAoSMHJfc9swzj24aXi2rmdyrVJy/PjL6AOvaTrh7vBjzQZcmR
         aLhMLfITLo4m5D29sYzMUN/TKmmbaO2Nw+MTUtUdqDJotvbVEnpTv847922yy8ihI6qf
         qiCg==
X-Gm-Message-State: AOAM531aTh4jcoKzGOA2mpJbRbaCftn3hhHrjIFcIeesjiHKkfb9emxM
        MOesyawkW7Rm7cXdQQ9piSc=
X-Google-Smtp-Source: ABdhPJzhiC2AkZX1mfE7TokL3YKEtXilW/4kMcPB6yZUx7y7CiyT7oAGRKlBjg8rD+3SSxcfc0I+2w==
X-Received: by 2002:a17:907:9604:: with SMTP id gb4mr1727777ejc.142.1632349813602;
        Wed, 22 Sep 2021 15:30:13 -0700 (PDT)
Received: from tom-desktop.station (net-93-71-218-228.cust.vodafonedsl.it. [93.71.218.228])
        by smtp.gmail.com with ESMTPSA id b38sm1913069edf.46.2021.09.22.15.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 15:30:13 -0700 (PDT)
From:   Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     tomm.merciai@gmail.com, Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yujia Qiao <rapiz@foxmail.com>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        Lucas Henneman <lucas.henneman@linaro.org>,
        Marcos Antonio de Jesus Filho <mdejesusfilho@gmail.com>,
        Edmundo Carmona Antoranz <eantoranz@gmail.com>,
        =?UTF-8?q?Aldas=20Tara=C5=A1kevi=C4=8Dius?= <aldas60@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Deepak R Varma <mh12gx2825@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: vt6655: Replace camel case variable name
Date:   Thu, 23 Sep 2021 00:29:45 +0200
Message-Id: <20210922222959.614321-1-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Work in progress: replace camel case variables

byLocalID -> by_local_id

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
index 9bd1ff36f9af..ff596bdcee8d 100644
--- a/drivers/staging/vt6655/baseband.c
+++ b/drivers/staging/vt6655/baseband.c
@@ -1994,7 +1994,7 @@ bool bb_vt3253_init(struct vnt_private *priv)
 	int        ii;
 	void __iomem *iobase = priv->port_off_set;
 	unsigned char by_rf_type = priv->byRFType;
-	unsigned char by_local_id = priv->byLocalID;
+	unsigned char by_local_id = priv->by_local_id;
 
 	if (by_rf_type == RF_RFMD2959) {
 		if (by_local_id <= REV_ID_VT3253_A1) {
diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index e048216ef6c7..9bec1cd036be 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -427,7 +427,7 @@ void CARDbRadioPowerOff(struct vnt_private *priv)
 
 	MACvRegBitsOff(priv->port_off_set, MAC_REG_HOSTCR, HOSTCR_RXON);
 
-	bb_set_deep_sleep(priv, priv->byLocalID);
+	bb_set_deep_sleep(priv, priv->by_local_id);
 
 	priv->bRadioOff = true;
 	pr_debug("chester power off\n");
diff --git a/drivers/staging/vt6655/channel.c b/drivers/staging/vt6655/channel.c
index 8f2ea280d4c1..50cb4fb7e742 100644
--- a/drivers/staging/vt6655/channel.c
+++ b/drivers/staging/vt6655/channel.c
@@ -193,7 +193,7 @@ bool set_channel(struct vnt_private *priv, struct ieee80211_channel *ch)
 
 	bb_software_reset(priv);
 
-	if (priv->byLocalID > REV_ID_VT3253_B1) {
+	if (priv->by_local_id > REV_ID_VT3253_B1) {
 		unsigned long flags;
 
 		spin_lock_irqsave(&priv->lock, flags);
diff --git a/drivers/staging/vt6655/device.h b/drivers/staging/vt6655/device.h
index 2b50cf4e2406..3d8e28c45287 100644
--- a/drivers/staging/vt6655/device.h
+++ b/drivers/staging/vt6655/device.h
@@ -154,7 +154,7 @@ struct vnt_private {
 	u32                         rx_bytes;
 
 	/* Version control */
-	unsigned char byLocalID;
+	unsigned char by_local_id;
 	unsigned char byRFType;
 
 	unsigned char byMaxPwrLevel;
diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index cae666ed548f..1b214546bf65 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -219,7 +219,7 @@ static void device_init_registers(struct vnt_private *priv)
 	MACvInitialize(priv);
 
 	/* Get Local ID */
-	VNSvInPortB(priv->port_off_set + MAC_REG_LOCALID, &priv->byLocalID);
+	VNSvInPortB(priv->port_off_set + MAC_REG_LOCALID, &priv->by_local_id);
 
 	spin_lock_irqsave(&priv->lock, flags);
 
@@ -331,7 +331,7 @@ static void device_init_registers(struct vnt_private *priv)
 					   (unsigned char)(ii + EEP_OFS_OFDMA_PWR_dBm));
 	}
 
-	if (priv->byLocalID > REV_ID_VT3253_B1) {
+	if (priv->by_local_id > REV_ID_VT3253_B1) {
 		MACvSelectPage1(priv->port_off_set);
 
 		VNSvOutPortB(priv->port_off_set + MAC_REG_MSRCTL + 1,
@@ -398,7 +398,7 @@ static void device_init_registers(struct vnt_private *priv)
 	/* reset Rx pointer */
 	CARDvSafeResetTx(priv);
 
-	if (priv->byLocalID <= REV_ID_VT3253_A1)
+	if (priv->by_local_id <= REV_ID_VT3253_A1)
 		MACvRegBitsOn(priv->port_off_set, MAC_REG_RCR, RCR_WPAERR);
 
 	/* Turn On Rx DMA */
diff --git a/drivers/staging/vt6655/dpc.c b/drivers/staging/vt6655/dpc.c
index 2d06cecc0307..7f63335ed2d3 100644
--- a/drivers/staging/vt6655/dpc.c
+++ b/drivers/staging/vt6655/dpc.c
@@ -100,7 +100,7 @@ static bool vnt_rx_data(struct vnt_private *priv, struct sk_buff *skb,
 	rx_status.rate_idx = rate_idx;
 
 	if (ieee80211_has_protected(fc)) {
-		if (priv->byLocalID > REV_ID_VT3253_A1)
+		if (priv->by_local_id > REV_ID_VT3253_A1)
 			rx_status.flag |= RX_FLAG_DECRYPTED;
 
 		/* Drop packet */
diff --git a/drivers/staging/vt6655/key.c b/drivers/staging/vt6655/key.c
index 20881cf2f394..2c1410155095 100644
--- a/drivers/staging/vt6655/key.c
+++ b/drivers/staging/vt6655/key.c
@@ -81,7 +81,7 @@ static int vnt_set_keymode(struct ieee80211_hw *hw, u8 *mac_addr,
 	}
 
 	MACvSetKeyEntry(priv, key_mode, entry, key_inx,
-			bssid, (u32 *)key->key, priv->byLocalID);
+			bssid, (u32 *)key->key, priv->by_local_id);
 
 	return 0;
 }
diff --git a/drivers/staging/vt6655/mac.c b/drivers/staging/vt6655/mac.c
index fd30a9646fa5..e7e286b67259 100644
--- a/drivers/staging/vt6655/mac.c
+++ b/drivers/staging/vt6655/mac.c
@@ -763,14 +763,14 @@ bool MACbPSWakeup(struct vnt_private *priv)
 void MACvSetKeyEntry(struct vnt_private *priv, unsigned short wKeyCtl,
 		     unsigned int uEntryIdx, unsigned int uKeyIdx,
 		     unsigned char *pbyAddr, u32 *pdwKey,
-		     unsigned char byLocalID)
+		     unsigned char by_local_id)
 {
 	void __iomem *io_base = priv->port_off_set;
 	unsigned short offset;
 	u32 data;
 	int     ii;
 
-	if (byLocalID <= 1)
+	if (by_local_id <= 1)
 		return;
 
 	offset = MISCFIFO_KEYETRY0;
diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index 9797eddaea01..9e7c50a74814 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -921,7 +921,7 @@ bool MACbPSWakeup(struct vnt_private *priv);
 void MACvSetKeyEntry(struct vnt_private *priv, unsigned short wKeyCtl,
 		     unsigned int uEntryIdx, unsigned int uKeyIdx,
 		     unsigned char *pbyAddr, u32 *pdwKey,
-		     unsigned char byLocalID);
+		     unsigned char by_local_id);
 void MACvDisableKeyEntry(struct vnt_private *priv, unsigned int uEntryIdx);
 
 #endif /* __MAC_H__ */
diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
index 05068c81070d..2bb83b9dec5e 100644
--- a/drivers/staging/vt6655/rxtx.c
+++ b/drivers/staging/vt6655/rxtx.c
@@ -1012,7 +1012,7 @@ s_cbFillTxBufHead(struct vnt_private *pDevice, unsigned char byPktType,
 
 		cbFrameSize += info->control.hw_key->icv_len;
 
-		if (pDevice->byLocalID > REV_ID_VT3253_A1) {
+		if (pDevice->by_local_id > REV_ID_VT3253_A1) {
 			/* MAC Header should be padding 0 to DW alignment. */
 			uPadding = 4 - (ieee80211_get_hdrlen_from_skb(skb) % 4);
 			uPadding %= 4;
-- 
2.25.1

