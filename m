Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4793632AB
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Apr 2021 01:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235589AbhDQXlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 19:41:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:52708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229865AbhDQXlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 19:41:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 95289610C8;
        Sat, 17 Apr 2021 23:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618702829;
        bh=VgV9ikKq0R4LGvajS9HYOiMJP4jAPJgDL9L+rKl6+Yc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=lrtLt0webkK4ldlBG7p2Xc5BOOhaaGye25ivRhZedKgs/icf5b8yX6SP/+/TX3uwN
         nPePK6gL0Jm05mALxYeLj59jz7TZjYFXUqMsMXgcQ4qNmWtgRT0MW18cUptTqQIkN9
         SMKfxdxY5l5OWi3Xpeozw5BOAR7moZB9swfHp2DHWC+nvXGyG+muQazMSRVdmP3WDa
         qvccG3a7M/EI6k5hEp63K/q2SWMgVULyCGyRT+pgJhS/x5261UQDKQqOx0PApZFR6u
         uI3/MyYb5ube8MU1C/PZCW1sz33APXRGjhriUwekgCxWo0sxlNAReHeqOhSBoC/E6S
         UGxSQv8ana2qQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 646E95C051E; Sat, 17 Apr 2021 16:40:28 -0700 (PDT)
Date:   Sat, 17 Apr 2021 16:40:28 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@fb.com, neeraju@codeaurora.org,
        ak@linux.intel.com, Chris Mason <clm@fb.com>
Subject: Re: [PATCH v8 clocksource 2/5] clocksource: Retry clock read if long
 delays detected
Message-ID: <20210417234028.GB5006@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210414043435.GA2812539@paulmck-ThinkPad-P17-Gen-1>
 <20210414043602.2812981-2-paulmck@kernel.org>
 <87y2dhrte0.ffs@nanos.tec.linutronix.de>
 <20210417225409.GA5006@paulmck-ThinkPad-P17-Gen-1>
 <87eef8sdtd.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87eef8sdtd.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 18, 2021 at 01:15:26AM +0200, Thomas Gleixner wrote:
> On Sat, Apr 17 2021 at 15:54, Paul E. McKenney wrote:
> > On Sat, Apr 17, 2021 at 02:24:23PM +0200, Thomas Gleixner wrote:
> >> I so wish we could just delete all of this horror instead of making it
> >> more horrible.
> >
> > Revisit deleting it in five years if there are no issues, whatever
> > "issue" might mean in this context?  Five years should give time for
> > this to propagate to the enterprise distros.
> 
> That does not help with the fact that the broken hardware will still be
> around in 5 years from now. Which is what prevents me from deleting the
> whole watchdog muck ...

Ouch!  Sigh...

							Thanx, Paul
