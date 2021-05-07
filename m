Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D068637618F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 09:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbhEGH7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 03:59:51 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:17142 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236269AbhEGH7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 03:59:40 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fc2mp4Z99zqT4T;
        Fri,  7 May 2021 15:55:22 +0800 (CST)
Received: from [127.0.0.1] (10.40.192.131) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.498.0; Fri, 7 May 2021
 15:58:31 +0800
Subject: Re: [PATCH] printk: stop spining waiter when console resume to flush
 prb
To:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Petr Mladek <pmladek@suse.com>
CC:     <sergey.senozhatsky@gmail.com>, <rostedt@goodmis.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <bobo.shaobowang@huawei.com>
References: <1620288026-5373-1-git-send-email-luojiaxing@huawei.com>
 <YJPxj83F1sBjHHAE@alley> <YJP4F1UIt/eRZ96s@google.com>
 <YJP5MnkJ8pJevXM6@google.com> <87h7jfzygr.fsf@jogness.linutronix.de>
From:   luojiaxing <luojiaxing@huawei.com>
Message-ID: <962e67ff-12e3-9de9-9f2f-75d48bc729b1@huawei.com>
Date:   Fri, 7 May 2021 15:58:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <87h7jfzygr.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.40.192.131]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/5/6 23:14, John Ogness wrote:
> On 2021-05-06, Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
>>> Can we count the number of lines that we print from the `current` context
>>> in console_unlock() and if after N messages there is no console_lock waiter
>>> waiting for the `current` to handover console lock ownership, then create
>>> one: schedule IRQ work that will become a console lock owner, spin on
>>> console lock and call console_unlock() once it acquired the ownership.
>>> That 'artificial' console lock owner will do the same - print N
>>> messages, if nothing wants to become a console lock owner then it'll
>>> queue another IRQ work.
>> Or even simpler
>>
>> console_unlock()
>> {
>> 	...
>>
>> 	if (printed_messages > limit && !console_lock_spinning_disable_and_check()) {
>> 		printk_safe_exit_irqrestore(flags);
>>
>> 		console_locked = 0;
>> 		up_console_sem();
>>
>> 		defer_console_output();
>> 		return;
>> 	}
>>
>> 	...
>> }
> Or instead to keep it suspend/resume related maybe...
>
>   void resume_console(void)
>   {
>           if (!console_suspend_enabled)
>                   return;
>           down_console_sem();
>           console_suspended = 0;
> -        console_unlock();
> +        console_locked = 0;
> +        up_console_sem();
> +        defer_console_output();


Hi, john, I test this and found a calltrace below:

[  467.670366] hisi_sas_v3_hw 0000:b4:02.0: print test
[  467.670367] hisi_sas_v3_hw 0000:b4:02.0: print test
[  467.670368] hisi_sas_v3_hw 0000:b4:02.0: print test
[  467.670369] hisi_sas_v3_hw 0000:b4:02.0: print test
[  467.670370] hisi_sas_v3_hw 0000:b4:02.0: print test
[  467.670371] hisi_sas_v3_hw 0000:b4:02.0: print test
[  468.297467] hisi_sas_v3_hw 0000:b4:02.0: print test
[  489.298709] rcu: INFO: rcu_preempt self-detected stall on CPU
[  489.298712] rcu:     44-....: (4324 ticks this GP) 
idle=e6e/1/0x4000000000000002 softirq=1212/1212 fqs=2625
[  489.298722]  (t=5250 jiffies g=3285 q=1820)
[  489.298725] Task dump for CPU 44:
[  489.298726] task:bash            state:R  running task stack:    0 
pid:16937 ppid: 16935 flags:0x00000206
[  489.298731] Call trace:
[  489.298732]  dump_backtrace+0x0/0x1a4
[  489.298738]  show_stack+0x24/0x40
[  489.298740]  sched_show_task+0x148/0x170
[  489.298744]  dump_cpu_task+0x50/0x60
[  489.298748]  rcu_dump_cpu_stacks+0x10c/0x154
[  489.298751]  rcu_sched_clock_irq+0x8d4/0xd94
[  489.298755]  update_process_times+0xa8/0xf4
[  489.298758]  tick_sched_handle+0x38/0x74
[  489.298760]  tick_sched_timer+0x58/0xb0
[  489.298762]  __hrtimer_run_queues+0x18c/0x3a0
[  489.298764]  hrtimer_interrupt+0xf4/0x2cc
[  489.298767]  arch_timer_handler_phys+0x40/0x50
[  489.298771]  handle_percpu_devid_irq+0x94/0x280
[  489.298775]  __handle_domain_irq+0x88/0xf0
[  489.298777]  gic_handle_irq+0xd8/0x2c0
[  489.298779]  el1_irq+0xbc/0x180
[  489.298780]  console_unlock+0x390/0x580
[  489.298782]  vprintk_emit+0x104/0x280
[  489.298784]  dev_vprintk_emit+0x14c/0x184
[  489.298787]  dev_printk_emit+0x64/0x8c
[  489.298789]  __dev_printk+0x60/0x84
[  489.298792]  _dev_info+0x6c/0x94
[  489.298794]  debugfs_test_if_1_write+0xc0/0x14c [hisi_sas_v3_hw]
[  489.298801]  full_proxy_write+0x6c/0xc0
[  489.298804]  vfs_write+0xfc/0x2b0
[  489.298807]  ksys_write+0x74/0x100
[  489.298809]  __arm64_sys_write+0x28/0x34
[  489.298812]  el0_svc_common.constprop.0+0x70/0x1a4
[  489.298815]  do_el0_svc+0x28/0x3c
[  489.298817]  el0_svc+0x2c/0x70
[  489.298820]  el0_sync_handler+0x1a4/0x1b0
[  489.298822]  el0_sync+0x170/0x180
[  492.474266] hisi_sas_v3_hw 0000:b4:02.0: print test
[  492.479137] hisi_sas_v3_hw 0000:b4:02.0: print test
[  492.483996] hisi_sas_v3_hw 0000:b4:02.0: print test
[  492.488857] hisi_sas_v3_hw 0000:b4:02.0: print test
[  492.493716] hisi_sas_v3_hw 0000:b4:02.0: print test
[  492.498574] hisi_sas_v3_hw 0000:b4:02.0: print test


My test method is as follows: Use a kernel thread to make the console 
enter suspend, sleep for 10 seconds, and then resume.

At the same time, another thread repeatedly calls printk() for output.


Thanks

Jiaxing


>   }
>
> John Ogness
>
> .
>

