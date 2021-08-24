Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9C083F5720
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 06:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbhHXEYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 00:24:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:10730 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229568AbhHXEYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 00:24:02 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17O43FP3036884;
        Tue, 24 Aug 2021 00:23:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=yVOcYDT2FydFRnahOo/7IY16KLoG32LqTTcJOgpNTGs=;
 b=FtoMTij6Fw0GUTerB7n5kRCflskiVS/+N5qlYWcj7e5C3/2VNO2bj0hw5kYM05J/xzeY
 uJWM2y4mTz4iLsvi4b0xXgxy1shfzTRYBHTiWTQ09HcOEBj10c1xtKE2vF3nAyfyFNVt
 Ej8yoeGBUY8dWJLF2Ju46Hkn+2iT4kDo+ZUE5p5e2BCkECggj8Wpm7yc3oJicptPL+Oy
 sBHwCydgIoH1x2Lzjgw6oZPCA+ahLU8lsyKPYeDGSfWcsjbVF9p6d2AhpvDSIhMClptq
 9k3apC3HCS/XNirPTzGU3etTO3lUiIuQsFwoOWPIc2rkA0H5Xe228/tZI1eTY/RTNvpC Fg== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3amncvd0f4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Aug 2021 00:23:13 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17O4HTLn020867;
        Tue, 24 Aug 2021 04:23:10 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma01fra.de.ibm.com with ESMTP id 3ajs48bqyj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Aug 2021 04:23:10 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17O4JQa657475456
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Aug 2021 04:19:26 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E2CE611C01F;
        Tue, 24 Aug 2021 04:23:06 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 718FE11C064;
        Tue, 24 Aug 2021 04:23:06 +0000 (GMT)
Received: from localhost (unknown [9.43.24.142])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 24 Aug 2021 04:23:06 +0000 (GMT)
Date:   Tue, 24 Aug 2021 09:53:05 +0530
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCHv2 2/2] lib/percpu_test: Add extra tests in percpu_test
Message-ID: <20210824042305.f3lyi4bhj37n7y5d@riteshh-domain>
References: <5afc2a0c4da65e71ccf24fe65396710d34fc662e.1629751104.git.riteshh@linux.ibm.com>
 <e29d6768053d4e05be3cd831f4fec540fb8f77c3.1629751104.git.riteshh@linux.ibm.com>
 <YSRV6o7nJ1HCENVj@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSRV6o7nJ1HCENVj@fedora>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 75Tif3kXVmDWp3p15tnbF-lX6rCfFaMn
X-Proofpoint-GUID: 75Tif3kXVmDWp3p15tnbF-lX6rCfFaMn
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-24_01:2021-08-23,2021-08-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 clxscore=1015 spamscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108240024
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/08/23 10:14PM, Dennis Zhou wrote:
> Hello,
>
> On Tue, Aug 24, 2021 at 02:12:30AM +0530, Ritesh Harjani wrote:
> > While debugging a issue, we needed to stress test the percpu alloc/free
> > path. Hence added some tests in lib/percpu_test to stress test
> > percpu subsystem for allocation with different sizes.
> >
>
> Can you explain more about the problem you are trying to debug and why
> it required stressing the percpu allocator?

We saw a BUG_ON() in older implementation of percpu code from pcpu_free_area()
function, since it wasn't able to find an entry in the pcpu_chunk->map[].
The problem eventually ended up in a different subsystem which lead to
pcpu_chunk->map[] getting corrupted and hence hit that BUG_ON().
But at the time, we wanted to test percpu_alloc/free with all possible sizes,
before ruling out anything.

Since the problem was also seen in >4+ hrs (sometimes even more), we wrote this
test to stress more on percpu alloc and free path, to see the problem early
along with some other debugging instrumentation.

>
> > This patch keeps the default behavior of insmod module same for default
> > test. But when given insmod with different option, it can run a
> > percpu_stressd daemon (percpu_test_num=2) which does a stress test
> > evey 10secs unless the module is unloaded.
> >
> > We found this to be helpful in our testing, since with this we could
> > easily excercise percpu allo/free path. Hence cleaned this up for
> > inclusion in percpu_test module.
> >
> > Logs
> > ======
> > qemu-> sudo insmod /mnt/percpu_test.ko percpu_test_num=0
> > [  334.362973] percpu_test: INIT, interval: 1000, max_shift: 13, run_tests: percpu_verify
> > [  334.364946] TEST Starts: percpu_verify
> > [  334.365601] TEST Completed: percpu_verify
> > insmod: ERROR: could not insert module /mnt/percpu_test.ko: Resource temporarily unavailable
>
> ^ this seems wrong? What am I missing.

