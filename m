Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD6A3FBA57
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 18:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237928AbhH3Qsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 12:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233637AbhH3Qse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 12:48:34 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E3BC061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 09:47:40 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id b4so16771096ilr.11
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 09:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KI1go/bWyK3uFvdpi2Hmwl92t/CnNu6rtLHnz4QqfNw=;
        b=UipLlEGcbX/NKC+y8dmXw7/iVKECWvQurRTphJBTBX8EjEMxFnoJhBI7BOMBlQFxjm
         R7JGLlEbyTGyTyUs2TC//KSNiRCSWUgM1K073SFt+qCIoFeTE6oEa/wcOF5Gpu8ar2Xk
         rAMyGUehm5DtmqZyFCx2htDpssI02374juiHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KI1go/bWyK3uFvdpi2Hmwl92t/CnNu6rtLHnz4QqfNw=;
        b=fMBXkEO6zOgyZUOgNCygoithv7rf5Eyriq6NALGfK9PE6dQB5JlahEPIEkv8d+Kgtt
         /EGTSuUU93gJqwahb37OMSUyHEZYJyLB7ux7zV8NxwXT6ocW6OCz2GZ+AdjF/h8qirwP
         eE9wcuYUwocC4/6Z4HVKf2J4Dh4kUzrFDU65v9CxrKKvaPoWwsrOH/MBlVK00CYagUh8
         lLfVV75111diPJU8i+2Sl5J+pmsmCwwuachVCC8yCjAGnPnYf+GRrhUcgdyhEGct687L
         v9g8UqjMzz7C8xlh1l9QoyE8oT7ZdBgm8i45eJ0ukWlNJwZtSoh1ZFrvi4pPnDGs8i5w
         XZYw==
X-Gm-Message-State: AOAM533mvo6kYE+oZ5oPzpMQURQt3oCAKMctJyPaLXtI8rSa9gDWMkKq
        TMS1vOsiddZcrb36IBv1sOWv1A==
X-Google-Smtp-Source: ABdhPJxFgLpVCHtx849MDnbJrR+9jy/XnUqgMjF7/wXKnNsz/n/5NlEdvV0H1rlAVQvBkFPDXae3DQ==
X-Received: by 2002:a92:c091:: with SMTP id h17mr14564075ile.286.1630342060272;
        Mon, 30 Aug 2021 09:47:40 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id b12sm8716058ios.0.2021.08.30.09.47.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Aug 2021 09:47:39 -0700 (PDT)
Subject: Re: [PATCH] workqueue: Don't record workqueue stack holding
 raw_spin_lock
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     tj@kernel.org, jiangshanlai@gmail.com, elver@google.com,
        akpm@linux-foundation.org, walter-zh.wu@mediatek.com,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210827234910.40490-1-skhan@linuxfoundation.org>
 <CACT4Y+bEsE7nbka82B68Z9EjqEc2-3Zqx-471HDw2vFtv8cqRg@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <887e2fc8-04ac-3cde-60f4-7ab0d6c98f0c@linuxfoundation.org>
