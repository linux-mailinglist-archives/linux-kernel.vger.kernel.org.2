Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A70F33EF138
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 20:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbhHQSAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 14:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232344AbhHQSAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 14:00:41 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468E9C0613C1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 11:00:08 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id i7so28959376iow.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 11:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3EQ4mM9cWz0DrH1U8SdciDq+Tk0hQntHt9l+G76fc50=;
        b=rTA0zkQcD6+DZgwYwD8Zz+OeKIPeOFaLcbn3vpTlWGylV/imH0ebdGYT3dFylK0FEd
         9UGeSkAFbMLOzLxOou7MLygRP9j6di4dPxP3endFZS4TWTNkqSnYG5gcCx+oP/nhI1Pa
         tpaZ4Q0gzE7hOgZusTtbzi3TvK4lWH3SNCBQGcIPWnHFdVyIBz82JCFjRo14QrS2vZkZ
         vmKsZVtCJ8Q55r5aP3xZiE7tCO8OPPDHp0C6Ux4Z8x+J3wmsnnCAei4U/V2WaxiVSk78
         +7RvnxGAgsQVIrHGYarIHlnOc39fRUT+mLMGCAAboPD/nwAGPOdJYfBuHN8e3ZtiYrj/
         o6GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3EQ4mM9cWz0DrH1U8SdciDq+Tk0hQntHt9l+G76fc50=;
        b=LGR9BKPtuEinW6I4+Ixt6fLlabZkPRaCshPY2r1vyXv50JRU5IixdnttvIEiFKbydx
         zbnw0oTduLvc0p+WkcS28a5xGL3bigZASmT/1rCJuAlPm+lWJegn3FPJZw9W3CNioyQB
         wItKWwMlVH7RntBk4lJII7MM8dkM87KoEiKpp2I6wHFve/zxJsDwSnqTzTJIcTZt9Tnw
         59+RQjJG+NhzHUr8j+pDoHg06th1ySa+iR/MSu7cYiPNcPkHIqJOGO/T24S/sLcFxOHD
         TjbghvOu227Seh1C6oT/oRpY2f/gQwk4iebdyawbCgV9Gq0hjEm1gsFYjI78xhf9Fob8
         ylQw==
X-Gm-Message-State: AOAM5335tLnQ2T+d/FbGJYiDn/doRbilMCge59g1L4skWEXFdkxA7V/6
        JYEitmovWFY3+OuzRaYdCV4+6XMHf4F4vtZr+PsFtw==
X-Google-Smtp-Source: ABdhPJzxKZNXhJWeHYUXe0XMUlCUvmpDg+fBJ7uoG0zZv4hb70Ps4ntmb52BIwEMriE86EHRTPoPVdCP/HWPjGWAPtE=
X-Received: by 2002:a5e:a81a:: with SMTP id c26mr3796200ioa.15.1629223207462;
 Tue, 17 Aug 2021 11:00:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210813220754.2104922-1-cjense@google.com> <20210815144007.3e7cwiecbre2nt6y@two.firstfloor.org>
In-Reply-To: <20210815144007.3e7cwiecbre2nt6y@two.firstfloor.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 17 Aug 2021 10:59:54 -0700
Message-ID: <CAP-5=fUg=LU96ATtZ4OtJpyfe75bHwpkD+XTkoZPXVeJdPAVOQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] perf stat: Add JSON output option.
To:     Andi Kleen <andi@firstfloor.org>
Cc:     Claire Jensen <cjense@google.com>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, yao.jin@linux.intel.com, song@kernel.org,
        adrian.hunter@intel.com, kan.liang@linux.intel.com,
        james.clark@arm.com, alexander.antonov@linux.intel.com,
        changbin.du@intel.com, liuqi115@huawei.com, eranian@google.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        clairej735@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 15, 2021 at 7:40 AM Andi Kleen <andi@firstfloor.org> wrote:
>
> > CSV output example:
> >
> > 1.20,msec,task-clock:u,1204272,100.00,0.697,CPUs utilized
> > 0,,context-switches:u,1204272,100.00,0.000,/sec
> > 0,,cpu-migrations:u,1204272,100.00,0.000,/sec
> > 70,,page-faults:u,1204272,100.00,58.126,K/sec
>
> The difficult part of such changes to perf stat is that it has
> so many different output modes that all need to be tested.
> Unfortunately the unit tests in perf test are not really
> enough for it.
>
> I have an older script (attached) that tests a lot of these outputs. It just
> exercises them, you still need to check the output manually
>
> Can you check that all these modes work correctly both
> with and without json?

Hi Andi,

Completely agreed on the need to make sure output isn't broken.
Claire's changes include tests for CSV and json output:

CSV:
https://lore.kernel.org/lkml/20210813220936.2105426-1-cjense@google.com/

json:
https://lore.kernel.org/lkml/20210813220936.2105426-1-cjense@google.com/

I think we can improve the json test by making sure the json output is
parseable, which can be a follow up patch. For the CSV output, an
unfortunate aspect to Claire's test was to discover that the current
CSV output is broken with summaries enabled. Specifically, when there
are more than one "shadow stat" to display after the event the summary
column disappears for the additional shadow stats. I'll point at the
specific problems in the code as-is below as I'd like to refactor it,
but it'd be nice to land Claire's work to build upon, including the
tests.

The current stat output display code works through a large number of
"ifs" as well as through function pointers specialized to the style of
output, the complexity of this leads to the CSV summary bug. With
summaries enabled a summary column is added on the left here:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/stat-display.c?h=perf/core&id=e0a7ef2a62e4f61a751bccfc79b9e7acb51474de#n453

but then in the shadow stats a newline may get printed like:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/stat-shadow.c?h=perf/core&id=fba7c86601e2e42d7057db47bf6d45865a208b8c#n986

the CSV newline code doesn't know of the summary column:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/stat-display.c?h=perf/core&id=e0a7ef2a62e4f61a751bccfc79b9e7acb51474de#n203

which causes a row with fewer columns and the shadow stats out of place.

There is a notion in the output of a prefix:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/stat-display.c?h=perf/core&id=e0a7ef2a62e4f61a751bccfc79b9e7acb51474de#n148

but it seems to be unused.

To refactor the code I'd like the printing code to focus on computing
"stats" and "shadow stats" and calling helpers to print these. The
helpers would be specialized per output kind, much as the new_line and
print_metric function pointers currently do. To avoid the problem of
the missing column, I'd like the abstraction for the printing to be
slightly higher level - so things like, print_header, print_stat,
print_shadow_stat and then we have functions for each output kind
implementing this. These functions should be sufficiently specialized
to avoid "ifs".

In doing the refactor it is going to correct bugs like the missing
column, and so we'll need to be mindful that some small changes in
output are intentional. This brittleness points to why Claire's
addition of json output is so useful :-)

Thanks,
Ian

> -Andi
