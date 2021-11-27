Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5FD045FE0B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 11:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235707AbhK0KQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 05:16:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242028AbhK0KOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 05:14:15 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A941C061748
        for <linux-kernel@vger.kernel.org>; Sat, 27 Nov 2021 02:10:05 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id g14so48976649edb.8
        for <linux-kernel@vger.kernel.org>; Sat, 27 Nov 2021 02:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bfcy5GO85I/YEABOM6teid4ZMWCnzDFALpVwMAU2S0M=;
        b=k5DvSV0HEghPeamCefoIg2ZeYHdwAR5DnyexpvuCTr9MKySbtMjrEC3TqQUOsfjgAb
         Ku4yKuXXJUhSauoEV+U0Y6AMN0Ina8MFuYIFhjWj8Wq7YB1Z2LhRymDBZUusAfICQ8J0
         J/MmDgCoHraVlsDtbgqrwW3GALyiW5Ky7425coyKeq/qXxj2uh8B4e2fYuRWjo2GKC+I
         rzVk++fG7rCyszlL075TjrRHGT+PY9DWPvpYEKQSTwyu4XxE2SuAnzmcyGTJpJS9W3EU
         B/ZrlzMqr9+qcg9TKsjLccpc7GaMVa0Ni8RrAzgHbenzfWe8PZ5TtKlzJNuL25b4NmsM
         XEFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bfcy5GO85I/YEABOM6teid4ZMWCnzDFALpVwMAU2S0M=;
        b=j3FHseSAk8B9zgusWFLNA7qymnQYMFzaaHoj1gpljYJCqb572+IT7aAJdFFX+IJrbT
         r6JBcdk+F1+yvujtaers+mHrp8LHH1u1RV95IogeK2xC2DfkbLwxefHKpo+pb5Qw3/y1
         x/SL5YLUM4nbU7wG/EgIuvFqGQ+CcvD8DxmaBnqjcPgj14MeVozENnmenGBiy3SR4Kum
         0sqaQBgfRPNI7bZz7HHYqj9QW94MmtPKi+1tjp1G+F2d49HFQoH5O1/boX9NqiqZpTJ6
         hG7REIFnJgVY8p5C6/MGpubYzck8vt8RDaWjeeCliWn/HHv31KMP/9D0HkDOZM7yPO3K
         w3GQ==
X-Gm-Message-State: AOAM530Irc2Phx2Qxei2OKdLUTCQSY3UtplD5KiOMm7803uhrzbi/7cO
        FqFhLAGTr9hTK8V8SLfEoMU=
X-Google-Smtp-Source: ABdhPJxu2JhTBwIGJPikPiEhcVCiRH9AWtNjecvD4+sBPOFsZiQB4K9cdm5bP96qSshuIs9KaFRxfw==
X-Received: by 2002:a17:907:7215:: with SMTP id dr21mr44912097ejc.505.1638007803015;
        Sat, 27 Nov 2021 02:10:03 -0800 (PST)
Received: from bulldog.fritz.box (host-79-17-112-183.retail.telecomitalia.it. [79.17.112.183])
        by smtp.gmail.com with ESMTPSA id hb10sm4286204ejc.9.2021.11.27.02.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Nov 2021 02:10:02 -0800 (PST)
From:   Alberto Merciai <alb3rt0.m3rciai@gmail.com>
To:     alb3rt0.m3rciai@gmail.com
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tommaso Merciai <tomm.merciai@gmail.com>,
        =?UTF-8?q?Aldas=20Tara=C5=A1kevi=C4=8Dius?= <aldas60@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Karolina Drobnik <karolinadrobnik@gmail.com>,
        Lucas Henneman <lucas.henneman@linaro.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v6] staging: vt6655: refactor camelcase uCurrRSSI to current_rssi
Date:   Sat, 27 Nov 2021 11:08:02 +0100
Message-Id: <20211127100807.3113388-1-alb3rt0.m3rciai@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace camelcase variable "uCurrRSSI" (current Received Signal Strength
Indicator) into linux kernel coding style equivalent
variable "current_rssi".

Signed-off-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
---

v5
- change patch version
v4
- rebase against the staging-next
v3
- change tab with whitespace next to current_rssi
v2
- correct mailing list
v1
- remove whitespaces

 drivers/staging/vt6655/device.h      | 2 +-
 drivers/staging/vt6655/device_main.c | 4 ++--
 drivers/staging/vt6655/dpc.c         | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/vt6655/device.h b/drivers/staging/vt6655/device.h
index 9e5f060f3784..c51eba94230d 100644
--- a/drivers/staging/vt6655/device.h
+++ b/drivers/staging/vt6655/device.h
@@ -165,7 +165,7 @@ struct vnt_private {
 	unsigned char abyCurrentNetAddr[ETH_ALEN]; __aligned(2)
 	bool bLinkPass;          /* link status: OK or fail */
 
-	unsigned int	uCurrRSSI;
+	unsigned int current_rssi;
 	unsigned char byCurrSQ;
 
 	unsigned long dwTxAntennaSel;
diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 6c5140e29f6b..897d70cf32b8 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -980,10 +980,10 @@ static void vnt_check_bb_vga(struct vnt_private *priv)
 	if (priv->hw->conf.flags & IEEE80211_CONF_OFFCHANNEL)
 		return;
 
-	if (!(priv->vif->bss_conf.assoc && priv->uCurrRSSI))
+	if (!(priv->vif->bss_conf.assoc && priv->current_rssi))
 		return;
 
-	RFvRSSITodBm(priv, (u8)priv->uCurrRSSI, &dbm);
+	RFvRSSITodBm(priv, (u8)priv->current_rssi, &dbm);
 
 	for (i = 0; i < BB_VGA_LEVEL; i++) {
 		if (dbm < priv->dbm_threshold[i]) {
diff --git a/drivers/staging/vt6655/dpc.c b/drivers/staging/vt6655/dpc.c
index a7d1d35de5d4..c6ed3537f439 100644
--- a/drivers/staging/vt6655/dpc.c
+++ b/drivers/staging/vt6655/dpc.c
@@ -80,7 +80,7 @@ static bool vnt_rx_data(struct vnt_private *priv, struct sk_buff *skb,
 	RFvRSSITodBm(priv, *rssi, &rx_dbm);
 
 	priv->byBBPreEDRSSI = (u8)rx_dbm + 1;
-	priv->uCurrRSSI = *rssi;
+	priv->current_rssi = *rssi;
 
 	skb_pull(skb, 4);
 	skb_trim(skb, frame_size);
-- 
2.25.1

