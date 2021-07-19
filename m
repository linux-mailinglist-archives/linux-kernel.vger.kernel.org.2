Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1293CED95
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 22:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385788AbhGSTJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 15:09:29 -0400
Received: from mail-lj1-f169.google.com ([209.85.208.169]:40743 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385141AbhGSSsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 14:48:13 -0400
Received: by mail-lj1-f169.google.com with SMTP id e14so9442072ljo.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 12:28:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RgpzSaDoE49Hmap/02EI97v6mGPtGNERbuhikbT+WCE=;
        b=tkMj1m+Zg1H5rPDYhxXIG9q8IKM2dT0Lu0eGjSIv7TPVxVCUgEdVGqJiHR1x1CFuTb
         9mBlIy16N/7Ze3NlRbzGbCgJpW4PUHATI6dYRyK+EtRMu7jEd4ABkIgz4MtQWwaVrl2Z
         bjObi7/a8Qgx0dm7w6NQ2qwmNCK+uLeYoTbJC9Ke8oBzp/XrL1yQUstolK8EBqvOlH0O
         WBQCpZUQvhLipmlEIU/hGSdIyx/IRSbMqTvtdShlVms29CPWY7xj8+6Fb5wZi7/Bd/xb
         vdimENXLuP+5Ul1U8jfB7rH7EJvwpIgLbUEkFLsJoz6DfsXMe3FSaYYVjTCq2pmcU9bX
         h/3Q==
X-Gm-Message-State: AOAM530E9e4GKanhbVbiPgSOKwlnEd7r3R5vjDYsHWTd2M5L+GyKAUxg
        btV1SdEkRWsjil19PnMHsCk9v5VaFYTEkl0fPWM=
X-Google-Smtp-Source: ABdhPJzS5ifmvp6wZ+x9fctpOULd6GmsmTrFI4RH3JWF4qQ0ttWhkiEbPDOU1mRCC21ZwB0QOCV9AuzfjOzqD0p5aKM=
X-Received: by 2002:a2e:5c03:: with SMTP id q3mr23113003ljb.233.1626722931450;
 Mon, 19 Jul 2021 12:28:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210714003442.1111502-1-namhyung@kernel.org> <20210714003442.1111502-6-namhyung@kernel.org>
 <YPSfaEIKydevKLpi@krava>
In-Reply-To: <YPSfaEIKydevKLpi@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 19 Jul 2021 12:28:40 -0700
Message-ID: <CAM9d7ciTRRA8haOM4K_EKj019VuD-+fwxnDdokqYD9W=gHwkdg@mail.gmail.com>
Subject: Re: [PATCH 5/5] perf tools: Add pipe_test.sh to verify pipe operations
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On Sun, Jul 18, 2021 at 2:38 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Tue, Jul 13, 2021 at 05:34:42PM -0700, Namhyung Kim wrote:
>
> SNIP
>
> > diff --git a/tools/perf/tests/shell/pipe_test.sh b/tools/perf/tests/shell/pipe_test.sh
> > new file mode 100755
> > index 000000000000..b6a89c6896c3
> > --- /dev/null
> > +++ b/tools/perf/tests/shell/pipe_test.sh
> > @@ -0,0 +1,69 @@
> > +#!/bin/sh
> > +# perf pipe recording and injection test
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +# skip if there's no compiler
> > +if ! [ -x "$(command -v cc)" ]; then
> > +     echo "failed: no compiler, install gcc"
> > +     exit 2
> > +fi
> > +
> > +file=$(mktemp /tmp/test.file.XXXXXX)
> > +data=$(mktemp /tmp/perf.data.XXXXXX)
> > +
> > +cat <<EOF | cc -o ${file} -x c -
> > +#include <signal.h>
> > +#include <stdlib.h>
> > +#include <unistd.h>
> > +
> > +volatile int done;
> > +
> > +void sigalrm(int sig) {
> > +     done = 1;
> > +}
> > +
> > +__attribute__((noinline)) void noploop(void) {
> > +     while (!done)
> > +             continue;
> > +}
> > +
> > +int main(int argc, char *argv[]) {
> > +     int sec = 1;
> > +
> > +     if (argc > 1)
> > +             sec = atoi(argv[1]);
> > +
> > +     signal(SIGALRM, sigalrm);
> > +     alarm(sec);
> > +
> > +     noploop();
> > +     return 0;
> > +}
> > +EOF
> > +
> > +
> > +if ! perf record -e cycles:u -o - ${file} | perf report -i - --task | grep test.file; then
>
> hi
> cycles:u will fail in virtual machine, could you use
> cpu-clock instead or skip the test?

You're right!  I'll update to use task-clock.

Thanks,
Namhyung
