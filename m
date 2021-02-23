Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97487322A78
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 13:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbhBWMYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 07:24:52 -0500
Received: from mout.gmx.net ([212.227.15.15]:53535 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232413AbhBWMYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 07:24:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1614082954;
        bh=f7VuagnLWNDJuslV/PykFdFSFDKbqqogB4VsWkxhI74=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=V9JfXxTTRdvnBgdc3ECsIyQKyuCXIeGAQatk3yYdYZicuJuOfEYok6PdWge2tG9n4
         +zJY6yw7BcVeFBt+KYtHCm3s/oBja8o4tEhQ25OP9xx2rZgVrUaVAArc3Z4j0aNWvl
         okMD2AEMldX+g6yAROdA5vFy4cdidJHd2Em6czBE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.131.29]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mwfai-1m3SL22xfG-00y5ix; Tue, 23
 Feb 2021 13:22:34 +0100
Subject: Re: [PATCH printk-rework 08/14] printk: add syslog_lock
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org
References: <20210218081817.28849-1-john.ogness@linutronix.de>
 <20210218081817.28849-9-john.ogness@linutronix.de> <YC+9gc/IR8PzeIFf@alley>
 <875z2o15ha.fsf@jogness.linutronix.de> <8735xs10hi.fsf@jogness.linutronix.de>
 <db43de06-3183-7401-30f2-0e9302cc48e0@gmx.de> <YDPbqhi6wVwGa5rF@alley>
From:   Helge Deller <deller@gmx.de>
Message-ID: <b8ddd9e3-896f-cd9a-a340-0a7e139fee2e@gmx.de>
Date:   Tue, 23 Feb 2021 13:22:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YDPbqhi6wVwGa5rF@alley>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KQbKrAdLX33gKon7+I4fFN17Dc4ADs0s8qH33ruhDoYtNNj3HI4
 44LbvXWorrZcZG1ET4G3KElCbWUbQAxOXi/FCJiIF51nux/8q7oL8dpP90p6qaOAC495pf0
 iBL08iBCnVL2/PwNduS6tERquXfrBHU8sbEWv05Oto7Qnv/KEV9IOf1e6oXLwl3AX0uVcx4
 fU2IOBHbp08gDIPiqJU/Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:HOOeed+yBIM=:NQl5dKM2FdyGShn8WKRYJi
 jZIQzVZldyHeHzro1NlhdXWEeO92aZgE5InR/VlMyuDrevkV7uSe24sqrmE8H0hg3FhOcgAqU
 dB1ReP0erWZH9gP5amIC2WvZ2bfpKFLXOTqjmCFZl22D9Tmt5+g4KHekrkmw6hBT/i5GTpxde
 Yac7O/LrKLmCFaQdbscY5w6ZMvb+5PqTzRobwHIRo1KZqHGCZcQ3PGGnJzj43RheLkADFAoJ0
 6muxKeG22FG0d95edO+Wln8l3AU5A3MLu+RtvL+OQCB6GI30McLhsP6TcakU5UOvRyrN02pgJ
 OiQ1H6bVgbosaoAtso21VdXu/I117BFn7ckWPuXN2tyBZzsr487l5TiUND3oaSAcraa0jJyXq
 p9lR+y3XrhjRAkrs8KIH7rbaRxzIxXfbXu0HAiakpqZe7NVZC336vLh+4VIVu2MwJGDXDjDym
 6YFPDc734AglB87qOUsccBMxMss0GojQUeDWj74xRG4CL7Ptu3jAyunVM6dBE3IIur7XEaK+x
 laYmsxFiVrZ9W5I/Z1Lg0JnLjIvkLebS8mqlEzys2RIRQp8KV8Gmq5j+3MWtoNXLdgIhJDawm
 c2QoQ8NXURARwqaVa0nhlZAw6SHRcRY8sJPw1OzIcvSQ5cVW59U4dOfoo/FrROsil6a9ExwXX
 /JG2XObK4N8S7MfUOGoDLZCACZh8IeGhbONU2OlC8eVp+DAsDfMinWvyHHmswYjKer+1BPukW
 p+6O5XYVbOSfd1eRFESgV1rQf43rfl0IBuehvie9Vreu3Lsv/aJErhY6TMk0mvL82sFqxppMQ
 wzlA35Qlm/BEPzvMPuZ6B8UUmHVL3LA9dxXjLuDPD8HaAuClh+yeANfmWba4tePGeFOKx0R6J
 rladSHGlYDkpS6hLkSvg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/22/21 5:28 PM, Petr Mladek wrote:
