Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25C5840A222
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 02:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233779AbhINAm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 20:42:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:57348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229633AbhINAm0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 20:42:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 470E961130;
        Tue, 14 Sep 2021 00:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631580070;
        bh=vkm3tOczFg1ESVWTvsGwYOWJp1/g+2cMeuAj9ascL60=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oHwXH2UURpYpyPldgXAMsLXJZAxG4OSvO6HPGC4+7w36oQzze4LTxhQYmmUmuv9zv
         1hYNoMG9YpF2ttqv+IS8xDEn3mh0bwbV6Uz2n6d10ih+xbLFVM8eIARzirzt1etKJk
         YEabv8xKbCitE+3nfMEsatJ1SbPtP5vEE0FPxM+HRPz2d75QgFeHVy6p3U19gKkDXN
         k3Nfvh7u0mdFJsdMkGoIWh1E4P9Nj6KciyxhYlYqqfNX/7trBee/BXUJklbG/7DYyX
         DDySXUmOQcCEzKF69ERPAh2v3NFR+5uRXdXBnheSOzBwhZeOZ4xvAetDQ/r7yX/j3m
         MO69lZ9ZvYG3w==
Date:   Tue, 14 Sep 2021 09:41:07 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kprobes: convert tests to kunit
Message-Id: <20210914094107.7c8b45b9315f968d9bf2342f@kernel.org>
In-Reply-To: <yt9dk0jkbhvw.fsf@linux.ibm.com>
References: <20210913092748.1763259-1-svens@linux.ibm.com>
        <20210914000228.3ada4fc2e339b5007ce39d04@kernel.org>
        <yt9dk0jkbhvw.fsf@linux.ibm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Sep 2021 17:43:47 +0200
Sven Schnelle <svens@linux.ibm.com> wrote:

> Masami Hiramatsu <mhiramat@kernel.org> writes:
> 
> [ +CC linux-kernel, missed that in the initial message ]
> 
> > On Mon, 13 Sep 2021 11:27:48 +0200
> > Sven Schnelle <svens@linux.ibm.com> wrote:
> >
> > Great! thanks for you updating the test case.
> > BTW, can you add some description for this patch?
> 
> Not sure what to write there, as the conversion is pretty
> self-explaining. I'll think about it :-)

I think many things are changed from the viewpoint of
developers who checks dmesg, for example, the testing
timing (not run immediately after enabling the kprobes, but
at the late_initcall), new dependency of CONFIG_KUNIT, 
how the dmesg output has been changed.
Those are important information for who are maintaning
the kernel test systems :)

> 
> >> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> >> ---
> >>  kernel/kprobes.c      |   3 -
> >>  kernel/test_kprobes.c | 223 ++++++++++++------------------------------
> >>  lib/Kconfig.debug     |   1 +
> >>  3 files changed, 62 insertions(+), 165 deletions(-)
> >> 
> >> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> >> index 790a573bbe00..adf6ed1932c2 100644
> >> --- a/kernel/kprobes.c
> >> +++ b/kernel/kprobes.c
> >> @@ -2508,9 +2508,6 @@ static int __init init_kprobes(void)
> >>  		err = register_module_notifier(&kprobe_module_nb);
> >>  
> >>  	kprobes_initialized = (err == 0);
> >> -
> >> -	if (!err)
> >> -		init_test_probes();
> >
> > Also, I'm interested in when the test will be executed.
> 
> I checked the kunit code, and the unit tests run as late initcall,
> while kprobes is an early initcall. So the ordering should still be
> fine. If you think the sanity tests should run immediately after kprobes
> startup, i'm not sure whether that's possible with kunit.

No need to run it immediately, but it need to be after kprobe initialized.
kprobe itself is initalized in early initcall, and optprobe is initialized
in subsys initcall. So late initcall is good to me. :)

Thank you,

