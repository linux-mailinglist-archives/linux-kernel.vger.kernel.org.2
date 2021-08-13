Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93A6E3EBB71
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 19:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbhHMR2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 13:28:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38046 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhHMR2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 13:28:06 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628875658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hXTaSydLQd13Wt3GN8lQTythfyuBI5u6fx4bdjj3qSg=;
        b=VLTc/NGS01W+I7Tlg4jxZ/rgRXF32oKOJjtdocgDY+RPIkowZnl3vDNsWUcC4q4Yga2BMF
        2wbW+YBdmz1PBFt+LXhB6OqnJ8DzTPNb8Sdg1yQsN7lG69N4Wc97lJxUrCmhyX1fu/rCD9
        eUSK8XWfLmzJUCWEFSnWCrJ9gwcb/QoK4xQk6nS5go0yrbop8VoO8HIFKOix4VM8l2/qfW
        vuAtle7ZBCVS35jtLccUg8RbuPF9IuNWWJn/RNQwhV+abr5nkr42IAJbuI8YHr5J/XG2bO
        ONgm+C4Pt/KYIQ4wb4sJx3ESzwBz6d2wSKMFb8L1x7z+mthbGBJPCk9sH6To4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628875658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hXTaSydLQd13Wt3GN8lQTythfyuBI5u6fx4bdjj3qSg=;
        b=+C58gskZdXfZhavBAInUT9TFk9MBa4c7jqWdWExTuhHBWCGEBVHtqq9BHpJftcWd409HWO
        bNhtQ37dB9iXedBQ==
To:     Waiman Long <llong@redhat.com>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com
Cc:     wangle6@huawei.com, xiaoqian9@huawei.com, shaolexi@huawei.com
Subject: Re: [PATCH] semaphore: Add might_sleep() to down_*() family
In-Reply-To: <48cddad4-0388-ae8b-f98b-1629b9ae590a@redhat.com>
References: <20210809021215.19991-1-nixiaoming@huawei.com>
 <48cddad4-0388-ae8b-f98b-1629b9ae590a@redhat.com>
Date:   Fri, 13 Aug 2021 19:27:37 +0200
Message-ID: <877dgpp852.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 08 2021 at 23:01, Waiman Long wrote:
> On 8/8/21 10:12 PM, Xiaoming Ni wrote:
>> Semaphore is sleeping lock. Add might_sleep() to down*() family
>> (with exception of down_trylock()) to detect atomic context sleep.
>> @@ -157,6 +160,7 @@ int down_timeout(struct semaphore *sem, long timeout)
>>   	unsigned long flags;
>>   	int result = 0;
>>   
>> +	might_sleep();
>>   	raw_spin_lock_irqsave(&sem->lock, flags);
>>   	if (likely(sem->count > 0))
>>   		sem->count--;
>
> I think it is simpler to just put a "might_sleep()" in __down_common() 
> which is the function where sleep can actually happen.

No. Putting it in __down_common() is wrong, because that covers only the
contended case.

But we want to cover the potential sleep, i.e. checking even in the
non-contended case, which is what might_sleep() is about.

Thanks,

        tglx
