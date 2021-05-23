Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE8038DBC5
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 18:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbhEWQDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 12:03:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24196 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231789AbhEWQDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 12:03:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621785728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Sb7Riq90Mp7CtKiS+0Ek4OhhboD3KkV4bCprIlf8zAc=;
        b=PtgmVGwp6cuJz/6uuquBDVb/ah92iCT8tgzvF+5kBaBhmBfBvt474VyUsTjh2mq0alU0Y5
        t2EMFEld2Wkh0BNncJ/+hKwVymJOQBrnQd8qWibV1eFvHxlhg7uFXMG7SUwKmnqOizaJtH
        KmZMclq3sL2v/nwMZChyOhkZuHcmPG8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-dpspOBqpMHmjlEt0-u71jQ-1; Sun, 23 May 2021 12:02:05 -0400
X-MC-Unique: dpspOBqpMHmjlEt0-u71jQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B9493501E0;
        Sun, 23 May 2021 16:02:04 +0000 (UTC)
Received: from krava (unknown [10.40.192.56])
        by smtp.corp.redhat.com (Postfix) with SMTP id DE86E60C17;
        Sun, 23 May 2021 16:02:03 +0000 (UTC)
Date:   Sun, 23 May 2021 18:02:02 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] perf script: Find script file relative to exec path
Message-ID: <YKp8ejb3zzmk6go8@krava>
References: <20210522100151.670-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210522100151.670-1-adrian.hunter@intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 22, 2021 at 01:01:51PM +0300, Adrian Hunter wrote:

SNIP

> diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
> index 4e4aa4c97ac5..db8f24341406 100644
> --- a/tools/perf/util/scripting-engines/trace-event-python.c
> +++ b/tools/perf/util/scripting-engines/trace-event-python.c
> @@ -1876,6 +1876,7 @@ static int python_generate_script(struct tep_handle *pevent, const char *outfile
>  
>  struct scripting_ops python_scripting_ops = {
>  	.name			= "Python",
> +	.dirname		= "python",
>  	.start_script		= python_start_script,
>  	.flush_script		= python_flush_script,
>  	.stop_script		= python_stop_script,
> diff --git a/tools/perf/util/trace-event-scripting.c b/tools/perf/util/trace-event-scripting.c
> index 714581b0de65..721f38c0d5cf 100644
> --- a/tools/perf/util/trace-event-scripting.c
> +++ b/tools/perf/util/trace-event-scripting.c
> @@ -63,6 +63,7 @@ static int python_generate_script_unsupported(struct tep_handle *pevent
>  
>  struct scripting_ops python_scripting_unsupported_ops = {
>  	.name = "Python",
> +	.dirname = "python",
>  	.start_script = python_start_script_unsupported,
>  	.flush_script = flush_script_unsupported,
>  	.stop_script = stop_script_unsupported,
> @@ -126,6 +127,7 @@ static int perl_generate_script_unsupported(struct tep_handle *pevent
>  
>  struct scripting_ops perl_scripting_unsupported_ops = {
>  	.name = "Perl",
> +	.dirname = "perf",

looks like typo.. usually means that you run perf way too often ;-)

jirka

>  	.start_script = perl_start_script_unsupported,
>  	.flush_script = flush_script_unsupported,
>  	.stop_script = stop_script_unsupported,
> diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
> index 72fdf2a3577c..39fb39ed6612 100644
> --- a/tools/perf/util/trace-event.h
> +++ b/tools/perf/util/trace-event.h
> @@ -71,6 +71,7 @@ struct perf_stat_config;
>  
>  struct scripting_ops {
>  	const char *name;
> +	const char *dirname; /* For script path .../scripts/<dirname>/... */
>  	int (*start_script) (const char *script, int argc, const char **argv);
>  	int (*flush_script) (void);
>  	int (*stop_script) (void);
> -- 
> 2.17.1
> 

