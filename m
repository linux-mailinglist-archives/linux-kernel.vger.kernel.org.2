Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38B6D3B5400
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jun 2021 17:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbhF0PcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 11:32:19 -0400
Received: from mail-lj1-f180.google.com ([209.85.208.180]:39919 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbhF0PcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 11:32:18 -0400
Received: by mail-lj1-f180.google.com with SMTP id c11so20957724ljd.6
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 08:29:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n3zC9vct0BKnSbcykuX2t4D1DXK+99mTvL/jzo8DFs4=;
        b=XVMXweTFrVdKe80reSpWSFpKbChiR+bpglqSsqaW3qoRCkVdyQfB5Kob5KxMsvIRRR
         LHuCpFHc9CVnDGUyGMfOi0sCE3d2Wq+XuUSaNl51aytq6BqQvgKlVOys1COkZJrwKPh6
         VfIHtd1v5yHyQQCWbvz+D1g+92b/DUGBoCXKH8dOXEuq3umlJENuM0S54W4S48Igukdj
         rH0emdEOYgMc7JMyJoRdiiNP7m92PkKLMX37nlVH1TOHgXX/7gpSUMRBzJ78cTIOIddx
         7kTHiuT4HrxYb5lnLFuUOZ1MAIZ3l+5ROf/72dyecFkQO22bkwQNSJvfIzPDcfmlz+aB
         s19w==
X-Gm-Message-State: AOAM530PY8xlIpTRPKIPE72VEITxUQvG6br6K7wLkQx2XXWDtir7Bf8K
        9j/fiYYrJGMhaI9FK0WU4iq9X62yNoqP28zXkDo=
X-Google-Smtp-Source: ABdhPJzyQticJUoe1xUnMcKbKFqjT5MaalHuyAvRwaHjC8jJdz8Q2+b/1/VVfZ9SykRP6lb4lcuYMTPfD/e5rMtdIa0=
X-Received: by 2002:a2e:5c42:: with SMTP id q63mr15906539ljb.23.1624807792158;
 Sun, 27 Jun 2021 08:29:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210625071826.608504-1-namhyung@kernel.org>
In-Reply-To: <20210625071826.608504-1-namhyung@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sun, 27 Jun 2021 08:29:40 -0700
Message-ID: <CAM9d7ci=S2p4_Baqo_vY8sVnST1jKL-HxcHNtcfKzuv0fA-R+Q@mail.gmail.com>
Subject: Re: [PATCHSET v4 0/4] perf stat: Enable BPF counters with --for-each-cgroup
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
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

On Fri, Jun 25, 2021 at 12:18 AM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hello,
>
> This is to add BPF support for --for-each-cgroup to handle many cgroup
> events on big machines.  You can use the --bpf-counters to enable the
> new behavior.
>
>  * changes in v4
>   - convert cgrp_readings to a per-cpu array map
>   - remove now-unused cpu_idx map
>   - move common functions to a header file
>   - reuse bpftool bootstrap binary
>   - fix build error in the cgroup code
>
>  * changes in v3
>   - support cgroup hierarchy with ancestor ids
>   - add and trigger raw_tp BPF program
>   - add a build rule for vmlinux.h
>
>  * changes in v2
>   - remove incorrect use of BPF_F_PRESERVE_ELEMS
>   - add missing map elements after lookup
>   - handle cgroup v1
>
> Basic idea is to use a single set of per-cpu events to count
> interested events and aggregate them to each cgroup.  I used bperf
> mechanism to use a BPF program for cgroup-switches and save the
> results in a matching map element for given cgroups.
>
> Without this, we need to have separate events for cgroups, and it
> creates unnecessary multiplexing overhead (and PMU programming) when
> tasks in different cgroups are switched.  I saw this makes a big
> difference on 256 cpu machines with hundreds of cgroups.
>
> Actually this is what I wanted to do it in the kernel [1], but we can
> do the job using BPF!

Ugh, I found the current kernel bpf verifier doesn't accept the
bpf_get_current_ancestor_cgroup_id() helper.  Will send the fix
to BPF folks.

Thanks,
Namhyung
