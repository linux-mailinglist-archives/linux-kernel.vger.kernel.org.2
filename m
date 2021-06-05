Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC89039C4CD
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 03:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbhFEBW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 21:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbhFEBW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 21:22:26 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581CCC061766
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 18:20:23 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id f22so8731237pfn.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 18:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zNT0x6qT9c2WmL4Efe+UtHpfNlz8Ce7pcTNRHMcZDWA=;
        b=FHUGhG7X+/XdkvpYPiZ+bByot4sdztlIWq1BDHB0WILWCzFgDmoRThOpXWi5Qqxydl
         dFoLyBP7yl5GAFVCiCvtkzvDZwAg71w3Yn75TuT5zbsAy8x2YIt7QdDjtCVDTVes0GWw
         JTDbakn4PmHo18zCOLMX/hvg0TUqz3pQiBUiLAyexyGKXrq3LAass2rBJ55TDNUah+K7
         kAF1Bk88jfNMGG5/N/U4abm/8PI4GNrpzi4WMNvv/yoTiWrj3sB8/SbWiAh3ps1sQsaR
         dfLDmLDFQCnZD3Ukz4Afh7eldJ4+7Y/dd0Nuy4nUipES7E1VH+xn1vU/Owyj1NbC13hm
         ATsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zNT0x6qT9c2WmL4Efe+UtHpfNlz8Ce7pcTNRHMcZDWA=;
        b=omS8qOk53aQ319Krj5OVoyRsTDaXv+4Ho3EqcVAgjX/k7yfDDzBF6xPM7IMRCvCisf
         nSW5tyyrCls7JsrM4ViRUOxgwRjYYxSMtbgz4/WWRCEQIrx10DGboEpRM4Q/NR92AOrd
         AOVOOG7HT1xcb6rDmmJhdMtq6AQdHnct7YtAQzFlZLhYGBBdQbf2IpMjC2KlZAeG72VJ
         sqD/cTPcP2k4HdDrz33V/lrRPNkGB4nHrGeXpEdI5gprsr0o9EAYSOqtWtTpnuVhnZ+2
         r9G3OicpUYdjmtyJAuQsTWF1cFcVe3bmYIEx+F8757X5NSq2g6hj7N8PeJBgXmu1pID4
         GF2w==
X-Gm-Message-State: AOAM532WpA8OXPbb1T6zuUgRp7MwYK5k6sAA/LLJmg4wXZ8pI7BUPQ8E
        W5F3xxxEm+rtPilfGcBqFH/5ejhNTLgU7Q==
X-Google-Smtp-Source: ABdhPJyXsTV/NaijDfvkl44zv5JO1yZfA8IRQ+93WmOA1mJ1beASNIdb7YKVQ2/M4va0TSF0E2uxDA==
X-Received: by 2002:a63:4547:: with SMTP id u7mr7678263pgk.250.1622856022403;
        Fri, 04 Jun 2021 18:20:22 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id 203sm2657959pfw.124.2021.06.04.18.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 18:20:21 -0700 (PDT)
Date:   Sat, 5 Jun 2021 01:20:18 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jacob Wen <jian.w.wen@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/2] tracing: Add a verifier to check string pointers for
 trace events
Message-ID: <YLrRUmwjjaozIt4K@google.com>
References: <20210226185909.100032746@goodmis.org>
 <20210226190705.871102407@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210226190705.871102407@goodmis.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Paolo

On Fri, Feb 26, 2021, Steven Rostedt wrote:
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index f5e8e39d6f57..ff08c04de6cb 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -3551,6 +3551,154 @@ static char *trace_iter_expand_format(struct trace_iterator *iter)
>  	return tmp;
>  }
>  
> +/* Returns true if the string is safe to dereference from an event */
> +static bool trace_safe_str(struct trace_iterator *iter, const char *str)
> +{
> +	unsigned long addr = (unsigned long)str;
> +	struct trace_event *trace_event;
> +	struct trace_event_call *event;
> +
> +	/* OK if part of the event data */
> +	if ((addr >= (unsigned long)iter->ent) &&
> +	    (addr < (unsigned long)iter->ent + iter->ent_size))
> +		return true;
> +
> +	/* OK if part of the temp seq buffer */
> +	if ((addr >= (unsigned long)iter->tmp_seq.buffer) &&
> +	    (addr < (unsigned long)iter->tmp_seq.buffer + PAGE_SIZE))
> +		return true;
> +
> +	/* Core rodata can not be freed */
> +	if (is_kernel_rodata(addr))
> +		return true;
> +
> +	/*
> +	 * Now this could be a module event, referencing core module
> +	 * data, which is OK.
> +	 */

Question on this: is it safe for a module to provide a string from its core data
when invoking a tracepoint that is defined and exported by a different module or
by the kernel proper?

If that behavior is safe, then this will generate false positives on those use
cases.  And AFAICT, it's not possible to fully fix the issue, at least not
without plumbing in more crud.  E.g. if the tracepoint is built into the kernel,
event->mod will be NULL and so even a hack-a-fix like walking source_list isn't
an option (I used source_list to verify the address is indeed in the invoking
module).

E.g. in KVM, all tracepoints are defined and exported by the common 'kvm' module
(which can also be built-in), and used by 'kvm' and the vendor modules,
'kvm_intel' and 'kvm_amd'.  One tracepoint in particular takes a hardcoded string
and does a direct fast assign to and from a 'const char *'.  This triggers the
WARN and displays [UNSAFE-MEMORY] because the string is in 'kvm_intel', not the
tracepoint owner.

The bug is easy to workaround in KVM by converting to the __string() machinery,
but I suspect there will be grumpy users on the horizon when a false positive
breaks a tracepoint in a different module at the worst possible time.

> +	if (!iter->ent)
> +		return false;
> +
> +	trace_event = ftrace_find_event(iter->ent->type);
> +	if (!trace_event)
> +		return false;
> +
> +	event = container_of(trace_event, struct trace_event_call, event);
> +	if (!event->mod)
> +		return false;
> +
> +	/* Would rather have rodata, but this will suffice */
> +	if (within_module_core(addr, event->mod))
> +		return true;
> +
> +	return false;
> +}