Original test itself in this module is written in the way that can unload
itself upon completion. So for percpu_test_num = 0 & 1, it does automatic
unload, whereas for percpu_test_num=2, tester need to unload the module.
Unload will happen if the individual test returns an error value which init
function returns too and the kernel automatically unloads this test module.

>
>
> >
> > qemu-> sudo insmod /mnt/percpu_test.ko percpu_test_num=1
> > [  336.556464] percpu_test: INIT, interval: 1000, max_shift: 13, run_tests: percpu_stress
> > [  336.558388] TEST Starts: percpu_stress
> > [  336.560611] TEST Completed: percpu_stress
> > insmod: ERROR: could not insert module /mnt/percpu_test.ko: Resource temporarily unavailable
> >
> > qemu-> sudo insmod /mnt/percpu_test.ko percpu_test_num=2
> > [  339.164406] percpu_test: INIT, interval: 1000, max_shift: 13, run_tests: percpu_stressd
> > [  339.165935] TEST Starts: percpu_stressd
> > [  339.167033] TEST Completed: percpu_stressd
> > [  339.167082] DAEMON: starts percpu_stressd
> > [  339.168498] TEST Starts: percpu_stressd: iter (1)
> > [  339.182530] TEST Completed: percpu_stressd: iter (1)
> > [  349.341109] TEST Starts: percpu_stressd: iter (2)
> > [  349.344447] TEST Completed: percpu_stressd: iter (2)
> > [  359.580829] TEST Starts: percpu_stressd: iter (3)
> > [  359.584315] TEST Completed: percpu_stressd: iter (3)
> > [  369.820471] TEST Starts: percpu_stressd: iter (4)
> > [  369.844402] TEST Completed: percpu_stressd: iter (4)
> >
> > qemu-> sudo rmmod percpu_test
> > [  375.001098] percpu_test: EXIT
> > [qemu][~]
> >
> > Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> > Cc: Vaibhav Jain <vaibhav@linux.ibm.com>
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> > ---
> > [v1 -> v2]: Fix warnings from kernel test robot
> >
> >  lib/percpu_test.c | 240 ++++++++++++++++++++++++++++++++++++----------
> >  1 file changed, 191 insertions(+), 49 deletions(-)
> >
> > diff --git a/lib/percpu_test.c b/lib/percpu_test.c
> > index 4a3d70bbc1a0..68c57c288dc6 100644
> > --- a/lib/percpu_test.c
> > +++ b/lib/percpu_test.c
> > @@ -1,4 +1,7 @@
> >  // SPDX-License-Identifier: GPL-2.0-only
> > +#include <linux/workqueue.h>
> > +#include <linux/kthread.h>
> > +#include <linux/cpu.h>
> >  #include <linux/module.h>
> >
> >  /* validate @native and @pcp counter values match @expected */
> > @@ -14,10 +17,25 @@
> >  		     (long long)(expected), (long long)(expected));	\
> >  	} while (0)
> >
> > -static DEFINE_PER_CPU(long, long_counter);
> > -static DEFINE_PER_CPU(unsigned long, ulong_counter);
>
> ^ These are good to keep fwiw as it's one of the few instances of using
> the reserved region of the first chunk of percpu memory.

Yes, sure. I can make changes to retain this.


