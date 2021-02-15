Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D704C31C29F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 20:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbhBOTqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 14:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbhBOTp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 14:45:57 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5D1C061756
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 11:45:16 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id z190so1510841qka.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 11:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5dqyGvIHoacEP1moj9V+kZ65LXd0117/1bf4nofJZRQ=;
        b=QHU5M6dRg5rLgbKNrrCWFRjK0HJ6G8FvXG4kwExlCx4hvYNVbp/uSChWtM1zpmW6BG
         gnCjuTsuLx8BSktmal6LXg3vpU09kSI5M+2dVzskjs9D4tu3R4aVlTljTzY8bMaZSkjq
         BFvcFXgSwlte84eHffGxw76fddbmR0iJnNy40Wajchw7Kjyw55mZbtmyakwBSyb3Es/Q
         TtU5dK8TWRQtgQctqTPbstOptpVCq87H08ChHSzh8KOO3/7xcB4cg6hcYAApUbIoQVfZ
         bMPs6NLyFixZ1LJ6+8uKpet3moQeEbEd7DVuyITHbxJ1dioejxikmdFHITNIylYk1rXg
         xfrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5dqyGvIHoacEP1moj9V+kZ65LXd0117/1bf4nofJZRQ=;
        b=snMv6XSAEYQqVOxG4foGBRxw83huK0EUrH8bvqvkSBbyPUfCHq6aniSMkZ366Aw/gb
         INSjxOKJNYS6sV/Ck6P+31zMH2vCZtCH8/7/xHtY58fF8hNs/64mCwDcxjb7QWkBT0+2
         M5FFD6V++a1ls/0iu+NNflI9SOnV0HeL2u4481bhB1XfycJrP/nvCOlrSt9lsr4WINul
         OFtsWgxB/LuXW0YWr40/Pl9JctqWRH4QyfjB8tsH3pYGFDc77OKigrr6JjWiwm4O/oup
         3WJOoU1ZTFwndD/yv5tkkJQA6s0KQXdLcAvXMQk1dCPbxnurZe5V6JjVZTvFIip1Hnoj
         iDqw==
X-Gm-Message-State: AOAM531sgRRgqaoI4M3XFZCC8B+WkdiI94Rr1+CAAB8sAFrBV5zS+0SO
        1MiZz+r30W5HUBotqpxvvqE=
X-Google-Smtp-Source: ABdhPJyb3H3IAWNHJz7yNmekzuS9Zs7saDQRdVsI+JfhcbGZ73I7H47M/NeIkT/KtJ0vYZV7XdaSww==
X-Received: by 2002:a05:620a:4016:: with SMTP id h22mr16530732qko.491.1613418316059;
        Mon, 15 Feb 2021 11:45:16 -0800 (PST)
Received: from darkstar.example.net ([2804:d45:9905:9600:c57:100:d8b8:6ad3])
        by smtp.gmail.com with ESMTPSA id q12sm5795179qki.91.2021.02.15.11.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 11:45:15 -0800 (PST)
From:   Davidson Francis <davidsondfgl@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Davidson Francis <davidsondfgl@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8192e: Fix comparisons to NULL
Date:   Mon, 15 Feb 2021 16:44:41 -0300
Message-Id: <20210215194441.11430-1-davidsondfgl@gmail.com>
X-Mailer: git-send-email 2.29.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checkpatch prefers the shorter version (x / !x) over
(!= NULL / == NULL), respectively.

Signed-off-by: Davidson Francis <davidsondfgl@gmail.com>
---
 drivers/staging/rtl8192e/rtllib_wx.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_wx.c b/drivers/staging/rtl8192e/rtllib_wx.c
