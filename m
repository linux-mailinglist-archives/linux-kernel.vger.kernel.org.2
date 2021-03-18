Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 576D233FF45
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 07:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbhCRGId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 02:08:33 -0400
Received: from mail-lf1-f43.google.com ([209.85.167.43]:41848 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbhCRGIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 02:08:02 -0400
Received: by mail-lf1-f43.google.com with SMTP id q13so2690127lfu.8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 23:08:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C4xNbPI7VR6RZK6yqecNv+3y5W8hur9pvokyakylyS0=;
        b=TI6I9RBTKqjaO0yhTEskGX52I7SKlYW3OoBDJL2dYe86979cZIGYjqUKORsMvzJhXB
         2X8x/b1wwjxOHGoMpjgz85c1NG4n32ZdoDrq463r6ThZ2iubtjwLx9EG2f5wg4ug8Fni
         Eo3bEeZXm1sxmiVivxBpAMWgqgJc/9NVCJ9ZP90t/z4YX/Sl0TurW0f2UVVWCg6d8p26
         dEFsm3mvV2IXKkGV+xrvak7YhRymCecYiDuP25fzhXe968/mmfrUstCnEs17eOnJ3F3L
         SmudCF3nfpqSbTBNa/ZwwjB6AFEHPZoeF06Z/IjdUf/SdVbeKdFVXOW+ZNOhAVuK+2tt
         VoNA==
X-Gm-Message-State: AOAM530Hy0HNvAQIucaf4Ydsty/xRWXUA4Phs6cPZNaay8HEgCnI8bpB
        bzBFvTtbYaq29RuE+25K86Sxusr/1qM6BkMBl9YNmE7P
X-Google-Smtp-Source: ABdhPJwC9q/HCvV19/xlYo3C2HajQ8Sdg2FFtdtgagv6OQ1MXkNow2TfDjN29BCoXENkcPVnIvFHkWfwfHUbTTmsVug=
X-Received: by 2002:a05:6512:6d0:: with SMTP id u16mr4272892lff.300.1616047680886;
 Wed, 17 Mar 2021 23:08:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210316211837.910506-1-songliubraving@fb.com> <20210316211837.910506-4-songliubraving@fb.com>
In-Reply-To: <20210316211837.910506-4-songliubraving@fb.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 18 Mar 2021 15:07:49 +0900
Message-ID: <CAM9d7ciqTGRx6kZ3c-+tXi3AwvOj5EG1ig4oTiUy9sDuTA=KEw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] perf-test: add a test for perf-stat --bpf-counters option
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 6:18 AM Song Liu <songliubraving@fb.com> wrote:
>
> Add a test to compare the output of perf-stat with and without option
> --bpf-counters. If the difference is more than 10%, the test is considered
> as failed.
>
> For stable results between two runs (w/ and w/o --bpf-counters), the test
> program should: 1) be long enough for better signal-noise-ratio; 2) not
> depend on the behavior of IO subsystem (for less noise from caching). So
> far, the best option we found is stressapptest.
>
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ---
>  tools/perf/tests/shell/stat_bpf_counters.sh | 34 +++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100755 tools/perf/tests/shell/stat_bpf_counters.sh
>
> diff --git a/tools/perf/tests/shell/stat_bpf_counters.sh b/tools/perf/tests/shell/stat_bpf_counters.sh
> new file mode 100755
> index 0000000000000..c0bcb38d6b53c
> --- /dev/null
> +++ b/tools/perf/tests/shell/stat_bpf_counters.sh
> @@ -0,0 +1,34 @@
> +#!/bin/sh
> +# perf stat --bpf-counters test
> +# SPDX-License-Identifier: GPL-2.0
> +
> +set -e
> +
> +# check whether $2 is within +/- 10% of $1
> +compare_number()
> +{
> +       first_num=$1
> +       second_num=$2
> +
> +       # upper bound is first_num * 110%
> +       upper=$(( $first_num + $first_num / 10 ))
> +       # lower bound is first_num * 90%
> +       lower=$(( $first_num - $first_num / 10 ))
> +
> +       if [ $second_num -gt $upper ] || [ $second_num -lt $lower ]; then
> +               echo "The difference between $first_num and $second_num are greater than 10%."
> +               exit 1
> +       fi
> +}
> +
> +# skip if --bpf-counters is not supported
> +perf stat --bpf-counters true > /dev/null 2>&1 || exit 2
> +
> +# skip if stressapptest is not available
> +stressapptest -s 1 -M 100 -m 1 > /dev/null 2>&1 || exit 2

I don't know how popular it is, but we can print some info
in case we miss it.

> +
> +base_cycles=$(perf stat --no-big-num -e cycles -- stressapptest -s 3 -M 100 -m 1 2>&1 | grep -e cycles | awk '{print $1}')
> +bpf_cycles=$(perf stat --no-big-num --bpf-counters -e cycles -- stressapptest -s 3 -M 100 -m 1 2>&1 | grep -e cycles | awk '{print $1}')

I think just awk '/cycles/ {print $1}' should work.

Thanks,
Namhyung


> +
> +compare_number $base_cycles $bpf_cycles
> +exit 0
> --
> 2.30.2
>
