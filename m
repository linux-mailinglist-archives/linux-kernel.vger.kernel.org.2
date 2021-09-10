Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0ADB406A5E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 12:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbhIJKwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 06:52:04 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55268 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232415AbhIJKwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 06:52:04 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5AF9021AD9;
        Fri, 10 Sep 2021 10:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631271052; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cLa40tf04nYkoytYOxqmcnFcOjSkFNnyh5QKFWN0cDQ=;
        b=UmM/PXCv3DjaKbFsOu+/cD98ovCVmoRIUYn1YAMeXxhTCzmGDFwv9po5FdMa5eWu2covb+
        WwvwlDwN1xLZcHsxuE2WWehpzw7yCzgYwqJiNiE/LLt+Wnpd8Lgs8VAOHnoy3rmKPfKZTQ
        9GnWim+bLE/vjrZlLvv2o1HdAvYM8Ws=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631271052;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cLa40tf04nYkoytYOxqmcnFcOjSkFNnyh5QKFWN0cDQ=;
        b=7h9cOBNJV0/tF44d4MDtH45pjx5vGDfQq7wTwZV8ZhT5XifVZXkyrFhUI/1NTlDdemjkSo
        kvU4CVNX/q3HdoBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0B64A13D27;
        Fri, 10 Sep 2021 10:50:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zunNAYw4O2F5HgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 10 Sep 2021 10:50:52 +0000
Message-ID: <1b1569ac-1144-4f9c-6938-b9d79c6743de@suse.cz>
Date:   Fri, 10 Sep 2021 12:50:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH 0/6] stackdepot, kasan, workqueue: Avoid expanding
 stackdepot slabs when holding raw_spin_lock
Content-Language: en-US
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Walter Wu <walter-zh.wu@mediatek.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vijayanand Jitta <vjitta@codeaurora.org>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Aleksandr Nogikh <nogikh@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20210907141307.1437816-1-elver@google.com>
 <69f98dbd-e754-c34a-72cf-a62c858bcd2f@linuxfoundation.org>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <69f98dbd-e754-c34a-72cf-a62c858bcd2f@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/21 22:05, Shuah Khan wrote:
> On 9/7/21 8:13 AM, Marco Elver wrote:
>> Shuah Khan reported [1]:
>>
>>   | When CONFIG_PROVE_RAW_LOCK_NESTING=y and CONFIG_KASAN are enabled,
>>   | kasan_record_aux_stack() runs into "BUG: Invalid wait context" when
>>   | it tries to allocate memory attempting to acquire spinlock in page
>>   | allocation code while holding workqueue pool raw_spinlock.
>>   |
>>   | There are several instances of this problem when block layer tries
>>   | to __queue_work(). Call trace from one of these instances is below:
>>   |
>>   |     kblockd_mod_delayed_work_on()
>>   |       mod_delayed_work_on()
>>   |         __queue_delayed_work()
>>   |           __queue_work() (rcu_read_lock, raw_spin_lock pool->lock held)
>>   |             insert_work()
>>   |               kasan_record_aux_stack()
>>   |                 kasan_save_stack()
>>   |                   stack_depot_save()
>>   |                     alloc_pages()
>>   |                       __alloc_pages()
>>   |                         get_page_from_freelist()
>>   |                           rm_queue()
>>   |                             rm_queue_pcplist()
>>   |                               local_lock_irqsave(&pagesets.lock, flags);
>>   |                               [ BUG: Invalid wait context triggered ]
>>
>> [1]
>> https://lkml.kernel.org/r/20210902200134.25603-1-skhan@linuxfoundation.org
>>
>> PROVE_RAW_LOCK_NESTING is pointing out that (on RT kernels) the locking
>> rules are being violated. More generally, memory is being allocated from
>> a non-preemptive context (raw_spin_lock'd c-s) where it is not allowed.
>>
>> To properly fix this, we must prevent stackdepot from replenishing its
>> "stack slab" pool if memory allocations cannot be done in the current
>> context: it's a bug to use either GFP_ATOMIC nor GFP_NOWAIT in certain
>> non-preemptive contexts, including raw_spin_locks (see gfp.h and
>> ab00db216c9c7).
>>
>> The only downside is that saving a stack trace may fail if: stackdepot
>> runs out of space AND the same stack trace has not been recorded before.
>> I expect this to be unlikely, and a simple experiment (boot the kernel)
>> didn't result in any failure to record stack trace from insert_work().
>>
>> The series includes a few minor fixes to stackdepot that I noticed in
>> preparing the series. It then introduces __stack_depot_save(), which
>> exposes the option to force stackdepot to not allocate any memory.
>> Finally, KASAN is changed to use the new stackdepot interface and
>> provide kasan_record_aux_stack_noalloc(), which is then used by
>> workqueue code.
>>
>> Marco Elver (6):
>>    lib/stackdepot: include gfp.h
>>    lib/stackdepot: remove unused function argument
>>    lib/stackdepot: introduce __stack_depot_save()
>>    kasan: common: provide can_alloc in kasan_save_stack()
>>    kasan: generic: introduce kasan_record_aux_stack_noalloc()
>>    workqueue, kasan: avoid alloc_pages() when recording stack
>>
>>   include/linux/kasan.h      |  2 ++
>>   include/linux/stackdepot.h |  6 +++++
>>   kernel/workqueue.c         |  2 +-
>>   lib/stackdepot.c           | 51 ++++++++++++++++++++++++++++++--------
>>   mm/kasan/common.c          |  6 ++---
>>   mm/kasan/generic.c         | 14 +++++++++--
>>   mm/kasan/kasan.h           |  2 +-
>>   7 files changed, 65 insertions(+), 18 deletions(-)
>>
> 
> Thank you. Tested all the 6 patches in this series on Linux 5.14. This problem
> exists in 5.13 and needs to be marked for both 5.14 and 5.13 stable releases.

I think if this problem manifests only with CONFIG_PROVE_RAW_LOCK_NESTING
then it shouldn't be backported to stable. CONFIG_PROVE_RAW_LOCK_NESTING is
an experimental/development option to earlier discover what will collide
with RT lock semantics, without needing the full RT tree.
Thus, good to fix going forward, but not necessary to stable backport.

> Here is my
> 
> Tested-by: Shuah Khan <skhan@linuxfoundation.org>
> 
> thanks,
> -- Shuah
> 

