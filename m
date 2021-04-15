Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC723604D3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 10:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbhDOIs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 04:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbhDOIs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 04:48:57 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2843BC061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 01:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=eBuTqDypVu6e1lY+9cpL77Ud3/gpxsSbLzitWzul4AU=; b=b/rAuYrPTL723vHCtrvLgvhzKk
        AKdSNLTXOpEn4ba+yiEsrZeSuTrXwgIWLPUXHeeQN78ljkLP+5cd4mVD6TtIYVm8anJ6WKTOcWH/7
        TRkEtxp8A40N0gu2hyYDoGxkJMvRRpEgyr/aDYcrYM6NGbs4b7CAfC/jCI9WAboMC2sH6CQIrpqY3
        uv+tPwn4E+YOPzTFdRNo7k9UXDZnRzbuWWGsTlJiXxrdqFSerLFdar0GPlN5CIawuTFJgZAx6vrAA
        uEVEARFtZ93zka6oZvZWdiv2U6sKJSd4D9Kq+jvjcG18Ll4I8jKllsp0c4TkFthyeYrQHFTFpVm+T
        FY6z/kyA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lWxfn-00FPBo-3X; Thu, 15 Apr 2021 08:48:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 05EE1300209;
        Thu, 15 Apr 2021 10:48:25 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CD3C82022422C; Thu, 15 Apr 2021 10:48:25 +0200 (CEST)
Date:   Thu, 15 Apr 2021 10:48:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     kbuild-all@lists.01.org, kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [peterz-queue:perf/core 18/22] kernel/events/core.c:6418:22:
 sparse: sparse: incorrect type in assignment (different address spaces)
Message-ID: <YHf92aCeN65rANQY@hirez.programming.kicks-ass.net>
References: <202104142209.hLOfOONR-lkp@intel.com>
 <YHb9Mi1IwY5qtJxp@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YHb9Mi1IwY5qtJxp@elver.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 04:33:22PM +0200, Marco Elver wrote:
> On Wed, Apr 14, 2021 at 10:10PM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf/core
> > head:   0da503cd07380952599b67ded6efe030d78ea42d
> > commit: c7d4112e9f0e69edd649665836ce72008b95ab9f [18/22] perf: Add support for SIGTRAP on perf events
> [...]
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> [...]
> >   6416		info.si_errno = event->attr.type;
> >   6417		info.si_perf = event->attr.sig_data;
> > > 6418		info.si_addr = (void *)event->sig_addr;
> >   6419		force_sig_info(&info);
> 
> I think it wants the below (feel free to squash into "perf: Add support
> for SIGTRAP on perf events").
> 
> Thanks,
> -- Marco
> 
> ------ >8 ------
> 
> From: Marco Elver <elver@google.com>
> Date: Wed, 14 Apr 2021 16:26:26 +0200
> Subject: [PATCH] perf: Fix cast to void __user pointer
> 
> sparse let us know that si_addr is 'void __user *', therefore add the
> missing __user attribute to the cast.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  kernel/events/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 1d2077389c0c..2677438ed668 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -6414,7 +6414,7 @@ static void perf_sigtrap(struct perf_event *event)
>  	info.si_code = TRAP_PERF;
>  	info.si_errno = event->attr.type;
>  	info.si_perf = event->attr.sig_data;
> -	info.si_addr = (void *)event->sig_addr;
> +	info.si_addr = (void __user *)event->sig_addr;
>  	force_sig_info(&info);
>  }

Now the silly robot complains about:

CC      kernel/events/core.o
../kernel/events/core.c: In function ‘perf_sigtrap’:
../kernel/events/core.c:6418:17: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
6418 |  info.si_addr = (void __user *)event->sig_addr;

for all 32bit builds (because sig_addr is u64 and the pointer cast
truncates bits).

This had me look a little harder at sig_addr and I figured it should be
next to the pending fields for cache locality.

I've ended up with the below delta, does that work for you?

---

--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -735,6 +735,7 @@ struct perf_event {
 	int				pending_wakeup;
 	int				pending_kill;
 	int				pending_disable;
+	unsigned long			pending_addr;	/* SIGTRAP */
 	struct irq_work			pending;
 
 	atomic_t			event_limit;
@@ -778,9 +779,6 @@ struct perf_event {
 	void *security;
 #endif
 	struct list_head		sb_list;
-
-	/* Address associated with event, which can be passed to siginfo_t. */
-	u64				sig_addr;
 #endif /* CONFIG_PERF_EVENTS */
 };
 
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6415,7 +6415,7 @@ static void perf_sigtrap(struct perf_eve
 	info.si_code = TRAP_PERF;
 	info.si_errno = event->attr.type;
 	info.si_perf = event->attr.sig_data;
-	info.si_addr = (void __user *)event->sig_addr;
+	info.si_addr = (void __user *)event->pending_addr;
 	force_sig_info(&info);
 }
 
@@ -9137,7 +9137,7 @@ static int __perf_event_overflow(struct
 	if (events && atomic_dec_and_test(&event->event_limit)) {
 		ret = 1;
 		event->pending_kill = POLL_HUP;
-		event->sig_addr = data->addr;
+		event->pending_addr = data->addr;
 
 		perf_event_disable_inatomic(event);
 	}
