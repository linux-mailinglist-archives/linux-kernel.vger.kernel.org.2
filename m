Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52937427912
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 12:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244578AbhJIKpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 06:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244511AbhJIKoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 06:44:55 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65EEDC061755
        for <linux-kernel@vger.kernel.org>; Sat,  9 Oct 2021 03:42:58 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id y7so767924pfg.8
        for <linux-kernel@vger.kernel.org>; Sat, 09 Oct 2021 03:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k4IlhSZq3bz0IJmsC/grRGaO47UWS9NT2fcwZEHeN/M=;
        b=n002sSlR6Rjmn+spHL2zqzrQCo1r3SLmeyp/US24ySvP/cB7W+wFIyHgTU39E7XTLq
         zCVN0RRPeRfBxelup3zAXe/Op6B8DWY5WeDSdpG3WqBjCdXF8eBrbKnAYUlwYD3QCkT6
         jqRC+1h1dQScvkEPCQgn9cbZHgfsGMYa+J23HcRDqbW0tQ2OqG2aUsN3jyiQcSRAvEH5
         Vi92L3zlzAQu8RCgsm3/mVluuDQhqKPp4baH6Vsf7Fi0JZbzJcTVPW8JwnJOnagiV44t
         mC1C+2WXhbTa/vY6Zvi4b4dHLzhQrXKrCnfRUQUaMX4Y3v5hePdL2fR7IYyykTSN+ZTm
         yWJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k4IlhSZq3bz0IJmsC/grRGaO47UWS9NT2fcwZEHeN/M=;
        b=rgghjotFIECjYma6TGdmURiy57iIPLNOQDQ0Gu6N2NwE/8nLXjXxwo+HWKUPTUqUTc
         S0g17Jm2W1tnbW6XTHyvjBR/ARblMyGiy/c4nnTSbbAOerS+HDxno6Do9MDKZ6FqJ83R
         FBtFtcMt+GFxhkxqtDcL1VU3TbTcBv8ThdVt0KsD4mw1uW27nNsq8vb0HUhx3zmUn952
         P/IKG48GSg0La1S5CVfejpiVYU5GLuBSNSz2GttfDkDtWESZP6bc/Lp5lCRGRulHygXX
         9zwHjfv8NwGqEImmcn/s2m9G+eMrf+mHDI9MSh2OACicNOcyDV55vA4sW+q5wH9AnDto
         14MQ==
X-Gm-Message-State: AOAM530wAKSxxy4w1A3+cwS6F+9/XcqxT+nj/TLyzDaJOTvBPFuN4hIm
        5p2JibJNuAJwtFAr/C8Ys6wGFA==
X-Google-Smtp-Source: ABdhPJzPc4Xr2fE7qNfW2Icd3EzuSEJ6GtIJscDJ77Cpqm9vA0OfRdn+sCQcnavT1on5YJ7GDSjdDg==
X-Received: by 2002:a63:1e60:: with SMTP id p32mr9088649pgm.234.1633776177926;
        Sat, 09 Oct 2021 03:42:57 -0700 (PDT)
Received: from FVFC60ZAL416.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id e2sm13075027pjl.31.2021.10.09.03.42.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Oct 2021 03:42:57 -0700 (PDT)
From:   yanghui <yanghui.def@bytedance.com>
To:     john.stultz@linaro.org
Cc:     tglx@linutronix.de, sboyd@kernel.org, linux-kernel@vger.kernel.org,
        yanghui <yanghui.def@bytedance.com>
Subject: [PATCH v2] Clocksource:Avoid misjudgment of clocksource
Date:   Sat,  9 Oct 2021 18:42:40 +0800
Message-Id: <20211009104240.46406-1-yanghui.def@bytedance.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function clocksource_watchdog() is executed every WATCHDOG_INTERVAL(0.5s)
by Timer. But sometimes system is very busy and the Timer cannot be
executed in 0.5sec. For example,if clocksource_watchdog be executed
after 10sec, the calculated value of abs(cs_nsec - wd_nsec) will
be magnified. Then the current clocksource will be misjudged as
unstable. So we add conditions to prevent the clocksource from
being misjudged.

Signed-off-by: yanghui <yanghui.def@bytedance.com>
---
Change in v2:
    Remove the check on cs_nsec.

 kernel/time/clocksource.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index b8a14d2fb5ba..c35bb708e030 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -136,8 +136,10 @@ static void __clocksource_change_rating(struct clocksource *cs, int rating);
 
 /*
  * Interval: 0.5sec.
+ * MaxInterval: 1s.
  */
 #define WATCHDOG_INTERVAL (HZ >> 1)
+#define WATCHDOG_MAX_INTERVAL_NS (NSEC_PER_SEC)
 
 static void clocksource_watchdog_work(struct work_struct *work)
 {
@@ -404,7 +406,8 @@ static void clocksource_watchdog(struct timer_list *unused)
 
 		/* Check the deviation from the watchdog clocksource. */
 		md = cs->uncertainty_margin + watchdog->uncertainty_margin;
-		if (abs(cs_nsec - wd_nsec) > md) {
+		if ((abs(cs_nsec - wd_nsec) > md) &&
+		    wd_nsec < WATCHDOG_MAX_INTERVAL_NS) {
 			pr_warn("timekeeping watchdog on CPU%d: Marking clocksource '%s' as unstable because the skew is too large:\n",
 				smp_processor_id(), cs->name);
 			pr_warn("                      '%s' wd_nsec: %lld wd_now: %llx wd_last: %llx mask: %llx\n",
-- 
2.20.1

