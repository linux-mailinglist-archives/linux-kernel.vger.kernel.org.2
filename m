Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0F3C334963
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 22:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbhCJVD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 16:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbhCJVDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 16:03:52 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A375DC061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 13:03:52 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id s21so2039147pfm.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 13:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kgZRDWg+E5eBmEuNfvh5FPMkh8S3VA4zLnMLimy3dco=;
        b=YN0Z/Vhtni4MgeYq5ZXFSPAnmyYH+lkZC+AUrGdL1FSjOP6FTEcki8jRb9CpsNidan
         bTf6DVBu9IZ9qccH7IA+cOlRe8qbtBRf7N3rHBrgr/zXFmg3FnjjA8PO7MJE/yIDO1/a
         qFVyvQ+I7V0ur72vLR6/jxgCfMQLRlBhrNqzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kgZRDWg+E5eBmEuNfvh5FPMkh8S3VA4zLnMLimy3dco=;
        b=q7BwEsND9jmxOICE8XnfpBlXIdYZ/Xppi+y+b8NshlH72Yn3cO/PgayefHk9j6JB37
         V+trn8pZxQ20V+BhzJ2WgLh1RMR2FFSofKJgEb45h4/04Q7DiHCsMilPX1p8oeLAKd8r
         emLUpLyrADskqAlCc/9twhcXM4z+Y0Mjcg5SyKplO2xvN6zVAmNqnrVZ6uHjPuOgfgVV
         DBmVE8zwev+sDVEAAxYV6KGLoXjYLgk7Eo8NUCXdYjOUqwnmJ8frW6edq9lrmU/KGiT8
         Ssjf365758WHPmql3rLOjQevWsMZ0mEEf+knEhf9L9Ww4tGK/OJOvrzPsbd07HcBQOU9
         I3/Q==
X-Gm-Message-State: AOAM5332bFsGHL5GoJCz4S4OKnRChPrMOvsL0TQmL+sUoZJt5j7vzGTd
        RiXybAXaIsLGVewSlqZs+EG5Og==
X-Google-Smtp-Source: ABdhPJx0EQbJUnNqWnWy4ORz94xOvLvvXICL3tLfic8hpJEypnFS58ssYytUjMkPtAFORl44nriB/w==
X-Received: by 2002:aa7:9154:0:b029:1ee:fa0d:24dd with SMTP id 20-20020aa791540000b02901eefa0d24ddmr4403109pfi.17.1615410232053;
        Wed, 10 Mar 2021 13:03:52 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m7sm236760pjc.54.2021.03.10.13.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 13:03:51 -0800 (PST)
Date:   Wed, 10 Mar 2021 13:03:50 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Elena Reshetova <elena.reshetova@intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Popov <alex.popov@linux.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jann Horn <jannh@google.com>,
        kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v5 3/7] init_on_alloc: Unpessimize default-on builds
Message-ID: <202103101303.6E6569C1@keescook>
References: <20210309214301.678739-1-keescook@chromium.org>
 <20210309214301.678739-4-keescook@chromium.org>
 <CAAeHK+xog8-DP1o=1qqKgSP7Hii2Yjah6oyowNE3zSNVW5pRSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAeHK+xog8-DP1o=1qqKgSP7Hii2Yjah6oyowNE3zSNVW5pRSw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 01:52:04PM +0100, Andrey Konovalov wrote:
> On Tue, Mar 9, 2021 at 10:43 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > Right now, the state of CONFIG_INIT_ON_ALLOC_DEFAULT_ON (and
> > ...ON_FREE...) did not change the assembly ordering of the static branch
> > tests. Use the new jump_label macro to check CONFIG settings to default
> > to the "expected" state, unpessimizes the resulting assembly code.
> >
> > Reviewed-by: Alexander Potapenko <glider@google.com>
> > Link: https://lore.kernel.org/lkml/CAG_fn=X0DVwqLaHJTO6Jw7TGcMSm77GKHinrd0m_6y0SzWOrFA@mail.gmail.com/
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  include/linux/mm.h | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index bf341a9bfe46..2ccd856ac0d1 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -2874,7 +2874,8 @@ static inline void kernel_unpoison_pages(struct page *page, int numpages) { }
> >  DECLARE_STATIC_KEY_MAYBE(CONFIG_INIT_ON_ALLOC_DEFAULT_ON, init_on_alloc);
> >  static inline bool want_init_on_alloc(gfp_t flags)
> >  {
> > -       if (static_branch_unlikely(&init_on_alloc))
> > +       if (static_branch_maybe(CONFIG_INIT_ON_ALLOC_DEFAULT_ON,
> > +                               &init_on_alloc))
> >                 return true;
> >         return flags & __GFP_ZERO;
> >  }
> > @@ -2882,7 +2883,8 @@ static inline bool want_init_on_alloc(gfp_t flags)
> >  DECLARE_STATIC_KEY_MAYBE(CONFIG_INIT_ON_FREE_DEFAULT_ON, init_on_free);
> >  static inline bool want_init_on_free(void)
> >  {
> > -       return static_branch_unlikely(&init_on_free);
> > +       return static_branch_maybe(CONFIG_INIT_ON_FREE_DEFAULT_ON,
> > +                                  &init_on_free);
> >  }
> >
> >  extern bool _debug_pagealloc_enabled_early;
> 
> Should we also update slab_want_init_on_alloc() and slab_want_init_on_free()?

Whoops! Thank you; I will update and resend. :)

-- 
Kees Cook
