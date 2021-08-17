Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0A273EEEB2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 16:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240180AbhHQOoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 10:44:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:32828 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238059AbhHQOoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 10:44:24 -0400
Date:   Tue, 17 Aug 2021 16:43:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629211429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ToTwZ7fzKUwF5DMBpNCJy591Y2V7vjABASffhGtERYs=;
        b=TTmDah60q34JslYwBUsTpbS2H+bgCL9WONxSFaeAZ6iZpG2hcFc97mt7lJYtci1ESsUdMA
        HfcOqS6YKtuKmTB//UZp8sDhM/SeEO4G7cC7teUlw+nE6brK/RKC05R2kf5xntm8+jaUSN
        1RvYIVcvw0XvEb6JCZDHpLm7S1isiFdZ2ZB96H3BvUQ3hWfn1EzSlXcOXNOSEk9BD3vgx/
        3z/qbiLlDeb60TTYxEIZjIEFP0w2HQH0qzjHXGybpmpYoZ3vGqzs+no8w830UhQsJxyr1v
        ONls+D6honXtEzORYJuZKm9QgtJ5srr02gGRlCwwyIYEBmrN+ekqAHwdpVwoEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629211429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ToTwZ7fzKUwF5DMBpNCJy591Y2V7vjABASffhGtERYs=;
        b=g/h9HV3880q78q/QHt6T5odQjDeawMOp7OK21rnI6o0ovdcwBQ4M/EstlbV6DyJPVcpCYH
        ChRMMebLfK6N1CBg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rcu@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Steven Price <steven.price@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH v3 2/4] sched: Introduce migratable()
Message-ID: <20210817144348.kkgoytuz3766jeoz@linutronix.de>
References: <20210811201354.1976839-1-valentin.schneider@arm.com>
 <20210811201354.1976839-3-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210811201354.1976839-3-valentin.schneider@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-11 21:13:52 [+0100], Valentin Schneider wrote:
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index debc960f41e3..8ba7b4a7ee69 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1715,6 +1715,16 @@ static inline bool is_percpu_thread(void)
>  #endif
>  }
>  
> +/* Is the current task guaranteed to stay on its current CPU? */
> +static inline bool migratable(void)
> +{
> +#ifdef CONFIG_SMP
> +	return preemptible() && !current->migration_disabled;
> +#else
> +	return true;

shouldn't this be false in the UP case?

> +#endif
> +}
> +
>  /* Per-process atomic flags. */
>  #define PFA_NO_NEW_PRIVS		0	/* May not gain new privileges. */
>  #define PFA_SPREAD_PAGE			1	/* Spread page cache over cpuset */

Sebastian
