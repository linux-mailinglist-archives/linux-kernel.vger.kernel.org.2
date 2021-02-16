Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4E4231C8F0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 11:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbhBPKjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 05:39:05 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:53111 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229703AbhBPKi7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 05:38:59 -0500
Received: from [192.168.0.6] (ip5f5aea7e.dynamic.kabel-deutschland.de [95.90.234.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 8021F2064791F;
        Tue, 16 Feb 2021 11:38:14 +0100 (CET)
Subject: Re: smpboot: CPU numbers printed as warning
To:     Petr Mladek <pmladek@suse.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        it+linux-x86@molgen.mpg.de,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>
References: <e964b2ae-7a15-a510-e76a-56d704949d62@molgen.mpg.de>
 <YCuVEDXyIu+yE4c1@alley>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <06fbb8ba-5e6a-2430-f447-86324916fc54@molgen.mpg.de>
Date:   Tue, 16 Feb 2021 11:38:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YCuVEDXyIu+yE4c1@alley>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Petr,


Thank you for the quick reply.


Am 16.02.21 um 10:49 schrieb Petr Mladek:
> On Mon 2021-02-15 20:22:34, Paul Menzel wrote:

>> Using Linux 5.10.13 (and before), looking at the Linux kernel warnings, the
>> CPU numbers show up. For example with 12 cpus/threads:
>>
>> ```
>> $ sudo dmesg --level=warn
>> [    0.216103]   #2
>> [    0.220105]   #3
>> [    0.224103]   #4
>> [    0.228104]   #5
>> [    0.232110]   #6
>> [    0.236101]   #7
>> [    0.240102]   #8
>> [    0.244102]   #9
>> [    0.248100]  #10
>> [    0.252098]  #11
>> ```
> 
> Is this the exact output from sudo dmesg --level=warn?

Yes, it is.

> It is strange that each CPU number is printed on its own line.

Should it be put on one line, if `dmesg --level=warn` is executed, even 
with other messages in between?

> Anyway, it might be affected by the new lockless ringbuffer.
> The original code decided whether to connect the lines only by
> "current" task pointer. The lockless ring buffer takes into account
> also CPU number.
> 
> Well, it has never been reliable. For example, I see here:
> 
> <6>[    0.238262][    T1] smp: Bringing up secondary CPUs ...
> <6>[    0.239340][    T1] x86: Booting SMP configuration:
> <6>[    0.239794][    T1] .... node  #0, CPUs:      #1
> <6>[    0.113946][    T0] kvm-clock: cpu 1, msr 6ba01041, secondary cpu clock
> <6>[    0.113946][    T0] smpboot: CPU 1 Converting physical 0 to logical die 1
> <6>[    0.246056][   T16] kvm-guest: stealtime: cpu 1, msr 17f9f2080
> <4>[    0.246679][    T1]  #2
> <6>[    0.113946][    T0] kvm-clock: cpu 2, msr 6ba01081, secondary cpu clock
> <6>[    0.113946][    T0] smpboot: CPU 2 Converting physical 0 to logical die 2
> <6>[    0.250023][   T21] kvm-guest: stealtime: cpu 2, msr 17fbf2080
> <4>[    0.250648][    T1]  #3
> <6>[    0.113946][    T0] kvm-clock: cpu 3, msr 6ba010c1, secondary cpu clock
> <6>[    0.113946][    T0] smpboot: CPU 3 Converting physical 0 to logical die 3
> <6>[    0.254026][   T26] kvm-guest: stealtime: cpu 3, msr 17fdf2080
> <6>[    0.254568][    T1] smp: Brought up 1 node, 4 CPUs
> <6>[    0.254597][    T1] smpboot: Max logical packages: 4
> <6>[    0.255097][    T1] smpboot: Total of 4 processors activated (16896.11 BogoMIPS)
> 
> There are another messages printed in between that obviously break pr_cont().

Yes, that is what I meant.

>> If I am not mistaken, this is from `announce_cpu()` in
>> `arch/x86/kernel/smpboot.c`, and the `pr_cont()` in their “forgets” the log
>> level it belongs to, maybe because of SMP and other messages are printed in
>> between.
>>
>> ```
>>          if (system_state < SYSTEM_RUNNING) {
>>                  if (node != current_node) {
>>                          if (current_node > (-1))
>>                                  pr_cont("\n");
>>                          current_node = node;
>>
>>                          printk(KERN_INFO ".... node %*s#%d, CPUs:  ",
>>                                 node_width - num_digits(node), " ", node);
>>                  }
>>
>>                  /* Add padding for the BSP */
>>                  if (cpu == 1)
>>                          pr_cont("%*s", width + 1, " ");
>>
>>                  pr_cont("%*s#%d", width - num_digits(cpu), " ", cpu);
>>
>>          } else
>>                  pr_info("Booting Node %d Processor %d APIC 0x%x\n",
>>                          node, cpu, apicid);
>> ```
> 
>> Would using `pr_info()` instead be an acceptable fix?
> 
> Makes sense to me.
> 
> Also you should add '\n' into the previous string to make the behavior
> clear. It will always be printed on a new line when pr_info()
> is used.

I am going to reply to Borislav’s response.


Kind regards,

Paul
