Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC6439B138
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 06:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbhFDELE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 00:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhFDELD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 00:11:03 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E2BC061760
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 21:09:01 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id l2so7876863wrw.6
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 21:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rfFWh4ehMvZvarUEM/OEH+HgEJn9h9iDxFF2ooCD8dA=;
        b=izbJ97c5bA5kiAg0OyxG8z7Op1DZWsH9lOrD0hv8MC+iEa29K9rV1k21a4TSFqGSRN
         DLp/z/A9fClS7OxJXegKLroGrPgZTFNmtcLlGk6Vnw6BlxC9ZunDPDYFqUbLo7KVNuiw
         OLGzKA7WR6Hihl44JJSKOIT49fcKaXWLwM9TBWSI8Z/8JlbuWHczr8lrMawrYzIV81iV
         yGl5gGUmFh+nwFtLbgmevWlj6xierVLPmgVGzB6RE5hcgJ3pE59hxAkUV8BUvKQXAcxB
         3K2GXHwiy7HxYdLm757RyIYVhC/kDvv2TdWWQd836RbugR6VDfHXf6/tBU2PAA9NV+Pp
         r3Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rfFWh4ehMvZvarUEM/OEH+HgEJn9h9iDxFF2ooCD8dA=;
        b=a6rSIUDX7kW5dBdU69/gZcpmiFTQPmiynDw0QOT/s3joKT1dU9R/VXm2uLdnS/OLds
         uXH/GWfayYNVgILfqpcEdVbnC+ciwWnNY76kBjR2hO3mqVQIvHhaXvzQp33mrDYCynQh
         dK0yoykHf1Y7T1eC0Oak5twj6Og49oJOxaQv5WUvrTEy1nwCbcwi1GmmVJLsIpaziQwE
         46DrI1jAoWWiWTYfTKbzd/SowxYJCyzKFJY8EXiHUtmBqPJjgh2IIQbk3OX14cHFLL/N
         DPZ00ID51BTuoXw7BcGZ5qeaZYh6niW3OXKKCGBeRzWVNrurDHfSCjOpxgZB1rClrQ4R
         yd6w==
X-Gm-Message-State: AOAM532XRkgXmPZgnFbEs94dakjKeYdgbt9MKH4Qtv9p3fOvylt5wz45
        7ss2VtGn6gSWoZZozr1GnkFoe2DrUmVkFp0u+ZKPzQ==
X-Google-Smtp-Source: ABdhPJwCMc8OCua2a8Stp6+Juhx/T0QnU8lnOkF9ApbXBxQGf+cjfYTZ8147PX7RSpFOPdLl217ejDPQJt2rA/pO1sQ=
X-Received: by 2002:a5d:4903:: with SMTP id x3mr1481395wrq.376.1622779739764;
 Thu, 03 Jun 2021 21:08:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210602220833.285226-1-rickyman7@gmail.com>
In-Reply-To: <20210602220833.285226-1-rickyman7@gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 3 Jun 2021 21:08:46 -0700
Message-ID: <CAP-5=fVp4xGd8wxLc1eFfTUPn3Urp23RmHBha2kgiJGvfysgZg@mail.gmail.com>
Subject: Re: [PATCH] perf symbol-elf: fix memory leak: free sdt_note.args
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Fabian Hemmer <copy@copy.sh>,
        Remi Bernon <rbernon@codeweavers.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 2, 2021 at 3:12 PM Riccardo Mancini <rickyman7@gmail.com> wrote:
>
> Reported by ASan.

Did you have a reproducer for getting this to fail?

> Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/symbol-elf.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index 4c56aa8374344..a73345730ba90 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -2412,6 +2412,7 @@ int cleanup_sdt_note_list(struct list_head *sdt_notes)
>
>         list_for_each_entry_safe(pos, tmp, sdt_notes, note_list) {
>                 list_del_init(&pos->note_list);
> +               zfree(&pos->args);
>                 zfree(&pos->name);
>                 zfree(&pos->provider);
>                 free(pos);
> --
> 2.31.1
>
