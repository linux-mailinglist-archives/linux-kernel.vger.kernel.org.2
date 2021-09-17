Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C60240FFB5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 21:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241893AbhIQTTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 15:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241158AbhIQTTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 15:19:33 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046EDC061757
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 12:18:11 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id v16so11427517ilg.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 12:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=otIPOBKTALgDqmbdP0BjYHgFoa0MRSeqshKC5h3969Y=;
        b=Hd+4Aiyrp4nfBdHIyKtNFxYpomaky9COpAb7rrFjoWuG4rB/wWrvTmL6TAhi7IArtC
         PC0cFHKY+VI6OpfeMlWG/3BsFRpp9WFfLanu+/ZjpuWArtPopTIbU00NbvByamDDJfvf
         hRyvOupEj5JXm1Tr20b8zVMDofKS+ifaomP6UgeueedB3XYMeC+Pq72m6a/EnsKTJ23s
         cKin76OAiwd8BBf04fFBbwlbEs4mHsKU9RTAMT/9EXQmy3atgD8I1I+c52VvGOcMinyr
         C0FnfVZMvNt74O7DqLAIpoZe4PPOadicE8I7j3QtTimUsr5qr7mFe4NSMkeX7O3uH8MX
         SaJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=otIPOBKTALgDqmbdP0BjYHgFoa0MRSeqshKC5h3969Y=;
        b=rcK0sxxtGBhBhnDnrtjeC+S9C/DwO+I1A/LrYAsXXM47Nm8v0vYBSgyVmHAd5aF8cj
         R1u31Llap7JvyaWiNsyh8my4fETZWx8xysar7L6X4J1IJVkLr1aLTnzqM6tpy1PQxZKr
         WXMXh4SEqMSki8LB+wV9QODXslhHW6CidBULgsRT0IAuAszIVrMZVrzA0N6zVQbdzqY4
         /LoZ0X/yraaW5LW4XHLiXZQEhXwZku2jafxSPc48kUNIrFIlHG11nzrsOplaLNLDzRJW
         hul7JnRAEGB4wxb9ujw7Yg0F0JSbtardF6BeXVxr0py/5wrXePmXcmXsm5fSvOe6R3sN
         yfZQ==
X-Gm-Message-State: AOAM530+tTAox0WBNa69SS/DzKxhMx0imUXBmPl/ixlAaGFGPvs8KzHF
        XduJMLZh+d0Q8KBcs9rljOc5CD+W4XlFtdRN0s/6yA==
X-Google-Smtp-Source: ABdhPJwO4lTQDkRkbVTyTpduTA26sQmiR/zfjwYcA3bV1lVvYfzxRbHv09r71vTkttCg1LhVkWw72RbaIAIZz2wEAn0=
X-Received: by 2002:a92:440c:: with SMTP id r12mr9077114ila.174.1631906290176;
 Fri, 17 Sep 2021 12:18:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210916060525.1890638-1-irogers@google.com> <20210916120434.GA4498@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
In-Reply-To: <20210916120434.GA4498@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 17 Sep 2021 12:17:58 -0700
Message-ID: <CAP-5=fV63VtSgfjVn=uSWqBq1LuFA4fBnjyFtKR+5qdg9+w9yw@mail.gmail.com>
Subject: Re: [PATCH v2] perf test: Workload test of metric and metricgroups
To:     "Paul A. Clarke" <pc@us.ibm.com>,
        John Garry <john.garry@huawei.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021 at 5:04 AM Paul A. Clarke <pc@us.ibm.com> wrote:
>
> On Wed, Sep 15, 2021 at 11:05:25PM -0700, Ian Rogers wrote:
> > Test every metric and metricgroup with 'true' as a workload.
>
> Good idea!  (However...)
>
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
> > index 000000000000..de24d374ce24
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
> > +  perf stat -M "$m" true
> > +done
> > +
> > +exit 0
>
> This always succeeds. Is that what you want?
> Maybe check the return code from "perf", at least?

The "set -e" above means that if the perf command fails then the test exits.

> > diff --git a/tools/perf/tests/shell/stat_all_metrics.sh b/tools/perf/tests/shell/stat_all_metrics.sh
> > new file mode 100755
> > index 000000000000..81b19ba27e68
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
> > +  result=$(perf stat -M "$m" true)
>
> I don't think this is doing what you want it to do, as it just captures the
> output of "true", which is always empty.
>
> > +  if [[ "$result" =~ "$m" ]]; then
>
> So this always fails to match, and you'll never fail here, either. :-)

Doh! Thanks for catching this!

> > +    echo "Metric not printed: $m"
> > +    exit 1
> > +  fi
> > +done
> > +
> > +exit 0
>
> You may want to redirect the output of the "perf" command to a temporary file,
> then grep within that.  And, you'll need to remove the file before running the
> perf command, because if it fails, it will leave any existing file untouched.

I fixed it by redirecting stderr.

Thanks!
Ian

> Thanks! :-)
>
> PC
