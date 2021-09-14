Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15C1840AD6E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 14:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbhINMUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 08:20:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:60174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232506AbhINMUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 08:20:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8590261163;
        Tue, 14 Sep 2021 12:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631621973;
        bh=WvLtZcj6bM1H4a7g8qqenlitdHhXh8zcbVFaQr3ZqOI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MeOad7JCBRg4EP/vjwHlhFeYYUUXFolnwqHuGTW4SjveDxnBp8xmg3Ap0Rj0fDfEp
         8YapgVa9o7oRDDu/X5n7Gdgsa5503Ndq5kxYEgeRZPG0pJ8y8TriQb+9M1nz/wyQb3
         uuemgHRI87iwOyzWPNMKN4GdEHrKiA0TJaEoyuUnVvxiL5BhDykZo6nhmbfrcvQ7Y6
         lRQfgkDtC6NZHnZsIP329L1nbYEZGxowRbrGTgvlez26YPXAL5oNhqbMNONzPadIkZ
         GXdASRVklrHU/lEPtqq1LjABHZEJbC1nAyk4cGUmGZfdesP7SqRWI4PI2iB3QFQlio
         Earq0DHwACAbw==
Date:   Tue, 14 Sep 2021 21:19:30 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v2] kprobes: convert tests to kunit
Message-Id: <20210914211930.7b6d3e0ac3800fbf52a402c3@kernel.org>
In-Reply-To: <20210914070816.3516994-1-svens@linux.ibm.com>
References: <20210914070816.3516994-1-svens@linux.ibm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Sep 2021 09:08:16 +0200
Sven Schnelle <svens@linux.ibm.com> wrote:

> This converts the kprobes testcases to use the kunit framework.
> It adds a dependency on CONFIG_KUNIT, and the output will change
> to TAP:
> 
> TAP version 14
> 1..1
>     # Subtest: kprobes_test
>     1..4
> random: crng init done
>     ok 1 - test_kprobe
>     ok 2 - test_kprobes
>     ok 3 - test_kretprobe
>     ok 4 - test_kretprobes
> ok 1 - kprobes_test
> 
> Note that the kprobes testcases are no longer run immediately after
> kprobes initialization, but as a late initcall when kunit is
> initialized. kprobes itself is initialized with an early initcall,
> so the order is still correct.
> 

