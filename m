Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D405834A4E1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbhCZJuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbhCZJtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:49:24 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE44DC0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:49:23 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id m20-20020a7bcb940000b029010cab7e5a9fso4568536wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3WoVeeuohXWqZrICJpFt7SabNLUW+Kq4A6OEPmpX/WA=;
        b=Ec0xB3ZS8wHdgCqc8PFUoFQufXHqWxvnj230NURucCeorhFDKk4AhHXDput7Ew1pmG
         kPBiD2U8hI5bSUKyN1ZkTi5wgTWldyX8JQ6/fQu18KubHhFpZo2qDoU7rNp5KFas9qDg
         YkG7bdgyfU9xhj4kHAFkVdMtnzjsfWZQCzbbaoQ25KUJ10ETJPTdQ9NNhUspN/U1aerC
         1ItxlbaFdUU/NyfoNwvRgAsEX5YW/MYnHRY+1bMCegOs8OJubCYzPQwbyYI07D0t3Ibu
         6hkjwNskmRbZ7Oo1Ttg4OrGDJ1dAyW20oNWN/MspBlrAGpsNiRbskjYOdMEFhp0fFWkZ
         rrDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3WoVeeuohXWqZrICJpFt7SabNLUW+Kq4A6OEPmpX/WA=;
        b=ChUuX88PceSdheQBsB49Gd+tigDirqOstVWWcQ8IheDJ13Z7iVwf7nAi7XfwZYdn51
         fUyaim7gf4bL7qhdSn33mYMN0bHzHTGWDDiqoXRXBJatShJhsMCw+9dKajDWdM7MbgSq
         hnvfM/K+C34J1dP7HzKd6hZSBa4JYnhoAIwcYpCkRtP9MRJdMoYlEme2peSZrK1qiWKQ
         cM41Mngk3GSH9Yolt5ir3Uu593l/7TRNleJuWZbZsCmNe6JY/UajaBMMhUMpvm3xYdFc
         iBft2PTk/U3BCHSKiXMW89dJE+rZjL4c++p16WZLpUemRtlXYb6vgk+T7Tkv/YMfShWa
         OFaw==
X-Gm-Message-State: AOAM533Rj97JRFWYv6ISJ/kWa+jBg7oZlgJwX41rq2tjJGazOzfdtAno
        dVenRRwCTwORkNg3r1cEOC8=
X-Google-Smtp-Source: ABdhPJy8Hu4XaYiPORO+mEB8nq50ZcVGCZyyFI9IJ4ksuWi5IFe4rewMT8IS8o3Zmkvz51H+k4Df7w==
X-Received: by 2002:a05:600c:2102:: with SMTP id u2mr12241366wml.22.1616752162517;
        Fri, 26 Mar 2021 02:49:22 -0700 (PDT)
Received: from lorien (home.raoult.com. [78.214.78.108])
        by smtp.gmail.com with ESMTPSA id z82sm9341079wmg.19.2021.03.26.02.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 02:49:21 -0700 (PDT)
Received: by lorien (Postfix, from userid 1000)
        id DA5F314021D; Fri, 26 Mar 2021 10:49:19 +0100 (CET)
From:   Bruno Raoult <braoult@gmail.com>
To:     gregkh@linuxfoundation.org, straube.linux@gmail.com,
        zhaoxiao@uniontech.com, dan.carpenter@oracle.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Bruno Raoult <braoult@gmail.com>
Subject: [PATCH 1/5] r8192U_wx.c: style: alignment with open parenthesis
Date:   Fri, 26 Mar 2021 10:48:31 +0100
Message-Id: <34f4134241f49d1694cbfb9c2185e3ef54284680.1616748922.git.braoult@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1616748922.git.braoult@gmail.com>
References: <cover.1616748922.git.braoult@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix checkpatch.pl check:

CHECK: Alignment should match open parenthesis
in drivers/staging/rtl8192u/r8192U_wx.c

Signed-off-by: Bruno Raoult <braoult@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_wx.c | 124 +++++++++++++--------------
 1 file changed, 62 insertions(+), 62 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_wx.c b/drivers/staging/rtl8192u/r8192U_wx.c
