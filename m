Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A61963459B0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 09:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbhCWI2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 04:28:30 -0400
Received: from relay.yourmailgateway.de ([185.244.194.184]:56667 "EHLO
        relay.yourmailgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhCWI2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 04:28:02 -0400
X-Greylist: delayed 481 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Mar 2021 04:28:01 EDT
Received: from relay01-mors.netcup.net (localhost [127.0.0.1])
        by relay01-mors.netcup.net (Postfix) with ESMTPS id 4F4PRz1xJhz8tSG;
        Tue, 23 Mar 2021 09:19:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=alexander-lochmann.de; s=key2; t=1616487599;
        bh=+p0e/i3bojWKDeQgNSy96bwUnLwKiF2lmTH6hEUgB8A=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Tqf/j6Gozt6f4lr7rAvdB4hZv1brkVCMy2MJjGspBnp4GK78KPLWHiJMl6L6TIYvL
         eSsYjq1M41ri/6G0X/cnBVHZGivbApys8456glgB0Vlf+mqPQxD77qkNQ66ooQLqbM
         dJTn7E76aijkvDQq/kDILqbEuElCEsmHlU7ud7iiuEHnoBUBiMhDIAfwgpZflaQbet
         woUBvqSVNEWoT6kqnELfjHvUV6mTYMFZd0yljhhoAHKabgLMDDth9BOm/GyDka1yHl
         s12byVAQ4gyg69YqNZUqs7JVdirOHCjddA1SAjpPAdCwlSA1lWOMGVQ/TT98wxtJLa
         xSZSIFUFqJ9SA==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
        by relay01-mors.netcup.net (Postfix) with ESMTPS id 4F4PRz1Wnnz8901;
        Tue, 23 Mar 2021 09:19:59 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at policy02-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=6.31 tests=[ALL_TRUSTED=-1,
        BAYES_00=-1.9, SPF_PASS=-0.001, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from mx2e12.netcup.net (unknown [10.243.12.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by policy02-mors.netcup.net (Postfix) with ESMTPS id 4F4PRt2j8Jz8t10;
        Tue, 23 Mar 2021 09:19:54 +0100 (CET)
Received: from [IPv6:2001:638:50d:132b::37] (chulak.cs.uni-dortmund.de [IPv6:2001:638:50d:132b::37])
        by mx2e12.netcup.net (Postfix) with ESMTPSA id 20F73A166A;
        Tue, 23 Mar 2021 09:19:53 +0100 (CET)
Authentication-Results: mx2e12;
        spf=pass (sender IP is 2001:638:50d:132b::37) smtp.mailfrom=info@alexander-lochmann.de smtp.helo=[IPv6:2001:638:50d:132b::37]
Received-SPF: pass (mx2e12: connection is authenticated)
Subject: Re: [PATCH] Introduced new tracing mode KCOV_MODE_UNIQUE.
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Miguel Ojeda <ojeda@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Klychkov <andrew.a.klychkov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aleksandr Nogikh <nogikh@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Maciej Grochowski <maciej.grochowski@pm.me>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
References: <CACT4Y+bdXrFoL1Z_h5s+5YzPZiazkyr2koNvfw9xNYEM69TSvg@mail.gmail.com>
 <20210321184403.8833-1-info@alexander-lochmann.de>
 <CACT4Y+Z=d0WmcGV+Tt-g4G=XVDruxbpvOPJSAN6JZ1rXbOQ=2Q@mail.gmail.com>
From:   Alexander Lochmann <info@alexander-lochmann.de>
Message-ID: <3ccb3274-b179-99e1-a317-b8c176bdac8e@alexander-lochmann.de>
Date:   Tue, 23 Mar 2021 09:19:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CACT4Y+Z=d0WmcGV+Tt-g4G=XVDruxbpvOPJSAN6JZ1rXbOQ=2Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <161648759337.962.3256402245034528508@mx2e12.netcup.net>
X-PPP-Vhost: alexander-lochmann.de
X-NC-CID: Kss/iMZsYNwjhJRgpnXIfPtQsPoSkXR8Dfz7pI9DUq3OasaLQGF4Q1NN
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23.03.21 08:23, Dmitry Vyukov wrote:
>> diff --git a/kernel/kcov.c b/kernel/kcov.c
>> index 80bfe71bbe13..1f727043146a 100644
>> --- a/kernel/kcov.c
>> +++ b/kernel/kcov.c
>> @@ -24,6 +24,7 @@
>>  #include <linux/refcount.h>
>>  #include <linux/log2.h>
>>  #include <asm/setup.h>
>> +#include <asm/sections.h>
> 
> Is this for __always_inline?
> __always_inline is defined in include/linux/compiler_types.h.
> 
This is for the symbols marking start and end of the text segment
(_stext/_etext).
> 
>>
>>  #define kcov_debug(fmt, ...) pr_debug("%s: " fmt, __func__, ##__VA_ARGS__)
>>
>> @@ -151,10 +152,8 @@ static void kcov_remote_area_put(struct kcov_remote_area *area,
>>         list_add(&area->list, &kcov_remote_areas);
>>  }
>>
>> -static notrace bool check_kcov_mode(enum kcov_mode needed_mode, struct task_struct *t)
>> +static __always_inline notrace bool check_kcov_mode(enum kcov_mode needed_mode, struct task_struct *t, unsigned int *mode)
>>  {
>> -       unsigned int mode;
>> -
>>         /*
>>          * We are interested in code coverage as a function of a syscall inputs,
>>          * so we ignore code executed in interrupts, unless we are in a remote
>> @@ -162,7 +161,7 @@ static notrace bool check_kcov_mode(enum kcov_mode needed_mode, struct task_stru
>>          */
>>         if (!in_task() && !(in_serving_softirq() && t->kcov_softirq))
>>                 return false;
>> -       mode = READ_ONCE(t->kcov_mode);
>> +       *mode = READ_ONCE(t->kcov_mode);
>>         /*
>>          * There is some code that runs in interrupts but for which
>>          * in_interrupt() returns false (e.g. preempt_schedule_irq()).
>> @@ -171,7 +170,7 @@ static notrace bool check_kcov_mode(enum kcov_mode needed_mode, struct task_stru
>>          * kcov_start().
>>          */
>>         barrier();
>> -       return mode == needed_mode;
>> +       return ((int)(*mode & (KCOV_IN_CTXSW | needed_mode))) > 0;
> 
> This logic and the rest of the patch looks good to me.
> 
> Thanks
Thx.
> 
>>  }
>>
>>  static notrace unsigned long canonicalize_ip(unsigned long ip)
>> @@ -191,18 +190,27 @@ void notrace __sanitizer_cov_trace_pc(void)
>>         struct task_struct *t;
>>         unsigned long *area;
>>         unsigned long ip = canonicalize_ip(_RET_IP_);
>> -       unsigned long pos;
>> +       unsigned long pos, idx;
>> +       unsigned int mode;
>>
>>         t = current;
>> -       if (!check_kcov_mode(KCOV_MODE_TRACE_PC, t))
>> +       if (!check_kcov_mode(KCOV_MODE_TRACE_PC | KCOV_MODE_UNIQUE_PC, t, &mode))
>>                 return;
>>
>>         area = t->kcov_area;
>> -       /* The first 64-bit word is the number of subsequent PCs. */
>> -       pos = READ_ONCE(area[0]) + 1;
>> -       if (likely(pos < t->kcov_size)) {
>> -               area[pos] = ip;
>> -               WRITE_ONCE(area[0], pos);
>> +       if (likely(mode == KCOV_MODE_TRACE_PC)) {
>> +               /* The first 64-bit word is the number of subsequent PCs. */
>> +               pos = READ_ONCE(area[0]) + 1;
>> +               if (likely(pos < t->kcov_size)) {
>> +                       area[pos] = ip;
>> +                       WRITE_ONCE(area[0], pos);
>> +               }
>> +       } else {
>> +               idx = (ip - canonicalize_ip((unsigned long)&_stext)) / 4;
>> +               pos = idx % BITS_PER_LONG;
>> +               idx /= BITS_PER_LONG;
>> +               if (likely(idx < t->kcov_size))
>> +                       WRITE_ONCE(area[idx], READ_ONCE(area[idx]) | 1L << pos);
>>         }
>>  }
>>  EXPORT_SYMBOL(__sanitizer_cov_trace_pc);
>> @@ -213,9 +221,10 @@ static void notrace write_comp_data(u64 type, u64 arg1, u64 arg2, u64 ip)
>>         struct task_struct *t;
>>         u64 *area;
>>         u64 count, start_index, end_pos, max_pos;
>> +       unsigned int mode;
>>
>>         t = current;
>> -       if (!check_kcov_mode(KCOV_MODE_TRACE_CMP, t))
>> +       if (!check_kcov_mode(KCOV_MODE_TRACE_CMP, t, &mode))
>>                 return;
>>
>>         ip = canonicalize_ip(ip);
>> @@ -362,7 +371,7 @@ void kcov_task_init(struct task_struct *t)
>>  static void kcov_reset(struct kcov *kcov)
>>  {
>>         kcov->t = NULL;
>> -       kcov->mode = KCOV_MODE_INIT;
>> +       kcov->mode = KCOV_MODE_INIT_TRACE;
>>         kcov->remote = false;
>>         kcov->remote_size = 0;
>>         kcov->sequence++;
>> @@ -468,12 +477,13 @@ static int kcov_mmap(struct file *filep, struct vm_area_struct *vma)
>>
>>         spin_lock_irqsave(&kcov->lock, flags);
>>         size = kcov->size * sizeof(unsigned long);
>> -       if (kcov->mode != KCOV_MODE_INIT || vma->vm_pgoff != 0 ||
>> +       if (kcov->mode & ~(KCOV_INIT_TRACE | KCOV_INIT_UNIQUE) || vma->vm_pgoff != 0 ||
>>             vma->vm_end - vma->vm_start != size) {
>>                 res = -EINVAL;
>>                 goto exit;
>>         }
>>         if (!kcov->area) {
>> +               kcov_debug("mmap(): Allocating 0x%lx bytes\n", size);
>>                 kcov->area = area;
>>                 vma->vm_flags |= VM_DONTEXPAND;
>>                 spin_unlock_irqrestore(&kcov->lock, flags);
>> @@ -515,6 +525,8 @@ static int kcov_get_mode(unsigned long arg)
>>  {
>>         if (arg == KCOV_TRACE_PC)
>>                 return KCOV_MODE_TRACE_PC;
>> +       else if (arg == KCOV_UNIQUE_PC)
>> +               return KCOV_MODE_UNIQUE_PC;
>>         else if (arg == KCOV_TRACE_CMP)
>>  #ifdef CONFIG_KCOV_ENABLE_COMPARISONS
>>                 return KCOV_MODE_TRACE_CMP;
>> @@ -562,12 +574,14 @@ static int kcov_ioctl_locked(struct kcov *kcov, unsigned int cmd,
>>  {
>>         struct task_struct *t;
>>         unsigned long size, unused;
>> -       int mode, i;
>> +       int mode, i, text_size, ret = 0;
>>         struct kcov_remote_arg *remote_arg;
>>         struct kcov_remote *remote;
>>         unsigned long flags;
>>
>>         switch (cmd) {
>> +       case KCOV_INIT_UNIQUE:
>> +               /* fallthrough here */
> 
> Looking at "git log --grep fallthrough", it seems that the modern way
> to say this is to use the fallthrough keyword.
> 
> Please run checkpatch, it shows a bunch of other warnings as well:
> 
> git diff HEAD^ | scripts/checkpatch.pl -
Yeah. I'll do that.

-- 
Alexander Lochmann                PGP key: 0xBC3EF6FD
Heiliger Weg 72                   phone:  +49.231.28053964
D-44141 Dortmund                  mobile: +49.151.15738323
