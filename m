Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4A1434BFB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 15:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhJTN0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 09:26:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30988 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229639AbhJTN0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 09:26:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634736264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GcpzAnNHjm23kN2uqigubTKcRaFFegqSoAGf8LIkgeI=;
        b=LYvq6Uo6SS2cSLT7123qDG9ir6RgNOIJbEOi5olTDINfWx+UF6cb70ZeA/IsiLGbS9ixuG
        TlLix5tebL4iYo4rm7PJDhh9zViRignbAKZrkPCoFf+A2nhbQEngkLr4JsruNuY3PIba6N
        dd5yQdo/zmKk8Lh1OpO5zpyjSluh4sU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499-F9ig7TfCNdmY17ROuYYXqg-1; Wed, 20 Oct 2021 09:24:23 -0400
X-MC-Unique: F9ig7TfCNdmY17ROuYYXqg-1
Received: by mail-ed1-f72.google.com with SMTP id f4-20020a50e084000000b003db585bc274so20935000edl.17
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 06:24:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GcpzAnNHjm23kN2uqigubTKcRaFFegqSoAGf8LIkgeI=;
        b=kZvvF6+uqZxC/iIxUJdzE/KynixRVVcnNw+QDfGNoApiH6k+cWzU6TZIX25LJ19mxT
         /ox2zdEzlU8MN6S0nVxjkyyJ6jHCMR17yIY+J+mHjKaMEAsXCU2LDpvg6F3qp3hLkyAz
         3elXSXi6TgjxW2bJadndZf3fojm9f19L79kVRaARlUOmvnrlydcDmrjNDHazroridU26
         weVDuaXn8e4QE0OJsB0n6jlfGLbhLSTJxCULyQDoc8Nx+9kw2FUk0My5FR/7t0pkay17
         FZNwtf8OlVy3KQinXMtKuERKyKPW5WDybxv8htulEhrkB7r7U8Wers3kBYAK3uh4Untv
         1jwA==
X-Gm-Message-State: AOAM530han5qnc7f1pI2/zp9B4o0geBJHjMOGA1cKA/PRi0QJ27joBXt
        AfTj6a1R9FFSGNNahtuTTQgO7CKtn2PpD3tqS0Lr+3PGlZclA3v6t6d0dCP1Y02hhfUH3hxuTwy
        ck1cDuhV1Ci7+avNHke2JrpMy
X-Received: by 2002:a05:6402:2805:: with SMTP id h5mr62501158ede.169.1634736262078;
        Wed, 20 Oct 2021 06:24:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzVW+LAoHPzviyKRL0KsI2xrRCoci0hduDBTl5iwSEDG3IMqePK/Z2vDw19wC+rX4UbPj8O5w==
X-Received: by 2002:a05:6402:2805:: with SMTP id h5mr62501139ede.169.1634736261861;
        Wed, 20 Oct 2021 06:24:21 -0700 (PDT)
Received: from krava ([83.240.63.48])
        by smtp.gmail.com with ESMTPSA id d4sm1205734edk.78.2021.10.20.06.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 06:24:21 -0700 (PDT)
Date:   Wed, 20 Oct 2021 15:24:19 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Lexi Shao <shaolexi@huawei.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        acme@kernel.org, mark.rutland@arm.com, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, qiuxi1@huawei.com, nixiaoming@huawei.com,
        wangbing6@huawei.com
Subject: Re: [PATCH] perf script: Show binary offsets for userspace addr
Message-ID: <YXAYg8N1vikCsOnU@krava>
References: <20211019072417.122576-1-shaolexi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019072417.122576-1-shaolexi@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2021 at 03:24:17PM +0800, Lexi Shao wrote:
> Show binary offsets for userspace addr with map in perf script output
> with callchain.
> 
> In commit 19610184693c("perf script: Show virtual addresses instead of
> offsets"), the addr shown in perf script output with callchain is changed
> from binary offsets to virtual address to fix the incorrectness when
> displaying symbol offset.
> 
> This is inconvenient in scenario that the binary is stripped and
> symbol cannot be resolved. If someone wants to further resolve symbols for
> specific binaries later, he would need an extra step to translate virtual
> address to binary offset with mapping information recorded in perf.data,
> which can be difficult for people not familiar with perf.
> 
> This patch modifies function sample__fprintf_callchain to print binary
> offset for userspace addr with dsos, and virtual address otherwise. It
> does not affect symbol offset calculation so symoff remains correct.
> 
> Before applying this patch:
> test  1512    78.711307:     533129 cycles:
> 	aaaae0da07f4 [unknown] (/tmp/test)
> 	aaaae0da0704 [unknown] (/tmp/test)
> 	ffffbe9f7ef4 __libc_start_main+0xe4 (/lib64/libc-2.31.so)
> 
> After this patch:
> test  1519   111.330127:     406953 cycles:
> 	7f4 [unknown] (/tmp/test)
> 	704 [unknown] (/tmp/test)
> 	20ef4 __libc_start_main+0xe4 (/lib64/libc-2.31.so)
> 
> Fixes: 19610184693c("perf script: Show virtual addresses instead of offsets")
> 
> Signed-off-by: Lexi Shao <shaolexi@huawei.com>

makes sense to me

Acked-/Tested-by Jiri Olsa <jolsa@redhat.com>

should we have a way to display these callchain detail in perf report output as well?

thanks,
jirka

> ---
>  tools/perf/util/evsel_fprintf.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/evsel_fprintf.c b/tools/perf/util/evsel_fprintf.c
> index bfedd7b23521..8c2ea8001329 100644
> --- a/tools/perf/util/evsel_fprintf.c
> +++ b/tools/perf/util/evsel_fprintf.c
> @@ -11,6 +11,7 @@
>  #include "strlist.h"
>  #include "symbol.h"
>  #include "srcline.h"
> +#include "dso.h"
>  
>  static int comma_fprintf(FILE *fp, bool *first, const char *fmt, ...)
>  {
> @@ -144,12 +145,17 @@ int sample__fprintf_callchain(struct perf_sample *sample, int left_alignment,
>  			if (print_arrow && !first)
>  				printed += fprintf(fp, " <-");
>  
> -			if (print_ip)
> -				printed += fprintf(fp, "%c%16" PRIx64, s, node->ip);
> -
>  			if (map)
>  				addr = map->map_ip(map, node->ip);
>  
> +			if (print_ip) {
> +				/* Show binary offset for userspace addr */
> +				if (map && !map->dso->kernel)
> +					printed += fprintf(fp, "%c%16" PRIx64, s, addr);
> +				else
> +					printed += fprintf(fp, "%c%16" PRIx64, s, node->ip);
> +			}
> +
>  			if (print_sym) {
>  				printed += fprintf(fp, " ");
>  				node_al.addr = addr;
> -- 
> 2.12.3
> 

