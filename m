Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1D5E415118
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 22:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237477AbhIVUJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 16:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237664AbhIVUIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 16:08:17 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77643C0617BD
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:05:58 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id u18so10422310wrg.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2rVSZ1EINx17V4YagxgYe0WT6sqjRu5zz30GSyfrtdk=;
        b=PZWCS+TcjZrrt/Kjgi3o6tr/Oyw5KRXtWpKh6I/LbXem4aqB3cgEJtluOsRr7KppCw
         rchsXxpAC0XUzYShUoA03+wd8oLBR6W734L+xESuDMgYkbvigaUUqyicl7s4dFmbIJWP
         8dpEbuSMVLlqIzR7JN/yC8pFgsey4KaOSS2HtsZiNLVouDmpWOS0YcD0SdGTliw83T6b
         oz4qDpcJx1VDcmld49PWvezABmwuOMfkJefZVzRKZqZyB9MIJ/cR0I3/ZwvqPb36/07F
         yjAXISWqYne9VZs0fiqlh5wrzdSTupzc7CiQ/fhW5kP/ACYCXXcdciYEc1scAvATmQFF
         SsJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2rVSZ1EINx17V4YagxgYe0WT6sqjRu5zz30GSyfrtdk=;
        b=YXymNbCvxXpg2I1M10lDvcPvvZiIJ8jzUWwjUQi0ZfCmZSwfodzJKVUpW6XlGesNK4
         fAO2hnVVC3UdzT13Q5EItL3Lm+3nxhYJF0YYk6LdAHAmRzpF7fFyChx7S1O16sXstI4S
         Fk0EFz/wjADprhBvY7D7f7WSWB/Zv+/MJUafjFtFJ/wcNDiqGPO7VHHvsnOuirhpm9il
         Pj+8gFuRN1Ah1hawFu4pFR8NFqFumVZT0klcdrnAk3PeD5CvxNBX6bzy9t0kq3CZDpO+
         F6Dr3LMzDbTFI1S+pOXCkEFgW6uyrmVC1OWIYzl/+3XJs9XmgP2c+VBdNPTHqUKpPKYf
         GJ8w==
X-Gm-Message-State: AOAM530GW358UA3vS4AEQWJVGcC6e6HPbzYF9W7q7t+GdpFRcDNRIMMq
        4MsaLzplH1X2sdRZXFlc1gY=
X-Google-Smtp-Source: ABdhPJyYI0SPRCUY9nk88J86KyZBp7vCSKzwUy+l1CpVky+1PXGtdAesFFjdKpuCLOxMHhg9mPeo1g==
X-Received: by 2002:adf:dcc1:: with SMTP id x1mr845234wrm.415.1632341157179;
        Wed, 22 Sep 2021 13:05:57 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cde])
        by smtp.gmail.com with ESMTPSA id e2sm3219761wra.40.2021.09.22.13.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 13:05:56 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 36/47] staging: r8188eu: remove rtw_action_frame_parse()
Date:   Wed, 22 Sep 2021 22:04:09 +0200
Message-Id: <20210922200420.9693-37-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210922200420.9693-1-straube.linux@gmail.com>
References: <20210922200420.9693-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function rtw_action_frame_parse() is not used, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_ieee80211.c | 29 --------------------
 drivers/staging/r8188eu/include/ieee80211.h  |  3 --
 2 files changed, 32 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ieee80211.c b/drivers/staging/r8188eu/core/rtw_ieee80211.c
index 29bf3bdb598b..bc7ab84c0e05 100644
--- a/drivers/staging/r8188eu/core/rtw_ieee80211.c
+++ b/drivers/staging/r8188eu/core/rtw_ieee80211.c
@@ -1339,32 +1339,3 @@ u16 rtw_mcs_rate(u8 rf_type, u8 bw_40MHz, u8 short_GI_20, u8 short_GI_40, unsign
 	}
 	return max_rate;
 }
-
-int rtw_action_frame_parse(const u8 *frame, u32 frame_len, u8 *category, u8 *action)
-{
-	const u8 *frame_body = frame + sizeof(struct rtw_ieee80211_hdr_3addr);
-	u16 fc;
-	u8 c, a = 0;
-
-	fc = le16_to_cpu(((struct rtw_ieee80211_hdr_3addr *)frame)->frame_ctl);
-
-	if ((fc & (RTW_IEEE80211_FCTL_FTYPE | RTW_IEEE80211_FCTL_STYPE)) !=
-	    (RTW_IEEE80211_FTYPE_MGMT | RTW_IEEE80211_STYPE_ACTION))
-		return false;
-
-	c = frame_body[0];
-
-	switch (c) {
-	case RTW_WLAN_CATEGORY_P2P: /* vendor-specific */
-		break;
-	default:
-		a = frame_body[1];
-	}
-
-	if (category)
-		*category = c;
-	if (action)
-		*action = a;
-
-	return true;
-}
diff --git a/drivers/staging/r8188eu/include/ieee80211.h b/drivers/staging/r8188eu/include/ieee80211.h
index af1e074e0bdf..36c95adb9d85 100644
--- a/drivers/staging/r8188eu/include/ieee80211.h
+++ b/drivers/staging/r8188eu/include/ieee80211.h
@@ -1169,7 +1169,4 @@ void rtw_macaddr_cfg(u8 *mac_addr);
 u16 rtw_mcs_rate(u8 rf_type, u8 bw_40MHz, u8 short_GI_20, u8 short_GI_40,
 		 unsigned char *MCS_rate);
 
-int rtw_action_frame_parse(const u8 *frame, u32 frame_len, u8 *category,
-			   u8 *action);
-
 #endif /* IEEE80211_H */
-- 
2.33.0

