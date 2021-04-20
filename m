Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5502C3655FA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 12:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbhDTKRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 06:17:51 -0400
Received: from foss.arm.com ([217.140.110.172]:60142 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230264AbhDTKRu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 06:17:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 187A11474;
        Tue, 20 Apr 2021 03:17:19 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9F6DC3F85F;
        Tue, 20 Apr 2021 03:17:17 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     syzbot <syzbot+9362b31a2e0cad8b749d@syzkaller.appspotmail.com>,
        bp@alien8.de, dwmw@amazon.co.uk, hpa@zytor.com,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Subject: Re: [syzbot] WARNING in kthread_is_per_cpu
In-Reply-To: <YH6o6gd4oqqs6sHr@hirez.programming.kicks-ass.net>
References: <000000000000a61f7705c050e601@google.com> <87im4ilddh.mognet@arm.com> <20210419184553.GA26214@worktop.programming.kicks-ass.net> <874kg2kpwd.mognet@arm.com> <YH6WJc825C4P0FCK@hirez.programming.kicks-ass.net> <87lf9duw8g.mognet@arm.com> <YH6o6gd4oqqs6sHr@hirez.programming.kicks-ass.net>
Date:   Tue, 20 Apr 2021 11:17:15 +0100
Message-ID: <87im4huuok.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/04/21 12:11, Peter Zijlstra wrote:
> On Tue, Apr 20, 2021 at 10:43:43AM +0100, Valentin Schneider wrote:
>> On 20/04/21 10:51, Peter Zijlstra wrote:
>
>> > I think free_kthread_struct() is ok, because a task at that point in its
>> > lifetime cannot be also doing exec().
>> >
>>
>> What if it's one of those kthreads created by directly invoking
>> kernel_thread()? AFAICT right now it's only umh, and that one does execve()
>> so it ends up stripped of PF_KTHREAD. It could however go through an error
>> path, i.e. not call exec, and exit, giving us:
>>
>>   put_task_struct(p)
>>   `\
>>     free_task(p)
>>     `\
>>       if (tsk->flags & PF_KTHREAD)
>>           free_kthread_struct(tsk);
>>           `\
>>             to_kthread(p)
>
> I'm not following, at the point we hit free_task() it had better be dead
> and p->flags had better be stable. Either it will, or will not, have
> PF_KTHREAD.

Bah, don't mind me, for some reason I was obsessed by that umh thing of
having

  (p->flags & PF_KTHREAD) && !p->set_child_tid

but that's not a problem there. Sorry about that.
