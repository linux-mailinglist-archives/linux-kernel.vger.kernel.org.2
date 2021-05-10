Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E354377E2F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 10:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbhEJIa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 04:30:27 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2736 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbhEJIaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 04:30:25 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FdvJm1QPszqTn4;
        Mon, 10 May 2021 16:26:00 +0800 (CST)
Received: from [127.0.0.1] (10.40.192.131) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.498.0; Mon, 10 May 2021
 16:29:11 +0800
Subject: Re: [PATCH] printk: stop spining waiter when console resume to flush
 prb
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
CC:     <sergey.senozhatsky@gmail.com>, <rostedt@goodmis.org>,
        <john.ogness@linutronix.de>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <bobo.shaobowang@huawei.com>
References: <1620288026-5373-1-git-send-email-luojiaxing@huawei.com>
 <YJPxj83F1sBjHHAE@alley> <YJP4F1UIt/eRZ96s@google.com>
 <YJVnNQ7RGvx9JKxV@alley>
From:   luojiaxing <luojiaxing@huawei.com>
Message-ID: <46df3838-e1a6-ee95-b398-bef0896d2b03@huawei.com>
Date:   Mon, 10 May 2021 16:29:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <YJVnNQ7RGvx9JKxV@alley>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.40.192.131]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/5/8 0:13, Petr Mladek wrote:
> On Thu 2021-05-06 23:07:19, Sergey Senozhatsky wrote:
>> Thanks for Cc-ing Petr
>>
>> On (21/05/06 15:39), Petr Mladek wrote:
>>> Many printk messages might get accumulated when consoles were suspended.
>>> They are proceed when console_unlock() is called in resume_console().
>>>
>>> The possibility to pass the console lock owner was added to reduce the risk
>>> of softlockup when too many messages were handled in an atomic context.
>>>
>>> Now, resume_console() is always in a preemptible context that is safe
>>> to handle all accumulated messages. The possibility to pass the console
>>> lock owner actually makes things worse. The new owner might be in an atomic
>>> context and might cause softlockup when processing all messages accumulated
>>> when the console was suspended.
>>>
>>> Create new console_unlock_preemptible() that will not allow to pass
>>> the console lock owner. As a result, all accumulated messages will
>>> be proceed in the safe preemptible process.
>> If we have a lot of pending messages in the logbuf, then there is
>> something chatty - some context (task, irq) or maybe several contexts.
>> And those contexts can continue adding messages, while we print them
>> _exclusively_ from preemptible context only. without ever throttling down
>> printk() callers - something that console_owner spinning and handover
>> does for us. And those printk() callers can even preempt
>> console_unlock_preemptible() and cause delays and lost messages.
> Luo, please, correct me if I am wrong.


Hi, Petr, I reply the test result on your first reply for this patch.

Please check it when you are free.


>
> This patch a about one well defined scenario. The messages are
> accumulated between suspend_console() and resume_console().
> It is "small" part of the system hibernation. And we need
> to get them out now. There might be many if something special
> was debugged.
>
> I am pretty sure that Luo did not see any flood of messages:
>
>     + Flood in more contexts would be balanced by switching
>       the console_owner.
>
>     + Flood in one context would be naturally throttled because
>       this context will become the console_owner.
>
> In each case, these messages would be generated after
> console_resume(). Luo's original patch was explicitly talking
> about messages accumulated during the suspend.
>
> Luo, could you please provide some log showing the problem?


Sure, But, it is not easy to find that the printk got such problem in 
the user's logs.

So I'm attaching a log of the simulation test. You can clearly see that 
the driver thread calling dev_info() is blocked.


My test method is as follows:
Kernel thread A causes the console to enter suspend and then resume it 
10 seconds later.
Kernel thread B repeatedly invokes dev_info() for 15 seconds after the 
console suspend.


Part of dmesg log I save before:

[  288.013869] hisi_sas_v3_hw 0000:b4:02.0: print test
[  288.013870] hisi_sas_v3_hw 0000:b4:02.0: print test
[  288.013871] hisi_sas_v3_hw 0000:b4:02.0: print test
[  288.013872] hisi_sas_v3_hw 0000:b4:02.0: print test
[  288.013873] hisi_sas_v3_hw 0000:b4:02.0: print test
[  288.013874] hisi_sas_v3_hw 0000:b4:02.0: print test
[  288.013875] hisi_sas_v3_hw 0000:b4:02.0: print test
[  288.013876] hisi_sas_v3_hw 0000:b4:02.0: print test
[  288.013877] hisi_sas_v3_hw 0000:b4:02.0: print test
[  289.670256] hisi_sas_v3_hw 0000:b4:02.0: print test
[  299.286325] hisi_sas_v3_hw 0000:b4:02.0: print test
[  299.291198] hisi_sas_v3_hw 0000:b4:02.0: print test
[  299.296063] hisi_sas_v3_hw 0000:b4:02.0: print test
[  299.300924] hisi_sas_v3_hw 0000:b4:02.0: print test
[  299.305787] hisi_sas_v3_hw 0000:b4:02.0: print test

The log shows that when thread B invokes dev_info, dev_info is blocked 
for several seconds.


Thanks

Jiaxing


>
> Best Regards,
> Petr
>
> .
>

