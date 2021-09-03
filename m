Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 811A64007EC
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 00:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349675AbhICW3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 18:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242831AbhICW3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 18:29:25 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6553C061757
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 15:28:24 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id c6so502469pjv.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 15:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BS6jWoL9pWSi0KXjHeej6vjUIclKhlV3mGFNGSvhg5w=;
        b=lvAfLsLnn/50KH5BhXOVM8yk6EQsU+CWCcB3ajHc68JoJFkEsFipc+RHheUz83Bfbt
         t+8Fh+FZC2ScHzSuqtnikr4XATusXLxd9ZaDi4YqJjYk9Vp/H1MwSsOXtB154B9cS2u5
         gd4PrW561dBLiOjrX3i69lbR51p3vC5CyFNis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BS6jWoL9pWSi0KXjHeej6vjUIclKhlV3mGFNGSvhg5w=;
        b=Y38f93I+/5KI6JaOu8weDW95zt2nBNL1IdQvfISdlqyUma+3Jry36WZQdj14H0Sr/X
         VS1pZHK8ZbsQLcP6pXuRO072Q7/MbIQaDfw8knOX/UE2PRrK+HrQh8TXVfVpbI5GRwvb
         47nNk/DG4F4MtqeX6COkOlr6nmBY/Acs/2qw3NYAeLvOwAPnB+L7lKeWzdaXDdwbelk9
         msCtP6+sKSBNzGQw4+TmnWm5ZbPU3vP4kLEo9NEBZnb/bZIoo4hoWi7R04shaAxR9uS8
         dW3bgDXKZJycAazR/l+/hj5YnY9JXqUd2ChzGTPTP0HtoMsrshdjpB9FUMrl9xqW1BOi
         rC1Q==
X-Gm-Message-State: AOAM533ZgWR8/R54jlak92ih7XqkqWGv3Ciy5PyXFGu9A99x0J1XvfX1
        i2Lm8xpl7rlCyYCdlkhkftoxwg==
X-Google-Smtp-Source: ABdhPJzuaBI1DIl35wZKJ43uYtU+X5MQjRpDOgfLtB5e93HgeqaaD+mSm3mJj0NaFzUqMvKInh7J3Q==
X-Received: by 2002:a17:90a:194a:: with SMTP id 10mr1071828pjh.221.1630708104224;
        Fri, 03 Sep 2021 15:28:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j11sm359051pfa.10.2021.09.03.15.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 15:28:23 -0700 (PDT)
Date:   Fri, 3 Sep 2021 15:28:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Colin Cross <ccross@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Peter Xu <peterx@redhat.com>, rppt@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        vincenzo.frascino@arm.com,
        Chinwen Chang =?utf-8?B?KOW8temMpuaWhyk=?= 
        <chinwen.chang@mediatek.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jann Horn <jannh@google.com>, apopple@nvidia.com,
        John Hubbard <jhubbard@nvidia.com>,
        Yu Zhao <yuzhao@google.com>, Will Deacon <will@kernel.org>,
        fenghua.yu@intel.com, thunder.leizhen@huawei.com,
        Hugh Dickins <hughd@google.com>, feng.tang@intel.com,
        Jason Gunthorpe <jgg@ziepe.ca>, Roman Gushchin <guro@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>, krisman@collabora.com,
        chris.hyser@oracle.com, Peter Collingbourne <pcc@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jens Axboe <axboe@kernel.dk>, legion@kernel.org,
        Rolf Eike Beer <eb@emlix.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thomas Cedeno <thomascedeno@google.com>, sashal@kernel.org,
        cxfcosmos@gmail.com, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>
Subject: Re: [PATCH v9 2/3] mm: add a field to store names for private
 anonymous memory
Message-ID: <202109031522.ACDF5BA8@keescook>
References: <20210902231813.3597709-1-surenb@google.com>
 <20210902231813.3597709-2-surenb@google.com>
 <202109031439.B58932AF0@keescook>
 <CAJuCfpEQAJqu2DLf5D5pCkv4nq+dtVOpiJSnsxwGrgb9H6inQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpEQAJqu2DLf5D5pCkv4nq+dtVOpiJSnsxwGrgb9H6inQA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2021 at 02:56:21PM -0700, Suren Baghdasaryan wrote:
> On Fri, Sep 3, 2021 at 2:47 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > (Sorry, a few more things jumped out at me when I looked again...)
> >
> > On Thu, Sep 02, 2021 at 04:18:12PM -0700, Suren Baghdasaryan wrote:
> > > [...]
> > > diff --git a/kernel/sys.c b/kernel/sys.c
> > > index 72c7639e3c98..25118902a376 100644
> > > --- a/kernel/sys.c
> > > +++ b/kernel/sys.c
> > > @@ -2299,6 +2299,64 @@ int __weak arch_prctl_spec_ctrl_set(struct task_struct *t, unsigned long which,
> > >
> > >  #define PR_IO_FLUSHER (PF_MEMALLOC_NOIO | PF_LOCAL_THROTTLE)
> > >
> > > +#ifdef CONFIG_MMU
> > > +
> > > +#define ANON_VMA_NAME_MAX_LEN        256
> > > +
> > > +static inline bool is_valid_name_char(char ch)
> > > +{
> > > +     /* printable ascii characters, except [ \ ] */
> > > +     return (ch > 0x1f && ch < 0x5b) || (ch > 0x5d && ch < 0x7f);
> > > +}
> >
> > In the back of my mind, I feel like disallowing backtick would be nice,
> > but then if $, (, and ) are allowed, it doesn't matter, and that seems
> > too limiting. :)
> 
> It's not used by the only current user (Android) and we can always
> allow more chars later. However going the other direction and
> disallowing some of them I think would be harder (need to make sure
> nobody uses them). WDYT if we keep it stricter and relax if needed?

I'd say, if we can also drop each of: ` $ ( )
then let's do it. Better to keep the obvious shell meta-characters out
of this, although I don't feel strongly about it. Anything that might
get confused by this would be similarly confused by binary names too:

$ cat /proc/3407216/maps
560bdafd4000-560bdafd6000 r--p 00000000 fd:02 2621909 /tmp/yay`wat

And it's probably easier to change a binary name than to call prctl. :P

I'm good either way. What you have now is great, but if we wanted to be
extra extra strict, we can add the other 4 above.

-- 
Kees Cook
