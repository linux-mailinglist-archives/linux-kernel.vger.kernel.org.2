Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 426963DC214
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 02:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235077AbhGaAlE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 30 Jul 2021 20:41:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:51124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234385AbhGaAlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 20:41:03 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5A176044F;
        Sat, 31 Jul 2021 00:40:57 +0000 (UTC)
Date:   Fri, 30 Jul 2021 20:40:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH] trace: eradicate noisy warning in trace_osnoise.c
Message-ID: <20210730204050.46975ae2@oasis.local.home>
In-Reply-To: <20210731000055.28876-1-rdunlap@infradead.org>
References: <20210731000055.28876-1-rdunlap@infradead.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jul 2021 17:00:55 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> OK, I'm officially tired of this noise warning coming from
> trace_osnoise.c, so shut it up. Also, adding new warnings is not OK.

I agree adding "new warnings" is not OK, but this is a stupid warning.

> 
> ../kernel/trace/trace_osnoise.c: In function ‘start_kthread’:
> ../kernel/trace/trace_osnoise.c:1461:8: warning: ‘main’ is usually a function [-Wmain]
>   void *main = osnoise_main;
>         ^~~~
> 
> Fixes: c8895e271f79 ("trace/osnoise: Support hotplug operations")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> ---
>  kernel/trace/Makefile |    2 ++
>  1 file changed, 2 insertions(+)
> 
> --- mmotm-2021-0728-1824.orig/kernel/trace/Makefile
> +++ mmotm-2021-0728-1824/kernel/trace/Makefile
> @@ -36,6 +36,8 @@ CFLAGS_bpf_trace.o := -I$(src)
>  CFLAGS_trace_benchmark.o := -I$(src)
>  CFLAGS_trace_events_filter.o := -I$(src)
>  
> +CFLAGS_trace_osnoise.o := -Wno-main

Why just add it here. It's a silly warning to have for the kernel at
all. Should this not be added in a more global place?

-- Steve


> +
>  obj-$(CONFIG_TRACE_CLOCK) += trace_clock.o
>  
>  obj-$(CONFIG_FUNCTION_TRACER) += libftrace.o

