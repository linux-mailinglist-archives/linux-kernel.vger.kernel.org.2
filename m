Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7046C321EC1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 19:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbhBVSCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 13:02:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbhBVSCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 13:02:05 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9B5C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 10:01:25 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id u14so20058930wri.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 10:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=LPkzCWzgTTRB9IFbmFZQR3gPhCmhsf+1JM/o4I3eeoc=;
        b=TW5IvECR9QxqNYsQhczLzYQlb7O+/SLzwxpD2eaRgmRi3hwmivV2pdzP/Vq4G/99ER
         kcaYv//UcdunhsZ+qWK0aR7eNiqUiktMMFmVn+bm/0o6zimb/vRNhPBvQ6HIKW7mrRwI
         tdgEFrvwtfNkVfC9lp+aHPddJBsG+Dds8TgVJrXoJtniNhBOGlgPnbPK/0Cbrgw6JKW2
         KnmKDLbFGRskuaEc4jGUISKmQpEYFMnCfQXm62frf3z0BeyMsAl1RQqc+TdjloEf1aV1
         wfBOiKb9L5DEwpFiT1ahujhIneO/yFQmZzJW3WEp+Xhk35gU3NykMBriSeXrqS+W1MNm
         iJZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=LPkzCWzgTTRB9IFbmFZQR3gPhCmhsf+1JM/o4I3eeoc=;
        b=a/3Yq6aq1uWuAFq1y2cxToG3jH7j6uV9YOj/i6HWsK3lkyGfg937ES0toCa8/Vek2O
         tmY0gStugmEAQL8Mi7Fps2smxJXjuxeXgumvUZki0FkkpLuAkUKZBhn/RlgaFD6sh9dg
         MCpdgQkNwbrYnrncF8BrZDEKnh4vlXkbn/8PDVLsNCaFCZm8aqddQ1tNurVBgfW1nD9I
         vJESUIcxwB/kRRDGXagq0IW0rNJQb7x2xqZmZfSpj5Q3AfIAU5lAQWU7abTVMcenIf12
         zOtYFfrIwAHrTkM9cO9geDe485UHX1zXubz7iFt9HkKZJbsw9W0h3DjqdutqiYe8VvEG
         5fxQ==
X-Gm-Message-State: AOAM5329Z99BgYF+v6pdwWYVOOrHTk1xyRciEGR+wa8+BJh+Acg2W9Id
        N3w/E+Hmg95Op/Ksb/NGe4Dd9pivIsylkxojbla74g==
X-Google-Smtp-Source: ABdhPJxPMdKl+pluu9d52YZ94zHILBxpp8X0ZvaLBYsTXXq9OpfcJjhXhLAF3hApYKCqdTZUR3jCoalR8TxlUxCiVVw=
X-Received: by 2002:a05:6000:8f:: with SMTP id m15mr21453842wrx.376.1614016883707;
 Mon, 22 Feb 2021 10:01:23 -0800 (PST)
MIME-Version: 1.0
References: <20201120063037.3166069-1-irogers@google.com>
In-Reply-To: <20201120063037.3166069-1-irogers@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 22 Feb 2021 10:01:12 -0800
Message-ID: <CAP-5=fWStOGveisGTXejQ7ZxgBKu1Mgw4MF+k-ZXVvM4hMdQaQ@mail.gmail.com>
Subject: Re: [PATCH v2] perf docs: Add man pages to see also
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 10:30 PM Ian Rogers <irogers@google.com> wrote:
>
> Add all other man pages to the "see also" list except for
> perf-script-perl and perf-script-python that are linked to from
> perf-script.
>
> v2. Fix accidentally listing perf-top twice.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Ping. I think this might have gotten lost.

Thanks,
Ian

> ---
>  tools/perf/Documentation/perf.txt | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/tools/perf/Documentation/perf.txt b/tools/perf/Documentation/perf.txt
> index c130a3c46a90..9c330cdfa973 100644
> --- a/tools/perf/Documentation/perf.txt
> +++ b/tools/perf/Documentation/perf.txt
> @@ -76,3 +76,15 @@ SEE ALSO
>  linkperf:perf-stat[1], linkperf:perf-top[1],
>  linkperf:perf-record[1], linkperf:perf-report[1],
>  linkperf:perf-list[1]
> +
> +linkperf:perf-annotate[1],linkperf:perf-archive[1],
> +linkperf:perf-bench[1], linkperf:perf-buildid-cache[1],
> +linkperf:perf-buildid-list[1], linkperf:perf-c2c[1],
> +linkperf:perf-config[1], linkperf:perf-data[1], linkperf:perf-diff[1],
> +linkperf:perf-evlist[1], linkperf:perf-ftrace[1],
> +linkperf:perf-help[1], linkperf:perf-inject[1],
> +linkperf:perf-intel-pt[1], linkperf:perf-kallsyms[1],
> +linkperf:perf-kmem[1], linkperf:perf-kvm[1], linkperf:perf-lock[1],
> +linkperf:perf-mem[1], linkperf:perf-probe[1], linkperf:perf-sched[1],
> +linkperf:perf-script[1], linkperf:perf-test[1],
> +linkperf:perf-trace[1], linkperf:perf-version[1]
> --
> 2.29.2.454.gaff20da3a2-goog
>
