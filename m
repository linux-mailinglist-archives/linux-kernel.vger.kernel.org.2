Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85870389547
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 20:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbhESS3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 14:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbhESS3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 14:29:36 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B147C06175F;
        Wed, 19 May 2021 11:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=z+zF/bxBA7JkJ18qA7wJYanPORYmBR/rph7jhG3xj7g=; b=LNOs0jgymbRoH8nRWRQRWyldFE
        4lOuLfsR5CMJOg4ku6ooTndAfbSW8eahgf6nyfpCJ7NJA1l8hQ62dJe2OvjY1dCOC9ejRfBZlVMzu
        OaTyFg4vlJ+mutXcUN0eNlTEHj4oXs5J0g9Mv5OV78Hbbv3Dv7zb4J8X6rjNlLu5r1SQfdzMsLxzd
        2T6rwHzQLJmZK54s+h9KhcbA/PjDViqnUviFYIy2fdG2PWHXv25fwrDbNE90xJSz6tBJp6mqG0Num
        TMhDyyAbBxtW65mXQz0NKd5HaoHx74wTzlIhMEdFrhmHN5yjtDvuz1NcJGBab8IhIsC6ALUTWPKG2
        aVL3Nqqw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1ljQuy-004lT2-Iy; Wed, 19 May 2021 18:27:41 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5409D986465; Wed, 19 May 2021 20:27:39 +0200 (CEST)
Date:   Wed, 19 May 2021 20:27:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Kate Carcia <kcarcia@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Gabriele Paoloni <gabriele.paoloni@intel.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>, linux-doc@vger.kernel.org
Subject: Re: [RFC PATCH 04/16] rv/include: Add deterministic automata monitor
 definition via C macros
Message-ID: <20210519182739.GG21560@worktop.programming.kicks-ass.net>
References: <cover.1621414942.git.bristot@redhat.com>
 <1e67370a0808714325b434edfe8f84178867af47.1621414942.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e67370a0808714325b434edfe8f84178867af47.1621414942.git.bristot@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 01:36:25PM +0200, Daniel Bristot de Oliveira wrote:

> +struct da_monitor {
> +	char curr_state;
> +	bool monitoring;
> +	void *model;
> +};
> +
> +#define MAX_PID		 1024000

> +/*
> + * Functions to define, init and get a per-task monitor.
> + *
> + * XXX: Make it dynamic? make it part of the task structure?

Yes !

I'd start with maybe adding a list_head to da_monitor and embedding a
single copy into task_struct and link from there. Yes lists suck, but
how many monitors do you realistically expect to run concurrently?

> + */
> +#define DECLARE_DA_MON_INIT_PER_TASK(name, type)				\
> +										\
> +struct da_monitor da_mon_##name[MAX_PID];					\

That's ~16M of memory, which seems somewhat silly.

> +										\
> +static inline struct da_monitor *da_get_monitor_##name(pid_t pid)		\
> +{										\
> +	return &da_mon_##name[pid];						\
> +}										\
> +										\
> +void da_monitor_reset_all_##name(void)						\
> +{										\
> +	struct da_monitor *mon = da_mon_##name;					\
> +	int i;									\
> +	for (i = 0; i < MAX_PID; i++)						\
> +		da_monitor_reset_##name(&mon[i]);				\
> +}										\
> +										\
> +static void da_monitor_init_##name(void)					\
> +{										\
> +	struct da_monitor *mon = da_mon_##name;					\
> +	int i;									\
> +										\
> +	for (i = 0; i < MAX_PID; i++) {						\
> +		mon[i].curr_state = model_get_init_state_##name();		\
> +		mon[i].monitoring = 0;						\
> +		mon[i].model = model_get_model_##name();			\
> +	}									\
> +}										\
