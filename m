Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34CDE4564F6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 22:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhKRVUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 16:20:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhKRVUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 16:20:04 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F55DC061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 13:17:03 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id w1so32942003edd.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 13:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=wyMx3V2KnsMHshkcvzDbgkTPDUvp34qBaCbDKr739rc=;
        b=cxQEFKruVtlqpRlV0d+YkU6bgLhjpN74tGql0DTY5mQOMBGKhTuD4oH00R2uVqITYt
         htSg8Ve6eCk0LD+8GL04PdeYemcgja576q2+LHvlRtX7mt0ms2Xx+lPwkXOuRoj4L9KW
         +67eg7rUMv+XxaTK9Z+QkfNgVCwkzl5enWkqBWwLLvJLJenHY9UgOeeNsaSccCkuOc6P
         VKkXEwwf1SZFOxxS0isGgHHGWT/gTfOodGco6yPKCIZz5kPCWaUwADBKNVbs9St8Vhq4
         qEoVxzzV2w1yAYyS+Jqs0/rXiPjUdeUl9wdw0Dg5ERcCB5qi7Ae4a1gCCFBuJsWsQbz8
         Q3JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=wyMx3V2KnsMHshkcvzDbgkTPDUvp34qBaCbDKr739rc=;
        b=uW6s/9sfJQjEYjQ+GZY1lNXDLEJuxgQ5oJ9UpKpeFQQwRE3pfVFsHemY+JPbE/3WnA
         QiQu+t4itXU/DMA1pQObE2LFVXtPUqApfklXfoDyRD1pe3SLpWpKc7kjgIZq8exqBFzs
         FIhpnDzLpz3zTzdYume5fyMU44Nf/ftxKDncsifnNwU/awAm3B09du0PTXCJ6Z2zr9Fa
         LSzOFRlfqNeAEnBA59LinF+ucJXbcJP2w7miqJr+oss8Fzncorp24YuHnHLO/jxqTpWp
         cNPko7w7uzBRcZuuKgksjxqUJ6ni6BGwpPP5bsVkH7fKGlsnxkTYFAKHPGJGWiV8bny0
         Nphg==
X-Gm-Message-State: AOAM531LiCOGEbzIILDSPjehcVWhizwQz6NbqpAVfsjnHYJH54EVqcMQ
        ZOi6N8Nl/0MiSFgWKUqqIA0=
X-Google-Smtp-Source: ABdhPJwKB7pAj5je6zrKVeO7m3nryuwYQkOBvPUGF77xmE9uJNA+keTuLqzdj20Kz3Yejj5fajjZfg==
X-Received: by 2002:a05:6402:34cd:: with SMTP id w13mr16060244edc.112.1637270222214;
        Thu, 18 Nov 2021 13:17:02 -0800 (PST)
Received: from t470p (host-95-252-102-163.retail.telecomitalia.it. [95.252.102.163])
        by smtp.gmail.com with ESMTPSA id l16sm582731edb.59.2021.11.18.13.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 13:17:01 -0800 (PST)
Date:   Thu, 18 Nov 2021 22:16:59 +0100
From:   Alberto Merciai <alb3rt0.m3rciai@gmail.com>
To:     alb3rt0.m3rciai@gmail.com
Cc:     joe@perches.com, forest@alittletooquiet.net,
        gregkh@linuxfoundation.org, karolinadrobnik@gmail.com,
        lucas.henneman@linaro.org, dan.carpenter@oracle.com,
        tomm.merciai@gmail.com, eantoranz@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH v5] staging: vt6655: refactor camelcase uCurrRSSI to
 current_rssi
Message-ID: <20211118211128.GA156436@t470p>
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
index 3768791d9744..ff171acc11f4 100644
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
index e74caf22d75a..1f98f2b069c4 100644
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

