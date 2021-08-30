Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECA583FBAFF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 19:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238010AbhH3Reb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 13:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232969AbhH3ReZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 13:34:25 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163B5C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 10:33:32 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id g9so20951145ioq.11
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 10:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ODl6HGTF2kLoet1+p2gKeAGRNfIXjy4VGuQv/r8RP2s=;
        b=bP7D5CG4K2OQAyA87jW48TLC+/vtQD5IF3xNhv9D36s7MxchtHsd3LgyEi/xtSwOmX
         vXNmbIEv/iKMI5uDhRJvseeqjc8IDIFPHluEb7E+Vn+AwZl3oooOTY4S9bn/ZSdJl+v3
         HuEuhLaCG43I13BnlrAeTso8ODH9JXMOChveBHLrKr2oxp3gLsEH+d6mzZR1i439A2Lz
         U6GcF6kWfZHGMe8N0x9YkLP2D+w/sld4mF56n7bNw0QP9tyIY5TxMKbdLd8pv/OQHa90
         tfqd7huXN5m2dHJydfL5o1CleT8/MQzPfL5zvs3K1XcJdzra04MFD1xcJ+uWwUwS3Ae4
         xMyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ODl6HGTF2kLoet1+p2gKeAGRNfIXjy4VGuQv/r8RP2s=;
        b=UjA+HweAXg/eUes2/VDQ76LPPL6EA6jKy82iZdMWE6wHRi4dlH/JBgFzI/Un7HPQt5
         ms0udPaLIR6eXrD/ARXi7qDGvrHyhGWtsw4notqc+JLgjMxheyW3p7kfFuAvYSswy3u6
         rTAHa7zNiXtzIF3VrMLCk/ryT0sJLxzly+sQmzxn5m3Q0N0ZTyWXimP+9CgvhxkJ/KCl
         sf5JkgbWvC6V76iEidw06DQjmxpuYzi9c8eUFa7dlKVfO/Kas8nTNee1YyKrTX6PqYuq
         NktvenyR0GV7Qa5hBT9vggrRmQGptU+xjDuq9PlFR+oeg7K66tHkYPf7QS7574T46eWo
         IedQ==
X-Gm-Message-State: AOAM531N+zEEPiJRJtqkM7aZhW8KxMUaGpv92H/bYGHdB0EcP7tmqm+P
        5TW6iLNWHh6SGjSXmYH5ZNGshwzXs1moi2458b+HqQ==
X-Google-Smtp-Source: ABdhPJxvwPYADrBFNY+y9a2ja7/K1Nq1a809O4z4SYmArFHMFfQxIoEZm6mA08saLVmX5FzXF3+cW941QDkOCsJbnF0=
X-Received: by 2002:a6b:fc1a:: with SMTP id r26mr19022753ioh.30.1630344811165;
 Mon, 30 Aug 2021 10:33:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210827233212.3121037-1-namhyung@kernel.org>
In-Reply-To: <20210827233212.3121037-1-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 30 Aug 2021 10:33:16 -0700
Message-ID: <CAP-5=fWLUBzsaVNvHpJBMcZY+Ms3gE7OF6i3toOBaW-rYpVFeg@mail.gmail.com>
Subject: Re: [PATCH] perf record: Fix wrong comm in system-wide mode with delay
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2021 at 4:32 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Stephane found that the name of the forked process in a system-wide
> mode is wrong when --delay option is used.  For example,
>
>   # perf record -a --delay=1000  noploop 3
>
> The noploop process will run a busy loop for 3 second.  And on an idle
> machine it should show up at the top in the perf report.  It works
> well without the --delay option.  But if I add the option, it showed
> 'perf' not 'noploop'.
>
>   # perf report -s comm -q | head -3
>       52.94%  perf
>       16.65%  swapper
>       12.04%  chrome
>
> It turned out that the dummy event didn't work at all and it missed
> COMM and MMAP events for the noploop process (and others too).  We
> should enable the dummy event immediately in system-wide mode, as the
> enable-on-exec would work only for task events.
>
> With this change,
>
>   # perf report -s comm -q | head -3
>       52.75%  noploop
>       17.03%  swapper
>       12.83%  chrome
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Reported-by: Stephane Eranian <eranian@google.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-record.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 548c1dbde6c5..acfe66e31cf0 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -910,7 +910,8 @@ static int record__open(struct record *rec)
>                  * Enable the dummy event when the process is forked for
>                  * initial_delay, immediately for system wide.
>                  */
> -               if (opts->initial_delay && !pos->immediate)
> +               if (opts->initial_delay && !pos->immediate &&
> +                   !target__has_cpu(&opts->target))
>                         pos->core.attr.enable_on_exec = 1;
>                 else
>                         pos->immediate = 1;
> --
> 2.33.0.259.gc128427fd7-goog
>
