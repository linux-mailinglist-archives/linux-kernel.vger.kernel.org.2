Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D277C43A68E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 00:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbhJYWc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 18:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbhJYWc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 18:32:27 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20898C061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 15:30:05 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id n11-20020a17090a2bcb00b001a1e7a0a6a6so612356pje.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 15:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IddZQTyrCr8HT48PQm9m39l5JFYt46wr7uNMWEr0FH0=;
        b=IXTOoHtSl2NEkkG/zSTDmi8NbcF1s0dc235SPl6k0S6Wjg195c43mShxx0hBOH70zb
         0SUW4sIJjngbhS964reoqzKYf+S7osgVm6qtIrCZHOKuKJvfml60NZaa3de3qhG3yr2I
         NVl+ObGA746xxAli4zvcpyUOdXEs1K5ZVZ0/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IddZQTyrCr8HT48PQm9m39l5JFYt46wr7uNMWEr0FH0=;
        b=0vBBywexl669dRxQIy7dwviu4qsvlIiz+rK92ri2UQ45eXAoVjxC+vxdFtTLzvlMo/
         cv7gNPwIcLbdlKBdIB05llq2i27d7OY3/RuN7FAzn5hzSwVPKUaZQFCbXGuvSeQ7ZdFs
         eRAqjFMY4YoWIKLxJ4LOZHB6WQwgXox2+0YV/ekgDwYguhId8/UKOUhh1Uv6fBeDSPSc
         kVkVn4ML7C/gSx1J2jaDolqro7OJP3YhWnTnLV8thpNdc3/RBn5e57UQOZTKkhriFShY
         z1GOInR0qo6hDkIPrjUkTFkpLKQD869pL1jUrCdDpEBowfqI/4aJ+WPFgYTEERbhnFDf
         RAsw==
X-Gm-Message-State: AOAM531OR6sH7IZLtbIxywIYoga+FK0orHdVyCGA7sC0X3lR5anJHZ43
        PAmquHwCFC3wEnbxvKuSfmgU3A5TpeSxmQ==
X-Google-Smtp-Source: ABdhPJyHf74fiyczGcPdRHcai8y8mFtM7Fvwl1YLbpP6dOqH3ElDxBOmPyPOdGGTCyMUPtaRRr9p0Q==
X-Received: by 2002:a17:90a:e7cc:: with SMTP id kb12mr12801334pjb.176.1635201004421;
        Mon, 25 Oct 2021 15:30:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x15sm1958414pfp.30.2021.10.25.15.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 15:30:04 -0700 (PDT)
Date:   Mon, 25 Oct 2021 15:30:03 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Jordy Zomer <jordy@pwning.systems>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] secretmem: Prevent secretmem_users from wrapping to zero
Message-ID: <202110251438.1762406A5@keescook>
References: <20211025181634.3889666-1-willy@infradead.org>
 <202110251225.D01841AE67@keescook>
 <YXcKzKVX7NTAtvPh@casper.infradead.org>
 <202110251402.ADFA4D41BF@keescook>
 <CAHk-=wgvb72urgEM5q_SpXFv1OXnDGY8VFs8QmZPt9_n1bH0CQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgvb72urgEM5q_SpXFv1OXnDGY8VFs8QmZPt9_n1bH0CQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021 at 02:17:58PM -0700, Linus Torvalds wrote:
> On Mon, Oct 25, 2021 at 2:04 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > Is secretmem different? We're trying to count how many of these we have,
> > this is a common pattern in, for example, the network code which does
> > this kind of thing a lot.
> 
> Yes, secretmem is different.

Prefix: I'm fine with this being whatever; it's a corner case, so this
reply is mainly about nailing down the rationales for future decisions.

> A refcount being zero means that the data it referenced no longer exists.

I don't disagree with this definition, but I would like to understand how
some other use-cases fit into this. The case of basic allocated object memory
lifetime reference counting we all agree on. What about the case of what
I see that is more like a "shared resource usage count" where the shared
resource doesn't necessarily disappear when we reach "no users"?

i.e. there is some resource, and it starts its life with no one using it
(count = 1). Then we have users declaring their use (count = 2) and later
release (count = 1) of the resource. It's not really ever unallocated when
users == 0 (count == 1), but we might use the usage counter for other
things and don't want to let it go negative or ever increment from zero
(in case zero is used for marking the resource unavailable forever). For
example, protocols knowing if there are any sockets left open, crypto
API usage counts, kernel module usage counts, etc.

I don't see as clear a distinction between secretmem and the above
examples. The question being answered is "how many users do I have?" and
we want to make sure we don't end up with overflow or underflow given the
(unfortunately) common case of reference counting kernel bugs. The fact
that secretmem doesn't have its own allocation to free when it hits 0
seems like just an implementation detail of this particular resource
usage counter.

But, ignoring secretmem for a moment, what about a specific example
from above: the module loader's refcnt atomic_t, which is actually
maintaining an allocation (the module), and uses usage counts of 0 to mean
"I am removing this module", and 1 is "I have no users", 2 is "1 user",
etc. It seems like this should use refcount_t to me?

> Stop arguing for garbage. It was wrong, just admit it. The semantics
> for "refcount" is something else than what that code had. As a result,
> it got reverted. I've applied Willy's patch that actually makes sense.
> 
> Arguing for garbage in the name of "security" is still garbage. In
> fact, it only causes confusion, and as such is likely to result in
> problems - including security problems - later.

Sure, and reasonable people can disagree about what is garbage. :) I see
using a refcount_t here as a not unreasonable way to protect against
potential future security problems if the scope of secretmem ever grows
and more than just hibernation starts to care about this usage counter.

> Because confusion about semantics is bad. And that was what that patch was.
> 
> And I want to state - again - how dangerous this "refcounts are always
> prefereable to atomics" mental model is. Refcounts are _not_
> fundamentally preferable to atomics. They are slower, bigger, and have
> completely different semantics.

I will push back on this; I don't think that's a fair assessment at all.
For storage size, refcount_t is identical to atomic_t (refcount_t _is_
an atomic_t). But perhaps you meant code size? Yes, the refcount_t
helpers are technically larger. But like speed, where refcount_t is also
technically slower, neither size nor speed were so much changed that
we kept around the routines that made it exactly the same speed and
grew the instruction count by 1 (the original x86-specific refcount_t
implementation was just as fast as atomic_t). I don't see speed nor size
alone to be a good reason to say "don't use refcount_t".

But yes, I agree about the different semantics: there are very specific
memory ordering assumptions that tend to be more strict than atomic_t
(which IMO actually makes it more suitable than atomic_t for shared
usage counts).

> So if something isn't a refcount, it damn well shouldn't use "refcount_t".

Again, I don't disagree, but since it looked like a refcount to me, I'd
like to understand what why we don't see this case the same way. Since I
agree that secretmem is currently pretty iffy (nothing actually allocated
to track, only system state), I'll ask a slightly different question:
should the module loader use refcount_t? If not, why?

-- 
Kees Cook
