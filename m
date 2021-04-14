Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6F935FA72
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 20:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352258AbhDNSM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 14:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234411AbhDNSMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 14:12:05 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9C4C061756
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:11:43 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id z1so24827765edb.8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cYsOMA8TmTYxhtaHQf4Zdy0n6RJpYtiGTFjA+gbKh4k=;
        b=kQu3F0hVw6y20Toe/9oqX7i0HnapuJBRIboRisVj7Fmbr+4Gl53zlmVQHCxEa6MWg9
         PD3EvHQmhCSA6VWI5sEaqRJOxBkI+OklnweK17tikLtFh8BDT0prkDkx4cLhGn6XNgRB
         VBMLeAK5Ce83vEEeWueqa9+PSVK+VJio7bG8A7+tJZ3drBOS/5xJ2ltFsbOEscPzWdfV
         xkNZbEykckx6AaLkj5uoBZRiWVvYORczUmik5axDXs1SDRhGKOX3ndoYydWZAMxwPtT7
         73FIKDiLqeU2uTWdrdN1rxOsJB1DaYZi9Uwv6BOnuEOyoXqUK13UFPNbZJOROvbq/ipZ
         2Nmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cYsOMA8TmTYxhtaHQf4Zdy0n6RJpYtiGTFjA+gbKh4k=;
        b=KLrxN0vdeO+t24Z3tI4JXiOrsTWn03gJwS5d3PKfx78A0KopwpWQzY7x+zAogCblW9
         /d/gT1+reypH/u/DwN9q98Uvjhzsao1Cb1796uBDqLf/maSFQnlIAwBBjMkNVkmWRaG1
         p6cPbWTRnqGhUNxeDI8BaSwiEBwlHhalGTjVtmfvl1caYIjamhu8tnJvAnrRarHFpvZo
         VvzGX3fZa1uVnxuLSl3HqBbrJFVCbfiFDJ9ohrKMy1IlryS+8QdMXkccHhx2U+w0YZ20
         eLXN1Tq0i76DqElGWIpKoVhhlNbd9wl24qAMstUiQwxbt+0WwkQ8PyRaWZEO1Tvfe/V1
         27nQ==
X-Gm-Message-State: AOAM533O0Rustdq8DTx4QrVPBohNRcsEmvNBOZAt/DvKrPe6uugKyvy4
        gYSDeNRfijnopTIeKtzNNJT2/Q==
X-Google-Smtp-Source: ABdhPJy0SYJ4d/Q+7Ky3bPg/ka4IplgMBqpmObXQU7WJ+3CjfMahKDFd+tKBBKgdMKfT2ib1Vi9iqQ==
X-Received: by 2002:aa7:db95:: with SMTP id u21mr207985edt.152.1618423902139;
        Wed, 14 Apr 2021 11:11:42 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id v1sm279493eds.17.2021.04.14.11.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 11:11:41 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sumera Priyadarsini <sylphrenadin@gmail.com>,
        linux-staging@lists.linux.dev
Subject: [PATCH 07/57] staging: wlan-ng: cfg80211: Move large struct onto the heap
Date:   Wed, 14 Apr 2021 19:10:39 +0100
Message-Id: <20210414181129.1628598-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210414181129.1628598-1-lee.jones@linaro.org>
References: <20210414181129.1628598-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/staging/wlan-ng/cfg80211.c: In function ‘prism2_scan’:
 drivers/staging/wlan-ng/cfg80211.c:388:1: warning: the frame size of 1296 bytes is larger than 1024 bytes [-Wframe-larger-than=]

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sumera Priyadarsini <sylphrenadin@gmail.com>
Cc: linux-staging@lists.linux.dev
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/staging/wlan-ng/cfg80211.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/wlan-ng/cfg80211.c b/drivers/staging/wlan-ng/cfg80211.c
index 759e475e303c0..7951bd63816ff 100644
--- a/drivers/staging/wlan-ng/cfg80211.c
+++ b/drivers/staging/wlan-ng/cfg80211.c
@@ -276,7 +276,7 @@ static int prism2_scan(struct wiphy *wiphy,
 	struct prism2_wiphy_private *priv = wiphy_priv(wiphy);
 	struct wlandevice *wlandev;
 	struct p80211msg_dot11req_scan msg1;
-	struct p80211msg_dot11req_scan_results msg2;
+	struct p80211msg_dot11req_scan_results *msg2;
 	struct cfg80211_bss *bss;
 	struct cfg80211_scan_info info = {};
 
@@ -301,6 +301,10 @@ static int prism2_scan(struct wiphy *wiphy,
 		return -EOPNOTSUPP;
 	}
 
+	msg2 = kzalloc(sizeof(*msg2), GFP_KERNEL);
+	if (!msg2)
+		return -ENOMEM;
+
 	priv->scan_request = request;
 
 	memset(&msg1, 0x00, sizeof(msg1));
@@ -342,31 +346,30 @@ static int prism2_scan(struct wiphy *wiphy,
 	for (i = 0; i < numbss; i++) {
 		int freq;
 
-		memset(&msg2, 0, sizeof(msg2));
-		msg2.msgcode = DIDMSG_DOT11REQ_SCAN_RESULTS;
-		msg2.bssindex.data = i;
+		msg2->msgcode = DIDMSG_DOT11REQ_SCAN_RESULTS;
+		msg2->bssindex.data = i;
 
 		result = p80211req_dorequest(wlandev, (u8 *)&msg2);
 		if ((result != 0) ||
-		    (msg2.resultcode.data != P80211ENUM_resultcode_success)) {
+		    (msg2->resultcode.data != P80211ENUM_resultcode_success)) {
 			break;
 		}
 
 		ie_buf[0] = WLAN_EID_SSID;
-		ie_buf[1] = msg2.ssid.data.len;
+		ie_buf[1] = msg2->ssid.data.len;
 		ie_len = ie_buf[1] + 2;
-		memcpy(&ie_buf[2], &msg2.ssid.data.data, msg2.ssid.data.len);
-		freq = ieee80211_channel_to_frequency(msg2.dschannel.data,
+		memcpy(&ie_buf[2], &msg2->ssid.data.data, msg2->ssid.data.len);
+		freq = ieee80211_channel_to_frequency(msg2->dschannel.data,
 						      NL80211_BAND_2GHZ);
 		bss = cfg80211_inform_bss(wiphy,
 					  ieee80211_get_channel(wiphy, freq),
 					  CFG80211_BSS_FTYPE_UNKNOWN,
-					  (const u8 *)&msg2.bssid.data.data,
-					  msg2.timestamp.data, msg2.capinfo.data,
-					  msg2.beaconperiod.data,
+					  (const u8 *)&msg2->bssid.data.data,
+					  msg2->timestamp.data, msg2->capinfo.data,
+					  msg2->beaconperiod.data,
 					  ie_buf,
 					  ie_len,
-					  (msg2.signal.data - 65536) * 100, /* Conversion to signed type */
+					  (msg2->signal.data - 65536) * 100, /* Conversion to signed type */
 					  GFP_KERNEL);
 
 		if (!bss) {
@@ -378,12 +381,13 @@ static int prism2_scan(struct wiphy *wiphy,
 	}
 
 	if (result)
-		err = prism2_result2err(msg2.resultcode.data);
+		err = prism2_result2err(msg2->resultcode.data);
 
 exit:
 	info.aborted = !!(err);
 	cfg80211_scan_done(request, &info);
 	priv->scan_request = NULL;
+	kfree(msg2);
 	return err;
 }
 
-- 
2.27.0

