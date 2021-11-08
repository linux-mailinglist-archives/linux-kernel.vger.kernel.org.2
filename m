Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06D15449C00
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 19:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236200AbhKHS4J convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 8 Nov 2021 13:56:09 -0500
Received: from mail-lf1-f51.google.com ([209.85.167.51]:33624 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236093AbhKHS4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 13:56:06 -0500
Received: by mail-lf1-f51.google.com with SMTP id bu18so38590475lfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 10:53:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5vNydMfW1sXkWlVMt2KbleYyrlDrMWn1da2v8RdtY+c=;
        b=ybvyRiwPMyipRtY3Ojh4KfmxYMp6JYwtcyfeERV0ITZ9Q501eW7JF/ffpeh7C5S0Ne
         GBev+PgdsZcVeqx5qPSRwIyUuNQQQB9cVLgGYvbmnVYQi5p6FKzkWVQzSd8np9pQwBLQ
         uhGq0oevGJs4yVmJ6C0waESdsTbdMux8raIAqUOytGekPtsLoKOcpc5Q6TER8yT0ncSz
         pTqphXYEfvpwCCBADBIM7D2rMMw2KYa7CD6O7uWu2/GkeIz/eevMVWVM6YNnV2IKoeOx
         jmX87b6GFTCAEVxw5sQTUYEQ3xj7k03MdlPQLo8FwLt5C1hURJUF65roTyEL0wvEyw25
         CPDg==
X-Gm-Message-State: AOAM532uKwQJtjCKV2DFngWUR7yDAMNiEOAUWqqaVFhHIXNQTPMmc1Vc
        1tjYr9tIQt5OM/iYzzzweKWGtgOqBZADkGBLBqU=
X-Google-Smtp-Source: ABdhPJwwxE9wb7aE2dqpsI6Ki+uJOMpZzdVCNMRAN3bVsLPIgvgY0iTzWulyvkCEobicGZ55wLfvlrTp3WwfyZKvFRk=
X-Received: by 2002:a05:6512:690:: with SMTP id t16mr1276625lfe.586.1636397600493;
 Mon, 08 Nov 2021 10:53:20 -0800 (PST)
MIME-Version: 1.0
References: <20211105205847.120950-1-namhyung@kernel.org> <YYbS/UoQ9wHAc44j@kernel.org>
In-Reply-To: <YYbS/UoQ9wHAc44j@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 8 Nov 2021 10:53:09 -0800
Message-ID: <CAM9d7cjXLUpGWhBTgPjkZ5rU7r5TKUJ5v6dTOeGizhqMJXL7-Q@mail.gmail.com>
Subject: Re: [PATCH v4] perf evsel: Fix missing exclude_{host,guest} setting
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Sat, Nov 6, 2021 at 12:09 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Fri, Nov 05, 2021 at 01:58:47PM -0700, Namhyung Kim escreveu:
> > The current logic for the perf missing feature has a bug that it can
> > wrongly clear some modifiers like G or H.  Actually some PMUs don't
> > support any filtering or exclusion while others do.  But we check it
> > as a global feature.
> >
> > For example, the cycles event can have 'G' modifier to enable it only
> > in the guest mode on x86.  When you don't run any VMs it'll return 0.
> >
> >   # perf stat -a -e cycles:G sleep 1
> >
> >     Performance counter stats for 'system wide':
> >
> >                     0      cycles:G
> >
> >           1.000721670 seconds time elapsed
> >
> > But when it's used with other pmu events that don't support G modifier,
> > it'll be reset and return non-zero values.
> >
> >   # perf stat -a -e cycles:G,msr/tsc/ sleep 1
> >
> >     Performance counter stats for 'system wide':
> >
> >           538,029,960      cycles:G
> >        16,924,010,738      msr/tsc/
> >
> >           1.001815327 seconds time elapsed
> >
> > This is because of the missing feature detection logic being global.
> > Add a hashmap to set pmu-specific exclude_host/guest features.
>
> ⬢[acme@toolbox perf]$ perf test python
> 19: 'import perf' in python                                         : FAILED!
> ⬢[acme@toolbox perf]$ perf test -v python
> Couldn't bump rlimit(MEMLOCK), failures may take place when creating BPF maps, etc
> 19: 'import perf' in python                                         :
> --- start ---
> test child forked, pid 11602
> python usage test: "echo "import sys ; sys.path.append('/tmp/build/perf/python'); import perf" | '/usr/bin/python3' "
> Traceback (most recent call last):
>   File "<stdin>", line 1, in <module>
> ImportError: /tmp/build/perf/python/perf.cpython-39-x86_64-linux-gnu.so: undefined symbol: evsel__find_pmu
> test child finished with -1
> ---- end ----
> 'import perf' in python: FAILED!
> ⬢[acme@toolbox perf]$
>
> Trying to fix this now. please do a 'perf test' before submitting
> patches.

Oops, sorry about that.  Forgot to run it after the change.
I'll check it next time and thanks for the fix.

Thanks,
Namhyung
