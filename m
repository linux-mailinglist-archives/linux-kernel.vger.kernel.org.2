Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C63E238DAEE
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 12:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbhEWK6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 06:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbhEWK6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 06:58:45 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDE7C061574
        for <linux-kernel@vger.kernel.org>; Sun, 23 May 2021 03:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gw7rNxRfNTjuFI4Ut7DQRtrbTW37NXCrecNUqsprRRk=; b=jPWyPs3X1tfUhwZrI6O5BuX0zt
        xqL2RV0qbEWNGCCKH7qjj6yXzcZ5gO9VvAPumLBAuRCuMUPMiwEcgd3fgSgBIllnWTd5IwUJGFXPT
        znJUbA2LiOs5vJLMV9UDLJlSVY/uw+4sk9CO3ZRFeOXgJWDzkHO0LIT9QBdPzsQuffV40c3b9OiIX
        krFepAuid0yU2E8RCCl2NE+8MbdfyqS4W8AO2T8OVy637212dykyIsUW77Pqi4wMl+msXB46z2HOx
        HMiXqQ+5twMcWQo/U1aWv3jdqNzUpLnxmaNAsDXNEOBwV5FFLOhjfOVM1VrHJWiiyXGh5ZYx8zRtb
        fSR7pqMQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lkln8-004HlW-1X; Sun, 23 May 2021 10:57:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 98FC1300103;
        Sun, 23 May 2021 12:57:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7268031473E79; Sun, 23 May 2021 12:57:04 +0200 (CEST)
Date:   Sun, 23 May 2021 12:57:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Hugh Dickins <hughd@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: config SCHED_CORE
Message-ID: <YKo1AOIIsZectSQt@hirez.programming.kicks-ass.net>
References: <alpine.LSU.2.11.2105201954180.6100@eggly.anvils>
 <YKdm69K8k/ztd6BM@hirez.programming.kicks-ass.net>
 <CAEXW_YRxOqQCF2FgXAjL3xkZhRD4rdFuxvyPd-ESXYQQ78cyfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YRxOqQCF2FgXAjL3xkZhRD4rdFuxvyPd-ESXYQQ78cyfQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 07:57:35AM -0400, Joel Fernandes wrote:
> On Fri, May 21, 2021 at 3:53 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > +       help
> > +         This option enables Core scheduling, a means of coordinated task
> > +         selection across SMT siblings with the express purpose of creating a
> > +         Core wide privilidge boundary. When enabled -- see prctl(PR_SCHED_CORE)
> > +         -- task selection will ensure all SMT siblings will execute a task
> > +         from the same 'core group', forcing idle when no matching task is found.
> > +
> > +         This provides means of mitigation against a number of SMT side-channels;
> > +         but is, on its own, insufficient to mitigate all known side-channels.
> > +         Notable: the MDS class of attacks require more.
> > +
> > +         Default enabled for anything that has SCHED_SMT, when unused there should
> > +         be no impact on performance.
> 
> This description sort of makes it sound like security is the only
> usecase. Perhaps we can also add here that core-scheduling can help
> performance of workloads where hyperthreading is undesired, such as
> when VM providers don't want to share hyperthreads.

Something like so then?

---
 kernel/Kconfig.preempt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index ea1e3331c0ba..cd497fecfd43 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -104,4 +104,18 @@ config SCHED_CORE
 	bool "Core Scheduling for SMT"
 	default y
 	depends on SCHED_SMT
+	help
+	  This option enables Core scheduling, a means of coordinated task
+	  selection across SMT siblings. When enabled -- see
+	  prctl(PR_SCHED_CORE) -- task selection will ensure all SMT siblings
+	  will execute a task from the same 'core group', forcing idle when no
+	  matching task is found.
+
+	  Use of this feature includes:
+	   - mitigation of some (not all) SMT side channels;
+	   - limiting SMT interference to improve determinism and/or performance.
+
+	  Default enabled for anything that has SCHED_SMT, when unused there
+	  should be no impact on performance.
+
 
