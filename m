Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1E1F436A38
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 20:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbhJUSMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 14:12:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:39193 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229968AbhJUSMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 14:12:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634839834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nQPA4gIncgOjokPe31P+KOdM18jrOxjAAR2NTlE893c=;
        b=dym+yziEj76mSMXaO11+vITyaP8ARpbBOv5F/9YKCaM+IEXQXFQyy/83ibEuenKLD+eLcC
        TOQ/cs/upVCKcwkrVTLRxEFBuT/V8nEscIt2aexrWm3ngfTJAtFYTLkXdCQbQcmsm56w8M
        guZht9csQjoqxPFLaX41YVi0auJ+XIE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-jN8tV1adOnqQvEb9aPqoxQ-1; Thu, 21 Oct 2021 14:10:33 -0400
X-MC-Unique: jN8tV1adOnqQvEb9aPqoxQ-1
Received: by mail-wr1-f71.google.com with SMTP id f1-20020a5d64c1000000b001611832aefeso146692wri.17
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 11:10:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nQPA4gIncgOjokPe31P+KOdM18jrOxjAAR2NTlE893c=;
        b=hRIx9Xke53zWIxKv4LWCOFSj9vHxAWxlKooG/riCFDtI6FJInqFvx/63IUdoHOqbyH
         zyzMHOnlctEzxWn+YA35RzrQG3wbKDzoq/skYHJG2c+kYH8GLv7uejRKoXuBBGL48Du/
         B/xqU7TpvnAqTmg3G7gLu8entqV9vIl3uLUvYYxzIL2JD4Vhv8O/kGiomW6EAuMeLyO8
         CoHEfLx2UIXsKAczBrprqU+NylqjA/NyQWSIr+YBSXzs9kGcxZpCmqZKeOS5tbPiaoSC
         Jeg1e8LV5ZSSBlaXqCxqKxwFktdfL4YTtcHejYUR8tU7+eDySVGLxvSx2Jr1/Fd1Wlls
         Ji6w==
X-Gm-Message-State: AOAM532XkhXRYPDV13ZaBj4WQaiPJmxi7Iip70+Y84L7pzrXPKLTglWE
        2lMJkR95l89v4qNO62eSKyPG6iHsOKd6YilRwXvFve25C24/abqi2xXbx81gxePOTrhydstknyj
        umV+rDc+gw9DoT/nLuZSmV4sQ
X-Received: by 2002:adf:a486:: with SMTP id g6mr9149074wrb.130.1634839832078;
        Thu, 21 Oct 2021 11:10:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwI8H8YTO95qnmDxctwFhw/p3TDNeskxXydvxWBkVLZ4noeounK2x30fPUeRUwjbAebLUH5Qw==
X-Received: by 2002:adf:a486:: with SMTP id g6mr9149048wrb.130.1634839831913;
        Thu, 21 Oct 2021 11:10:31 -0700 (PDT)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id j14sm5506397wrw.12.2021.10.21.11.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 11:10:31 -0700 (PDT)
Date:   Thu, 21 Oct 2021 20:10:30 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] tracing: Fix selftest config check for function graph
 start up test
Message-ID: <YXGtFpBKHhEtAFsP@krava>
References: <20211021134357.7f48e173@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021134357.7f48e173@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2021 at 01:43:57PM -0400, Steven Rostedt wrote:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> There's a new test in trace_selftest_startup_function_graph() that
> requires the use of ftrace args being supported as well does some tricks
> with dynamic tracing. Although this code checks HAVE_DYNAMIC_FTRACE_WITH_ARGS
> it fails to check DYNAMIC_FTRACE, and the kernel fails to build due to
> that dependency.
> 
> Also only define the prototype of trace_direct_tramp() if it is used.
> 
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
> Changes since v1:
>    https://lkml.kernel.org/r/20211021123729.23be20c4@gandalf.local.home
>    - Hide trace_direct_tramp() when not used
> 
>  kernel/trace/trace_selftest.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
> index 3404a245417e..afd937a46496 100644
> --- a/kernel/trace/trace_selftest.c
> +++ b/kernel/trace/trace_selftest.c
> @@ -784,7 +784,11 @@ static struct fgraph_ops fgraph_ops __initdata  = {
>  	.retfunc		= &trace_graph_return,
>  };
>  
> +#if defined(CONFIG_DYNAMIC_FTRACE) && \
> +    defined(CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS)
> +#define TEST_DIRECT_TRAMP
>  noinline __noclone static void trace_direct_tramp(void) { }
> +#endif
>  
>  /*
>   * Pretty much the same than for the function tracer from which the selftest
> @@ -845,7 +849,7 @@ trace_selftest_startup_function_graph(struct tracer *trace,
>  		goto out;
>  	}
>  
> -#ifdef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
> +#ifdef TEST_DIRECT_TRAMP
>  	tracing_reset_online_cpus(&tr->array_buffer);
>  	set_graph_array(tr);
>  
> -- 
> 2.31.1
> 

