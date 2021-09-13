Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 852064097B0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 17:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244967AbhIMPpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 11:45:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4862 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233005AbhIMPp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 11:45:29 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18DF4dDa006038;
        Mon, 13 Sep 2021 11:43:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=i9W4ocivWrpXA+p8C+55pbEEj3IWrGKTsGA9vaxpMRA=;
 b=YN/72bgV2yMWcfQF4Q23ki2OAg1zxBPWc4nKq78GXeGU1t73dBg6T1WwppL6oqAYR1+j
 hE1EVHuiA+uhOI1S6/QcGRrLh9ao4PvsUeAsm0SCALruMLS1gTrEEI/1c/YZSRK+SgXN
 BdfaZnV8WMKxBp8ynGcSsTcum1/FFBgQ7361QNjvku3ZUSeUPXEBjQAgC8EOdXASo0l7
 8hyMz58w9Iq9dDW60/delfeAEyz79bjPsv+s4u1UwFyCuLBA6D1fLmBpJDpHv0hi92kD
 gZx29nJl9VicW+X90/xtIcQ95OHdc47+4B4Dp0ghHwtvDZsWwvownE5Dg46Kq2o61CbC tg== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3b23ja2k8g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Sep 2021 11:43:52 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18DFY5VY018812;
        Mon, 13 Sep 2021 15:43:51 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03fra.de.ibm.com with ESMTP id 3b0m391pun-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Sep 2021 15:43:51 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18DFhmUJ56361342
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Sep 2021 15:43:48 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7DDEE11C066;
        Mon, 13 Sep 2021 15:43:48 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2CDB011C050;
        Mon, 13 Sep 2021 15:43:48 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 13 Sep 2021 15:43:48 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kprobes: convert tests to kunit
References: <20210913092748.1763259-1-svens@linux.ibm.com>
        <20210914000228.3ada4fc2e339b5007ce39d04@kernel.org>
