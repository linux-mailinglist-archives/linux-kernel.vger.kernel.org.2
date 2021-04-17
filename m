Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4B4362C6A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 02:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235110AbhDQAZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 20:25:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:39378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229719AbhDQAZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 20:25:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 94C67611AC;
        Sat, 17 Apr 2021 00:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618619121;
        bh=udOYoMsGWJqI1Bs7o5HTBOVlM4gttNyQUPGQSQKxVHo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=AY7TtHY2RtowjEOBO3Dh0KANPe6vJYAhjtsNXdAd2XW3TL4siIE4OmIdAj0O0Qe5A
         AcbWuYPw4wgCONMwdkGBp8Msd4uPnvdxDfLgtIOtPQtlbxoCChDImWLPfHZDQKl+cL
         zU/jGVrkbym6pYOsY7sfHRhAiis/GxvTy/U+ncIJu0fdPYxH59I9QiItfRu58DlGBb
         DtzCiiBjuivIEYkjgwrxRclQ8KsAupHo51T/eFsSUZVVE5a0L6JXz5W3BrF2Q2DvIQ
         WtbzyCMrw7SNsEYeMOK/QnBmGusawe7ARHi2YN3iaLuesbYeb7Inx1f/TMlkA+Zkqm
         l0TYuCazyegtw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 601EF5C251A; Fri, 16 Apr 2021 17:25:21 -0700 (PDT)
Date:   Fri, 16 Apr 2021 17:25:21 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@fb.com, neeraju@codeaurora.org,
        ak@linux.intel.com, Chris Mason <clm@fb.com>
Subject: Re: [PATCH v8 clocksource 2/5] clocksource: Retry clock read if long
 delays detected
Message-ID: <20210417002521.GP4212@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210414043602.2812981-2-paulmck@kernel.org>
 <871rbauffb.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871rbauffb.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 10:45:28PM +0200, Thomas Gleixner wrote:
> On Tue, Apr 13 2021 at 21:35, Paul E. McKenney wrote:
> >  #define WATCHDOG_INTERVAL (HZ >> 1)
> >  #define WATCHDOG_THRESHOLD (NSEC_PER_SEC >> 4)
> 
> Didn't we discuss that the threshold is too big ?

Indeed we did!  How about like this, so that WATCHDOG_INTERVAL is at 500
microseconds and we tolerate up to 125 microseconds of delay during the
timer-read process?

I am firing up overnight tests.

							Thanx, Paul

------------------------------------------------------------------------

commit 6c52b5f3cfefd6e429efc4413fd25e3c394e959f
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Fri Apr 16 16:19:43 2021 -0700

    clocksource: Reduce WATCHDOG_THRESHOLD
    
    Currently, WATCHDOG_THRESHOLD is set to detect a 62.5-millisecond skew in
    a 500-millisecond WATCHDOG_INTERVAL.  This requires that clocks be skewed
    by more than 12.5% in order to be marked unstable.  Except that a clock
    that is skewed by that much is probably destroying unsuspecting software
    right and left.  And given that there are now checks for false-positive
    skews due to delays between reading the two clocks, and given that current
    hardware clocks all increment well in excess of 1MHz, it should be possible
    to greatly decrease WATCHDOG_THRESHOLD.
    
    Therefore, decrease WATCHDOG_THRESHOLD from the current 62.5 milliseconds
    down to 500 microseconds.
    
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

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 8f4967e59b05..4ec19a13dcf0 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -125,8 +125,8 @@ static void __clocksource_change_rating(struct clocksource *cs, int rating);
  * Interval: 0.5sec Threshold: 0.0625s
  */
 #define WATCHDOG_INTERVAL (HZ >> 1)
-#define WATCHDOG_THRESHOLD (NSEC_PER_SEC >> 4)
-#define WATCHDOG_MAX_SKEW (NSEC_PER_SEC >> 6)
+#define WATCHDOG_THRESHOLD (500 * NSEC_PER_USEC)
+#define WATCHDOG_MAX_SKEW (WATCHDOG_THRESHOLD / 4)
 
 static void clocksource_watchdog_work(struct work_struct *work)
 {
