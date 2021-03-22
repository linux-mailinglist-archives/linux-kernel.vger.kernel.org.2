Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E79D344FEC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 20:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbhCVTcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 15:32:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:54500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230437AbhCVTcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 15:32:19 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DDD96199E;
        Mon, 22 Mar 2021 19:32:17 +0000 (UTC)
Date:   Mon, 22 Mar 2021 15:32:14 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] static_call: fix function type mismatch
Message-ID: <20210322153214.25d869b1@gandalf.local.home>
In-Reply-To: <20210322170711.1855115-1-arnd@kernel.org>
References: <20210322170711.1855115-1-arnd@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Mar 2021 18:06:37 +0100
Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> The __static_call_return0() function is declared to return a 'long',
> while it aliases a couple of functions that all return 'int'. When
> building with 'make W=1', gcc warns about this:
> 
> kernel/sched/core.c:5420:37: error: cast between incompatible function types from 'long int (*)(void)' to 'int (*)(void)' [-Werror=cast-function-type]
>  5420 |   static_call_update(might_resched, (typeof(&__cond_resched)) __static_call_return0);
> 
> Change the function to return 'int' as well, but remove the cast to
> ensure we get a warning if any of the types ever change.

I think the answer is the other way around. That is, to make the functions
it references return long instead. __static_call_return0 is part of the
dynamic call infrastructure. Perhaps it is currently only used by functions
that return int, but what happens when it is used for a function that
returns a pointer?

-- Steve


> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
