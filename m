Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF68D340EC8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 21:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbhCRUEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 16:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbhCRUEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 16:04:32 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F13C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 13:04:32 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id r32so20755311qtd.16
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 13:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Sy0ok4NDvEEWcKa8gZVauE+I24CZBWOlbwpSDaAczD4=;
        b=OYvbaHL4Cw/2tEMKIpXymUrOdPxlDLE16i0tNA1k6PToqW2gxs01/TDyDN3xUy08IP
         v0KqdzfxqSFwp+GFzYMiEoYQDVYtGNUeOvyucbUEsZUgzypqBTyUxk7p84IQoaWHHu7O
         1SLxkNx03DABkLuTtoKDnvVMI94og1t00o+/DQ8QpPfcKq3kY2lXVfF3IKSM1Bu7hZ29
         eLjJneJj+eKVLvf9uE+j+jEGEti8bhfZ1QSVaSA+OeenV3XoL9CSGVkt/HNDnhoTzXcW
         ir0fo6+jjZ7Eyl1F5KaL7En9r523E3mw7LKatSL1ctsWuFKU6qYclSWa23US36YEww4x
         rL5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Sy0ok4NDvEEWcKa8gZVauE+I24CZBWOlbwpSDaAczD4=;
        b=KSt1/il/e3p+U2NMSb71PTGgKfIdJ35orDCT8PqxFuK55me0WBCCIH1/9+s1r44tbI
         e0a9F7g8B9/wg4nwmE3ftsstXc2M9ozaHMr+pk7mIxpfEsiYuKF01iZ2Es67yyBAPBn4
         zZy9r36Wul1GlqjHcXEEODJlYulwMVbZ+d9AuRY7w27R74kSKtlrGTyMdBqIOYB3ipZ4
         h31ioZQGbonHP/V8xcBmXFsE0dQ88mGuxglGQXiq4PN69jB1idtvfbIBKWw4v+Juyq47
         jpbnBH7z9grM7U5Mi02EGc8HcIwbbxkSkGbkgtF+kKo2COhF55XK4A+u7w9UBOMFa0ef
         n0lQ==
X-Gm-Message-State: AOAM533YMENiOk9PjsgGn25TzwPbDwi2sqfFUBimXlWzl8cbN+e937eJ
        WWH6X3DKSJtVAPpQr2/JPppKZTzigXTTUHE7
X-Google-Smtp-Source: ABdhPJyQ78BMLMSkt/5hyJHt/m7uMl6vx5Xf4POCD7cNtWcNhm+B+Nmifj71WzlahW0x8X0CpISeWd9uPTkm4V6u
X-Received: from schuffelen.mtv.corp.google.com ([2620:15c:211:200:49b9:40b4:cada:e298])
 (user=schuffelen job=sendgmr) by 2002:a05:6214:13b3:: with SMTP id
 h19mr6166044qvz.31.1616097871522; Thu, 18 Mar 2021 13:04:31 -0700 (PDT)
Date:   Thu, 18 Mar 2021 13:04:19 -0700
Message-Id: <20210318200419.1421034-1-schuffelen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v2] virt_wifi: Return micros for BSS TSF values
From:   "A. Cody Schuffelen" <schuffelen@google.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "A. Cody Schuffelen" <schuffelen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cfg80211_inform_bss expects to receive a TSF value, but is given the
time since boot in nanoseconds. TSF values are expected to be at
microsecond scale rather than nanosecond scale.

Signed-off-by: A. Cody Schuffelen <schuffelen@google.com>
---
 drivers/net/wireless/virt_wifi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/virt_wifi.c b/drivers/net/wireless/virt_wifi.c
index c878097f0dda..1df959532c7d 100644
--- a/drivers/net/wireless/virt_wifi.c
+++ b/drivers/net/wireless/virt_wifi.c
@@ -12,6 +12,7 @@
 #include <net/cfg80211.h>
 #include <net/rtnetlink.h>
 #include <linux/etherdevice.h>
+#include <linux/math64.h>
 #include <linux/module.h>
 
 static struct wiphy *common_wiphy;
@@ -168,11 +169,11 @@ static void virt_wifi_scan_result(struct work_struct *work)
 			     scan_result.work);
 	struct wiphy *wiphy = priv_to_wiphy(priv);
 	struct cfg80211_scan_info scan_info = { .aborted = false };
+	u64 tsf = div_u64(ktime_get_boottime_ns(), 1000);
 
 	informed_bss = cfg80211_inform_bss(wiphy, &channel_5ghz,
 					   CFG80211_BSS_FTYPE_PRESP,
-					   fake_router_bssid,
-					   ktime_get_boottime_ns(),
+					   fake_router_bssid, tsf,
 					   WLAN_CAPABILITY_ESS, 0,
 					   (void *)&ssid, sizeof(ssid),
 					   DBM_TO_MBM(-50), GFP_KERNEL);
-- 
2.31.0.rc2.261.g7f71774620-goog

