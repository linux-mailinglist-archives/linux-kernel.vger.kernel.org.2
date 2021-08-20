Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 152DD3F27AE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 09:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238756AbhHTHek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 03:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238646AbhHTHej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 03:34:39 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3267C061575
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 00:34:01 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id j187so7855073pfg.4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 00:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OdZwHSPvBf7v8TQzJgGvLUz2M9eAxdHhfezfY1ArgPY=;
        b=EmvoMyKhPrYNoLdElwrJbx+ch2kLlhtAaBuHABjBtXG7s3LErAyDyTpRW0WKYwDYu7
         lnBgLN0SGA67qYrSd9mlyGLzp9/QllciG0rtYIy2koKjYw51O7wnBAscI2X6IjExvOV8
         ucWJBay9ZSVGQ3xNPVqOwJb0tucMYAZlIdKTg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OdZwHSPvBf7v8TQzJgGvLUz2M9eAxdHhfezfY1ArgPY=;
        b=eUF9DmUT69GNtPv9fimZP3RWxWNHatD4hUZWBK4+CnyXrDVDSJd4HaPREeXtWf+zk4
         oWBEjeMS8jAyEle07xX11q8dOl0VPCth5wdNUmydJO3Gf5jR0RFQmrD6DkhnmPaneDog
         SLmrii6yXu//uePdhg9M/IdmwfcHFyXvpVkKLM1AyZFTrfUOMAiV2FixZiuhicJMfz1H
         eG2khFJULo9wGVWR9SQoKon5tCMBKLQ+8POVT1x+sij7hUuHWbKaKGHusvqtlArs34K4
         Od1KWcoaMuRiI+G0+X2Fb6cRtisoFKfBHCxpntoGbULoU0kU854RQB1xqrBnsZ4Htjo1
         eHhg==
X-Gm-Message-State: AOAM530nr5FL0VpwgpSv5yOEWyUUUHR9DKRQ7IsoUfI6H/riq8Q7HSRj
        74xWuhVwH7Mxn6OIKC5izXbxpc5rXnp1/g==
X-Google-Smtp-Source: ABdhPJyl8Pz1tgvSdMmTUn1bWAcfV38nnU6/ESt68A28mRcBFWuomuJUbGtSteVQqR4uvUtUHcHy9A==
X-Received: by 2002:a63:1b45:: with SMTP id b5mr17581761pgm.302.1629444841222;
        Fri, 20 Aug 2021 00:34:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 22sm6656587pgn.88.2021.08.20.00.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 00:34:00 -0700 (PDT)
Date:   Fri, 20 Aug 2021 00:33:59 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
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
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] mm/rmap: Convert from atomic_t to refcount_t on
 anon_vma->refcount
Message-ID: <202108200017.9F1744F76@keescook>
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
> On Thu, Aug 19, 2021 at 12:09:37PM -0700, Linus Torvalds wrote:
> > On Thu, Aug 19, 2021 at 8:21 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > If we can skip the OF... we can do something like this:
> > 
> > Honestly, I think a lot of the refcount code is questionable. It was
> > absolutely written with no care for performance AT ALL.
> 
> That's a bit unfair I feel. Will's last rewrite of the stuff was
> specifically to address performance issues.

Well, to address performance issues with the "full" version. The default
x86-specific code was already as fast as atomic_t. Will got it to nearly
match while making it catch all conditions, not just the exploitable
ones. (i.e. it didn't bother trying to catch underflow; there's no way
to mitigate it).

Will's version gave us three properties: correctness (it catches all the
pathological conditions), speed (it was very nearly the same speed as
regular atomic_t), and arch-agnosticism, which expanded this protection
to things beyond just x86 and arm64.

> > But see above: maybe just make this a separate "careful atomic_t",
> > with the option to panic-on-overflow. So then we could get rid of
> > refcount_warn_saturate() enmtirely above, and instead just have a
> > (compile-time option) BUG() case, with the non-careful version just
> > being our existing atomic_dec_and_test.

This is nearly what we had before. But refcount_t should always saturate
on overflow -- that's specifically the mitigation needed to defang the
traditional atomic_t overflow exploits (of which we had several a year
before refcount_t and now we've seen zero since).

> We used to have that option; the argument was made that everybody cares
> about security and as long as this doesn't show up on benchmarks we
> good.
> 
> Also, I don't think most people want the overflow to go BUG, WARN is
> mostly the right thing and only the super paranoid use panic-on-warn or
> something.

Saturating on overflow stops exploitability. WARNing is informational.
BUG kills the system for no good reason: the saturation is the defense
against attack, and the WARN is the "oh, I found a bug" details needed
to fix it.

I prefer the arch-agnostic, fully checked, very fast version of this
(i.e. what we have right now). :P I appreciate it's larger, but in my
opinion size isn't as important as correctness and speed. If it's just
as fast as a small version but has greater coverage, that seems worth
the size.

-- 
Kees Cook
