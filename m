Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E79D841552E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 03:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238823AbhIWBqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 21:46:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56614 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238177AbhIWBqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 21:46:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632361511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=18E7gXRiq8bGHFDdj4pH+TKVPOQ8tZmgGwIjGcp0he8=;
        b=N6FxWUs48UoV7DsP4CRRCRlzcM14UAvkXUED0M7E5/hl/pp+yERhOZTQH53PlJEaWCMjtb
        ME8TNL51gnQHznRO/vVJFbzV1Nvuh0i4Gc9e2dX6ypHRfONWpVRLO36y40q71gXZvVcqxU
        d6sIM4ETvllK9rwAomhm1pBhZr2+Hmg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-fr4wYtpONKCVIqyrK9yffQ-1; Wed, 22 Sep 2021 21:45:10 -0400
X-MC-Unique: fr4wYtpONKCVIqyrK9yffQ-1
Received: by mail-qv1-f72.google.com with SMTP id p12-20020ad4496c000000b0037a535cb8b2so16004326qvy.15
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 18:45:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=18E7gXRiq8bGHFDdj4pH+TKVPOQ8tZmgGwIjGcp0he8=;
        b=DvbO3HPeI11IuMKh04hcOVFBsJ1G2zmjlrUnwbpUaSe6IIuGTtIbFZTRAnd8qwqT6h
         wqqZkwbdo9YljIUuUD7cb5xei4RaMH4S9mqg4fpIhb0UO0HfFYqk+/v7OCyNuJdCY7iP
         smAN3MEnSu3/WgeOGcKeQuARNuc6uqTeaIgaxckKX+rbLVbVg7ujxgyiCx3iSCNvOWWR
         s18AK7y7A/u+TxEjIfieBbShpBFK8w/i09wnkE6a/AdXnvvG5Ptbtmp8MJJY3K0EXcvZ
         tCI+mPuW56bpSpqhA8Q6M6f6f1oUmTHA4EjWMrGn3Tuzw9AJVYD9n8tnweeyJhumdzUo
         0jGQ==
X-Gm-Message-State: AOAM532UjNCcoDpdu5YWzbF+HfVTuDg+7PH5/Y3gn54ZNuO3qP/sEh5T
        lG2vvVPlRgQCzEdtP5QIf1LT7F/tG2VWxxRhJCw5S9nweKJwjh1GKVGIhH+lGcpSqMuF4GRTORM
        hzlD96Ef0pYQgk6laGwas1WyS
X-Received: by 2002:a0c:9d07:: with SMTP id m7mr2251489qvf.60.1632361510170;
        Wed, 22 Sep 2021 18:45:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzlrhWqndqojDWMAPYNzVKvmh101pj2sHkY/jdU8wzg9pcKqwyA7lWjVqyMC72ZDp68sAo3Hg==
X-Received: by 2002:a0c:9d07:: with SMTP id m7mr2251475qvf.60.1632361509936;
        Wed, 22 Sep 2021 18:45:09 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id m139sm3491766qke.18.2021.09.22.18.45.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Sep 2021 18:45:09 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [RFC PATCH] locking/rwsem: Add upgrade_read()
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>
References: <20210922193657.29461-1-longman@redhat.com>
 <YUvVg6OJLIqg/rUZ@boqun-archlinux>
