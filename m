Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23789326F29
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Feb 2021 23:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbhB0WYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Feb 2021 17:24:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbhB0WXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Feb 2021 17:23:55 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2C6C061788
        for <linux-kernel@vger.kernel.org>; Sat, 27 Feb 2021 14:23:14 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id k12so5869217ljg.9
        for <linux-kernel@vger.kernel.org>; Sat, 27 Feb 2021 14:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uXpwxr7TUV/Z8qxPoO7S8pXAiEh9GOQdULn01SJ7/aA=;
        b=OPI1+PcrKi44YAcLvqwdQdka3HgLn2m9DT7mfN6zEfyDtfVepi3YJqYQnM9kDJn8gO
         E6BVfD4s/PCS/kdYtGWI9VKwtYmyMRZ575Ph4V/zKW11PkXTsM+ZvDHTTl6bEkBEQpQ8
         FRh9UEVje1e9rFiH57Cm8yWx7cH3jvSdYKREyQBe+c6spcrggCSmLuB4vV/b1tGs7zqc
         r7MheP4ZdGC+XULMKoo+XTBjagCxfDTzNZxPEIt3yxJG09UCMIM9ecaJkAVH+alRkUCN
         PttlloI8EPod3BgZHXM/oEUB0uUALGIVMYDE9+UJckvrQmdkW4iTRYdvIS4Zyn/DleAE
         onNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uXpwxr7TUV/Z8qxPoO7S8pXAiEh9GOQdULn01SJ7/aA=;
        b=o+6cXEQ8V2yr5YIqg7sgKB2Ryu/wQGuYvs2FCRsAXLupwEQWaUYtd6WtTbvx+ZRtTj
         P5WSJ87/gT38+LKJejQvl+2/JDfQvPbUeOed5bst85boRVTQgUpMAMsT0A1gn/XFgN8g
         9yF69rEJLgnc04OzPYMIljBEbikm+gwXV8qL5ZO3bXNSaUJYp7j+RZuw/3WmP5nu7FGt
         IO3JlPOVCPNGkA5REVKQRukFrR2uf/oG6lbqJVAPdQvvj6BR0s/EsUBTXM7nDwf7zEHk
         lxnYKSkX7+QxsqixN/1YCmXkncXZuevXBHi6JJiTDQ8rFIpxkqvggskNKNe71Mbfet32
         nTng==
X-Gm-Message-State: AOAM533foTS4uz9/TYgz7gjVk6GdwrmpzBzcccAcUd90Hmj0r3p4gvQi
        3SlXaO/LQUvEnBOeTpvlEnc=
X-Google-Smtp-Source: ABdhPJx8aVQD4DqxYHTK8wfmhRUMM2i2v1zYuvkrIYYWJOyURiVtKEGMbuYLiPX1J4e9bsEefNkTsw==
X-Received: by 2002:a2e:81cd:: with SMTP id s13mr5127919ljg.323.1614464592994;
        Sat, 27 Feb 2021 14:23:12 -0800 (PST)
Received: from alpha (10.177.smarthome.spb.ru. [109.71.177.10])
        by smtp.gmail.com with ESMTPSA id k10sm835923lfo.75.2021.02.27.14.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Feb 2021 14:23:12 -0800 (PST)
Received: (nullmailer pid 581549 invoked by uid 1000);
        Sat, 27 Feb 2021 22:23:10 -0000
From:   Ivan Safonov <insafonov@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Michael Straube <straube.linux@gmail.com>,
        Pascal Terjan <pterjan@google.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Ivan Safonov <insafonov@gmail.com>
Subject: [PATCH 3/4] staging:rtl8712: use IEEE80211_FCTL_* kernel definitions
Date:   Sun, 28 Feb 2021 01:22:36 +0300
Message-Id: <20210227222236.581490-4-insafonov@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210227222236.581490-1-insafonov@gmail.com>
References: <20210227222236.581490-1-insafonov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

