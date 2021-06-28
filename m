Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 719923B664E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 17:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbhF1QBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 12:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbhF1QBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 12:01:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A75DC061574
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 08:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2CHhRZOQhuRMRmOJwG9bhC1JRYB41Jo0jQj6ZnEYgQE=; b=Yu83be+jK6WY/MkkADbTgY+Bs/
        v+Ol+5ETzOoILqYdV+RHcyuXSZiIZiFS2LsXfIjsaCImtPgt54H/H+wQeqYU/VUTne2yw0/fbWwVd
        dQ8cG6BecGF7H2QxNFzZq6Z+cl3gEfGtD2c7t8tF3/SSoQAIObJp1xN/tQ98JzCCVNhFb1mN1On8h
        3qqqF4hvOOlDRIT6xwA6QUEFteehaGUiTvC5a3A/iqdfw1DAZj9hrd19+H8YRJNzTVYdUqztO/e0C
        kg4JUyZ/8F7q1TazP9AZtuK8aOCbeY0cXMG61kEhz8Ryn0mnt1ai0gLNKDbm+wKhW0NB0zZQNt7C0
        H3FWMdzA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lxtdh-003D4q-3G; Mon, 28 Jun 2021 15:57:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id ED94C30022B;
        Mon, 28 Jun 2021 17:57:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CC5E22041E859; Mon, 28 Jun 2021 17:57:35 +0200 (CEST)
Date:   Mon, 28 Jun 2021 17:57:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 7/7] posix-cpu-timers: Recalc next expiration when
 timer_settime() ends up not queueing
Message-ID: <YNnxbzgckC3+Rh+7@hirez.programming.kicks-ass.net>
References: <20210622234155.119685-1-frederic@kernel.org>
 <20210622234155.119685-8-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622234155.119685-8-frederic@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2021 at 01:41:55AM +0200, Frederic Weisbecker wrote:
>  include/linux/posix-timers.h   |  7 +++++-
>  kernel/time/posix-cpu-timers.c | 41 +++++++++++++++++++++++++++++-----
>  2 files changed, 41 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
> index 4cf1fbe8d1bc..00fef0064355 100644
> --- a/include/linux/posix-timers.h
> +++ b/include/linux/posix-timers.h
> @@ -82,9 +82,14 @@ static inline bool cpu_timer_enqueue(struct timerqueue_head *head,
>  	return timerqueue_add(head, &ctmr->node);
>  }
>  
> +static inline bool cpu_timer_queued(struct cpu_timer *ctmr)
> +{
> +	return !!ctmr->head;

Sad that we can't check sighand lock here... but I agree that adding
that will be messy :/

> +}
