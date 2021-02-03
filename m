Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6FB330D29F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 05:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbhBCEYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 23:24:41 -0500
Received: from mail-qt1-f176.google.com ([209.85.160.176]:35399 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbhBCEXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 23:23:16 -0500
Received: by mail-qt1-f176.google.com with SMTP id t17so16726899qtq.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 20:23:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=52ElOgRD0cpaOEUcD0lTI/TyzV50oXNQCCvTWGkQQIU=;
        b=j1/7XOe6Pk7wBkdn22gwgEiOsjaW5HCVD/pYh64nlkck2eLx1MoYqhp/zmAVzvmKsu
         NHmvokjkRnCbMREkcpmk+5jmJ4QUGk7pIH23U7aOQwO9lSW+rHazEaS7BXRdHyGnNubL
         gXQuyoiO+DZfZe8qTtD9yzyeUKmNbDkFvvGl6+hQC8lxZKQ8/j/VuqWfTSGSBWQl3Gs7
         KJiHAsC6fLaWiaWGZNd2il/eidVRBnxoAQAxAJJjK1CFfNjxpboboDRP0Lm8MGKnL83N
         FiGIOBJNAwGrXkfiDKyTkf5r3Pb855OmKtUCHIpHY2kUoQ5gaW4Xp0KYjrRTR92qeK9Q
         xR3w==
X-Gm-Message-State: AOAM530rwoCv37tzloeRkW/8T5fiunFd25B8on7Qni7sQ1d239OD+S4b
        XsCube7n2P0tywL8rRql6SKmSWKGxOMdpfVyWHm1kz+K
X-Google-Smtp-Source: ABdhPJy/kw166iTQuvPURDunWO5oO9rb3qA6NgPtv5yaO4+VFD3T5p6OMPmJSnghwOARS+YrtcYd5a6kE+wiWGzvkWc=
X-Received: by 2002:ac8:46d4:: with SMTP id h20mr1067449qto.256.1612326155568;
 Tue, 02 Feb 2021 20:22:35 -0800 (PST)
MIME-Version: 1.0
References: <20210127184629.516169-1-irogers@google.com>
In-Reply-To: <20210127184629.516169-1-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 3 Feb 2021 13:22:24 +0900
Message-ID: <CAM9d7cjNLyzHbp1-g+KcgHw6X8zTKes4zN1ZPRWbY01r=rL6-w@mail.gmail.com>
Subject: Re: [PATCH] perf parse-events: Remove unnecessary #includes
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <andi@firstfloor.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

On Thu, Jan 28, 2021 at 3:46 AM Ian Rogers <irogers@google.com> wrote:
>
> Minor cleanup motivated by trying to separately fuzz test parse-events.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/util/parse-events.c | 2 --
>  tools/perf/util/parse-events.l | 1 -
>  2 files changed, 3 deletions(-)
>
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 42c84adeb2fb..8982b3c8014c 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -19,8 +19,6 @@
>  #include <subcmd/exec-cmd.h>
>  #include "string2.h"
>  #include "strlist.h"
> -#include "symbol.h"
> -#include "header.h"
>  #include "bpf-loader.h"
>  #include "debug.h"
>  #include <api/fs/tracing_path.h>
> diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
> index 9db5097317f4..03d2ac04edb3 100644
> --- a/tools/perf/util/parse-events.l
> +++ b/tools/perf/util/parse-events.l
> @@ -12,7 +12,6 @@
>  #include <sys/types.h>
>  #include <sys/stat.h>
>  #include <unistd.h>
> -#include "../perf.h"
>  #include "parse-events.h"
>  #include "parse-events-bison.h"
>  #include "evsel.h"
> --
> 2.30.0.280.ga3ce27912f-goog
>