Great! Thank you!

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> ---
>  kernel/kprobes.c      |   3 -
>  kernel/test_kprobes.c | 221 +++++++++++-------------------------------
>  lib/Kconfig.debug     |   1 +
>  3 files changed, 59 insertions(+), 166 deletions(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 790a573bbe00..adf6ed1932c2 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -2508,9 +2508,6 @@ static int __init init_kprobes(void)
>  		err = register_module_notifier(&kprobe_module_nb);
>  
>  	kprobes_initialized = (err == 0);
> -
> -	if (!err)
> -		init_test_probes();
>  	return err;
>  }
>  early_initcall(init_kprobes);
> diff --git a/kernel/test_kprobes.c b/kernel/test_kprobes.c
> index 76c997fdbc9d..3c481560f439 100644
> --- a/kernel/test_kprobes.c
> +++ b/kernel/test_kprobes.c
> @@ -5,18 +5,17 @@
>   * Copyright IBM Corp. 2008
>   */
>  
> -#define pr_fmt(fmt) "Kprobe smoke test: " fmt
> -
>  #include <linux/kernel.h>
>  #include <linux/kprobes.h>
>  #include <linux/random.h>
> +#include <kunit/test.h>
>  
>  #define div_factor 3
>  
>  static u32 rand1, preh_val, posth_val;
> -static int errors, handler_errors, num_tests;
>  static u32 (*target)(u32 value);
>  static u32 (*target2)(u32 value);
> +static struct kunit *current_test;
>  
>  static noinline u32 kprobe_target(u32 value)
>  {
> @@ -25,10 +24,7 @@ static noinline u32 kprobe_target(u32 value)
>  
>  static int kp_pre_handler(struct kprobe *p, struct pt_regs *regs)
>  {
> -	if (preemptible()) {
> -		handler_errors++;
> -		pr_err("pre-handler is preemptible\n");
> -	}
> +	KUNIT_EXPECT_FALSE(current_test, preemptible());
>  	preh_val = (rand1 / div_factor);
>  	return 0;
>  }
> @@ -36,14 +32,8 @@ static int kp_pre_handler(struct kprobe *p, struct pt_regs *regs)
>  static void kp_post_handler(struct kprobe *p, struct pt_regs *regs,
>  		unsigned long flags)
>  {
> -	if (preemptible()) {
> -		handler_errors++;
> -		pr_err("post-handler is preemptible\n");
> -	}
> -	if (preh_val != (rand1 / div_factor)) {
> -		handler_errors++;
> -		pr_err("incorrect value in post_handler\n");
> -	}
> +	KUNIT_EXPECT_FALSE(current_test, preemptible());
> +	KUNIT_EXPECT_EQ(current_test, preh_val, (rand1 / div_factor));
>  	posth_val = preh_val + div_factor;
>  }
>  
> @@ -53,30 +43,14 @@ static struct kprobe kp = {
>  	.post_handler = kp_post_handler
>  };
>  
> -static int test_kprobe(void)
> +static void test_kprobe(struct kunit *test)
>  {
> -	int ret;
> -
> -	ret = register_kprobe(&kp);
> -	if (ret < 0) {
> -		pr_err("register_kprobe returned %d\n", ret);
> -		return ret;
> -	}
> -
> -	ret = target(rand1);
> +	current_test = test;
> +	KUNIT_EXPECT_EQ(test, 0, register_kprobe(&kp));
> +	target(rand1);
>  	unregister_kprobe(&kp);
> -
> -	if (preh_val == 0) {
> -		pr_err("kprobe pre_handler not called\n");
> -		handler_errors++;
> -	}
> -
> -	if (posth_val == 0) {
> -		pr_err("kprobe post_handler not called\n");
> -		handler_errors++;
> -	}
> -
> -	return 0;
> +	KUNIT_EXPECT_NE(test, 0, preh_val);
> +	KUNIT_EXPECT_NE(test, 0, posth_val);
>  }
>  
>  static noinline u32 kprobe_target2(u32 value)
> @@ -93,10 +67,7 @@ static int kp_pre_handler2(struct kprobe *p, struct pt_regs *regs)
>  static void kp_post_handler2(struct kprobe *p, struct pt_regs *regs,
>  		unsigned long flags)
>  {
> -	if (preh_val != (rand1 / div_factor) + 1) {
> -		handler_errors++;
> -		pr_err("incorrect value in post_handler2\n");
> -	}
> +	KUNIT_EXPECT_EQ(current_test, preh_val, (rand1 / div_factor) + 1);
>  	posth_val = preh_val + div_factor;
>  }
>  
> @@ -106,51 +77,31 @@ static struct kprobe kp2 = {
>  	.post_handler = kp_post_handler2
>  };
>  
> -static int test_kprobes(void)
> +static void test_kprobes(struct kunit *test)
>  {
> -	int ret;
>  	struct kprobe *kps[2] = {&kp, &kp2};
>  
> +	current_test = test;
> +
>  	/* addr and flags should be cleard for reusing kprobe. */
>  	kp.addr = NULL;
>  	kp.flags = 0;
> -	ret = register_kprobes(kps, 2);
> -	if (ret < 0) {
> -		pr_err("register_kprobes returned %d\n", ret);
> -		return ret;
> -	}
>  
> +	KUNIT_EXPECT_EQ(test, 0, register_kprobes(kps, 2));
>  	preh_val = 0;
>  	posth_val = 0;
> -	ret = target(rand1);
> +	target(rand1);
>  
> -	if (preh_val == 0) {
> -		pr_err("kprobe pre_handler not called\n");
> -		handler_errors++;
> -	}
> -
> -	if (posth_val == 0) {
> -		pr_err("kprobe post_handler not called\n");
> -		handler_errors++;
> -	}
> +	KUNIT_EXPECT_NE(test, 0, preh_val);
> +	KUNIT_EXPECT_NE(test, 0, posth_val);
>  
>  	preh_val = 0;
>  	posth_val = 0;
> -	ret = target2(rand1);
> -
> -	if (preh_val == 0) {
> -		pr_err("kprobe pre_handler2 not called\n");
> -		handler_errors++;
> -	}
> -
> -	if (posth_val == 0) {
> -		pr_err("kprobe post_handler2 not called\n");
> -		handler_errors++;
> -	}
> +	target2(rand1);
>  
> +	KUNIT_EXPECT_NE(test, 0, preh_val);
> +	KUNIT_EXPECT_NE(test, 0, posth_val);
>  	unregister_kprobes(kps, 2);
> -	return 0;
> -
>  }
>  
>  #ifdef CONFIG_KRETPROBES
> @@ -158,10 +109,7 @@ static u32 krph_val;
>  
>  static int entry_handler(struct kretprobe_instance *ri, struct pt_regs *regs)
>  {
> -	if (preemptible()) {
> -		handler_errors++;
> -		pr_err("kretprobe entry handler is preemptible\n");
> -	}
> +	KUNIT_EXPECT_FALSE(current_test, preemptible());
>  	krph_val = (rand1 / div_factor);
>  	return 0;
>  }
> @@ -170,19 +118,9 @@ static int return_handler(struct kretprobe_instance *ri, struct pt_regs *regs)
>  {
>  	unsigned long ret = regs_return_value(regs);
>  
> -	if (preemptible()) {
> -		handler_errors++;
> -		pr_err("kretprobe return handler is preemptible\n");
> -	}
> -	if (ret != (rand1 / div_factor)) {
> -		handler_errors++;
> -		pr_err("incorrect value in kretprobe handler\n");
> -	}
> -	if (krph_val == 0) {
> -		handler_errors++;
> -		pr_err("call to kretprobe entry handler failed\n");
> -	}
> -
> +	KUNIT_EXPECT_FALSE(current_test, preemptible());
> +	KUNIT_EXPECT_EQ(current_test, ret, rand1 / div_factor);
> +	KUNIT_EXPECT_NE(current_test, krph_val, 0);
>  	krph_val = rand1;
>  	return 0;
>  }
> @@ -193,39 +131,21 @@ static struct kretprobe rp = {
>  	.kp.symbol_name = "kprobe_target"
>  };
>  
> -static int test_kretprobe(void)
> +static void test_kretprobe(struct kunit *test)
>  {
> -	int ret;
> -
> -	ret = register_kretprobe(&rp);
> -	if (ret < 0) {
> -		pr_err("register_kretprobe returned %d\n", ret);
> -		return ret;
> -	}
> -
> -	ret = target(rand1);
> +	current_test = test;
> +	KUNIT_EXPECT_EQ(test, 0, register_kretprobe(&rp));
> +	target(rand1);
>  	unregister_kretprobe(&rp);
> -	if (krph_val != rand1) {
> -		pr_err("kretprobe handler not called\n");
> -		handler_errors++;
> -	}
> -
> -	return 0;
> +	KUNIT_EXPECT_EQ(test, krph_val, rand1);
>  }
>  
>  static int return_handler2(struct kretprobe_instance *ri, struct pt_regs *regs)
>  {
>  	unsigned long ret = regs_return_value(regs);
>  
> -	if (ret != (rand1 / div_factor) + 1) {
> -		handler_errors++;
> -		pr_err("incorrect value in kretprobe handler2\n");
> -	}
> -	if (krph_val == 0) {
> -		handler_errors++;
> -		pr_err("call to kretprobe entry handler failed\n");
> -	}
> -
> +	KUNIT_EXPECT_EQ(current_test, ret, (rand1 / div_factor) + 1);
> +	KUNIT_EXPECT_NE(current_test, krph_val, 0);
>  	krph_val = rand1;
>  	return 0;
>  }
> @@ -236,78 +156,53 @@ static struct kretprobe rp2 = {
>  	.kp.symbol_name = "kprobe_target2"
>  };
>  
> -static int test_kretprobes(void)
> +static void test_kretprobes(struct kunit *test)
>  {
> -	int ret;
>  	struct kretprobe *rps[2] = {&rp, &rp2};
>  
> +	current_test = test;
>  	/* addr and flags should be cleard for reusing kprobe. */
>  	rp.kp.addr = NULL;
>  	rp.kp.flags = 0;
> -	ret = register_kretprobes(rps, 2);
> -	if (ret < 0) {
> -		pr_err("register_kretprobe returned %d\n", ret);
> -		return ret;
> -	}
> +	KUNIT_EXPECT_EQ(test, 0, register_kretprobes(rps, 2));
>  
>  	krph_val = 0;
> -	ret = target(rand1);
> -	if (krph_val != rand1) {
> -		pr_err("kretprobe handler not called\n");
> -		handler_errors++;
> -	}
> +	target(rand1);
> +	KUNIT_EXPECT_EQ(test, krph_val, rand1);
>  
>  	krph_val = 0;
> -	ret = target2(rand1);
> -	if (krph_val != rand1) {
> -		pr_err("kretprobe handler2 not called\n");
> -		handler_errors++;
> -	}
> +	target2(rand1);
> +	KUNIT_EXPECT_EQ(test, krph_val, rand1);
>  	unregister_kretprobes(rps, 2);
> -	return 0;
>  }
>  #endif /* CONFIG_KRETPROBES */
>  
> -int init_test_probes(void)
> +static int kprobes_test_init(struct kunit *test)
>  {
> -	int ret;
> -
>  	target = kprobe_target;
>  	target2 = kprobe_target2;
>  
>  	do {
>  		rand1 = prandom_u32();
>  	} while (rand1 <= div_factor);
> +	return 0;
> +}
>  
> -	pr_info("started\n");
> -	num_tests++;
> -	ret = test_kprobe();
> -	if (ret < 0)
> -		errors++;
> -
> -	num_tests++;
> -	ret = test_kprobes();
> -	if (ret < 0)
> -		errors++;
> -
> +static struct kunit_case kprobes_testcases[] = {
> +	KUNIT_CASE(test_kprobe),
> +	KUNIT_CASE(test_kprobes),
>  #ifdef CONFIG_KRETPROBES
> -	num_tests++;
> -	ret = test_kretprobe();
> -	if (ret < 0)
> -		errors++;
> -
> -	num_tests++;
> -	ret = test_kretprobes();
> -	if (ret < 0)
> -		errors++;
> -#endif /* CONFIG_KRETPROBES */
> +	KUNIT_CASE(test_kretprobe),
> +	KUNIT_CASE(test_kretprobes),
> +#endif
> +	{}
> +};
>  
> -	if (errors)
> -		pr_err("BUG: %d out of %d tests failed\n", errors, num_tests);
> -	else if (handler_errors)
> -		pr_err("BUG: %d error(s) running handlers\n", handler_errors);
> -	else
> -		pr_info("passed successfully\n");
> +static struct kunit_suite kprobes_test_suite = {
> +	.name = "kprobes_test",
> +	.init = kprobes_test_init,
> +	.test_cases = kprobes_testcases,
> +};
> +
> +kunit_test_suites(&kprobes_test_suite);
>  
> -	return 0;
> -}
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index ed4a31e34098..10dbed281a6a 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2083,6 +2083,7 @@ config KPROBES_SANITY_TEST
>  	bool "Kprobes sanity tests"
>  	depends on DEBUG_KERNEL
>  	depends on KPROBES
> +	depends on KUNIT
>  	help
>  	  This option provides for testing basic kprobes functionality on
>  	  boot. Samples of kprobe and kretprobe are inserted and
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
