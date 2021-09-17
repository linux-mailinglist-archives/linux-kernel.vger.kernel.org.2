Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1AC40FFB1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 21:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241157AbhIQTSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 15:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhIQTSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 15:18:12 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FF8C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 12:16:49 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id d11so7468621ilc.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 12:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0utUDHU5p18JMyukMfxcGrVkMwkedcIXc7VizY5R+P8=;
        b=W6l7KgDGXz2lMw4Pq3SmZRzZhi+sOvLppPrrQvcigEMP4RtEnMaBWKWGSBmHfBO3LC
         sFMYWN9TkCDCbG+M53RTNjf8/kcxMH0crDBaw2s7umnlF9bWLvJ+CQzy7B+npXaYQ0Sh
         PlTmeEXaTpa4DTUjI/bqyel6UpFNJC3MlxiS8wgzdPslzlK5FzvO6ye8fjRxMO23N5kL
         MzGq4hmppZQw9nqNHmzAE09XiSBh4AMYsKIkuZxUTGGi9vSJ09BodDje6ArBokAgyxl0
         +iL1Wkh4fq8/f7JfV6Fc5jcymST7wWHIPuCgfTpRylNpV/tLGqCVfYKETYH2UbbS0MuW
         28og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0utUDHU5p18JMyukMfxcGrVkMwkedcIXc7VizY5R+P8=;
        b=rhmvG9R0DG1Ra/hQyPe7q4s2Xj8DQ5WB5tb+YSEeFC+h8f1FWFfMBFxE1ikXvwzaf/
         POe5stPD/52nvOYFO6uWeKQ0zj7WK7y05iTMUfL6WGYlBEr+5KTiyIDB1478CUmYx+r0
         h50I5Nl/mtp5VAxD8/TK435ylE5Qt2nz5hC+2LI0KgyKSYx0SZXxNQKCrKGkyl1E/c16
         jUkPHnwIOFu2ccdHsAvYXj456dmTSaDsvIEU47ltHKRWH0BftqIVT8GmbUkn3pE+pPSI
         xCC2mmb6YaVuZBMsRXYKpbdBFyZcMzW3inPIYb0RbXrYWawQzNQ/N5jlPbI+RFGaIyWU
         5hUA==
X-Gm-Message-State: AOAM531K82BaaCJgOvaSyD1eQpFcuYySs/CXLLnrHL7/g8rmXuVnb4VF
        ZxZqu8r3q6KGsyetcT9p7tFzjlipPO2RiNyc+TaqfA==
X-Google-Smtp-Source: ABdhPJzLIBUHnD9ftwAcLNqrDK0tQV7kzf8ZkV8GyaORq4DC2PSMbOLz8sfI65gBqSyhioStYsBdCUul48YNGW+ZoQ4=
X-Received: by 2002:a92:c605:: with SMTP id p5mr8982501ilm.53.1631906208787;
 Fri, 17 Sep 2021 12:16:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210916060525.1890638-1-irogers@google.com> <f7bbc59b-794f-2675-a044-1e3a58ad1495@huawei.com>
In-Reply-To: <f7bbc59b-794f-2675-a044-1e3a58ad1495@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 17 Sep 2021 12:16:37 -0700
Message-ID: <CAP-5=fUAxfHb8fNjpPKthztJhB7Q3yUZucLS-6kKZtq-iNOVoA@mail.gmail.com>
Subject: Re: [PATCH v2] perf test: Workload test of metric and metricgroups
To:     John Garry <john.garry@huawei.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com, Paul Clarke <pc@us.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021 at 12:37 AM John Garry <john.garry@huawei.com> wrote:
>
> On 16/09/2021 07:05, Ian Rogers wrote:
> > Test every metric and metricgroup with 'true' as a workload.
> >
> > Signed-off-by: Ian Rogers<irogers@google.com>
>
> Reviewed-by: John Garry <john.garry@huawei.com>
>
> Note that I also had a local test for pmu events:
> for e in `$PERF list --raw-dump pmu`; do
>    echo "Testing $e"
>    result=$($PERF stat -v -e "$e" perf bench internals synthesize)
>    if [[ "$result" =~ "$e" ]]; then
>      echo "Event not printed: $e"
>      exit 1
>    fi
> done
>
> Is there any value in upstreaming this? I could not see same already
> there. Or else make your new script generic, so that it accepts an
> argument whether to test events or metrics or metricgroups

It is not easy to make a generic script with the current shell test
infrastructure. I made a variant of this test:
https://lore.kernel.org/linux-perf-users/20210917184240.2181186-2-irogers@google.com/T/#u
For skylake it ran for 1m15s and so it may be too slow. Perhaps we
need to add to the test infrastructure with some kind of speed flag.

Thanks,
Ian