index e6ff310f3e90..3ff6da837ac1 100644
--- a/drivers/staging/rtl8192u/r8192U_wx.c
+++ b/drivers/staging/rtl8192u/r8192U_wx.c
@@ -77,8 +77,8 @@ static int r8192_wx_set_rate(struct net_device *dev,
 }
 
 static int r8192_wx_set_rts(struct net_device *dev,
-			     struct iw_request_info *info,
-			     union iwreq_data *wrqu, char *extra)
+			    struct iw_request_info *info,
+			    union iwreq_data *wrqu, char *extra)
 {
 	int ret;
 	struct r8192_priv *priv = ieee80211_priv(dev);
@@ -93,8 +93,8 @@ static int r8192_wx_set_rts(struct net_device *dev,
 }
 
 static int r8192_wx_get_rts(struct net_device *dev,
-			     struct iw_request_info *info,
-			     union iwreq_data *wrqu, char *extra)
+			    struct iw_request_info *info,
+			    union iwreq_data *wrqu, char *extra)
 {
 	struct r8192_priv *priv = ieee80211_priv(dev);
 
@@ -102,8 +102,8 @@ static int r8192_wx_get_rts(struct net_device *dev,
 }
 
 static int r8192_wx_set_power(struct net_device *dev,
-			     struct iw_request_info *info,
-			     union iwreq_data *wrqu, char *extra)
+			      struct iw_request_info *info,
+			      union iwreq_data *wrqu, char *extra)
 {
 	int ret;
 	struct r8192_priv *priv = ieee80211_priv(dev);
@@ -118,8 +118,8 @@ static int r8192_wx_set_power(struct net_device *dev,
 }
 
 static int r8192_wx_get_power(struct net_device *dev,
-			     struct iw_request_info *info,
-			     union iwreq_data *wrqu, char *extra)
+			      struct iw_request_info *info,
+			      union iwreq_data *wrqu, char *extra)
 {
 	struct r8192_priv *priv = ieee80211_priv(dev);
 
@@ -127,8 +127,8 @@ static int r8192_wx_get_power(struct net_device *dev,
 }
 
 static int r8192_wx_force_reset(struct net_device *dev,
-		struct iw_request_info *info,
-		union iwreq_data *wrqu, char *extra)
+				struct iw_request_info *info,
+				union iwreq_data *wrqu, char *extra)
 {
 	struct r8192_priv *priv = ieee80211_priv(dev);
 
@@ -141,8 +141,8 @@ static int r8192_wx_force_reset(struct net_device *dev,
 }
 
 static int r8192_wx_set_rawtx(struct net_device *dev,
-			       struct iw_request_info *info,
-			       union iwreq_data *wrqu, char *extra)
+			      struct iw_request_info *info,
+			      union iwreq_data *wrqu, char *extra)
 {
 	struct r8192_priv *priv = ieee80211_priv(dev);
 	int ret;
@@ -456,9 +456,9 @@ static int r8192_wx_get_frag(struct net_device *dev,
 }
 
 static int r8192_wx_set_wap(struct net_device *dev,
-			 struct iw_request_info *info,
-			 union iwreq_data *awrq,
-			 char *extra)
+			    struct iw_request_info *info,
+			    union iwreq_data *awrq,
+			    char *extra)
 {
 	int ret;
 	struct r8192_priv *priv = ieee80211_priv(dev);
@@ -557,23 +557,23 @@ static int r8192_wx_set_enc(struct net_device *dev,
 			EnableHWSecurityConfig8192(dev);
 
 			setKey(dev,
-				key_idx,                /* EntryNo */
-				key_idx,                /* KeyIndex */
-				KEY_TYPE_WEP40,         /* KeyType */
-				zero_addr[key_idx],
-				0,                      /* DefaultKey */
-				hwkey);                 /* KeyContent */
+			       key_idx,                /* EntryNo */
+			       key_idx,                /* KeyIndex */
+			       KEY_TYPE_WEP40,         /* KeyType */
+			       zero_addr[key_idx],
+			       0,                      /* DefaultKey */
+			       hwkey);                 /* KeyContent */
 		} else if (wrqu->encoding.length == 0xd) {
 			ieee->pairwise_key_type = KEY_TYPE_WEP104;
 			EnableHWSecurityConfig8192(dev);
 
 			setKey(dev,
-				key_idx,                /* EntryNo */
-				key_idx,                /* KeyIndex */
-				KEY_TYPE_WEP104,        /* KeyType */
-				zero_addr[key_idx],
-				0,                      /* DefaultKey */
-				hwkey);                 /* KeyContent */
+			       key_idx,                /* EntryNo */
+			       key_idx,                /* KeyIndex */
+			       KEY_TYPE_WEP104,        /* KeyType */
+			       zero_addr[key_idx],
+			       0,                      /* DefaultKey */
+			       hwkey);                 /* KeyContent */
 		} else {
 			netdev_warn(dev, "wrong type in WEP, not WEP40 and WEP104\n");
 		}
