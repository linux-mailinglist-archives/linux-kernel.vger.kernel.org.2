Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C045C3F3233
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 19:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbhHTR0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 13:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbhHTR0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 13:26:51 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29695C061575
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 10:26:13 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id y190so9202520pfg.7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 10:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=D8sisJowkMm73SRcyloSHTS3YrdB++THv76Ik71IMKs=;
        b=PsGLm1nHLmD0olMes1ii+F35WB1QR3GTdzThohn2vNRHikczDvTAL7ub6u59oWmXOh
         yhGJ7GXmoYVqqa6Ujv/zD3nt0WUaghYfRdXL9FI9PNhxF3QA2yV5NJV0jGNRq4L6F3iz
         M5DBU12zh7G4AIT9vbvOjCjTmI+CmHnd7ti6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D8sisJowkMm73SRcyloSHTS3YrdB++THv76Ik71IMKs=;
        b=Ph+BwkxpqfTJD6+5Z8+oGnrEuZGlg+sZ5+AUIazh8QsYSbAPbvqOL+/xebWtYGIJ8o
         gOcks29nhCROTKYTJSgKFKawK7t9kF65TIKjNycBWcqDJAGLffJfGQf3DHWtaNevhTi5
         HPq/fuL1BujODP6K2lF6qwIttmfhiZc0GGF8x0rgPJAa6WDpFNO3gJeonjGxUj+DRCBt
         yRZBuKAGkUXIZ8RAzK/YoP5iz+hy8dsMoFbvH3O1X07M9ZIfxXly5hRpvNGf6FDm7FMT
         krVV6mA7JvIYLhxhFvaQhcBdNUTyfi4E/xKAPY2S4lJG2ZLKHHZK/G4FPuoEoVP9p81P
         Sqvg==
X-Gm-Message-State: AOAM533m0p5zEQF3nXhFPu8eA8lFlTjU7eOx2DJe29lLvw9gq4pYQ6kf
        2rPrpM5wby9lcAz8uoDOELaYjg==
X-Google-Smtp-Source: ABdhPJxP3ToehmaVHNs/nW/7VuNtAx+pgvsn+WFlB9EEoe2zs22r1Qot84tN6E5aN5x6mPGGRXYiBw==
X-Received: by 2002:a05:6a00:168a:b0:3e2:789e:5fd0 with SMTP id k10-20020a056a00168a00b003e2789e5fd0mr20666872pfc.68.1629480372638;
        Fri, 20 Aug 2021 10:26:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g26sm8760565pgb.45.2021.08.20.10.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 10:26:11 -0700 (PDT)
Date:   Fri, 20 Aug 2021 10:26:10 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
Message-ID: <202108201013.36752C28@keescook>
References: <1626665029-49104-1-git-send-email-xiyuyang19@fudan.edu.cn>
 <20210720160127.ac5e76d1e03a374b46f25077@linux-foundation.org>
 <20210819132131.GA15779@willie-the-truck>
 <YR5ldaQvAnCKMnkk@hirez.programming.kicks-ass.net>
 <YR52igt/lJ7gQqOG@hirez.programming.kicks-ass.net>
 <CAHk-=wh_vEzmYnMufOa=03WAU=DRM5+n6uZy=dVtJERFJm3Q-Q@mail.gmail.com>
 <YR9PHD+pWTelGKVd@hirez.programming.kicks-ass.net>
 <YR9k0hzMJpNF/0qL@hirez.programming.kicks-ass.net>
 <20210820082457.GA16784@willie-the-truck>
 <YR9vxHlSFalryHi0@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YR9vxHlSFalryHi0@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2021 at 11:03:00AM +0200, Peter Zijlstra wrote:
> On Fri, Aug 20, 2021 at 09:24:58AM +0100, Will Deacon wrote:
> 
> > > gcc-10.2.1, x86_64-defconfig
> > > 
> > > kernel/event/core.o-inline-ud1:     96454
> > > kernel/event/core.o-outofline-ud1:  96604
> > > kernel/event/core.o-outofline-call: 97072
> 
>     kernel/event/core.o-outofline-saturate-ud2: 96954
>     kernel/event/core.o:                97248
> 
> > Is that with the saturation moved to the UD handler as well? 
> 
> Yep, that's the full function call replaced with an exception.
> 
> > I think it would be good to keep that as close to the point at which
> > we detect the problem as we can, so perhaps we can inline that part
> > and leave the diagnostics to the exception handler?
> 
> That's simpler execption code too, we can abuse the existing WARN/UD2
> stuff.
> 
> ---
>  arch/x86/include/asm/refcount.h | 31 +++++++++++++++++++++++++++++++
>  include/asm-generic/bug.h       |  4 ++++
>  include/linux/refcount.h        | 15 +++++++++++----
>  lib/bug.c                       | 13 ++++++++++++-
>  lib/refcount.c                  |  7 ++-----
>  5 files changed, 60 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/include/asm/refcount.h b/arch/x86/include/asm/refcount.h
> new file mode 100644
> index 000000000000..bed52b95d24c
> --- /dev/null
> +++ b/arch/x86/include/asm/refcount.h
> @@ -0,0 +1,31 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_X86_REFCOUNT_H
> +#define _ASM_X86_REFCOUNT_H
> +
> +#define refcount_warn_saturate refcount_warn_saturate
> +static __always_inline void refcount_warn_saturate(refcount_t *r, const enum refcount_saturation_type t)
> +{
> +	refcount_set(r, REFCOUNT_SATURATED);
> +	__WARN_FLAGS(BUGFLAG_ONCE|BUGFLAG_REFCOUNT|BUGFLAG_REFCOUNT_TYPE(t));
> +}

Instead of using up warn flags, what was done in
the past was to use an explicit EXTABLE in a cold text section:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/include/asm/asm.h?h=v4.15#n80
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/mm/extable.c?h=v4.15#n45
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/include/asm/refcount.h?h=v4.15

> +
> +#define refcount_dec_and_test refcount_dec_and_test
> +static inline bool refcount_dec_and_test(refcount_t *r)
> +{
> +	asm_volatile_goto (LOCK_PREFIX "decl %[var]\n\t"
> +			   "jz %l[cc_zero]\n\t"
> +			   "jl %l[cc_error]"
> +			   : : [var] "m" (r->refs.counter)
> +			   : "memory" : cc_zero, cc_error);
> +
> +	return false;
> +
> +cc_zero:
> +	return true;
> +
> +cc_error:
> +	refcount_warn_saturate(r, REFCOUNT_SUB_UAF);
> +	return false;
> +}

This looks basically the same as what we had before (i.e. the earlier
REFCOUNT_CHECK_LE_ZERO within GEN_UNARY_SUFFIXED_RMWcc).

-- 
Kees Cook
