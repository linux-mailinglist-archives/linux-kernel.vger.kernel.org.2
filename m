Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9433F55B4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 04:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233769AbhHXCOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 22:14:49 -0400
Received: from mail-qv1-f53.google.com ([209.85.219.53]:42941 "EHLO
        mail-qv1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233145AbhHXCOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 22:14:48 -0400
Received: by mail-qv1-f53.google.com with SMTP id c14so10873042qvs.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 19:14:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ya8SlNQty6mh8457AcvIZ0Nm3y/y4F76ffUOZipML+g=;
        b=Wa9nFqBAljZ1Jib0gjjoNKpLDnySykfSklfj2vZC0lzNbH1vdltNcfVBkbVr/2EOO9
         IEj2On1eKW/Hrotbi52B1GtAlNy08jb8YEvsTRCjl1movQdIhBBX1T3KUQOW7fxJzkPy
         SYpAukw8SZGVKGPXnKY4V/52Vmam4OFaltU9sy33NHrO8RCtbx+HLqC87tagjYsW4Bgz
         e7aiObJ+2GvdGYO4LzHraOad8qf/qDNlUS0UuOvMu8plMqw+OpkWZ18lKauf2j38ClfQ
         +AK6Z/xB88deof20AazKJhqldZe6J3YSg1S7hh8I+CxPJJXSpktT+XbNsxrMmaK33NgL
         umSw==
X-Gm-Message-State: AOAM530PFanDq+Y7Ss34HYeP9wEHe7u7zNK6KHOjeeT2AB6huGfqJvOz
        mcWM2OnTfEg1RpQlv5hvqRlJLX/a6uP/Qw==
X-Google-Smtp-Source: ABdhPJxQ1I/xffrIBH6ZM+mqHO9342ko5BbBIy58xf3OF33L+6GgLhzMQNmzCSGIRcydxSH+XUahBg==
X-Received: by 2002:a05:6214:ca2:: with SMTP id s2mr36569213qvs.35.1629771244512;
        Mon, 23 Aug 2021 19:14:04 -0700 (PDT)
Received: from fedora (pool-173-68-57-129.nycmny.fios.verizon.net. [173.68.57.129])
        by smtp.gmail.com with ESMTPSA id g20sm9599605qki.73.2021.08.23.19.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 19:14:03 -0700 (PDT)
Date:   Mon, 23 Aug 2021 22:14:02 -0400
From:   Dennis Zhou <dennis@kernel.org>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCHv2 2/2] lib/percpu_test: Add extra tests in percpu_test
Message-ID: <YSRV6o7nJ1HCENVj@fedora>
References: <5afc2a0c4da65e71ccf24fe65396710d34fc662e.1629751104.git.riteshh@linux.ibm.com>
 <e29d6768053d4e05be3cd831f4fec540fb8f77c3.1629751104.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e29d6768053d4e05be3cd831f4fec540fb8f77c3.1629751104.git.riteshh@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Aug 24, 2021 at 02:12:30AM +0530, Ritesh Harjani wrote:
> While debugging a issue, we needed to stress test the percpu alloc/free
> path. Hence added some tests in lib/percpu_test to stress test
> percpu subsystem for allocation with different sizes.
> 

Can you explain more about the problem you are trying to debug and why
it required stressing the percpu allocator?

> This patch keeps the default behavior of insmod module same for default
> test. But when given insmod with different option, it can run a
> percpu_stressd daemon (percpu_test_num=2) which does a stress test
> evey 10secs unless the module is unloaded.
> 
> We found this to be helpful in our testing, since with this we could
> easily excercise percpu allo/free path. Hence cleaned this up for
> inclusion in percpu_test module.
> 
> Logs
> ======
> qemu-> sudo insmod /mnt/percpu_test.ko percpu_test_num=0
> [  334.362973] percpu_test: INIT, interval: 1000, max_shift: 13, run_tests: percpu_verify
> [  334.364946] TEST Starts: percpu_verify
> [  334.365601] TEST Completed: percpu_verify
> insmod: ERROR: could not insert module /mnt/percpu_test.ko: Resource temporarily unavailable

