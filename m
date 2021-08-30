Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB06D3FBA29
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 18:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237817AbhH3Q2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 12:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237962AbhH3Q2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 12:28:34 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD67C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 09:27:40 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id b7so20703067iob.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 09:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qRVc9wtgxEShcbmYz7OGhp8D0sYciRXHgYyK5WT21P8=;
        b=FjDVBhD1aY+HZpb5KLAOQ8d8/zFAsh8IG+Qh3nQcebtxy7Z1ZafNhhqJmqb3e/EeMz
         P9oGDXVXpzZw5/RQLnS0B25zvswQEGqITwtfxnlaZ1FNVqH6ivuP6opeokpejbJ0m5Sx
         OcgNlFwqtwgCNlUp3hz9cJsioRylYPht90B8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qRVc9wtgxEShcbmYz7OGhp8D0sYciRXHgYyK5WT21P8=;
        b=qHQB7ptJa6eswSwFe6fGWRshkAlaSyGrrEGkKKPVCql1f1zb67neO5KaWYtnV0jMRk
         Daq+uo0Fnmpc0vX5W+i3wHvS7l6ErjN+NXZ0RZ9plYOiN5HVuEBTEBQJBunc+ThwR7K+
         B50uewgXUnqdBQaRKGXKcgTvgtSzy9sSkFDUZx2Y68jVax3E3NCu42XYo1bUxGxQckqk
         gKZDTD9P4aGAefJB587jd+lbcIIjG/xIP54nWHtDFKarZFAZ8fw5Jj+hktgtOHC/vj5T
         /reCofaKTswhPORiiC6AGSOaTReqpeKGorJGcfK3m4YpbJTlk4SNj+/L/HNxCyV8M8eX
         gmgw==
X-Gm-Message-State: AOAM533XaHjmQTR6eIdrO5d8hNBBP+k1QBRwJ9L3sCrWTuOxEiy3rJwp
        yM2L1TjeWOvgas6euhupkyQKJQ==
X-Google-Smtp-Source: ABdhPJzt8s6WmO83TYamsF+iEKKAcL/GloVsQLb/1PxaYAUfX1llIFxLCphIyKjFQTJd9VwLgOmBkQ==
X-Received: by 2002:a6b:f714:: with SMTP id k20mr18597658iog.148.1630340859991;
        Mon, 30 Aug 2021 09:27:39 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id p15sm9445853ilc.12.2021.08.30.09.27.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Aug 2021 09:27:39 -0700 (PDT)
Subject: Re: [PATCH] workqueue: Don't record workqueue stack holding
 raw_spin_lock
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>, walter-zh.wu@mediatek.com,
        LKML <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210827234910.40490-1-skhan@linuxfoundation.org>
 <CAJhGHyCLb2HJVkj5osdgUjrMEq9mWQ2J6bytyfZVs9d5ZHfwrw@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <ef440afd-504b-b49b-91ec-1c3d057c82ba@linuxfoundation.org>
Date:   Mon, 30 Aug 2021 10:27:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAJhGHyCLb2HJVkj5osdgUjrMEq9mWQ2J6bytyfZVs9d5ZHfwrw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/21 8:18 PM, Lai Jiangshan wrote:
> On Sat, Aug 28, 2021 at 7:49 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
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
>> +
> 
> Hello
> 
> After the pool lock is released, the work item can be executed and be freed
> before kasan_record_aux_stack() is called.  Is it Ok?
> 

Right. That is a concern. As Dmitry pointed out there is a bug in the
code that kasan_record_aux_stack() is in the "out:" path.

> And I think queue_work() is allowed to be called with other raw_spin held.
> If it is the case, kasan_record_aux_stack() is still in raw_spin held section.
> 

I looked for queue_work() -> queue_work_on() -> __queue_work() and
function header doc. I couldn't find any place it says it is okay to
call queue_work() with raw spinlock held.

I am thinking that is not the case, since __queue_work() acquires pool
lock which is a raw spinlock. The lockdep warning will occur when the
pool lock acquire happens. I haven't seen it. We have 1290 callers of
queue_work() and we would have seen this before.

thanks,
-- Shuah








