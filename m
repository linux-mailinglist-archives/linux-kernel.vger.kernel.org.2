Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C90DF36A9C0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 00:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbhDYWsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 18:48:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:50810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231441AbhDYWrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 18:47:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 60F23613BB;
        Sun, 25 Apr 2021 22:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619390831;
        bh=YOXvJ9c4FtwxVpG/WsHRuATvBXtO3NDC6pYxQbAN5x0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LlUoC/3CuWoSzxWmtb6iuhCs3ToYXoDONB7lCkjX52/CPDXAp1Y6VwDJOCxiR9w9X
         GzZVcidyOQ9UPBE/I6QVnm9k2Tm+Y/hLh/oOQ5byGSME72N4rEbWgxNAkaPb1pOZGA
         RnoI411D1QYy4zg9y3J+skeEjJoyIkhUEm7hkgzgYyFQtmsgjFGgKUr4HZ+JN8s5zb
         LkRe9jRqu83h4GX/1A/NC3tk2SmYnJOXIsv2FPOnqfCfOVjFcedP69FxqfGlZ3PdzH
         9aTyynk46R+HWErFtmkgAp3wI8iyVpf3y7kI0qxk/7XvnYVZmDs2XXJoPU9MO+CclQ
         eRzxegXNYBSSw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DD2705C05AA; Sun, 25 Apr 2021 15:47:10 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@fb.com, neeraju@codeaurora.org,
        ak@linux.intel.com, feng.tang@intel.com, zhengjun.xing@intel.com,
        "Paul E. McKenney" <paulmck@kernel.org>, Chris Mason <clm@fb.com>
Subject: [PATCH v10 clocksource 7/7] clocksource: Reduce WATCHDOG_THRESHOLD
Date:   Sun, 25 Apr 2021 15:47:09 -0700
Message-Id: <20210425224709.1312655-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210425224540.GA1312438@paulmck-ThinkPad-P17-Gen-1>
References: <20210425224540.GA1312438@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, WATCHDOG_THRESHOLD is set to detect a 62.5-millisecond skew in
a 500-millisecond WATCHDOG_INTERVAL.  This requires that clocks be skewed
by more than 12.5% in order to be marked unstable.  Except that a clock
that is skewed by that much is probably destroying unsuspecting software
right and left.  And given that there are now checks for false-positive
skews due to delays between reading the two clocks, and given that current
hardware clocks all increment well in excess of 1MHz, it should be possible
to greatly decrease WATCHDOG_THRESHOLD.

Therefore, decrease WATCHDOG_THRESHOLD from the current 62.5 milliseconds
down to 200 microseconds.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Mark Rutland <Mark.Rutland@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
[ paulmck: Apply Rik van Riel feedback. ]
Reported-by: Chris Mason <clm@fb.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/time/clocksource.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 070b09dab815..a374cf7b6336 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -125,7 +125,7 @@ static void __clocksource_change_rating(struct clocksource *cs, int rating);
  * Interval: 0.5sec Threshold: 0.0625s
  */
 #define WATCHDOG_INTERVAL (HZ >> 1)
-#define WATCHDOG_THRESHOLD (NSEC_PER_SEC >> 4)
+#define WATCHDOG_THRESHOLD (200 * NSEC_PER_USEC)
 #define WATCHDOG_SYNC_FORGIVENESS (HZ * 60UL)
 
 /*
@@ -133,7 +133,7 @@ static void __clocksource_change_rating(struct clocksource *cs, int rating);
  * clocksource surrounding a read of the clocksource being validated.
  * This delay could be due to SMIs, NMIs, or to VCPU preemptions.
  */
-#define WATCHDOG_MAX_SKEW (100 * NSEC_PER_USEC)
+#define WATCHDOG_MAX_SKEW (50 * NSEC_PER_USEC)
 
 static void clocksource_watchdog_work(struct work_struct *work)
 {
-- 
2.31.1.189.g2e36527f23

