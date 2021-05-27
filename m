Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3A23932E4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 17:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235989AbhE0PyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 11:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233936AbhE0PyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 11:54:04 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8970C061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 08:52:28 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id n5-20020a1c72050000b0290192e1f9a7e1so775116wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 08:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SlgmpzlXrGPb4adzxgTzuNIO/2YBxtpJ9xpzMiqFgFw=;
        b=XSTD9340EamIS2ZjQNaRsw5UgXNY2HMxLCvLI9bdSj8Iea3fde0JEAY3wLkLsHjV1c
         /MhBeBdeS+ie68i3NmmmB53Oz4AaJ2u8DZK5oFiW7XkmgjC/izgKLAtcur7H+36HjD6h
         ppD6WJhjpSwtyft1byckOTPuzvxG8hl9BqPdrmzHZ2+jrc2rB0y5jIi9GyItDMB/bc0s
         nHuJn0f4M6+DoOk/dOESaSKoHCsmUPbhMOAtwm9sdP2gUV0DyR1o0WevT5AT7UbC3dLF
         r0GZ0VvBf/W429+f65G7U9SPXtLnFfePvoB84Ebn7szU9lrU9K0tmm81tN5Xx71jcxuV
         NEUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SlgmpzlXrGPb4adzxgTzuNIO/2YBxtpJ9xpzMiqFgFw=;
        b=KOJjYw3VQKZ+QwjzISm7YLee2JCab4nzEAoUNYAUAltaeIZsF7Bm9m295bQFJvioVI
         vNhiM1UOtc/3yLtZ51T/iNpflccizoaibT4uYOUHICiWFKCc6tA9kosTuoMyafc2JC8w
         LkWO1JBPnsb5RUAjNw8hxKKquAcd2ruH9xzYNx+/9WnqHpUmSyTE52hGkfMhH5oGGAD7
         P/QvvDDs/R5OoLZiw8Bpn3JhbWiHeF2FVVEIQUYAb5XHH5ejFVEDQO/ueL9WLHCkdUWB
         SrbXCL1LPlztkrQfoDOFQV85n+DALR+PmU4T+oaIOVu9Gqz/Knx5i05FmDkZWe18Nnqe
         N9VQ==
X-Gm-Message-State: AOAM530AHS9cxqoj4APk/oljEGr1pcYoTdUKRUATur8hciyNYHOSKqQL
        j22HhPOEVbvLW4yFm9j+M0W9m0vSNGl7zqvwGImxRw==
X-Google-Smtp-Source: ABdhPJxecOp9yIEugWSR4DBipzJE9LPuNgsMpZ5JckoAPWek0qsw0htS6vxLt0+yoDyAJ+GoVqLA/y/ieSQqQxx2VL8=
X-Received: by 2002:a05:600c:414a:: with SMTP id h10mr1416201wmm.77.1622130747362;
 Thu, 27 May 2021 08:52:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210519151213.2643570-1-irogers@google.com>
In-Reply-To: <20210519151213.2643570-1-irogers@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 27 May 2021 08:52:14 -0700
Message-ID: <CAP-5=fXpibzr2Vdzy4RHPVzQbSAOLimpHeuVY_L_YsXDy-2_1Q@mail.gmail.com>
Subject: Re: [PATCH] perf test: Test 2 libpfm4 error cases
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>
Cc:     Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 8:12 AM Ian Rogers <irogers@google.com> wrote:
>
> Proposed in:
> https://lore.kernel.org/lkml/20210517140931.2559364-1-tmricht@linux.ibm.com/
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Ping.

Thanks!
Ian

> ---
>  tools/perf/tests/pfm.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/tools/perf/tests/pfm.c b/tools/perf/tests/pfm.c
> index d4b0ef74defc..acd50944f6af 100644
> --- a/tools/perf/tests/pfm.c
> +++ b/tools/perf/tests/pfm.c
> @@ -155,6 +155,16 @@ static int test__pfm_group(void)
>                         .nr_events = 3,
>                         .nr_groups = 1,
>                 },
> +               {
> +                       .events = "instructions}",
> +                       .nr_events = 1,
> +                       .nr_groups = 0,
> +               },
> +               {
> +                       .events = "{{instructions}}",
> +                       .nr_events = 0,
> +                       .nr_groups = 0,
> +               },
>         };
>
>         for (i = 0; i < ARRAY_SIZE(table); i++) {
> --
> 2.31.1.751.gd2f1c929bd-goog
>
