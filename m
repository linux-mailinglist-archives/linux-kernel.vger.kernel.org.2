Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A92594254BE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 15:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241826AbhJGNxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 09:53:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:50388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241824AbhJGNxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 09:53:11 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BBD961251;
        Thu,  7 Oct 2021 13:51:17 +0000 (UTC)
Date:   Thu, 7 Oct 2021 09:51:15 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: tracing: Create a sparse bitmask for pid filtering
Message-ID: <20211007095115.5d26c558@gandalf.local.home>
In-Reply-To: <221bc7ba-a475-1cb9-1bbe-730bb9c2d448@canonical.com>
References: <221bc7ba-a475-1cb9-1bbe-730bb9c2d448@canonical.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Oct 2021 12:26:32 +0100
Colin Ian King <colin.king@canonical.com> wrote:

> Hi,
> 
> Static analysis on linux-next with Coverity has identified two issues 
> with reads of initialized pointers in the following commit:
> 
> commit 8d6e90983ade25ec7925211ac31d9ccaf64b7edf
> Author: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Date:   Thu Sep 23 22:20:57 2021 -0400
> 
>      tracing: Create a sparse bitmask for pid filtering
> 
> The analysis is as follows:
> 
> 332 static void pid_list_refill_irq(struct irq_work *iwork)
> 333 {
> 
>     1. Condition 0 /* !!(!__builtin_types_compatible_p() && 
> !__builtin_types_compatible_p()) */, taking false branch.

What does the above mean?

> 
> 334        struct trace_pid_list *pid_list = container_of(iwork, struct 
> trace_pid_list,
> 335                                                       refill_irqwork);
> 
>     2. var_decl: Declaring variable upper without initializer.

Hmm, I think this is legit. I should have both upper and lower initialized
as NULL.

> 
> 336        union upper_chunk *upper;
> 337        union lower_chunk *lower;
> 338        union upper_chunk **upper_next = &upper;
> 339        union lower_chunk **lower_next = &lower;
> 340        int upper_count;
> 341        int lower_count;
> 342        int ucnt = 0;
> 343        int lcnt = 0;
> 344
> 345 again:
> 346        raw_spin_lock(&pid_list->lock);
> 347        upper_count = CHUNK_ALLOC - pid_list->free_upper_chunks;
> 348        lower_count = CHUNK_ALLOC - pid_list->free_lower_chunks;
> 349        raw_spin_unlock(&pid_list->lock);
> 350
> 
>     3. Condition upper_count <= 0, taking false branch.

What does the above mean?

> 
> 351        if (upper_count <= 0 && lower_count <= 0)
> 352                return;
> 353
> 
>     4. Condition upper_count-- > 0, taking true branch.
> 
> 354        while (upper_count-- > 0) {
> 355                union upper_chunk *chunk;
> 356
> 357                chunk = kzalloc(sizeof(*chunk), GFP_KERNEL);
> 
>     5. Condition !chunk, taking true branch.
> 358                if (!chunk)
>     6. Breaking from loop.
> 
> 359                        break;
> 360                *upper_next = chunk;
> 361                upper_next = &chunk->next;
> 362                ucnt++;
> 363        }
> 364
> 
>     7. Condition lower_count-- > 0, taking true branch.
> 
> 365        while (lower_count-- > 0) {
> 366                union lower_chunk *chunk;
> 367
> 368                chunk = kzalloc(sizeof(*chunk), GFP_KERNEL);
> 
>     8. Condition !chunk, taking true branch.
> 
> 369                if (!chunk)
> 
>     9. Breaking from loop.
> 
> 370                        break;
> 371                *lower_next = chunk;
> 372                lower_next = &chunk->next;
> 373                lcnt++;
> 374        }
> 375
> 376        raw_spin_lock(&pid_list->lock);
> 
>      Uninitialized pointer read (UNINIT)
>      10. uninit_use: Using uninitialized value upper.

Agreed.

> 
> 377        if (upper) {
> 378                *upper_next = pid_list->upper_list;
> 379                pid_list->upper_list = upper;
> 380                pid_list->free_upper_chunks += ucnt;
> 381        }
> 
>      Uninitialized pointer read (UNINIT)
>      11. uninit_use: Using uninitialized value lower.

Agreed.

> 
> 382        if (lower) {
> 383                *lower_next = pid_list->lower_list;
> 384                pid_list->lower_list = lower;
> 385                pid_list->free_lower_chunks += lcnt;
> 386        }
> 387        raw_spin_unlock(&pid_list->lock);
> 388
> 
> Colin

So is this just a fancy way of saying that upper and lower were
uninitialized?

-- Steve

