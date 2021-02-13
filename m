Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A61331AB97
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 14:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbhBMNRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 08:17:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbhBMNRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 08:17:12 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11C3C061756
        for <linux-kernel@vger.kernel.org>; Sat, 13 Feb 2021 05:16:30 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id p21so3427768lfu.11
        for <linux-kernel@vger.kernel.org>; Sat, 13 Feb 2021 05:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1IwuTREhFP8d9ZWKkA5JdYA4S8M6KiAe3Ff0MI1TUoM=;
        b=NgAgtxrEUm9ITgTHJj0GiOn1zOWEy/HFxLmf1EFIg6/d+/sVEG3GObVARsQu9rNti8
         u7Mf/C4xe50kxW6jKQhAIHWEfXsMu5R0Ew0ahObfJIQjxX1Jys4XYAtbhm70aYKvqKcJ
         Ib59T/l+76kgo/6nBg8960HyaY+cV6KBcWrB1YmBJgMDBRb1Knt2el3e+HgkB5L7ZjQe
         NYqgz4RC0qgyeyvyVL1XOEEFEs6T1ZXDMEk9Z7LOpn3la/KL5ESdPPSQHIFj4qJL15Bc
         rEaDoBHbyCDUMCPjKj6MHStTkMNfRjrQqhpNoVpcmFT3LXjSnAFZRvjyGjABlOLEx8Rg
         0XEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1IwuTREhFP8d9ZWKkA5JdYA4S8M6KiAe3Ff0MI1TUoM=;
        b=Q+dM8PN2TMxWndOVUyz02YFjkH4vxVNNX0gQbJEkLXtmOZfwcNP3x2oUmCntR2tiG1
         LaoSsOxdLouoAT8sKd6rc1++yiYxTaiRnOXW9LxEhMMvecfLJnwruN2DIpOFY19dIqqj
         RNV2uPzNAV6YXlB4nnrwUXYk0c3her1TZMbJE56N0HK6qkw7hgtQYzLu7mizQRVNlwwU
         P6fqtpppZmBTyTmrHe3DVagFDbpCP5CAKDrjr812MV16TqqnGCP96xDPI+jVcrZG0xgf
         hGfQUytX9oXJOjCEBVeTUmt15pDep8a7WtD8Yh8lYdtHMefF8qPC44RnJb6EUAnbh4Jc
         VK9w==
X-Gm-Message-State: AOAM530N7Ns7X4FVGnb4K/vUdkr9SnuRI1Kk4wfyxCGow3c5LYu6nFUw
        B3K2bZMixH+VP63xCInnPoY=
X-Google-Smtp-Source: ABdhPJzEVQ1wpZr4fBxdHTc5Yy0aYa9wxrH0QX12OI8rH4V7QRx0LpioWap+nT9kKnkZOE8bOtu5cA==
X-Received: by 2002:ac2:5d51:: with SMTP id w17mr3850510lfd.343.1613222189270;
        Sat, 13 Feb 2021 05:16:29 -0800 (PST)
Received: from alpha (10.177.smarthome.spb.ru. [109.71.177.10])
        by smtp.gmail.com with ESMTPSA id k9sm1875142lfm.224.2021.02.13.05.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Feb 2021 05:16:28 -0800 (PST)
Received: (nullmailer pid 458778 invoked by uid 1000);
        Sat, 13 Feb 2021 13:12:52 -0000
From:   Ivan Safonov <insafonov@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Ivan Safonov <insafonov@gmail.com>
Subject: [PATCH] staging:r8188eu: use IEEE80211_FCTL_* kernel definitions
Date:   Sat, 13 Feb 2021 16:11:50 +0300
Message-Id: <20210213131148.458582-1-insafonov@gmail.com>
X-Mailer: git-send-email 2.26.2
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
 drivers/staging/rtl8188eu/include/wifi.h | 51 ++++++++++--------------
 1 file changed, 21 insertions(+), 30 deletions(-)

