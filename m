Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EED74104F9
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 10:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243628AbhIRII4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 04:08:56 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:16276 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235163AbhIRIIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 04:08:55 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HBNh96Zq8z57Cl;
        Sat, 18 Sep 2021 16:06:49 +0800 (CST)
Received: from dggpemm500009.china.huawei.com (7.185.36.225) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Sat, 18 Sep 2021 16:07:30 +0800
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemm500009.china.huawei.com (7.185.36.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Sat, 18 Sep 2021 16:07:29 +0800
Subject: Re: [PATCH v2 2/3] kfence: maximize allocation wait timeout duration
To:     Marco Elver <elver@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
References: <20210421105132.3965998-1-elver@google.com>
 <20210421105132.3965998-3-elver@google.com>
 <6c0d5f40-5067-3a59-65fa-6977b6f70219@huawei.com>
 <abd74d5a-1236-4f0e-c123-a41e56e22391@huawei.com>
 <CANpmjNNXiuQbjMBP=5+uZRNAiduV7v067pPmAgsYzSPpR8Y2yg@mail.gmail.com>
CC:     <akpm@linux-foundation.org>, <glider@google.com>,
        <dvyukov@google.com>, <jannh@google.com>, <mark.rutland@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <kasan-dev@googlegroups.com>, <hdanton@sina.com>
From:   Liu Shixin <liushixin2@huawei.com>
Message-ID: <da6629d3-2530-46b0-651b-904159a7a189@huawei.com>
Date:   Sat, 18 Sep 2021 16:07:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <CANpmjNNXiuQbjMBP=5+uZRNAiduV7v067pPmAgsYzSPpR8Y2yg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.24]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500009.china.huawei.com (7.185.36.225)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/9/16 16:49, Marco Elver wrote:
> On Thu, 16 Sept 2021 at 03:20, Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>> Hi Marco,
>>
>> We found kfence_test will fails  on ARM64 with this patch with/without
>> CONFIG_DETECT_HUNG_TASK,
>>
>> Any thought ?
> Please share log and instructions to reproduce if possible. Also, if
> possible, please share bisection log that led you to this patch.
>
> I currently do not see how this patch would cause that, it only
> increases the timeout duration.
>
> I know that under QEMU TCG mode, there are occasionally timeouts in
> the test simply due to QEMU being extremely slow or other weirdness.
>
> .
>
Hi Marco,

There are some of the results of the current test:
1. Using qemu-kvm on arm64 machine, all testcase can pass.
2. Using qemu-system-aarch64 on x86_64 machine, randomly some testcases fail.
3. Using qemu-system-aarch64 on x86_64, but removing the judgment of kfence_allocation_key in kfence_alloc(), all testcase can pass.

I add some printing to the kernel and get very strange results.
I add a new variable kfence_allocation_key_gate to track the
state of kfence_allocation_key. As shown in the following code, theoretically,
if kfence_allocation_key_gate is zero, then kfence_allocation_key must be
enabled, so the value of variable error in kfence_alloc() should always be
zero. In fact, all the passed testcases fit this point. But as shown in the
following failed log, although kfence_allocation_key has been enabled, it's
still check failed here.

So I think static_key might be problematic in my qemu environment.
The change of timeout is not a problem but caused us to observe this problem.
I tried changing the wait_event to a loop. I set timeout to HZ and re-enable/disabled
in each loop, then the failed testcase disappears.

[    3.463519]     # Subtest: kfence
[    3.463629]     1..25
[    3.465548]     # test_out_of_bounds_read: test_alloc: size=128, gfp=cc0, policy=left, cache=0
[    3.561001] kfence: ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~enabled~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
[    3.561934] kfence: ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~disabled~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
[    3.665449] kfence: ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~enabled~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
[   13.464796] --------------kfence_allocation_key check failed 13839286 times----------------
[   13.467482] kfence: ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~disabled~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
[   13.469166]     # test_out_of_bounds_read: ASSERTION FAILED at mm/kfence/kfence_test.c:308
[   13.469166]     Expected false to be true, but is false
[   13.469166]
[   13.469166] failed to allocate from KFENCE
[   13.473592]     not ok 1 - test_out_of_bounds_read


diff --git a/include/linux/kfence.h b/include/linux/kfence.h
index 3fe6dd8a18c1..e72889606e82 100644
--- a/include/linux/kfence.h
+++ b/include/linux/kfence.h
@@ -25,6 +25,7 @@ extern char *__kfence_pool;
 #ifdef CONFIG_KFENCE_STATIC_KEYS
 #include <linux/static_key.h>
 DECLARE_STATIC_KEY_FALSE(kfence_allocation_key);
+extern atomic_t kfence_allocation_key_gate;
 #else
 #include <linux/atomic.h>
 extern atomic_t kfence_allocation_gate;
@@ -116,12 +117,20 @@ void *__kfence_alloc(struct kmem_cache *s, size_t size, gfp_t flags);
  */
 static __always_inline void *kfence_alloc(struct kmem_cache *s, size_t size, gfp_t flags)
 {
+       static int error;
 #ifdef CONFIG_KFENCE_STATIC_KEYS
-       if (static_branch_unlikely(&kfence_allocation_key))
+       if (static_branch_unlikely(&kfence_allocation_key)) {
 #else
-       if (unlikely(!atomic_read(&kfence_allocation_gate)))
+       if (unlikely(!atomic_read(&kfence_allocation_gate))) {
 #endif
+               if (error) {
+                       pr_info("--------------kfence_allocation_key check failed %d times----------------\n", error);
+                       error = 0;
+               }
                return __kfence_alloc(s, size, flags);
+       }
+       if (!atomic_read(&kfence_allocation_key_gate))
+               error++;
        return NULL;
 }
diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index 7a97db8bc8e7..637c2efa6133 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -100,6 +100,7 @@ static DEFINE_RAW_SPINLOCK(kfence_freelist_lock); /* Lock protecting freelist. *
 #ifdef CONFIG_KFENCE_STATIC_KEYS
 /* The static key to set up a KFENCE allocation. */
 DEFINE_STATIC_KEY_FALSE(kfence_allocation_key);
+atomic_t kfence_allocation_key_gate = ATOMIC_INIT(1);
 #endif
 
 /* Gates the allocation, ensuring only one succeeds in a given period. */
@@ -624,7 +625,9 @@ static void toggle_allocation_gate(struct work_struct *work)
 #ifdef CONFIG_KFENCE_STATIC_KEYS
        /* Enable static key, and await allocation to happen. */
        static_branch_enable(&kfence_allocation_key);
-
+       if (static_branch_unlikely(&kfence_allocation_key))
+               pr_info("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~enabled~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n");
+       atomic_set(&kfence_allocation_key_gate, 0);
        if (sysctl_hung_task_timeout_secs) {
                /*
                 * During low activity with no allocations we might wait a
@@ -637,7 +640,10 @@ static void toggle_allocation_gate(struct work_struct *work)
        }
 
        /* Disable static key and reset timer. */
+       atomic_set(&kfence_allocation_key_gate, 1);
        static_branch_disable(&kfence_allocation_key);
+       if (!static_branch_unlikely(&kfence_allocation_key))
+                       pr_info("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~disabled~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n");
 #endif
        queue_delayed_work(system_unbound_wq, &kfence_timer,
                           msecs_to_jiffies(kfence_sample_interval));

thanks,
 

