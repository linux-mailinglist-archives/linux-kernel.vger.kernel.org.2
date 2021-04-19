Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFA63363AAA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 06:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbhDSEyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 00:54:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:49492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231646AbhDSExn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 00:53:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1E10B61359;
        Mon, 19 Apr 2021 04:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618807982;
        bh=61SePc1GcT9sPgJaob+M5p4af6p5YFJt5b4qYSd6fRg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ILfRq+qRfGmLJDBFtr7oCe9O8vuwsHZRYLABBktRmxNlnEOXsLimHjoustp1hURq7
         54jXISgR5q5DHsUnB6HCkpJZnlTVVXURkgJCVyzZsoAjU6u8yt/4LPDBtWXdwviC1n
         AeKMlSynF4zxo76Xd4+8Rcv5KOCqdd6qkGSVnZBIwxRVB5Iax/5f9RPP7ta1AHBHQ4
         WB73jwcBkVyb5636wH8bKiQfqhwcip/JQG9OFbsF1e0pRA9g8pAQ4o3jLifDKcg09H
         JEY9L+McBMO3f1pFlV7QDHW+he5i2cIE5TFf/ts7pd2SA1LlSHvqmOadK3rJNULPBo
         UKtb4Dicupz4A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A21555C04FE; Sun, 18 Apr 2021 21:53:01 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@fb.com, neeraju@codeaurora.org,
        ak@linux.intel.com, "Paul E. McKenney" <paulmck@kernel.org>,
        Chris Mason <clm@fb.com>
Subject: [PATCH v9 clocksource 6/6] clocksource: Reduce WATCHDOG_THRESHOLD
Date:   Sun, 18 Apr 2021 21:53:00 -0700
Message-Id: <20210419045300.596332-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210419045155.GA596058@paulmck-ThinkPad-P17-Gen-1>
References: <20210419045155.GA596058@paulmck-ThinkPad-P17-Gen-1>
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
index 2981e293a468..d82ad0492777 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -125,14 +125,14 @@ static void __clocksource_change_rating(struct clocksource *cs, int rating);
  * Interval: 0.5sec Threshold: 0.0625s
  */
 #define WATCHDOG_INTERVAL (HZ >> 1)
-#define WATCHDOG_THRESHOLD (NSEC_PER_SEC >> 4)
+#define WATCHDOG_THRESHOLD (200 * NSEC_PER_USEC)
 
 /*
  * Maximum permissible delay between two readouts of the watchdog
  * clocksource surrounding a read of the clocksource being validated.
  * This delay could be due to SMIs, NMIs, or to VCPU preemptions.
  */
-#define WATCHDOG_MAX_SKEW (100 * NSEC_PER_USEC)
+#define WATCHDOG_MAX_SKEW (50 * NSEC_PER_USEC)
 
 static void clocksource_watchdog_work(struct work_struct *work)
 {
-- 
2.31.1.189.g2e36527f23

