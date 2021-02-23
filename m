Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE55322CC2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 15:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233075AbhBWOsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 09:48:19 -0500
Received: from mout.gmx.net ([212.227.15.19]:59339 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232553AbhBWOsN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 09:48:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1614091564;
        bh=zxnMH3kQfAmn6A4bjMLcgvD+U/7mgtPr2Oy8ZiauVZY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=fKeTJewAXSZdAnfaN3nHEwGToZZj3hyq1FR3iVyYt4kJebVx9iahOsvMK9aBu7dkV
         tH44oQxUuInADJwqrEx6JFSfM0lelTJYI5ngRaTYjqZ2A7po4fqjYREgrRsoiNhtVv
         9IY0e5KY/SNLCNChvr+bPnawj9I8VmFZpnGn5A8E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.131.29]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MEm2D-1l3rhX16br-00GKpC; Tue, 23
 Feb 2021 15:46:04 +0100
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
 <b8ddd9e3-896f-cd9a-a340-0a7e139fee2e@gmx.de> <YDUP5J+AJwYjx5P4@alley>
From:   Helge Deller <deller@gmx.de>
Message-ID: <101aee06-2f7a-0c3a-44a1-449cba7ad7c1@gmx.de>
Date:   Tue, 23 Feb 2021 15:45:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YDUP5J+AJwYjx5P4@alley>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ki7LJbzXBWBcf8Jf6eWnuFKb/BOChLAp7DyI3df7shFJ3vN11fw
 wap/wJgYDPUBkygvFvEv71n8TbbItjgcrcaNl2O9IiHS6Lasno+/KPv5aUxWaFZQ+BL48nu
 J6h1oEflriWd7UZ9W+X1+CEgZtenghoF1xGzWi9Ophnisi9LOiVYO9f8qjThNVL0QPEiz8l
 LHdIvLK3AMxg5kIgIZ6Hw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0JSW2m71b0I=:Ei0yOA7ciLnsyVR9bU5kEG
 uc6+9BWNOMV8Drc6QKJVfTfR3THpAdCH1L090hgkXn868Xi42PGd+9sB1GMSD5FV/SitnI6Hy
 /ImVrfGe09BQZtI7A9eoXLFjwWDWZayRD0c4rQTIhrBa0tWUJg2WRJTQCTl0nUJ3W6EteXNX4
 hBdBvj4WoxZ20/upkBjsB83sBIX+pBVh3sPfgdmxjtCuMLiGp6hI+WpxAIV4OmvHtrba4D0Ik
 1latMmCHUY68WO5/TmAUpvxh06CsgHpKBNgkOF5UXvJ2Wtxaf1MCadzxWC3/dJs3p6fGWnnDw
 dUy1r/bOK6pEfTf2dl0wJVR9d6YDflyZW1USRZEAYA1cuW5umf0LGKanT3igNM0axfo6TiK2O
 RdCThuFh4peR/EzLns5I8qyAmM5SaC6ikDCQg5AE58gjkxh6H1zPKX2y0wWrRVWopwOt5aCpl
 QviEVx7O9ZOE8MuWf7JfFTu46pod7DQqT//DTjtWkMC9OVVxGO+5OHNYyZGkXicuunROyUhg9
 jsq9UTrAQYEbV/qt69b+6Fn3dEAwSIGN1EN9ktfqSmXVHHBPjKA0RKLIMYyzaruduZP7ve8W+
 bG/QHGjThcYto/xHrnebGiWSiwdK2nS5vkcp1zosWEduk88AHs/Qfz52TnSg6siDdDZYjYW4H
 UuG+DfQMj3uPDwczhfP+jO+PJnVtbvhtKvVZWykRA3/1BV5zLBkm/GXn7aApNiIlT888X85hZ
 onSBT57twHGPj7O+xF+vY124jsROuXISn7PVjm07BYVFPr0KXIQnO7Z02gRDYNnqvjXlF8Sv/
 VnFmXoBGq4mcqGxpIYVnmrgVmcE120ujFyxBtckE31guHyGSWmKlZWmhMl1oxER5yU1XEbUEw
 IKhyN4Ossuw4GMbHVl0w==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/23/21 3:23 PM, Petr Mladek wrote:
> On Tue 2021-02-23 13:22:22, Helge Deller wrote:
>> On 2/22/21 5:28 PM, Petr Mladek wrote:
>>> On Sun 2021-02-21 22:39:42, Helge Deller wrote:
>>>> On 2/19/21 5:33 PM, John Ogness wrote:
>>>>> Added CC: linux-parisc@vger.kernel.org
>>>>>
>>>>> On 2021-02-19, John Ogness <john.ogness@linutronix.de> wrote:
>>>>>>>> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
>>>>>>>> index 20c21a25143d..401df370832b 100644
>>>>>>>> --- a/kernel/printk/printk.c
>>>>>>>> +++ b/kernel/printk/printk.c
>>>>>>>> +/* Return a consistent copy of @syslog_seq. */
>>>>>>>> +static u64 read_syslog_seq_irq(void)
>>>>>>>> +{
>>>>>>>> +	u64 seq;
>>>>>>>> +
>>>>>>>> +	raw_spin_lock_irq(&syslog_lock);
>>>>>>>> +	seq =3D syslog_seq;
>>>>>>>> +	raw_spin_unlock_irq(&syslog_lock);
>>>>>>>
>>>>>>> Is there any particular reason to disable interrupts here?
>>>>>>>
>>>>> I found a possible call chain in interrupt context. From arch/parisc
>>>>> there is the interrupt handler:
>>>>>
>>>> Yes, handle_interruption() is the irq handler, running with irqs off.
>>>> HPMC is the crash handler - it's called when the kernel will stop
>>>> anyway. pdc_console is a very basic firmware console which prints
>>>> the last messages before the machine halts on fatal errors.
>>>> So, this code it's not the typical use case....
>>>
>>> Thanks for information.
>>>
>>> Is this code supposed to work only during early boot or anytime,
>>> please?
>>
>> No.
>> It's only called when the kernel completely crashes, when all
>> spinlocks should get busted and so on.
>> It's the emergency way to get some info out at least.
>
> OK.
>
>>> Note that it is not safe because register_console() takes
>>> console_lock() which is a sleeping lock.
>>
>> As I said, in that stage the plan is to bust all spinlocks.
>
> Just to be sure. Note that that register_console() does not bust
> console_lock in panic.

Ok.

> bust_spinlocks() just increments oops_in_progress counter. It has
> effect only when the caller checks this variable and use trylock
> when it is set. For example, see serial8250_console_write():
>
> void serial8250_console_write(struct uart_8250_port *up, const char *s,
> 			      unsigned int count)
> {
> 	int locked =3D 1;
>
> 	if (oops_in_progress)
> 		locked =3D spin_trylock_irqsave(&port->lock, flags);
> 	else
> 		spin_lock_irqsave(&port->lock, flags);
>
>
> 	...
>
>
> 	if (locked)
> 		spin_unlock_irqrestore(&port->lock, flags);
> }
>
> register_console() does not check oops_in_progress at the moment
> and might get blocked on console_sem.
>
> We could add the checks for oops_in_progress into register_console().
> But I am not sure if it is worth it.

It's not worth it just because of parisc.
I haven't seen any such crash in years, so the current implementation
is probably untested and outdated.

> It seems that you used this code for ages. The risk of the deadlock
> is small. It likely works most of the time. The upcoming printk rework
> should allow a cleaner solution.

Yes, it would be great if you can include such a "hard-panic/crash-dump-ca=
se"
in the rework.

Helge
