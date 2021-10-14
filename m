Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF06542DDB6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 17:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233146AbhJNPOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 11:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbhJNPOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 11:14:07 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77674C0612ED
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 08:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=W5pw2CE/uzyiW+aTpQ3ZuIwrhdvcki06u9/0gkIPEBc=; b=euISmwXBiaLKhCbaEMBPqxPsdq
        daMFJJNgNxPMA2U/OltF7Z7QpwfpX/6jKE/UFAnCglhWVvLz/v+hPrrrp/xHXLhoubB++R1vqnJDs
        42Epm8kGWy3IhFfZDF5nvMyr+aR1Vq7Fx/8vTRbPh5gPh42KWhuyzPeor/0eWUzbtkYFvGvOsg5w9
        RId0pNOPM2bOMSuZTls9taTomwj0w44piVkXROyETnV5yrALMq6y0i35+yRtGoiUGgYmYGYifTdd6
        TaJ6AA2A4x3Wp+bpbl7++RNu/VcGXLiXxn+14v6VoGNLynnC68DA0SSxjkawPFQOoLTDBkgdhk4+6
        bzAaazgg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mb2Ls-009qwq-Ls; Thu, 14 Oct 2021 15:09:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7602F30030B;
        Thu, 14 Oct 2021 17:08:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6258C20A958AF; Thu, 14 Oct 2021 17:08:59 +0200 (CEST)
Date:   Thu, 14 Oct 2021 17:08:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     kernel test robot <lkp@intel.com>,
        Yafang Shao <laoar.shao@gmail.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [tip:sched/core 14/47] kernel/sched/fair.c:893:22: error:
 variable 'p' set but not used
Message-ID: <YWhIC30vBoOgXxie@hirez.programming.kicks-ass.net>
References: <202110121132.N2z9JrD0-lkp@intel.com>
 <YWVw/oVd5ztGZDAK@hirez.programming.kicks-ass.net>
 <YWWPLnaZGybHsTkv@hirez.programming.kicks-ass.net>
 <YWew3ItdPC5QrL/w@archlinux-ax161>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YWew3ItdPC5QrL/w@archlinux-ax161>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 09:23:56PM -0700, Nathan Chancellor wrote:
> On Tue, Oct 12, 2021 at 03:35:42PM +0200, Peter Zijlstra wrote:
> > On Tue, Oct 12, 2021 at 01:26:54PM +0200, Peter Zijlstra wrote:
> > 
> > > Again, I have absolutely no intention of fixing this. IMO this is the
> > > compiler being a total pain in the arse.
> > > 
> > > Please stop reporting this.
> > 
> > How's this then?
> > 
> > diff --git a/kernel/sched/Makefile b/kernel/sched/Makefile
> > index 978fcfca5871..b0d9121c5dce 100644
> > --- a/kernel/sched/Makefile
> > +++ b/kernel/sched/Makefile
> > @@ -3,6 +3,10 @@ ifdef CONFIG_FUNCTION_TRACER
> >  CFLAGS_REMOVE_clock.o = $(CC_FLAGS_FTRACE)
> >  endif
> >  
> > +# The compilers are complaining about unused variables inside an if(0) scope
> > +# block. This is daft, shut them up.
> > +ccflags-y += -Wno-unused-but-set-variable
> 
> Please consider making this
> 
> ccflags-y += $(call cc-disable-warning, unused-but-set-variable)

Ooh, shiny, will do.

> because -Wunused-but-set-variable was only added to clang in the 13
> release but we support back to 10, meaning this will cause errors for
> those older compilers.
> 
> With that:
> 
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> 
> Additionally, perhaps this could be restricted to just fair.c?

It triggers in a bunch of files, given the right config (defconfig -SCHEDSTATS +SCHED_DEBUG)

(and I have a pile of patches for most of the other warnings somewhere...)