_TO_DS_, _FROM_DS_, _MORE_FRAG_, _RETRY_, _PWRMGT_, _MORE_DATA_,
_PRIVACY_, _ORDER_ definitions are duplicate IEEE80211_FCTL_*
kernel definitions.

Signed-off-by: Ivan Safonov <insafonov@gmail.com>
---
 drivers/staging/rtl8712/wifi.h | 52 ++++++++++++++--------------------
 1 file changed, 22 insertions(+), 30 deletions(-)

diff --git a/drivers/staging/rtl8712/wifi.h b/drivers/staging/rtl8712/wifi.h
index 11fba6f9e721..b7889ac3dce9 100644
--- a/drivers/staging/rtl8712/wifi.h
+++ b/drivers/staging/rtl8712/wifi.h
@@ -15,6 +15,7 @@
 #define _WIFI_H_
 
 #include <linux/compiler.h>
+#include <linux/ieee80211.h>
 
 #define WLAN_HDR_A3_LEN		24
 #define WLAN_HDR_A3_QOS_LEN	26
@@ -74,33 +75,24 @@ enum WIFI_REG_DOMAIN {
 	DOMAIN_MAX
 };
 
-#define _TO_DS_		BIT(8)
-#define _FROM_DS_	BIT(9)
-#define _MORE_FRAG_	BIT(10)
-#define _RETRY_		BIT(11)
-#define _PWRMGT_	BIT(12)
-#define _MORE_DATA_	BIT(13)
-#define _PRIVACY_	BIT(14)
-#define _ORDER_		BIT(15)
-
 #define SetToDs(pbuf) ({ \
-	*(__le16 *)(pbuf) |= cpu_to_le16(_TO_DS_); \
+	*(__le16 *)(pbuf) |= cpu_to_le16(IEEE80211_FCTL_TODS); \
 })
 
-#define GetToDs(pbuf)	(((*(__le16 *)(pbuf)) & cpu_to_le16(_TO_DS_)) != 0)
+#define GetToDs(pbuf)	(((*(__le16 *)(pbuf)) & cpu_to_le16(IEEE80211_FCTL_TODS)) != 0)
 
 #define ClearToDs(pbuf)	({ \
-	*(__le16 *)(pbuf) &= (~cpu_to_le16(_TO_DS_)); \
+	*(__le16 *)(pbuf) &= (~cpu_to_le16(IEEE80211_FCTL_TODS)); \
 })
 
 #define SetFrDs(pbuf) ({ \
-	*(__le16 *)(pbuf) |= cpu_to_le16(_FROM_DS_); \
+	*(__le16 *)(pbuf) |= cpu_to_le16(IEEE80211_FCTL_FROMDS); \
 })
 
-#define GetFrDs(pbuf)	(((*(__le16 *)(pbuf)) & cpu_to_le16(_FROM_DS_)) != 0)
+#define GetFrDs(pbuf)	(((*(__le16 *)(pbuf)) & cpu_to_le16(IEEE80211_FCTL_FROMDS)) != 0)
 
 #define ClearFrDs(pbuf)	({ \
-	*(__le16 *)(pbuf) &= (~cpu_to_le16(_FROM_DS_)); \
+	*(__le16 *)(pbuf) &= (~cpu_to_le16(IEEE80211_FCTL_FROMDS)); \
 })
 
 static inline unsigned char get_tofr_ds(unsigned char *pframe)
@@ -109,56 +101,56 @@ static inline unsigned char get_tofr_ds(unsigned char *pframe)
 }
 
 #define SetMFrag(pbuf) ({ \
-	*(__le16 *)(pbuf) |= cpu_to_le16(_MORE_FRAG_); \
+	*(__le16 *)(pbuf) |= cpu_to_le16(IEEE80211_FCTL_MOREFRAGS); \
 })
 