Date:   Mon, 13 Sep 2021 17:43:47 +0200
In-Reply-To: <20210914000228.3ada4fc2e339b5007ce39d04@kernel.org> (Masami
        Hiramatsu's message of "Tue, 14 Sep 2021 00:02:28 +0900")
Message-ID: <yt9dk0jkbhvw.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yOuPlqAzI-hdcQrPGKIF7z9I3fPyXEM4
X-Proofpoint-ORIG-GUID: yOuPlqAzI-hdcQrPGKIF7z9I3fPyXEM4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 suspectscore=0 impostorscore=0 adultscore=0 spamscore=0
 mlxscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1011
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109130048
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masami Hiramatsu <mhiramat@kernel.org> writes:

[ +CC linux-kernel, missed that in the initial message ]

> On Mon, 13 Sep 2021 11:27:48 +0200
> Sven Schnelle <svens@linux.ibm.com> wrote:
>
> Great! thanks for you updating the test case.
> BTW, can you add some description for this patch?

Not sure what to write there, as the conversion is pretty
self-explaining. I'll think about it :-)

>> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
>> ---
>>  kernel/kprobes.c      |   3 -
>>  kernel/test_kprobes.c | 223 ++++++++++++------------------------------
>>  lib/Kconfig.debug     |   1 +
>>  3 files changed, 62 insertions(+), 165 deletions(-)
>> 
>> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
>> index 790a573bbe00..adf6ed1932c2 100644
>> --- a/kernel/kprobes.c
>> +++ b/kernel/kprobes.c
>> @@ -2508,9 +2508,6 @@ static int __init init_kprobes(void)
>>  		err = register_module_notifier(&kprobe_module_nb);
>>  
>>  	kprobes_initialized = (err == 0);
>> -
>> -	if (!err)
>> -		init_test_probes();
>
> Also, I'm interested in when the test will be executed.

I checked the kunit code, and the unit tests run as late initcall,
while kprobes is an early initcall. So the ordering should still be
fine. If you think the sanity tests should run immediately after kprobes
startup, i'm not sure whether that's possible with kunit.

> Thank you,
>
>>  	return err;
>>  }
>>  early_initcall(init_kprobes);
>> diff --git a/kernel/test_kprobes.c b/kernel/test_kprobes.c
>> index 76c997fdbc9d..06adede697a4 100644
>> --- a/kernel/test_kprobes.c
>> +++ b/kernel/test_kprobes.c
>> @@ -5,18 +5,17 @@
>>   * Copyright IBM Corp. 2008
>>   */
>>  
>> -#define pr_fmt(fmt) "Kprobe smoke test: " fmt
>> -
>>  #include <linux/kernel.h>
>>  #include <linux/kprobes.h>
>>  #include <linux/random.h>
>> +#include <kunit/test.h>
>>  
>>  #define div_factor 3
>>  
>>  static u32 rand1, preh_val, posth_val;
>> -static int errors, handler_errors, num_tests;
>>  static u32 (*target)(u32 value);
>>  static u32 (*target2)(u32 value);
>> +static struct kunit *current_test;
>>  
>>  static noinline u32 kprobe_target(u32 value)
>>  {
>> @@ -25,10 +24,7 @@ static noinline u32 kprobe_target(u32 value)
>>  
>>  static int kp_pre_handler(struct kprobe *p, struct pt_regs *regs)
>>  {
>> -	if (preemptible()) {
>> -		handler_errors++;
>> -		pr_err("pre-handler is preemptible\n");
>> -	}
>> +	KUNIT_EXPECT_FALSE(current_test, preemptible());
>>  	preh_val = (rand1 / div_factor);
>>  	return 0;
>>  }
>> @@ -36,14 +32,8 @@ static int kp_pre_handler(struct kprobe *p, struct pt_regs *regs)
>>  static void kp_post_handler(struct kprobe *p, struct pt_regs *regs,
>>  		unsigned long flags)
>>  {
>> -	if (preemptible()) {
>> -		handler_errors++;
>> -		pr_err("post-handler is preemptible\n");
>> -	}
>> -	if (preh_val != (rand1 / div_factor)) {
>> -		handler_errors++;
>> -		pr_err("incorrect value in post_handler\n");
>> -	}
>> +	KUNIT_EXPECT_FALSE(current_test, preemptible());
>> +	KUNIT_EXPECT_EQ(current_test, preh_val, (rand1 / div_factor));
>>  	posth_val = preh_val + div_factor;
>>  }
>>  
>> @@ -53,30 +43,14 @@ static struct kprobe kp = {
>>  	.post_handler = kp_post_handler
>>  };
>>  
>> -static int test_kprobe(void)
>> +static void test_kprobe(struct kunit *test)
>>  {
>> -	int ret;
>> -
>> -	ret = register_kprobe(&kp);
>> -	if (ret < 0) {
>> -		pr_err("register_kprobe returned %d\n", ret);
>> -		return ret;
>> -	}
>> -
>> -	ret = target(rand1);
>> +	current_test = test;
>> +	KUNIT_EXPECT_EQ(test, 0, register_kprobe(&kp));
>> +	target(rand1);
>>  	unregister_kprobe(&kp);
>> -
>> -	if (preh_val == 0) {
>> -		pr_err("kprobe pre_handler not called\n");
>> -		handler_errors++;
>> -	}
>> -
>> -	if (posth_val == 0) {
>> -		pr_err("kprobe post_handler not called\n");
>> -		handler_errors++;
>> -	}
>> -
>> -	return 0;
>> +	KUNIT_EXPECT_NE(test, 0, preh_val);
>> +	KUNIT_EXPECT_NE(test, 0, posth_val);
>>  }
>>  
>>  static noinline u32 kprobe_target2(u32 value)
>> @@ -93,10 +67,7 @@ static int kp_pre_handler2(struct kprobe *p, struct pt_regs *regs)
>>  static void kp_post_handler2(struct kprobe *p, struct pt_regs *regs,
>>  		unsigned long flags)
>>  {
>> -	if (preh_val != (rand1 / div_factor) + 1) {
>> -		handler_errors++;
>> -		pr_err("incorrect value in post_handler2\n");
>> -	}
>> +	KUNIT_EXPECT_EQ(current_test, preh_val, (rand1 / div_factor) + 1);
>>  	posth_val = preh_val + div_factor;
>>  }
>>  
>> @@ -106,51 +77,31 @@ static struct kprobe kp2 = {
>>  	.post_handler = kp_post_handler2
>>  };
>>  
>> -static int test_kprobes(void)
>> +static void test_kprobes(struct kunit *test)
>>  {
>> -	int ret;
>>  	struct kprobe *kps[2] = {&kp, &kp2};
>>  
>> +	current_test = test;
>> +
>>  	/* addr and flags should be cleard for reusing kprobe. */
>>  	kp.addr = NULL;
>>  	kp.flags = 0;
>> -	ret = register_kprobes(kps, 2);
>> -	if (ret < 0) {
>> -		pr_err("register_kprobes returned %d\n", ret);
>> -		return ret;
>> -	}
>>  
>> +	KUNIT_EXPECT_EQ(test, 0, register_kprobes(kps, 2));
>>  	preh_val = 0;
>>  	posth_val = 0;
>> -	ret = target(rand1);
>> +	target(rand1);
>>  
>> -	if (preh_val == 0) {
>> -		pr_err("kprobe pre_handler not called\n");
>> -		handler_errors++;
>> -	}
>> -
>> -	if (posth_val == 0) {
>> -		pr_err("kprobe post_handler not called\n");
>> -		handler_errors++;
>> -	}
>> +	KUNIT_EXPECT_NE(test, 0, preh_val);
>> +	KUNIT_EXPECT_NE(test, 0, posth_val);
>>  
>>  	preh_val = 0;
>>  	posth_val = 0;
>> -	ret = target2(rand1);
>> -
>> -	if (preh_val == 0) {
>> -		pr_err("kprobe pre_handler2 not called\n");
>> -		handler_errors++;
>> -	}
>> -
>> -	if (posth_val == 0) {
>> -		pr_err("kprobe post_handler2 not called\n");
>> -		handler_errors++;
>> -	}
>> +	target2(rand1);
>>  
>> +	KUNIT_EXPECT_NE(test, 0, preh_val);
>> +	KUNIT_EXPECT_NE(test, 0, posth_val);
>>  	unregister_kprobes(kps, 2);
>> -	return 0;
>> -
>>  }
>>  
>>  #ifdef CONFIG_KRETPROBES
>> @@ -158,10 +109,7 @@ static u32 krph_val;
>>  
>>  static int entry_handler(struct kretprobe_instance *ri, struct pt_regs *regs)
>>  {
>> -	if (preemptible()) {
>> -		handler_errors++;
>> -		pr_err("kretprobe entry handler is preemptible\n");
>> -	}
>> +	KUNIT_EXPECT_FALSE(current_test, preemptible());
>>  	krph_val = (rand1 / div_factor);
>>  	return 0;
>>  }
>> @@ -170,19 +118,9 @@ static int return_handler(struct kretprobe_instance *ri, struct pt_regs *regs)
>>  {
>>  	unsigned long ret = regs_return_value(regs);
>>  
>> -	if (preemptible()) {
>> -		handler_errors++;
>> -		pr_err("kretprobe return handler is preemptible\n");
>> -	}
>> -	if (ret != (rand1 / div_factor)) {
>> -		handler_errors++;
>> -		pr_err("incorrect value in kretprobe handler\n");
>> -	}
>> -	if (krph_val == 0) {
>> -		handler_errors++;
>> -		pr_err("call to kretprobe entry handler failed\n");
>> -	}
>> -
>> +	KUNIT_EXPECT_FALSE(current_test, preemptible());
>> +	KUNIT_EXPECT_EQ(current_test, ret, rand1 / div_factor);
>> +	KUNIT_EXPECT_NE(current_test, krph_val, 0);
>>  	krph_val = rand1;
>>  	return 0;
>>  }
>> @@ -193,39 +131,21 @@ static struct kretprobe rp = {
>>  	.kp.symbol_name = "kprobe_target"
>>  };
>>  
>> -static int test_kretprobe(void)
>> +static void test_kretprobe(struct kunit *test)
>>  {
>> -	int ret;
>> -
>> -	ret = register_kretprobe(&rp);
>> -	if (ret < 0) {
>> -		pr_err("register_kretprobe returned %d\n", ret);
>> -		return ret;
>> -	}
>> -
>> -	ret = target(rand1);
>> +	current_test = test;
>> +	KUNIT_EXPECT_EQ(test, 0, register_kretprobe(&rp));
>> +	target(rand1);
>>  	unregister_kretprobe(&rp);
>> -	if (krph_val != rand1) {
>> -		pr_err("kretprobe handler not called\n");
>> -		handler_errors++;
>> -	}
>> -
>> -	return 0;
>> +	KUNIT_EXPECT_EQ(test, krph_val, rand1);
>>  }
>>  
>>  static int return_handler2(struct kretprobe_instance *ri, struct pt_regs *regs)
>>  {
>>  	unsigned long ret = regs_return_value(regs);
>>  
>> -	if (ret != (rand1 / div_factor) + 1) {
>> -		handler_errors++;
>> -		pr_err("incorrect value in kretprobe handler2\n");
>> -	}
>> -	if (krph_val == 0) {
>> -		handler_errors++;
>> -		pr_err("call to kretprobe entry handler failed\n");
>> -	}
>> -
>> +	KUNIT_EXPECT_EQ(current_test, ret, (rand1 / div_factor) + 1);
>> +	KUNIT_EXPECT_NE(current_test, krph_val, 0);
>>  	krph_val = rand1;
>>  	return 0;
>>  }
>> @@ -236,78 +156,57 @@ static struct kretprobe rp2 = {
>>  	.kp.symbol_name = "kprobe_target2"
>>  };
>>  
>> -static int test_kretprobes(void)
>> +static void test_kretprobes(struct kunit *test)
>>  {
>> -	int ret;
>>  	struct kretprobe *rps[2] = {&rp, &rp2};
>>  
>> +	current_test = test;
>>  	/* addr and flags should be cleard for reusing kprobe. */
>>  	rp.kp.addr = NULL;
>>  	rp.kp.flags = 0;
>> -	ret = register_kretprobes(rps, 2);
>> -	if (ret < 0) {
>> -		pr_err("register_kretprobe returned %d\n", ret);
>> -		return ret;
>> -	}
>> +	KUNIT_EXPECT_EQ(test, 0, register_kretprobes(rps, 2));
>>  
>>  	krph_val = 0;
>> -	ret = target(rand1);
>> -	if (krph_val != rand1) {
>> -		pr_err("kretprobe handler not called\n");
>> -		handler_errors++;
>> -	}
>> +	target(rand1);
>> +	KUNIT_EXPECT_EQ(test, krph_val, rand1);
>>  
>>  	krph_val = 0;
>> -	ret = target2(rand1);
>> -	if (krph_val != rand1) {
>> -		pr_err("kretprobe handler2 not called\n");
>> -		handler_errors++;
>> -	}
>> +	target2(rand1);
>> +	KUNIT_EXPECT_EQ(test, krph_val, rand1);
>>  	unregister_kretprobes(rps, 2);
>> -	return 0;
>>  }
>>  #endif /* CONFIG_KRETPROBES */
>>  
>> -int init_test_probes(void)
>> +static int kprobes_test_init(struct kunit *test)
>>  {
>> -	int ret;
>> -
>>  	target = kprobe_target;
>>  	target2 = kprobe_target2;
>>  
>>  	do {
>>  		rand1 = prandom_u32();
>>  	} while (rand1 <= div_factor);
>> +	return 0;
>> +}
>>  
>> -	pr_info("started\n");
>> -	num_tests++;
>> -	ret = test_kprobe();
>> -	if (ret < 0)
>> -		errors++;
>> -
>> -	num_tests++;
>> -	ret = test_kprobes();
>> -	if (ret < 0)
>> -		errors++;
>> +static void kprobes_test_exit(struct kunit *test)
>> +{
>> +}

I noticed that kprobes_test_exit() is a leftover, i'll remove that with
v2.

>> +static struct kunit_case kprobes_testcases[] = {
>> +	KUNIT_CASE(test_kprobe),
>> +	KUNIT_CASE(test_kprobes),
>>  #ifdef CONFIG_KRETPROBES
>> -	num_tests++;
>> -	ret = test_kretprobe();
>> -	if (ret < 0)
>> -		errors++;
>> -
>> -	num_tests++;
>> -	ret = test_kretprobes();
>> -	if (ret < 0)
>> -		errors++;
>> -#endif /* CONFIG_KRETPROBES */
>> +	KUNIT_CASE(test_kretprobe),
>> +	KUNIT_CASE(test_kretprobes),
>> +#endif
>> +	{}
>> +};
>>  
>> -	if (errors)
>> -		pr_err("BUG: %d out of %d tests failed\n", errors, num_tests);
>> -	else if (handler_errors)
>> -		pr_err("BUG: %d error(s) running handlers\n", handler_errors);
>> -	else
>> -		pr_info("passed successfully\n");
>> +static struct kunit_suite kprobes_test_suite = {
>> +	.name = "kprobes_test",
>> +	.init = kprobes_test_init,
>> +	.test_cases = kprobes_testcases,
>> +};
>> +
>> +kunit_test_suites(&kprobes_test_suite);
>>  
>> -	return 0;
>> -}
>> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
>> index 5ddd575159fb..2bfdf2b6ef39 100644
>> --- a/lib/Kconfig.debug
>> +++ b/lib/Kconfig.debug
>> @@ -2100,6 +2100,7 @@ config KPROBES_SANITY_TEST
>>  	bool "Kprobes sanity tests"
>>  	depends on DEBUG_KERNEL
>>  	depends on KPROBES
>> +	depends on KUNIT
>>  	help
>>  	  This option provides for testing basic kprobes functionality on
>>  	  boot. Samples of kprobe and kretprobe are inserted and
>> -- 
>> 2.25.1
>> 