>
> > +/* upto max alloc size tests for percpu var */
> > +static char __percpu *counters[1 << PAGE_SHIFT];
> > +static struct task_struct *percpu_stressd_thread;
> >
> > -static int __init percpu_test_init(void)
> > +/* let's not trigger OOM */
> > +int percpu_alloc_max_size_shift = PAGE_SHIFT - 3;
> > +module_param(percpu_alloc_max_size_shift, int, 0644);
> > +MODULE_PARM_DESC(percpu_alloc_max_size_shift, "max size of allocation in stress test will be upto 1 << percpu_alloc_max_size_shift");
> > +
> > +static long percpu_stressd_interval = 1 * 10 * HZ;
> > +module_param(percpu_stressd_interval, long, 0644);
> > +MODULE_PARM_DESC(percpu_stressd_interval, "percpu_stressd internal");
> > +
> > +/* keep the default test same */
> > +static int percpu_test_num;
> > +module_param(percpu_test_num, int, 0644);
> > +MODULE_PARM_DESC(percpu_test_num, "Test number percpu_test_num");
> > +
> > +static int percpu_test_verify(void)
> >  {
> >  	/*
> >  	 * volatile prevents compiler from optimizing it uses, otherwise the
> > @@ -26,109 +44,233 @@ static int __init percpu_test_init(void)
> >  	volatile unsigned int ui_one = 1;
> >  	long l = 0;
> >  	unsigned long ul = 0;
> > +	long __percpu *long_counter = alloc_percpu(long);
> > +	unsigned long __percpu *ulong_counter = alloc_percpu(unsigned long);
> >
> > -	pr_info("percpu test start\n");
> > +	if (!long_counter || !ulong_counter)
> > +		goto out;
> > +
> > +	pr_debug("percpu_test: %s start cpu: %d\n", __func__, smp_processor_id());
> >
> >  	preempt_disable();
> >
> >  	l += -1;
> > -	__this_cpu_add(long_counter, -1);
> > -	CHECK(l, long_counter, -1);
> > +	__this_cpu_add(*long_counter, -1);
> > +	CHECK(l, *long_counter, -1);
> >
> >  	l += 1;
> > -	__this_cpu_add(long_counter, 1);
> > -	CHECK(l, long_counter, 0);
> > +	__this_cpu_add(*long_counter, 1);
> > +	CHECK(l, *long_counter, 0);
> >
> >  	ul = 0;
> > -	__this_cpu_write(ulong_counter, 0);
> > +	__this_cpu_write(*ulong_counter, 0);
> >
> >  	ul += 1UL;
> > -	__this_cpu_add(ulong_counter, 1UL);
> > -	CHECK(ul, ulong_counter, 1);
> > +	__this_cpu_add(*ulong_counter, 1UL);
> > +	CHECK(ul, *ulong_counter, 1);
> >
> >  	ul += -1UL;
> > -	__this_cpu_add(ulong_counter, -1UL);
> > -	CHECK(ul, ulong_counter, 0);
> > +	__this_cpu_add(*ulong_counter, -1UL);
> > +	CHECK(ul, *ulong_counter, 0);
> >
> >  	ul += -(unsigned long)1;
> > -	__this_cpu_add(ulong_counter, -(unsigned long)1);
> > -	CHECK(ul, ulong_counter, -1);
> > +	__this_cpu_add(*ulong_counter, -(unsigned long)1);
> > +	CHECK(ul, *ulong_counter, -1);
> >
> >  	ul = 0;
> > -	__this_cpu_write(ulong_counter, 0);
> > +	__this_cpu_write(*ulong_counter, 0);
> >
> >  	ul -= 1;
> > -	__this_cpu_dec(ulong_counter);
> > -	CHECK(ul, ulong_counter, -1);
> > -	CHECK(ul, ulong_counter, ULONG_MAX);
> > +	__this_cpu_dec(*ulong_counter);
> > +	CHECK(ul, *ulong_counter, -1);
> > +	CHECK(ul, *ulong_counter, ULONG_MAX);
> >
> >  	l += -ui_one;
> > -	__this_cpu_add(long_counter, -ui_one);
> > -	CHECK(l, long_counter, 0xffffffff);
> > +	__this_cpu_add(*long_counter, -ui_one);
> > +	CHECK(l, *long_counter, 0xffffffff);
> >
> >  	l += ui_one;
> > -	__this_cpu_add(long_counter, ui_one);
> > -	CHECK(l, long_counter, (long)0x100000000LL);
> > +	__this_cpu_add(*long_counter, ui_one);
> > +	CHECK(l, *long_counter, (long)0x100000000LL);
> >
> >
> >  	l = 0;
> > -	__this_cpu_write(long_counter, 0);
> > +	__this_cpu_write(*long_counter, 0);
> >
> >  	l -= ui_one;
> > -	__this_cpu_sub(long_counter, ui_one);
> > -	CHECK(l, long_counter, -1);
> > +	__this_cpu_sub(*long_counter, ui_one);
> > +	CHECK(l, *long_counter, -1);
> >
> >  	l = 0;
> > -	__this_cpu_write(long_counter, 0);
> > +	__this_cpu_write(*long_counter, 0);
> >
> >  	l += ui_one;
> > -	__this_cpu_add(long_counter, ui_one);
> > -	CHECK(l, long_counter, 1);
> > +	__this_cpu_add(*long_counter, ui_one);
> > +	CHECK(l, *long_counter, 1);
> >
> >  	l += -ui_one;
> > -	__this_cpu_add(long_counter, -ui_one);
> > -	CHECK(l, long_counter, (long)0x100000000LL);
> > +	__this_cpu_add(*long_counter, -ui_one);
> > +	CHECK(l, *long_counter, (long)0x100000000LL);
> >
> >  	l = 0;
> > -	__this_cpu_write(long_counter, 0);
> > +	__this_cpu_write(*long_counter, 0);
> >
> >  	l -= ui_one;
> > -	this_cpu_sub(long_counter, ui_one);
> > -	CHECK(l, long_counter, -1);
> > -	CHECK(l, long_counter, ULONG_MAX);
> > +	this_cpu_sub(*long_counter, ui_one);
> > +	CHECK(l, *long_counter, -1);
> > +	CHECK(l, *long_counter, ULONG_MAX);
> >
> >  	ul = 0;
> > -	__this_cpu_write(ulong_counter, 0);
> > +	__this_cpu_write(*ulong_counter, 0);
> >
> >  	ul += ui_one;
> > -	__this_cpu_add(ulong_counter, ui_one);
> > -	CHECK(ul, ulong_counter, 1);
> > +	__this_cpu_add(*ulong_counter, ui_one);
> > +	CHECK(ul, *ulong_counter, 1);
> >
> >  	ul = 0;
> > -	__this_cpu_write(ulong_counter, 0);
> > +	__this_cpu_write(*ulong_counter, 0);
> >
> >  	ul -= ui_one;
> > -	__this_cpu_sub(ulong_counter, ui_one);
> > -	CHECK(ul, ulong_counter, -1);
> > -	CHECK(ul, ulong_counter, ULONG_MAX);
> > +	__this_cpu_sub(*ulong_counter, ui_one);
> > +	CHECK(ul, *ulong_counter, -1);
> > +	CHECK(ul, *ulong_counter, ULONG_MAX);
> >
> >  	ul = 3;
> > -	__this_cpu_write(ulong_counter, 3);
> > +	__this_cpu_write(*ulong_counter, 3);
> >
> > -	ul = this_cpu_sub_return(ulong_counter, ui_one);
> > -	CHECK(ul, ulong_counter, 2);
> > +	ul = this_cpu_sub_return(*ulong_counter, ui_one);
> > +	CHECK(ul, *ulong_counter, 2);
> >
> > -	ul = __this_cpu_sub_return(ulong_counter, ui_one);
> > -	CHECK(ul, ulong_counter, 1);
> > +	ul = __this_cpu_sub_return(*ulong_counter, ui_one);
> > +	CHECK(ul, *ulong_counter, 1);
> >
> >  	preempt_enable();
> >
> > -	pr_info("percpu test done\n");
> > -	return -EAGAIN;  /* Fail will directly unload the module */
> > +out:
> > +	free_percpu(long_counter);
> > +	free_percpu(ulong_counter);
> > +	pr_debug("percpu_test: %s done cpu: %d\n", __func__, smp_processor_id());
> > +
> > +	/*
> > +	 * Keep the default functionality same.
> > +	 * Fail will directly unload this module.
> > +	 */
> > +	return -EAGAIN;
> > +}
> > +
> > +static void percpu_test_verify_work(struct work_struct *work)
> > +{
> > +	percpu_test_verify();
> > +}
> > +
> > +static int percpu_test_stress(void)
> > +{
> > +	int i;
> > +
> > +	for (i = 1; i < (1 << percpu_alloc_max_size_shift); i++) {
> > +		size_t size = i;
> > +
> > +		if (size > PCPU_MIN_ALLOC_SIZE)
> > +			break;
> > +		counters[i] = (char __percpu *)__alloc_percpu(size, __alignof__(char));
> > +		if (!counters[i])
> > +			break;
> > +		cond_resched();
> > +	}
> > +
> > +	schedule_on_each_cpu(percpu_test_verify_work);
>
> I'm not understanding the value of scheduling on each cpu here? Each
> CHECK() call is accessing the value via __this_cpu_read() meaning it has
> nothing to do with any other cpu's copy of the variable?

Yes, that is true. This I wrote, since we just wanted some work to happen on
each cpu before freeing all the percpu vars, hence scheduled
percpu_test_verify function to run and verify the original test on each cpu.

Dennis,
Let me know in case if you want me to make any additions to this stress test.
I can make such changes too which we think will be more useful.

This stress test was useful at the time of initial debugging for us.
But if you find something to be added which can add more value to this, I can
certainly do that.

Thanks
-ritesh

>
> > +
> > +	for (i = 0; i < (1 << percpu_alloc_max_size_shift); i++) {
> > +		free_percpu(counters[i]);
> > +		cond_resched();
> > +	}
> > +	return -EAGAIN;
> > +}
> > +
> > +static int percpu_stressd(void *v)
> > +{
> > +	int iter = 0;
> > +
> > +	pr_info("DAEMON: starts %s\n", __func__);
> > +	do {
> > +		if (kthread_should_stop())
> > +			break;
> > +		iter++;
> > +		pr_info("TEST Starts: %s: iter (%d)\n", __func__, iter);
> > +		percpu_test_stress();
> > +		pr_info("TEST Completed: %s: iter (%d)\n", __func__, iter);
> > +
> > +		set_current_state(TASK_INTERRUPTIBLE);
> > +		schedule_timeout(percpu_stressd_interval);
> > +	} while (1);
> > +
> > +	return 0;
> > +}
> > +
> > +static int percpu_test_stressd(void)
> > +{
> > +	percpu_stressd_thread = kthread_run(percpu_stressd, NULL, "percpu_stressd");
> > +	if (IS_ERR(percpu_stressd_thread))
> > +		percpu_stressd_thread = NULL;
> > +	return 0;
> > +}
> > +
> > +enum test_type {
> > +	PERCPU_VERIFY,
> > +	PERCPU_STRESS,
> > +	PERCPU_STRESSD,
> > +	NR_TESTS,
> > +};
> > +
> > +const char *test_names[NR_TESTS] = {
> > +	[PERCPU_VERIFY] = "percpu_verify",
> > +	[PERCPU_STRESS] = "percpu_stress",
> > +	[PERCPU_STRESSD] = "percpu_stressd",
> > +};
> > +
> > +static int __init percpu_test_init(void)
> > +{
> > +	int i, ret = 0;
> > +	typedef int (*percpu_tests)(void);
> > +	const percpu_tests test_funcs[NR_TESTS] = {
> > +		[PERCPU_VERIFY] = percpu_test_verify,
> > +		[PERCPU_STRESS] = percpu_test_stress,
> > +		[PERCPU_STRESSD] = percpu_test_stressd,
> > +	};
> > +
> > +	/* sanity checks */
> > +	if (percpu_alloc_max_size_shift > PAGE_SHIFT)
> > +		percpu_alloc_max_size_shift = PAGE_SHIFT;
> > +	if (percpu_test_num > NR_TESTS)
> > +		percpu_test_num = NR_TESTS;
> > +
> > +	pr_info("percpu_test: INIT, interval: %ld, max_shift: %d, run_tests: %s\n",
> > +			percpu_stressd_interval, percpu_alloc_max_size_shift,
> > +			percpu_test_num == NR_TESTS ? "run all tests" :
> > +			test_names[percpu_test_num]);
> > +
> > +	/* run a given test */
> > +	if (percpu_test_num < NR_TESTS) {
> > +		pr_info("TEST Starts: %s\n", test_names[percpu_test_num]);
> > +		ret = test_funcs[percpu_test_num]();
> > +		pr_info("TEST Completed: %s\n", test_names[percpu_test_num]);
> > +		goto out;
> > +	}
> > +
> > +	for (i = 0; i < NR_TESTS; i++) {
> > +		pr_info("TEST Starts: %s\n", test_names[i]);
> > +		test_funcs[i]();
> > +		pr_info("TEST Completed: %s\n", test_names[i]);
> > +	}
> > +out:
> > +	return ret;
> >  }
> >
> >  static void __exit percpu_test_exit(void)
> >  {
> > +	if (percpu_stressd_thread)
> > +		kthread_stop(percpu_stressd_thread);
> > +	pr_info("percpu_test: EXIT\n");
> >  }
> >
> >  module_init(percpu_test_init)
> > --
> > 2.31.1
> >
>
> Thanks,
> Dennis
