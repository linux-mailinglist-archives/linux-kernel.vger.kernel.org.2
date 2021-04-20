Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A28C73655A5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 11:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbhDTJo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 05:44:26 -0400
Received: from foss.arm.com ([217.140.110.172]:59712 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229937AbhDTJoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 05:44:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D26F1435;
        Tue, 20 Apr 2021 02:43:54 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A428B3F85F;
        Tue, 20 Apr 2021 02:43:52 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     syzbot <syzbot+9362b31a2e0cad8b749d@syzkaller.appspotmail.com>,
        bp@alien8.de, dwmw@amazon.co.uk, hpa@zytor.com,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Subject: Re: [syzbot] WARNING in kthread_is_per_cpu
In-Reply-To: <YH6WJc825C4P0FCK@hirez.programming.kicks-ass.net>
References: <000000000000a61f7705c050e601@google.com> <87im4ilddh.mognet@arm.com> <20210419184553.GA26214@worktop.programming.kicks-ass.net> <874kg2kpwd.mognet@arm.com> <YH6WJc825C4P0FCK@hirez.programming.kicks-ass.net>
Date:   Tue, 20 Apr 2021 10:43:43 +0100
Message-ID: <87lf9duw8g.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/04/21 10:51, Peter Zijlstra wrote:
> On Mon, Apr 19, 2021 at 08:58:26PM +0100, Valentin Schneider wrote:
>
>> Looks about right, IIUC the key being:
>>
>>   p->flags & PF_KTHREAD + p->set_child_tid => the struct kthread is
>>   persistent
>>
>>   p->flags & PF_KTHREAD => you may or may not have a struct kthread (see
>>   kernel/umh.c kernel_thread() uses). PF_KTHREAD isn't even guaranteed to
>>   persist (begin_new_exec()), which seems to be what the syzbot hit.
>
> Ack, that's nicely put.
>
>> While we're at it, does free_kthread_struct() want the __to_kthread()
>> treatment as well? The other to_kthread() callsites looked like they only
>> made sense with a "proper" kthread anyway.
>
> I think free_kthread_struct() is ok, because a task at that point in its
> lifetime cannot be also doing exec().
>

What if it's one of those kthreads created by directly invoking
kernel_thread()? AFAICT right now it's only umh, and that one does execve()
so it ends up stripped of PF_KTHREAD. It could however go through an error
path, i.e. not call exec, and exit, giving us:

  put_task_struct(p)
  `\
    free_task(p)
    `\
      if (tsk->flags & PF_KTHREAD)
          free_kthread_struct(tsk);
          `\
            to_kthread(p)

> kthread_func() is another 'fun' trainwreck waiting to happen -- luckily
> the only caller uses current, still let me go fix it.
>
> kthread_probe_data() relies on PF_WQ_WORKER implying PF_KTHREAD but
> otherwise seems very fragile too.
>
> Something like so then?
>

Other than the above:

Reviewed-by: Valentin Schneider <Valentin.Schneider@arm.com>
