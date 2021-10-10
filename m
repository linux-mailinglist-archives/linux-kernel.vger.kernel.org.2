Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 389604283F1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 00:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbhJJWCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 18:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbhJJWCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 18:02:20 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70466C061570
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 15:00:21 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id g10so58922417edj.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 15:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hfl07gjWDXgXi0hSHdZBMygqSznqPoJkaRR5PLe9DvA=;
        b=TQ99+sExC+MxhycGeQPD+ndI2FvdwTK4UzSqgZZdkIc0jjHdrNhuAQjBjxJsm24w+t
         zk+AVWGSMDVt3E1PQvaz78zYQc4kK5oCwCmHkBlL6ZGJZVAP7Yrrm7M5yDXKOG6LZ28D
         f7ngUxhllDf5LhtK9J/+MasiCwfEUTmedgkq+HNMcR9MUdhhwspIHbW/+xoCa/kRwwhJ
         Mjl/Gq/yXtwobcaRnAG+L20OvHihYwOxir91RaCKnU5i7uucWEOW951Frbva/BUUc+np
         BOVhmcMB3U4uizlrlLvGEyAZj153J2z8+gNDXKDS5JRjcasqaflrLWtr1NFlOIQczePG
         zNow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hfl07gjWDXgXi0hSHdZBMygqSznqPoJkaRR5PLe9DvA=;
        b=SHym/7wdtPOHVEI5VLC0+uxAFJLqj7UNee1P0VXhBYWOj1YWbddfvu57B0VSjUpHna
         cC9Z/p9qVmcwKQwHfgpCMGt6pIQAWxbJBu5DiMY88BmAyBTM6aV+jsqiVSBYYIto7CeM
         QV/bRloVfVjc8uKNJ4QlqTDT1kU8KCNiJ/9tAWOvETK3L/1UL4RF2gFFFiD5IVhcF6zD
         8800IWBMYm7oT11zuVrpy0SnsPDHPz80UNuslEKhiQwfhW0vFwJT9oDB06/DNr5kyb6V
         DpsStgdLRpw3npZqD9uiL2RE91dlZlxnqB2ioOcKJLvIFru/njEvbN5W9zAvoygRW8dh
         kv7w==
X-Gm-Message-State: AOAM530Gi1uV/PDtI25MxxBYLKh4N1C8gWldWAo5k9OFHOxBpwU6JuLU
        xzqR+rMhJRlwRI90599o60A=
X-Google-Smtp-Source: ABdhPJzK3AB/td0fJF4ACgDpDjxbLw5WHW3//c/oTXObDTmU8WcERE+iOBcHzvg0hXlFxrIftan99g==
X-Received: by 2002:a17:906:2890:: with SMTP id o16mr21025795ejd.161.1633903219865;
        Sun, 10 Oct 2021 15:00:19 -0700 (PDT)
Received: from tom-desktop.station (net-188-153-110-208.cust.vodafonedsl.it. [188.153.110.208])
        by smtp.gmail.com with ESMTPSA id ck9sm2534875ejb.56.2021.10.10.15.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Oct 2021 15:00:19 -0700 (PDT)
From:   Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     tomm.merciai@gmail.com, Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas Henneman <lucas.henneman@linaro.org>,
        Yujia Qiao <rapiz@foxmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        Marcos Antonio de Jesus Filho <mdejesusfilho@gmail.com>,
        Edmundo Carmona Antoranz <eantoranz@gmail.com>,
        =?UTF-8?q?Aldas=20Tara=C5=A1kevi=C4=8Dius?= <aldas60@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Deepak R Varma <mh12gx2825@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: vt6655: fix camelcase in byLocalID
Date:   Sun, 10 Oct 2021 23:59:45 +0200
Message-Id: <20211010220014.148785-1-tomm.merciai@gmail.com>
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
Changes since v1:
 - Rebased as suggested by gregkh

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
index d6e114f25685..0bae35af6e0f 100644
--- a/drivers/staging/vt6655/baseband.c
+++ b/drivers/staging/vt6655/baseband.c
@@ -1994,7 +1994,7 @@ bool bb_vt3253_init(struct vnt_private *priv)
 	int        ii;
 	void __iomem *iobase = priv->port_offset;
 	unsigned char by_rf_type = priv->byRFType;
