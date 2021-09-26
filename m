Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B02B441858E
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 04:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbhIZCWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 22:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbhIZCWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 22:22:01 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A63C061570
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 19:20:25 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id n2so9219172plk.12
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 19:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VomPzUlQwzo0EgTLQkSEq5bVZTa+IXXefvRwX88V1gQ=;
        b=DD/Qap+I8sMuX+7b4FQFPC9MQvbDFA136Lnhljj3aeWmC4Nv3S27lwU9HHW62H9CTK
         LdIG4kGLZm46WGBXS9fhfycQjzWBlGzQjzWAJQ84HiqwlixsUTJ/yqJjk34dcmSyMddM
         pGIXTn1h7ccsBHLMaOeITTlFbq++tBQs+3NH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VomPzUlQwzo0EgTLQkSEq5bVZTa+IXXefvRwX88V1gQ=;
        b=5CSj1sN60Cv5D6opC3scnoJvfS7IdvaeMQKGY74NU2y6tUBkjv+tKzbjsdqbN1vfPQ
         OHyTOwv39MF8oCb3R7AH9nU1KadjjuKDeh2sV1GVB2XVxvK5ibl2orULwmfsyqLagl3f
         MlNpGKBQRJPa8luehCn/MpMJXjKcrvfE8bc0EustPHxAkCr7HmZ44thhimirqAY1HOJd
         BlS2w8Xe8tumvBCtcNJGwsHnqMj+GbcSphHBJbfHELf4k97zUrhNTf12lnfLe965BmJf
         9oBQ20w4ypRxOfzE5vyQ4+eStll0L8kocNyDapqyZoGeZwECBuNVzLZ35xg4YLjEakNI
         NroQ==
X-Gm-Message-State: AOAM533EsNuRibiJG/sN5qRzla8iN/fjcsIOxm7sNLSCfhPgzkG0hb/8
        nrb6Vqcwk7krewp8b/cvkQsOfg==
X-Google-Smtp-Source: ABdhPJx4DbNoXjDKV8tGIkCNeOkOw+/+RkeSoNjIuxDTnG9nABYHQZz/yRrYfH/G6F536AdFP7Djbw==
X-Received: by 2002:a17:90a:1b67:: with SMTP id q94mr11591314pjq.246.1632622824479;
        Sat, 25 Sep 2021 19:20:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p48sm12941527pfw.160.2021.09.25.19.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Sep 2021 19:20:23 -0700 (PDT)
Date:   Sat, 25 Sep 2021 19:20:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Collingbourne <pcc@google.com>
Cc:     Jann Horn <jannh@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Colin Ian King <colin.king@canonical.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Balbir Singh <sblbir@amazon.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Alexey Gladkov <legion@kernel.org>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        David Hildenbrand <david@redhat.com>,
        Xiaofeng Cao <caoxiaofeng@yulong.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Thomas Cedeno <thomascedeno@google.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Evgenii Stepanov <eugenis@google.com>
Subject: Re: [PATCH] kernel: introduce prctl(PR_LOG_UACCESS)
Message-ID: <202109251909.B7BB577BA@keescook>
References: <20210922061809.736124-1-pcc@google.com>
 <87k0j8zo35.fsf@disp2133>
 <202109220755.B0CFED9F5@keescook>
 <CAG48ez1wQZ2Jte_JRS92Njw89abpU5kGCk8KPyEdC93XX33NRA@mail.gmail.com>
 <CAMn1gO5_L-+Gjm2GGGPAa8JhZj+Xf-zZ4MDzHjb7xtANFG8c5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMn1gO5_L-+Gjm2GGGPAa8JhZj+Xf-zZ4MDzHjb7xtANFG8c5A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2021 at 02:50:04PM -0700, Peter Collingbourne wrote:
