Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A540B3282C7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 16:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237382AbhCAPrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 10:47:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236819AbhCAPq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 10:46:56 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFC4C061756;
        Mon,  1 Mar 2021 07:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fGQP+mV2y92qkbpjMBXPSQ03FtN3LiZq6yfm+Qczok4=; b=eINfi8rePq0BOqcbnRkDRGaTUU
        j/qrilFBjLOCeVw+dDK6ymE27NlfTD4qj5PiC9OpEr92WRQhvK5mhl7EptC4VPBADqYyJ1mXMTKWZ
        uD7r9jykhVFHBsqVynWGVz581McsTNLQ+uvh9G6q5zpYKTulcgADr2pUFmQpLcVHECdoVk7fVZKDq
        abk3z4yLDVmB5v1h+3UvRwB/nnF/QT3CirQbrsTFT5WpID+C1WeE6KYyEbWFpdyvIAdJjCTxvqFCH
        H4ASfBxiccWVlcOowbbH4SA0XB89kiH0ckEJtrbNWWglMNnrcCMPhVHWdrVW5ByJo4+gjFEIZcCe2
        qjFREMYg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lGkjs-00FuI6-5F; Mon, 01 Mar 2021 15:45:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B8346301959;
        Mon,  1 Mar 2021 16:45:39 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A9A3620C80E0E; Mon,  1 Mar 2021 16:45:39 +0100 (CET)
Date:   Mon, 1 Mar 2021 16:45:39 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, mhocko@suse.com,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 3/3] kernel/smp: add more data to CSD lock debugging
Message-ID: <YD0MI1Cye+YbOov3@hirez.programming.kicks-ass.net>
References: <20210226112521.8641-1-jgross@suse.com>
 <20210226112521.8641-4-jgross@suse.com>
 <YDkkFBerBlW5uUBS@hirez.programming.kicks-ass.net>
 <20210226181205.GZ2743@paulmck-ThinkPad-P72>
 <YDlirwTWMmZ3g0ts@hirez.programming.kicks-ass.net>
 <20210301000704.GF2696@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210301000704.GF2696@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 28, 2021 at 04:07:04PM -0800, Paul E. McKenney wrote:
> On Fri, Feb 26, 2021 at 10:05:51PM +0100, Peter Zijlstra wrote:
> > On Fri, Feb 26, 2021 at 10:12:05AM -0800, Paul E. McKenney wrote:
> > > On Fri, Feb 26, 2021 at 05:38:44PM +0100, Peter Zijlstra wrote:
> > > > 
> > > > I hate all of this, but if this will finally catch the actual problem,
> > > > we can then revert all this, so sure.
> > > 
> > > OK, I will bite...  What exactly do you hate about it?
> > 
> > It's ugly and messy. We're basically commiting a debug session. Normally
> > gunk like this is done in private trees, then we find the problem and
> > fix that and crap like this never sees the light of day.
> 
> Is your hatred due to the presence of debug code at all, or a belief that
> this code is unlikely to be useful in any subsequent IPI-related bug hunt?

The clutter, mostly I think. There's a lot of debug sprinkled about.
