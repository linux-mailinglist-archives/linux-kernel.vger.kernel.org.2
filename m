Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2643C37A0D8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 09:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbhEKHdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 03:33:32 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2773 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhEKHda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 03:33:30 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FfV0X73kWzmgB0;
        Tue, 11 May 2021 15:29:00 +0800 (CST)
Received: from [127.0.0.1] (10.40.192.131) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.498.0; Tue, 11 May 2021
 15:32:14 +0800
Subject: Re: [PATCH] printk: stop spining waiter when console resume to flush
 prb
To:     Petr Mladek <pmladek@suse.com>
CC:     <sergey.senozhatsky@gmail.com>, <rostedt@goodmis.org>,
        <john.ogness@linutronix.de>, <linux-kernel@vger.kernel.org>,
        "Sergey Senozhatsky" <senozhatsky@chromium.org>,
        <linuxarm@huawei.com>, <bobo.shaobowang@huawei.com>
References: <1620288026-5373-1-git-send-email-luojiaxing@huawei.com>
 <YJPxj83F1sBjHHAE@alley> <f38cd7b9-22a4-b65d-fd37-2d95fe95fc00@huawei.com>
 <YJj9JdhgL88ivHVy@alley>
From:   luojiaxing <luojiaxing@huawei.com>
Message-ID: <cf883de9-0fd9-5b84-88e8-1bd73b9ee28a@huawei.com>
Date:   Tue, 11 May 2021 15:32:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <YJj9JdhgL88ivHVy@alley>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.40.192.131]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/5/10 17:30, Petr Mladek wrote:
> On Mon 2021-05-10 15:41:31, luojiaxing wrote:
>> On 2021/5/6 21:39, Petr Mladek wrote:
>> Hi, Petr, I test your patch and I think it needs to make some modifications
>> to fix the problem.
>>
>>
>> My test method is as follows:
>> Kernel thread A causes the console to enter suspend and then resume it 10
>> seconds later.
>> Kernel thread B repeatedly invokes dev_info() for 15 seconds after the
>> console suspend.
> Could you please provide the test code?


To facilitate debugging, I replaced the implementation code of the 
kernel thread with the debugfs interface.

debugfs_test_if_1_write（） corresponds to kernel thread A.


+static ssize_t debugfs_test_if_1_write(struct file *file,
+                                               const char __user *user_buf,
+                                               size_t count, loff_t *ppos)
+{
+       struct hisi_hba *hisi_hba = file->f_inode->i_private;
+       char buf[DUMP_BUF_SIZE];
+
+       if (copy_from_user(buf, user_buf, count))
+               return -EFAULT;
+
+       if (buf[0] != '1')
+               return -EFAULT;
+
+       suspend_console();
+       mdelay(5000);
+       resume_console();
+
+       return count;
+}

debugfs_test_if_2_write corresponds to kernel thread B.

+static ssize_t debugfs_test_if_2_write(struct file *file,
+                                               const char __user *user_buf,
+                                               size_t count, loff_t *ppos)
+{
+       struct hisi_hba *hisi_hba = file->f_inode->i_private;
+       char buf[DUMP_BUF_SIZE];
+       int i;
+
+       if (copy_from_user(buf, user_buf, count))
+               return -EFAULT;
+
+       if (buf[0] != '1')
+               return -EFAULT;
+
+       for (i = 0; i < 1000; i++){
+               dev_info(hisi_hba->dev, "print test");
+       }
+
+       return count;
+}


Step：

1.echo 1 > debugfs_test_if_1

2.repeat to echo 1 > debugfs_test_if_2, until debugfs_test_if_1 return

3.check timestamp by dmesg


>
> If kthread B starts invoking dev_info() after console_resume() then it
> has nothing to do with suspend/resume.


It's possible that my simulations test were not designed clearly enough, 
and you might be misunderstood. Sorry.