---
# make O=defconfig-build/ kernel/sched/ -j8 -s W=1
../kernel/sched/deadline.c: In function ‘update_stats_wait_start_dl’:
../kernel/sched/deadline.c:1486:27: warning: variable ‘stats’ set but not used [-Wunused-but-set-variable]
1486 |  struct sched_statistics *stats;
|                           ^~~~~
../kernel/sched/deadline.c: In function ‘update_stats_wait_end_dl’:
../kernel/sched/deadline.c:1498:27: warning: variable ‘stats’ set but not used [-Wunused-but-set-variable]
1498 |  struct sched_statistics *stats;
|                           ^~~~~
../kernel/sched/deadline.c: In function ‘update_stats_enqueue_sleeper_dl’:
../kernel/sched/deadline.c:1510:27: warning: variable ‘stats’ set but not used [-Wunused-but-set-variable]
1510 |  struct sched_statistics *stats;
|                           ^~~~~
../kernel/sched/fair.c: In function ‘update_curr’:
../kernel/sched/fair.c:860:28: warning: variable ‘stats’ set but not used [-Wunused-but-set-variable]
860 |   struct sched_statistics *stats;
|                            ^~~~~
../kernel/sched/fair.c: In function ‘update_stats_wait_start_fair’:
../kernel/sched/fair.c:893:22: warning: variable ‘p’ set but not used [-Wunused-but-set-variable]
893 |  struct task_struct *p = NULL;
|                      ^
../kernel/sched/fair.c:892:27: warning: variable ‘stats’ set but not used [-Wunused-but-set-variable]
892 |  struct sched_statistics *stats;
|                           ^~~~~
../kernel/sched/fair.c: In function ‘update_stats_wait_end_fair’:
../kernel/sched/fair.c:910:22: warning: variable ‘p’ set but not used [-Wunused-but-set-variable]
910 |  struct task_struct *p = NULL;
|                      ^
../kernel/sched/fair.c:909:27: warning: variable ‘stats’ set but not used [-Wunused-but-set-variable]
909 |  struct sched_statistics *stats;
|                           ^~~~~
../kernel/sched/fair.c: In function ‘update_stats_enqueue_sleeper_fair’:
../kernel/sched/fair.c:936:22: warning: variable ‘tsk’ set but not used [-Wunused-but-set-variable]
936 |  struct task_struct *tsk = NULL;
|                      ^~~
../kernel/sched/fair.c:935:27: warning: variable ‘stats’ set but not used [-Wunused-but-set-variable]
935 |  struct sched_statistics *stats;
|                           ^~~~~
../kernel/sched/fair.c: In function ‘set_next_entity’:
../kernel/sched/fair.c:4450:28: warning: variable ‘stats’ set but not used [-Wunused-but-set-variable]
4450 |   struct sched_statistics *stats;
|                            ^~~~~
../kernel/sched/rt.c:669:6: warning: no previous prototype for ‘sched_rt_bandwidth_account’ [-Wmissing-prototypes]
669 | bool sched_rt_bandwidth_account(struct rt_rq *rt_rq)
|      ^~~~~~~~~~~~~~~~~~~~~~~~~~
../kernel/sched/rt.c: In function ‘update_stats_wait_start_rt’:
../kernel/sched/rt.c:1292:22: warning: variable ‘p’ set but not used [-Wunused-but-set-variable]
1292 |  struct task_struct *p = NULL;
|                      ^
../kernel/sched/rt.c: In function ‘update_stats_enqueue_sleeper_rt’:
../kernel/sched/rt.c:1311:22: warning: variable ‘p’ set but not used [-Wunused-but-set-variable]
1311 |  struct task_struct *p = NULL;
|                      ^
../kernel/sched/rt.c: In function ‘update_stats_wait_end_rt’:
../kernel/sched/rt.c:1341:22: warning: variable ‘p’ set but not used [-Wunused-but-set-variable]
1341 |  struct task_struct *p = NULL;
|                      ^
../kernel/sched/core.c:3420:6: warning: no previous prototype for ‘sched_set_stop_task’ [-Wmissing-prototypes]
3420 | void sched_set_stop_task(int cpu, struct task_struct *stop)
|      ^~~~~~~~~~~~~~~~~~~
../kernel/sched/debug.c: In function ‘print_cfs_group_stats’:
../kernel/sched/debug.c:466:28: warning: variable ‘stats’ set but not used [-Wunused-but-set-variable]
466 |   struct sched_statistics *stats;
|                            ^~~~~
../kernel/sched/fair.c:8673: warning: Function parameter or member 'sds' not described in 'update_sg_lb_stats'
