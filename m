Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4706E447921
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 05:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237349AbhKHEMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 23:12:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237341AbhKHEL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 23:11:59 -0500
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84EEC061570
        for <linux-kernel@vger.kernel.org>; Sun,  7 Nov 2021 20:09:15 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id v3so28905856uam.10
        for <linux-kernel@vger.kernel.org>; Sun, 07 Nov 2021 20:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ht1a7BHorlhsE8dC2GuUzDtj79AIkNJ784TbJlxLVrc=;
        b=hEpZGtyPHSeODH2+z3tM2pL2kZdsRw6MkBcSLD1h50yio+oDm2Cwoy97zfiHNmYEvk
         haP5bd0VlBqkKPQmgtpp2mgMPdM+Jh3dmFSmMXCh9tLXao5vu1BLa++B77FnkohwBEQk
         E3y5nsN70+m2w0lTYZzaUPYlxC1UkkkqMMnow0D+fvRi6tuR47ETSDJXJWME4zBbAwGn
         /fX14irruZ9MzIUm5GRhmTV7tCdw+3/x6FkdtXUa8+CT8ZXyRg+InwsNdQTAKAxpM4ao
         CLdAbav/wyHeHVbQswqb0lLCH7XMaMFbhkM2DC1u9dde7S1o3VKm8CHYCzdj9ijM0JN1
         TUjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ht1a7BHorlhsE8dC2GuUzDtj79AIkNJ784TbJlxLVrc=;
        b=e4i49DWLJtosixyA6AQkuv3/M9qjh2fUTx+XHZGPkHvKhMgUlcKjY60WuVnpMmVdmg
         NyyRagULWlgf178t7IFgaj41R4rc+EGW57Z08l8PJlB7nHPN6A8JqpoDGX17Lx2jiNn1
         Sqi1ng3bJcSEwv9mCIrepvmt5YfcGMz6JGsulwtBgY4eS4M+62GrjQ4k2H0/lA/faz2t
         ezQpPihleTSnPDoPUykq+8tFCTdE3+Lml9E0lEgJON0M6c62uCWQzicvYnAWhJgm98dJ
         7nfeUEc3tGfiDOw7ShDDGKAJ5aBVmvgxqawdX8B1fPHAAfbddJJH39WodwF2wHdavWTk
         1dOw==
X-Gm-Message-State: AOAM530dqgs6VpyPNjUIdqkIzLheZJXsRUCWzMnpuhC9+zl19IT+Y0+t
        FoMolvKy+NjaHAaNH1+oXH5f0Icn8Dv62R1h3nV5dQ==
X-Google-Smtp-Source: ABdhPJy4sFP5Rd4WqLzOYU+KqsxywfbN2kHNY7KPnD9rSyvbVDu+X+nYjpnPfnRxztF3BGa/RKHiuhaerSgi0/5fPBI=
X-Received: by 2002:a05:6102:dce:: with SMTP id e14mr48258555vst.21.1636344554818;
 Sun, 07 Nov 2021 20:09:14 -0800 (PST)
MIME-Version: 1.0
References: <20211104195804.83240-1-posk@google.com> <20211104195804.83240-4-posk@google.com>
 <ec84f37d-da30-8f03-3864-0c94078f6e21@uwaterloo.ca>
In-Reply-To: <ec84f37d-da30-8f03-3864-0c94078f6e21@uwaterloo.ca>
From:   Peter Oskolkov <posk@posk.io>
Date:   Sun, 7 Nov 2021 20:09:04 -0800
Message-ID: <CAFTs51XU1rKqSscdFK69RUCtaKrLJ1r5pdXSBJ1qc3=ZMNorBw@mail.gmail.com>
Subject: Re: [PATCH v0.8 3/6] sched/umcg: implement UMCG syscalls
To:     Thierry Delisle <tdelisle@uwaterloo.ca>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Paul Turner <pjt@google.com>,
        Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@google.com>,
        Andrei Vagin <avagin@google.com>, Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 5, 2021 at 4:48 PM Thierry Delisle <tdelisle@uwaterloo.ca> wrote:
>
> On 2021-11-04 3:58 p.m., Peter Oskolkov wrote:
>  > +/*
>  > + * Try to wake up. May be called with preempt_disable set. May be called
>  > + * cross-process.
>  > + *
>  > + * Note: umcg_ttwu succeeds even if ttwu fails: see wait/wake state
>  > + *       ordering logic.
>  > + */
>  > +static int umcg_ttwu(u32 next_tid, int wake_flags)
>  > +{
>  > +    struct task_struct *next;
>  > +
>  > +    rcu_read_lock();
>  > +    next = find_task_by_vpid(next_tid);
>  > +    if (!next || !umcg_wakeup_allowed(next)) {
>  > +        rcu_read_unlock();
>  > +        return -ESRCH;
>  > +    }
>  > +
>  > +    /* The result of ttwu below is ignored. */
>  > +    try_to_wake_up(next, TASK_NORMAL, wake_flags);
>  > +    rcu_read_unlock();
>  > +
>  > +    return 0;
>  > +}
>
> Doesn't try_to_wake_up return different values based on whether or not a
> task
> was woken up? I think it could be useful to propagate that result instead of
> always returning zero. Even if it only helps for debugging.
>

The protocol is to mark the wakee as UMCG_TASK_RUNNING and call ttwu;
if you look at umcg_idle_loop(), you will see that the ordering is set
so that the wakee will indeed either wake or not go to sleep at all,
regardless of whether ttwu succeeds. So in terms of correctness we do
not need to check ttwu result; returning anything different here "for
debugging"? Maybe. If/when this is merged, feel free to send a patch.
Or maybe I'll add this in a next patchset version...

>
>
>  > +static bool enqueue_idle_worker(struct umcg_task __user *ut_worker)
>  > +{
>  > +    u64 __user *node = &ut_worker->idle_workers_ptr;
>  > +    u64 __user *head_ptr;
>  > +    u64 first = (u64)node;
>  > +    u64 head;
>  > +
>  > +    if (get_user(head, node) || !head)
>  > +        return false;
>  > +
>  > +    head_ptr = (u64 __user *)head;
>  > +
>  > +    /* Mark the worker as pending. */
>  > +    if (put_user(UMCG_IDLE_NODE_PENDING, node))
>  > +        return false;
>  > +
>  > +    /* Make the head point to the worker. */
>  > +    if (xchg_user_64(head_ptr, &first))
>  > +        return false;
>  > +
>  > +    /* Make the worker point to the previous head. */
>  > +    if (put_user(first, node))
>  > +        return false;
>  > +
>  > +    return true;
>  > +}
>
> If the last two operation return false, whichever task tries to consume the
> list could deadlock, depending on whether or not the ensuing
> force_sig(SIGKILL); reaches the consuming task. Does the force_sig kill
> the task or the entire process. Is it possible to consume this list from a
> different process that shares the memory? I'm wondering if the last
> two "return false" should attempt to retract the
> UMCG_IDLE_NODE_PENDING.

The function will return false only on a memory access error, and the
whole process will be killed as a result. At least this is the
intention. Do you think the code does anything different?
