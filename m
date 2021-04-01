Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDB1F351D97
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240251AbhDAS3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:29:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27477 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234925AbhDASHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:07:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617300433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mHI3kK2l6R6bQkNsYRKDg5GNKOb/0mlH0MNoRlrgvFY=;
        b=HnzGmHoHVe2IVLfCQ5l3llEu7VeHKIGZoSRbzWVhPA+iJHfp1TF3vJyyHnBWoGTOGOZz4D
        1wJ2CqmyQS1RINgUXiKxoBoTthTZf7ATgxb5u51RzI6YXVMXA99ANWNTlOHjVNuBFIwcTZ
        tDO2y+muFKt6ZDtXv9vGEW4CdOCbyDI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-503-lqWGGEMbOT-RQvZJrvyUbQ-1; Thu, 01 Apr 2021 10:05:31 -0400
X-MC-Unique: lqWGGEMbOT-RQvZJrvyUbQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB0AD81633;
        Thu,  1 Apr 2021 14:05:14 +0000 (UTC)
Received: from krava (unknown [10.40.193.98])
        by smtp.corp.redhat.com (Postfix) with SMTP id 15F917217B;
        Thu,  1 Apr 2021 14:05:13 +0000 (UTC)
Date:   Thu, 1 Apr 2021 16:05:13 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf inject: Fix repipe usage
Message-ID: <YGXTGQwbz0wOWplZ@krava>
References: <20210401103605.9000-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401103605.9000-1-adrian.hunter@intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 01:36:05PM +0300, Adrian Hunter wrote:
> Since commit 14d3d5405253 ("perf session: Try to read pipe data from file")
> perf inject has started printing "PERFILE2h" when not processing pipes.
> 
> The commit exposed perf to the possiblity that the input is not a pipe but
> the 'repipe' parameter gets used. That causes the printing because perf
> inject sets 'repipe' to true always.
> 
> The 'repipe' parameter of perf_session__new() is used by 2 functions:
> 	- perf_file_header__read_pipe()
> 	- trace_report()
> In both cases, the functions copy data to STDOUT_FILENO when 'repipe' is
> true.
> 
> Fix by setting 'repipe' to true only if the output is a pipe.
> 
> Fixes: e558a5bd8b74 ("perf inject: Work with files")
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
>  tools/perf/builtin-inject.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index 6fe44d97fde5..ddccc0eb7390 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -906,7 +906,7 @@ int cmd_inject(int argc, const char **argv)
>  	}
>  
>  	data.path = inject.input_name;
> -	inject.session = perf_session__new(&data, true, &inject.tool);
> +	inject.session = perf_session__new(&data, inject.output.is_pipe, &inject.tool);
>  	if (IS_ERR(inject.session))
>  		return PTR_ERR(inject.session);
>  
> -- 
> 2.17.1
> 

