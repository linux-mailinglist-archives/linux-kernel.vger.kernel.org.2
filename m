Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEB332938C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 22:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244709AbhCAVZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 16:25:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:48350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237327AbhCARPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 12:15:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2F41164F95;
        Mon,  1 Mar 2021 16:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614617154;
        bh=BgEBO1YfcoTcNSvVv4L2rDo6/saPOBPSddSbNh3hoeg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=RAimudY26B/q7zpn7QUYAmgQGiBDhOU28tUGaSwdmUodjYeIgpTimn5H2s/giTjUG
         1PhAMZo01o7fWuo5sXj9PPCAg0ybYMNI2R4EdJARnLqD5jZocOxQJbhCvSODTIOxz6
         A3LD5LXeCL2Y3rvq+zFsLomQI4imt076IzaeoQdXHT4tQQzn5dAnW+Pnj2lJKOxoCs
         gmdMCioWMTytDkTpxgzDspUVUhBCLzg4aRH6iMsS1Ve8/OnmjR9vuYSocHkeKEjAeg
         VoNuJ+pmwtqfYOFhPRPxp0vS+WcEQv+aT6MxZmpeNE4G5dBJPiaIKsn4hNmMOpTWku
         p3BBz/Gulyk7A==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id C1E4735225E7; Mon,  1 Mar 2021 08:45:53 -0800 (PST)
Date:   Mon, 1 Mar 2021 08:45:53 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     =?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        mhocko@suse.com, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 3/3] kernel/smp: add more data to CSD lock debugging
Message-ID: <20210301164553.GI2696@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210226112521.8641-1-jgross@suse.com>
 <20210226112521.8641-4-jgross@suse.com>
 <YDkkFBerBlW5uUBS@hirez.programming.kicks-ass.net>
 <20210226181205.GZ2743@paulmck-ThinkPad-P72>
 <YDlirwTWMmZ3g0ts@hirez.programming.kicks-ass.net>
 <20210301000704.GF2696@paulmck-ThinkPad-P72>
 <YD0MI1Cye+YbOov3@hirez.programming.kicks-ass.net>
 <6bc3d90d-f369-e91d-01f7-b83a48e9721d@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6bc3d90d-f369-e91d-01f7-b83a48e9721d@suse.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01, 2021 at 04:53:27PM +0100, Jürgen Groß wrote:
> On 01.03.21 16:45, Peter Zijlstra wrote:
> > On Sun, Feb 28, 2021 at 04:07:04PM -0800, Paul E. McKenney wrote:
> > > On Fri, Feb 26, 2021 at 10:05:51PM +0100, Peter Zijlstra wrote:
> > > > On Fri, Feb 26, 2021 at 10:12:05AM -0800, Paul E. McKenney wrote:
> > > > > On Fri, Feb 26, 2021 at 05:38:44PM +0100, Peter Zijlstra wrote:
> > > > > > 
> > > > > > I hate all of this, but if this will finally catch the actual problem,
> > > > > > we can then revert all this, so sure.
> > > > > 
> > > > > OK, I will bite...  What exactly do you hate about it?
> > > > 
> > > > It's ugly and messy. We're basically commiting a debug session. Normally
> > > > gunk like this is done in private trees, then we find the problem and
> > > > fix that and crap like this never sees the light of day.
> > > 
> > > Is your hatred due to the presence of debug code at all, or a belief that
> > > this code is unlikely to be useful in any subsequent IPI-related bug hunt?
> > 
> > The clutter, mostly I think. There's a lot of debug sprinkled about.
> 
> I agree.
> 
> In case we are able to identify the root cause of the problem I think
> it would be no problem to revert this patch and put a comment into smp.c
> naming the commit-id of this patch and what it was good for. This will
> enable future bug hunters to make use of the patch without spoiling the
> code for others.

Works for me!

							Thanx, Paul
