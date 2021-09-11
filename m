Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 469DD407A88
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 23:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233944AbhIKVgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 17:36:13 -0400
Received: from gate.crashing.org ([63.228.1.57]:56833 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229977AbhIKVgM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 17:36:12 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 18BLUhGl030275;
        Sat, 11 Sep 2021 16:30:43 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 18BLUfuG030274;
        Sat, 11 Sep 2021 16:30:41 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Sat, 11 Sep 2021 16:30:41 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kernel test robot <lkp@intel.com>,
        Yafang Shao <laoar.shao@gmail.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org
Subject: Re: [peterz-queue:sched/core 13/19] kernel/sched/fair.c:892:34: warning: variable 'stats' set but not used
Message-ID: <20210911213041.GD1583@gate.crashing.org>
References: <202109110214.oh62aoIq-lkp@intel.com> <20210911122049.GW4323@worktop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210911122049.GW4323@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Sat, Sep 11, 2021 at 02:20:49PM +0200, Peter Zijlstra wrote:
> On Sat, Sep 11, 2021 at 02:21:26AM +0800, kernel test robot wrote:
> > compiler: m68k-linux-gcc (GCC) 11.2.0
> 
> >    kernel/sched/fair.c: In function 'update_curr':
> >    kernel/sched/fair.c:860:42: warning: unused variable 'stats' [-Wunused-variable]
> >      860 |                 struct sched_statistics *stats = __schedstats_from_se(curr);
> >          |                                          ^~~~~
> 
> OK, compiler guys, this code reads like:
> 
> #define schedstats_enabled()	(0)
> #define __schedstat_set(x, y)	do { } while (0)
> 
> 
> 	if (schedstats_enabled()) {
> 		struct sched_statistics *stats = __schedstats_from_se(curr);
> 
> 		__schedstat_set(stats->exec_max,
> 				max(delta_exec, stats->exec_max));
> 	}
> 
> So yes, we initialize a variable that then isn't used, but the whole
> bloody thing is inside if (0) which will not ever get ran *anyway*.
> 
> This is a crap warning if ever I saw one...

Yes, we really should warn "do not use a preprocessor macro if what you
want is a function"?  The variable really *is* unused, with this macro.

If we would remove dead code before warning about unused variables
there would be many *more* false positives, fwiw.


Segher
