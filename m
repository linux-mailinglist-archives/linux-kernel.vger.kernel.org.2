Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE6C333D630
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 15:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237616AbhCPOyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 10:54:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:53996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231277AbhCPOxz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 10:53:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 475DE6508C;
        Tue, 16 Mar 2021 14:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615906434;
        bh=iDvKivvZe2AXkjSJBSIKjW2/ReT9lsm6+x92RtUJwP0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oAvXHV1ScYZF8wjabtZwQG2KTgM9YxZJ4ZhCefyUz8MAPSnHJYDC1xaHBeTfaVVD/
         mKP7soyeQSXgCzC4NhJpa0daF9kB+VqmKI+XS4TgnYFDvANG6Hx5YewXFlY1Wzpy/5
         8BgpfHN+G4j1kUR25iRRYCVJO8MJvhGMAe9zcd/cmS3F+kRsyg/RMc7D2sv1nMPsTs
         aN5dmPJ8/qwbB+mHm6hDFQzKJk8Yqz2eXA8luVq/MaxzURXL0d6KLv2bmYo3rrZjM3
         0VApLMnJngKfNmnvtyDChxG/UWnxg9QRNKjX379x+l5/RIy3NJsho28x2KBYPmGqEO
         bL5NqW0tNARUA==
Date:   Tue, 16 Mar 2021 15:53:52 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "Zhou Ti (x2019cwm)" <x2019cwm@stfx.ca>,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 01/10] tick/nohz: Prevent tick_nohz_get_sleep_length()
 from returning negative value
Message-ID: <20210316145352.GE639918@lothringen>
References: <20210311123708.23501-1-frederic@kernel.org>
 <20210311123708.23501-2-frederic@kernel.org>
 <YFCiycIaViYCy3GH@hirez.programming.kicks-ass.net>
 <20210316133703.GC639918@lothringen>
 <YFDCOYstnDWPSWRU@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFDCOYstnDWPSWRU@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 03:35:37PM +0100, Peter Zijlstra wrote:
> On Tue, Mar 16, 2021 at 02:37:03PM +0100, Frederic Weisbecker wrote:
> > On Tue, Mar 16, 2021 at 01:21:29PM +0100, Peter Zijlstra wrote:
> > > On Thu, Mar 11, 2021 at 01:36:59PM +0100, Frederic Weisbecker wrote:
> > > > From: "Zhou Ti (x2019cwm)" <x2019cwm@stfx.ca>
> > > > 
> > > > If the hardware clock happens to fire its interrupts late, two possible
> > > > issues can happen while calling tick_nohz_get_sleep_length(). Either:
> > > > 
> > > > 1) The next clockevent device event is due past the last idle entry time.
> > > > 
> > > > or:
> > > > 
> > > > 2) The last timekeeping update happened before the last idle entry time
> > > >    and the next timer callback expires before the last idle entry time.
> > > > 
> > > > Make sure that both cases are handled to avoid returning a negative
> > > > duration to the cpuidle governors.
> > > 
> > > Why? ... and wouldn't it be cheaper the fix the caller to
> > > check negative once, instead of adding two branches here?
> > 
> > There are already two callers and potentially two return values to check
> > for each because the function returns two values.
> > 
> > I'd rather make the API more robust instead of fixing each callers and worrying
> > about future ones.
> 
> But what's the actual problem? The Changelog doesn't say why returning a
> negative value is a problem, and in fact the return value is explicitly
> signed.
> 
> Anyway, I don't terribly mind the patch, I was just confused by the lack
> of actual justification.

And you're right, the motivation is pure FUD: I don't know exactly
how the cpuidle governors may react to such negative values and so this
is just to prevent from potential accident.

Rafael, does that look harmless to you?
