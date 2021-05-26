Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB7F9391974
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 16:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbhEZOGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 10:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbhEZOGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 10:06:07 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5772C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 07:04:34 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id f9so732975vsp.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 07:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uQqGtYMr2zlLbcLVkcKrC3bk86zDK/4KzT5M92QS2z8=;
        b=js0k+v30ImDal3nu+/B9Tvhdzxml+LpwXVkA6WLASYT7Mug29dZ2qe5dl5t2NouImy
         +Lqx++Xq+upNIti72W3v3QtK2lh1Gzgf3OGidOYsVedDayOylmIDfVMIjtYZDpLpfD7w
         hUbxgUBgK9y958DlbeQMsjZ464wapULJK5RKqvNj9vITzfxsBtU2lfZA61CZpGpFV11V
         N+LwRbMtHPKOW9AYqf8opwM+MxULdhwUk4MUt0W9+VHXYSpgpUdEhmVqQLUC6VO9JSfZ
         zF87yHTc7/GQWwjt4fz845y6qMOYNin08fkirflQeOmKyEjJjaiPgA4HcOE26vjm7mU9
         hapQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uQqGtYMr2zlLbcLVkcKrC3bk86zDK/4KzT5M92QS2z8=;
        b=XR1Ti3Hqy6cyaCViALgN4JnBX31t65A62ZqJtIYfQ+hqXcF9ASYKSu/2Ud2COBOI9D
         SYMf/qIdwW3xp/BkcYUkzR+Uzzg+B2cZ+oEljSAXrt076wR21I71UgUHieNZYI4HQcZG
         6T0I3GXvAMKrrV5fKmEUhIj7dNsLjAMXQ2G24/3U3QlF+3bbdTMwjhJW5+FtkVOAXrC8
         w5JVTTjtp1S4La1pWoTITc/QMtGGXfT2am0rdyUv2Dfpj8L3X1qLlQ0KVaEi5oVscjVv
         2FjWro1/TyovEisDmCnuzrID0WZlQTla22/oEwh0htLeyuA6G4t/zAaC1wJHU3oGz/s6
         uXMA==
X-Gm-Message-State: AOAM532tY7VIGcwfF24iGRO8E67OGQ0k5LICzNrnbTWnGCFHbWuo9JvF
        BQ6qXecZAlIv+pKapWscLhY=
X-Google-Smtp-Source: ABdhPJxr7d/4yuItMUDK3EeiOYXQRE1LsT4KeRccReNM27n6EYZdsge6foszt+L3iAJUkKN/3MhaPQ==
X-Received: by 2002:a67:1684:: with SMTP id 126mr31603327vsw.37.1622037873952;
        Wed, 26 May 2021 07:04:33 -0700 (PDT)
Received: from localhost.localdomain ([65.48.163.91])
        by smtp.gmail.com with ESMTPSA id o5sm2025488vke.32.2021.05.26.07.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 07:04:33 -0700 (PDT)
From:   Sean Gloumeau <sajgloumeau@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>
Cc:     Sean Gloumeau <sajgloumeau@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: vt6655: key.c: Fix coding style issues
Date:   Wed, 26 May 2021 10:03:09 -0400
Message-Id: <20210526140309.23376-1-sajgloumeau@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes were made to comply with the suggestions present
in Documentation/process/coding-style.rst as a requirement for Task 10
of the Eudyptula challenge.

Signed-off-by: Sean Gloumeau <sajgloumeau@gmail.com>
---
 drivers/staging/vt6655/key.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/vt6655/key.c b/drivers/staging/vt6655/key.c
index 94665ddc36a5..d1470ff55e06 100644
--- a/drivers/staging/vt6655/key.c
+++ b/drivers/staging/vt6655/key.c
@@ -64,7 +64,7 @@ static int vnt_set_keymode(struct ieee80211_hw *hw, u8 *mac_addr,
 		key_mode |= (mode << 4);
 		key_mode |= VNT_KEY_GROUP;
 		break;
-	case  VNT_KEY_PAIRWISE:
+	case VNT_KEY_PAIRWISE:
 		key_mode |= mode;
 		key_inx = 4;
 		break;
@@ -82,8 +82,8 @@ static int vnt_set_keymode(struct ieee80211_hw *hw, u8 *mac_addr,
 			key->key[15] |= 0x80;
 	}
 
-	MACvSetKeyEntry(priv, key_mode, entry, key_inx,
-			bssid, (u32 *)key->key, priv->byLocalID);
+	MACvSetKeyEntry(priv, key_mode, entry, key_inx, bssid, (u32 *)key->key,
+			priv->byLocalID);
 
 	return 0;
 }
@@ -103,7 +103,7 @@ int vnt_set_keys(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
 
 	switch (key->cipher) {
 	case 0:
-		for (u = 0 ; u < MAX_KEY_TABLE; u++)
+		for (u = 0; u < MAX_KEY_TABLE; u++)
 			MACvDisableKeyEntry(priv, u);
 		return ret;
 
@@ -112,8 +112,8 @@ int vnt_set_keys(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
 		for (u = 0; u < MAX_KEY_TABLE; u++)
 			MACvDisableKeyEntry(priv, u);
 
-		vnt_set_keymode(hw, mac_addr,
-				key, VNT_KEY_DEFAULTKEY, KEY_CTL_WEP, true);
+		vnt_set_keymode(hw, mac_addr, key, VNT_KEY_DEFAULTKEY,
+				KEY_CTL_WEP, true);
 
 		key->flags |= IEEE80211_KEY_FLAG_GENERATE_IV;
 
@@ -132,14 +132,14 @@ int vnt_set_keys(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
 	}
 
 	if (key->flags & IEEE80211_KEY_FLAG_PAIRWISE) {
-		vnt_set_keymode(hw, mac_addr,
-				key, VNT_KEY_PAIRWISE, key_dec_mode, true);
+		vnt_set_keymode(hw, mac_addr, key, VNT_KEY_PAIRWISE,
+				key_dec_mode, true);
 	} else {
-		vnt_set_keymode(hw, mac_addr,
-				key, VNT_KEY_DEFAULTKEY, key_dec_mode, true);
+		vnt_set_keymode(hw, mac_addr, key, VNT_KEY_DEFAULTKEY,
+				key_dec_mode, true);
 
-		vnt_set_keymode(hw, (u8 *)conf->bssid,
-				key, VNT_KEY_GROUP_ADDRESS, key_dec_mode, true);
+		vnt_set_keymode(hw, (u8 *)conf->bssid, key,
+				VNT_KEY_GROUP_ADDRESS, key_dec_mode, true);
 	}
 
 	return 0;
-- 
2.31.1

