Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E664E40584E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 15:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351069AbhIIN4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 09:56:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:39696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356663AbhIINyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 09:54:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0B24560F4A;
        Thu,  9 Sep 2021 13:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631195620;
        bh=wX/t1ySdI9RzQU+w7TBtaVXBa9pRpdLD+m8PM7j2Hgg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PseAVEo+MvmLtzwfYNQKUzLS8EpTQ0M8a7XdLq2d0zU/OYF+bkV9mZCoilTlqoMEj
         18AggIHDZoxSSIB1yjVyj3xqZXagv7VMvrwIehisKleotLeRbDo29RT+cMiu3I3Nla
         1JwIII//YR5+blHxYq+/wEYy4ij1CBQJsYpTvKlotUnB7cHJEBf5OkiPhILcoF21Lo
         NNZxydKLi+zg0IfDcuq7iTZcRWgEzk8tZmo5GROPWYg0lZRV4/Pz43fpFjzJcANzXu
         BrhQM4AhTk6N06n1FhVHiwEjI3lyU5Wy7lxbND18d6rdFgN0184v1y+R3CxhEAll6P
         1KTsThp+I5gTA==
Date:   Thu, 9 Sep 2021 14:53:34 +0100
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Waiman Long <longman@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mike Galbraith <efault@gmx.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 2/4] locking/rwbase: Properly match set_and_save_state()
 to restore_state()
Message-ID: <20210909135334.GC9722@willie-the-truck>
References: <20210909105915.757320973@infradead.org>
 <20210909110203.828203010@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210909110203.828203010@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2021 at 12:59:17PM +0200, Peter Zijlstra wrote:
> Noticed while looking at the readers race.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/locking/rwbase_rt.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/kernel/locking/rwbase_rt.c
> +++ b/kernel/locking/rwbase_rt.c
> @@ -220,7 +220,7 @@ static int __sched rwbase_write_lock(str
>  	for (; atomic_read(&rwb->readers);) {
>  		/* Optimized out for rwlocks */
>  		if (rwbase_signal_pending_state(state, current)) {
> -			__set_current_state(TASK_RUNNING);
> +			rwbase_restore_current_state();
>  			__rwbase_write_unlock(rwb, 0, flags);
>  			return -EINTR;

Acked-by: Will Deacon <will@kernel.org>

Will
