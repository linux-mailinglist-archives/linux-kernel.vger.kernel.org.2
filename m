Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A565A34DF58
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 05:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbhC3D3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 23:29:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:41336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231196AbhC3D3D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 23:29:03 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A6816148E;
        Tue, 30 Mar 2021 03:29:02 +0000 (UTC)
Date:   Mon, 29 Mar 2021 23:29:01 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        kael_w@yeah.net
Subject: Re: [PATCH] linux/trace_events.h: Remove duplicate struct
 declaration
Message-ID: <20210329232901.038ecb4f@gandalf.local.home>
In-Reply-To: <20210330015517.2264721-1-wanjiabing@vivo.com>
References: <20210330015517.2264721-1-wanjiabing@vivo.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Mar 2021 09:55:17 +0800
Wan Jiabing <wanjiabing@vivo.com> wrote:

> struct trace_array is declared twice. One has been declared
> at forward struct declaration. Remove the duplicate.
> And sort these forward declarations alphabetically.

Um, no that's not how we sort things.

> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>  include/linux/trace_events.h | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> index 28e7af1406f2..29ae3ec5cab9 100644
> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h
> @@ -10,11 +10,11 @@
>  #include <linux/perf_event.h>
>  #include <linux/tracepoint.h>
>  
> -struct trace_array;
>  struct array_buffer;
> -struct tracer;
> -struct dentry;
>  struct bpf_prog;
> +struct dentry;
> +struct tracer;
> +struct trace_array;

NAK to the above. If anything, we sort it by length. But the above doesn't
need to be touched.

>  
>  const char *trace_print_flags_seq(struct trace_seq *p, const char *delim,
>  				  unsigned long flags,
> @@ -404,7 +404,6 @@ trace_get_fields(struct trace_event_call *event_call)
>  	return event_call->class->get_fields(event_call);
>  }
>  
> -struct trace_array;

This part is fine.

Thanks,

-- Steve

>  struct trace_subsystem_dir;
>  
>  enum {