> 
> > Thank you,
> >
> >>  	return err;
> >>  }
> >>  early_initcall(init_kprobes);
> >> diff --git a/kernel/test_kprobes.c b/kernel/test_kprobes.c
> >> index 76c997fdbc9d..06adede697a4 100644
> >> --- a/kernel/test_kprobes.c
> >> +++ b/kernel/test_kprobes.c
> >> @@ -5,18 +5,17 @@
> >>   * Copyright IBM Corp. 2008
> >>   */
> >>  
> >> -#define pr_fmt(fmt) "Kprobe smoke test: " fmt
> >> -
> >>  #include <linux/kernel.h>
> >>  #include <linux/kprobes.h>
> >>  #include <linux/random.h>
> >> +#include <kunit/test.h>
> >>  
> >>  #define div_factor 3
> >>  
> >>  static u32 rand1, preh_val, posth_val;
> >> -static int errors, handler_errors, num_tests;
> >>  static u32 (*target)(u32 value);
> >>  static u32 (*target2)(u32 value);
> >> +static struct kunit *current_test;
> >>  
> >>  static noinline u32 kprobe_target(u32 value)
> >>  {
> >> @@ -25,10 +24,7 @@ static noinline u32 kprobe_target(u32 value)
> >>  
> >>  static int kp_pre_handler(struct kprobe *p, struct pt_regs *regs)
> >>  {
> >> -	if (preemptible()) {
> >> -		handler_errors++;
> >> -		pr_err("pre-handler is preemptible\n");
> >> -	}
> >> +	KUNIT_EXPECT_FALSE(current_test, preemptible());
> >>  	preh_val = (rand1 / div_factor);
> >>  	return 0;
> >>  }
> >> @@ -36,14 +32,8 @@ static int kp_pre_handler(struct kprobe *p, struct pt_regs *regs)
> >>  static void kp_post_handler(struct kprobe *p, struct pt_regs *regs,
> >>  		unsigned long flags)
> >>  {
> >> -	if (preemptible()) {
> >> -		handler_errors++;
> >> -		pr_err("post-handler is preemptible\n");
> >> -	}
> >> -	if (preh_val != (rand1 / div_factor)) {
> >> -		handler_errors++;
> >> -		pr_err("incorrect value in post_handler\n");
> >> -	}
> >> +	KUNIT_EXPECT_FALSE(current_test, preemptible());
> >> +	KUNIT_EXPECT_EQ(current_test, preh_val, (rand1 / div_factor));
> >>  	posth_val = preh_val + div_factor;
> >>  }
> >>  
> >> @@ -53,30 +43,14 @@ static struct kprobe kp = {
> >>  	.post_handler = kp_post_handler
> >>  };
> >>  
> >> -static int test_kprobe(void)
> >> +static void test_kprobe(struct kunit *test)
> >>  {
> >> -	int ret;
> >> -
> >> -	ret = register_kprobe(&kp);
> >> -	if (ret < 0) {
> >> -		pr_err("register_kprobe returned %d\n", ret);
> >> -		return ret;
> >> -	}
> >> -
> >> -	ret = target(rand1);
> >> +	current_test = test;
> >> +	KUNIT_EXPECT_EQ(test, 0, register_kprobe(&kp));
> >> +	target(rand1);
> >>  	unregister_kprobe(&kp);
> >> -
> >> -	if (preh_val == 0) {
> >> -		pr_err("kprobe pre_handler not called\n");
> >> -		handler_errors++;
> >> -	}
> >> -
> >> -	if (posth_val == 0) {
> >> -		pr_err("kprobe post_handler not called\n");
> >> -		handler_errors++;
> >> -	}
> >> -
> >> -	return 0;
> >> +	KUNIT_EXPECT_NE(test, 0, preh_val);
> >> +	KUNIT_EXPECT_NE(test, 0, posth_val);
> >>  }
> >>  
> >>  static noinline u32 kprobe_target2(u32 value)
> >> @@ -93,10 +67,7 @@ static int kp_pre_handler2(struct kprobe *p, struct pt_regs *regs)
> >>  static void kp_post_handler2(struct kprobe *p, struct pt_regs *regs,
> >>  		unsigned long flags)
> >>  {
> >> -	if (preh_val != (rand1 / div_factor) + 1) {
> >> -		handler_errors++;
> >> -		pr_err("incorrect value in post_handler2\n");
> >> -	}
> >> +	KUNIT_EXPECT_EQ(current_test, preh_val, (rand1 / div_factor) + 1);
> >>  	posth_val = preh_val + div_factor;
> >>  }
> >>  
> >> @@ -106,51 +77,31 @@ static struct kprobe kp2 = {
> >>  	.post_handler = kp_post_handler2
> >>  };
> >>  
> >> -static int test_kprobes(void)
> >> +static void test_kprobes(struct kunit *test)
> >>  {
> >> -	int ret;
> >>  	struct kprobe *kps[2] = {&kp, &kp2};
> >>  
> >> +	current_test = test;
> >> +
> >>  	/* addr and flags should be cleard for reusing kprobe. */
> >>  	kp.addr = NULL;
> >>  	kp.flags = 0;
> >> -	ret = register_kprobes(kps, 2);
> >> -	if (ret < 0) {
> >> -		pr_err("register_kprobes returned %d\n", ret);
> >> -		return ret;
> >> -	}
> >>  
> >> +	KUNIT_EXPECT_EQ(test, 0, register_kprobes(kps, 2));
> >>  	preh_val = 0;
> >>  	posth_val = 0;
> >> -	ret = target(rand1);
> >> +	target(rand1);
> >>  
> >> -	if (preh_val == 0) {
> >> -		pr_err("kprobe pre_handler not called\n");
> >> -		handler_errors++;
> >> -	}
> >> -
> >> -	if (posth_val == 0) {
> >> -		pr_err("kprobe post_handler not called\n");
> >> -		handler_errors++;
> >> -	}
> >> +	KUNIT_EXPECT_NE(test, 0, preh_val);
> >> +	KUNIT_EXPECT_NE(test, 0, posth_val);
> >>  
> >>  	preh_val = 0;
> >>  	posth_val = 0;
> >> -	ret = target2(rand1);
> >> -
> >> -	if (preh_val == 0) {
> >> -		pr_err("kprobe pre_handler2 not called\n");
> >> -		handler_errors++;
> >> -	}
> >> -
> >> -	if (posth_val == 0) {
> >> -		pr_err("kprobe post_handler2 not called\n");
> >> -		handler_errors++;
> >> -	}
> >> +	target2(rand1);
> >>  
> >> +	KUNIT_EXPECT_NE(test, 0, preh_val);
> >> +	KUNIT_EXPECT_NE(test, 0, posth_val);
> >>  	unregister_kprobes(kps, 2);
> >> -	return 0;
> >> -
> >>  }
> >>  
> >>  #ifdef CONFIG_KRETPROBES
> >> @@ -158,10 +109,7 @@ static u32 krph_val;
> >>  
> >>  static int entry_handler(struct kretprobe_instance *ri, struct pt_regs *regs)
> >>  {
> >> -	if (preemptible()) {
> >> -		handler_errors++;
> >> -		pr_err("kretprobe entry handler is preemptible\n");
> >> -	}
> >> +	KUNIT_EXPECT_FALSE(current_test, preemptible());
> >>  	krph_val = (rand1 / div_factor);
> >>  	return 0;
> >>  }
> >> @@ -170,19 +118,9 @@ static int return_handler(struct kretprobe_instance *ri, struct pt_regs *regs)
> >>  {
> >>  	unsigned long ret = regs_return_value(regs);
> >>  
> >> -	if (preemptible()) {
> >> -		handler_errors++;
> >> -		pr_err("kretprobe return handler is preemptible\n");
> >> -	}
> >> -	if (ret != (rand1 / div_factor)) {
> >> -		handler_errors++;
> >> -		pr_err("incorrect value in kretprobe handler\n");
> >> -	}
> >> -	if (krph_val == 0) {
> >> -		handler_errors++;
> >> -		pr_err("call to kretprobe entry handler failed\n");
> >> -	}
> >> -
> >> +	KUNIT_EXPECT_FALSE(current_test, preemptible());
> >> +	KUNIT_EXPECT_EQ(current_test, ret, rand1 / div_factor);
> >> +	KUNIT_EXPECT_NE(current_test, krph_val, 0);
> >>  	krph_val = rand1;
> >>  	return 0;
> >>  }
> >> @@ -193,39 +131,21 @@ static struct kretprobe rp = {
> >>  	.kp.symbol_name = "kprobe_target"
> >>  };
> >>  
> >> -static int test_kretprobe(void)
> >> +static void test_kretprobe(struct kunit *test)
> >>  {
> >> -	int ret;
> >> -
> >> -	ret = register_kretprobe(&rp);
> >> -	if (ret < 0) {
> >> -		pr_err("register_kretprobe returned %d\n", ret);
> >> -		return ret;
> >> -	}
> >> -
> >> -	ret = target(rand1);
> >> +	current_test = test;
> >> +	KUNIT_EXPECT_EQ(test, 0, register_kretprobe(&rp));
> >> +	target(rand1);
> >>  	unregister_kretprobe(&rp);
> >> -	if (krph_val != rand1) {
> >> -		pr_err("kretprobe handler not called\n");
> >> -		handler_errors++;
> >> -	}
> >> -
> >> -	return 0;
> >> +	KUNIT_EXPECT_EQ(test, krph_val, rand1);
> >>  }
> >>  
> >>  static int return_handler2(struct kretprobe_instance *ri, struct pt_regs *regs)
> >>  {
> >>  	unsigned long ret = regs_return_value(regs);
> >>  
> >> -	if (ret != (rand1 / div_factor) + 1) {
> >> -		handler_errors++;
> >> -		pr_err("incorrect value in kretprobe handler2\n");
> >> -	}
> >> -	if (krph_val == 0) {
> >> -		handler_errors++;
> >> -		pr_err("call to kretprobe entry handler failed\n");
> >> -	}
> >> -
> >> +	KUNIT_EXPECT_EQ(current_test, ret, (rand1 / div_factor) + 1);
> >> +	KUNIT_EXPECT_NE(current_test, krph_val, 0);
> >>  	krph_val = rand1;
> >>  	return 0;
> >>  }
> >> @@ -236,78 +156,57 @@ static struct kretprobe rp2 = {
> >>  	.kp.symbol_name = "kprobe_target2"
> >>  };
> >>  
> >> -static int test_kretprobes(void)
> >> +static void test_kretprobes(struct kunit *test)
> >>  {
> >> -	int ret;
> >>  	struct kretprobe *rps[2] = {&rp, &rp2};
> >>  
> >> +	current_test = test;
> >>  	/* addr and flags should be cleard for reusing kprobe. */
> >>  	rp.kp.addr = NULL;
> >>  	rp.kp.flags = 0;
> >> -	ret = register_kretprobes(rps, 2);
> >> -	if (ret < 0) {
> >> -		pr_err("register_kretprobe returned %d\n", ret);
> >> -		return ret;
> >> -	}
> >> +	KUNIT_EXPECT_EQ(test, 0, register_kretprobes(rps, 2));
> >>  
> >>  	krph_val = 0;
> >> -	ret = target(rand1);
> >> -	if (krph_val != rand1) {
> >> -		pr_err("kretprobe handler not called\n");
> >> -		handler_errors++;
> >> -	}
> >> +	target(rand1);
> >> +	KUNIT_EXPECT_EQ(test, krph_val, rand1);
> >>  
> >>  	krph_val = 0;
> >> -	ret = target2(rand1);
> >> -	if (krph_val != rand1) {
> >> -		pr_err("kretprobe handler2 not called\n");
> >> -		handler_errors++;
> >> -	}
> >> +	target2(rand1);
> >> +	KUNIT_EXPECT_EQ(test, krph_val, rand1);
> >>  	unregister_kretprobes(rps, 2);
> >> -	return 0;
> >>  }
> >>  #endif /* CONFIG_KRETPROBES */
> >>  
> >> -int init_test_probes(void)
> >> +static int kprobes_test_init(struct kunit *test)
> >>  {
> >> -	int ret;
> >> -
> >>  	target = kprobe_target;
> >>  	target2 = kprobe_target2;
> >>  
> >>  	do {
> >>  		rand1 = prandom_u32();
> >>  	} while (rand1 <= div_factor);
> >> +	return 0;
> >> +}
> >>  
> >> -	pr_info("started\n");
> >> -	num_tests++;
> >> -	ret = test_kprobe();
> >> -	if (ret < 0)
> >> -		errors++;
> >> -
> >> -	num_tests++;
> >> -	ret = test_kprobes();
> >> -	if (ret < 0)
> >> -		errors++;
> >> +static void kprobes_test_exit(struct kunit *test)
> >> +{
> >> +}
> 
> I noticed that kprobes_test_exit() is a leftover, i'll remove that with
> v2.
> 
> >> +static struct kunit_case kprobes_testcases[] = {
> >> +	KUNIT_CASE(test_kprobe),
> >> +	KUNIT_CASE(test_kprobes),
> >>  #ifdef CONFIG_KRETPROBES
> >> -	num_tests++;
> >> -	ret = test_kretprobe();
> >> -	if (ret < 0)
> >> -		errors++;
> >> -
> >> -	num_tests++;
> >> -	ret = test_kretprobes();
> >> -	if (ret < 0)
> >> -		errors++;
> >> -#endif /* CONFIG_KRETPROBES */
> >> +	KUNIT_CASE(test_kretprobe),
> >> +	KUNIT_CASE(test_kretprobes),
> >> +#endif
> >> +	{}
> >> +};
> >>  
> >> -	if (errors)
> >> -		pr_err("BUG: %d out of %d tests failed\n", errors, num_tests);
> >> -	else if (handler_errors)
> >> -		pr_err("BUG: %d error(s) running handlers\n", handler_errors);
> >> -	else
> >> -		pr_info("passed successfully\n");
> >> +static struct kunit_suite kprobes_test_suite = {
> >> +	.name = "kprobes_test",
> >> +	.init = kprobes_test_init,
> >> +	.test_cases = kprobes_testcases,
> >> +};
> >> +
> >> +kunit_test_suites(&kprobes_test_suite);
> >>  
> >> -	return 0;
> >> -}
> >> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> >> index 5ddd575159fb..2bfdf2b6ef39 100644
> >> --- a/lib/Kconfig.debug
> >> +++ b/lib/Kconfig.debug
> >> @@ -2100,6 +2100,7 @@ config KPROBES_SANITY_TEST
> >>  	bool "Kprobes sanity tests"
> >>  	depends on DEBUG_KERNEL
> >>  	depends on KPROBES
> >> +	depends on KUNIT
> >>  	help
> >>  	  This option provides for testing basic kprobes functionality on
> >>  	  boot. Samples of kprobe and kretprobe are inserted and
> >> -- 
> >> 2.25.1
> >> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
