Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F638346EFD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 02:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbhCXBpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 21:45:44 -0400
Received: from mail-lf1-f54.google.com ([209.85.167.54]:34716 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbhCXBpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 21:45:34 -0400
Received: by mail-lf1-f54.google.com with SMTP id i26so13667078lfl.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 18:45:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tal5jVdrjgVWMUWypFZT5HSvKaB1RMRGOJXZbG1abew=;
        b=TF2PchEcCOL2Rd7hvH8yCqatXACCZDwmZ4MqiK+22aXQC63kk9+X+KNhIIx71LZ0Cc
         xf//5vDBn9q/Jiq6vcQLGS81RPfiia7TFtQpswWt6/gLRKCOnBvL2K29xmKuQAGqJcRi
         abUidkYieZBPutd8mn7UsXEst2C5w51dG+cdzkoSvlspTjxB9sK/H27tI+XBGbLnkymj
         3KMw3zrMmrf01EpKDs+wAe4heR+YkCMj4qykLecTXKyHOnigFnR91H1lniFpX70r7IqU
         z0C0My/93HUlYrWQMs0m37tQjnJ5vYdHKpXZ1yp+dDIJizvISkABZ/iaeeMDWltnJlYK
         dc4A==
X-Gm-Message-State: AOAM532NmMFsG8wNULi3xl4JvDmOJCg+U67sXmsHveXD4kSA+30Zd8RF
        j1+qMzB1v8TuUkzakZsSEfcff0ADC92g/u9XgvI=
X-Google-Smtp-Source: ABdhPJxn1BNLQFJY4Uq1HZNHBDQwECvPAOE6+RYH9exqk77p2rStZ7XqY3xdMVWyHFOkuRcoxQW9u1y/FA9i2hEEU7s=
X-Received: by 2002:a19:430e:: with SMTP id q14mr541786lfa.374.1616550333154;
 Tue, 23 Mar 2021 18:45:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210320104554.529213-1-leo.yan@linaro.org>
In-Reply-To: <20210320104554.529213-1-leo.yan@linaro.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 24 Mar 2021 10:45:22 +0900
Message-ID: <CAM9d7ch4TQtwK_VxHuJCB=szyq8K0MurKgFjJAcNbw6dDVU8=g@mail.gmail.com>
Subject: Re: [PATCH] perf test: Change to use bash for daemon test
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

On Sat, Mar 20, 2021 at 7:46 PM Leo Yan <leo.yan@linaro.org> wrote:
>
> When executed the daemon test on Arm64 and x86 with Debian (Buster)
> distro, both skip the test case with the log:
>
>   # ./perf test -v 76
>   76: daemon operations                                               :
>   --- start ---
>   test child forked, pid 11687
>   test daemon list
>   trap: SIGINT: bad trap
>   ./tests/shell/daemon.sh: 173: local: cpu-clock: bad variable name
>   test child finished with -2
>   ---- end ----
>   daemon operations: Skip
>
> So the error happens for the variable expansion when use local variable
> in the shell script.  Since Debian Buster uses dash but not bash as
> non-interactive shell, when execute the daemon testing, it hits a
> known issue for dash which was reported [1].
>
> To resolve this issue, one option is to add double quotes for all local
> variables assignment, so need to change the code from:
>
>   local line=`perf daemon --config ${config} -x: | head -2 | tail -1`
>
>   ... to:
>
>   local line="`perf daemon --config ${config} -x: | head -2 | tail -1`"
>
> But the testing script has bunch of local variables, this leads to big
> changes for whole script.
>
> On the other hand, the testing script asks to use the "local" feature
> which is bash-specific, so this patch explicitly uses "#!/bin/bash" to
> ensure running the script with bash.
>
> After:
>
>   # ./perf test -v 76
>   76: daemon operations                                               :
>   --- start ---
>   test child forked, pid 11329
>   test daemon list
>   test daemon reconfig
>   test daemon stop
>   test daemon signal
>   signal 12 sent to session 'test [11596]'
>   signal 12 sent to session 'test [11596]'
>   test daemon ping
>   test daemon lock
>   test child finished with 0
>   ---- end ----
>   daemon operations: Ok
>
> [1] https://bugs.launchpad.net/ubuntu/+source/dash/+bug/139097
>
> Fixes: 2291bb915b55 ("perf tests: Add daemon 'list' command test")
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/tests/shell/daemon.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/tests/shell/daemon.sh b/tools/perf/tests/shell/daemon.sh
> index ee4a30ca3f57..45fc24af5b07 100755
> --- a/tools/perf/tests/shell/daemon.sh
> +++ b/tools/perf/tests/shell/daemon.sh
> @@ -1,4 +1,4 @@
> -#!/bin/sh
> +#!/bin/bash
>  # daemon operations
>  # SPDX-License-Identifier: GPL-2.0
>
> --
> 2.25.1
>