Message-ID: <bafdd02e-68f8-a55c-68fe-8fe165cfe9d4@redhat.com>
Date:   Wed, 22 Sep 2021 21:45:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YUvVg6OJLIqg/rUZ@boqun-archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/21 9:16 PM, Boqun Feng wrote:
> On Wed, Sep 22, 2021 at 03:36:57PM -0400, Waiman Long wrote:
>> Currently there are about 12 instances in the kernel where an up_read()
>> is immediately followed by a down_write() of the same lock. For example,
>>
>>    drivers/tty/n_tty.c:		up_read(&tty->termios_rwsem);
>>    drivers/tty/n_tty.c-		down_write(&tty->termios_rwsem);
>>
>> Since we have already provided a downgrade_write() function, we may as
>> well provide an upgrade_read() function to make the code easier to read
>> and the intention clearer.
>>
>> If the current task is the only reader, the upgrade can be done by a
>> single atomic operation. If not, the upgrade will have to be done by a
>> separate up_read() call followed by a down_write(). In the former case,
>> the handoff bit is not considered and the waiter will have to wait a
>> bit longer to acquire the lock.
>>
>> The new upgrade_read() function returns a value of 0 for safe upgrade
>> where rwsem protected data won't change. Otherwise a value of 1 is
>> returned to indicate unsafe upgrade where rwsem protected data may
>> change during the upgrade process.
>>
>> For PREEMPT_RT, it falls back to up_read() followed by down_write()
>> for simplicity.
>>
>> Some uses of down_write() with long lock hold time may be changed
>> to the following format in the future:
>>
>> 	down_read()
>> 	/* check data */
>> 	if (upgrade_read()) {
>> 		/* unsafe upgrade, recheck data */
>> 	}
>> 	/* update data */
>> 	up_write();
>>
>> As long as the "recheck data" and "update data" parts are relatively
>> short compared with the "check data" part, this conversion may help to
>> improve parallelism and reduce lock contention.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   include/linux/rwsem.h  |  5 ++++
>>   kernel/locking/rwsem.c | 53 ++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 58 insertions(+)
>>
>> diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
>> index 352c6127cb90..8ece58224f25 100644
>> --- a/include/linux/rwsem.h
>> +++ b/include/linux/rwsem.h
>> @@ -207,6 +207,11 @@ extern void up_write(struct rw_semaphore *sem);
>>    */
>>   extern void downgrade_write(struct rw_semaphore *sem);
>>   
>> +/*
>> + * upgrade read lock to write lock
>> + */
>> +extern int upgrade_read(struct rw_semaphore *sem);
>> +
>>   #ifdef CONFIG_DEBUG_LOCK_ALLOC
>>   /*
>>    * nested locking. NOTE: rwsems are not allowed to recurse
>> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
>> index 000e8d5a2884..aeb5b0668304 100644
>> --- a/kernel/locking/rwsem.c
>> +++ b/kernel/locking/rwsem.c
>> @@ -1203,6 +1203,29 @@ static struct rw_semaphore *rwsem_downgrade_wake(struct rw_semaphore *sem)
>>   	return sem;
>>   }
>>   
>> +/*
>> + * Try to upgrade read lock to write lock
>> + */
>> +static inline int __try_upgrade_read(struct rw_semaphore *sem)
>> +{
>> +	long count = atomic_long_read(&sem->count);
>> +
>> +	WARN_ON_ONCE(count & RWSEM_WRITER_LOCKED);
>> +
>> +	/*
>> +	 * When upgrading from shared to exclusive ownership,
>> +	 * anything inside the write-locked region cannot leak
>> +	 * into the read side. Use an ACQUIRE semantics.
>> +	 */
>> +	if (((count & RWSEM_READER_MASK) == RWSEM_READER_BIAS) &&
>> +	     atomic_long_try_cmpxchg_acquire(&sem->count, &count,
>> +			count - RWSEM_READER_BIAS + RWSEM_WRITER_LOCKED)) {
>> +		rwsem_set_owner(sem);
>> +		return 1;
>> +	}
>> +	return 0;
>> +}
>> +
>>   /*
>>    * lock for reading
>>    */
>> @@ -1438,6 +1461,11 @@ static inline void __downgrade_write(struct rw_semaphore *sem)
>>   	rwbase_write_downgrade(&sem->rwbase);
>>   }
>>   
>> +static inline int __try_upgrade_read(struct rw_semaphore *sem)
>> +{
>> +	return 0;
>> +}
>> +
>>   /* Debug stubs for the common API */
>>   #define DEBUG_RWSEMS_WARN_ON(c, sem)
>>   
>> @@ -1581,6 +1609,31 @@ void downgrade_write(struct rw_semaphore *sem)
>>   }
>>   EXPORT_SYMBOL(downgrade_write);
>>   
>> +/*
>> + * Upgrade read lock to write lock
>> + *
>> + * Return: 0 when upgrade is safe, i.e. rwsem protected data do not change;
>> + *         1 when upgrade is unsafe as rwsem protected data may have changed.
>> + */
>> +int upgrade_read(struct rw_semaphore *sem)
>> +{
>> +	if (__try_upgrade_read(sem)) {
>> +		rwsem_release(&sem->dep_map, _RET_IP_);
>> +		rwsem_acquire(&sem->dep_map, 0, 0, _RET_IP_);
>> +		return 0;
>> +	}
>> +
>> +	/*
>> +	 * We cannot directly upgrade to the write lock, just do a regular
>> +	 * up_read() and down_write() sequence. The data protected by the
>> +	 * rwsem may have changed before the write lock is acquired.
>> +	 */
>> +	down_read(sem);
>> +	up_write(sem);
> Confused, the comment says up_read()+down_write(), however the code is
> down_read()+up_write().
Thanks for catching that typo. My bad.
>
> Besides, I don't like the idea that the value may have changed before
> the write lock is acquired if we call it "upgrade". Maybe we want api
> like down_read_upgradable(), which can be held in parallel with other
> down_read() but no other down_read_upgradable(), and one can only
> upgrade the read-side critical section created by
> down_read_upgradable(). For implementation, that means we need to have
> one extra bit for upgradable. Thoughts?

I like your idea. There are spare bits available and we can dedicate one 
bit for that purpose. After successfully acquire the bit the reader can 
probably spin a little bit and then insert itself to the head of the 
wait queue to sleep. The last exiting reader can wake it up to acquire 
the write lock.

I will probably use "try_upgrade_read() to indicate that the attempt may 
fail.

Thanks for the suggestion.

Cheers,
Longman