@@ -583,7 +583,7 @@ static int r8192_wx_set_enc(struct net_device *dev,
 }
 
 static int r8192_wx_set_scan_type(struct net_device *dev, struct iw_request_info *aa,
-					union iwreq_data *wrqu, char *p)
+				  union iwreq_data *wrqu, char *p)
 {
 	struct r8192_priv *priv = ieee80211_priv(dev);
 	int *parms = (int *)p;
@@ -595,8 +595,8 @@ static int r8192_wx_set_scan_type(struct net_device *dev, struct iw_request_info
 }
 
 static int r8192_wx_set_retry(struct net_device *dev,
-				struct iw_request_info *info,
-				union iwreq_data *wrqu, char *extra)
+			      struct iw_request_info *info,
+			      union iwreq_data *wrqu, char *extra)
 {
 	struct r8192_priv *priv = ieee80211_priv(dev);
 	int err = 0;
@@ -640,8 +640,8 @@ static int r8192_wx_set_retry(struct net_device *dev,
 }
 
 static int r8192_wx_get_retry(struct net_device *dev,
-				struct iw_request_info *info,
-				union iwreq_data *wrqu, char *extra)
+			      struct iw_request_info *info,
+			      union iwreq_data *wrqu, char *extra)
 {
 	struct r8192_priv *priv = ieee80211_priv(dev);
 
@@ -663,8 +663,8 @@ static int r8192_wx_get_retry(struct net_device *dev,
 }
 
 static int r8192_wx_get_sens(struct net_device *dev,
-				struct iw_request_info *info,
-				union iwreq_data *wrqu, char *extra)
+			     struct iw_request_info *info,
+			     union iwreq_data *wrqu, char *extra)
 {
 	struct r8192_priv *priv = ieee80211_priv(dev);
 
@@ -675,8 +675,8 @@ static int r8192_wx_get_sens(struct net_device *dev,
 }
 
 static int r8192_wx_set_sens(struct net_device *dev,
-				struct iw_request_info *info,
-				union iwreq_data *wrqu, char *extra)
+			     struct iw_request_info *info,
+			     union iwreq_data *wrqu, char *extra)
 {
 	struct r8192_priv *priv = ieee80211_priv(dev);
 	short err = 0;
@@ -699,8 +699,8 @@ static int r8192_wx_set_sens(struct net_device *dev,
 
 /* hw security need to reorganized. */
 static int r8192_wx_set_enc_ext(struct net_device *dev,
-					struct iw_request_info *info,
-					union iwreq_data *wrqu, char *extra)
+				struct iw_request_info *info,
+				union iwreq_data *wrqu, char *extra)
 {
 	int ret = 0;
 	struct r8192_priv *priv = ieee80211_priv(dev);
@@ -738,29 +738,29 @@ static int r8192_wx_set_enc_ext(struct net_device *dev,
 
 		if ((alg & KEY_TYPE_WEP40) && (ieee->auth_mode != 2)) {
 			setKey(dev,
-					idx,	/* EntryNao */
-					idx,	/* KeyIndex */
-					alg,	/* KeyType */
-					zero,	/* MacAddr */
-					0,	/* DefaultKey */
-					key);	/* KeyContent */
+			       idx,	/* EntryNao */
+			       idx,	/* KeyIndex */
+			       alg,	/* KeyType */
+			       zero,	/* MacAddr */
+			       0,	/* DefaultKey */
+			       key);	/* KeyContent */
 		} else if (group) {
 			ieee->group_key_type = alg;
 			setKey(dev,
-					idx,	/* EntryNo */
-					idx,	/* KeyIndex */
-					alg,	/* KeyType */
-					broadcast_addr,	/* MacAddr */
-					0,		/* DefaultKey */
-					key);		/* KeyContent */
+			       idx,	/* EntryNo */
+			       idx,	/* KeyIndex */
+			       alg,	/* KeyType */
+			       broadcast_addr,	/* MacAddr */
+			       0,		/* DefaultKey */
+			       key);		/* KeyContent */
 		} else {	/* pairwise key */
 			setKey(dev,
-					4,	/* EntryNo */
-					idx,	/* KeyIndex */
-					alg,	/* KeyType */
-					(u8 *)ieee->ap_mac_addr,/* MacAddr */
-					0,			/* DefaultKey */
-					key);			/* KeyContent */
+			       4,	/* EntryNo */
+			       idx,	/* KeyIndex */
+			       alg,	/* KeyType */
+			       (u8 *)ieee->ap_mac_addr,/* MacAddr */
+			       0,			/* DefaultKey */
+			       key);			/* KeyContent */
 		}
 	}
 
@@ -771,8 +771,8 @@ static int r8192_wx_set_enc_ext(struct net_device *dev,
 }
 
 static int r8192_wx_set_auth(struct net_device *dev,
-					struct iw_request_info *info,
-					union iwreq_data *data, char *extra)
+			     struct iw_request_info *info,
+			     union iwreq_data *data, char *extra)
 {
 	int ret = 0;
 	struct r8192_priv *priv = ieee80211_priv(dev);
@@ -784,8 +784,8 @@ static int r8192_wx_set_auth(struct net_device *dev,
 }
 
 static int r8192_wx_set_mlme(struct net_device *dev,
-					struct iw_request_info *info,
-					union iwreq_data *wrqu, char *extra)
+			     struct iw_request_info *info,
+			     union iwreq_data *wrqu, char *extra)
 {
 	int ret = 0;
 	struct r8192_priv *priv = ieee80211_priv(dev);
@@ -798,8 +798,8 @@ static int r8192_wx_set_mlme(struct net_device *dev,
 }
 
 static int r8192_wx_set_gen_ie(struct net_device *dev,
-					struct iw_request_info *info,
-					union iwreq_data *data, char *extra)
+			       struct iw_request_info *info,
+			       union iwreq_data *data, char *extra)
 {
 	int ret = 0;
 	struct r8192_priv *priv = ieee80211_priv(dev);
-- 
2.27.0

