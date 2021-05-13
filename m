Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF8137F3C2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 09:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbhEMH4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 03:56:54 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3744 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbhEMH4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 03:56:52 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FgkQV55bCzqSVD;
        Thu, 13 May 2021 15:52:18 +0800 (CST)
Received: from [127.0.0.1] (10.40.192.131) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.498.0; Thu, 13 May 2021
 15:55:34 +0800
Subject: Re: [PATCH] printk: stop spining waiter when console resume to flush
 prb
To:     Petr Mladek <pmladek@suse.com>
CC:     <sergey.senozhatsky@gmail.com>, <rostedt@goodmis.org>,
        <john.ogness@linutronix.de>, <linux-kernel@vger.kernel.org>,
        "Sergey Senozhatsky" <senozhatsky@chromium.org>,
        <linuxarm@huawei.com>, <bobo.shaobowang@huawei.com>
References: <1620288026-5373-1-git-send-email-luojiaxing@huawei.com>
 <YJPxj83F1sBjHHAE@alley> <f38cd7b9-22a4-b65d-fd37-2d95fe95fc00@huawei.com>
 <YJj9JdhgL88ivHVy@alley> <cf883de9-0fd9-5b84-88e8-1bd73b9ee28a@huawei.com>
 <YJpJlsw6860gZhIt@alley>
From:   luojiaxing <luojiaxing@huawei.com>
Message-ID: <f0ce1966-9316-918b-e33e-0f324e148039@huawei.com>
Date:   Thu, 13 May 2021 15:55:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <YJpJlsw6860gZhIt@alley>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.40.192.131]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/5/11 17:08, Petr Mladek wrote:
> On Tue 2021-05-11 15:32:13, luojiaxing wrote:
>> On 2021/5/10 17:30, Petr Mladek wrote:
>>> On Mon 2021-05-10 15:41:31, luojiaxing wrote:
>>>> On 2021/5/6 21:39, Petr Mladek wrote:
>> To facilitate debugging, I replaced the implementation code of the kernel
>> thread with the debugfs interface.
>>
>> It's possible that my simulations test were not designed clearly enough, and
>> you might be misunderstood. Sorry.
> No problem. The simulation is not that important. We all agree that
> printk() has this problem. I was just curios how much the simulation
> did meet the real life problem.
>
>
>>> Also, do you see this problem in the real life, please?
>> Yes, the following is part of log found when the user performs S4 suspend
>> and resume on the PC:
>>
>> [  1368979] PM: thaw_processes over
>> [  146.369606] PM: __pm_notifier_call_chain over
>> [  146.374285] cpu1 pid4321 irq0 hisi_sas_debug_I_T_nexus_reset 1844 phy5
>> unlock mutex
>> [  146.374287] cpu1 pid4321 irq0 hisi_sas_debug_I_T_nexus_reset 1845 phy5
>> reset over
>> [  146.374288] cpu2 pid4256 irq0 hisi_sas_debug_I_T_nexus_reset 1780 phy4
>> get mutex
>> [  146.374297] hisi_sas_v3_hw 0000:74:02.0: phydown: phy4 phy_state=0x21
>> [  146.531336] cpu2 pid4256 irq0 hisi_sas_debug_I_T_nexus_reset 1810 phy4
>> wait start 2
>> [  146.533523] hisi_sas_v3_hw 0000:74:02.0: ignore flutter phy4 down
> So, here is the delay caused by flushing the accumulated printk()
> messages. Am I right, please?


Yes, My personal expectation was that the delay in printk() was about 10ms,

but this situaton was far more than expected,


>
>
>> [  148.551332] cpu2 pid4256 irq0 hisi_sas_debug_I_T_nexus_reset 1812 phy4
>> wait over 2
>> [  148.552442] cpu0 pid302 irq128 phy_up_v3_hw 1586 phy4
>> [  148.552449] sas: sas_form_port: phy4 belongs to port0 already(1)!
>> [  148.559980] cpu2 pid4256 irq0 hisi_sas_debug_I_T_nexus_reset 182reset
>> timeout
>> [  148.567480] ata5.00: configured for UDMA/133
>> [  148.574743] cpu2 pid4256 irq0 hisi_sas_debug_I_T_nexus_reset 14 phy4
>> unlock mut  148.574744] cpu2 pid4250 hisi_sas_debug_I_T_nexus_reset 1845
>> phy4 reset over
>> [  148.734754] PM: pm_restore_console over
> I am a bit confused that pm_restore_console is mentioned after the
> problematic delay.
>
> I guess that "over" means that the function returned here.
> Does it mean that resume_console() was called earlier before
> the above delay?


