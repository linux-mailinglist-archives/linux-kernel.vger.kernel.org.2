Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6800340398F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 14:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351650AbhIHMP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 08:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235195AbhIHMP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 08:15:59 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC588C061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 05:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hEuKeBl0bf7BPTqdloL/nKyrupvk3MfCfBiLXZV+JGo=; b=C0pyq+4MTP9GV/XkkdcwdYrBeL
        VtLyT3IpdGg0rMMgrOB0oISXy/GE3Pt390RTiq0HNrmljJDklcwCdTVJHODRFpT27YiFokBnbciB7
        tyZ/63dsfAg7Up6HojqXrMPrNxCy6BWLv0wkRRZF5zSZSkttM0vtgVq2SmD9Rv8D6swwA2pXELEQs
        kKucCfj7F1QikfTTiDweMb0peya5sNPum93U4/e9og+Y2QGIa3HcqIZ+R87K25a0ud57uhPkQtgzm
        7dFiJ8N/vrrLeBW8MpXeN7ilNSwIGVQmmcTlQy1JH/5nDX/kSMxyrTwwbXF54kRLMqQBUOJFncyqD
        kPUNEupA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mNwTH-001dYu-0C; Wed, 08 Sep 2021 12:14:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1B646300332;
        Wed,  8 Sep 2021 14:14:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0578F2080015E; Wed,  8 Sep 2021 14:14:29 +0200 (CEST)
Date:   Wed, 8 Sep 2021 14:14:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mike Galbraith <efault@gmx.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] locking: rwbase: Take care of ordering guarantee for
 fastpath reader
Message-ID: <YTipJJcjU57l7Mju@hirez.programming.kicks-ass.net>
References: <20210901150627.620830-1-boqun.feng@gmail.com>
 <YTijvI3BpBxkWcTd@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTijvI3BpBxkWcTd@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2021 at 01:51:24PM +0200, Peter Zijlstra wrote:
> On Wed, Sep 01, 2021 at 11:06:27PM +0800, Boqun Feng wrote:
> @@ -201,23 +207,30 @@ static int __sched rwbase_write_lock(struct rwbase_rt *rwb,
>  {
>  	struct rt_mutex_base *rtm = &rwb->rtmutex;
>  	unsigned long flags;
> +	int readers;
>  
>  	/* Take the rtmutex as a first step */
>  	if (rwbase_rtmutex_lock_state(rtm, state))
>  		return -EINTR;
>  
>  	/* Force readers into slow path */
> -	atomic_sub(READER_BIAS, &rwb->readers);
> +	readers = atomic_sub_return_relaxed(READER_BIAS, &rwb->readers);

Hurmph... the above really begs for something like

	if (!readers)
		return 0;

But then we needs that _acquire() thing again :/

