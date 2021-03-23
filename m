Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05818346B1A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 22:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233504AbhCWVcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 17:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233607AbhCWVcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 17:32:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515B7C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 14:32:04 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616535121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BJrUa06w/c8dTdM2MLKJTDsGbSbOPx0icN/AfO8mLAw=;
        b=2i3ag7FDUWKZ/KRIm0gJzSV6XTbqc3bDAE9eHeDXlnqsb0XuLn/0Dt6qy9yVXWumJvE9HA
        i1HzUInPVX3M2NA20+NpGv4i3DCbHLGwjnH0x2gPtLtJgMOvmI7SWY6To4VBxyzjjDaqY8
        4xrzjTfHMeL/d3rfrtRDzFko05A0wqccEdfbiOVTghux74MK0yPqQZiFFAEjzbe653wS2K
        bhQoXv1CQR1MpKUg+ABdlxQMJZlqDDi8qLCgWWWAwSCCVjn129AYMXpuw4bu9v8EapUUXw
        sDEbipPMFlVDqNEV3bEiycqShqQUtkTVTWFj2gUT1OTXDAULCG3mQn6g0tde0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616535121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BJrUa06w/c8dTdM2MLKJTDsGbSbOPx0icN/AfO8mLAw=;
        b=+5b/oKDfAWBlGMOn2ANolqucGuSLwWt3xvVDakrBMCjgq56cphMjU2n/uCbsBaNH7gndC5
        md6FiEvOePNew8Bw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH next v1 1/3] printk: track/limit recursion
In-Reply-To: <YFiuf/Kn9iLOwgNx@alley>
References: <20210316233326.10778-1-john.ogness@linutronix.de> <20210316233326.10778-2-john.ogness@linutronix.de> <YFiuf/Kn9iLOwgNx@alley>
Date:   Tue, 23 Mar 2021 22:32:00 +0100
Message-ID: <87czvp7e0f.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-03-22, Petr Mladek <pmladek@suse.com> wrote:
> On Wed 2021-03-17 00:33:24, John Ogness wrote:
>> Track printk() recursion and limit it to 3 levels per-CPU and per-context.
>
> Please, explain why it is added. I mean that it will
> allow remove printk_safe that provides recursion protection at the
> moment.

OK.

>> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
>> index 2f829fbf0a13..c666e3e43f0c 100644
>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> @@ -1940,6 +1940,71 @@ static void call_console_drivers(const char *ext_text, size_t ext_len,
>>  	}
>>  }
>>  
>> +/*
>> + * Recursion is tracked separately on each CPU. If NMIs are supported, an
>> + * additional NMI context per CPU is also separately tracked. Until per-CPU
>> + * is available, a separate "early tracking" is performed.
>> + */
>> +#ifdef CONFIG_PRINTK_NMI
>
> CONFIG_PRINTK_NMI is a shortcut for CONFIG_PRINTK && CONFIG_HAVE_NMI.
> It should be possible to use CONFIG_HAVE_NMI here because this should
> be in section where CONFIG_PRINTK is defined.
>
> This would make sense if it allows to remove CONFIG_PRINTK_NMI
> entirely. IMHO, it would be nice to remove one layer in the
> config options of possible.

OK. I will remove CONFIG_PRINTK_NMI for v2.

>> +#define PRINTK_CTX_NUM 2
>> +#else
>> +#define PRINTK_CTX_NUM 1
>> +#endif
>> +static DEFINE_PER_CPU(char [PRINTK_CTX_NUM], printk_count);
>> +static char printk_count_early[PRINTK_CTX_NUM];
>> +
>> +/*
>> + * Recursion is limited to keep the output sane. printk() should not require
>> + * more than 1 level of recursion (allowing, for example, printk() to trigger
>> + * a WARN), but a higher value is used in case some printk-internal errors
>> + * exist, such as the ringbuffer validation checks failing.
>> + */
>> +#define PRINTK_MAX_RECURSION 3
>> +
>> +/* Return a pointer to the dedicated counter for the CPU+context of the caller. */
>> +static char *printk_recursion_counter(void)
>> +{
>> +	int ctx = 0;
>> +
>> +#ifdef CONFIG_PRINTK_NMI
>> +	if (in_nmi())
>> +		ctx = 1;
>> +#endif
>> +	if (!printk_percpu_data_ready())
>> +		return &printk_count_early[ctx];
>> +	return &((*this_cpu_ptr(&printk_count))[ctx]);
>> +}
>
> It is not a big deal. But using an array for two contexts looks strange
> especially when only one is used on some architectures.
> Also &((*this_cpu_ptr(&printk_count))[ctx]) is quite tricky ;-)
>
> What do you think about the following, please?
>
> static DEFINE_PER_CPU(u8 printk_count);
> static u8 printk_count_early;
>
> #ifdef CONFIG_HAVE_NMI
> static DEFINE_PER_CPU(u8 printk_count_nmi);
> static u8 printk_count_nmi_early;
> #endif
>
> static u8 *printk_recursion_counter(void)
> {
> 	if (IS_ENABLED(CONFIG_HAVE_NMI) && in_nmi()) {
> 		if (printk_cpu_data_ready())
> 			return this_cpu_ptr(&printk_count_nmi);
> 		return printk_count_nmi_early;
> 	}
>
> 	if (printk_cpu_data_ready())
> 		return this_cpu_ptr(&printk_count);
> 	return printk_count_early;
> }

I can split it into explicit variables. But is the use of the IS_ENABLED
macro preferred over ifdef? I would prefer:

static u8 *printk_recursion_counter(void)
{
#ifdef CONFIG_HAVE_NMI
	if (in_nmi()) {
		if (printk_cpu_data_ready())
			return this_cpu_ptr(&printk_count_nmi);
		return printk_count_nmi_early;
	}
#endif
	if (printk_cpu_data_ready())
		return this_cpu_ptr(&printk_count);
	return printk_count_early;
}

Since @printk_count_nmi and @printk_count_nmi_early would not exist, I
would prefer the pre-processor removes that code block rather than
relying on compiler optimization.

John Ogness
