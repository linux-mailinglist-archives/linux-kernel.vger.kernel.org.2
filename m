Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8650337916
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 17:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234509AbhCKQT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 11:19:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234497AbhCKQSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 11:18:54 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34F0C061760
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 08:18:40 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id u5-20020a7bcb050000b029010e9316b9d5so10212866wmj.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 08:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=scPeu1W4oPf7ukxV1Wwv9Ny4L6MYW8naSBM1diyXnYo=;
        b=wFiOP7QBPbOFX5eujFdUQ+rHWwxcjoJeGuvNmzeqpiem12IZ22rxIUs05Cdydbhnrt
         o5LfwTT8Ifa/3DVmJO9D1o1ppxnvZPxKniLUikBc8aEP4M9eKIhvnpBuaCLmc6359tw4
         WsMG7AOqqxQITQB+YvM+3UPL6Q5BLfHQ2E15NxGI9nMJVwRkwBRNrcigah0ytnnlIuZH
         jmDJEHAKjcY9uBqqx6nFfJ6T+aggNZooFr0KjssDhuELLG2zegnhy17H/s4Gonnokbnf
         KHJ+Eh4hE0eVP5q9FVMrRYP7M3BT8WI5sptl1vBck7/L2YcF/nDGeY+GgvIKTkLrXrFc
         Rl1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=scPeu1W4oPf7ukxV1Wwv9Ny4L6MYW8naSBM1diyXnYo=;
        b=BKnqCxw0H1HMPDkBdK+d8Mxu21GyzxUwkmcXoEAq5VpDmTm5v6FToeLat7CqFBBgSA
         aTg2Llx7WfYBV9lixif4NY3lT9qUUhD78srDCSKaHUkUrC6xrNxbtTD3tjKoittnoKRy
         gccmAN322DjQXbT+VLUZfyyAYuXnyPCgeZWuZVdyIbX0GNHwuxwTegf7BMifYPMuJ8fG
         nj1TwrqWqwmPvn7tRsVcypR9Q3NkBiQEKsEJCFdcDJD/y5wQN+RO91QLJAzH+wu+V/3i
         y1UJGs2a0jIVAkOMHQe1lh0VyI/NMPYGuZKq95VYLxq+AsKGvNQDFGX2OAOkUMp+u/3k
         tbxQ==
X-Gm-Message-State: AOAM5303V8RZ8JeeoBhfWEI6+dOKeiDFYI4rjdk4ptLbUhAKekmbp8mx
        OV4v3CHHfs7aD0c8db11+aDoTd86UVyWE0DV9OoJbg==
X-Google-Smtp-Source: ABdhPJw5xkJ68FV9Pg63ZuazH6UPX6LNntb5XOJb4WoVyN11tLRJ32QnZ/I0aKzXzlYSV5C36ATIzeYlkjicaQ9c+tI=
X-Received: by 2002:a7b:c188:: with SMTP id y8mr8862511wmi.76.1615479519470;
 Thu, 11 Mar 2021 08:18:39 -0800 (PST)
MIME-Version: 1.0
References: <20210310204118.711514-1-irogers@google.com> <20210310204118.711514-2-irogers@google.com>
 <YEnzAK01qD1+3aOg@krava>
In-Reply-To: <YEnzAK01qD1+3aOg@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 11 Mar 2021 08:18:27 -0800
Message-ID: <CAP-5=fUdg=qxfqy5bf+N1r3_eiwCoz5F7g0TQayV-_Cu67Vo+A@mail.gmail.com>
Subject: Re: [PATCH 2/3] perf test: Cleanup daemon if test is interrupted.
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 2:38 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Wed, Mar 10, 2021 at 12:41:17PM -0800, Ian Rogers wrote:
> > Reorder daemon_start and daemon_exit as the trap handler is added in
> > daemon_start referencing daemon_exit.
>
> makes sense, minor comments below
>
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/tests/shell/daemon.sh | 34 +++++++++++++++++++-------------
> >  1 file changed, 20 insertions(+), 14 deletions(-)
> >
> > diff --git a/tools/perf/tests/shell/daemon.sh b/tools/perf/tests/shell/daemon.sh
> > index 66ad56b4e0a5..a02cedc76de6 100755
> > --- a/tools/perf/tests/shell/daemon.sh
> > +++ b/tools/perf/tests/shell/daemon.sh
> > @@ -98,6 +98,23 @@ check_line_other()
> >       fi
> >  }
> >
> > +daemon_exit()
> > +{
> > +     local config=$1
> > +
> > +     local line=`perf daemon --config ${config} -x: | head -1`
> > +     local pid=`echo "${line}" | awk 'BEGIN { FS = ":" } ; { print $1 }'`
> > +
> > +        # Reset trap handler.
> > +        trap - SIGINT SIGTERM
>
> please keep the 'tabs' in here
>
> > +
> > +     # stop daemon
> > +     perf daemon stop --config ${config}
> > +
> > +     # ... and wait for the pid to go away
> > +     tail --pid=${pid} -f /dev/null
> > +}
> > +
> >  daemon_start()
> >  {
> >       local config=$1
> > @@ -105,6 +122,9 @@ daemon_start()
> >
> >       perf daemon start --config ${config}
> >
> > +        # Clean up daemon if interrupted.
> > +        trap "daemon_exit ${config}; exit 4" SIGINT SIGTERM
>
> ditto, plus let's document exit values somewhere in comments,
> I think the next patch is adding exit 62, so that one as well

Thanks, it might be easier to just have these as exit 1 - I pulled
values from the errno list. Do you have any preferences?

Ian

> thanks,
> jirka
>
> > +
> >       # wait for the session to ping
> >       local state="FAIL"
> >       while [ "${state}" != "OK" ]; do
> > @@ -113,20 +133,6 @@ daemon_start()
> >       done
> >  }
> >
> > -daemon_exit()
> > -{
> > -     local config=$1
> > -
> > -     local line=`perf daemon --config ${config} -x: | head -1`
> > -     local pid=`echo "${line}" | awk 'BEGIN { FS = ":" } ; { print $1 }'`
> > -
> > -     # stop daemon
> > -     perf daemon stop --config ${config}
> > -
> > -     # ... and wait for the pid to go away
> > -     tail --pid=${pid} -f /dev/null
> > -}
> > -
> >  test_list()
> >  {
> >       echo "test daemon list"
> > --
> > 2.30.1.766.gb4fecdf3b7-goog
> >
>
