Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34B973C82A7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 12:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239107AbhGNKWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 06:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238638AbhGNKWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 06:22:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05484C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 03:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Xe3dguhWCsGlums2k2x94NYL3ilyvsPEmKUpmyGp7Cw=; b=Lr0qhmEPWfVuUbAbA+qBtFQLip
        uqTrSTuOzD20H9fb8PWwPaPppm6WB6zAHLM/bEXb6HENdHixoN69J0+sT3ADmd6SKYsKitM/kjLHI
        CMEVf+TiDmvMa6VWiZBMvVoeffPq1M5YqDqliIDyG/0wdpmuXHLlEk5QwRsRvZKpLQ6Wi6VET3O6F
        WLm3zJ4kXlqvgm3vWBVHOotMEuuyyutUMYJDOYffBUT3F7La9M1fKVmqkGpckDJdJuG7kpquFyYP/
        nk3nknbFvvbnFZ1IfKL7eqe9G6n55PmyRPlph/KwwWnZijcxCZzdiLBG1W5+rD9+dKaqvEW9pHB0V
        AsmQ69Xw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3byM-0026La-6T; Wed, 14 Jul 2021 10:18:39 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0776798689D; Wed, 14 Jul 2021 12:18:31 +0200 (CEST)
Date:   Wed, 14 Jul 2021 12:18:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [patch 14/50] locking/rtmutex: Add wake_state to rt_mutex_waiter
Message-ID: <20210714101831.GC2591@worktop.programming.kicks-ass.net>
References: <20210713151054.700719949@linutronix.de>
 <20210713160747.320345860@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210713160747.320345860@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2021 at 05:11:08PM +0200, Thomas Gleixner wrote:
> @@ -33,6 +34,7 @@ struct rt_mutex_waiter {
>  	struct rb_node		pi_tree_entry;
>  	struct task_struct	*task;
>  	struct rt_mutex		*lock;
> +	int			wake_state;
>  	int			prio;
>  	u64			deadline;

State is 'unsigned int', but we're (luckily) not yet at the MSB so it's
a bit moot, still...
