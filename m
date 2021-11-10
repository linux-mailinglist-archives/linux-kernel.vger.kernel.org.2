Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5A4C44C2D8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 15:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbhKJOWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 09:22:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbhKJOWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 09:22:04 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF31FC061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 06:19:16 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id x10so2936886ioj.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 06:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5bmUaTCF2qLSg7ziczsp09lQo1mJ0Y9pmNeg19CT4Yw=;
        b=ZSjVs0sAvuBejGbyo7CVzmmfZG3HPVIFy4irXXgxxutR3mBRpEXuX/aWiGYD1KutCM
         yNcN+wAL9exuISHx3DMVJfGd6hphgfZc5EuLLnzzpdQ2aLNKmtcMhf0ywr1SZb39tUvF
         voAPbQun5qxCrbWrnXSczoLgrHvea//CdCS3Wp1tcYrBB558vkaYenlESEgMH/pT9uPh
         HPaQHfYcTFiicHCjkftLeKwYOm67XDy4tHzMIWnGYQpa4xw4ncMeoiqCqqReZSfbfF2T
         8nrhokFCVC8bz4i/lBa+1q9dfSFGza++L9ilsISv55YINTGUpgLjUoXHm961pnEr7FvX
         o0Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5bmUaTCF2qLSg7ziczsp09lQo1mJ0Y9pmNeg19CT4Yw=;
        b=HGlQs7ebH3+fe8HDNJ7SWT+K74v1FUas/hmXRkSwNwFgg502a2L2lHfrqEMgpcfT+g
         GUhCW+SvKf7JmbRouctqKky6VhY+Vh3m/VPCzWVi7S8o1rZMMBKF6748JQ0T+3Ps5WM5
         epFeMTuwfUR0ptdgF2CxKM58wHCghmF0LJT/zH/lPrCfMJ31JND62u/8BvL58Sz+SgbT
         cNFIljFgLH39LRUzbWukcP/s0urBAZ2XRWNROSOhVv3fljeHEaDbo5uY8zRBDEFprMWy
         4tHD2070TXVwAiBSK6B0LrAzi79xei7fk1nUT/Cx7O/PR9x7oZgIV9HA79z6vWh2oAHp
         4Aug==
X-Gm-Message-State: AOAM532bgBIWRcjYvh2WEO7R3x29TsEIaBBrtDHDzUtZ6Xn6pYOVl7IR
        SB9Kb9fYP9blu/1sjrusyZt95uwVDFFAgVNkj8F8Ag==
X-Google-Smtp-Source: ABdhPJzakf/meQ+Vsq5+VHGC9/8t3YK1D+6VDTO1yV66SzWzP9hrA9GAZZ4Q6zQ9/dQNmiBt+ikxj1HUhrhuuzphRW4=
X-Received: by 2002:a6b:4013:: with SMTP id k19mr6045094ioa.18.1636553955960;
 Wed, 10 Nov 2021 06:19:15 -0800 (PST)
MIME-Version: 1.0
References: <20211105170943.3479315-1-irogers@google.com> <20211105170943.3479315-7-irogers@google.com>
 <YYvBhfyizI+z8SAC@krava>
In-Reply-To: <YYvBhfyizI+z8SAC@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 10 Nov 2021 06:19:04 -0800
Message-ID: <CAP-5=fWRzptEG2TUALNJaVLdP2egHhyhPZ=9HuP2da68jiPPTA@mail.gmail.com>
Subject: Re: [PATCH 6/7] perf expr: Add metric literals for topology.
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Song Liu <song@kernel.org>, Wan Jiabing <wanjiabing@vivo.com>,
        Yury Norov <yury.norov@gmail.com>,
        Changbin Du <changbin.du@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 4:56 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Fri, Nov 05, 2021 at 10:09:42AM -0700, Ian Rogers wrote:
> > Allow the number of cpus, cores, dies and packages to be queried by a
> > metric expression.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/tests/expr.c | 12 +++++++++++-
> >  tools/perf/util/expr.c  | 27 +++++++++++++++++++++++++++
> >  2 files changed, 38 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
> > index 9ee2dc91c27b..0c09ccc76665 100644
> > --- a/tools/perf/tests/expr.c
> > +++ b/tools/perf/tests/expr.c
> > @@ -66,7 +66,7 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
> >  {
> >       struct expr_id_data *val_ptr;
> >       const char *p;
> > -     double val;
> > +     double val, num_cpus, num_cores, num_dies, num_packages;
> >       int ret;
> >       struct expr_parse_ctx *ctx;
> >
> > @@ -161,6 +161,16 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
> >                       NULL, ctx) == 0);
> >       TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 0);
> >
> > +     /* Test toplogy constants appear well ordered. */
> > +     expr__ctx_clear(ctx);
> > +     TEST_ASSERT_VAL("#num_cpus", expr__parse(&num_cpus, ctx, "#num_cpus") == 0);
> > +     TEST_ASSERT_VAL("#num_cores", expr__parse(&num_cores, ctx, "#num_cores") == 0);
> > +     TEST_ASSERT_VAL("#num_cpus >= #num_cores", num_cpus >= num_cores);
> > +     TEST_ASSERT_VAL("#num_dies", expr__parse(&num_dies, ctx, "#num_dies") == 0);
> > +     TEST_ASSERT_VAL("#num_cores >= #num_dies", num_cores >= num_dies);
> > +     TEST_ASSERT_VAL("#num_packages", expr__parse(&num_packages, ctx, "#num_packages") == 0);
> > +     TEST_ASSERT_VAL("#num_dies >= #num_packages", num_dies >= num_packages);
> > +
> >       expr__ctx_free(ctx);
> >
> >       return 0;
> > diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> > index 7464739c2890..15af8b8ef5e7 100644
> > --- a/tools/perf/util/expr.c
> > +++ b/tools/perf/util/expr.c
> > @@ -5,6 +5,8 @@
> >  #include <stdlib.h>
> >  #include <string.h>
> >  #include "metricgroup.h"
> > +#include "cpumap.h"
> > +#include "cputopo.h"
> >  #include "debug.h"
> >  #include "expr.h"
> >  #include "expr-bison.h"
> > @@ -375,9 +377,34 @@ double expr_id_data__value(const struct expr_id_data *data)
> >
> >  double expr__get_literal(const char *literal)
> >  {
> > +     static struct cpu_topology *topology;
> > +
> >       if (!strcmp("#smt_on", literal))
> >               return smt_on() > 0 ? 1.0 : 0.0;
> >
> > +     if (!strcmp("#num_cpus", literal))
> > +             return cpu__max_present_cpu();
> > +
> > +     /*
> > +      * Assume that topology strings are consistent, such as CPUs "0-1"
> > +      * wouldn't be listed as "0,1", and so after deduplication the number of
> > +      * these strings gives an indication of the number of packages, dies,
> > +      * etc.
> > +      */
> > +     if (!topology) {
> > +             topology = cpu_topology__new();
>
> any chance we could propagate expr_scanner_ctx in here and store topology
> to it and release it at the end? I think we have several places like this,
> so it'd be nice not to make more if it's possible ;-)

The topology here is static and so will only get computed once per
execution rather than once pre expression parse. I was worried about
the cost of recomputing the topology for something like 'perf stat -I
1000 -M ...' in which case the static will do less recomputation.

Thanks,
Ian

> thanks,
> jirka
>
> > +             if (!topology) {
> > +                     pr_err("Error creating CPU topology");
> > +                     return NAN;
> > +             }
> > +     }
> > +     if (!strcmp("#num_packages", literal))
> > +             return topology->package_cpus_lists;
> > +     if (!strcmp("#num_dies", literal))
> > +             return topology->die_cpus_lists;
> > +     if (!strcmp("#num_cores", literal))
> > +             return topology->core_cpus_lists;
> > +
> >       pr_err("Unrecognized literal '%s'", literal);
> >       return NAN;
> >  }
> > --
> > 2.34.0.rc0.344.g81b53c2807-goog
> >
>
