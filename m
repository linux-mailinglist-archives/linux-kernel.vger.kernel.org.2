Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D93532757A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 01:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbhCAAHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Feb 2021 19:07:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:41932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230412AbhCAAHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Feb 2021 19:07:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 93C2B64E10;
        Mon,  1 Mar 2021 00:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614557224;
        bh=EOHLpSwtZLgHIs2j7IOL7U85lAC+hVAOyqWikacMpr0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=iEvPjBP4gy8IEo+NgPOGnBYkzpA1rt5YpMo9j425qNB8oJr3YsHxy5MOFtIMgFkSU
         FKtGJeg0R2EsTHdHKw6fp8sxo7Kdtm5ESi97M0On04Kd8VD3CNfNOIXdQE7/1QLSy7
         SGBrMvcjB2ht7vyj+/4FDDz+JE42xXYE/QdZnLBLkj9PaLaFK16dP/sLbM4NUeGbGV
         qKn9TgVtHOxrk2322+mHRigjqazbPyXC8Bd+0JuJ1jmGlx87U/pE1SVGGb6DYSI8Im
         xh0EkMXUf/iamgIh2BaBMgdhJa8ldUMF1bNOr693Mbpu6+ftd5+qqfzkus6yHvQuuY
         B5J3z6rFPWApQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 5547335239D3; Sun, 28 Feb 2021 16:07:04 -0800 (PST)
Date:   Sun, 28 Feb 2021 16:07:04 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, mhocko@suse.com,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 3/3] kernel/smp: add more data to CSD lock debugging
Message-ID: <20210301000704.GF2696@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210226112521.8641-1-jgross@suse.com>
 <20210226112521.8641-4-jgross@suse.com>
 <YDkkFBerBlW5uUBS@hirez.programming.kicks-ass.net>
 <20210226181205.GZ2743@paulmck-ThinkPad-P72>
 <YDlirwTWMmZ3g0ts@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YDlirwTWMmZ3g0ts@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 10:05:51PM +0100, Peter Zijlstra wrote:
> On Fri, Feb 26, 2021 at 10:12:05AM -0800, Paul E. McKenney wrote:
> > On Fri, Feb 26, 2021 at 05:38:44PM +0100, Peter Zijlstra wrote:
> > > 
> > > I hate all of this, but if this will finally catch the actual problem,
> > > we can then revert all this, so sure.
> > 
> > OK, I will bite...  What exactly do you hate about it?
> 
> It's ugly and messy. We're basically commiting a debug session. Normally
> gunk like this is done in private trees, then we find the problem and
> fix that and crap like this never sees the light of day.

Is your hatred due to the presence of debug code at all, or a belief that
this code is unlikely to be useful in any subsequent IPI-related bug hunt?

							Thanx, Paul
