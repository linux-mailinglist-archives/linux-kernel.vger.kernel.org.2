Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1D43B69DE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 22:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235647AbhF1UtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 16:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236264AbhF1UtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 16:49:10 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A256DC061574
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 13:46:43 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id t3so27945075edc.7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 13:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JXoIt7pihemUAkjyb0k/va6D62kjJWDZQF9IdvlsEI0=;
        b=UxVLSCLLmb1ji+poet4HOWLBgwf/9veeB1sZPkQjgcEP7MaELmQN30CW0Am1jKgR31
         GHJ0ptkpbvBQRtPFTdWgiTE+txaIxWoQampvVhI2emsGB7O0BZZi8HKjow5Uilh8ZU0D
         Iw4PYmyz6TIPkyP5pLbvVg1LIRsStDSoGe9rBMNRib0KrRZ4a/Bx73CMsE/boJ9avAMS
         ASU4lcnofbSUMKcTtBCv7s9vGMFU9jc3yFMdGr4jHEOHv/rVW48YG5sAr84WnKWJmQQK
         9uywybvmCpWR2d6RDeDMwtbDRQ4yctQHZ9Zi0w+gObHhikNnH4u91RUhN5XDk4etsRpt
         ML2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=JXoIt7pihemUAkjyb0k/va6D62kjJWDZQF9IdvlsEI0=;
        b=HwWt9nK8Qfwknbpe+ax8yfHyo53jkViFmJE2hORcZ/N6Sq03u3aiAPhMWN69XbnZuZ
         sbaAHJq9Hw2aEell3vUFeSHCRvyOoMjIW3TrIbKrn5y8o7pxb4SGCRE0w4x6zVAcbp16
         YRGhZ3LjPo57qzt0NmTxJjEYaMl8fjw6ubgHyGV2oj2V6Um59Y95qe5x8iORQ3XnHFmH
         cHYKMKtrlYSjaP66psCZjPt2yZbddrWcFBuEnza2fcMlFD99GcTNNVtH/JnfaIKAuEPW
         ojOC2Mw+ixWlD0O/f74Nrh54BKZsrUeQShFB8BHj3fVu04GaQI4clAxTjLduDHXljbI+
         REcg==
X-Gm-Message-State: AOAM531riHNqoVGZB3Pmy7Or8LgVg82bgwKpkC1IWHLikEolOe04XYAm
        TKB2s1dmhpI0yNsxwcOmlX8=
X-Google-Smtp-Source: ABdhPJxzvf3d0Ta/25EPobxnCOYDQ+NBbbWKcXxGI6seVgfm7LIsvTKNpl6w1sSXY5WLGZ/oY63erw==
X-Received: by 2002:aa7:d159:: with SMTP id r25mr35532324edo.281.1624913202149;
        Mon, 28 Jun 2021 13:46:42 -0700 (PDT)
Received: from gmail.com (94-21-131-96.pool.digikabel.hu. [94.21.131.96])
        by smtp.gmail.com with ESMTPSA id j22sm7681446ejt.11.2021.06.28.13.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 13:46:41 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 28 Jun 2021 22:46:39 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH, -v2] sched/core: Disable CONFIG_SCHED_CORE by default
Message-ID: <YNo1L2j/AWPmrtHS@gmail.com>
References: <YNlxcCpk4shGcPrU@gmail.com>
 <CAHk-=wisVoq7COhA-B+5UAbisJqTn7Sehh-brqn6K3UVuFzoew@mail.gmail.com>
 <YNopqw/BbJGjOGMq@gmail.com>
 <CAHk-=wjNP8Oi4nve=uu=Q3+rGar3CY9fBUQFuJK-WYCK3F198w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjNP8Oi4nve=uu=Q3+rGar3CY9fBUQFuJK-WYCK3F198w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, Jun 28, 2021 at 12:57 PM Ingo Molnar <mingo@kernel.org> wrote:
> >
> > You are completely right, I missed this. Find below the patch to fix it -
> 
> I think you should update the helptext too, which currently says that
> it's enabled if SCHED_SMT is enabled.
> 
> And yes, it may be that there is no measurable performance downside,
> but this feature has been discussed and under development for a long
> time now, and I'd like the default to try to limit the impact since it
> makes little sense to most people.

Updated patch attached, which updates the help text and clarifies what 
overhead there is.

While the worst of the overhead is behind the __sched_core_enabled static 
key, there's a notable increase in pick_next_task(), which might be 
measurable with the right microbenchmark.

So the 'no overhead' claim is probably not entirely true, and comes from 
the context of *horrible* overhead of early iterations of the core 
scheduling feature ...

Thanks,

	Ingo

===================================>
From: Ingo Molnar <mingo@kernel.org>
Date: Mon, 28 Jun 2021 21:55:16 +0200
Subject: [PATCH] sched/core: Disable CONFIG_SCHED_CORE by default

This option at minimum adds extra code to the scheduler - even if
it's default unused - and most users wouldn't want it.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/Kconfig.preempt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index bd7c4147b9a8..5876e30c5740 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -102,7 +102,6 @@ config PREEMPT_DYNAMIC
 
 config SCHED_CORE
 	bool "Core Scheduling for SMT"
-	default y
 	depends on SCHED_SMT
 	help
 	  This option permits Core Scheduling, a means of coordinated task
@@ -115,7 +114,8 @@ config SCHED_CORE
 	   - mitigation of some (not all) SMT side channels;
 	   - limiting SMT interference to improve determinism and/or performance.
 
-	  SCHED_CORE is default enabled when SCHED_SMT is enabled -- when
-	  unused there should be no impact on performance.
+	  SCHED_CORE is default disabled. When it is enabled and unused,
+	  which is the likely usage by Linux distributions, there should
+	  be no measurable impact on performance.
 
 
