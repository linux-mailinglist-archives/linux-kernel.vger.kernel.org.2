Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB5445640A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 21:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbhKRUaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 15:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbhKRUaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 15:30:23 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547C5C061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 12:27:22 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id x6so20786373edr.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 12:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Bku4og72Nr6a7MbIrMa3waOOwhpR77QKOKfLXyNDkMI=;
        b=gz55aBS6TWWM8f8cXToxhgR8xwOmjROc0W/1nTZY+iQhPTAA287vRIAgOv0M6bxIrf
         MlF93ZjcBQ8ChEfaQOpVUQ8lhlIfa+kVyBK3VPKjF8Fkq6klZ7eBRzBmUb0mc8ETcOTw
         lvgj5iQeqbkHhfzn41lMrQFVaIObrIsWcW7sOaQ35EnC7uOVVCCs9Mfs0W2YjT+WHxDc
         JrmxLTHWwMeF4YIsydpvOSYpWGEf779nbhclELVi2xNgSFn2W06USnRCVxLR+ai6yeR+
         C100LnGHho1V1SgtvJ05x2dffN6qh9HWOWhMHqtYRKCbP6TXcjswaiVfqTOm/Cf9OxBm
         6nuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Bku4og72Nr6a7MbIrMa3waOOwhpR77QKOKfLXyNDkMI=;
        b=aY0CTSLmOuww4jJZARwJdozY4atlMH6JpHejn44NOsVBhca1MoaAG4LzVuLYGh9H88
         S73QbQyM4meDlRh368Ls8jc4JdRhT0ejH+vUBRB2co6l5jgiRVhSf6TfGTG4rqk9ZT3L
         MYQbI5M2QkWI160YlD9q/Iioy9QI2Jq0M0pc2NobaV1wNoGJU2KjfOhbU99Qjb/ubf/K
         FbtUTSFo+5mmVLSeiPeROpImJqXNoFEJIWIbmcidAWC5c+TMHapljrJlOYzaPV6r3916
         /Z6+tVfyWIUNPSBTgf2TPDE3VY0/nSCK+Z3dQK2iP6oD47mbw39ryDv6spAIwDOf2gM7
         2FhQ==
X-Gm-Message-State: AOAM531iT3/Rrt5kqIWezJNWmLyX26+Y8gr30yYUs0bIRFF1aqVcqhKC
        hijyt28OIWIEndppie3z2XI=
X-Google-Smtp-Source: ABdhPJzkI0oRGhLTF7LY1pLYuuYRU4I7TbFXpZA8P2q29G8RNjubd0glYxE9ZxgMs4Ubh5HXauTWmA==
X-Received: by 2002:a05:6402:51ca:: with SMTP id r10mr15771820edd.0.1637267240969;
        Thu, 18 Nov 2021 12:27:20 -0800 (PST)
Received: from t470p (host-95-252-102-163.retail.telecomitalia.it. [95.252.102.163])
        by smtp.gmail.com with ESMTPSA id v13sm338379ejo.36.2021.11.18.12.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 12:27:20 -0800 (PST)
Date:   Thu, 18 Nov 2021 21:27:18 +0100
From:   Alberto Merciai <alb3rt0.m3rciai@gmail.com>
To:     alb3rt0.m3rciai@gmail.com
Cc:     forest@alittletooquiet.net, gregkh@linuxfoundation.org,
        alb3rt0.m3rciai@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] staging: vt6655: refactor camelcase uCurrRSSI to
 current_rssi
Message-ID: <20211118202718.GA152832@t470p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace camelcase variable "uCurrRSSI" (current Received Signal Strength
Indicator) into linux kernel coding style equivalent
variable "current_rssi".

Signed-off-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
---

v2
- correct mailing list
v1
- remove whitespaces

 drivers/staging/vt6655/device.h      | 2 +-
 drivers/staging/vt6655/device_main.c | 4 ++--
 drivers/staging/vt6655/dpc.c         | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/vt6655/device.h b/drivers/staging/vt6655/device.h
index 29f354ced563..80c9ace0d116 100644
--- a/drivers/staging/vt6655/device.h
+++ b/drivers/staging/vt6655/device.h
@@ -167,7 +167,7 @@ struct vnt_private {
 	unsigned char abyCurrentNetAddr[ETH_ALEN]; __aligned(2)
 	bool bLinkPass;          /* link status: OK or fail */
 
-	unsigned int	uCurrRSSI;
+	unsigned int	current_rssi;
 	unsigned char byCurrSQ;
 
 	unsigned long dwTxAntennaSel;
diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 41cbec4134b0..17cdb2dc0aa9 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -979,10 +979,10 @@ static void vnt_check_bb_vga(struct vnt_private *priv)
 	if (priv->hw->conf.flags & IEEE80211_CONF_OFFCHANNEL)
 		return;
 
-	if (!(priv->vif->bss_conf.assoc && priv->uCurrRSSI))
+	if (!(priv->vif->bss_conf.assoc && priv->current_rssi))
 		return;
 
-	RFvRSSITodBm(priv, (u8)priv->uCurrRSSI, &dbm);
+	RFvRSSITodBm(priv, (u8)priv->current_rssi, &dbm);
 
 	for (i = 0; i < BB_VGA_LEVEL; i++) {
 		if (dbm < priv->ldBmThreshold[i]) {
diff --git a/drivers/staging/vt6655/dpc.c b/drivers/staging/vt6655/dpc.c
index 52214a30e9b6..9fea1ee0d612 100644
--- a/drivers/staging/vt6655/dpc.c
+++ b/drivers/staging/vt6655/dpc.c
@@ -82,7 +82,7 @@ static bool vnt_rx_data(struct vnt_private *priv, struct sk_buff *skb,
 	RFvRSSITodBm(priv, *rssi, &rx_dbm);
 
 	priv->byBBPreEDRSSI = (u8)rx_dbm + 1;
-	priv->uCurrRSSI = *rssi;
+	priv->current_rssi = *rssi;
 
 	skb_pull(skb, 4);
 	skb_trim(skb, frame_size);
-- 
2.25.1