-	unsigned char by_local_id = priv->byLocalID;
+	unsigned char by_local_id = priv->local_id;
 
 	if (by_rf_type == RF_RFMD2959) {
 		if (by_local_id <= REV_ID_VT3253_A1) {
diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index b5e6880555fd..834b9db05dff 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -427,7 +427,7 @@ void CARDbRadioPowerOff(struct vnt_private *priv)
 
 	MACvRegBitsOff(priv->port_offset, MAC_REG_HOSTCR, HOSTCR_RXON);
 
-	bb_set_deep_sleep(priv, priv->byLocalID);
+	bb_set_deep_sleep(priv, priv->local_id);
 
 	priv->bRadioOff = true;
 	pr_debug("chester power off\n");
diff --git a/drivers/staging/vt6655/channel.c b/drivers/staging/vt6655/channel.c
index 76ee3146b865..b550a1a0844e 100644
--- a/drivers/staging/vt6655/channel.c
+++ b/drivers/staging/vt6655/channel.c
@@ -193,7 +193,7 @@ bool set_channel(struct vnt_private *priv, struct ieee80211_channel *ch)
 
 	bb_software_reset(priv);
 
-	if (priv->byLocalID > REV_ID_VT3253_B1) {
+	if (priv->local_id > REV_ID_VT3253_B1) {
 		unsigned long flags;
 
 		spin_lock_irqsave(&priv->lock, flags);
diff --git a/drivers/staging/vt6655/device.h b/drivers/staging/vt6655/device.h
index ea6f9568f112..92d6f82f939f 100644
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
index 3683a9d65017..24f0e346da12 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -219,7 +219,7 @@ static void device_init_registers(struct vnt_private *priv)
 	MACvInitialize(priv);
 
 	/* Get Local ID */
-	VNSvInPortB(priv->port_offset + MAC_REG_LOCALID, &priv->byLocalID);
+	VNSvInPortB(priv->port_offset + MAC_REG_LOCALID, &priv->local_id);
 
 	spin_lock_irqsave(&priv->lock, flags);
 
@@ -331,7 +331,7 @@ static void device_init_registers(struct vnt_private *priv)
 					   (unsigned char)(ii + EEP_OFS_OFDMA_PWR_dBm));
 	}
 
-	if (priv->byLocalID > REV_ID_VT3253_B1) {
+	if (priv->local_id > REV_ID_VT3253_B1) {
 		MACvSelectPage1(priv->port_offset);
 
 		VNSvOutPortB(priv->port_offset + MAC_REG_MSRCTL + 1,
@@ -398,7 +398,7 @@ static void device_init_registers(struct vnt_private *priv)
 	/* reset Rx pointer */
 	CARDvSafeResetTx(priv);
 
-	if (priv->byLocalID <= REV_ID_VT3253_A1)
+	if (priv->local_id <= REV_ID_VT3253_A1)
 		MACvRegBitsOn(priv->port_offset, MAC_REG_RCR, RCR_WPAERR);
 
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
index 1ae7148b4092..80cced7dfda8 100644
--- a/drivers/staging/vt6655/mac.c
+++ b/drivers/staging/vt6655/mac.c
@@ -763,14 +763,14 @@ bool MACbPSWakeup(struct vnt_private *priv)
 void MACvSetKeyEntry(struct vnt_private *priv, unsigned short wKeyCtl,
 		     unsigned int uEntryIdx, unsigned int uKeyIdx,
 		     unsigned char *pbyAddr, u32 *pdwKey,
-		     unsigned char byLocalID)
+		     unsigned char local_id)
 {
 	void __iomem *io_base = priv->port_offset;
 	unsigned short offset;
 	u32 data;
 	int     ii;
 
-	if (byLocalID <= 1)
+	if (local_id <= 1)
 		return;
 
 	offset = MISCFIFO_KEYETRY0;
diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index 3043d2813074..550dc4da80a9 100644
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
index 7ec7fd309329..ff0b5391ea0b 100644
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

