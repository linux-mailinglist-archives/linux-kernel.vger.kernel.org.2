Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 688AA37B2A9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 01:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhEKXgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 19:36:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:56138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229964AbhEKXgF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 19:36:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6295461931;
        Tue, 11 May 2021 23:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620776098;
        bh=4Od/no2MnQDMvEZbD970huF63vrfWP+lhs2RT184EVA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i2lrK3OqoyWlCSVcONsajsskCRmxxaoznGkFDFFgWeEPOSjAeyF7kl4e9ahiYPSYk
         8Y3yMExU7pj4yE4yarIbfrvkaHw9Y7hrI8oTAGEK5voG8cD01pm/NDq9pD9zNjuZZE
         SeWyU/7WXBtkazE56kpFZOIuF9VN7zHpK1XCgPrY8qnPKGb/Sx+p4JMjKuTatu0cF6
         fUVpZsguWSw6X3bd5WvCzWKC4a8b/W7T2JYmfYgoR+AEqVLQ6WGTQikUEmi4cf/70a
         kzalcB78xK9DRw9PUpIXA/cG0Fb8k7autHqllJO7umnCdMESOlEG29GsY6V9/IdrMd
         nsqgLD8BrGslw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B6C4F5C0DB3; Tue, 11 May 2021 16:34:57 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@fb.com, neeraju@codeaurora.org,
        ak@linux.intel.com, feng.tang@intel.com, zhengjun.xing@intel.com,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v14 clocksource 6/6] clocksource: Print deviation in nanoseconds for unstable case
Date:   Tue, 11 May 2021 16:34:55 -0700
Message-Id: <20210511233455.2897068-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511233403.GA2896757@paulmck-ThinkPad-P17-Gen-1>
References: <20210511233403.GA2896757@paulmck-ThinkPad-P17-Gen-1>
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

Signed-off-by: Feng Tang <feng.tang@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/time/clocksource.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index bbe1bcf44ffa..9c45b98e60e2 100644
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
+			pr_warn("                      '%s' wd_nesc: %lld wd_now: %llx wd_last: %llx mask: %llx\n",
+				watchdog->name, wd_nsec, wdnow, wdlast, watchdog->mask);
+			pr_warn("                      '%s' cs_nsec: %lld cs_now: %llx cs_last: %llx mask: %llx\n",
+				cs->name, cs_nsec, csnow, cslast, cs->mask);
 			if (curr_clocksource == cs)
 				pr_warn("                      '%s' is current clocksource.\n", cs->name);
 			else if (curr_clocksource)
-- 
2.31.1.189.g2e36527f23

