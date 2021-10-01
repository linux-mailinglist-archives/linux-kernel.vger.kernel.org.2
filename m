Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC9241F561
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 21:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354887AbhJATET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 15:04:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:53832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229640AbhJATES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 15:04:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B6D2B619EC
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 19:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633114953;
        bh=EPGyMNhxkP7Yp1ZD9ry009CVJ19Uzh2NdY+aZQeVb9Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Jcsg/VwGyNCVtmLFVUvgiC3JrEVJ9aoysg3jdAhlWp+4zmygK4bAyQYvILd9VCX2h
         0IYiuokIMCXvWIGgQVX/pJfAMxyazFELQr6+xrXmDoFVXRbCmo8U/R1d2DHDN56xVv
         0Vsb4wGPo+CL6t53jCSWoRE0apiayOZRcXl27rqJfZk6r0objvYeK2dOkALAnMpML7
         eD/mE7bLJytbD7DY36i1DTk2GlTT4okBYcc9iDWFseMHosp/LJTQQeuwoj/wqtWCft
         n0S9ccmDxKM3fv64q7zlMAq5tTCZAsNs4+Insw8Qnm2k69+Dbq55tmyc5joBmdROKV
         0gTrmRqbOF3EA==
Received: by mail-ed1-f53.google.com with SMTP id g8so38405837edt.7
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 12:02:33 -0700 (PDT)
X-Gm-Message-State: AOAM531egRZfIoviv3vOOaILE9KQ2WXpYDE0nfch830GPgFH47Usuf7c
        YQ5jnKivNPOoiybPTPp7AcniOImKNaaKgTO638o/nQ==
X-Google-Smtp-Source: ABdhPJyHuGma665z1uiKZ5kxpxRss6aiB4Q88gMYX5DzVh8xuu+EdB6MX8qOk/bMjgzH0UseO9DExSEVInMJhFEji1U=
X-Received: by 2002:a50:cf87:: with SMTP id h7mr16411017edk.330.1633114952148;
 Fri, 01 Oct 2021 12:02:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210928122339.502270600@linutronix.de> <20210928122411.593486363@linutronix.de>
 <YVRT6QbX5zwiIJkI@hirez.programming.kicks-ass.net> <CALCETrVP3asoqWyNqEe+rDs+YECd9gnp9eFb1==X0140oMZ41g@mail.gmail.com>
 <87o8884q02.ffs@tglx> <CALCETrU7Fu7BA+DEk8HJPRkqsOSsC-NXR2tPsxW6VFF0pxSS6A@mail.gmail.com>
In-Reply-To: <CALCETrU7Fu7BA+DEk8HJPRkqsOSsC-NXR2tPsxW6VFF0pxSS6A@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 1 Oct 2021 12:02:19 -0700
X-Gmail-Original-Message-ID: <CALCETrXk0i50vyWwou0AT0jtb7V2pqZiJW_7_dqrthi1N19qeg@mail.gmail.com>
Message-ID: <CALCETrXk0i50vyWwou0AT0jtb7V2pqZiJW_7_dqrthi1N19qeg@mail.gmail.com>
Subject: Re: [patch 4/5] sched: Delay task stack freeing on RT
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 1, 2021 at 11:48 AM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Fri, Oct 1, 2021 at 10:24 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >

> ISTM it would be conceptually for do_exit() to handle its own freeing
> in its own preemptible context.  Obviously that can't really work,
> since we can't free a task_struct or a task stack while we're running
> on it.  But I wonder if we could approximate it by putting this work
> in a workqueue so that it all runs in a normal schedulable context.
> To make the shell script case work nicely, we want to release the task
> stack before notifying anyone waiting for the dying task to exit, but
> maybe that's doable.  It could involve some nasty exit_signal hackery,
> though.

I'm making this way more complicated than it needs to be.  How about
we unaccount the task stack in do_exit and release it for real in
finish_task_switch()?  Other than accounting, free_thread_stack
doesn't take any locks.

--Andy