Date:   Mon, 30 Aug 2021 10:47:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CACT4Y+bEsE7nbka82B68Z9EjqEc2-3Zqx-471HDw2vFtv8cqRg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/21 11:40 PM, Dmitry Vyukov wrote:
> On Sat, 28 Aug 2021 at 01:49, Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> When CONFIG_PROVE_RAW_LOCK_NESTING and CONFIG_KASAN are enabled,
>> kasan_record_aux_stack() runs into "BUG: Invalid wait context" when
>> it tries to allocate memory attempting to acquire spinlock in page
>> allocation code while holding workqueue pool raw_spinlock.
>>
>> There are several instances of this problem when block layer tries
>> to __queue_work(). Call trace from one of these instances is below:
>>
>>      kblockd_mod_delayed_work_on()
>>        mod_delayed_work_on()
>>          __queue_delayed_work()
>>            __queue_work() (rcu_read_lock, raw_spin_lock pool->lock held)
>>              insert_work()
>>                kasan_record_aux_stack()
>>                  kasan_save_stack()
>>                    stack_depot_save()
>>                      alloc_pages()
>>                        __alloc_pages()
>>                          get_page_from_freelist()
>>                            rm_queue()
>>                              rm_queue_pcplist()
>>                                local_lock_irqsave(&pagesets.lock, flags);
>>                                [ BUG: Invalid wait context triggered ]
>>
>> Fix it by calling kasan_record_aux_stack() without holding pool lock.
>> There is no need to hold pool lock in this path.
>>
>> =============================
>>   [ BUG: Invalid wait context ]
>>   5.14.0-rc7+ #8 Not tainted
>>   -----------------------------
>>   snap/532 is trying to lock:
>>   ffff888374f32ba0 (lock#2){..-.}-{3:3}, at: get_page_from_freelist (mm/page_alloc.c:3665 mm/page_alloc.c:3703 mm/page_alloc.c:4165)
>>   other info that might help us debug this:
>>   context-{5:5}
>>   3 locks held by snap/532:
>>   #0: ffff888139fa4408 (&type->i_mutex_dir_key#10){.+.+}-{4:4}, at: walk_component (fs/namei.c:1663 fs/namei.c:1959)
>>   #1: ffffffffab870c40 (rcu_read_lock){....}-{1:3}, at: __queue_work (./arch/x86/include/asm/preempt.h:80 ./include/linux/rcupdate.h:68 ./include/linux/rcupdate.h:685 kernel/workqueue.c:1421)
>>   #2: ffff888374f36cd8 (&pool->lock){-.-.}-{2:2}, at: __queue_work (kernel/workqueue.c:1466)
>>   stack backtrace:
>>   CPU: 14 PID: 532 Comm: snap Not tainted 5.14.0-rc7+ #8
>>   Hardware name: LENOVO 90Q30008US/3728, BIOS O4ZKT1CA 09/16/2020
>>   Call Trace:
>>   dump_stack_lvl (lib/dump_stack.c:106 (discriminator 4))
>>   dump_stack (lib/dump_stack.c:113)
>>   __lock_acquire.cold (kernel/locking/lockdep.c:4666 kernel/locking/lockdep.c:4727 kernel/locking/lockdep.c:4965)
>>   ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4873)
>>   ? lock_is_held_type (kernel/locking/lockdep.c:5368 kernel/locking/lockdep.c:5668)
>>   lock_acquire (kernel/locking/lockdep.c:438 kernel/locking/lockdep.c:5627 kernel/locking/lockdep.c:5590)
>>   ? get_page_from_freelist (mm/page_alloc.c:3665 mm/page_alloc.c:3703 mm/page_alloc.c:4165)
>>   ? lock_release (kernel/locking/lockdep.c:5593)
>>   ? __kasan_check_read (mm/kasan/shadow.c:32)
>>   ? __lock_acquire (kernel/locking/lockdep.c:5019)
>>   ? __zone_watermark_ok (./include/linux/list.h:282 ./include/linux/mmzone.h:111 mm/page_alloc.c:3908)
>>   get_page_from_freelist (./include/linux/local_lock_internal.h:43 mm/page_alloc.c:3665 mm/page_alloc.c:3703 mm/page_alloc.c:4165)
>>   ? get_page_from_freelist (mm/page_alloc.c:3665 mm/page_alloc.c:3703 mm/page_alloc.c:4165)
>>   ? lock_is_held_type (kernel/locking/lockdep.c:5368 kernel/locking/lockdep.c:5668)
>>   ? is_bpf_text_address (./arch/x86/include/asm/preempt.h:85 ./include/linux/rcupdate.h:73 ./include/linux/rcupdate.h:719 kernel/bpf/core.c:708)
>>   ? lock_downgrade (kernel/locking/lockdep.c:5633)
>>   ? __zone_watermark_ok (mm/page_alloc.c:4054)
>>   __alloc_pages (mm/page_alloc.c:5391)
>>   ? __alloc_pages_slowpath.constprop.0 (mm/page_alloc.c:5354)
>>   ? create_prof_cpu_mask (kernel/stacktrace.c:82)
>> ? _find_first_bit (lib/find_bit.c:83)
>>   alloc_pages (mm/mempolicy.c:2249)
>>   stack_depot_save (lib/stackdepot.c:304)
>>   ? lock_is_held_type (kernel/locking/lockdep.c:5368 kernel/locking/lockdep.c:5668)
>>   kasan_save_stack (mm/kasan/common.c:41)
>>   ? kasan_save_stack (mm/kasan/common.c:39)
>>   ? kasan_record_aux_stack (mm/kasan/generic.c:348)
>>   ? insert_work (./include/linux/instrumented.h:71 ./include/asm-generic/bitops/instrumented-non-atomic.h:134 kernel/workqueue.c:616 kernel/workqueue.c:623 kernel/workqueue.c:1335)
>>   ? __queue_work (kernel/workqueue.c:1501)
>>   ? __queue_delayed_work (kernel/workqueue.c:1657)
>>   ? mod_delayed_work_on (kernel/workqueue.c:1720)
>>   ? kblockd_mod_delayed_work_on (block/blk-core.c:1633)
>>   ? __blk_mq_delay_run_hw_queue (block/blk-mq.c:1567)
>>   ? blk_mq_run_hw_queue (block/blk-mq.c:1610)
>>   ? blk_mq_sched_insert_request (block/blk-mq-sched.c:480)
>>   ? blk_mq_submit_bio (block/blk-mq.c:2276)
>>
>> Fixes: e89a85d63fb2 ("workqueue: kasan: record workqueue stack")
>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
>> ---
>>   kernel/workqueue.c | 18 +++++++++++++++---
>>   1 file changed, 15 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
>> index f148eacda55a..e647b29b9fb0 100644
>> --- a/kernel/workqueue.c
>> +++ b/kernel/workqueue.c
>> @@ -1328,9 +1328,6 @@ static void insert_work(struct pool_workqueue *pwq, struct work_struct *work,
>>   {
>>          struct worker_pool *pool = pwq->pool;
>>
>> -       /* record the work call stack in order to print it in KASAN reports */
>> -       kasan_record_aux_stack(work);
>> -
>>          /* we own @work, set data and link */
>>          set_work_pwq(work, pwq, extra_flags);
>>          list_add_tail(&work->entry, head);
>> @@ -1499,6 +1496,14 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
>>
>>   out:
>>          raw_spin_unlock(&pwq->pool->lock);
>> +
>> +       /*
>> +        * record the work call stack in order to print it in KASAN reports
>> +        * Do this without pool raw_spinlock hold to avoid nesting raw
>> +        * spinlock with page allocation spinlock.
>> +        */
>> +       kasan_record_aux_stack(work);
> 
> Hi Shuah,
> 
> I agree that the current code is problematic and we don't need to hold
> the lock around kasan_record_aux_stack().
> 

Good.

> However, I think we need to call kasan_record_aux_stack() before the
> actual queueing, otherwise the work can be dequeued and cause a bug
> before we call kasan_record_aux_stack() in this task (it's like
> setting permissions on an fd after publishing it in fd table).
> 

You are right. This patch does change the order of recording by moving
from insert_work(). I couldn't find a unrecord step in the current
code? Where does that happen? Is it necessary to deallocate and do
other cleanup when work gets dequeued?

> Also, this happens after "out:" label and it seems we go to it even if
> we don't queue the work in some cases. Ideally we only call
> kasan_record_aux_stack() only if we queue it, because the capacity for
> aux stacks are only 2 stacks (the oldest gets evicted). However, I
> think the first point is more important. So if move
> kasan_record_aux_stack() to happen before insert_work() and won't be
> able to predict if we actually queue it later or not, then I think
> it's fine to episodically call kasan_record_aux_stack() even if we
> don't queue later. At least I don't see a better solution.
> 
> 

Yeah. I missed that. I was careful with the start_flush_work() out leg.

thanks,
-- Shuah