index 2e486ccb6432..ecd472baee16 100644
--- a/drivers/staging/rtl8192e/rtllib_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_wx.c
@@ -324,7 +324,7 @@ int rtllib_wx_set_encode(struct rtllib_device *ieee,
 		 * and if no key index was provided, de-init them all
 		 */
 		for (i = 0; i < NUM_WEP_KEYS; i++) {
-			if (ieee->crypt_info.crypt[i] != NULL) {
+			if (ieee->crypt_info.crypt[i]) {
 				if (key_provided)
 					break;
 				lib80211_crypt_delayed_deinit(&ieee->crypt_info,
@@ -344,7 +344,7 @@ int rtllib_wx_set_encode(struct rtllib_device *ieee,
 	sec.enabled = 1;
 	sec.flags |= SEC_ENABLED;
 
-	if (*crypt != NULL && (*crypt)->ops != NULL &&
+	if (*crypt && (*crypt)->ops &&
 	    strcmp((*crypt)->ops->name, "R-WEP") != 0) {
 		/* changing to use WEP; deinit previously used algorithm
 		 * on this key
@@ -352,12 +352,12 @@ int rtllib_wx_set_encode(struct rtllib_device *ieee,
 		lib80211_crypt_delayed_deinit(&ieee->crypt_info, crypt);
 	}
 
-	if (*crypt == NULL) {
+	if (!*crypt) {
 		struct lib80211_crypt_data *new_crypt;
 
 		/* take WEP into use */
 		new_crypt = kzalloc(sizeof(*new_crypt), GFP_KERNEL);
-		if (new_crypt == NULL)
+		if (!new_crypt)
 			return -ENOMEM;
 		new_crypt->ops = lib80211_get_crypto_ops("R-WEP");
 		if (!new_crypt->ops) {
@@ -484,7 +484,7 @@ int rtllib_wx_get_encode(struct rtllib_device *ieee,
 
 	erq->flags = key + 1;
 
-	if (crypt == NULL || crypt->ops == NULL) {
+	if (!crypt || !crypt->ops) {
 		erq->length = 0;
 		erq->flags |= IW_ENCODE_DISABLED;
 		return 0;
@@ -549,7 +549,7 @@ int rtllib_wx_set_encode_ext(struct rtllib_device *ieee,
 			lib80211_crypt_delayed_deinit(&ieee->crypt_info, crypt);
 
 		for (i = 0; i < NUM_WEP_KEYS; i++) {
-			if (ieee->crypt_info.crypt[i] != NULL)
+			if (ieee->crypt_info.crypt[i])
 				break;
 		}
 		if (i == NUM_WEP_KEYS) {
@@ -582,7 +582,7 @@ int rtllib_wx_set_encode_ext(struct rtllib_device *ieee,
 	netdev_dbg(dev, "alg name:%s\n", alg);
 
 	ops = lib80211_get_crypto_ops(alg);
-	if (ops == NULL) {
+	if (!ops) {
 		char tempbuf[100];
 
 		memset(tempbuf, 0x00, 100);
@@ -590,19 +590,19 @@ int rtllib_wx_set_encode_ext(struct rtllib_device *ieee,
 		request_module("%s", tempbuf);
 		ops = lib80211_get_crypto_ops(alg);
 	}
-	if (ops == NULL) {
+	if (!ops) {
 		netdev_info(dev, "========>unknown crypto alg %d\n", ext->alg);
 		ret = -EINVAL;
 		goto done;
 	}
 
-	if (*crypt == NULL || (*crypt)->ops != ops) {
+	if (!*crypt || (*crypt)->ops != ops) {
 		struct lib80211_crypt_data *new_crypt;
 
 		lib80211_crypt_delayed_deinit(&ieee->crypt_info, crypt);
 
 		new_crypt = kzalloc(sizeof(*new_crypt), GFP_KERNEL);
-		if (new_crypt == NULL) {
+		if (!new_crypt) {
 			ret = -ENOMEM;
 			goto done;
 		}
@@ -610,7 +610,7 @@ int rtllib_wx_set_encode_ext(struct rtllib_device *ieee,
 		if (new_crypt->ops && try_module_get(new_crypt->ops->owner))
 			new_crypt->priv = new_crypt->ops->init(idx);
 
-		if (new_crypt->priv == NULL) {
+		if (!new_crypt->priv) {
 			kfree(new_crypt);
 			ret = -EINVAL;
 			goto done;
@@ -766,7 +766,7 @@ int rtllib_wx_set_gen_ie(struct rtllib_device *ieee, u8 *ie, size_t len)
 	u8 *buf;
 	u8 eid, wps_oui[4] = {0x0, 0x50, 0xf2, 0x04};
 
-	if (len > MAX_WPA_IE_LEN || (len && ie == NULL))
+	if (len > MAX_WPA_IE_LEN || (len && !ie))
 		return -EINVAL;
 
 	if (len) {
@@ -776,7 +776,7 @@ int rtllib_wx_set_gen_ie(struct rtllib_device *ieee, u8 *ie, size_t len)
 
 			ieee->wps_ie_len = min_t(size_t, len, MAX_WZC_IE_LEN);
 			buf = kmemdup(ie, ieee->wps_ie_len, GFP_KERNEL);
-			if (buf == NULL)
+			if (!buf)
 				return -ENOMEM;
 			ieee->wps_ie = buf;
 			return 0;
@@ -789,7 +789,7 @@ int rtllib_wx_set_gen_ie(struct rtllib_device *ieee, u8 *ie, size_t len)
 		if (len != ie[1]+2)
 			return -EINVAL;
 		buf = kmemdup(ie, len, GFP_KERNEL);
-		if (buf == NULL)
+		if (!buf)
 			return -ENOMEM;
 		kfree(ieee->wpa_ie);
 		ieee->wpa_ie = buf;
-- 
2.29.1

