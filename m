Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB80132599E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 23:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbhBYWZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 17:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbhBYWWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 17:22:09 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2B5C061788
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 14:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rWub/DMObw9aa3UyAYei0G79+z5B7WgwOLJHn6sffYQ=; b=xnoLnPpMpQvjfrBMNgIN2GM8Df
        l2W0dmEKAKq+lSc6ov38zcBvjlucJW7EeLvL9MYPkz+HbrTBD9EYfEPX8jQYy+7wyqbAz6NFKSlaM
        ldqE87E3JJ8pPTK4BXUoZgv5+Q05MNQwK0+MvHLq2PxpSJ/2955OfXmVRZ2oXapgiVfnM0303apWe
        pgG2krMmGV09d7hhEieugl2/FLS6RzwtnMhgfsb89L7Ug+6Hy+Nftn/9Vik2ZtRvLbHsLtsMN30ec
        qUJT9c+tDxcrwIUGZZQkVTPEOgKJ7HdSSeYById7g/rSC19fbGinhGENiaowIdjnAd3N6APWb5yTH
        31k5Ypkg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lFP0a-0008Hr-6X; Thu, 25 Feb 2021 22:21:20 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9775E9864D3; Thu, 25 Feb 2021 23:21:17 +0100 (CET)
Date:   Thu, 25 Feb 2021 23:21:17 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        syzbot+d7581744d5fd27c9fbe1@syzkaller.appspotmail.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, luto@kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        syzkaller-bugs@googlegroups.com,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>
Subject: Re: [PATCH] sched/fair: Fix shift-out-of-bounds in load_balance()
Message-ID: <20210225222117.GF4746@worktop.programming.kicks-ass.net>
References: <20210225175656.17006-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225175656.17006-1-valentin.schneider@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 05:56:56PM +0000, Valentin Schneider wrote:
> Syzbot reported a handful of occurrences where an sd->nr_balance_failed can
> grow to much higher values than one would expect.
> 
> A successful load_balance() resets it to 0; a failed one increments
> it. Once it gets to sd->cache_nice_tries + 3, this *should* trigger an
> active balance, which will either set it to sd->cache_nice_tries+1 or reset
> it to 0. However, in case the to-be-active-balanced task is not allowed to
> run on env->dst_cpu, then the increment is done without any further
> modification.
> 
> This could then be repeated ad nauseam, and would explain the absurdly high
> values reported by syzbot (86, 149). VincentG noted there is value in
> letting sd->cache_nice_tries grow, so the shift itself should be
> fixed. That means preventing:
> 
>   """
>   If the value of the right operand is negative or is greater than or equal
>   to the width of the promoted left operand, the behavior is undefined.
>   """
> 
> Thus we need to cap the shift exponent to
>   BITS_PER_TYPE(typeof(lefthand)) - 1.
> 

Thanks!
