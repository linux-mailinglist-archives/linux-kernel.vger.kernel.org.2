Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BEE931C095
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 18:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbhBOR2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 12:28:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbhBOQ1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 11:27:51 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20557C061797;
        Mon, 15 Feb 2021 08:27:10 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id v5so11152997lft.13;
        Mon, 15 Feb 2021 08:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FV6VCJqnmDh1otGBmo06V2xl2FJ/aeDw3FKVMAd7wvE=;
        b=hzP+jSK7OkPtsPJTCxgNTLZqaOY9jXtBJfKuebyHwYFGxs6AClZGfKVEWXDfoLh2AV
         xYKWkCYo/JKGHimISfGYZrM+cwqxG2kiYd2j0e62KoOFPfcMj/Fowg9/kaphH/8NCEIa
         PuPMZ6AI9Du4q7pkJlG/u3zYY21Xofgfp5Q/IzaBtZoAer0sQM9+Xk0yavhNIFQwEizC
         U0BP7Tit3PUO+g1vzpxKH8BM5CNux7d2/M8M3nI23qryhJwAhXhPI8pl2cV/30gp1zJu
         Wmz3qRuxR6wCFw4aWF41eoYNK9o7MtndTl2jNCLIqIk5Nuz1k0zn0xMDPpmShvm75B5c
         vOOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FV6VCJqnmDh1otGBmo06V2xl2FJ/aeDw3FKVMAd7wvE=;
        b=a4rHAFgLgwIa5aI5adWmrIqVfHqs7MGbnel7uEQ1bt6lRbXjY9GTsWT/bWYb/33k0f
         GCkufj4rpYLJSRaDzb9W7bVlKONcxQY62Q4KKtPEC5i+Yd7P5WFBqIm5BSuTnZI23lun
         OCeE69yFrzBbpVrxcaBJC2Nz29gXiNLEP7Z6OoyTAbQERcSHohML4nLFOoMv0L0ZY8GI
         uOSKHhmgViyatkIko+/yfAPPopjCQqEuM6jG88LM3WCXse8fV1tMVX+J7wCmILj+YVwD
         MZxRz6wZzidJsfYXbZ8y95bfz2b/x1OUsNEFyAKjP8+VrkTmuSewhVIHsY428ngjMeQb
         o9+w==
X-Gm-Message-State: AOAM531MswSzWP9cTNoc1S86y/eUb36APGEJReOqx+PsCdKpHGBqYTUl
        2olAUMZk1C7HoAIlrHkMt2w=
X-Google-Smtp-Source: ABdhPJxWx3p2QDHHPx5A3UIynUSJTYcuM8yuMWZu9UrxgkNYmKraORM6w/mA2wSyj9h8GwYNke2fwg==
X-Received: by 2002:a19:fc16:: with SMTP id a22mr8854862lfi.516.1613406428563;
        Mon, 15 Feb 2021 08:27:08 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id c18sm2826342lft.258.2021.02.15.08.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 08:27:08 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Mon, 15 Feb 2021 17:27:05 +0100
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 1/2] rcuscale: add kfree_rcu() single-argument scale test
Message-ID: <20210215162705.GA45713@pc638.lan>
References: <20210129200505.5273-1-urezki@gmail.com>
 <20210204214648.GL2743@paulmck-ThinkPad-P72>
 <20210209201343.GA15619@pc638.lan>
 <20210210010052.GZ2743@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210010052.GZ2743@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 05:00:52PM -0800, Paul E. McKenney wrote:
> On Tue, Feb 09, 2021 at 09:13:43PM +0100, Uladzislau Rezki wrote:
> > On Thu, Feb 04, 2021 at 01:46:48PM -0800, Paul E. McKenney wrote:
> > > On Fri, Jan 29, 2021 at 09:05:04PM +0100, Uladzislau Rezki (Sony) wrote:
> > > > To stress and test a single argument of kfree_rcu() call, we
> > > > should to have a special coverage for it. We used to have it
> > > > in the test-suite related to vmalloc stressing. The reason is
> > > > the rcuscale is a correct place for RCU related things.
> > > > 
> > > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > 
> > > This is a great addition, but it would be even better if there was
> > > a way to say "test both in one run".  One way to do this is to have
> > > torture_param() variables for both kfree_rcu_test_single and (say)
> > > kfree_rcu_test_double, both bool and both initialized to false.  If both
> > > have the same value (false or true) both are tested, otherwise only
> > > the one with value true is tested.  The value of this is that it allows
> > > testing of both options with one test.
> > > 
> > Make sense to me :)
> > 
> > >From ba083a543a123455455c81230b7b5a9aa2a9cb7f Mon Sep 17 00:00:00 2001
> > From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
> > Date: Fri, 29 Jan 2021 19:51:27 +0100
> > Subject: [PATCH v2 1/1] rcuscale: add kfree_rcu() single-argument scale test
> > 
> > To stress and test a single argument of kfree_rcu() call, we
> > should to have a special coverage for it. We used to have it
> > in the test-suite related to vmalloc stressing. The reason is
> > the rcuscale is a correct place for RCU related things.
> > 
> > Therefore introduce two torture_param() variables, one is for
> > single-argument scale test and another one for double-argument
> > scale test.
> > 
> > By default kfree_rcu_test_single and kfree_rcu_test_double are
> > initialized to false. If both have the same value (false or true)
> > both are tested in one run, otherwise only the one with value
> > true is tested. The value of this is that it allows testing of
> > both options with one test.
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > ---
> >  kernel/rcu/rcuscale.c | 33 ++++++++++++++++++++++++++++-----
> >  1 file changed, 28 insertions(+), 5 deletions(-)
> > 
> > diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
> > index 06491d5530db..0cde5c17f06c 100644
> > --- a/kernel/rcu/rcuscale.c
> > +++ b/kernel/rcu/rcuscale.c
> > @@ -625,6 +625,8 @@ rcu_scale_shutdown(void *arg)
> >  torture_param(int, kfree_nthreads, -1, "Number of threads running loops of kfree_rcu().");
> >  torture_param(int, kfree_alloc_num, 8000, "Number of allocations and frees done in an iteration.");
> >  torture_param(int, kfree_loops, 10, "Number of loops doing kfree_alloc_num allocations and frees.");
> > +torture_param(int, kfree_rcu_test_single, 0, "Do we run a kfree_rcu() single-argument scale test?");
> > +torture_param(int, kfree_rcu_test_double, 0, "Do we run a kfree_rcu() double-argument scale test?");
> 
> Good!  But why int instead of bool?
> 
> >  static struct task_struct **kfree_reader_tasks;
> >  static int kfree_nrealthreads;
> > @@ -641,7 +643,7 @@ kfree_scale_thread(void *arg)
> >  {
> >  	int i, loop = 0;
> >  	long me = (long)arg;
> > -	struct kfree_obj *alloc_ptr;
> > +	struct kfree_obj *alloc_ptr[2];
> 
> You lost me on this one...
> 
> >  	u64 start_time, end_time;
> >  	long long mem_begin, mem_during = 0;
> >  
> > @@ -665,12 +667,33 @@ kfree_scale_thread(void *arg)
> >  			mem_during = (mem_during + si_mem_available()) / 2;
> >  		}
> >  
> > +		// By default kfree_rcu_test_single and kfree_rcu_test_double are
> > +		// initialized to false. If both have the same value (false or true)
> > +		// both are tested in one run, otherwise only the one with value
> > +		// true is tested.
> >  		for (i = 0; i < kfree_alloc_num; i++) {
> > -			alloc_ptr = kmalloc(kfree_mult * sizeof(struct kfree_obj), GFP_KERNEL);
> > -			if (!alloc_ptr)
> > -				return -ENOMEM;
> > +			alloc_ptr[0] = kmalloc(kfree_mult * sizeof(struct kfree_obj), GFP_KERNEL);
> > +			alloc_ptr[1] = (kfree_rcu_test_single == kfree_rcu_test_double) ?
> > +				kmalloc(kfree_mult * sizeof(struct kfree_obj), GFP_KERNEL) : NULL;
> > +
> > +			// 0 ptr. is freed either over single or double argument.
> > +			if (alloc_ptr[0]) {
> > +				if (kfree_rcu_test_single == kfree_rcu_test_double ||
> > +						kfree_rcu_test_single) {
> > +					kfree_rcu(alloc_ptr[0]);
> > +				} else {
> > +					kfree_rcu(alloc_ptr[0], rh);
> > +				}
> > +			}
> > +
> > +			// 1 ptr. is always freed over double argument.
> > +			if (alloc_ptr[1])
> > +				kfree_rcu(alloc_ptr[1], rh);
> >  
> > -			kfree_rcu(alloc_ptr, rh);
> > +			if (!alloc_ptr[0] ||
> > +					(kfree_rcu_test_single == kfree_rcu_test_double &&
> > +						!alloc_ptr[1]))
> > +				return -ENOMEM;
> 
> How about something like this?
> 
> 	bool krts = kfree_rcu_test_single || kfree_rcu_test_single == kfree_rcu_test_double;
> 	bool krtd = kfree_rcu_test_double || kfree_rcu_test_single == kfree_rcu_test_double;
> 	bool krtb = kfree_rcu_test_single && kfree_rcu_test_double;
> 	DEFINE_TORTURE_RANDOM(tr);
> 
> 	...
> 
> 			alloc_ptr = kmalloc(kfree_mult * sizeof(struct kfree_obj), GFP_KERNEL);
> 			if (!alloc_ptr)
> 				return -ENOMEM;
> 			if (krtd || (krtb && (torture_random(&tr) & 0x800)))
> 				kfree_rcu(alloc_ptr, rh);
> 			else
> 				kfree_rcu(alloc_ptr);
> 
> >  		}
> >  
> >  		cond_resched();
>
Sorry for my late answer. I got it differently as we discussed offline.
Please see below the v3. Hope we are on the same page now :)

