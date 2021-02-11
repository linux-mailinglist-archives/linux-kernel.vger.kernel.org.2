Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4045F318732
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 10:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbhBKJga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 04:36:30 -0500
Received: from mail-qv1-f54.google.com ([209.85.219.54]:42164 "EHLO
        mail-qv1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbhBKJSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 04:18:23 -0500
Received: by mail-qv1-f54.google.com with SMTP id f18so2220400qvm.9
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 01:18:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eC2vK//PqNAjet2c5GOUIjmIPB9ZRrawgSHRPiiueec=;
        b=F4tUUS2EIgUB5grw4BjAJiu31PCzdO5M6febZgSmiPr60gyxFIEGLrUhbqxabBPEVs
         VMBOQJ/Huyy1y34l/KBo8kD6MMpyptAHGJ/ym/gcZTuZ3rhb4QdJTVvV+i89hyqqwOan
         SBILGy9hBJeYTeCY73wbQC5VNGSsPdlEqx6BOz6IE2q/DYnREdMKhoV50qqWqXOjgjKw
         rXbzgcUd+U7qlKr/WdmNX73iNcslFg8KcrhgqWH3QGDVizr0Sp7EiCWZXIa13cUKBGll
         CuukKMp1XNKrO2wNCjouTRGW1qWxaafQQeLR2TrdYkXd0LaddKuDX4VFgphKT1+vfLAF
         tmYA==
X-Gm-Message-State: AOAM5327mGRf38+MBrKodnoli0UAGG5UlQ41fFg+YvL49ZUQk8WMyimp
        aXN0AMGa5XD2FEa0SUaOaO28uMclYocqPgsKk8M=
X-Google-Smtp-Source: ABdhPJxhQoOb/Ywz15JleQb3+xrDP+r8DRASHJAOOosB87HZlcUF92/j5YnjymJckskwXnmRJJNkAWRZKU39nk7htHE=
X-Received: by 2002:a05:6214:21a5:: with SMTP id t5mr6912744qvc.20.1613035061771;
 Thu, 11 Feb 2021 01:17:41 -0800 (PST)
MIME-Version: 1.0
References: <20210210234220.2401035-1-keescook@chromium.org>
In-Reply-To: <20210210234220.2401035-1-keescook@chromium.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 11 Feb 2021 18:17:29 +0900
Message-ID: <CAM9d7cgDEeFqiZDXmQeDH-TS4SMBVFJXuZTGxg3M_9LVootMwQ@mail.gmail.com>
Subject: Re: [PATCH] perf: Replace lkml.org links with lore
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Feb 11, 2021 at 8:42 AM Kees Cook <keescook@chromium.org> wrote:
>
> As started by commit 05a5f51ca566 ("Documentation: Replace lkml.org
> links with lore"), replace lkml.org links with lore to better use a
> single source that's more likely to stay available long-term.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/Documentation/examples.txt | 2 +-
>  tools/perf/util/data-convert-bt.c     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/Documentation/examples.txt b/tools/perf/Documentation/examples.txt
> index a4e392156488..c0d22fbe9201 100644
> --- a/tools/perf/Documentation/examples.txt
> +++ b/tools/perf/Documentation/examples.txt
> @@ -3,7 +3,7 @@
>                 ****** perf by examples ******
>                 ------------------------------
>
> -[ From an e-mail by Ingo Molnar, http://lkml.org/lkml/2009/8/4/346 ]
> +[ From an e-mail by Ingo Molnar, https://lore.kernel.org/lkml/20090804195717.GA5998@elte.hu ]
>
>
>  First, discovery/enumeration of available counters can be done via
> diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
> index 27c5fef9ad54..8b67bd97d122 100644
> --- a/tools/perf/util/data-convert-bt.c
> +++ b/tools/perf/util/data-convert-bt.c
> @@ -948,7 +948,7 @@ static char *change_name(char *name, char *orig_name, int dup)
>                 goto out;
>         /*
>          * Add '_' prefix to potential keywork.  According to
> -        * Mathieu Desnoyers (https://lkml.org/lkml/2015/1/23/652),
> +        * Mathieu Desnoyers (https://lore.kernel.org/lkml/1074266107.40857.1422045946295.JavaMail.zimbra@efficios.com),
>          * futher CTF spec updating may require us to use '$'.
>          */
>         if (dup < 0)
> --
> 2.25.1
>
