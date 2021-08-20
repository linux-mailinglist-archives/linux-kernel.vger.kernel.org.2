Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED6C3F2840
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 10:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbhHTIUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 04:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbhHTIUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 04:20:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48249C061575
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 01:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YFi+FW2U2s7s29whrwZAMBkRsLUDaIoWOOpz9VPBCJc=; b=RJ52XRy7Mbgn6kkEQRDJI1GNqh
        2icOetgEGmJ9/zuyZrXd3JV4fhXN+gFZh+vNyyDo+2kMmkm3Pljp9OFFdEZnWRi20ll7ZmVLWxp7n
        XmlFl/hD0cRYEemaQNV9j/pEuqCfgnkztOm3IhVLj+lwy4WWpIeEYdL6f7JovuEA9EHSEFfwEsyA9
        tCsEMpdbDmD37Jm1ow5sptIvB/6zpFx17QcqdIHnBSYlfR71VJfD1IRw8ELTI+y5IOtAxtNNJ9Rwg
        sq4TnhZ3MSCspgatiu6/19kn90GVqO9x6Q6ErDxNRTwa4A+fdpUns5b6VeIppLZU4XHG6gnX5e0M4
        Ox8Z5+Wg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGzhN-006Ew6-JE; Fri, 20 Aug 2021 08:16:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1EA5B3004B2;
        Fri, 20 Aug 2021 10:16:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F2F802D80FBBE; Fri, 20 Aug 2021 10:16:18 +0200 (CEST)
Date:   Fri, 20 Aug 2021 10:16:18 +0200
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
Message-ID: <YR9k0hzMJpNF/0qL@hirez.programming.kicks-ass.net>
References: <1626665029-49104-1-git-send-email-xiyuyang19@fudan.edu.cn>
 <20210720160127.ac5e76d1e03a374b46f25077@linux-foundation.org>
 <20210819132131.GA15779@willie-the-truck>
 <YR5ldaQvAnCKMnkk@hirez.programming.kicks-ass.net>
 <YR52igt/lJ7gQqOG@hirez.programming.kicks-ass.net>
 <CAHk-=wh_vEzmYnMufOa=03WAU=DRM5+n6uZy=dVtJERFJm3Q-Q@mail.gmail.com>
 <YR9PHD+pWTelGKVd@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YR9PHD+pWTelGKVd@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2021 at 08:43:40AM +0200, Peter Zijlstra wrote:

> Fine with me; although the immediate complaint from Andrew was about
> size, hence my UD1 hackery.
> 
> > So if we do this, I think it should be something like
> > 
> >    static inline __must_check bool refcount_dec_and_test(refcount_t *r)
> >    {
> >         asm_volatile_goto (LOCK_PREFIX "decl %[var]\n\t"
> >                 "jz %l[cc_zero]\n\t"
> >                 "jl %l[cc_error]"
> >                 : : [var] "m" (r->refs.counter)
> >                 : "memory" : cc_zero, cc_error);
> > 
> >         return false;
> > 
> >    cc_zero:
> >         return true;
> >    cc_error:
> >         refcount_warn_saturate(r, REFCOUNT_SUB_UAF);
> >         return false;
> >    }
> > 
> > and we can discuss whether we could improve on the
> > refcount_warn_saturate() separately.
> 
> I can do the refcount_warn_saturate() change separately.
> 
> Let me go check how small I can get it...

gcc-10.2.1, x86_64-defconfig

kernel/event/core.o-inline-ud1:     96454
kernel/event/core.o-outofline-ud1:  96604
kernel/event/core.o-outofline-call: 97072

(42 refcount_warn_saturate/ud1 instances in that file,
 10 of which are refcount_dec_and_test)
