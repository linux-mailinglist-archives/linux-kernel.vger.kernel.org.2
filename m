Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0791244F91C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 17:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235827AbhKNQoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 11:44:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbhKNQns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 11:43:48 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622F6C061746
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 08:40:53 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id g14so60747480edz.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 08:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=yH5jlMEp13Y3JSGXuU6UqW4nNJ0SyKJmoMUfJV7lpoA=;
        b=lMctiQ5i45ED6LX2Ljl+60ykbGlr4I0L0ZN7pxtV9YKu5r8TsVSK5Y8pPcZcZZ4qir
         bYvT+wHD1PfOi/BUVebTwih3rgNRzgKn5Gk/qlK4YMOYehyLuJtJEYA8UjngeVVaQshm
         6cWeiGbhpEsyOv8tx+GcFpQ5+5H/Cz9ZFbdErlc4bNsrPRRMQ0yljlrcDesVhRVo37Qi
         /9cnsw/Y9DlfsxB3+PWxYNAJlPbULyn1QLo4kXfrhcLfTNaxOkzPB78lVU0kL1de7XVB
         ior+LncdhLHJQtNCVXxwz3kDMJCE/Pc2EZaA0UdzotszEHG6DkDRQ7NPxjBGsDF2yThz
         vF0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=yH5jlMEp13Y3JSGXuU6UqW4nNJ0SyKJmoMUfJV7lpoA=;
        b=qXx1ilAf9NfGyirv0c1KZLjr55YEWTVTmnvXIcTjYXHqs23UBmXTN1rbq3i5zXrO+W
         5fKp2HtfNJofhBLKDmhtwJ7LvgzljozI30IVml0ILMSXS7ZNtSHRB0vwerhmFkKvh5kv
         WwcoWVy5gDS/Pce9OZWhBwNSChWSyr4TE4TbbPgvSkYcNoorJMpdJ31psCofW4BfFnsj
         aeAjWdeVbib+T69zJ3O4xAsrlP6HES+vWi57AD5RJ26h3x2ai/507ycdyn+duDoZ3aeC
         3lLC/wlSjRmXo/rlMueZuswB+vhSncpgk5NkDKTqUJP0Llf38FopARfPYvG9Ltc+8b6D
         aRbQ==
X-Gm-Message-State: AOAM531JETAgyHeboCaZ6bJFNlBXxuOwsBudfrp7k8FyPaQTWS6spOm/
        UwHmQ1yGowfAsI65LQChj0w+Dy5sf1lEoCVNa6g=
X-Google-Smtp-Source: ABdhPJwzgac1nnU88FrGFgHwbEA+8xUxsXjMrkIKnfmPU1FijZFgifEw3h0FvxVR1F5AwC4uXMzfRg==
X-Received: by 2002:a17:907:7ea4:: with SMTP id qb36mr42466435ejc.146.1636908052034;
        Sun, 14 Nov 2021 08:40:52 -0800 (PST)
Received: from t470p (host-82-51-109-131.retail.telecomitalia.it. [82.51.109.131])
        by smtp.gmail.com with ESMTPSA id x15sm2115384edq.65.2021.11.14.08.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 08:40:51 -0800 (PST)
Date:   Sun, 14 Nov 2021 17:40:48 +0100
From:   Alberto Merciai <alb3rt0.m3rciai@gmail.com>
To:     alb3rt0.m3rciai@gmail.com
Cc:     forest@alittletooquiet.net, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: vt6655: refactor camelcase uCurrRSSI to current_rssi
Message-ID: <20211114164048.GA134727@t470p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace camelcase variable "uCurrRSSI" (current Received Signal Strength
Indicator) into linux kernel coding style equivalent 
variable "current_rssi".

References:
https://www.kernel.org/doc/html/latest/process/coding-style.html
https://www.cse.iitk.ac.in/users/dsrkg/cs245/html/Guide.htm

---
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

