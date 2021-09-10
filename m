Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85336406C71
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 14:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233693AbhIJMqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 08:46:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38424 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233683AbhIJMqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 08:46:43 -0400
Date:   Fri, 10 Sep 2021 14:45:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631277931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kYe9djVH32oIH1dMg/4UjSUuB4tMkZH3lMYm37JAmKk=;
        b=w+k4dlfOOv7gn5eutCAba/foctsxreNZ4ry2tb6w4PXPlKcgSDM8Ceq3VK8NSCyGDYibiw
        C06iw+7yUoIV/VAxyQ9ZwJ16BO+yK4vGK7yNUtuMZXv68GgvvdnllhWxWRfU1spWVvEDRK
        DMCwo0fJTQ+LIRdz9QmnFkWNegRvEVcFZoHhsIaw6xAtF2Kneu8BRrqRx+akpdcU3yLrl7
        LkfSJ8Ec3KcUObMDk40940jM7wkl89y23Qqdn+Gdu/8VThNJ1c58cwVGKPdPCPnUsdOBgc
        XYxDzawY7nKXlEMM7Oz+30jpvry+c9g4ahGAh5LLo5djlDCwP4rIhgNVd/sk4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631277931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kYe9djVH32oIH1dMg/4UjSUuB4tMkZH3lMYm37JAmKk=;
        b=AdsAeligySKM6SzqdjbDXCbe8QdfU3L2ILy9rWSDZPjeIoOBtuy2qnH6MlEPJT1GgufPDQ
        yuf71zaDqRumWfBw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Mike Galbraith <efault@gmx.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 1/4] sched/wakeup: Strengthen
 current_save_and_set_rtlock_wait_state()
Message-ID: <20210910124530.iezmxpzzhkbl6gwt@linutronix.de>
References: <20210909105915.757320973@infradead.org>
 <20210909110203.767330253@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210909110203.767330253@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-09-09 12:59:16 [+0200], Peter Zijlstra wrote:
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -253,22 +254,24 @@ struct task_group;
>   */
>  #define current_save_and_set_rtlock_wait_state()			\
>  	do {								\
> -		lockdep_assert_irqs_disabled();				\
> -		raw_spin_lock(&current->pi_lock);			\
> +		unsigned long flags; /* may shadow */			\
could we haz __flags so no shadow?

> +									\
> +		raw_spin_lock_irqsave(&current->pi_lock, flags);	\
>  		current->saved_state = current->__state;		\
>  		debug_rtlock_wait_set_state();				\
> -		WRITE_ONCE(current->__state, TASK_RTLOCK_WAIT);		\
> -		raw_spin_unlock(&current->pi_lock);			\
> +		smp_store_mb(current->__state, TASK_RTLOCK_WAIT);	\
> +		raw_spin_unlock_irqrestore(&current->pi_lock, flags);	\

Sebastian
