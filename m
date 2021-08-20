Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1F9D3F2701
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 08:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238525AbhHTGow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 02:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231998AbhHTGov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 02:44:51 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552E1C061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 23:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=z8KFItNI7mVsJ+C1MoNIJsoXQ10X1syrvXI2kfF+1oU=; b=l43CxEtXJhMMYRI0aDC2rF5ZzB
        TN47illQ2FfshWt7MAXfTjaTikzcg6U94BkVCtc51tBPw26gM7qZYaeUwhe0Ap/zfeQ1273Bf2Vcs
        Gsc9XxuuwdUgQdGw6coCXlcw2Q3r1kxGSX3TqGNIwTzGM8EUoo7sxn49VCI6WE1LB6Lj0Yz4YAudw
        eIG0tVzWCtKXUtnGR6o9+HrzMqDu33WwA2WlelI7+OhZT55CneBaauPDlK2MPm4bw7IfAO0vpcC/p
        oTVhTQ6Saapsg+btW0uMdBQddylsQb13l8DCp6goC8ALS01TEVEpuHFqe2LO9xO/kFdQ6tLfiQPks
        gwFyv9Qg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGyFi-00BLrB-Up; Fri, 20 Aug 2021 06:43:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 26B59300233;
        Fri, 20 Aug 2021 08:43:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 15F692015BC65; Fri, 20 Aug 2021 08:43:40 +0200 (CEST)
Date:   Fri, 20 Aug 2021 08:43:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
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
Message-ID: <YR9PHD+pWTelGKVd@hirez.programming.kicks-ass.net>
References: <1626665029-49104-1-git-send-email-xiyuyang19@fudan.edu.cn>
 <20210720160127.ac5e76d1e03a374b46f25077@linux-foundation.org>
 <20210819132131.GA15779@willie-the-truck>
 <YR5ldaQvAnCKMnkk@hirez.programming.kicks-ass.net>
 <YR52igt/lJ7gQqOG@hirez.programming.kicks-ass.net>
 <CAHk-=wh_vEzmYnMufOa=03WAU=DRM5+n6uZy=dVtJERFJm3Q-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh_vEzmYnMufOa=03WAU=DRM5+n6uZy=dVtJERFJm3Q-Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2021 at 12:09:37PM -0700, Linus Torvalds wrote:
> On Thu, Aug 19, 2021 at 8:21 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > If we can skip the OF... we can do something like this:
> 
> Honestly, I think a lot of the refcount code is questionable. It was
> absolutely written with no care for performance AT ALL.

That's a bit unfair I feel. Will's last rewrite of the stuff was
specifically to address performance issues.

> I'm not sure it helps to then add arch-specific code for it without
> thinking it through a _lot_ first.
> 
> It might be better to just have a "atomic_t with overflow handling" in
> general, exactly because the refcount_t was designed and written
> without any regard for code that cares about performance.

The primary concern was to use a single unconditional atomic op where
possible (mostly fetch_add), as the atomic op dominates whatever else it
does. The rest is just because C absolutely sucks at conditions.

Doing atomic_t with overflow handling would require doing the whole
thing in arch asm.

> > static inline bool refcount_dec_and_test(refcount_t *r)
> > {
> >         asm_volatile_goto (LOCK_PREFIX "decl %[var]\n\t"
> >                            "jz %l[cc_zero]\n\t"
> >                            "jns 1f\n\t"
> 
> I think you can use "jl" for the bad case.

Duh yes. I clearly didn't have my head on straight.

> I think it's better to handle that case out-of-line than play games
> with UD, though - this is going to be the rare case, the likelihood
> that we get the fixup wrong is just too big. Once it's out-of-line
> it's not as critical any more, even if it does add to the size of the
> code.

Fine with me; although the immediate complaint from Andrew was about
size, hence my UD1 hackery.

> So if we do this, I think it should be something like
> 
>    static inline __must_check bool refcount_dec_and_test(refcount_t *r)
>    {
>         asm_volatile_goto (LOCK_PREFIX "decl %[var]\n\t"
>                 "jz %l[cc_zero]\n\t"
>                 "jl %l[cc_error]"
>                 : : [var] "m" (r->refs.counter)
>                 : "memory" : cc_zero, cc_error);
> 
>         return false;
> 
>    cc_zero:
>         return true;
>    cc_error:
>         refcount_warn_saturate(r, REFCOUNT_SUB_UAF);
>         return false;
>    }
> 
> and we can discuss whether we could improve on the
> refcount_warn_saturate() separately.

I can do the refcount_warn_saturate() change separately.

Let me go check how small I can get it...

> But see above: maybe just make this a separate "careful atomic_t",
> with the option to panic-on-overflow. So then we could get rid of
> refcount_warn_saturate() enmtirely above, and instead just have a
> (compile-time option) BUG() case, with the non-careful version just
> being our existing atomic_dec_and_test.

We used to have that option; the argument was made that everybody cares
about security and as long as this doesn't show up on benchmarks we
good.

Also, I don't think most people want the overflow to go BUG, WARN is
mostly the right thing and only the super paranoid use panic-on-warn or
something.

