Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93E6D414D05
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 17:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236445AbhIVPcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 11:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236443AbhIVPcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 11:32:13 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49CBC061756
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 08:30:43 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id q23so3003195pfs.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 08:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uG8kbMDq3wWFr/zeapZnykzvzoN7SSQeT88JzB5wbWE=;
        b=PmZIAxL0qI0ZUjgkEKbm/alrr9/0KQGVptK74f5bXbBYVa7zokeLn8N3pGkUV55CfI
         DAGkFnpsgbZc2MGiCPciF6VSHahGpJCkzssEe0ITNqYGY5viUeYZaDEcpNNsKG7uJoF0
         ZvfoUXuemAsGMxl15kJkc+y3OXSGOclJt5wXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uG8kbMDq3wWFr/zeapZnykzvzoN7SSQeT88JzB5wbWE=;
        b=IWJtNAq6LtGlII4+PU79qssmt4MAw0ba9lVyvUqYg1M9wGuvRQfrzCSyOcs/piw+UE
         bdQLzV3Az5AJBVpjqTkgSrnzBKJLAiGB1vpR+/VkPnFmmoywmR5NkbaRAhJuIEkq5Ewm
         8qSt+3glwGrJo0ijRdeg8uuAZ+8j1zRhTrOgSqjyVnSkyqMOndMkL6sJ+5W4hdeo49K3
         z8elOpJIRBMAWMm6QeO3oqwxvqa1hcy2Uw1Ob98roRG6NduweKRuNcjFRkT7NRTFR74Y
         blphgsV3voQE0NdQSSHyWguRT/j2xbbd1ASg2OVL5j3A8thvxj9vG+evbiRZpdeDpuMp
         7AQw==
X-Gm-Message-State: AOAM533MknsZofbKCRLkPP6R/ktK83BQI+t4rAYUagb6hdr12buShlDk
        tevdPShBuVR/KBtDc0H09EBAcw==
X-Google-Smtp-Source: ABdhPJz7U8r0IYlJkaTUi1d6EowadRFph6RW0II+c9Yh+WaHWwqTzkXXlAWA8N8ZPDEqXdM+hLiuNA==
X-Received: by 2002:a63:480b:: with SMTP id v11mr183763pga.413.1632324643268;
        Wed, 22 Sep 2021 08:30:43 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k29sm2941045pfp.200.2021.09.22.08.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 08:30:41 -0700 (PDT)
Date:   Wed, 22 Sep 2021 08:30:40 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Peter Collingbourne <pcc@google.com>
Cc:     Jann Horn <jannh@google.com>,
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
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Evgenii Stepanov <eugenis@google.com>
Subject: Re: [PATCH] kernel: introduce prctl(PR_LOG_UACCESS)
Message-ID: <202109220755.B0CFED9F5@keescook>
References: <20210922061809.736124-1-pcc@google.com>
 <87k0j8zo35.fsf@disp2133>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0j8zo35.fsf@disp2133>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 09:23:10AM -0500, Eric W. Biederman wrote:
> Peter Collingbourne <pcc@google.com> writes:
> 
> > This patch introduces a kernel feature known as uaccess logging.
> > With uaccess logging, the userspace program passes the address and size
> > of a so-called uaccess buffer to the kernel via a prctl(). The prctl()
> > is a request for the kernel to log any uaccesses made during the next
> > syscall to the uaccess buffer. When the next syscall returns, the address
> > one past the end of the logged uaccess buffer entries is written to the
> > location specified by the third argument to the prctl(). In this way,
> > the userspace program may enumerate the uaccesses logged to the access
> > buffer to determine which accesses occurred.
> > [...]
> > 3) Kernel fuzzing. We may use the list of reported kernel accesses to
> >    guide a kernel fuzzing tool such as syzkaller (so that it knows which
> >    parts of user memory to fuzz), as an alternative to providing the tool
> >    with a list of syscalls and their uaccesses (which again thanks to
> >    (2) may not be accurate).
> 
> How is logging the kernel's activity like this not a significant
> information leak?  How is this safe for unprivileged users?

This does result in userspace being able to "watch" the kernel progress
through a syscall. I'd say it's less dangerous than userfaultfd, but
still worrisome. (And userfaultfd is normally disabled[1] for unprivileged
users trying to interpose the kernel accessing user memory.)

Regardless, this is a pretty useful tool for this kind of fuzzing.
Perhaps the timing exposure could be mitigated by having the kernel
collect the record in a separate kernel-allocated buffer and flush the
results to userspace at syscall exit? (This would solve the
copy_to_user() recursion issue too.)

I'm pondering what else might be getting exposed by creating this level
of probing... kernel addresses would already be getting rejected, so
they wouldn't show up in the buffer. Hmm. Jann, any thoughts here?


Some other thoughts:


Instead of reimplementing copy_*_user() with a new wrapper that
bypasses some checks and adds others and has to stay in sync, etc,
how about just adding a "recursion" flag? Something like:

    copy_from_user(...)
        instrument_copy_from_user(...)
            uaccess_buffer_log_read(...)
                if (current->uaccess_buffer.writing)
                    return;
                uaccess_buffer_log(...)
                    current->uaccess_buffer.writing = true;
                    copy_to_user(...)
                    current->uaccess_buffer.writing = false;


How about using this via seccomp instead of a per-syscall prctl? This
would mean you would have very specific control over which syscalls
should get the uaccess tracing, and wouldn't need to deal with
the signal mask (I think). I would imagine something similar to
SECCOMP_FILTER_FLAG_LOG, maybe SECCOMP_FILTER_FLAG_UACCESS_TRACE, and
add a new top-level seccomp command, (like SECCOMP_GET_NOTIF_SIZES)
maybe named SECCOMP_SET_UACCESS_TRACE_BUFFER.

This would likely only make sense for SECCOMP_RET_TRACE or _TRAP if the
program wants to collect the results after every syscall. And maybe this
won't make any sense across exec (losing the mm that was used during
SECCOMP_SET_UACCESS_TRACE_BUFFER). Hmmm.


-Kees

[1] https://git.kernel.org/linus/d0d4730ac2e404a5b0da9a87ef38c73e51cb1664

-- 
Kees Cook
