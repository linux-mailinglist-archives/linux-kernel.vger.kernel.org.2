Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAC9392D51
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 13:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234356AbhE0L6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 07:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233633AbhE0L6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 07:58:20 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09411C061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 04:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nbt48evzaN28wkSoEU+iXS88RVoflb2h8pcS9x+yCcw=; b=mit0NZbq08XzeyMfq2+k7o3/va
        8BAguRkXmimM2jJhn0aNDzuzDazc+LXEoaz5p1aPNXsew2YB6LUJw7q5bpXVLykhQ5K5sKffK/C16
        t9V+YdSLFUIYYFRQDp9s55R4kD3pAkRYwdrt5a0bAigEFAGFahLmtZfBDn73Yz6vTmxVtodYaZdlt
        vOQy+0+s37Rlcok4lphdZUKutcGgHGCL0e2TP/SMX1Wv0K38t9FehYHJsgg66MCj9TMfJj74SKShB
        EY289zqrGqv6YyAyCMRhX92sWRmAnwUXsNaj3IWMua0k8XoYQMzKju6UsLiKkvdHe5IMePscxgurX
        WjUEF/0w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lmEcl-000zXg-SP; Thu, 27 May 2021 11:56:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E10D5300202;
        Thu, 27 May 2021 13:56:33 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C808F201D301D; Thu, 27 May 2021 13:56:33 +0200 (CEST)
Date:   Thu, 27 May 2021 13:56:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Len Brown <lenb@kernel.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Chen, Tim C" <tim.c.chen@intel.com>
Subject: Re: [PATCH v5 28/28] x86/fpu/amx: Clear the AMX state when
 appropriate
Message-ID: <YK+I8YEEnhWjuVAd@hirez.programming.kicks-ass.net>
References: <20210523193259.26200-1-chang.seok.bae@intel.com>
 <20210523193259.26200-29-chang.seok.bae@intel.com>
 <1980c78b-d51b-c186-9179-f3c72692ad8a@kernel.org>
 <ff72d7cd-e36d-06d8-d741-645a0504bf65@intel.com>
 <CAJvTdKmQjTmOCwUBk+3dhYzOdsZBadqVdqFUPKRMkfcTccJHuA@mail.gmail.com>
 <bd5a5457-edd7-fc1c-2285-c8392a902298@intel.com>
 <CAJvTdKmOLb0pt2SDgAKfwjxtMzT=t=UoREoPRUmi=4MWzeJ+QA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJvTdKmOLb0pt2SDgAKfwjxtMzT=t=UoREoPRUmi=4MWzeJ+QA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 02:24:54PM -0400, Len Brown wrote:
> On Mon, May 24, 2021 at 1:39 PM Dave Hansen <dave.hansen@intel.com> wrote:
> 
> > >> might be considered nasty.
> 
> > > I'm not excited about burdening the generic idle path with a CPU
> > > feature specific check that would need to be checked on every idle
> > > entry.
> >
> > Me neither.
> >
> > But, the check itself should be cheap.  A cpu_feature_enabled(AMX) check
> > will eliminate even the cost of a branch on systems without AMX.  You
> > could probably even get fancy and also use a static branch that doesn't
> > get enabled until the first AMX user shows up.
> 
> It isn't just the hardware run-time cost.
> It is the source code complexity.
> That code is 100% generic.

Why can't this live in intel_idle.c ? We had to pull out
CPUIDLE_FLAG_TLB_FLUSH because leave_mm() requires RCU, but afaict both
TILERELEASE and XRESTOR do not and could be added to intel_idle_tile(),
which can be used in XXX_cstates[] for the relevant chips instead of
intel_idle() for C6 and up.

intel_idle_tile(args)
{
	bool has_tile = // something XINUSE

	if (has_tile)
		TILERELEASE

	intel_idle(args...);

	if (has_tile)
		// something XRESTOR
}

Hmm?
