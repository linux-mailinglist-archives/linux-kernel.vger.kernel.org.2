Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC41C3F2851
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 10:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbhHTIZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 04:25:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:40312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230077AbhHTIZl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 04:25:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7A112610A3;
        Fri, 20 Aug 2021 08:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629447904;
        bh=4zuMd4m7p1eR8VRfwtyd8SamPC6YHM7BjTVw1hV8o74=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Eg7LkK5l4UtJTA97Lw2VDJbt56j5SiiDvAZqCGMDbaWHkEO/kEUQQrEg7GSbT2RVJ
         QWNdqk+kK2mmFFe8hGO1hFcIWoJMGwNJKtQPeUqKw60/c4pDITEmoVmP4tpKv37fhK
         +sRU8TbrsHWSjKLTzsaWyRDHX9KhH3qjio56ARaRxOHGBU8QLd+YVwU6/PkY/vgKSq
         GLTQKbpuGuUXPoD0oHibx4AeBr/XogQOlWkRyUAB6FipROU4FYibQjliClTUDbHjmy
         NUMMVeqAv3HAd9LTGqnlcx9aF1DTUbPtw1QdrVnFbRQ+qaGDBoYpisA1QsOIsIVc+c
         TmONRcZZVw3hg==
Date:   Fri, 20 Aug 2021 09:24:58 +0100
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Alistair Popple <apopple@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, yuanxzhang@fudan.edu.cn,
        Xin Tan <tanxin.ctf@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        David Howells <dhowells@redhat.com>, keescook@chromium.org
Subject: Re: [PATCH] mm/rmap: Convert from atomic_t to refcount_t on
 anon_vma->refcount
Message-ID: <20210820082457.GA16784@willie-the-truck>
References: <1626665029-49104-1-git-send-email-xiyuyang19@fudan.edu.cn>
 <20210720160127.ac5e76d1e03a374b46f25077@linux-foundation.org>
 <20210819132131.GA15779@willie-the-truck>
 <YR5ldaQvAnCKMnkk@hirez.programming.kicks-ass.net>
 <YR52igt/lJ7gQqOG@hirez.programming.kicks-ass.net>
 <CAHk-=wh_vEzmYnMufOa=03WAU=DRM5+n6uZy=dVtJERFJm3Q-Q@mail.gmail.com>
 <YR9PHD+pWTelGKVd@hirez.programming.kicks-ass.net>
 <YR9k0hzMJpNF/0qL@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YR9k0hzMJpNF/0qL@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2021 at 10:16:18AM +0200, Peter Zijlstra wrote:
> On Fri, Aug 20, 2021 at 08:43:40AM +0200, Peter Zijlstra wrote:
> 
> > Fine with me; although the immediate complaint from Andrew was about
> > size, hence my UD1 hackery.
> > 
> > > So if we do this, I think it should be something like
> > > 
> > >    static inline __must_check bool refcount_dec_and_test(refcount_t *r)
> > >    {
> > >         asm_volatile_goto (LOCK_PREFIX "decl %[var]\n\t"
> > >                 "jz %l[cc_zero]\n\t"
> > >                 "jl %l[cc_error]"
> > >                 : : [var] "m" (r->refs.counter)
> > >                 : "memory" : cc_zero, cc_error);
> > > 
> > >         return false;
> > > 
> > >    cc_zero:
> > >         return true;
> > >    cc_error:
> > >         refcount_warn_saturate(r, REFCOUNT_SUB_UAF);
> > >         return false;
> > >    }
> > > 
> > > and we can discuss whether we could improve on the
> > > refcount_warn_saturate() separately.
> > 
> > I can do the refcount_warn_saturate() change separately.
> > 
> > Let me go check how small I can get it...
> 
> gcc-10.2.1, x86_64-defconfig
> 
> kernel/event/core.o-inline-ud1:     96454
> kernel/event/core.o-outofline-ud1:  96604
> kernel/event/core.o-outofline-call: 97072
> 
> (42 refcount_warn_saturate/ud1 instances in that file,
>  10 of which are refcount_dec_and_test)

Is that with the saturation moved to the UD handler as well? I think it
would be good to keep that as close to the point at which we detect the
problem as we can, so perhaps we can inline that part and leave the
diagnostics to the exception handler?

Will
