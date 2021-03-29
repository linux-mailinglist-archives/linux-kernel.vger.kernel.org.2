Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 237D734C0A8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 02:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbhC2Ase (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 20:48:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21368 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229656AbhC2As0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 20:48:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616978905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HhRejdT28MmQipBzPazGW9STgpVrKQAwSUx2IuiDgnA=;
        b=KsIK252G5va0FQCggTdnHVGXPeZUhk6HqI8I+uemm+vm+KiNO3oA86q7asSPBbV7w6hwi+
        YVieTuTpFy0X5tS02L5Tal4RSMRgjIqdX1gePlJhP3wVvyBCOYmsBmh1K2DBueKUuNyW2Y
        ROO6mCT9jt/n8XxzJuIB20gaf7+Adhk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-AMiUwyUyP2aQxF2SRw5_tg-1; Sun, 28 Mar 2021 20:48:21 -0400
X-MC-Unique: AMiUwyUyP2aQxF2SRw5_tg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B0CF180FCA0;
        Mon, 29 Mar 2021 00:48:19 +0000 (UTC)
Received: from llong.remote.csb (unknown [10.22.8.14])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1B43A5D768;
        Mon, 29 Mar 2021 00:48:17 +0000 (UTC)
Subject: Re: [PATCH] x86/apic/vector: Move pr_warn() outside of vector_lock
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, David Woodhouse <dwmw@amazon.co.uk>,
        Marc Zyngier <maz@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
References: <20210328195811.32109-1-longman@redhat.com>
 <871rbzc4ul.ffs@nanos.tec.linutronix.de>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <36fcb881-239c-38e7-081b-918c5310ef99@redhat.com>
Date:   Sun, 28 Mar 2021 20:48:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <871rbzc4ul.ffs@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/28/21 6:04 PM, Thomas Gleixner wrote:
> Waiman,
>
> On Sun, Mar 28 2021 at 15:58, Waiman Long wrote:
>> It was found that the following circular locking dependency warning
>> could happen in some systems:
>>
>> [  218.097878] ======================================================
>> [  218.097879] WARNING: possible circular locking dependency detected
>> [  218.097880] 4.18.0-228.el8.x86_64+debug #1 Not tainted
>> [  218.097881] ------------------------------------------------------
>> [  218.097882] systemd/1 is trying to acquire lock:
>> [  218.097883] ffffffff84c27920 (console_owner){-.-.}, at: console_unlock+0x3fb/0x9f0
>> [  218.097886]
>> [  218.097887] but task is already holding lock:
>> [  218.097888] ffffffff84afca78 (vector_lock){-.-.}, at: x86_vector_activate+0xca/0xab0
>> [  218.097891]
>> [  218.097892] which lock already depends on the new lock.
>>      :
>> [  218.097966] other info that might help us debug this:
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
> can you please post the full lockdep output?

Will do.


>> This lockdep warning was causing by printing of the warning message:
>>
>> [  218.095152] irq 3: Affinity broken due to vector space exhaustion.
>>
>> It looks that this warning message is relatively more common than
>> the other warnings in arch/x86/kernel/apic/vector.c. To avoid this
>> potential deadlock scenario, this patch moves all the pr_warn() calls
>> in the vector.c file outside of the vector_lock critical sections.
> Definitely not.
>
>> -static int activate_reserved(struct irq_data *irqd)
>> +static int activate_reserved(struct irq_data *irqd, unsigned long flags,
>> +			     bool *unlocked)
>>   {
>>   	struct apic_chip_data *apicd = apic_chip_data(irqd);
>>   	int ret;
>> @@ -410,6 +411,8 @@ static int activate_reserved(struct irq_data *irqd)
>>   	 */
>>   	if (!cpumask_subset(irq_data_get_effective_affinity_mask(irqd),
>>   			    irq_data_get_affinity_mask(irqd))) {
>> +		raw_spin_unlock_irqrestore(&vector_lock, flags);
>> +		*unlocked = true;
> What?
>
>>   		pr_warn("irq %u: Affinity broken due to vector space exhaustion.\n",
>>   			irqd->irq);
>>   	}
>> @@ -446,6 +449,7 @@ static int x86_vector_activate(struct irq_domain *dom, struct irq_data *irqd,
>>   {
>>   	struct apic_chip_data *apicd = apic_chip_data(irqd);
>>   	unsigned long flags;
>> +	bool unlocked = false;
>>   	int ret = 0;
>>   
>>   	trace_vector_activate(irqd->irq, apicd->is_managed,
>> @@ -459,8 +463,9 @@ static int x86_vector_activate(struct irq_domain *dom, struct irq_data *irqd,
>>   	else if (apicd->is_managed)
>>   		ret = activate_managed(irqd);
>>   	else if (apicd->has_reserved)
>> -		ret = activate_reserved(irqd);
>> -	raw_spin_unlock_irqrestore(&vector_lock, flags);
>> +		ret = activate_reserved(irqd, flags, &unlocked);
>> +	if (!unlocked)
>> +		raw_spin_unlock_irqrestore(&vector_lock, flags);
> Even moar what?
>
>>   	return ret;
>>   }
> This turns that code into complete unreadable gunk. No way.

I am sorry that this part of the patch is sloppy. I will revise it to 
make it better.

Cheers,
Longman


