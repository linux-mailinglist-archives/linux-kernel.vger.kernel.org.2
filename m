Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A65BF3811C4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 22:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhENU0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 16:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbhENU0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 16:26:33 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A549C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 13:25:20 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id r11so11978901edt.13
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 13:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=VBnqNiOUccDKwPHZcvRpD/cDYiw6UO3907bwYc6Zs50=;
        b=kgi56kuQCm2ZuTZhyCRYlNh89otEHEzYypAejvkX2gd3N7+k+R4McFlVIQGTYKhRz/
         KWfnyaikvB6qzt/uxaOOaKVBUKUcl2b2+FLbKzLvhWjf0v1DQGLhtD4o31rQ4WXVRsM5
         12Kfz1Pxn5/hKVhTodiUuQ5ISOND9VIT4aiZxahqu5TRjCr13U4lMsdhULBAsYGuiip+
         6qY7l+hYYFEmaES6cXdYu0huG//seb9CYAyKXKxgt+VjgVe4wjLK09FwEnt2OZ1uN+Ys
         e9XRanRzcsI6J6rZuXrfx8LuWOppQRiBLXOZLsCCCMvOyzWCfYUFHr6SJsgEcfVLro++
         o0vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=VBnqNiOUccDKwPHZcvRpD/cDYiw6UO3907bwYc6Zs50=;
        b=g0ommeUSqSqYAvMAWDe4aYBP2mM1g/A2IZslNrZ1IS9rjo9tTIrcmyUp8xCjHeTWXu
         7Ll6UXh5pHscB3k8nPe/WABBaoQJ1392u1qAR1S32+z5hfZVGvQdjo8ZJNbS0R+9fYf9
         uNnBDaIWvg/ST0M3RZDcYOZyfmVff+Ryt2ULMdG7T2Te6bmjmSu3ayYBljRmwMyJWj07
         7jLLSXxfQWxjbja26DMB/sCn07jrrhW9f+tLdHleiU6wQTLa4NROZtzNZYoi+SkENZD+
         8c6vB9Y0fR6MVOFLGue9ZUMD7Gr4N5dAiOUH/VwKTafnz5THS+4k2flWAAls95YnEF3w
         i22w==
X-Gm-Message-State: AOAM531dlxK6heJt5w5du97sy79PL7QN0LphCn0rw0ZVc7pDRdoZkzB+
        Oqxqc7qcYmHReuQJrPKeU0cCJA==
X-Google-Smtp-Source: ABdhPJwioDaBn45MlqtK3UheBT+V6TCJPcVnRYT9ytz3gpwDicxq9zrDWREcX/o0SrQo/fqXb9RwYA==
X-Received: by 2002:a05:6402:10c6:: with SMTP id p6mr58690437edu.241.1621023919241;
        Fri, 14 May 2021 13:25:19 -0700 (PDT)
Received: from localhost.localdomain (p200300d9970469005bb43495a574ac97.dip0.t-ipconnect.de. [2003:d9:9704:6900:5bb4:3495:a574:ac97])
        by smtp.googlemail.com with ESMTPSA id ga3sm4130472ejb.34.2021.05.14.13.25.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 May 2021 13:25:18 -0700 (PDT)
Subject: Re: [PATCH] ipc/sem.c: use READ_ONCE()/WRITE_ONCE() for
 use_global_lock
To:     paulmck@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andrew Morton <akpm@linux-foundation.org>, 1vier1@web.de
References: <20210514175319.12195-1-manfred@colorfullife.com>
 <20210514194407.GN975577@paulmck-ThinkPad-P17-Gen-1>
