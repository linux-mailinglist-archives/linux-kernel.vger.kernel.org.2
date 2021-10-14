Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83CC742DAD3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 15:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbhJNNwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 09:52:55 -0400
Received: from mail.efficios.com ([167.114.26.124]:53082 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbhJNNwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 09:52:53 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 23E0438D9B7;
        Thu, 14 Oct 2021 09:50:48 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id rL65uo4OawBC; Thu, 14 Oct 2021 09:50:47 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 7236438D5B9;
        Thu, 14 Oct 2021 09:50:47 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 7236438D5B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1634219447;
        bh=1oQ91ES9+OrNcvxVdRqxEZUeYE/0Ga7yL1CNMP75TGU=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=Gv70AcN0MVN251go5qKMZ7Ll+9BNGYD1t+t8bBnHhRgjeHtKfSDEzIMOkdVcy4Zcq
         GzWdCTl+9vtZVvTiGJ8OjumO1OyH7IgPvFD5xMnEaGX94fizNUtPOa3ZhnFLpDc0n2
         rvx1VhUrX+CBJ5qJ0/1/trFiGLIV+nvDSMtGqjMxpTzogMtTC1irsQM6tcRzp8Hg/v
         TxwUTFl9XX5HbsQ6vfG+qjbr0bslrI/qQQv8rSIZ8de001wr8c5cSh3KZRfE25dXBe
         +UnNIxhjiYMIhAgaR5S+0EDj45JTdaxyPMzSUXLjQDjLKLgj7nYB6I5J4PrBcdYOhb
         3fr6sAgkIg3bQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id teD4_N-aPibQ; Thu, 14 Oct 2021 09:50:47 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 5710638D850;
        Thu, 14 Oct 2021 09:50:47 -0400 (EDT)
Date:   Thu, 14 Oct 2021 09:50:47 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     acme <acme@kernel.org>, rostedt <rostedt@goodmis.org>,
        kernel test robot <oliver.sang@intel.com>,
        0day robot <lkp@intel.com>, Petr Mladek <pmladek@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        lkp <lkp@lists.01.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qiang Zhang <qiang.zhang@windriver.com>,
        robdclark <robdclark@chromium.org>,
        christian <christian@brauner.io>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        bristot <bristot@redhat.com>,
        aubrey li <aubrey.li@linux.intel.com>,
        yu c chen <yu.c.chen@intel.com>
Message-ID: <1171592945.14099.1634219447199.JavaMail.zimbra@efficios.com>
In-Reply-To: <CALOAHbBTxLvuiuT4tT2_7C+jaXBoh0uTjzLRm+njO4tKxCtPwg@mail.gmail.com>
References: <20211010102429.99577-4-laoar.shao@gmail.com> <20211014072707.GA18719@xsang-OptiPlex-9020> <CALOAHbD540exB5DDfB8DDh8WXvsag9JsdMmC0yxriWMaoAVfOg@mail.gmail.com> <1529739526.13983.1634215325995.JavaMail.zimbra@efficios.com> <CALOAHbDGH1vp7a9BYLDKCCrh-W2205O707LXNM+Yvt5tQ7Swag@mail.gmail.com> <173454728.14036.1634216949862.JavaMail.zimbra@efficios.com> <CALOAHbBTxLvuiuT4tT2_7C+jaXBoh0uTjzLRm+njO4tKxCtPwg@mail.gmail.com>
Subject: Re: [sched.h] 317419b91e:
 perf-sanity-tests.Parse_sched_tracepoints_fields.fail
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4156 (ZimbraWebClient - FF93 (Linux)/8.8.15_GA_4156)
Thread-Topic: 317419b91e: perf-sanity-tests.Parse_sched_tracepoints_fields.fail
Thread-Index: dnylLOo0GJfvLY2KUZXz7UA2DS74dw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Oct 14, 2021, at 9:11 AM, Yafang Shao laoar.shao@gmail.com wrote:

> On Thu, Oct 14, 2021 at 9:09 PM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> ----- On Oct 14, 2021, at 9:05 AM, Yafang Shao laoar.shao@gmail.com wrote:
>> [...]
>> >> If it happens that this ABI break is noticed by more than an in-tree test
>> >> program, then
>> >> the kernel's ABI rules will require that this trace field size stays unchanged.
>> >> This brings
>> >> up once more the whole topic of "Tracepoints ABI" which has been discussed
>> >> repeatedly in
>> >> the past.
>> >>
>> >
>> > I will check if any other in-tree tools depends on TASK_COMM_LEN.
>>
>> That's a start, but given this is a userspace ABI, out-of-tree userland
>> tools which depend of this to be fixed-size are also relevant.
>>
> 
> TASK_COMM_LEN isn't defined in include/uapi/ directory, so it seems
> that it isn't the uerspace ABI?

One case where this 16 bytes size is expected by userspace is prctl(2) PR_GET_NAME
and PR_SET_NAME.

The other case I am referring to is with ftrace and perf:

mount -t tracefs nodev /sys/kernel/tracing
cat /sys/kernel/tracing/events/sched/sched_switch/format

name: sched_switch
ID: 314
format:
[...]
	field:char prev_comm[16];	offset:8;	size:16;	signed:1;
[...]
	field:char next_comm[16];	offset:40;	size:16;	signed:1;

Both of those fields expose a fixed-size of 16 bytes.

AFAIK Steven's intent was that by parsing this file, trace viewers could adapt to
changes in the event field layout. Unfortunately, there have been cases where
trace viewers had a hard expectation on the field layout. Hopefully those have
all been fixed a while ago.

Thanks,

Mathieu


> 
> 
> --
> Thanks
> Yafang

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
