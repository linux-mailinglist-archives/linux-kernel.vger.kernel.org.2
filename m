Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4BD341F682
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 22:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355565AbhJAUzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 16:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355542AbhJAUzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 16:55:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1143FC061775
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 13:54:10 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633121648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tqUDfDbD+LheVFGVx1ttBWfxP0P88MXIJpplml+x1eE=;
        b=do2XRzWdyL27M+wQoWjr3T0jjmFvE+88eVrjBxQRJUFagMj4GRfcsSWMJ7p9FaFqMS2Pi6
        PMMkx7tHnBpuVV/kikxrdumnOtJzJJF1eNiLqWcSyAkUKXgr+rvX1IatskIgIApzGAmVQI
        kt/KQj21neRgg/fh04TvmNrgPqYz0HE/GuBqNB71D3AEWx316GKru17f8rRqGpF6ojK30M
        aKZU3D0E+z0Uyvd9uzczENmSzVf9/5gqJoTohiiSk1v9/4RlYTGh6CIhFxsyC0My7nBHQG
        vgAB+ylQiyIvW5RyOn9YNa6x6mCguGA3UkGr6GvUDosLI07kwDwmJc7TBuK5Hw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633121648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tqUDfDbD+LheVFGVx1ttBWfxP0P88MXIJpplml+x1eE=;
        b=Hl2AoXqTLZ3++Y3lwAO3co4RzsMV4fZWBlW51qebIb3AJcZ3XK5SKxaWZIDYsOFn7B5pr8
        Ks5+2yZI+S3CA8CA==
To:     Andy Lutomirski <luto@kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [patch 4/5] sched: Delay task stack freeing on RT
In-Reply-To: <CALCETrXk0i50vyWwou0AT0jtb7V2pqZiJW_7_dqrthi1N19qeg@mail.gmail.com>
References: <20210928122339.502270600@linutronix.de>
 <20210928122411.593486363@linutronix.de>
 <YVRT6QbX5zwiIJkI@hirez.programming.kicks-ass.net>
 <CALCETrVP3asoqWyNqEe+rDs+YECd9gnp9eFb1==X0140oMZ41g@mail.gmail.com>
 <87o8884q02.ffs@tglx>
 <CALCETrU7Fu7BA+DEk8HJPRkqsOSsC-NXR2tPsxW6VFF0pxSS6A@mail.gmail.com>
 <CALCETrXk0i50vyWwou0AT0jtb7V2pqZiJW_7_dqrthi1N19qeg@mail.gmail.com>
Date:   Fri, 01 Oct 2021 22:54:08 +0200
Message-ID: <87a6js4gb3.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 01 2021 at 12:02, Andy Lutomirski wrote:
> On Fri, Oct 1, 2021 at 11:48 AM Andy Lutomirski <luto@kernel.org> wrote:
>>
>> On Fri, Oct 1, 2021 at 10:24 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>> >
>
>> ISTM it would be conceptually for do_exit() to handle its own freeing
>> in its own preemptible context.  Obviously that can't really work,
>> since we can't free a task_struct or a task stack while we're running
>> on it.  But I wonder if we could approximate it by putting this work
>> in a workqueue so that it all runs in a normal schedulable context.
>> To make the shell script case work nicely, we want to release the task
>> stack before notifying anyone waiting for the dying task to exit, but
>> maybe that's doable.  It could involve some nasty exit_signal hackery,
>> though.
>
> I'm making this way more complicated than it needs to be.  How about
> we unaccount the task stack in do_exit and release it for real in
> finish_task_switch()?  Other than accounting, free_thread_stack
> doesn't take any locks.

Right.

