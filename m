Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1783C8008
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 10:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238486AbhGNIbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 04:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbhGNIbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 04:31:33 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45335C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 01:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XrKNiaYguW7yu1B6pn0ZucWLQ1pEtpZXx5BTuMnbfHY=; b=f4R0d9vZq9OfjqcTJi3TgwGDiH
        tMI0NuPP2LO0jMNupd9Fnrm3e4JiMS5sEQk3bNaCVIMMDz5dFa4NQbQZDXqAH7RJ4jQpmP/X5Sxwe
        OM1SwEoeDoHwZr0XR3AekIopzvmuznlJCYVjpf0/uf9NEdi11pvCQWtrcTH2PiJIN1waX+R0CXtpt
        K8hgh+5NgBy2KlQinBqMzIoxZUxRQlOgrEt8+8BNCgSsr3i7Sywm38FNeIkCjos44uIOtzvkmFwD/
        RhY2hiipuZJCHMMeDCaP7zaEHtxznOU3QPaCm6309cZa6ND6nONYszkd+nJLRlv/0bGQ6We/rSb9t
        IVrAx9tw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3aFh-00HQgN-68; Wed, 14 Jul 2021 08:28:21 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id B039F98689D; Wed, 14 Jul 2021 10:28:20 +0200 (CEST)
Date:   Wed, 14 Jul 2021 10:28:20 +0200
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
Subject: Re: [patch 05/50] sched: Provide schedule point for RT locks
Message-ID: <20210714082820.GB2725@worktop.programming.kicks-ass.net>
References: <20210713151054.700719949@linutronix.de>
 <20210713160746.410991567@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210713160746.410991567@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2021 at 05:10:59PM +0200, Thomas Gleixner wrote:

> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5832,8 +5832,14 @@ pick_next_task(struct rq *rq, struct tas
>   */
>  #define	SM_NONE			0x0
>  #define	SM_PREEMPT		0x1
> -#define SM_MASK_PREEMPT		UINT_MAX
> -#define SM_MASK_STATE		SM_MASK_PREEMPT
> +#ifndef CONFIG_PREEMPT_RT
> +# define SM_MASK_PREEMPT	UINT_MAX
> +# define SM_MASK_STATE		SM_MASK_PREEMPT
> +#else
> +# define SM_RTLOCK_WAIT		0x2
> +# define SM_MASK_PREEMPT	SM_PREEMPT
> +# define SM_MASK_STATE		(SM_PREEMPT | SM_RTLOCK_WAIT)
> +#endif

Wouldn't something like this:


#ifndef CONFIG_PREEMPT_RT
# define SM_MASK_PREEMPT        (~0U)
#else
# define SM_RTLOCK_WAIT         0x2
# define SM_MASK_PREEMPT        SM_PREEMPT
#endif

#define SM_MASK_STATE          (~0U)

Be even better?
