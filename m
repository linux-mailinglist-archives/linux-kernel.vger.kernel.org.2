Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA17E31B943
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 13:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbhBOM3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 07:29:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46699 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230261AbhBOMYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 07:24:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613391771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9+SnmqbEhNFjcfOI3mysTmgNqj2r4gSC7pE8Ni4es9A=;
        b=biJWGD/xmf3Ukbrsr9yifaK3ITgr0esg3vrpo+z+kqnQGOtZ4BHjV0LPw2MjRlumkqY5Ol
        1yO6eSZkVlEhp2CNSNbYWh4sfPx9DOxXVA3vjNjEClEusAd0aeqKCdFxJPc9lgN1vhNZom
        Oc6JuD+/d7Z3cq0yQkeXXdl3pJlE/7o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-WztHw_28MlShRZZLY3TeDg-1; Mon, 15 Feb 2021 07:22:50 -0500
X-MC-Unique: WztHw_28MlShRZZLY3TeDg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A6C1B1E563;
        Mon, 15 Feb 2021 12:22:47 +0000 (UTC)
Received: from krava (unknown [10.40.195.239])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7E3D660875;
        Mon, 15 Feb 2021 12:22:39 +0000 (UTC)
Date:   Mon, 15 Feb 2021 13:22:38 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jianlin Lv <Jianlin.Lv@arm.com>
Cc:     john.garry@huawei.com, will@kernel.org, mathieu.poirier@linaro.org,
        leo.yan@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        irogers@google.com, agerstmayr@redhat.com,
        kan.liang@linux.intel.com, adrian.hunter@intel.com,
        iecedge@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] perf tools: Fix arm64 build error with gcc-11
Message-ID: <YCpnji8ukXa06iBU@krava>
References: <20210213050516.1221523-1-Jianlin.Lv@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210213050516.1221523-1-Jianlin.Lv@arm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 13, 2021 at 01:05:16PM +0800, Jianlin Lv wrote:
> gcc version: 11.0.0 20210208 (experimental) (GCC)
> 
> Following build error on arm64:
> 
> .......
> In function ‘printf’,
>     inlined from ‘regs_dump__printf’ at util/session.c:1141:3,
>     inlined from ‘regs__printf’ at util/session.c:1169:2:
> /usr/include/aarch64-linux-gnu/bits/stdio2.h:107:10: \
>   error: ‘%-5s’ directive argument is null [-Werror=format-overflow=]
> 
> 107 |   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, \
>                 __va_arg_pack ());
> 
> ......
> In function ‘fprintf’,
>   inlined from ‘perf_sample__fprintf_regs.isra’ at \
>     builtin-script.c:622:14:
> /usr/include/aarch64-linux-gnu/bits/stdio2.h:100:10: \
>     error: ‘%5s’ directive argument is null [-Werror=format-overflow=]
>   100 |   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
>   101 |                         __va_arg_pack ());
> 
> cc1: all warnings being treated as errors
> .......
> 
> This patch fixes Wformat-overflow warnings. Add ternary operator,
> The statement evaluates to "Unknown" if reg_name==NULL is met.
> 
> Signed-off-by: Jianlin Lv <Jianlin.Lv@arm.com>

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
> v2: Add ternary operator to avoid similar errors in other arch.
> v3: Declared reg_name in inner block.
> ---
>  tools/perf/builtin-script.c                            | 4 +++-
>  tools/perf/util/scripting-engines/trace-event-python.c | 3 ++-
>  tools/perf/util/session.c                              | 3 ++-
>  3 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 42dad4a0f8cf..0d52dc45b1c7 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -643,7 +643,9 @@ static int perf_sample__fprintf_regs(struct regs_dump *regs, uint64_t mask,
>  
>  	for_each_set_bit(r, (unsigned long *) &mask, sizeof(mask) * 8) {
>  		u64 val = regs->regs[i++];
> -		printed += fprintf(fp, "%5s:0x%"PRIx64" ", perf_reg_name(r), val);
> +		const char *reg_name = perf_reg_name(r);
> +
> +		printed += fprintf(fp, "%5s:0x%"PRIx64" ", reg_name ?: "unknown", val);
>  	}
>  
>  	return printed;
> diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
> index c83c2c6564e0..768bdd4240f4 100644
> --- a/tools/perf/util/scripting-engines/trace-event-python.c
> +++ b/tools/perf/util/scripting-engines/trace-event-python.c
> @@ -699,10 +699,11 @@ static int regs_map(struct regs_dump *regs, uint64_t mask, char *bf, int size)
>  
>  	for_each_set_bit(r, (unsigned long *) &mask, sizeof(mask) * 8) {
>  		u64 val = regs->regs[i++];
> +		const char *reg_name = perf_reg_name(r);
>  
>  		printed += scnprintf(bf + printed, size - printed,
>  				     "%5s:0x%" PRIx64 " ",
> -				     perf_reg_name(r), val);
> +				     reg_name ?: "unknown", val);
>  	}
>  
>  	return printed;
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 25adbcce0281..2b40f1c431a3 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1138,9 +1138,10 @@ static void regs_dump__printf(u64 mask, u64 *regs)
>  
>  	for_each_set_bit(rid, (unsigned long *) &mask, sizeof(mask) * 8) {
>  		u64 val = regs[i++];
> +		const char *reg_name = perf_reg_name(rid);
>  
>  		printf(".... %-5s 0x%016" PRIx64 "\n",
> -		       perf_reg_name(rid), val);
> +		       reg_name ?: "unknown", val);
>  	}
>  }
>  
> -- 
> 2.25.1
> 

