Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEBCE381633
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 07:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234383AbhEOFnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 01:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234371AbhEOFnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 01:43:07 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE17C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 22:41:54 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id i13so861364edb.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 22:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=6rckXWl7BjyQXPzwD/P/SDYdcR87Ra4zqULmgEiLxDE=;
        b=yzjubYj2B80QIHiYErXQMKDY5pu2PDCuYFCE1s/chllwlraOitSCTQTlb27yyQhWCv
         5xQdDSdrWAzVran6LnCfG4ltxBAX/cgqaBNZKWt7HXJsUuzuwGpzPV3Tj2vhnl+sJqyQ
         aEVBAinlAcNbt2uuW7s3/iZOcOlLM1I1uF7TX/GjsWxHOuLW3ydkJkUTOaRZwnHUg6SA
         NwUZeB68MmZ/sAFNiBoXVPMr1PZR9uEQ5udxsv8YvK6Ou0bCA+CCTQYcR5xy7P7xijAf
         nNHf80pg3LkC89rwyRkPx8OxvzXcK4f9CK5roGETF0Y2F5vE9ZSJ4cSaoh440zIVqL5u
         UeaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=6rckXWl7BjyQXPzwD/P/SDYdcR87Ra4zqULmgEiLxDE=;
        b=V6oqvPShP0ORSO0UMccBfKt5DQDlbw22W0bFyAjsEa1+AxdxHbwnQRr3Nb2mVOy3Pw
         xBuc7o8jCDti/zZVo7EF7JQ0NIM+n25uNJxeoG48H8/mfaIo+hsjqp4cmhqoxe07G0S4
         JH7YVZokkt//FBoXSMoq4VGwsZi43llF6Pu2+AbucKT+e3m4nk5phfaU25Qra0zetLpO
         Zgr39F1HO4TzPK42OVza/cnhpcJXO71CzfUs9pEVixAueCT/x4CIL7CXKUXXRr/hy6/r
         x6ce7jAzRa+88UBJZhRkyZxAOaqBKDtDpV8u5yu2v7ZSOpBBc/OjvAUJHWFZsDEmJwMM
         nAbQ==
X-Gm-Message-State: AOAM531PPCOmbiFdW+GPcfNym9O+BYzNCGn+Ht9TTTVOyBgUlXkTnYSd
        vsUO2DUwcAcMH/zA3da7KVxUDpuSn0wPkSbouCU=
X-Google-Smtp-Source: ABdhPJyLlDLhoIR7YeR5xc75cK4I79H6TOAJ6KPw/6Lr4fy1ui+8H2g3HBLX715Fce0I2+mD0JRfIQ==
X-Received: by 2002:a05:6402:4383:: with SMTP id o3mr59608029edc.333.1621057312778;
        Fri, 14 May 2021 22:41:52 -0700 (PDT)
Received: from localhost.localdomain (p200300d99736a100737e0d2844aab884.dip0.t-ipconnect.de. [2003:d9:9736:a100:737e:d28:44aa:b884])
        by smtp.googlemail.com with ESMTPSA id r18sm4730527ejd.106.2021.05.14.22.41.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 May 2021 22:41:52 -0700 (PDT)
Subject: Re: [RFC PATCH] ipc/mqueue: avoid sleep after wakeup
To:     Hillf Danton <hdanton@sina.com>
Cc:     Davidlohr Bueso <dbueso@suse.de>,
        Matthias von Faber <matthias.vonfaber@aox-tech.de>,
        Varad Gautam <varad.gautam@suse.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210514030130.3253-1-hdanton@sina.com>
 <20210515040613.12820-1-hdanton@sina.com>
From:   Manfred Spraul <manfred@colorfullife.com>
Message-ID: <5d73d162-e860-785f-a775-1100b0aa57dd@colorfullife.com>
Date:   Sat, 15 May 2021 07:41:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210515040613.12820-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/15/21 6:06 AM, Hillf Danton wrote:
> On Fri, 14 May 2021 17:51:47 +0200  Manfred Spraul wrote:
>> On 5/14/21 5:01 AM, Hillf Danton wrote:
>>> The pipeline waker could start doing its job once waiter releases lock and
>>> get the work done before waiter takes a nap, so check wait condition before
>>> sleep to avoid waiting the wakeup that will never come, though that does not
>>> hurt much thanks to timer timeouts like a second.
>> First: The timeout could be infinity, thus the code must not rely on a
>> timeout wakeup.
>>
>> A wrong wait is would be a bug.
>>
>>
>>> Check signal for the same reason.
>>>
>>> Signed-off-by: Hillf Danton <hdanton@sina.com>
>>> ---
>>>
>>> --- y/ipc/mqueue.c
>>> +++ x/ipc/mqueue.c
>>> @@ -710,15 +710,24 @@ static int wq_sleep(struct mqueue_inode_
>>>    		__set_current_state(TASK_INTERRUPTIBLE);
>>>    
>>>    		spin_unlock(&info->lock);
>>> -		time = schedule_hrtimeout_range_clock(timeout, 0,
>>> -			HRTIMER_MODE_ABS, CLOCK_REALTIME);
>>>    
>> I do not see a bug:
>>
>> We do the __set_current_state() while holding the spinlock. If there is
>> a wakeup, then the wakeup will change current->state to TASK_RUNNING.
> Correct.
>> schedule() will not remove us from the run queue when current->state is
>> TASK_RUNNING. The same applies if there are pending signals: schedule()
>> checks for pending signals and sets current->state to TASK_RUNNING.
>>
>> Since the __set_current_state() is done while we hold info->lock, and
>> since the wakeup cannot happen before we have dropped the lock [because
>> the task that wakes us up needs the same lock], I do not see how a
>> wakeup could be lost.
>>
>> Thus: Which issue do you see?
> 	waiter		waker
> 	----		----
> 	unlock
> 			lock
> 	irq		set STATE_READY
> 	softirq		unlock
> 			wakeup
> 	sleep a tick
> 	  schedule();
>
> No need to schedule given READY.

This is not possible to avoid:

	waiter		waker
	----		----
	unlock
	schedule();
	  calls __schedule()
	   <before rq_lock()>

  	                lock
			set STATE_READY
			unlock
			wakeup
			--> set waiter->state = TASK_RUNNING

Now the run queue will be evaluated even though there is strictly speaking no need to do that.
Changes in ipc/sem.c can't solve that: From what I see, the majority of the critical window is in kernel/sched/*.c and not in ipc/sem.c
I do not consider it as useful to add complexity just to reduce the size of a extremely rare event.

Especially: No harm is done. User space can be preempted at any time, so the kernel is always allowed to check the run queue.

--
	Manfred

