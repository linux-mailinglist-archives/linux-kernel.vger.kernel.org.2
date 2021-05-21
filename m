Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97D9838C026
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 08:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234534AbhEUHBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 03:01:03 -0400
Received: from mail-lj1-f177.google.com ([209.85.208.177]:46839 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbhEUHBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 03:01:02 -0400
Received: by mail-lj1-f177.google.com with SMTP id e11so22677056ljn.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 23:59:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B4UFYIBQjq+rm3z/PFK+qq8p6F49QW0/iCfLedeJu7Y=;
        b=Me9YIQGPkxb7aduBTRaqDxsWM14gixawVld15ECzhh0gvBLI3akBG0uAq8rh4QEnvq
         6VPypxx2cd3sdGX8gar1e0UEmKcrf/KBDLqOHr/j5hWUaro948RNlxthlsTps+a4OT5J
         WKrKGQinkeRt8JmiLKbWMzUNHigR+15tF3IFRBQplo4gMxSfQHhY+duvit/tJ74Dh6M7
         wC1g2ei0952CGLBpsTi8tfS6MoTM6BxIPivZZnENJLe0uR5QhivV4oIl2OheGEiPFLur
         ibsNBmgHtqpgXhvqck7mIBkkux/SILXUDwVddBLucTPhR0o7FS70LoVuUMV9Ax5Gqlip
         RGng==
X-Gm-Message-State: AOAM531pvyPdAA7XyXgNCn3+NocDc7xIywfJRY6wzrhUpnWc9fXTiVLs
        PgfldteUp4nVCvA1Nw/WI9FyUQ7j9AGVEpUj+Jk=
X-Google-Smtp-Source: ABdhPJyf52Uy30dlVsp6mMrmEIMCCdmEse4ZZAt2B81CldnFo/YaZy4yAXzRb3lp02dE8eJ27HzOKriB5jW2og8Lvxo=
X-Received: by 2002:a2e:7807:: with SMTP id t7mr5516295ljc.393.1621580378772;
 Thu, 20 May 2021 23:59:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210517084604.2895-1-dzagorui@cisco.com> <20210517084604.2895-2-dzagorui@cisco.com>
In-Reply-To: <20210517084604.2895-2-dzagorui@cisco.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 20 May 2021 23:59:27 -0700
Message-ID: <CAM9d7chuLSM6PYvgUs0g9ZzuK5M5nQ0cP+4ahufNN9BOMYuqyA@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] perf tests: avoid storing an absolute path in perf binary
To:     Denys Zagorui <dzagorui@cisco.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, May 17, 2021 at 1:46 AM Denys Zagorui <dzagorui@cisco.com> wrote:
>
> python binding test uses PYTHONPATH definition to find python/perf.so
> library. This definition is an absolute path that makes perf binary
> unreproducible. This path can be found during runtime execution.
>
> Signed-off-by: Denys Zagorui <dzagorui@cisco.com>
> ---
[SNIP]
> +char *perf_exe_path(void)
> +{
> +       char *buf;
> +       char *dname;
> +
> +       buf = malloc(PATH_MAX);
> +       if (buf == NULL)
> +               return NULL;
> +
> +       buf = perf_exe(buf, PATH_MAX);
> +
> +       dname = dirname(buf);
> +
> +       free(buf);
> +       return dname;

I don't think it's safe to use dname after freeing buf.

Thanks,
Namhyung


> +}
> diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
> index 80b194ee6c7d..4b506df4e8b9 100644
> --- a/tools/perf/util/util.h
> +++ b/tools/perf/util/util.h
> @@ -49,6 +49,7 @@ void perf_set_singlethreaded(void);
>  void perf_set_multithreaded(void);
>
>  char *perf_exe(char *buf, int len);
> +char *perf_exe_path(void);
>
>  #ifndef O_CLOEXEC
>  #ifdef __sparc__
> --
> 2.26.2.Cisco
>
