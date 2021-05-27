Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B83F93935E2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 21:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236737AbhE0TDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 15:03:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:36664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236346AbhE0TDF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 15:03:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8D6AE6143C;
        Thu, 27 May 2021 19:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622142086;
        bh=ZW4smGedXdZxEkvJTKEYpO9UsuXTul3v6LeUO9IeuRQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZoxNjB1POiEUrg6ib8hSOzaVNH/LLp6t6zA1dGOkoTbmM/KHzcHBQmsLq3TyIaSz2
         U6c6q1p9CH8IO4qRNM78cCrtH0f9sVPX0w0OaWfkOEYdEZkjjTkvq21bmyLoRFP19d
         8ZssUl0P+DkVMAHPAcTnQkp2Et/R2zn6EtGGPcnNOyLrxU9APXTVVKygpJiTfDI4r0
         7RIUBecfmUIUAGWcL7YbRHscm8/FBg7kq6T6Jvxv2uZMNmoVpZiD4wd3QXTr4cO+ki
         Nc6rvCo/HzNVVTKSZfHYeTdnZDwKaW6Yj3bgGtjxU8w1FyFUhXOvosvNWOasbpKaxX
         3LX/ieFDJbwxw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 19EA55C033F; Thu, 27 May 2021 12:01:26 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@fb.com, neeraju@codeaurora.org,
        ak@linux.intel.com, feng.tang@intel.com, zhengjun.xing@intel.com,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v15 clocksource 6/6] clocksource: Print deviation in nanoseconds for unstable case
Date:   Thu, 27 May 2021 12:01:24 -0700
Message-Id: <20210527190124.440372-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210527190042.GA438700@paulmck-ThinkPad-P17-Gen-1>
References: <20210527190042.GA438700@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Feng Tang <feng.tang@intel.com>

Currently when an unstable clocksource is detected, the raw counters
of that clocksource and watchdog will be printed, which can only be
understood after some math calculation.  So print the existing delta in
nanoseconds to make it easier for humans to check the results.

[ paulmck: Fix typo. ]
Signed-off-by: Feng Tang <feng.tang@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/time/clocksource.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index bbe1bcf44ffa..4485635b69f5 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -406,10 +406,10 @@ static void clocksource_watchdog(struct timer_list *unused)
 		if (abs(cs_nsec - wd_nsec) > md) {
 			pr_warn("timekeeping watchdog on CPU%d: Marking clocksource '%s' as unstable because the skew is too large:\n",
 				smp_processor_id(), cs->name);
-			pr_warn("                      '%s' wd_now: %llx wd_last: %llx mask: %llx\n",
-				watchdog->name, wdnow, wdlast, watchdog->mask);
-			pr_warn("                      '%s' cs_now: %llx cs_last: %llx mask: %llx\n",
-				cs->name, csnow, cslast, cs->mask);
+			pr_warn("                      '%s' wd_nsec: %lld wd_now: %llx wd_last: %llx mask: %llx\n",
+				watchdog->name, wd_nsec, wdnow, wdlast, watchdog->mask);
+			pr_warn("                      '%s' cs_nsec: %lld cs_now: %llx cs_last: %llx mask: %llx\n",
+				cs->name, cs_nsec, csnow, cslast, cs->mask);
 			if (curr_clocksource == cs)
 				pr_warn("                      '%s' is current clocksource.\n", cs->name);
 			else if (curr_clocksource)
-- 
2.31.1.189.g2e36527f23