> On Wed, Sep 22, 2021 at 8:59 AM Jann Horn <jannh@google.com> wrote:
> >
> > On Wed, Sep 22, 2021 at 5:30 PM Kees Cook <keescook@chromium.org> wrote:
> > > On Wed, Sep 22, 2021 at 09:23:10AM -0500, Eric W. Biederman wrote:
> > > > Peter Collingbourne <pcc@google.com> writes:
> > > > > This patch introduces a kernel feature known as uaccess logging.
> > > > > [...]
> > > > [...]
> > > > How is logging the kernel's activity like this not a significant
> > > > information leak?  How is this safe for unprivileged users?
> > > [...]
> > > Regardless, this is a pretty useful tool for this kind of fuzzing.
> > > Perhaps the timing exposure could be mitigated by having the kernel
> > > collect the record in a separate kernel-allocated buffer and flush the
> > > results to userspace at syscall exit? (This would solve the
> > > copy_to_user() recursion issue too.)
> 
> Seems reasonable. I suppose that in terms of timing information we're
> already (unavoidably) exposing how long the syscall took overall, and
> we probably shouldn't deliberately expose more than that.

Right -- I can't think of anything that can really use this today,
but it very much feels like the kind of information that could aid in
a timing race.

> That being said, I'm wondering if that has security implications on
> its own if it's then possible for userspace to manipulate the kernel
> into allocating a large buffer (either at prctl() time or as a result
> of getting the kernel to do a large number of uaccesses). Perhaps it
> can be mitigated by limiting the size of the uaccess buffer provided
> at prctl() time.

There are a lot of exact-size allocation controls already (which I think
is an unavoidable but separate issue[1]), but perhaps this could be
mitigated by making the reserved buffer be PAGE_SIZE granular?

> > One aspect that might benefit from some clarification on intended
> > behavior is: what should happen if there are BPF tracing programs
> > running (possibly as part of some kind of system-wide profiling or
> > such) that poke around in userspace memory with BPF's uaccess helpers
> > (especially "bpf_copy_from_user")?
> 
> I think we should probably be ignoring those accesses, since we cannot
> know a priori whether the accesses are directly associated with the
> syscall or not, and this is after all a best-effort mechanism.

Perhaps the "don't log this uaccess" flag I suggested could be
repurposed by BPF too, as a general "make this access invisible to
PR_LOG_UACCESS" flag? i.e. this bit:

> > > Instead of reimplementing copy_*_user() with a new wrapper that
> > > bypasses some checks and adds others and has to stay in sync, etc,
> > > how about just adding a "recursion" flag? Something like:
> > >
> > >     copy_from_user(...)
> > >         instrument_copy_from_user(...)
> > >             uaccess_buffer_log_read(...)
> > >                 if (current->uaccess_buffer.writing)
> > >                     return;
> > >                 uaccess_buffer_log(...)
> > >                     current->uaccess_buffer.writing = true;
> > >                     copy_to_user(...)
> > >                     current->uaccess_buffer.writing = false;



> > > This would likely only make sense for SECCOMP_RET_TRACE or _TRAP if the
> > > program wants to collect the results after every syscall. And maybe this
> > > won't make any sense across exec (losing the mm that was used during
> > > SECCOMP_SET_UACCESS_TRACE_BUFFER). Hmmm.
> >
> > And then I guess your plan would be that userspace would be expected
> > to use the userspace instruction pointer
> > (seccomp_data::instruction_pointer) to indicate instructions that
> > should be traced?

That could be one way -- but seccomp filters would allow a bunch of
ways.

> >
> > Or instead of seccomp, you could do it kinda like
> > https://www.kernel.org/doc/html/latest/admin-guide/syscall-user-dispatch.html
> > , with a prctl that specifies a specific instruction pointer?
> 
> Given a choice between these two options, I would prefer the prctl()
> because userspace programs may already be using seccomp filters and
> sanitizers shouldn't interfere with it.

That's fair -- the "I wish we could make complex decisions about which
syscalls to act on" sounds like seccomp.

> However, in either the seccomp filter or prctl() case, you still have
> the problem of deciding where to log to. Keep in mind that you would
> need to prevent intervening async signals (that occur between when the
> syscall happens and when we read the log) from triggering additional

Could the sig handler also set the "make the uaccess invisible" flag?
(It would need to be a "depth" flag, most likely.)

-Kees

[1] https://github.com/KSPP/linux/issues/9

-- 
Kees Cook
