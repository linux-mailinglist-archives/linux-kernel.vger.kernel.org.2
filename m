Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D580B39B19E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 06:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbhFDEvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 00:51:15 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:41721 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbhFDEvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 00:51:14 -0400
Received: by mail-wm1-f41.google.com with SMTP id l11-20020a05600c4f0bb029017a7cd488f5so4887920wmq.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 21:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iyYToxjyHDWBMk26He64DqJcKFLELq/Zhc2lpJcy5+A=;
        b=Lu4GhJWupQk27Waz6gU0a5V+Wix11i7akCS4YlcqMBdNQvoLmn2iDJd0fJ6r61YgNJ
         xW4mQYz29fufX6esjJpG6jvHr5ixcWj8AOAIEiXqUSopTG+/bui3ZZWKFoMLLQPQsGWC
         Bx66kFJxVTmQIU127WRYUUqM0vZQI+6XxINy5UHfyPZetOlc2uvoJtuDN0Vpwtk4ed6z
         eYnVbcwQx1pf87/dqL8IDuN/dHR403dI6R3fJJtUOOt6VF13RPz8v/w4rH5Qwwp7JhxY
         YbbiYFYSqNggPBPsujKlul2CqFiwguKbovh4bePJ5aRJl+0tHN80fdUxcCuXEYXSQOHS
         A4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iyYToxjyHDWBMk26He64DqJcKFLELq/Zhc2lpJcy5+A=;
        b=Maftu4aAAdBaRyaVEqgnqu6JmA/0B3XcTskE5ppWm6eZB7BN1UwgeVMyAwIMcsviuL
         wtjWC1XawDz/0q6gmRjoODIZ4ejIyFhSqPoRYtxd0MZlh1E0flkT3kkToF/yGusjts4G
         Wr5c1Z/WbssTnYvIkMkxyZvBz0rMhFUth/dce3UPfXfYoTaY+ZqqhdVoHnK62fDZXG2H
         feU69FwxEkEh35T65XdV3+lV0p3L88kWKk+U8upbJTl4xEM5vccjAntuLgGkavF1x67R
         xeree7ke9K70YAo8ZiYDVlnitLcRNFM6cc1X91raSydOeLzfDmR5tVcMHA7VICj+HFYj
         P8Ng==
X-Gm-Message-State: AOAM532rEmhmobeqtf2qwE6nNp3iN/Egom6yQTLHlC75aaH4NnCwjWm5
        D7Si48kxHHzM6MCnrK/NVPjOTtSlgtvwCnl5RH8Hbg==
X-Google-Smtp-Source: ABdhPJzSsf7nlzc1UsQytqNVQFrrJPHDL3eCavnUxY62ZzTs/ipNsYzb5EnNmJB44OUHgJivR0BnWM2yzUIMW2DXbAI=
X-Received: by 2002:a05:600c:4145:: with SMTP id h5mr1601214wmm.124.1622782091519;
 Thu, 03 Jun 2021 21:48:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210602212241.2175005-1-namhyung@kernel.org>
In-Reply-To: <20210602212241.2175005-1-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 3 Jun 2021 21:47:58 -0700
Message-ID: <CAP-5=fVUvsnuayy9pqSUY1tjk9ptw5+QMXZrAwUKLzWD5hKa8g@mail.gmail.com>
Subject: Re: [PATCH 1/3] perf stat: Check return value of asprintf() properly
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 2, 2021 at 2:22 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> It returns -1 on error, so checking with 0 would not work.
>
> Fixes: 12279429d862 ("perf stat: Uniquify hybrid event name")
> Cc: Jin Yao <yao.jin@linux.intel.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/stat-display.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index b759dfd633b4..04afd41b6067 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -564,7 +564,7 @@ static void uniquify_event_name(struct evsel *counter)
>                                        counter->name, counter->pmu_name);
>                 }
>
> -               if (ret) {
> +               if (ret > 0) {
>                         free(counter->name);
>                         counter->name = new_name;
>                 }
> --
> 2.32.0.rc0.204.g9fa02ecfa5-goog
>
