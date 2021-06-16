Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64E253A9C3F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 15:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233528AbhFPNml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 09:42:41 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41862 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233406AbhFPNmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 09:42:10 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623850803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8l42JwcJEAAq1B3qSVKToK5LAryzVIpVDxEMtbe7pe8=;
        b=GQ9//uTEfzztb0BjI2qXqjGOLHRtg+nwxYGJ4Bz9nJ7tod+6u1cV3xp6FZQEKinJAtYghC
        5PVsJO5qp4em+aaXyNTPSMdzuCSnbisJcfkA7l25z9glqHvXuwWS47FSttviCL06tTOfFb
        vNmdNHYq4Ej6hY3GSwtHJ78NtmQUre7vECmw18/W+e8AsimuemvYXYm7JcH4xVoyLkf/jw
        Q1XNPWCvMiPvZ8g0Uu8xNqZQVTDclghV7FM15Qn11ywcdoA9seUuqJIINqhZD1+pQLqBRX
        V5YeOd9avD5j1ufyW3nV43M5NW2DxSzCyNf+lpYdGqSMLRFOvC1jQQClsUvlJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623850803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8l42JwcJEAAq1B3qSVKToK5LAryzVIpVDxEMtbe7pe8=;
        b=yr3UePZnsGzdNitiq+u1pnRcja1r/Yfgnd/xHjjZVo+cr0CLXsfFmkk7cmdkJWaFkeKbDG
        U+RomtsrbPOd3lAQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH next v3 1/2] dump_stack: move cpu lock to printk.c
In-Reply-To: <YMnenOBTUclLld9i@alley>
References: <20210615174947.32057-1-john.ogness@linutronix.de> <20210615174947.32057-2-john.ogness@linutronix.de> <8735tiq0d8.fsf@jogness.linutronix.de> <YMmi5xoTOb82TKtJ@google.com> <87mtrqnu74.fsf@jogness.linutronix.de> <YMnenOBTUclLld9i@alley>
Date:   Wed, 16 Jun 2021 15:46:02 +0206
Message-ID: <877diund1p.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-16, Petr Mladek <pmladek@suse.com> wrote:
>> With this series version I moved the tracking into a global variable
>> @printk_cpulock_nested, which is fine, except that a boolean is not
>> capable of tracking more than 1 nesting. Which means that
>> __printk_cpu_unlock() would release cpu lock ownership too soon.
>> 
>> Doing this correctly is a simple change:
>> 
>> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
>> index e67dc510fa1b..5376216e4f3d 100644
>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> @@ -3535,7 +3535,7 @@ EXPORT_SYMBOL_GPL(kmsg_dump_rewind);
>>  
>>  #ifdef CONFIG_SMP
>>  static atomic_t printk_cpulock_owner = ATOMIC_INIT(-1);
>> -static bool printk_cpulock_nested;
>> +static atomic_t printk_cpulock_nested = ATOMIC_INIT(0);
>>  
>>  /**
>>   * __printk_wait_on_cpu_lock() - Busy wait until the printk cpu-reentrant
>> @@ -3596,7 +3598,7 @@ int __printk_cpu_trylock(void)
>>  
>>  	} else if (old == cpu) {
>>  		/* This CPU is already the owner. */
>> -		printk_cpulock_nested = true;
>> +		atomic_inc(&printk_cpulock_nested);
>>  		return 1;
>>  	}
>>  
>> @@ -3613,8 +3615,8 @@ EXPORT_SYMBOL(__printk_cpu_trylock);
>>   */
>>  void __printk_cpu_unlock(void)
>>  {
>> -	if (printk_cpulock_nested) {
>> -		printk_cpulock_nested = false;
>> +	if (atomic_read(&printk_cpulock_nested)) {
>> +		atomic_dec(&printk_cpulock_nested);
>
> I think about handling printk_cpulock_nested with only one
> atomic operation. Something like:
>
> 	if (atomic_dec_return(&printk_cpulock_level) == 0)
> 		atomic_set_release(&printk_cpulock_owner, -1);
>
> It would require always incremanting the number in lock, e.g.
>
> 	old = atomic_cmpxchg(&printk_cpulock_owner, -1, cpu);
> 	if (old == -1 || old == cpu) {
> 		atomic_inc(&printk_cpulock_level);
> 		return 1;
> 	}

I actually implemented similar code during an internal draft. I later
decided against it, mainly because I prefer to keep the old==-1 and
old==cpu cases separate.

Also note that atomic_dec_return() introduces an unnecessary memory
barrier. If we take your proposed implementation we would use
atomic_dec_return_relaxed() instead.

> But I am not sure if it is really better. Feel free to keep
> your variant.

*sigh* Frankly, I don't care much. My variant saves a few CPU
instructions for the normal case (non-nested), but that probably is not
much of an argument.

For v4 I will keep my variant because it explicitly handles the
non-nested/nested cases separately, which helps when adding the memory
barrier comments in the follow-up patch. In particular, the label
LMM(__printk_cpu_trylock:B), which represents the first moment a new CPU
begins to load/store data, only applies to the old==-1 condition.

John Ogness
