Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 591AC33FD00
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 03:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbhCRCCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 22:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbhCRCBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 22:01:37 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300E1C061760
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 19:01:37 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id u5so30612382qkj.10
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 19:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=+UcgvFQcz7bzdmHaCkGqxDfp91gn2PcF3h4jni/C+fs=;
        b=kNtaBLJTYFvgTlVVaoA04VJ6ywOzWQuO2muRupaZcvTW4I1hI7xN/px+EP5rNWViL7
         nCL7w3k4zc446ZDvKTJMUx82ggdSWYv/UXRFBe7hSHxhbuh9W0IWYOgMmPAnCzPZfoiL
         cZC007huGqWaH9MtViemlBaPmkcgnQJDmXXGoeSz9Z/cgQkw7wWTXJ1BbE3lK8KGphsJ
         lXu6NPQd6+jCsoSGhGFKQQ7Gd73BILfNMzB1k/z7gU66gZXRP+foN2oi8GUZ1va1qA22
         +Y29mOZiUh74Ch+FaIrK1qRctuIgfa2caz15G1np/I+Ux1VDPq7hZcdpzM1DussDvDFx
         3kHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=+UcgvFQcz7bzdmHaCkGqxDfp91gn2PcF3h4jni/C+fs=;
        b=r5gMh7ULrF3Jz5Yd5dc0fnOfXiQ/+5wlwuwJ5+2kWUJKS4qvFN+a5y8siFEWtemmwq
         BLWO2Y7X0wLuVd+M72z+t2GXNQ5+S8joek7FSd+aAaQMlLhpr0C6mllXzwJg6S5P6M9y
         0p3xEw7R7ZfBaJsOKaf7YiMrD4fxjzOlyLTsU2gDEoXiusUpd6jHaQKC56YDFiTHErfO
         XBHQEqnZgoTNJoq6WNd6+BLiezZRFDWokMZcOdoMAPF6DdThZo4eDjiUPYAqLKhC+sOv
         hsuVP5oYnvTj4fy2XWshuMjvYMzB7ej0Q/rjq/weDVkD2xk99InmGvAS71IDTvcxdL4C
         +Zqw==
X-Gm-Message-State: AOAM533uFSdtpYhfSnVF5WgcGvYlP2bdl+fgSqpDatMX78yj4w6XE3Jw
        /BqRYmLoFYWAKaaaf802M98f/jMf3x9kHETG
X-Google-Smtp-Source: ABdhPJxWWYR/FLCWVHR+lEvCbYG5F4OUwXVAr8mkfj4cbykFxkGkL28cV/KGajZxpyCcrFTnxJ+7LdT/w7CHSEPh
X-Received: from schuffelen.mtv.corp.google.com ([2620:15c:211:200:49b9:40b4:cada:e298])
 (user=schuffelen job=sendgmr) by 2002:a0c:a0c6:: with SMTP id
 c64mr2196205qva.57.1616032896291; Wed, 17 Mar 2021 19:01:36 -0700 (PDT)
Date:   Wed, 17 Mar 2021 19:01:10 -0700
Message-Id: <20210318020110.778352-1-schuffelen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH] virt_wifi: Return micros for BSS TSF values
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
 drivers/net/wireless/virt_wifi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/virt_wifi.c b/drivers/net/wireless/virt_wifi.c
index c878097f0dda..07cefd0a86be 100644
--- a/drivers/net/wireless/virt_wifi.c
+++ b/drivers/net/wireless/virt_wifi.c
@@ -172,7 +172,7 @@ static void virt_wifi_scan_result(struct work_struct *work)
 	informed_bss = cfg80211_inform_bss(wiphy, &channel_5ghz,
 					   CFG80211_BSS_FTYPE_PRESP,
 					   fake_router_bssid,
-					   ktime_get_boottime_ns(),
+					   ktime_get_boottime_ns() / 1000,
 					   WLAN_CAPABILITY_ESS, 0,
 					   (void *)&ssid, sizeof(ssid),
 					   DBM_TO_MBM(-50), GFP_KERNEL);
-- 
2.31.0.rc2.261.g7f71774620-goog

