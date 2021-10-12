Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1B5B42A547
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 15:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236679AbhJLNTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 09:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236544AbhJLNTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 09:19:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48012C061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 06:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PcrwjpNbjvSiMmJst3jkPTToJXQ7Gee1/ZPXz0Rsz7M=; b=GA7Ap1p4PUzee/noDlsPlNNt3g
        oOGOpEFxde0qrjAZ/i7tC6jiDh7Cq+O+VJdgYKg3XWFcuZBMz2rdBPT9X7CwSQ6UMvXL1bduhgUi6
        JNL8/SNW2ej3vXXAZPOwFAsDiRq//i7Mcrip0JlgwWDc6gF4IaxaFCYMmgn34lgO3Z/uGOsSao43z
        JRpvIYmIcn3HW8OhN10bSw/5hX/Pv4qvcheb8mog5gvPBsdvehiY4DKlBER23XDv7fqTtQkdPGHZT
        McB6HvEb8foCPDbkyMebzM0eJDnliiSBxTE2Z/IUC0CJs/EsaNMAjDdpqG2z32vbarZkE+1IvgQBw
        9H5IfO0A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maHdG-006WfH-Nn; Tue, 12 Oct 2021 13:16:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7384230030B;
        Tue, 12 Oct 2021 15:15:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 578722C10165C; Tue, 12 Oct 2021 15:15:50 +0200 (CEST)
Date:   Tue, 12 Oct 2021 15:15:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yanfei Xu <yanfei.xu@windriver.com>
Cc:     mingo@redhat.com, will@kernel.org, longman@redhat.com,
        boqun.feng@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] locking/mutex: remove rcu_read_lock/unlock as we
 already disabled preemption
Message-ID: <YWWKhoRzUWoMsJbk@hirez.programming.kicks-ass.net>
References: <20211008032518.1298372-1-yanfei.xu@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211008032518.1298372-1-yanfei.xu@windriver.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2021 at 11:25:18AM +0800, Yanfei Xu wrote:
> preempt_disable/enable() is equal to RCU read-side crital section,
> and the mutex lock slowpath disabled the preemption for the optimistic
> spinning code. Let's remove the rcu_read_lock/unlock for saving some 
> cycles in hot codes.
> 
> Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
> ---
> v1->v2: fix the incorrect comment in code and commit message. 
>         thanks for WaiMan's suggestion.
> 
> BTW, sorry for this late v2 due to a long vocation.
> 
>  kernel/locking/mutex.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
> index 2fede72b6af5..2f654cfb10d9 100644
> --- a/kernel/locking/mutex.c
> +++ b/kernel/locking/mutex.c
> @@ -351,13 +351,14 @@ bool mutex_spin_on_owner(struct mutex *lock, struct task_struct *owner,
>  {
>  	bool ret = true;

	lockdep_assert_preemption_disabled();

> -	rcu_read_lock();
>  	while (__mutex_owner(lock) == owner) {
>  		/*
>  		 * Ensure we emit the owner->on_cpu, dereference _after_

And did you check the other code in locking/ for similar things?