^ this seems wrong? What am I missing.

> 
> qemu-> sudo insmod /mnt/percpu_test.ko percpu_test_num=1
> [  336.556464] percpu_test: INIT, interval: 1000, max_shift: 13, run_tests: percpu_stress
> [  336.558388] TEST Starts: percpu_stress
> [  336.560611] TEST Completed: percpu_stress
> insmod: ERROR: could not insert module /mnt/percpu_test.ko: Resource temporarily unavailable
> 
> qemu-> sudo insmod /mnt/percpu_test.ko percpu_test_num=2
> [  339.164406] percpu_test: INIT, interval: 1000, max_shift: 13, run_tests: percpu_stressd
> [  339.165935] TEST Starts: percpu_stressd
> [  339.167033] TEST Completed: percpu_stressd
> [  339.167082] DAEMON: starts percpu_stressd
> [  339.168498] TEST Starts: percpu_stressd: iter (1)
> [  339.182530] TEST Completed: percpu_stressd: iter (1)
> [  349.341109] TEST Starts: percpu_stressd: iter (2)
> [  349.344447] TEST Completed: percpu_stressd: iter (2)
> [  359.580829] TEST Starts: percpu_stressd: iter (3)
> [  359.584315] TEST Completed: percpu_stressd: iter (3)
> [  369.820471] TEST Starts: percpu_stressd: iter (4)
> [  369.844402] TEST Completed: percpu_stressd: iter (4)
> 
> qemu-> sudo rmmod percpu_test
> [  375.001098] percpu_test: EXIT
> [qemu][~]
> 
> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Cc: Vaibhav Jain <vaibhav@linux.ibm.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> ---
> [v1 -> v2]: Fix warnings from kernel test robot
> 
>  lib/percpu_test.c | 240 ++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 191 insertions(+), 49 deletions(-)
> 
> diff --git a/lib/percpu_test.c b/lib/percpu_test.c
> index 4a3d70bbc1a0..68c57c288dc6 100644
> --- a/lib/percpu_test.c
> +++ b/lib/percpu_test.c
> @@ -1,4 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> +#include <linux/workqueue.h>
> +#include <linux/kthread.h>
> +#include <linux/cpu.h>
>  #include <linux/module.h>
> 
>  /* validate @native and @pcp counter values match @expected */
> @@ -14,10 +17,25 @@
>  		     (long long)(expected), (long long)(expected));	\
>  	} while (0)
> 
> -static DEFINE_PER_CPU(long, long_counter);
> -static DEFINE_PER_CPU(unsigned long, ulong_counter);

^ These are good to keep fwiw as it's one of the few instances of using
the reserved region of the first chunk of percpu memory.

