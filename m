Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C23E446BF2
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Nov 2021 02:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbhKFBoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 21:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbhKFBnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 21:43:22 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E343C061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 18:40:32 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id f4so38677827edx.12
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 18:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QW28q31zTKGihmikqeRTg40iyRXMpJFUAKZOr0xTvEk=;
        b=cjxeBR5gfQ+qvEXqvOVXm4mfPcpzJzD+nJgPwXP7WD9DMQvT9+WETTO+UGgjlke/6O
         xvVmMBNNlJErrtIjgdz+QS/V9uuZjk873rKsfC9g6LUIWQbmbjZ3uXfr25VYRi44tAGG
         EgH4jsOwoHVZoI7CHLSWSi+n7yjchIq0O+oUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QW28q31zTKGihmikqeRTg40iyRXMpJFUAKZOr0xTvEk=;
        b=vr/pdI6T0UV5cBRwj1kmIWcJ+0/bXqqHbPtFsVBIdum0SRf0EIPB4NGCGFvYzEe4JA
         65LafOA086jIgdOFeDYs4o6Mwyi6ev8u7TkXtl3khlKpTqhsaHCsiC5RpYgGC543o2eF
         GejjGfYpgGwSPNj3PoUKXg1gY2qpOuaYAKoNWaaPX9kF5gk4sKTlEDaqlEEY3Kne0/Hk
         TT+N5cecjXn6n9LuCMRydCDYgt1z34E0fjSqtU+enoAYY32/v4BvntrucBj/Y/UMX/hn
         ENwuiXhFsBbGabkOGk4P+1lv5vqSdoVXsxmIc+46AkASNKvCF8yVBgVSok7Qg1Pf+QXk
         lO+g==
X-Gm-Message-State: AOAM532wDKJEW+8i+OL8rzzEtgcSwbmWUa1usMSjLre3znq7MVm6Fc81
        ZSbgfKKdt4gVdgcr15o2dg9H/9hwx8LnUjDAdJS4Ll4OO6o=
X-Google-Smtp-Source: ABdhPJxDcKSTNnkjA7l3gFkZdz3ftF9zMLNz/4Rtv02BW7FljeMFRPXda6TzlFIfw8MJ9utFqCNjsoOdplnTVO9D9wE=
X-Received: by 2002:a17:906:489a:: with SMTP id v26mr25840003ejq.305.1636162830366;
 Fri, 05 Nov 2021 18:40:30 -0700 (PDT)
MIME-Version: 1.0
References: <20211018134844.2627174-1-james.clark@arm.com> <20211018134844.2627174-2-james.clark@arm.com>
In-Reply-To: <20211018134844.2627174-2-james.clark@arm.com>
From:   Denis Nikitin <denik@chromium.org>
Date:   Fri, 5 Nov 2021 18:40:19 -0700
Message-ID: <CADDJ8CVnXu6HKuRqWJ+28CC6QuR-187tnSN8j7eSCb2KyKfXzA@mail.gmail.com>
Subject: Re: [PATCH 1/3] perf tools: Refactor out kernel symbol argument
 sanity checking
To:     James Clark <james.clark@arm.com>
Cc:     acme@kernel.org, linux-perf-users@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 6:48 AM James Clark <james.clark@arm.com> wrote:
>
> User supplied values for vmlinux and kallsyms are checked before
> continuing. Refactor this into a function so that it can be used
> elsewhere.
>
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  tools/perf/builtin-report.c | 13 ++-----------
>  tools/perf/util/symbol.c    | 22 ++++++++++++++++++++++
>  tools/perf/util/symbol.h    |  2 ++
>  3 files changed, 26 insertions(+), 11 deletions(-)
>
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index a0316ce910db..8167ebfe776a 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -1378,18 +1378,9 @@ int cmd_report(int argc, const char **argv)
>         if (quiet)
>                 perf_quiet_option();
>
> -       if (symbol_conf.vmlinux_name &&
> -           access(symbol_conf.vmlinux_name, R_OK)) {
> -               pr_err("Invalid file: %s\n", symbol_conf.vmlinux_name);
> -               ret = -EINVAL;
> -               goto exit;
> -       }
> -       if (symbol_conf.kallsyms_name &&
> -           access(symbol_conf.kallsyms_name, R_OK)) {
> -               pr_err("Invalid file: %s\n", symbol_conf.kallsyms_name);
> -               ret = -EINVAL;
> +       ret = symbol__validate_sym_arguments();
> +       if (ret)
>                 goto exit;
> -       }
>
>         if (report.inverted_callchain)
>                 callchain_param.order = ORDER_CALLER;
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 0fc9a5410739..8fad1f0d41cb 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -2630,3 +2630,25 @@ struct mem_info *mem_info__new(void)
>                 refcount_set(&mi->refcnt, 1);
>         return mi;
>  }
> +
> +/*
> + * Checks that user supplied symbol kernel files are accessible because
> + * the default mechanism for accessing elf files fails silently. i.e. if
> + * debug syms for a build ID aren't found perf carries on normally. When
> + * they are user supplied we should assume that the user doesn't want to
> + * silently fail.
> + */
> +int symbol__validate_sym_arguments(void)
> +{
> +       if (symbol_conf.vmlinux_name &&
> +           access(symbol_conf.vmlinux_name, R_OK)) {
> +               pr_err("Invalid file: %s\n", symbol_conf.vmlinux_name);
> +               return -EINVAL;
> +       }
> +       if (symbol_conf.kallsyms_name &&
> +           access(symbol_conf.kallsyms_name, R_OK)) {
> +               pr_err("Invalid file: %s\n", symbol_conf.kallsyms_name);
> +               return -EINVAL;
> +       }
> +       return 0;
> +}
> diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
> index 954d6a049ee2..166196686f2e 100644
> --- a/tools/perf/util/symbol.h
> +++ b/tools/perf/util/symbol.h
> @@ -286,4 +286,6 @@ static inline void __mem_info__zput(struct mem_info **mi)
>
>  #define mem_info__zput(mi) __mem_info__zput(&mi)
>
> +int symbol__validate_sym_arguments(void);
> +
>  #endif /* __PERF_SYMBOL */
> --
> 2.28.0
>

Reviewed-by: Denis Nikitin <denik@chromium.org>