I should actually design a kthread C to send a print during the 
console_resume process (when it hasn't been returned).

But this was a litter more difficult to achieved, so I had kthread B 
accomplish two test purposes. kthread B before console_resume

is invoked is to simulate loading a large amount of cache into printk 
logbuf. After the console_resume is invoked, kthread B is used to

prove that it takes over the prb flushing task from console_resume, 
causing Thread B to be blocked.


> It can happen anytime that a
> process starts a flood of printk() calls.
>
> Also, do you see this problem in the real life, please?


Yes, the following is part of log found when the user performs S4 
suspend and resume on the PC:

[  1368979] PM: thaw_processes over
[  146.369606] PM: __pm_notifier_call_chain over
[  146.374285] cpu1 pid4321 irq0 hisi_sas_debug_I_T_nexus_reset 1844 
phy5 unlock mutex
[  146.374287] cpu1 pid4321 irq0 hisi_sas_debug_I_T_nexus_reset 1845 
phy5 reset over
[  146.374288] cpu2 pid4256 irq0 hisi_sas_debug_I_T_nexus_reset 1780 
phy4 get mutex
[  146.374297] hisi_sas_v3_hw 0000:74:02.0: phydown: phy4 phy_state=0x21
[  146.531336] cpu2 pid4256 irq0 hisi_sas_debug_I_T_nexus_reset 1810 
phy4 wait start 2
[  146.533523] hisi_sas_v3_hw 0000:74:02.0: ignore flutter phy4 down
[  148.551332] cpu2 pid4256 irq0 hisi_sas_debug_I_T_nexus_reset 1812 
phy4 wait over 2
[  148.552442] cpu0 pid302 irq128 phy_up_v3_hw 1586 phy4
[  148.552449] sas: sas_form_port: phy4 belongs to port0 already(1)!
[  148.559980] cpu2 pid4256 irq0 hisi_sas_debug_I_T_nexus_reset 182reset 
timeout
[  148.567480] ata5.00: configured for UDMA/133
[  148.574743] cpu2 pid4256 irq0 hisi_sas_debug_I_T_nexus_reset 14 phy4 
unlock mut  148.574744] cpu2 pid4250 hisi_sas_debug_I_T_nexus_reset 1845 
phy4 reset over
[  148.734754] PM: pm_restore_console over
[  148.738587] PM: atomic_inc over
[  148.738588] PM: hibernation exit
[  148.738714] PM: hibernation entry


You can see "hisi_sas_debug_I_T_nexus_reset 182reset timeout" in the 
above print, which we added to the kernel.

The mean to wait for a phy up interrupt, as the interrupt didn't come 
back for more than 2s, so driver report a timeout.

However, when we check the hardware register, the flag of phy up 
interrupt has been set, So the interrupt should have returned.

After analysis,  we found that dev_info() called by phy up interrupt is 
blocked for more than 2s. We proved that this dev_info() takes over

the job of flushing the prb from console_resume(), and unfortunately, no 
other kthread call printk() at this moment.

So it take more than 2 seconds before returning and prolong phy up 
interrupt callback func's handle duration, finally misjudgment leading 
to timeout.


> What motivated you to investigate this scenario, please?


I also try to modify it in my own driver to prolong the timeout judgment 
by several seconds. However, since the time to flush the prb depends

on the number of caches in the logbuf, I cannot determine how many 
seconds to extend the timeout judgment.

In addition, I understand that many kernel drivers do not expect 
printk() to be blocked for more than a few seconds when calling 
printk(). And,

printk is blocked only in a few specific scenarios, and the framework 
does not need to be modified, so may be it's simple to be fixed.

Therefore, I proposed this bugfix.


>
>>> >From 574e844f512c9f450e64832f09cc389bc9915f83 Mon Sep 17 00:00:00 2001
>>> From: Petr Mladek <pmladek@suse.com>
>>> Date: Thu, 6 May 2021 12:40:56 +0200
>>> Subject: [PATCH] printk: Prevent softlockup when resuming console
>>>
>>> Many printk messages might get accumulated when consoles were suspended.
>>> They are proceed when console_unlock() is called in resume_console().
>>>
>>> --- a/kernel/printk/printk.c
>>> +++ b/kernel/printk/printk.c
>>> @@ -2637,13 +2636,15 @@ void console_unlock(void)
>>>    		 * finish. This task can not be preempted if there is a
>>>    		 * waiter waiting to take over.
>>>    		 */
>>> -		console_lock_spinning_enable();
>>> +		if (spinning_enabled)
>>> +			console_lock_spinning_enable();
>>
>> change to
>>
>>
>> +               if (!spinning_enabled) {
>> +                       raw_spin_lock(&console_owner_lock);
>> +                       WRITE_ONCE(console_waiter, true);
>> +                       raw_spin_unlock(&console_owner_lock);
>> +               }
>>
> IMHO, both variants have the same result and behavior:


Yes, you are right. If we set owner as NULL, it's the same with setting 
waiter as true.


Sorry for misunderstanding your purpose. It is ok to fix my problem.


Tested-by: Luo Jiaxing <luojiaxing@huawei.com>


Thanks

Jiaxing


>
> console_trylock_spinning() has the following condition:
>
> 	if (!waiter && owner && owner != current) {
> 		WRITE_ONCE(console_waiter, true);
> 		spin = true;
> 	}
>
> My variant causes that @owner will stay "NULL".
> Your variant causes that @waiter will be "true"
>
> In both cases, the condition fails and spin will stay "false"
> which means that any parallel printk() will not spin.
>
> Best Regards,
> Petr
>
> .
>

