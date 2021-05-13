Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0937A37FEF3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 22:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbhEMUZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 16:25:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40099 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232805AbhEMUZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 16:25:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620937465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ksER9Zeo8ZqIFysycLmXjmnFf6PSPfo6EBdkip46x2o=;
        b=dUtndAcNvtZJWKQuzzh8PPlt3akh9OrBdqzbMaoCeQPqbM518COrup1pteTsLZbbXwX0PM
        z52D/0FrZmoMhgZXH7j1QO/mt1Ijhvkhp942CsTQgggRUU0BhWIcALE4ECrGod67PTG/sC
        Eh2LGEIx3I32ATC/ml6+e29Fnr2oy24=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-502-tlK80T5dOCSi6fCs_FO1ew-1; Thu, 13 May 2021 16:24:22 -0400
X-MC-Unique: tlK80T5dOCSi6fCs_FO1ew-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB3E4803622;
        Thu, 13 May 2021 20:24:21 +0000 (UTC)
Received: from krava (unknown [10.40.192.9])
        by smtp.corp.redhat.com (Postfix) with SMTP id D98445D736;
        Thu, 13 May 2021 20:24:20 +0000 (UTC)
Date:   Thu, 13 May 2021 22:24:19 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] ftrace: Handle commands when closing set_ftrace_filter
 file
Message-ID: <YJ2K80OWCmoxy4n8@krava>
References: <20210505104818.24358ef7@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210505104818.24358ef7@gandalf.local.home>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 05, 2021 at 10:48:18AM -0400, Steven Rostedt wrote:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
>  # echo switch_mm:traceoff > /sys/kernel/tracing/set_ftrace_filter
> 
> will cause switch_mm to stop tracing by the traceoff command.
> 
>  # echo -n switch_mm:traceoff > /sys/kernel/tracing/set_ftrace_filter
> 
> does nothing.
> 
> The reason is that the parsing in the write function only processes
> commands if it finished parsing (there is white space written after the
> command). That's to handle:
> 
>  write(fd, "switch_mm:", 10);
>  write(fd, "traceoff", 8);
> 
> cases, where the command is broken over multiple writes.
> 
> The problem is if the file descriptor is closed, then the write call is
> not processed, and the command needs to be processed in the release code.
> The release code can handle matching of functions, but does not handle
> commands.
> 
> Cc: stable@vger.kernel.org
> Fixes: eda1e32855656 ("tracing: handle broken names in ftrace filter")

nice, breaking kernel since 2009.. I'll put that on t-shirt ;-)

I saw the patch got already merged, FWIW:

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  kernel/trace/ftrace.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 057e962ca5ce..c57508445faa 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -5591,7 +5591,10 @@ int ftrace_regex_release(struct inode *inode, struct file *file)
>  
>  	parser = &iter->parser;
>  	if (trace_parser_loaded(parser)) {
> -		ftrace_match_records(iter->hash, parser->buffer, parser->idx);
> +		int enable = !(iter->flags & FTRACE_ITER_NOTRACE);
> +
> +		ftrace_process_regex(iter, parser->buffer,
> +				     parser->idx, enable);
>  	}
>  
>  	trace_parser_put(parser);
> -- 
> 2.29.2
> 

