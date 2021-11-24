Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90A2945C8FE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 16:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345300AbhKXPpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 10:45:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344935AbhKXPpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 10:45:03 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65829C061714
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 07:41:53 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id t8so2900098ilu.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 07:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rayr/Ta3skw4nHGq7Cjbx5KeQztTWRrECFJXOMRV5CU=;
        b=Uu8EOkQOmJx6uYnwHna6/f9g95Cyo+dNifA5T6ZESd4i9V0kAMuf0dcxNF4vinUkHg
         RRpHnHaTr7PYIe8Pl5hqNbWiM6mX+X7cPmY+XA/L5AmtozYBZCQNz1gSo+rFrpbnXi98
         y3vkUr51JoYQfPV2OJUiodNKclJeX20esaTIrV09nT3SwQZnhUzYoVOUKPVHMKk6+ZkA
         w+o+PBw0mPkluA+lQLx9/t+a5UdlUMFNMPXdfN8MLpnKcrK+gz7HahaQ8shsfvyXb1Tt
         enw9BSe+O8e9UducNAJsnf+lPRCFe++TWx3Ry/ErEfCnhYRYhL+RxPZ/emFCyTk6NMz2
         2/6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rayr/Ta3skw4nHGq7Cjbx5KeQztTWRrECFJXOMRV5CU=;
        b=dpgE3IYKJsqk4n4BW7McMAnn/KPMnfx84CpVWEy1c0BRuTUahKp25ULznr/4CTeuci
         a9gnrV/3ibhGcCRgCylPwv0xaAqUBZeSPIfiyCKci8mus07lEMx9UIqpynvzBXm73lYr
         Aq1scvdsZ5O2gqWNe8rYQx+B4bmoaErXN3YIw1yUYRgzlWLbqHlAgGF5xobeoYGLy0cU
         4svqUvhvwLz/AgSVG9MBbh/rNUpkHd+zfmxkS3BayrIm9yZOPLqAajWfCsGadZhj7mU4
         bZsY9c49BWIwTEbj+nBnhWrEUGz7ZAy9xOLARL7t8bMm9P0r0ow4Y+0xrTvO0nzIhkWO
         Op8w==
X-Gm-Message-State: AOAM533oNG2yke4nEh6S1ESb0CeXMxiIDBF67g48+JS/yYaQOBEOxDum
        k0Fl3OIGkYM3/bpHTSprOyLnSX2MgK0j4qtkb9cU8Q==
X-Google-Smtp-Source: ABdhPJxyNQ6t96LtxnQP7D8WfNiMYSBBHq4d3TUsQf3F1+DIaGodncIEBAmHU63X067/VNTPPOD6VyxIUsP2bO4sgi0=
X-Received: by 2002:a05:6e02:f51:: with SMTP id y17mr418208ilj.2.1637768512611;
 Wed, 24 Nov 2021 07:41:52 -0800 (PST)
MIME-Version: 1.0
References: <20211124090343.9436-1-tmricht@linux.ibm.com>
In-Reply-To: <20211124090343.9436-1-tmricht@linux.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 24 Nov 2021 07:41:40 -0800
Message-ID: <CAP-5=fXdOQUNDTXvt7GHRvu_7jyTPp_53f8_5DzDCXWCpWLtEQ@mail.gmail.com>
Subject: Re: [PATCH] tools/perf: Fix perf test 7 Simple expression parser on s390
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, svens@linux.ibm.com, gor@linux.ibm.com,
        sumanthk@linux.ibm.com, hca@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 1:04 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
>
> Commit fdf1e29b6118 ("perf expr: Add metric literals for topology.")
> fails on s390:
>  # ./perf test -Fv 7
>    ...
>  # FAILED tests/expr.c:173 #num_dies >= #num_packages
>    ---- end ----
>    Simple expression parser: FAILED!
>  #
>
> Investigating this issue leads to these functions:
>  build_cpu_topology()
>    +--> has_die_topology(void)
>         {
>            struct utsname uts;
>
>            if (uname(&uts) < 0)
>                   return false;
>            if (strncmp(uts.machine, "x86_64", 6))
>                   return false;
>            ....
>         }
>
> which always returns false on s390. The caller build_cpu_topology()
> checks has_die_topology() return value. On false the
> the struct cpu_topology::die_cpu_list is not contructed and has zero
> entries. This leads to the failing comparison: #num_dies >= #num_packages.
> s390 of course has a positive number of packages.
>
> Fix this by adding s390 architecture to support CPU die list.
>
> Output after:
>  # ./perf test -Fv 7
>   7: Simple expression parser                                        :
>   --- start ---
>   division by zero
>   syntax error
>   ---- end ----
>   Simple expression parser: Ok
>  #
> Cc: Ian Rogers <irogers@google.com>
> Fixes: fdf1e29b6118 ("perf expr: Add metric literals for topology.")
>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> ---
>  tools/perf/util/cputopo.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/cputopo.c b/tools/perf/util/cputopo.c
> index 51b429c86f98..aad7a9e6e31b 100644
> --- a/tools/perf/util/cputopo.c
> +++ b/tools/perf/util/cputopo.c
> @@ -165,7 +165,8 @@ static bool has_die_topology(void)
>         if (uname(&uts) < 0)
>                 return false;
>
> -       if (strncmp(uts.machine, "x86_64", 6))
> +       if (strncmp(uts.machine, "x86_64", 6) &&
> +           strncmp(uts.machine, "s390x", 5))
>                 return false;
>
>         scnprintf(filename, MAXPATHLEN, DIE_CPUS_FMT,
> --
> 2.31.1
>