> +/* upto max alloc size tests for percpu var */
> +static char __percpu *counters[1 << PAGE_SHIFT];
> +static struct task_struct *percpu_stressd_thread;
> 
> -static int __init percpu_test_init(void)
> +/* let's not trigger OOM */
> +int percpu_alloc_max_size_shift = PAGE_SHIFT - 3;
> +module_param(percpu_alloc_max_size_shift, int, 0644);
> +MODULE_PARM_DESC(percpu_alloc_max_size_shift, "max size of allocation in stress test will be upto 1 << percpu_alloc_max_size_shift");
> +
> +static long percpu_stressd_interval = 1 * 10 * HZ;
> +module_param(percpu_stressd_interval, long, 0644);
> +MODULE_PARM_DESC(percpu_stressd_interval, "percpu_stressd internal");
> +
> +/* keep the default test same */
> +static int percpu_test_num;
> +module_param(percpu_test_num, int, 0644);
> +MODULE_PARM_DESC(percpu_test_num, "Test number percpu_test_num");
> +
> +static int percpu_test_verify(void)
>  {
>  	/*
>  	 * volatile prevents compiler from optimizing it uses, otherwise the
> @@ -26,109 +44,233 @@ static int __init percpu_test_init(void)
>  	volatile unsigned int ui_one = 1;
>  	long l = 0;
>  	unsigned long ul = 0;
> +	long __percpu *long_counter = alloc_percpu(long);
> +	unsigned long __percpu *ulong_counter = alloc_percpu(unsigned long);
> 
> -	pr_info("percpu test start\n");
> +	if (!long_counter || !ulong_counter)
> +		goto out;
> +
> +	pr_debug("percpu_test: %s start cpu: %d\n", __func__, smp_processor_id());
> 
>  	preempt_disable();
> 
>  	l += -1;
> -	__this_cpu_add(long_counter, -1);
> -	CHECK(l, long_counter, -1);
> +	__this_cpu_add(*long_counter, -1);
> +	CHECK(l, *long_counter, -1);
> 
>  	l += 1;
> -	__this_cpu_add(long_counter, 1);
> -	CHECK(l, long_counter, 0);
> +	__this_cpu_add(*long_counter, 1);
> +	CHECK(l, *long_counter, 0);
> 
>  	ul = 0;
> -	__this_cpu_write(ulong_counter, 0);
> +	__this_cpu_write(*ulong_counter, 0);
> 
>  	ul += 1UL;
> -	__this_cpu_add(ulong_counter, 1UL);
> -	CHECK(ul, ulong_counter, 1);
> +	__this_cpu_add(*ulong_counter, 1UL);
> +	CHECK(ul, *ulong_counter, 1);
> 
>  	ul += -1UL;
> -	__this_cpu_add(ulong_counter, -1UL);
> -	CHECK(ul, ulong_counter, 0);
> +	__this_cpu_add(*ulong_counter, -1UL);
> +	CHECK(ul, *ulong_counter, 0);
> 
>  	ul += -(unsigned long)1;
> -	__this_cpu_add(ulong_counter, -(unsigned long)1);
> -	CHECK(ul, ulong_counter, -1);
> +	__this_cpu_add(*ulong_counter, -(unsigned long)1);
> +	CHECK(ul, *ulong_counter, -1);
> 
>  	ul = 0;
> -	__this_cpu_write(ulong_counter, 0);
> +	__this_cpu_write(*ulong_counter, 0);
> 
>  	ul -= 1;
> -	__this_cpu_dec(ulong_counter);
> -	CHECK(ul, ulong_counter, -1);
> -	CHECK(ul, ulong_counter, ULONG_MAX);
> +	__this_cpu_dec(*ulong_counter);
> +	CHECK(ul, *ulong_counter, -1);
> +	CHECK(ul, *ulong_counter, ULONG_MAX);
> 
>  	l += -ui_one;
> -	__this_cpu_add(long_counter, -ui_one);
> -	CHECK(l, long_counter, 0xffffffff);
> +	__this_cpu_add(*long_counter, -ui_one);
> +	CHECK(l, *long_counter, 0xffffffff);
> 
>  	l += ui_one;
> -	__this_cpu_add(long_counter, ui_one);
> -	CHECK(l, long_counter, (long)0x100000000LL);
> +	__this_cpu_add(*long_counter, ui_one);
> +	CHECK(l, *long_counter, (long)0x100000000LL);
> 
> 
>  	l = 0;
> -	__this_cpu_write(long_counter, 0);
> +	__this_cpu_write(*long_counter, 0);
> 
>  	l -= ui_one;
> -	__this_cpu_sub(long_counter, ui_one);
> -	CHECK(l, long_counter, -1);
> +	__this_cpu_sub(*long_counter, ui_one);
> +	CHECK(l, *long_counter, -1);
> 
>  	l = 0;
> -	__this_cpu_write(long_counter, 0);
> +	__this_cpu_write(*long_counter, 0);
> 
>  	l += ui_one;
> -	__this_cpu_add(long_counter, ui_one);
> -	CHECK(l, long_counter, 1);
> +	__this_cpu_add(*long_counter, ui_one);
> +	CHECK(l, *long_counter, 1);
> 
>  	l += -ui_one;
> -	__this_cpu_add(long_counter, -ui_one);
> -	CHECK(l, long_counter, (long)0x100000000LL);
> +	__this_cpu_add(*long_counter, -ui_one);
> +	CHECK(l, *long_counter, (long)0x100000000LL);
> 
>  	l = 0;
> -	__this_cpu_write(long_counter, 0);
> +	__this_cpu_write(*long_counter, 0);
> 
>  	l -= ui_one;
> -	this_cpu_sub(long_counter, ui_one);
> -	CHECK(l, long_counter, -1);
> -	CHECK(l, long_counter, ULONG_MAX);
> +	this_cpu_sub(*long_counter, ui_one);
> +	CHECK(l, *long_counter, -1);
> +	CHECK(l, *long_counter, ULONG_MAX);
> 
>  	ul = 0;
> -	__this_cpu_write(ulong_counter, 0);
> +	__this_cpu_write(*ulong_counter, 0);
> 
>  	ul += ui_one;
> -	__this_cpu_add(ulong_counter, ui_one);
> -	CHECK(ul, ulong_counter, 1);
> +	__this_cpu_add(*ulong_counter, ui_one);
> +	CHECK(ul, *ulong_counter, 1);
> 
>  	ul = 0;
> -	__this_cpu_write(ulong_counter, 0);
> +	__this_cpu_write(*ulong_counter, 0);
> 
>  	ul -= ui_one;
> -	__this_cpu_sub(ulong_counter, ui_one);
> -	CHECK(ul, ulong_counter, -1);
> -	CHECK(ul, ulong_counter, ULONG_MAX);
> +	__this_cpu_sub(*ulong_counter, ui_one);
> +	CHECK(ul, *ulong_counter, -1);
> +	CHECK(ul, *ulong_counter, ULONG_MAX);
> 
>  	ul = 3;
> -	__this_cpu_write(ulong_counter, 3);
> +	__this_cpu_write(*ulong_counter, 3);
> 
> -	ul = this_cpu_sub_return(ulong_counter, ui_one);
> -	CHECK(ul, ulong_counter, 2);
> +	ul = this_cpu_sub_return(*ulong_counter, ui_one);
> +	CHECK(ul, *ulong_counter, 2);
> 
> -	ul = __this_cpu_sub_return(ulong_counter, ui_one);
> -	CHECK(ul, ulong_counter, 1);
> +	ul = __this_cpu_sub_return(*ulong_counter, ui_one);
> +	CHECK(ul, *ulong_counter, 1);
> 
>  	preempt_enable();
> 
> -	pr_info("percpu test done\n");
> -	return -EAGAIN;  /* Fail will directly unload the module */
> +out:
> +	free_percpu(long_counter);
> +	free_percpu(ulong_counter);
> +	pr_debug("percpu_test: %s done cpu: %d\n", __func__, smp_processor_id());
> +
> +	/*
> +	 * Keep the default functionality same.
> +	 * Fail will directly unload this module.
> +	 */
> +	return -EAGAIN;
> +}
> +
> +static void percpu_test_verify_work(struct work_struct *work)
> +{
> +	percpu_test_verify();
> +}
> +
> +static int percpu_test_stress(void)
> +{
> +	int i;
> +
> +	for (i = 1; i < (1 << percpu_alloc_max_size_shift); i++) {
> +		size_t size = i;
> +
> +		if (size > PCPU_MIN_ALLOC_SIZE)
> +			break;
> +		counters[i] = (char __percpu *)__alloc_percpu(size, __alignof__(char));
> +		if (!counters[i])
> +			break;
> +		cond_resched();
> +	}
> +
> +	schedule_on_each_cpu(percpu_test_verify_work);

I'm not understanding the value of scheduling on each cpu here? Each
CHECK() call is accessing the value via __this_cpu_read() meaning it has
nothing to do with any other cpu's copy of the variable?

> +
> +	for (i = 0; i < (1 << percpu_alloc_max_size_shift); i++) {
> +		free_percpu(counters[i]);
> +		cond_resched();
> +	}
> +	return -EAGAIN;
> +}
> +
> +static int percpu_stressd(void *v)
> +{
> +	int iter = 0;
> +
> +	pr_info("DAEMON: starts %s\n", __func__);
> +	do {
> +		if (kthread_should_stop())
> +			break;
> +		iter++;
> +		pr_info("TEST Starts: %s: iter (%d)\n", __func__, iter);
> +		percpu_test_stress();
> +		pr_info("TEST Completed: %s: iter (%d)\n", __func__, iter);
> +
> +		set_current_state(TASK_INTERRUPTIBLE);
> +		schedule_timeout(percpu_stressd_interval);
> +	} while (1);
> +
> +	return 0;
> +}
> +
> +static int percpu_test_stressd(void)
> +{
> +	percpu_stressd_thread = kthread_run(percpu_stressd, NULL, "percpu_stressd");
> +	if (IS_ERR(percpu_stressd_thread))
> +		percpu_stressd_thread = NULL;
> +	return 0;
> +}
> +
> +enum test_type {
> +	PERCPU_VERIFY,
> +	PERCPU_STRESS,
> +	PERCPU_STRESSD,
> +	NR_TESTS,
> +};
> +
> +const char *test_names[NR_TESTS] = {
> +	[PERCPU_VERIFY] = "percpu_verify",
> +	[PERCPU_STRESS] = "percpu_stress",
> +	[PERCPU_STRESSD] = "percpu_stressd",
> +};
> +
> +static int __init percpu_test_init(void)
> +{
> +	int i, ret = 0;
> +	typedef int (*percpu_tests)(void);
> +	const percpu_tests test_funcs[NR_TESTS] = {
> +		[PERCPU_VERIFY] = percpu_test_verify,
> +		[PERCPU_STRESS] = percpu_test_stress,
> +		[PERCPU_STRESSD] = percpu_test_stressd,
> +	};
> +
> +	/* sanity checks */
> +	if (percpu_alloc_max_size_shift > PAGE_SHIFT)
> +		percpu_alloc_max_size_shift = PAGE_SHIFT;
> +	if (percpu_test_num > NR_TESTS)
> +		percpu_test_num = NR_TESTS;
> +
> +	pr_info("percpu_test: INIT, interval: %ld, max_shift: %d, run_tests: %s\n",
> +			percpu_stressd_interval, percpu_alloc_max_size_shift,
> +			percpu_test_num == NR_TESTS ? "run all tests" :
> +			test_names[percpu_test_num]);
> +
> +	/* run a given test */
> +	if (percpu_test_num < NR_TESTS) {
> +		pr_info("TEST Starts: %s\n", test_names[percpu_test_num]);
> +		ret = test_funcs[percpu_test_num]();
> +		pr_info("TEST Completed: %s\n", test_names[percpu_test_num]);
> +		goto out;
> +	}
> +
> +	for (i = 0; i < NR_TESTS; i++) {
> +		pr_info("TEST Starts: %s\n", test_names[i]);
> +		test_funcs[i]();
> +		pr_info("TEST Completed: %s\n", test_names[i]);
> +	}
> +out:
> +	return ret;
>  }
> 
>  static void __exit percpu_test_exit(void)
>  {
> +	if (percpu_stressd_thread)
> +		kthread_stop(percpu_stressd_thread);
> +	pr_info("percpu_test: EXIT\n");
>  }
> 
>  module_init(percpu_test_init)
> --
> 2.31.1
> 

Thanks,
Dennis
