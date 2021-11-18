Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F64745645F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 21:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233601AbhKRUkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 15:40:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbhKRUka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 15:40:30 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5F2C061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 12:37:29 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id x6so20897932edr.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 12:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=36yDFfopFxLjWle4SmTLXk2V2L53KBUrQboPtECnYtY=;
        b=obMz6oFHTTLVG5qY2Yuc7yLU3xWHtKWptUTb535fFFrUZ+VKDUN7vAW9We/CacgC7p
         9prEXwwOvyzmw+NHgkvZPBIdCjglPqhqDPXvBTxGLTEEm2h1TQ5v67Zsa8DTO2MN/IkO
         2NBKMCDUxFhEMBEzkjViK1taRRhhIEuNTsK7wyBCkfM3BFM2cAaAgyeM/VRbrH0ixkYa
         F8CFDX14975QYxzxRl3kRv6hHtL5OEpXoGrIRKa5YXRTPtH6vFUezKGieWHPyu6KRdij
         L1yfUt7yC5981C2SiNNj56BmbxJMrjIaEuTrc4PHF1JmnJWJ6L43ObYrUd7DEMWH+9UQ
         zAYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=36yDFfopFxLjWle4SmTLXk2V2L53KBUrQboPtECnYtY=;
        b=0J/O+badD3TY8Z2y2IAKcybrozqAoy254Svo1Hr4Ov8epdgpgbAoIEihQHw2kHeG4P
         VA42pVPITK1bnb/CfWZQZ1y79H8d3dR94nWhM71kl3W+PvY1Jxq0J3zs4yxOYF7mR+sj
         Aoe1VfjlvzqCu/wPoarSsbu+b6L1lLLK4Xt1GACIsU+RFhhEatKhdOVKPBiJsof56Ol1
         L0swlsYzF9uvzJKIKMVcNVtlnRG+P5QBZ4zTkZgPsL7yWNlRfuoqVfndZH3g/MFPAQf0
         i6iYafri859Y40b9DHMBNCVTftZIfgCJHrVEEmFvuCU20OFSFKXyFfGHxQySxjOZbHWE
         zAYA==
X-Gm-Message-State: AOAM532GnS6rE+R3IWaiftEEtvNZ1hSixhv+PGW+SMVba2SUfsXXOCUh
        CtQvp5dtt/EdKJt2hzsV/NAVVHIUsEo=
X-Google-Smtp-Source: ABdhPJzLGaZxEFji+evDgg1a0q3AnGcBOQ/5/amRQ/lYQ8YYb0v3EwteCZ8yK1F7XOL2jgWeJnTcDA==
X-Received: by 2002:a17:906:309b:: with SMTP id 27mr368490ejv.129.1637267848608;
        Thu, 18 Nov 2021 12:37:28 -0800 (PST)
Received: from t470p (host-95-252-102-163.retail.telecomitalia.it. [95.252.102.163])
        by smtp.gmail.com with ESMTPSA id gz26sm334052ejc.100.2021.11.18.12.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 12:37:28 -0800 (PST)
Date:   Thu, 18 Nov 2021 21:37:26 +0100
From:   Alberto Merciai <alb3rt0.m3rciai@gmail.com>
To:     alb3rt0.m3rciai@gmail.com
Cc:     forest@alittletooquiet.net, gregkh@linuxfoundation.org,
        alb3rt0.m3rciai@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] staging: vt6655: refactor camelcase uCurrRSSI to
 current_rssi
Message-ID: <20211118203726.GA153646@t470p>
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

v3
- change tab with whitespace next to current_rssi
v2
- correct mailing list
v1
- remove whitespaces

 drivers/staging/vt6654/device.h      | 2 +-
 drivers/staging/vt6655/device_main.c | 4 ++--
 drivers/staging/vt6655/dpc.c         | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/vt6655/device.h b/drivers/staging/vt6655/device.h
index 29f354ced563..dffd9b2db575 100644
--- a/drivers/staging/vt6655/device.h
+++ b/drivers/staging/vt6655/device.h
@@ -167,7 +167,7 @@ struct vnt_private {
 	unsigned char abyCurrentNetAddr[ETH_ALEN]; __aligned(2)
 	bool bLinkPass;          /* link status: OK or fail */
 
-	unsigned int	uCurrRSSI;
+	unsigned int current_rssi;
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

