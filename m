Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3D741E648
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 05:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351812AbhJADqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 23:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbhJADqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 23:46:22 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC93C06176C
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 20:44:38 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id z5so17749983ybj.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 20:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nUyg5XpqEcjYRAILgiFJJzvxtqym2vAvVPMoISCLLDM=;
        b=WSQqQNNaNU6sKZN/vcVig76MwzWnqgyH3Y4g0q3bhSkAt+RLn8RiLo9wYfPmdxHEwj
         Ng8YvHClCtVSVSAlLJD7bFcHsn+Mw6Qh5uOBvYc84llJZCKuAdCRumGL9aV7ROzSVNoX
         zirkUMQUH0UsWfjfwIIuFEvQ5VJvlPVKeUYG791Ing+efx25wLB+Id73SD2iHg2OvmTz
         Du7tMGJLrwlhyzbwCZxrUiHX+uGM3N+Uq+mX6x8CcaSZaSQ/9ckaZzVNWy7/m5xwlPfO
         Ji+FZCzzvSsOgww9JvFT2qwCaP3NlgC1vAVpZ1vnahhCM7JpRWh6MSStXgxBI+Rfb4u7
         /awA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nUyg5XpqEcjYRAILgiFJJzvxtqym2vAvVPMoISCLLDM=;
        b=shKn5j7xhfiJVZ+ZkfzMLffSE5ioScIh0e9XzB6484rMj1MzVTOAS8g4zPVlFZnwdM
         FnvSjFpLBbo7f559hCSuAk8iDWWDXE68Dvq6wZh5IWfyr4mwdIT7byiSwpHbiRHl0JRO
         LGV3qRlmHYWrrNsyfS+/8eUzVAF/nmfrSW37ZQaqk3Y2nmp7XAoxrRFo2V8LdqX3ZIp5
         N76YuHtH5jhhJrgQCY2+bMgJBNIO5x2SYVZ9Z0956SEjYDE+WFw4wxFewXuXWuyD2Jcx
         2ici6/v9mRQPEc1Qkl9qRO5T7Y21mLdk+Lf7a0Ds+JsK/GQiWhWJErtHEDIVrDwrbyMJ
         9cdQ==
X-Gm-Message-State: AOAM530ko4VqYS1Pr0PjgMYyz708ExRZ8EnnAq2LzG2kZ0GUuF48XX8U
        2lKbfqBM/NmeT7/BCLUmKw2WOwrZvNo8OoMz/fDMcA==
X-Google-Smtp-Source: ABdhPJwc5YLWIpcCTp3KGzbsilLzZduRPuL3k5mA3LZsQk/Ms1ALPyxgKMWk6t/kOh+hE/j2nM/pGCogCW7YMRK3JKs=
X-Received: by 2002:a25:8411:: with SMTP id u17mr3282073ybk.376.1633059876528;
 Thu, 30 Sep 2021 20:44:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210902231813.3597709-1-surenb@google.com> <20210902231813.3597709-2-surenb@google.com>
 <202109031439.B58932AF0@keescook> <CAJuCfpEQAJqu2DLf5D5pCkv4nq+dtVOpiJSnsxwGrgb9H6inQA@mail.gmail.com>
 <202109031522.ACDF5BA8@keescook>
In-Reply-To: <202109031522.ACDF5BA8@keescook>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 30 Sep 2021 20:44:25 -0700
Message-ID: <CAJuCfpGVgSpvW_oXaGVc3TiobaGaYUtu3WR_DhrhWnEr_V=7TQ@mail.gmail.com>
Subject: Re: [PATCH v9 2/3] mm: add a field to store names for private
 anonymous memory
To:     Kees Cook <keescook@chromium.org>
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
        =?UTF-8?B?Q2hpbndlbiBDaGFuZyAo5by16Yym5paHKQ==?= 
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 3, 2021 at 3:28 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Sep 03, 2021 at 02:56:21PM -0700, Suren Baghdasaryan wrote:
> > On Fri, Sep 3, 2021 at 2:47 PM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > (Sorry, a few more things jumped out at me when I looked again...)
> > >
> > > On Thu, Sep 02, 2021 at 04:18:12PM -0700, Suren Baghdasaryan wrote:
> > > > [...]
> > > > diff --git a/kernel/sys.c b/kernel/sys.c
> > > > index 72c7639e3c98..25118902a376 100644
> > > > --- a/kernel/sys.c
> > > > +++ b/kernel/sys.c
> > > > @@ -2299,6 +2299,64 @@ int __weak arch_prctl_spec_ctrl_set(struct task_struct *t, unsigned long which,
> > > >
> > > >  #define PR_IO_FLUSHER (PF_MEMALLOC_NOIO | PF_LOCAL_THROTTLE)
> > > >
> > > > +#ifdef CONFIG_MMU
> > > > +
> > > > +#define ANON_VMA_NAME_MAX_LEN        256
> > > > +
> > > > +static inline bool is_valid_name_char(char ch)
> > > > +{
> > > > +     /* printable ascii characters, except [ \ ] */
> > > > +     return (ch > 0x1f && ch < 0x5b) || (ch > 0x5d && ch < 0x7f);
> > > > +}
> > >
> > > In the back of my mind, I feel like disallowing backtick would be nice,
> > > but then if $, (, and ) are allowed, it doesn't matter, and that seems
> > > too limiting. :)
> >
> > It's not used by the only current user (Android) and we can always
> > allow more chars later. However going the other direction and
> > disallowing some of them I think would be harder (need to make sure
> > nobody uses them). WDYT if we keep it stricter and relax if needed?
>
> I'd say, if we can also drop each of: ` $ ( )
> then let's do it. Better to keep the obvious shell meta-characters out
> of this, although I don't feel strongly about it. Anything that might
> get confused by this would be similarly confused by binary names too:
>
> $ cat /proc/3407216/maps
> 560bdafd4000-560bdafd6000 r--p 00000000 fd:02 2621909 /tmp/yay`wat
>
> And it's probably easier to change a binary name than to call prctl. :P
>
> I'm good either way. What you have now is great, but if we wanted to be
> extra extra strict, we can add the other 4 above.

While testing v10 I found one case when () are used in the name
"dalvik-main space (region space)". So I can add ` and $ to the
restricted set but not ( and ). Kees, would you be happy with:

static inline bool is_valid_name_char(char ch)
{
    return ch > 0x1f && ch < 0x7f && !strchr("\\`$[]", ch);
}

?

>
> --
> Kees Cook
