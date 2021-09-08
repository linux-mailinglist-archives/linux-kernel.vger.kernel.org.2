Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B985403D60
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 18:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347390AbhIHQKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 12:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244084AbhIHQK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 12:10:29 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0C8C061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 09:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=SrlxeFyg4nF0sdqGq5eyJXwhHLLH7AV+8KFmLDCTE4w=; b=kfDAkF+xPH+xZSCKvQ7l4UeHgi
        mBBshVxoYBj8sfj0wjlQjOSP6bgioLhHDlgA7gy8CYVTnppI+c5fJLqH83itDewHLx7uSi6aevcQ4
        qUrpGW3FQ9GXeYSeGJGDwYRQ+fX2Csm8zhG+zqT0/iG5NvZ5/kkja6BIf6TYgyuWyKlv/2gzGWgGs
        cd34c5nrCXZvVRMJcWDa3Xt+YB6f7XgkQYxej22rgZD3wiN6MhbH/8sv7dzg0xb+T5Mo9GkgyrIzy
        1M4IuRI5J0NrdE6urkrFXfHF6c3Da1ypkpf0gPvr6m062u9d+LIDvwA35cKXe5opYgIYgVcNPbo5J
        WYfJITUw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mO08W-007BL5-9H; Wed, 08 Sep 2021 16:09:20 +0000
Subject: Re: [PATCH] trace/osnoise: Do not use 'main' as variable name
To:     Steven Rostedt <rostedt@goodmis.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20210908151407.217052-1-linux@roeck-us.net>
 <20210908115350.555941ba@oasis.local.home>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b1e0f3f1-2679-9dcc-bbcd-3c35f8b5c260@infradead.org>
Date:   Wed, 8 Sep 2021 09:09:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210908115350.555941ba@oasis.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/21 8:53 AM, Steven Rostedt wrote:
> On Wed,  8 Sep 2021 08:14:07 -0700
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
>> gcc 11.x may get a hiccup when encountering 'main' as variable name.
>>
>> kernel/trace/trace_osnoise.c: In function 'start_kthread':
>> kernel/trace/trace_osnoise.c:1515:8: error: 'main' is usually a function
>>
>> Use a different variable name to silence it.
> 
> Egad, no. NACK! Double NACK. Linus already NACK'd this.
> 
> (although it's ironic that he also added -Werror as the default :-/ )
> 
> The bug in is in gcc, go send them a patch.
> 
> THERE IS NO ISSUE WITH HAVING A LOCAL VARIABLE NAMED "main"!!!!
> 
> This has already been discussed:
> 
>    https://lore.kernel.org/all/CAHk-=whHxeUjaNrWOLb0qx=-nibRZzQomwkw9xMPH_aHCf=BWQ@mail.gmail.com/
> 
> For now, the workaround is this patch:
> 
>     https://lore.kernel.org/all/20210813224131.25803-1-rdunlap@infradead.org/
> 
> 
> -- Steve
> 
> 
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   kernel/trace/trace_osnoise.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
>> index 65b08b8e5bf8..7a4c73b4fdcf 100644
>> --- a/kernel/trace/trace_osnoise.c
>> +++ b/kernel/trace/trace_osnoise.c
>> @@ -1512,20 +1512,20 @@ static void stop_per_cpu_kthreads(void)
>>   static int start_kthread(unsigned int cpu)
>>   {
>>   	struct task_struct *kthread;
>> -	void *main = osnoise_main;
>> +	void *func = osnoise_main;
>>   	char comm[24];
>>   
>>   #ifdef CONFIG_TIMERLAT_TRACER
>>   	if (osnoise_data.timerlat_tracer) {
>>   		snprintf(comm, 24, "timerlat/%d", cpu);
>> -		main = timerlat_main;
>> +		func = timerlat_main;
>>   	} else {
>>   		snprintf(comm, 24, "osnoise/%d", cpu);
>>   	}
>>   #else
>>   	snprintf(comm, 24, "osnoise/%d", cpu);
>>   #endif
>> -	kthread = kthread_create_on_cpu(main, NULL, cpu, comm);
>> +	kthread = kthread_create_on_cpu(func, NULL, cpu, comm);
>>   
>>   	if (IS_ERR(kthread)) {
>>   		pr_err(BANNER "could not start sampling thread\n");
> 

Preferably Linus's version:

https://lore.kernel.org/all/73ee98a4-c4a5-04f3-6280-dcd67507d889@infradead.org/


-- 
~Randy

