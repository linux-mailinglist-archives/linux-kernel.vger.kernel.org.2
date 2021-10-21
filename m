Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A99DA436848
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 18:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbhJUQtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 12:49:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47372 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231784AbhJUQtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 12:49:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634834855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eXbLpT0SAS1QlThf/5pxQ+oX4dtgbzPcG5S7giajofs=;
        b=EsK9tMywlvk3oyrOL0nZhMLTTpEBza40ne8Abftm5zzP4GXvmYUC6trgvuD+zEfDNM1xyp
        +QDchB5OzJjGmLFCG0A3+FxrcAMwOnAO8RHUGEgBM/F2kjiMMCbm9l4oxNaHHO0eUYFcn8
        7Bc6hOBG1NNJpu8FW34+4HLla/V2+zs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-PDgomqu7O-2uabgLLQS9Og-1; Thu, 21 Oct 2021 12:47:33 -0400
X-MC-Unique: PDgomqu7O-2uabgLLQS9Og-1
Received: by mail-wm1-f72.google.com with SMTP id d73-20020a1c1d4c000000b00329d18a550fso129583wmd.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 09:47:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eXbLpT0SAS1QlThf/5pxQ+oX4dtgbzPcG5S7giajofs=;
        b=Lo9XAj3Ao37oDYmPXh7sC1k/3FeZRYYZUI0bzzcqwtaJ4tVnbQEpmzARUDAsMZVwk7
         Akn6Qn6uaPsA99ggqmOOgSuDCqH5LmRx8uWOaU4n9AcC+/k+SPKqH3sK0zVF1AuLuSPx
         AeQGhCC1F2bQ5rX+Hz3db74mnckUb2QGBh3E6RawG9nPc/NDd5jxLdGLt9QVu+e8DtG9
         woiLfaX5D5lHULi+7NactdhjQK51l2IcJ8YabvI/GwtqYeDp9mew0dG63JbSGk2NU9U+
         UpD1i8rNJr8IqmP41g8/M+BFI7gXtggZe414XKuMtb2BHfsJ4+UjVCZ41xxGxMP9w5BE
         g8ZQ==
X-Gm-Message-State: AOAM530AJjiGLd3guM4CH+S9Rh3PHs2zM/HmK8hOzkPMDFHztesPLQBa
        54FUa7jXsBhNU4Z5joeYzZKrdu6sJdd/HlhLhDdemsqUMXPTDcoipete5rJLnvd1QLWRZILnaaR
        eNnGhQ9HZj228N1vB6PGRFxOD
X-Received: by 2002:a05:600c:3511:: with SMTP id h17mr22159661wmq.144.1634834852664;
        Thu, 21 Oct 2021 09:47:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyD/Gb7060ZwsBHru8/J5tPFZwvI+9wy573hFBGrGlRjRqmroHBO5NMz9uRQAcA3dR73NweGg==
X-Received: by 2002:a05:600c:3511:: with SMTP id h17mr22159643wmq.144.1634834852493;
        Thu, 21 Oct 2021 09:47:32 -0700 (PDT)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id 6sm1251197wma.48.2021.10.21.09.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 09:47:32 -0700 (PDT)
Date:   Thu, 21 Oct 2021 18:47:30 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] tracing: Fix selftest config check for function graph
 start up test
Message-ID: <YXGZogzuH5cv1UnF@krava>
References: <20211021123729.23be20c4@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021123729.23be20c4@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2021 at 12:37:29PM -0400, Steven Rostedt wrote:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> There's a new test in trace_selftest_startup_function_graph() that
> requires the use of ftrace args being supported as well does some tricks
> with dynamic tracing. Although this code checks HAVE_DYNAMIC_FTRACE_WITH_ARGS
> it fails to check DYNAMIC_FTRACE, and the kernel fails to build due to
> that dependency.
> 
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

oops, I assumed id depended on CONFIG_DYNAMIC_FTRACE,
but did not check..

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
> Fixes this patch:
>    https://lore.kernel.org/all/20211008091336.33616-5-jolsa@kernel.org/
> 
>  kernel/trace/trace_selftest.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
> index 3404a245417e..3db8b80fbdca 100644
> --- a/kernel/trace/trace_selftest.c
> +++ b/kernel/trace/trace_selftest.c
> @@ -845,7 +845,8 @@ trace_selftest_startup_function_graph(struct tracer *trace,
>  		goto out;
>  	}
>  
> -#ifdef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
> +#if defined(CONFIG_DYNAMIC_FTRACE) && \
> +    defined(CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS)
>  	tracing_reset_online_cpus(&tr->array_buffer);
>  	set_graph_array(tr);
>  
> -- 
> 2.31.1
> 

