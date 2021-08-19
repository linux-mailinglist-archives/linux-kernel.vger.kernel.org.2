Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3313F1FE5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 20:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234422AbhHSS3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 14:29:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48788 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233792AbhHSS33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 14:29:29 -0400
Date:   Thu, 19 Aug 2021 20:28:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629397731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4c1umn1z9wS9r7aL4cOCL+KeJXW9s3c7vulbukHF80Y=;
        b=qhWKztPLw2yYJWCUIffgoY9qnGWo6D64OgwuGR0NBqrBDs+fNTPoD5EXa2WfSzeh3JBjWk
        EbsyDvhD9wa5PX8xAiFekfZi4Ubuz7se7p2qC8b2GvKgdUk0cse+zqwBA2yvNYKwAXlOzV
        nomk20wq9oasqzMJGTBmPiBmATpMnlu1xn3TUXoIzZvqLKI4SEuglMZ059dQrSeyNv7MJ5
        V6sEM6lyVJ7OENCjN8RxmXkua8r0ohuemaBbWESfXPBNfn4MEa8/4/BjlwkMISP2QbXJoR
        FV5C9rOWAyeE7PlkH0shQmiECVVFWsdtPMNNtNaC0+Gw+EMFGlYwgN26YETVQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629397731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4c1umn1z9wS9r7aL4cOCL+KeJXW9s3c7vulbukHF80Y=;
        b=m/9u3+jpBfzxClCsS3bk9CemhWb903D5R+l5PMAWt9FDPG7mpvPziYJiRei/Xo5rhhhp+l
        xsfeL3Q+k4raIDDg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Mike Galbraith <efault@gmx.de>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [patch V5 41/72] locking/ww_mutex: Gather mutex_waiter
 initialization
Message-ID: <20210819182849.ztz6kswedrzpiaon@linutronix.de>
References: <20210815203225.710392609@linutronix.de>
 <20210815211304.281927514@linutronix.de>
 <20210819175110.w7lxq5w3gdj5vhwf@linutronix.de>
 <YR6gUaz2QMeNkPXp@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YR6gUaz2QMeNkPXp@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-19 20:17:53 [+0200], Peter Zijlstra wrote:
> You mean the 'use_ww_ctx && !ww_ctx' case?
> 
> Would not the below also help with that?

Yes, it does, just tested.

> diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
> index 3a65bf4bacfd..d456579d0952 100644
> --- a/kernel/locking/mutex.c
> +++ b/kernel/locking/mutex.c
> @@ -618,7 +618,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
>  
>  	debug_mutex_lock_common(lock, &waiter);
>  	waiter.task = current;
> -	if (ww_ctx)
> +	if (use_ww_ctx)
>  		waiter.ww_ctx = ww_ctx;
>  
>  	lock_contended(&lock->dep_map, ip);

Sebastian
