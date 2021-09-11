Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF1B407AB1
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 00:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234204AbhIKWfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 18:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbhIKWfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 18:35:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9746FC061574;
        Sat, 11 Sep 2021 15:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XVZFgr0/IpI6HZ5BddTEu3Nz+x0vlNCd5Qh7W6ZME/U=; b=LL22YaiURpoQEr7o3N1NVzgep/
        eiWhD04rWYUoxlIQn1Z7/kmbJDJVB5Z6P2WwmEgnFFRfnLHWvIWLXH6HoWGahRo32myY8Zc3iWBpG
        oQJFG8hvhGCUX4HdMizpVknokkYZV41FBqsIWHpqhHragpz/2/+fcifuHK3MQGmwRiyQ9Nb+Wi4kV
        AsgLhjGCYnpA6x1DyG9Ow4pUrwZRha8ofuC2VZGyFYjUvBmkF0cbcLTj0sTb20LBkuse43V/QL9IA
        5zGXGJs++e719NvRRIsQfo1vtMOoX6hUn8A8Xq+07lXvQaP0O/2qIkmylFsnYm0rF4R8E6JJ1qKd5
        K7cVCUHg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mPBYk-00CDmQ-Jd; Sat, 11 Sep 2021 22:33:26 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 70E439862C9; Sun, 12 Sep 2021 00:33:13 +0200 (CEST)
Date:   Sun, 12 Sep 2021 00:33:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     kernel test robot <lkp@intel.com>,
        Yafang Shao <laoar.shao@gmail.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org
Subject: Re: [peterz-queue:sched/core 13/19] kernel/sched/fair.c:892:34:
 warning: variable 'stats' set but not used
Message-ID: <20210911223313.GC4323@worktop.programming.kicks-ass.net>
References: <202109110214.oh62aoIq-lkp@intel.com>
 <20210911122049.GW4323@worktop.programming.kicks-ass.net>
 <20210911213041.GD1583@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210911213041.GD1583@gate.crashing.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 11, 2021 at 04:30:41PM -0500, Segher Boessenkool wrote:
> Hi!
> 
> On Sat, Sep 11, 2021 at 02:20:49PM +0200, Peter Zijlstra wrote:
> > On Sat, Sep 11, 2021 at 02:21:26AM +0800, kernel test robot wrote:
> > > compiler: m68k-linux-gcc (GCC) 11.2.0
> > 
> > >    kernel/sched/fair.c: In function 'update_curr':
> > >    kernel/sched/fair.c:860:42: warning: unused variable 'stats' [-Wunused-variable]
> > >      860 |                 struct sched_statistics *stats = __schedstats_from_se(curr);
> > >          |                                          ^~~~~
> > 
> > OK, compiler guys, this code reads like:
> > 
> > #define schedstats_enabled()	(0)
> > #define __schedstat_set(x, y)	do { } while (0)
> > 
> > 
> > 	if (schedstats_enabled()) {
> > 		struct sched_statistics *stats = __schedstats_from_se(curr);
> > 
> > 		__schedstat_set(stats->exec_max,
> > 				max(delta_exec, stats->exec_max));
> > 	}
> > 
> > So yes, we initialize a variable that then isn't used, but the whole
> > bloody thing is inside if (0) which will not ever get ran *anyway*.
> > 
> > This is a crap warning if ever I saw one...
> 
> Yes, we really should warn "do not use a preprocessor macro if what you
> want is a function"?  The variable really *is* unused, with this macro.

Why would I want to write a bunch of one-off functions and preprocessor
guard them? That's going to be a mess.

> If we would remove dead code before warning about unused variables
> there would be many *more* false positives, fwiw.

Not if you also remove any variables declared in dead code and all
variables only used in the dead code.