diff --git a/drivers/staging/rtl8188eu/include/wifi.h b/drivers/staging/rtl8188eu/include/wifi.h
index d0380f7f1bab..1b9006879a11 100644
--- a/drivers/staging/rtl8188eu/include/wifi.h
+++ b/drivers/staging/rtl8188eu/include/wifi.h
@@ -88,73 +88,64 @@ enum WIFI_REG_DOMAIN {
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
 #define SetToDs(pbuf)	\
-	*(__le16 *)(pbuf) |= cpu_to_le16(_TO_DS_)
+	*(__le16 *)(pbuf) |= cpu_to_le16(IEEE80211_FCTL_TODS)
 
-#define GetToDs(pbuf)	(((*(__le16 *)(pbuf)) & cpu_to_le16(_TO_DS_)) != 0)
+#define GetToDs(pbuf)	(((*(__le16 *)(pbuf)) & cpu_to_le16(IEEE80211_FCTL_TODS)) != 0)
 
 #define ClearToDs(pbuf)	\
-	*(__le16 *)(pbuf) &= (~cpu_to_le16(_TO_DS_))
+	*(__le16 *)(pbuf) &= (~cpu_to_le16(IEEE80211_FCTL_TODS))
 
 #define SetFrDs(pbuf)	\
-	*(__le16 *)(pbuf) |= cpu_to_le16(_FROM_DS_)
+	*(__le16 *)(pbuf) |= cpu_to_le16(IEEE80211_FCTL_FROMDS)
 
-#define GetFrDs(pbuf)	(((*(__le16 *)(pbuf)) & cpu_to_le16(_FROM_DS_)) != 0)
+#define GetFrDs(pbuf)	(((*(__le16 *)(pbuf)) & cpu_to_le16(IEEE80211_FCTL_FROMDS)) != 0)
 
 #define ClearFrDs(pbuf)	\
-	*(__le16 *)(pbuf) &= (~cpu_to_le16(_FROM_DS_))
+	*(__le16 *)(pbuf) &= (~cpu_to_le16(IEEE80211_FCTL_FROMDS))
 
 #define get_tofr_ds(pframe)	((GetToDs(pframe) << 1) | GetFrDs(pframe))
 
 #define SetMFrag(pbuf)	\
-	*(__le16 *)(pbuf) |= cpu_to_le16(_MORE_FRAG_)
+	*(__le16 *)(pbuf) |= cpu_to_le16(IEEE80211_FCTL_MOREFRAGS)
 
-#define GetMFrag(pbuf)	(((*(__le16 *)(pbuf)) & cpu_to_le16(_MORE_FRAG_)) != 0)
+#define GetMFrag(pbuf)	(((*(__le16 *)(pbuf)) & cpu_to_le16(IEEE80211_FCTL_MOREFRAGS)) != 0)
 
 #define ClearMFrag(pbuf)	\
-	*(__le16 *)(pbuf) &= (~cpu_to_le16(_MORE_FRAG_))
+	*(__le16 *)(pbuf) &= (~cpu_to_le16(IEEE80211_FCTL_MOREFRAGS))
 
 #define SetRetry(pbuf)	\
-	*(__le16 *)(pbuf) |= cpu_to_le16(_RETRY_)
+	*(__le16 *)(pbuf) |= cpu_to_le16(IEEE80211_FCTL_RETRY)
 
-#define GetRetry(pbuf)	(((*(__le16 *)(pbuf)) & cpu_to_le16(_RETRY_)) != 0)
+#define GetRetry(pbuf)	(((*(__le16 *)(pbuf)) & cpu_to_le16(IEEE80211_FCTL_RETRY)) != 0)
 
 #define ClearRetry(pbuf)	\
-	*(__le16 *)(pbuf) &= (~cpu_to_le16(_RETRY_))
+	*(__le16 *)(pbuf) &= (~cpu_to_le16(IEEE80211_FCTL_RETRY))
 
 #define SetPwrMgt(pbuf)	\
-	*(__le16 *)(pbuf) |= cpu_to_le16(_PWRMGT_)
+	*(__le16 *)(pbuf) |= cpu_to_le16(IEEE80211_FCTL_PM)
 
-#define GetPwrMgt(pbuf)	(((*(__le16 *)(pbuf)) & cpu_to_le16(_PWRMGT_)) != 0)
+#define GetPwrMgt(pbuf)	(((*(__le16 *)(pbuf)) & cpu_to_le16(IEEE80211_FCTL_PM)) != 0)
 
 #define ClearPwrMgt(pbuf)	\
-	*(__le16 *)(pbuf) &= (~cpu_to_le16(_PWRMGT_))
+	*(__le16 *)(pbuf) &= (~cpu_to_le16(IEEE80211_FCTL_PM))
 
 #define SetMData(pbuf)	\
-	*(__le16 *)(pbuf) |= cpu_to_le16(_MORE_DATA_)
+	*(__le16 *)(pbuf) |= cpu_to_le16(IEEE80211_FCTL_MOREDATA)
 
-#define GetMData(pbuf)	(((*(__le16 *)(pbuf)) & cpu_to_le16(_MORE_DATA_)) != 0)
+#define GetMData(pbuf)	(((*(__le16 *)(pbuf)) & cpu_to_le16(IEEE80211_FCTL_MOREDATA)) != 0)
 
 #define ClearMData(pbuf)	\
-	*(__le16 *)(pbuf) &= (~cpu_to_le16(_MORE_DATA_))
+	*(__le16 *)(pbuf) &= (~cpu_to_le16(IEEE80211_FCTL_MOREDATA))
 
 #define SetPrivacy(pbuf)	\
-	*(__le16 *)(pbuf) |= cpu_to_le16(_PRIVACY_)
+	*(__le16 *)(pbuf) |= cpu_to_le16(IEEE80211_FCTL_PROTECTED)
 
 #define GetPrivacy(pbuf)					\
-	(((*(__le16 *)(pbuf)) & cpu_to_le16(_PRIVACY_)) != 0)
+	(((*(__le16 *)(pbuf)) & cpu_to_le16(IEEE80211_FCTL_PROTECTED)) != 0)
 
 #define GetOrder(pbuf)					\
-	(((*(__le16 *)(pbuf)) & cpu_to_le16(_ORDER_)) != 0)
+	(((*(__le16 *)(pbuf)) & cpu_to_le16(IEEE80211_FCTL_ORDER)) != 0)
 
 #define GetFrameType(pbuf)				\
 	(le16_to_cpu(*(__le16 *)(pbuf)) & (BIT(3) | BIT(2)))
-- 
2.26.2