From:   Manfred Spraul <manfred@colorfullife.com>
Message-ID: <c3a1f1a3-8fc1-29b5-92e0-bf45e1cc438f@colorfullife.com>
Date:   Fri, 14 May 2021 22:25:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210514194407.GN975577@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On 5/14/21 9:44 PM, Paul E. McKenney wrote:
> On Fri, May 14, 2021 at 07:53:19PM +0200, Manfred Spraul wrote:
>> The patch solves two weaknesses in ipc/sem.c:
>>
>> 1) The initial read of use_global_lock in sem_lock() is an
>> intentional race. KCSAN detects these accesses and prints
>> a warning.
>>
>> 2) The code assumes that plain C read/writes are not
>> mangled by the CPU or the compiler.
>>
>> To solve both issues, use READ_ONCE()/WRITE_ONCE().
>> Plain C reads are used in code that owns sma->sem_perm.lock.
>>
>> Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
>
> One follow-up question: If I am reading the code correctly, there is
> a call to complexmode_enter() from sysvipc_sem_proc_show() that does
> not hold the global lock.  Does this mean that the first check of
> ->use_global_lock in complexmode_enter() should be marked?

Now you made me nervous, usually I do not test the proc interface.
According to the documentation in sysvipc_sem_proc_show(), 
sysvipc_find_ipc() acquires the global lock.

>         /*
>          * The proc interface isn't aware of sem_lock(), it calls
>          * ipc_lock_object() directly (in sysvipc_find_ipc).
>          * In order to stay compatible with sem_lock(), we must
>          * enter / leave complex_mode.
>          */
I have just tested it again: Yes, this is still true.

Perhaps, as future improvement: The rest of ipc/sem.c speaks about 
"sem_perm.lock", and here we suddenly use a function name instead of the 
structure member name.

 > "it calls ipc_lock_object() (i.e.: spin_lock(&sma->sem_perm.lock)).

> 							Thanx, Paul
>
>> ---
>>   ipc/sem.c | 11 +++++++----
>>   1 file changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/ipc/sem.c b/ipc/sem.c
>> index bf534c74293e..a0ad3a3edde2 100644
>> --- a/ipc/sem.c
>> +++ b/ipc/sem.c
>> @@ -217,6 +217,8 @@ static int sysvipc_sem_proc_show(struct seq_file *s, void *it);
>>    * this smp_load_acquire(), this is guaranteed because the smp_load_acquire()
>>    * is inside a spin_lock() and after a write from 0 to non-zero a
>>    * spin_lock()+spin_unlock() is done.
>> + * To prevent the compiler/cpu temporarily writing 0 to use_global_lock,
>> + * READ_ONCE()/WRITE_ONCE() is used.
>>    *
>>    * 2) queue.status: (SEM_BARRIER_2)
>>    * Initialization is done while holding sem_lock(), so no further barrier is
>> @@ -342,10 +344,10 @@ static void complexmode_enter(struct sem_array *sma)
>>   		 * Nothing to do, just reset the
>>   		 * counter until we return to simple mode.
>>   		 */
>> -		sma->use_global_lock = USE_GLOBAL_LOCK_HYSTERESIS;
>> +		WRITE_ONCE(sma->use_global_lock, USE_GLOBAL_LOCK_HYSTERESIS);
>>   		return;
>>   	}
>> -	sma->use_global_lock = USE_GLOBAL_LOCK_HYSTERESIS;
>> +	WRITE_ONCE(sma->use_global_lock, USE_GLOBAL_LOCK_HYSTERESIS);
>>   
>>   	for (i = 0; i < sma->sem_nsems; i++) {
>>   		sem = &sma->sems[i];
>> @@ -371,7 +373,8 @@ static void complexmode_tryleave(struct sem_array *sma)
>>   		/* See SEM_BARRIER_1 for purpose/pairing */
>>   		smp_store_release(&sma->use_global_lock, 0);
>>   	} else {
>> -		sma->use_global_lock--;
>> +		WRITE_ONCE(sma->use_global_lock,
>> +				sma->use_global_lock-1);
>>   	}
>>   }
>>   
>> @@ -412,7 +415,7 @@ static inline int sem_lock(struct sem_array *sma, struct sembuf *sops,
>>   	 * Initial check for use_global_lock. Just an optimization,
>>   	 * no locking, no memory barrier.
>>   	 */
>> -	if (!sma->use_global_lock) {
>> +	if (!READ_ONCE(sma->use_global_lock)) {
>>   		/*
>>   		 * It appears that no complex operation is around.
>>   		 * Acquire the per-semaphore lock.
>> -- 
>> 2.31.1
>>

