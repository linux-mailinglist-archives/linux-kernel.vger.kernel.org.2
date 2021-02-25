Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 075753248F8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 03:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234044AbhBYCp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 21:45:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234796AbhBYCpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 21:45:54 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07592C061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 18:45:09 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id o63so2824371pgo.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 18:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ymnx9lHJicynz6NYMtvoF1FplhRLE5fnNNKzFPIMwhA=;
        b=XfJRLRxUICKLf3fxrIN8IXEyk3oUxiHC8oWGwr9Cr1h3gu3k+aSdUJ2eTsPXVE0sFh
         U6DXwTQjDApu9Sgavsst9r8UrfxgsbR+u6DjXGak0jziNEmFZ9WsTWUORcS47vOqDx2P
         pgq6ND+DQVbFIASqKdwktjnZ7gP1PDow+x7Fw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ymnx9lHJicynz6NYMtvoF1FplhRLE5fnNNKzFPIMwhA=;
        b=aCGXJmUn78oYumWKlTyvX9L9GmwR1qbanudWHBl3i7Qjm7wbrE5y3T76iX992UHtqO
         miU999fmuV5jWJ0iEtbzrQcWAwpN8XLfcipkzSsiNmctTpM1HBJjRvH7sVRoXZWg/7is
         hMphzL4/G9I25JMrqTb0afMXyBqQzLbRJU5G3bwaH4POgj8n5hMg3RkAIJTRuD2k1y0Z
         2akVa12BCszHhuLc6CZla4LGtsH9pv33FogkA8yk3Sr+3CeOsArfKRCzhMlP4NphmnWs
         UEfKFgACdxE3QQc4V9BYv3e8bV/RM45x30yRoIWAFT93Fpi17cNL86YDcQOnVxFcxolM
         zENw==
X-Gm-Message-State: AOAM531ZjRpr0JeGcrdqHlBUFRSgjl5n5L9LwT1mqs85F9XKTqnXdVtu
        KpRGSzw3DMjfaVbqEPM/Otr2Iw==
X-Google-Smtp-Source: ABdhPJygPAKqxuUQlaE7SvFbYF1Ertdh2bCRBxXNdFMM/jaZm8itWKtJh9tInsWHCwbsVD7MOkIU6Q==
X-Received: by 2002:a63:4658:: with SMTP id v24mr963074pgk.258.1614221108613;
        Wed, 24 Feb 2021 18:45:08 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:a87f:b24e:bab3:2bfa])
        by smtp.gmail.com with ESMTPSA id j15sm4334858pjg.40.2021.02.24.18.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 18:45:08 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     linux-wireless@vger.kernel.org
Cc:     <linux-kernel@vger.kernel.org>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH] mwifiex: don't print SSID to logs
Date:   Wed, 24 Feb 2021 18:44:54 -0800
Message-Id: <20210225024454.4106485-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a few reasons not to dump SSIDs as-is in kernel logs:

1) they're not guaranteed to be any particular text encoding (UTF-8,
   ASCII, ...) in general
2) it's somewhat redundant; the BSSID should be enough to uniquely
   identify the AP/STA to which we're connecting
3) BSSIDs have an easily-recognized format, whereas SSIDs do not (they
   are free-form)
4) other common drivers (e.g., everything based on mac80211) get along
   just fine by only including BSSIDs when logging state transitions

Additional notes on reason #3: this is important for the
privacy-conscious, especially when providing tools that convey
kernel logs on behalf of a user -- e.g., when reporting bugs. So for
example, it's easy to automatically filter logs for MAC addresses, but
it's much harder to filter SSIDs out of unstructured text.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 drivers/net/wireless/marvell/mwifiex/cfg80211.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index a2ed268ce0da..0961f4a5e415 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -2300,8 +2300,7 @@ mwifiex_cfg80211_assoc(struct mwifiex_private *priv, size_t ssid_len,
 			is_scanning_required = 1;
 		} else {
 			mwifiex_dbg(priv->adapter, MSG,
-				    "info: trying to associate to '%.*s' bssid %pM\n",
-				    req_ssid.ssid_len, (char *)req_ssid.ssid,
+				    "info: trying to associate to bssid %pM\n",
 				    bss->bssid);
 			memcpy(&priv->cfg_bssid, bss->bssid, ETH_ALEN);
 			break;
@@ -2378,8 +2377,7 @@ mwifiex_cfg80211_connect(struct wiphy *wiphy, struct net_device *dev,
 	}
 
 	mwifiex_dbg(adapter, INFO,
-		    "info: Trying to associate to %.*s and bssid %pM\n",
-		    (int)sme->ssid_len, (char *)sme->ssid, sme->bssid);
+		    "info: Trying to associate to bssid %pM\n", sme->bssid);
 
 	if (!mwifiex_stop_bg_scan(priv))
 		cfg80211_sched_scan_stopped_locked(priv->wdev.wiphy, 0);
@@ -2512,9 +2510,8 @@ mwifiex_cfg80211_join_ibss(struct wiphy *wiphy, struct net_device *dev,
 		goto done;
 	}
 
-	mwifiex_dbg(priv->adapter, MSG,
-		    "info: trying to join to %.*s and bssid %pM\n",
-		    params->ssid_len, (char *)params->ssid, params->bssid);
+	mwifiex_dbg(priv->adapter, MSG, "info: trying to join to bssid %pM\n",
+		    params->bssid);
 
 	mwifiex_set_ibss_params(priv, params);
 
-- 
2.30.0.617.g56c4b15f3c-goog

