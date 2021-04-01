Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E26EF351EA6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238890AbhDASpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:45:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:51642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237298AbhDASW7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:22:59 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57DCD6124B;
        Thu,  1 Apr 2021 13:34:45 +0000 (UTC)
Date:   Thu, 1 Apr 2021 09:34:43 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel: initialize cpumask before parsing
Message-ID: <20210401093443.019b57d2@gandalf.local.home>
In-Reply-To: <20210401055823.3929-1-penguin-kernel@I-love.SAKURA.ne.jp>
References: <20210401055823.3929-1-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  1 Apr 2021 14:58:23 +0900
Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:

> KMSAN complains that new_value at cpumask_parse_user() from
> write_irq_affinity() from irq_affinity_proc_write() is uninitialized.
> 
>   [  148.133411][ T5509] =====================================================
>   [  148.135383][ T5509] BUG: KMSAN: uninit-value in find_next_bit+0x325/0x340
>   [  148.137819][ T5509]
>   [  148.138448][ T5509] Local variable ----new_value.i@irq_affinity_proc_write created at:
>   [  148.140768][ T5509]  irq_affinity_proc_write+0xc3/0x3d0
>   [  148.142298][ T5509]  irq_affinity_proc_write+0xc3/0x3d0
>   [  148.143823][ T5509] =====================================================
> 
> Since bitmap_parse() from cpumask_parse_user() calls find_next_bit(),
> any alloc_cpumask_var() + cpumask_parse_user() sequence has possibility
> that find_next_bit() accesses uninitialized cpu mask variable. Fix this
> problem by replacing alloc_cpumask_var() with zalloc_cpumask_var().
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  kernel/irq/proc.c    | 4 ++--
>  kernel/profile.c     | 2 +-


>  kernel/trace/trace.c | 2 +-

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
