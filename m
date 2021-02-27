Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A79B3326F28
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Feb 2021 23:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbhB0WX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Feb 2021 17:23:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbhB0WXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Feb 2021 17:23:54 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598B4C061756
        for <linux-kernel@vger.kernel.org>; Sat, 27 Feb 2021 14:23:12 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id u4so14889757ljh.6
        for <linux-kernel@vger.kernel.org>; Sat, 27 Feb 2021 14:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8kMhdvIdhbDz43HUBsLUfT2KZzfyvRCqBeoQrZQZUg0=;
        b=D2MPLIf6TPmXIWXZoXs6a9mHwzAf4ff/75KanLAXE2KpNAlniYKoHcrG+PjeqM8Ksd
         DaPv5DKx3tLdwpkvNg7n5/adal9Q9DJpbEjTE21T4KIZU4P1x0eM6MsOG21PJIuhcYMY
         yn2FPN6AWdXwIDuhdn88tWB8AVhmNhWyNZKm/C/0GJo0pn/fe7hvPwiQXLs1iZMrDrIc
         gY1qFleDplA7wPmJ1Du60A7tICkOWhlzPpqXVc0w6C6z7occDLPL54GllpdwBfkqfUrT
         vlOX+Q6bQLYfPp4piy0u0M4d0FlLOJpfNs1+YNlnnNM0qnL4Swdxf4RzYlvgIK9DHZu+
         fChQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8kMhdvIdhbDz43HUBsLUfT2KZzfyvRCqBeoQrZQZUg0=;
        b=RosUhDpzcDV6asQaENDa5NkO7/6N2Xmw3l1qQnuuGZ27rGUNWP4Q3QnA/XvfpzN8IL
         5XEqySePY+KRfCxacY3j7ZmrhgqieBC6KE5RPwvkTOJ3YmzHujPPBkD9UE3rXgD4rH85
         6E0dWks7nSJWQmr8WZ80WrqKyQ3HmB9Wt+epzoRf1vvGPJjYBVxu9awtX6TXd4g7et2N
         +s75QBJZfBkAZ+0wLCnwyBpq1y4QjOZXGCDFclZDKvFSZcXX+5yF78Fv+pxNWRFAgGHr
         vum5vmLobG9M9z1jZxGgz9sA4zthmHdQ3Ux9aquZuklIlu4XcjwbhrlUAs4lar5EPdi9
         Aurg==
X-Gm-Message-State: AOAM5319se1uYZlvA6xEjdKyU3BdbGmqg9G/xKxXMXYsuT3kjCkZWye4
        fORT5Nc3Tke6F7/Hl+Umbas=
X-Google-Smtp-Source: ABdhPJwMVPpvlUsx5RRd4Ifhi7BF3evaQBUuh0fKFTNMx/OPXpl3epAq6KhqTwDkJgAIc7k1AczRfQ==
X-Received: by 2002:a2e:88cb:: with SMTP id a11mr5438089ljk.394.1614464590917;
        Sat, 27 Feb 2021 14:23:10 -0800 (PST)
Received: from alpha (10.177.smarthome.spb.ru. [109.71.177.10])
        by smtp.gmail.com with ESMTPSA id w25sm1804278lfn.198.2021.02.27.14.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Feb 2021 14:23:10 -0800 (PST)
Received: (nullmailer pid 581544 invoked by uid 1000);
        Sat, 27 Feb 2021 22:23:09 -0000
From:   Ivan Safonov <insafonov@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Michael Straube <straube.linux@gmail.com>,
        Pascal Terjan <pterjan@google.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Ivan Safonov <insafonov@gmail.com>
Subject: [PATCH 1/4] staging:rtl8712: replace get_(d|s)a with ieee80211_get_(D|S)A
Date:   Sun, 28 Feb 2021 01:22:34 +0300
Message-Id: <20210227222236.581490-2-insafonov@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210227222236.581490-1-insafonov@gmail.com>
References: <20210227222236.581490-1-insafonov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_da()/get_sa() duplicate native ieee80211_get_(D|S)A functions.
Remove get_(d|s)a, use ieee80211_get_(D|S)A instead.

Signed-off-by: Ivan Safonov <insafonov@gmail.com>
---
 drivers/staging/rtl8712/rtl871x_recv.c |  4 +--
 drivers/staging/rtl8712/wifi.h         | 45 --------------------------
 2 files changed, 2 insertions(+), 47 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_recv.c b/drivers/staging/rtl8712/rtl871x_recv.c
index eb4e46a7f743..efd783e7ccbc 100644
--- a/drivers/staging/rtl8712/rtl871x_recv.c
+++ b/drivers/staging/rtl8712/rtl871x_recv.c
@@ -466,8 +466,8 @@ static sint validate_recv_data_frame(struct _adapter *adapter,
 	struct security_priv *psecuritypriv = &adapter->securitypriv;
 
 	bretry = GetRetry(ptr);
-	pda = get_da(ptr);
-	psa = get_sa(ptr);
+	pda = ieee80211_get_DA((struct ieee80211_hdr *)ptr);
+	psa = ieee80211_get_SA((struct ieee80211_hdr *)ptr);
 	pbssid = get_hdr_bssid(ptr);
 	if (!pbssid)
 		return _FAIL;
diff --git a/drivers/staging/rtl8712/wifi.h b/drivers/staging/rtl8712/wifi.h
index 1b32b3510093..5de0e67b1876 100644
--- a/drivers/staging/rtl8712/wifi.h
+++ b/drivers/staging/rtl8712/wifi.h
@@ -264,51 +264,6 @@ static inline unsigned char get_tofr_ds(unsigned char *pframe)
 
 #define GetAddr4Ptr(pbuf)	((unsigned char *)((addr_t)(pbuf) + 24))
 
-static inline unsigned char *get_da(unsigned char *pframe)
-{
-	unsigned char	*da;
-	unsigned int	to_fr_ds = (GetToDs(pframe) << 1) | GetFrDs(pframe);
-
-	switch (to_fr_ds) {
-	case 0x00:	/* ToDs=0, FromDs=0 */
-		da = GetAddr1Ptr(pframe);
-		break;
-	case 0x01:	/* ToDs=0, FromDs=1 */
-		da = GetAddr1Ptr(pframe);
-		break;
-	case 0x02:	/* ToDs=1, FromDs=0 */
-		da = GetAddr3Ptr(pframe);
-		break;
-	default:	/* ToDs=1, FromDs=1 */
-		da = GetAddr3Ptr(pframe);
-		break;
-	}
-	return da;
-}
-
-static inline unsigned char *get_sa(unsigned char *pframe)
-{
-	unsigned char	*sa;
-	unsigned int	to_fr_ds = (GetToDs(pframe) << 1) | GetFrDs(pframe);
-
-	switch (to_fr_ds) {
-	case 0x00:	/* ToDs=0, FromDs=0 */
-		sa = GetAddr2Ptr(pframe);
-		break;
-	case 0x01:	/* ToDs=0, FromDs=1 */
-		sa = GetAddr3Ptr(pframe);
-		break;
-	case 0x02:	/* ToDs=1, FromDs=0 */
-		sa = GetAddr2Ptr(pframe);
-		break;
-	default:	/* ToDs=1, FromDs=1 */
-		sa = GetAddr4Ptr(pframe);
-		break;
-	}
-
-	return sa;
-}
-
 static inline unsigned char *get_hdr_bssid(unsigned char *pframe)
 {
 	unsigned char	*sa;
-- 
2.26.2