Yes, resume_console() is called before phy up interrupt call printk()


These is another log, may be more clear:

[  739.860835] hisi_sas_v3_hw 0000:74:02.0: resuming from operating 
state [D0]
[  739.867233] hisi_sas_v3_hw 0000:74:04.0: resuming from operating 
state [D0]

...

[  742.906981] cpu2 pid4182 irq0 hisi_sas_debug_I_T_nexus_reset 1799 
phy0 wait start
[  742.907970] cpu0 pid4107 irq128 phy_up_v3_hw 1463 phy0
[  744.934979] cpu2 pid4182 irq0 hisi_sas_debug_I_T_nexus_reset 1801 
phy0 wait over
[  744.944173] cpu2 pid4182 irq0 hisi_sas_debug_I_T_nexus_reset 1811 
phy0 reset timeout


PC resume, console_resume() is call somewhere between [ 742.906981] and 
[  739.867233],

Then our driver execute I_T_nexus_reset on phy0 and start to wait phy 
up. phy up interrupt actually

come back soon, and cache "phy_up_v3_hw 1463 phy0" on [ 742.907970], but 
as you konw,

printk() is blocked here and after 2s, I_T_nexus_reset wait over and 
print timeout.


>
>
>> [  148.738587] PM: atomic_inc over
>> [  148.738588] PM: hibernation exit
>> [  148.738714] PM: hibernation entry
>>
>>
>> You can see "hisi_sas_debug_I_T_nexus_reset 182reset timeout" in the above
>> print, which we added to the kernel.
>>
>> The mean to wait for a phy up interrupt, as the interrupt didn't come back
>> for more than 2s, so driver report a timeout.
>>
>> However, when we check the hardware register, the flag of phy up interrupt
>> has been set, So the interrupt should have returned.
>>
>> After analysis,  we found that dev_info() called by phy up interrupt is
>> blocked for more than 2s. We proved that this dev_info() takes over
>>
>> the job of flushing the prb from console_resume(), and unfortunately, no
>> other kthread call printk() at this moment.
>>
>> So it take more than 2 seconds before returning and prolong phy up interrupt
>> callback func's handle duration, finally misjudgment leading to timeout.
> OK.
>
>
>>> What motivated you to investigate this scenario, please?
>>
>> I also try to modify it in my own driver to prolong the timeout judgment by
>> several seconds. However, since the time to flush the prb depends
>>
>> on the number of caches in the logbuf, I cannot determine how many seconds
>> to extend the timeout judgment.
> Unfortunately. there is no hard limit at the moment. There are
> situations where printk() causes softlockups which means that the
> console work takes longer than 30 sec.
>
>
>> In addition, I understand that many kernel drivers do not expect printk() to
>> be blocked for more than a few seconds when calling printk(). And,
>>
>> printk is blocked only in a few specific scenarios, and the framework does
>> not need to be modified, so may be it's simple to be fixed.
> This is very old problem. If I remember correctly, the first attempts
> to offload the console handling started in 2012. The main problem is
> that offloading increases the risk that the messages will never reach
> the console. This blocked any change for years.
>
> There is finally a consensus to give it a chance. RT people are
> working hard on it. They put a lot of effort to make lockless
> ringbuffer. Offload is the next step. But it requires implementing
> atomic console(s), serialize backtraces from all CPUs in NMI,
> and try to push the messages immediately when things go wrong
> or when the kthreads could not get scheduled by definition,
> for example, early boot, suspend, shutdown, panic.


I understand the effect of offload allows the driver to call printk() to 
return quickly without any blocking, right?


>
>> Therefore, I proposed this bugfix.
> The fix is rather a workaround. And it helps only in one particular
> scenario. It will get obsolete when the console work is offloaded.
> I would like to be sure that it is important enough.
>
> Does the fix prevent "only" an extra reset?
> Is the system functional in the end?


 From the results, system disk become read-only after resume. We are 
storage driver.


> Is it acceptable to keep it as is and wait for the proper solution?


As you said, offload takes more than one year to upstream. If this 
bugfix is a small one and scenario-specific,

can we fix it first? Perhaps this bugfix will be removed along with the 
rest of the code when offload upstream.

However other drivers don't sense any change.

If our drive do the workaround, we have to revert it after offload 
upstream, which may be more troublesome for us.


Thanks

Jiaxing


>
> To be honest, it might take a long time (even > 1 year) until
> the kthreads are upstream. As I already wrote, there was a pushback
> against it and we need to do it properly.
>
> Best Regards,
> Petr
>
> .
>

