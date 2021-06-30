Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7ED93B7D55
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 08:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbhF3GWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 02:22:41 -0400
Received: from mail-lj1-f169.google.com ([209.85.208.169]:39683 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbhF3GWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 02:22:39 -0400
Received: by mail-lj1-f169.google.com with SMTP id c11so1675635ljd.6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 23:20:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fi84/fcfdof1rBJUwt6I4qit4XezHxGkLHK4x+X55A0=;
        b=jFuNg6orlKQJyPLfgqQvpkC4w9UK9hJv4Gb1hXUYXzkZpHViLqkEOWWRek1or1tbrO
         Di/mlkf8zMUwf6zEzKg48YvzHLNoCNxRX0vFJLG2Kwk6uikOIEh3EI9oHepkZpgWiISH
         hXeFGapN7g7tSY34MdU6FJw2n85Zhgc7W3d2q1JFJtakQ0IT8sDhtDJillS69qOyJ8Mt
         WsueQhSSNW2YlrUvnuw7HnD1hAcmH1ZFMd+KXsgDKhxAJmCwA6moKAe6GtXB01j5sLgb
         uHaYa8l61u0ZLSZ1ZdG2NjO3ml6qcdMjHsdre+Z6Ubt1OJnTw14hobD20a5d3QvIWAdd
         YmGg==
X-Gm-Message-State: AOAM531mYy+zGVZfyXfhKcqnJP1Bce5cM7id3gFqNE6EEYrChkJwapCa
        gHdCDNE7+g+ckJRYSuy0pPZAq318pwQi7p3Vj34=
X-Google-Smtp-Source: ABdhPJwtshQlkTpu133O2Eazog1AoiarWWI9uQt4mgYxEI7iFpRcT3mckJ6nW9u7oaU3dJ1XOnrqpgjorM2492/Ui9Y=
X-Received: by 2002:a2e:5c42:: with SMTP id q63mr6508934ljb.23.1625034010564;
 Tue, 29 Jun 2021 23:20:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210625071826.608504-1-namhyung@kernel.org> <CAM9d7ci=S2p4_Baqo_vY8sVnST1jKL-HxcHNtcfKzuv0fA-R+Q@mail.gmail.com>
In-Reply-To: <CAM9d7ci=S2p4_Baqo_vY8sVnST1jKL-HxcHNtcfKzuv0fA-R+Q@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 29 Jun 2021 23:19:59 -0700
Message-ID: <CAM9d7cjopjKuLktX_kgEREbQdF5GmhuG9prKuBpP_=fkhfP05g@mail.gmail.com>
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

On Sun, Jun 27, 2021 at 8:29 AM Namhyung Kim <namhyung@kernel.org> wrote:
>
> On Fri, Jun 25, 2021 at 12:18 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hello,
> >
> > This is to add BPF support for --for-each-cgroup to handle many cgroup
> > events on big machines.  You can use the --bpf-counters to enable the
> > new behavior.
> >
> >  * changes in v4
> >   - convert cgrp_readings to a per-cpu array map
> >   - remove now-unused cpu_idx map
> >   - move common functions to a header file
> >   - reuse bpftool bootstrap binary
> >   - fix build error in the cgroup code
> >
> >  * changes in v3
> >   - support cgroup hierarchy with ancestor ids
> >   - add and trigger raw_tp BPF program
> >   - add a build rule for vmlinux.h
> >
> >  * changes in v2
> >   - remove incorrect use of BPF_F_PRESERVE_ELEMS
> >   - add missing map elements after lookup
> >   - handle cgroup v1
> >
> > Basic idea is to use a single set of per-cpu events to count
> > interested events and aggregate them to each cgroup.  I used bperf
> > mechanism to use a BPF program for cgroup-switches and save the
> > results in a matching map element for given cgroups.
> >
> > Without this, we need to have separate events for cgroups, and it
> > creates unnecessary multiplexing overhead (and PMU programming) when
> > tasks in different cgroups are switched.  I saw this makes a big
> > difference on 256 cpu machines with hundreds of cgroups.
> >
> > Actually this is what I wanted to do it in the kernel [1], but we can
> > do the job using BPF!
>
> Ugh, I found the current kernel bpf verifier doesn't accept the
> bpf_get_current_ancestor_cgroup_id() helper.  Will send the fix
> to BPF folks.

The fix landed on the bpf-next tree.

Thanks,
Namhyung
