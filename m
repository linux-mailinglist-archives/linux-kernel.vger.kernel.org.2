Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 027BE40D310
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 08:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234492AbhIPGNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 02:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234479AbhIPGMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 02:12:54 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A05C061767
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 23:11:34 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id j18so6519005ioj.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 23:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AQCw95q3YoHWHNG+isNBxzCBm6tbi/4giVp44oxJ0wQ=;
        b=jjeDrFp8oqLZ5TSxQ02Qz+AakF8ohXZhZGHNZQS+Xxyej7/eOpmLhwnKKtb1EiUM0E
         4q2zyHnyjqjagi1NYN/JPLJnhPY85fdb3TjZbHcOrJ5+dklECsOuVvSWEYTr/NN8xyDs
         lUV0FzkicS/8UaO7ie/iClEd9kpDDWcCIIsFXnu6kWDmY4yNpq/IVFg+Nav4olhxTBt7
         FZimiE6J7Ks9w48uNTDygoIJjJsiHhs9BaHs4ZoRiAlK3jlGzBjIrX8kWcVqUp9421kk
         uvhbCjTyEMDZJJXXNYxDfH4/lq2jh6I5JwpgR5QJlzGxFTC/raNSaLGRdYLMLAUCU65Z
         yPZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AQCw95q3YoHWHNG+isNBxzCBm6tbi/4giVp44oxJ0wQ=;
        b=ngPa0wlvMKqJ3BghUkfMyVPw+DLY6rjbr32k4uqvbfJ3EHbO4KWm172/OpN614sVqq
         P5dMsmI6nyfyk1DEoHy4Emjkgig+PBa+kHqhpzDfIhs8vzjhrS8PQbanlEQXpc4a9XQx
         FslTWiUQZ2wco1YIase3rqNV8NvkjcgOx0L0/ndIDoz7EV/u3Glqn/hQnaRBrSTL4pDu
         +221Q5Gl2r+0a3BMvF5ndTKiHfgAsk6fXu7ImVSoQrS6Nz0dQKJglkzfeq1e1DhRM2LK
         wYPZcXGNwpvbz+tdnoVrOQCfCQAIGU72ZQSq5KNTUkAGViV9B134TBnQtR2cSJ3E/DjI
         +9ig==
X-Gm-Message-State: AOAM531l8poyags4K5q+uZf6AoHbssdvk9nIMVBg75PIT7hrijO5OHQN
        NMJ336cD5LViB9rJkQkJTSJfbRF6ST/HVK9sW8/+iw==
X-Google-Smtp-Source: ABdhPJwoSqUIh+SLMT9AnwCdfMFzKuShy4y1q9k7lxbe8LXAnIes50UkZz5bfdkLNk3Gpbx269ERYdp1O1E/IGzi7tw=
X-Received: by 2002:a6b:f203:: with SMTP id q3mr3066796ioh.32.1631772693486;
 Wed, 15 Sep 2021 23:11:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210819055629.1059168-1-irogers@google.com> <YS52wU9r9U/x4lkb@krava>
In-Reply-To: <YS52wU9r9U/x4lkb@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 15 Sep 2021 23:11:21 -0700
Message-ID: <CAP-5=fUf5zK-GEjzqK--6G_R=nj4qERCzo2+muQhKWwreWBCww@mail.gmail.com>
Subject: Re: [RFC PATCH] perf test: Workload test of metric and metricgroups
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2021 at 11:46 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Wed, Aug 18, 2021 at 10:56:29PM -0700, Ian Rogers wrote:
> > Test every metric and metricgroup with perf bench as a workload.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/tests/shell/stat_all_metricgroups.sh | 12 ++++++++++++
> >  tools/perf/tests/shell/stat_all_metrics.sh      | 16 ++++++++++++++++
> >  2 files changed, 28 insertions(+)
> >  create mode 100755 tools/perf/tests/shell/stat_all_metricgroups.sh
> >  create mode 100755 tools/perf/tests/shell/stat_all_metrics.sh
> >
> > diff --git a/tools/perf/tests/shell/stat_all_metricgroups.sh b/tools/perf/tests/shell/stat_all_metricgroups.sh
> > new file mode 100755
> > index 000000000000..f0b7bda17970
> > --- /dev/null
> > +++ b/tools/perf/tests/shell/stat_all_metricgroups.sh
> > @@ -0,0 +1,12 @@
> > +#!/bin/sh
> > +# perf all metricgroups test
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +set -e
> > +
> > +for m in $(perf list --raw-dump metricgroups); do
> > +  echo "Testing $m"
> > +  perf stat -M "$m" perf bench internals synthesize
> > +done
> > +
> > +exit 0
> > diff --git a/tools/perf/tests/shell/stat_all_metrics.sh b/tools/perf/tests/shell/stat_all_metrics.sh
> > new file mode 100755
> > index 000000000000..767396e81121
> > --- /dev/null
> > +++ b/tools/perf/tests/shell/stat_all_metrics.sh
> > @@ -0,0 +1,16 @@
> > +#!/bin/sh
> > +# perf all metrics test
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +set -e
> > +
> > +for m in `perf list --raw-dump metrics`; do
> > +  echo "Testing $m"
> > +  result=$(perf stat -M "$m" perf bench internals synthesize)
>
> good test, but takes forever.. running 'true' should be enough for the test?
>
> jirka

Agreed/done:
https://lore.kernel.org/linux-perf-users/20210916060525.1890638-1-irogers@google.com/T/#u
There is an issue that I see a lot of "<not counted>" for metricgroups
like this. Note, the metricgroups test is also failing on my skylake
as I hit the bug fixed in:
https://lore.kernel.org/lkml/20210819054707.1057819-1-irogers@google.com/

Thanks,
Ian


> > +  if [[ "$result" =~ "$m" ]]; then
> > +    echo "Metric not printed: $m"
> > +    exit 1
> > +  fi
> > +done
> > +
> > +exit 0
> > --
> > 2.33.0.rc1.237.g0d66db33f3-goog
> >
>