> On Sun 2021-02-21 22:39:42, Helge Deller wrote:
>> On 2/19/21 5:33 PM, John Ogness wrote:
>>> Added CC: linux-parisc@vger.kernel.org
>>>
>>> On 2021-02-19, John Ogness <john.ogness@linutronix.de> wrote:
>>>>>> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
>>>>>> index 20c21a25143d..401df370832b 100644
>>>>>> --- a/kernel/printk/printk.c
>>>>>> +++ b/kernel/printk/printk.c
>>>>>> +/* Return a consistent copy of @syslog_seq. */
>>>>>> +static u64 read_syslog_seq_irq(void)
>>>>>> +{
>>>>>> +	u64 seq;
>>>>>> +
>>>>>> +	raw_spin_lock_irq(&syslog_lock);
>>>>>> +	seq =3D syslog_seq;
>>>>>> +	raw_spin_unlock_irq(&syslog_lock);
>>>>>
>>>>> Is there any particular reason to disable interrupts here?
>>>>>
>>>>> It would make sense only when the lock could be taken in IRQ
>>>>> context. Then we would need to always disable interrupts when
>>>>> the lock is taken. And if it is taken in IRQ context, we would
>>>>> need to safe flags.
>>>>
>>>> All other instances of locking @syslog_lock are done with interrupts
>>>> disabled. And we have:
>>>>
>>>> register_console()
>>>>     logbuf_lock_irqsave()
>>>>       raw_spin_lock(&syslog_lock)
>>>>
>>>> I suppose I need to go through all the console drivers to see if any
>>>> register in interrupt context. If not, that logbuf_lock_irqsave()
>>>> should be replaced with logbuf_lock_irq(). And then locking
>>>> @syslog_lock will not need to disable interrupts.
>>>
>>> I found a possible call chain in interrupt context. From arch/parisc
>>> there is the interrupt handler:
>>>
>>> handle_interruption(code=3D1) /* High-priority machine check (HPMC) */
>>>     pdc_console_restart()
>>>       pdc_console_init_force()
>>>         register_console()
>>>
>>> All other register_console() calls in the kernel are either during ini=
t
>>> (within __init sections and probe functions) or are clearly not in
>>> interrupt context (using mutex, kzalloc, spin_lock_irq, etc).
>>>
>>> I am not familiar with parisc, but I am assuming handle_interruption()
>>> is always called with interrupts disabled (unless the HPMC interrupt i=
s
>>> somehow an exception).
>>
>> Yes, handle_interruption() is the irq handler, running with irqs off.
>> HPMC is the crash handler - it's called when the kernel will stop
>> anyway. pdc_console is a very basic firmware console which prints
>> the last messages before the machine halts on fatal errors.
>> So, this code it's not the typical use case....
>
> Thanks for information.
>
> Is this code supposed to work only during early boot or anytime,
> please?

No.
It's only called when the kernel completely crashes, when all
spinlocks should get busted and so on.
It's the emergency way to get some info out at least.

> Note that it is not safe because register_console() takes
> console_lock() which is a sleeping lock.

As I said, in that stage the plan is to bust all spinlocks.

> That said, we are going to rework the console handling a lot. We are
> trying to remove as many locks from the printk path as possible.

That's good!

> I guess that the list of consoles will be synchronized using
> rcu at the end. But it is still a long way to go.

I'd say, that you simply should ignore this specific case here.
I'm happy to change anything there, so if you get rid of printk locks
it will benefit here too.

Helge
