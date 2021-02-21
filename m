Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8E6320E0A
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 22:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbhBUVmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 16:42:07 -0500
Received: from mout.gmx.net ([212.227.15.19]:54621 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230174AbhBUVmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 16:42:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1613943592;
        bh=GJ6uw/0QQ/OVNc65IgAoS6Y2h50ncWbM79nTeMI1iak=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=VQHMI0rbaopv2BK3GOH1NvgchTziZmVDV2KjQJcJsl4ho5/ZqKf8mNihIQj2/LNoW
         eTllZWf8nvyrfoAo56nB0+K5At8y5twf1vbSjEwt4cQAr0g3dpZnOgSc7Pq3+7pq4T
         rFJGcB9GLPnMnBy/VgKvn2aYX0M7JBCnSID5pQ1U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.180.210]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MysRk-1lzZ2A377S-00w04p; Sun, 21
 Feb 2021 22:39:52 +0100
Subject: Re: [PATCH printk-rework 08/14] printk: add syslog_lock
To:     John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org
References: <20210218081817.28849-1-john.ogness@linutronix.de>
 <20210218081817.28849-9-john.ogness@linutronix.de> <YC+9gc/IR8PzeIFf@alley>
 <875z2o15ha.fsf@jogness.linutronix.de> <8735xs10hi.fsf@jogness.linutronix.de>
From:   Helge Deller <deller@gmx.de>
Message-ID: <db43de06-3183-7401-30f2-0e9302cc48e0@gmx.de>
Date:   Sun, 21 Feb 2021 22:39:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <8735xs10hi.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZJ1Cbc0FtNCQZ2qqu85yNIzy18fhbaTtZ6/w9nBlBYX0j9pTsBd
 hzZIewj/8kKVHUdKawH57LsnkNnph8DH2flFeTAFRYr7et8SspfbG5mw8LfcKGcO53qENTw
 eCYcKNyUSZ01azyb5rK5ov/u3GHOEJ1iJKE9K6kZv+RoGjjQsz68NIbikMMiY5NcpUjbF/Q
 /EoOb3UEm9CPyWLkhwDMQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7TKuTg6RX28=:sn3V7rBz/l8uNG6KlRcMjo
 PxNl/UCxqVVYqRue+n0AudXo8F2n/UFQLbvmqFvsvdBQVv/FiHqfLNMf95ffFfYKmQLgDJ0MD
 HlWTM193xsNlgXDiXWoqPZPWt9XsFyKHCDaLTuAMbJL2WgDE3D2C/JN9AMDBVxlgX6iPDEvoq
 9tDDRlrlFbSWY55/Hgri5cW+EIfiY5qC36l9zrqbcz97obhiXDrkOK2L35oqgweFFr2bR8yy5
 8+l5v5s3Zh6DM+56OwvZOY1nM6I2EH4FLVWfaUt79DfCWSZwTR1KgHi/YubjIsCTQ3KnVsDwt
 bFcVnnNi+AVTGoXLqvjeS/mlrsuDMqNtW86qc7wkLnVsE81xW13EswMz6wSlZlNbLauAQVuYg
 viUfxfv+X1ZmTAKSg6pyblW7ulYkfEd9Ea2Qab9HVyupxR2JDD5W4pRy/X9drudQJnoMc5qDQ
 tMjNQzWcB+IxS+jQOmacnDVVIAsWd+ODlIILdmd4y/tVy4E3HLVf3t6vuhPYwMWXXxgtGaaU2
 uZ8t6k7enkf4xdeeu7mUgaNS2OYirzv427TEJEOKlPVT3KAccQLsDmfEwKazh643AVB030V7U
 oBTzLi1NmMTH1mJGRdb51dmqaWFU4bnKqzPSKmU2bG0Y8un4eRs+Y0avAEJk2G16BQ9xm8Gx2
 Pev+rGXgbkeWvnEtMFlh/WGPmT7wkxbwv6fHOSQILCy5ekLjv7z1Ud4y12kn4aR+9YR5NSzl1
 +q+iWP/+LKQbubAkp2Zmxe8heW/GXNXMZi79JPnyfOsQ/jYn2I9FfRL2LJRRaoq/ofkIJL7bZ
 ohsKLgUtnCN2rjyq9rLgieW5Dmk26qo/x2M6Pxq1F+Gn/lUYa7iXss5VbGgyakIYSIXjh8vBZ
 B4/diUZUCq0eItRue8kw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/19/21 5:33 PM, John Ogness wrote:
> Added CC: linux-parisc@vger.kernel.org
>
> On 2021-02-19, John Ogness <john.ogness@linutronix.de> wrote:
>>>> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
>>>> index 20c21a25143d..401df370832b 100644
>>>> --- a/kernel/printk/printk.c
>>>> +++ b/kernel/printk/printk.c
>>>> +/* Return a consistent copy of @syslog_seq. */
>>>> +static u64 read_syslog_seq_irq(void)
>>>> +{
>>>> +	u64 seq;
>>>> +
>>>> +	raw_spin_lock_irq(&syslog_lock);
>>>> +	seq =3D syslog_seq;
>>>> +	raw_spin_unlock_irq(&syslog_lock);
>>>
>>> Is there any particular reason to disable interrupts here?
>>>
>>> It would make sense only when the lock could be taken in IRQ
>>> context. Then we would need to always disable interrupts when
>>> the lock is taken. And if it is taken in IRQ context, we would
>>> need to safe flags.
>>
>> All other instances of locking @syslog_lock are done with interrupts
>> disabled. And we have:
>>
>> register_console()
>>    logbuf_lock_irqsave()
>>      raw_spin_lock(&syslog_lock)
>>
>> I suppose I need to go through all the console drivers to see if any
>> register in interrupt context. If not, that logbuf_lock_irqsave()
>> should be replaced with logbuf_lock_irq(). And then locking
>> @syslog_lock will not need to disable interrupts.
>
> I found a possible call chain in interrupt context. From arch/parisc
> there is the interrupt handler:
>
> handle_interruption(code=3D1) /* High-priority machine check (HPMC) */
>    pdc_console_restart()
>      pdc_console_init_force()
>        register_console()
>
> All other register_console() calls in the kernel are either during init
> (within __init sections and probe functions) or are clearly not in
> interrupt context (using mutex, kzalloc, spin_lock_irq, etc).
>
> I am not familiar with parisc, but I am assuming handle_interruption()
> is always called with interrupts disabled (unless the HPMC interrupt is
> somehow an exception).

Yes, handle_interruption() is the irq handler, running with irqs off.
HPMC is the crash handler - it's called when the kernel will stop
anyway. pdc_console is a very basic firmware console which prints
the last messages before the machine halts on fatal errors.
So, this code it's not the typical use case....

Helge