-#define GetMFrag(pbuf)	(((*(__le16 *)(pbuf)) & cpu_to_le16(_MORE_FRAG_)) != 0)
+#define GetMFrag(pbuf)	(((*(__le16 *)(pbuf)) & cpu_to_le16(IEEE80211_FCTL_MOREFRAGS)) != 0)
 
 #define ClearMFrag(pbuf) ({ \
-	*(__le16 *)(pbuf) &= (~cpu_to_le16(_MORE_FRAG_)); \
+	*(__le16 *)(pbuf) &= (~cpu_to_le16(IEEE80211_FCTL_MOREFRAGS)); \
 })
 
 #define SetRetry(pbuf) ({ \
-	*(__le16 *)(pbuf) |= cpu_to_le16(_RETRY_); \
+	*(__le16 *)(pbuf) |= cpu_to_le16(IEEE80211_FCTL_RETRY); \
 })
 
-#define GetRetry(pbuf)	(((*(__le16 *)(pbuf)) & cpu_to_le16(_RETRY_)) != 0)
+#define GetRetry(pbuf)	(((*(__le16 *)(pbuf)) & cpu_to_le16(IEEE80211_FCTL_RETRY)) != 0)
 
 #define ClearRetry(pbuf) ({ \
-	*(__le16 *)(pbuf) &= (~cpu_to_le16(_RETRY_)); \
+	*(__le16 *)(pbuf) &= (~cpu_to_le16(IEEE80211_FCTL_RETRY)); \
 })
 
 #define SetPwrMgt(pbuf) ({ \
-	*(__le16 *)(pbuf) |= cpu_to_le16(_PWRMGT_); \
+	*(__le16 *)(pbuf) |= cpu_to_le16(IEEE80211_FCTL_PM); \
 })
 
 #define GetPwrMgt(pbuf)	(((*(__le16 *)(pbuf)) & \
-			cpu_to_le16(_PWRMGT_)) != 0)
+			cpu_to_le16(IEEE80211_FCTL_PM)) != 0)
 
 #define ClearPwrMgt(pbuf) ({ \
-	*(__le16 *)(pbuf) &= (~cpu_to_le16(_PWRMGT_)); \
+	*(__le16 *)(pbuf) &= (~cpu_to_le16(IEEE80211_FCTL_PM)); \
 })
 
 #define SetMData(pbuf) ({ \
-	*(__le16 *)(pbuf) |= cpu_to_le16(_MORE_DATA_); \
+	*(__le16 *)(pbuf) |= cpu_to_le16(IEEE80211_FCTL_MOREDATA); \
 })
 
 #define GetMData(pbuf)	(((*(__le16 *)(pbuf)) & \
-			cpu_to_le16(_MORE_DATA_)) != 0)
+			cpu_to_le16(IEEE80211_FCTL_MOREDATA)) != 0)
 
 #define ClearMData(pbuf) ({ \
-	*(__le16 *)(pbuf) &= (~cpu_to_le16(_MORE_DATA_)); \
+	*(__le16 *)(pbuf) &= (~cpu_to_le16(IEEE80211_FCTL_MOREDATA)); \
 })
 
 #define SetPrivacy(pbuf) ({ \
-	*(__le16 *)(pbuf) |= cpu_to_le16(_PRIVACY_); \
+	*(__le16 *)(pbuf) |= cpu_to_le16(IEEE80211_FCTL_PROTECTED); \
 })
 
 #define GetPrivacy(pbuf)	(((*(__le16 *)(pbuf)) & \
-				cpu_to_le16(_PRIVACY_)) != 0)
+				cpu_to_le16(IEEE80211_FCTL_PROTECTED)) != 0)
 
 #define GetOrder(pbuf)	(((*(__le16 *)(pbuf)) & \
-			cpu_to_le16(_ORDER_)) != 0)
+			cpu_to_le16(IEEE80211_FCTL_ORDER)) != 0)
 
 #define GetFrameType(pbuf)	(le16_to_cpu(*(__le16 *)(pbuf)) & \
 				(BIT(3) | BIT(2)))
-- 
2.26.2

