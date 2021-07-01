Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1DCA3B9547
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 19:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbhGARNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 13:13:42 -0400
Received: from mail-lf1-f48.google.com ([209.85.167.48]:37521 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbhGARNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 13:13:42 -0400
Received: by mail-lf1-f48.google.com with SMTP id q16so13113943lfr.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 10:11:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TkLSd88P8swfZZPFWHEYFw2bADcxqOmNRhso9H/AhMI=;
        b=QiHFxb3AjQGW8Q0mWF2rRXikYfzHh4YILTTuP5s4BPeKfhaaDfPHWFBpm0wz92SrA6
         RH2bEZZJUI9FNHI2qY8+aPwSj2XfHcZr0GIqKGHp+whTFxrNboLSEmTuxVnCOhYz6lwG
         gST4LMn/66hvarSZ8HxTTEAskTR2sITg7WFbklkjE+jz4Zi4g/BFUV5e+7molZAOedVP
         8kSaTfRZzOWs1cz2xpZ5iInePkMgEniWvynSzxI7i3TEQ8gSW3g6KUfGy106difwFco8
         ER0eBfZ7tdDtqu9n9k0qcUJbcWCvduZdjuGeiF2yipAf73Phu7KFA7bCsUNtFM6VrnUm
         QOYg==
X-Gm-Message-State: AOAM531VjxiKOmM+Bu8BAG2+nLTaeJWrwoao+FPBrIope0dfBDsD7oyT
        g6Iw+hoQLVAB6OS9Q0StN1OSbG4oKh1MglwD/jA=
X-Google-Smtp-Source: ABdhPJwJ89Gp6+fGJk3upWd+c73eIN+isjAYAGXDOKAgY0UQ+R0PViZr3PgSiIw7VQ6nHnkZjlylV3bvt+3jUXDeZTw=
X-Received: by 2002:a05:6512:3744:: with SMTP id a4mr500420lfs.112.1625159468500;
 Thu, 01 Jul 2021 10:11:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210625071826.608504-1-namhyung@kernel.org> <20210625071826.608504-5-namhyung@kernel.org>
 <YNy85M22XZ8Sc/Gz@kernel.org> <YN3GgMUFtMCYpNI7@kernel.org>
In-Reply-To: <YN3GgMUFtMCYpNI7@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 1 Jul 2021 10:10:57 -0700
Message-ID: <CAM9d7ci833BC_9moyF7pbRLJ=tYxR8GH_y41pS1jcF3vC163bA@mail.gmail.com>
Subject: Re: [PATCH 4/4] perf stat: Enable BPF counter with --for-each-cgroup
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 1, 2021 at 6:43 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> Em Wed, Jun 30, 2021 at 03:50:12PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Fri, Jun 25, 2021 at 12:18:26AM -0700, Namhyung Kim escreveu:
> > > Recently bperf was added to use BPF to count perf events for various
> > > purposes.  This is an extension for the approach and targetting to
> > > cgroup usages.
> > >
> > > Unlike the other bperf, it doesn't share the events with other
> > > processes but it'd reduce unnecessary events (and the overhead of
> > > multiplexing) for each monitored cgroup within the perf session.
> > >
> > > When --for-each-cgroup is used with --bpf-counters, it will open
> > > cgroup-switches event per cpu internally and attach the new BPF
> > > program to read given perf_events and to aggregate the results for
> > > cgroups.  It's only called when task is switched to a task in a
> > > different cgroup.
> >
> > I'll take a stab at fixing these:
>
> So, tried some 'make -C tools clean', etc but I'm now stuck with:
>
>   CLANG   /tmp/build/perf/util/bpf_skel/.tmp/bperf_cgroup.bpf.o
> util/bpf_skel/bperf_cgroup.bpf.c:4:10: fatal error: 'vmlinux.h' file not found
> #include "vmlinux.h"
>          ^~~~~~~~~~~
> 1 error generated.
> make[2]: *** [Makefile.perf:1033: /tmp/build/perf/util/bpf_skel/.tmp/bperf_cgroup.bpf.o] Error 1
> make[2]: *** Waiting for unfinished jobs....
>   CC      /tmp/build/perf/pmu-events/pmu-events.o
>   LD      /tmp/build/perf/pmu-events/pmu-events-in.o
>
> Auto-detecting system features:
> ...                        libbfd: [ on  ]
> ...        disassembler-four-args: [ on  ]
> ...                          zlib: [ on  ]
> ...                        libcap: [ on  ]
> ...               clang-bpf-co-re: [ on  ]
>
>
>   MKDIR   /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/
>   MKDIR   /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/
>
>
> Have to go errands now, will put what I have at tmp.perf/core now.
> Please see if you can reproduce, I use this to build:
>
>     make -k CORESIGHT=1 BUILD_BPF_SKEL=1 PYTHON=python3 DEBUG=1 O=/tmp/build/perf -C tools/perf install-bin
>
> - Arnaldo

Oh, sorry about that.  I found the header generation is misplaced
in the Makefile.perf.  Will fix it in the next version.

Thanks,
Namhyung
