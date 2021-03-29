Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA4334D8AE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 21:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbhC2T6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 15:58:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40036 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230346AbhC2T53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 15:57:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617047848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+knGWj1JRoQjG3CkINDV/1Y/KnAis1LL4QjdGvCeOD0=;
        b=GvtfPrm1o8YenB43jHOhR30ERgOB/Dn51XUbqxV0v3G+cdPmw80n/4JvgifvnXi0XKYRN2
        qY7Z3OxDmf7ZWiOI1fX85YY1x0JeGb/rh2gu5oeoUA9CtY1sQJ3KI9INE5lrTOaW2FBvha
        phyi+oEYn/xZQ9iqzcUNj1Fyq4DVxeU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506-P5hkA14UMQWwKS-yZza78g-1; Mon, 29 Mar 2021 15:57:24 -0400
X-MC-Unique: P5hkA14UMQWwKS-yZza78g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E08988030B5;
        Mon, 29 Mar 2021 19:57:22 +0000 (UTC)
Received: from llong.remote.csb (ovpn-118-139.rdu2.redhat.com [10.10.118.139])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 70AB119C45;
        Mon, 29 Mar 2021 19:57:21 +0000 (UTC)
Subject: Re: [PATCH v2] x86/apic/vector: Move pr_warn() out of vector_lock
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, David Woodhouse <dwmw@amazon.co.uk>,
        Marc Zyngier <maz@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>, x86@kernel.org,
        John Ogness <john.ogness@linutronix.de>
References: <20210329005236.1218-1-longman@redhat.com>
 <87tuoub07f.ffs@nanos.tec.linutronix.de>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <ce7250cb-2b11-7d83-56b0-00f4f6274dae@redhat.com>
Date:   Mon, 29 Mar 2021 15:57:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <87tuoub07f.ffs@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/21 8:42 AM, Thomas Gleixner wrote:
> Waiman,
>
> On Sun, Mar 28 2021 at 20:52, Waiman Long wrote:
>> It was found that the following circular locking dependency warning
>> could happen in some systems:
>>
>> [  218.097878] ======================================================
>> [  218.097879] WARNING: possible circular locking dependency detected
>> [  218.097880] 4.18.0-228.el8.x86_64+debug #1 Not tainted
> Reports have to be against latest mainline and not against the random
> distro frankenkernel of the day. That's nothing new.
>
> Plus I was asking you to provide a full splat to look at so this can be
> discussed _upfront_. Oh well...

That was the full splat that I can see except the following trailing data:

[  218.098064] RIP: 0033:0x7ff4ee7620d6
[  218.098066] Code: 89 54 24 08 e8 9b f4 ff ff 8b 74 24 0c 48 8b 3c 24 
41 89 c0 44 8b 54 24 08 b8 01 01 00 00 89 f2 48 89 fe bf 9c ff ff ff 0f 
05 <48> 3d 00 f0 ff ff 77 30 44 89 c7 89 44 24 08 e8 c6 f4 ff ff 8b 44
[  218.098067] RSP: 002b:00007ffdda1116a0 EFLAGS: 00000293 ORIG_RAX: 
0000000000000101
[  218.098069] RAX: ffffffffffffffda RBX: 0000564733953f70 RCX: 
00007ff4ee7620d6
[  218.098070] RDX: 0000000000080902 RSI: 00005647339560e0 RDI: 
00000000ffffff9c
[  218.098071] RBP: 0000000000000015 R08: 0000000000000000 R09: 
000000000000004b
[  218.098072] R10: 0000000000000000 R11: 0000000000000293 R12: 
0000000000080902
[  218.098074] R13: 00005647339560e0 R14: 0000564733953a90 R15: 
0000000000000002
[  218.098460] irq 3: Affinity broken due to vector space exhaustion.


>> [  218.097914] -> #2 (&irq_desc_lock_class){-.-.}:
>> [  218.097917]        _raw_spin_lock_irqsave+0x48/0x81
>> [  218.097918]        __irq_get_desc_lock+0xcf/0x140
>> [  218.097919]        __dble_irq_nosync+0x6e/0x110
> This function does not even exist in mainline and never existed...
>
>> [  218.097967]
>> [  218.097967] Chain exists of:
>> [  218.097968]   console_oc_lock_class --> vector_lock
>> [  218.097972]
>> [  218.097973]  Possible unsafe locking scenario:
>> [  218.097973]
>> [  218.097974]        CPU0                    CPU1
>> [  218.097975]        ----                    ----
>> [  218.097975]   lock(vector_lock);
>> [  218.097977]                                lock(&irq_desc_lock_class);
>> [  218.097980]                                lock(vector_lock);
>> [  218.097981]   lock(console_owner);
>> [  218.097983]
>> [  218.097984]  *** DEADLOCK ***
>> [  218.097984]
>> [  218.097985] 6 locks held by systemd/1:
>> [  218.097986]  #0: ffff88822b5cc1e8 (&tty->legacy_mutex){+.+.}, at: tty_init_dev+0x79/0x440
>> [  218.097989]  #1: ffff88832ee00770 (&port->mutex){+.+.}, at: tty_port_open+0x85/0x190
>> [  218.097993]  #2: ffff88813be85a88 (&desc->request_mutex){+.+.}, at: __setup_irq+0x249/0x1e60
>> [  218.097996]  #3: ffff88813be858c0 (&irq_desc_lock_class){-.-.}, at: __setup_irq+0x2d9/0x1e60
>> [  218.098000]  #4: ffffffff84afca78 (vector_lock){-.-.}, at: x86_vector_activate+0xca/0xab0
>> [  218.098003]  #5: ffffffff84c27e20 (console_lock){+.+.}, at: vprintk_emit+0x13a/0x450
> This is a more fundamental problem than just vector lock and the same
> problem exists with any other printk over serial which is nested in the
> interrupt activation chain not only on X86.

That is true. This problem is more generic than just that. I am hoping 
that the new printk rewrite may address this problem. I have been 
waiting for a while and that work is still not upstream yet. So what is 
your current timeline for that? If that will happen soon, I probably 
don't need this patch. I send this patch out as I am uncertain about it.


>> -static int activate_reserved(struct irq_data *irqd)
>> +static int activate_reserved(struct irq_data *irqd, char *wbuf, size_t wsize)
>>   {
> ...
>
>>   	if (!cpumask_subset(irq_data_get_effective_affinity_mask(irqd),
>>   			    irq_data_get_affinity_mask(irqd))) {
>> -		pr_warn("irq %u: Affinity broken due to vector space exhaustion.\n",
>> -			irqd->irq);
>> +		snprintf(wbuf, wsize, KERN_WARNING
>> +			 "irq %u: Affinity broken due to vector space exhaustion.\n",
>> +			 irqd->irq);
> This is not really any more tasteful than the previous one and it does
> not fix the fundamental underlying problem.
>
> But, because I'm curious and printk is a constant source of trouble, I
> just added unconditional pr_warns into those functions under vector_lock
> on 5.12-rc5.
>
> Still waiting for the lockdep splat to show up while enjoying the
> trickle of printks over serial.
>
> If you really think this is an upstream problem then please provide a
> corresponding lockdep splat on plain 5.12-rc5 along with a .config and
> the scenario which triggers this. Not less, not more.

I will try to reproduce this problem with an upstream kernel.

Thanks,
Longman

