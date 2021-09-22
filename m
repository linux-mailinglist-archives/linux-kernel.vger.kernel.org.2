Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3611F41532D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 00:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237834AbhIVWHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 18:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbhIVWH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 18:07:29 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA81C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 15:05:59 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id b10so5450168ioq.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 15:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5SYXvLn3SjXAQ4MAzIaVmGx80q5ADpEHvJGRZh2fwGQ=;
        b=fIvXEv+vCCuCjlnflfXdH0G29UFJLzYXN4CfKvUbcEasTWFWDknqa1X58g4hv1kfH+
         aVup6rXSb0sh1Q8Fi4tzcDj4TljFixmarljYO8NtO4rGTUJGVNwxw3MijT1wthB+GbOU
         BVeDWCdfKd5PDrWg6KelnkiQ84/ANKLh93tu3AXzsxs8gyU4VfJMTInxsZ2Dwlf1jq43
         0YsjmiviUbGgMWYd1sKGgQqUZQtqof4Vg7vVSWLWbltNwkxh5dHpuMqJSlXy/5mZXyBo
         5ZqWW6gUqw+VBmuSKnMWS0wrcUTwKwC0WLc/iuVb+dbzXjTE/x5H1onsJxwDvkketsk7
         RHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5SYXvLn3SjXAQ4MAzIaVmGx80q5ADpEHvJGRZh2fwGQ=;
        b=62NgVBVgmukf7ZqaMIZ2/HxEJ4mF8gsP1i9Y4dqJBe8owGjWmNpZjBxfuIeQ91Ryje
         Ejm3HALN3rv3JIKY0T/MNBS6lWnH4lPYKEDj8xJkOOe0smsrwKXzs2K6mX1eUvBJlzKU
         ZQlBwoa2Aeh0HGb5QzLTV3YcozxNotMIFGTOXOymsPlsEuQsAYfpFNCriewCo6C/1/Kl
         w0Ra79z7F6rZaLjsh2pR3L2aOiyXTVrNfWOW6OZbI2H1e4dMyOrE2e2uWYYFOMoF40Rp
         dWNjxs0FgMmfs6NWs8eo6l7/rHICODiGoGenXjqHjoYAbnaxP9eQcYTKCQ/ThVT+7733
         s4kQ==
X-Gm-Message-State: AOAM530amcAXsHXUqkuM1v4PbE5sPhu8D7Xl3F6gWbZGMd4YIFHltoyv
        Uo8lBjnA8RndB9pav0o0f6nJDeb0LzSyVu2Slh+xcA==
X-Google-Smtp-Source: ABdhPJw1jzm4Ztt01wsrksRUqCwtTfxTOGoEOxhsCniLLcC1+2wPSZyuNP/18jrxFZ4lv80ghbbCdA+Jk+wHR+q8wiM=
X-Received: by 2002:a6b:5f08:: with SMTP id t8mr1043653iob.71.1632348358124;
 Wed, 22 Sep 2021 15:05:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210922061809.736124-1-pcc@google.com> <29f1822d-e4cd-eedb-bea8-619db1d56335@redhat.com>
 <20210922152250.4e7c869a@gandalf.local.home> <YUuJo7IfS4x0iLfX@hirez.programming.kicks-ass.net>
In-Reply-To: <YUuJo7IfS4x0iLfX@hirez.programming.kicks-ass.net>
From:   Peter Collingbourne <pcc@google.com>
Date:   Wed, 22 Sep 2021 15:05:46 -0700
Message-ID: <CAMn1gO7L=K7xRxi6yrkr+7BWZN_9UEprt=ywbvQ7M-0HVgf2ow@mail.gmail.com>
Subject: Re: [PATCH] kernel: introduce prctl(PR_LOG_UACCESS)
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
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
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        Xiaofeng Cao <caoxiaofeng@yulong.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Thomas Cedeno <thomascedeno@google.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Evgenii Stepanov <eugenis@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 12:56 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Sep 22, 2021 at 03:22:50PM -0400, Steven Rostedt wrote:
> > On Wed, 22 Sep 2021 19:46:47 +0200
> > David Hildenbrand <david@redhat.com> wrote:
> >
> > > > All signals except SIGKILL and SIGSTOP are masked for the interval
> > > > between the prctl() and the next syscall in order to prevent handlers
> > > > for intervening asynchronous signals from issuing syscalls that may
> > > > cause uaccesses from the wrong syscall to be logged.
> > >
> > > Stupid question: can this be exploited from user space to effectively
> > > disable SIGKILL for a long time ... and do we care?
> >
> > I first misread it too, but then caught my mistake reading it a second
> > time. It says "except SIGKILL". So no, it does not disable SIGKILL.
>
> Disabling SIGINT might already be a giant nuisance. Letting through
> SIGSTOP but not SIGCONT seems awkward. Blocking SIGTRAP seems like a bad
> idea too. Blocking SIGBUS as delivered by #MC will be hillarious.

I'm only blocking the signals that are already blockable from
userspace via rt_sigprocmask (which prevents blocking SIGKILL and
SIGSTOP, but allows blocking the others including SIGBUS, for which
the man page states that the result is undefined if synchronously
generated while blocked). So in terms of blocking signals I don't
think this is exposing any new capabilities.

Per the sigaction man page, SIGKILL and SIGSTOP can't have userspace
signal handlers, so we don't need to block them in order to prevent
intervening asynchronous signal handlers (nor do we want to due to the
DoS potential). I would need to double check the behavior but I
believe that for SIGCONT continuing the process is separate from
signal delivery and unaffected by blocking (see prepare_signal in
kernel/signal.c) -- so the SIGCONT will make it continue and the
handler if any would be called once the syscall returns after the
automatic restoration of the signal mask.

Peter