From e7181d01c5f7fab3418d6df155ccf06aff189328 Mon Sep 17 00:00:00 2001
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Date: Fri, 29 Jan 2021 19:51:27 +0100
Subject: [PATCH v3 1/1] rcuscale: add kfree_rcu() single-argument scale test

To stress and test a single argument of kfree_rcu() call, we
should to have a special coverage for it. We used to have it
in the test-suite related to vmalloc stressing. The reason is
the rcuscale is a correct place for RCU related things.

Therefore introduce two torture_param() variables, one is for
single-argument scale test and another one for double-argument
scale test.

By default kfree_rcu_test_single and kfree_rcu_test_double are
initialized to false. If both have the same value (false or true)
both are randomly tested, otherwise only the one with value true
is tested. The value of this is that it allows testing of both
options with one test.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/rcuscale.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 06491d5530db..0fb540e2b22b 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -625,6 +625,8 @@ rcu_scale_shutdown(void *arg)
 torture_param(int, kfree_nthreads, -1, "Number of threads running loops of kfree_rcu().");
 torture_param(int, kfree_alloc_num, 8000, "Number of allocations and frees done in an iteration.");
 torture_param(int, kfree_loops, 10, "Number of loops doing kfree_alloc_num allocations and frees.");
+torture_param(bool, kfree_rcu_test_single, false, "Do we run a kfree_rcu() single-argument scale test?");
+torture_param(bool, kfree_rcu_test_double, false, "Do we run a kfree_rcu() double-argument scale test?");
 
 static struct task_struct **kfree_reader_tasks;
 static int kfree_nrealthreads;
@@ -644,10 +646,13 @@ kfree_scale_thread(void *arg)
 	struct kfree_obj *alloc_ptr;
 	u64 start_time, end_time;
 	long long mem_begin, mem_during = 0;
+	bool kfree_rcu_test_both;
+	DEFINE_TORTURE_RANDOM(tr);
 
 	VERBOSE_SCALEOUT_STRING("kfree_scale_thread task started");
 	set_cpus_allowed_ptr(current, cpumask_of(me % nr_cpu_ids));
 	set_user_nice(current, MAX_NICE);
+	kfree_rcu_test_both = (kfree_rcu_test_single == kfree_rcu_test_double);
 
 	start_time = ktime_get_mono_fast_ns();
 
@@ -670,7 +675,15 @@ kfree_scale_thread(void *arg)
 			if (!alloc_ptr)
 				return -ENOMEM;
 
-			kfree_rcu(alloc_ptr, rh);
+			// By default kfree_rcu_test_single and kfree_rcu_test_double are
+			// initialized to false. If both have the same value (false or true)
+			// both are randomly tested, otherwise only the one with value true
+			// is tested.
+			if ((kfree_rcu_test_single && !kfree_rcu_test_double) ||
+					(kfree_rcu_test_both && torture_random(&tr) & 0x800))
+				kfree_rcu(alloc_ptr);
+			else
+				kfree_rcu(alloc_ptr, rh);
 		}
 
 		cond_resched();
-- 
2.20.1

> 
> And this is why I was so confused about the earlier OOMs.  We need
> something stronger, and not here, but rather inside the above loop.
> The function rcu_torture_fwd_prog_cond_resched() does what is needed,
> which needs to be moved to kernel/torture.c or to be a static inline in
> include/linux/torture.h so that it can be invoked here.
> 
> The flooding we are looking to emulate has to have frequent trips into
> userspace, and rcu_torture_fwd_prog_cond_resched() is the way that we
> emulate those trips.
> 
> But please make this change be a separate patch.
> 
OK. I will have a look at it!

--
Vlad Rezki
