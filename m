Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB63F338788
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 09:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbhCLIga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 03:36:30 -0500
Received: from mail-lj1-f180.google.com ([209.85.208.180]:40637 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbhCLIgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 03:36:20 -0500
Received: by mail-lj1-f180.google.com with SMTP id 9so5704679ljd.7
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 00:36:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PrzifUsyCtpgdH+6RpUgO0Lwk7DNJyvzEi8J89mgti4=;
        b=Vkn6Tr9oIbKTBXqrz8zdMPQH8YlRvep7elAmPR1YruUR5j52A8eOtTNxGHYR1LFz7a
         kLiSKopEAijcg/jR6owA+Q+KqnsnQbwbMi2u0pqm15tgYJC3PNvIsbbJaty/+BIhzlhZ
         0aJtJMsTnFniA9XGRdyUJ3Y3hfz5Ss7ZViKDGjVuWN/lOYzLOZfOoOjLZMGKaLJhF+at
         g1ZKRAG5bMyUtOaK8Ok517ayVvczSnJSM4SkNo5cwQxYsBknjaA6mkRgnYii+Vn2Hf1u
         8XVqmbyfFYohAmRBMIjyawcjbfpEAF/h+zB17RDigiU1++zmrE+PHZn12S9Tu5BVVnkr
         DgvA==
X-Gm-Message-State: AOAM532+VGXMrrijPxJt6RowMa/jcBq0+3GbpiCiDTwUA5ZUelYPdueY
        CNziQ/HvQwDdUsrySWZBjYC8oCvtV9WcZGiiGUw=
X-Google-Smtp-Source: ABdhPJyvxi0qQKOkFqd/pP44XXsVEgOuDtk366ztRmAMJ2Qyup6kqfoigqET2g7c7XqAUjqune64phjWjomIJsNyvrQ=
X-Received: by 2002:a2e:8e6e:: with SMTP id t14mr1689288ljk.23.1615538179489;
 Fri, 12 Mar 2021 00:36:19 -0800 (PST)
MIME-Version: 1.0
References: <20210312020257.197137-1-songliubraving@fb.com>
In-Reply-To: <20210312020257.197137-1-songliubraving@fb.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 12 Mar 2021 17:36:08 +0900
Message-ID: <CAM9d7che4Ott6F6SNj8aaXea+wgzDE8pVntkpGr1TCbnfWNXkw@mail.gmail.com>
Subject: Re: [PATCH] perf-stat: introduce bperf, share hardware PMCs with BPF
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, kernel-team@fb.com,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Mar 12, 2021 at 11:03 AM Song Liu <songliubraving@fb.com> wrote:
>
> perf uses performance monitoring counters (PMCs) to monitor system
> performance. The PMCs are limited hardware resources. For example,
> Intel CPUs have 3x fixed PMCs and 4x programmable PMCs per cpu.
>
> Modern data center systems use these PMCs in many different ways:
> system level monitoring, (maybe nested) container level monitoring, per
> process monitoring, profiling (in sample mode), etc. In some cases,
> there are more active perf_events than available hardware PMCs. To allow
> all perf_events to have a chance to run, it is necessary to do expensive
> time multiplexing of events.
>
> On the other hand, many monitoring tools count the common metrics (cycles,
> instructions). It is a waste to have multiple tools create multiple
> perf_events of "cycles" and occupy multiple PMCs.
>
> bperf tries to reduce such wastes by allowing multiple perf_events of
> "cycles" or "instructions" (at different scopes) to share PMUs. Instead
> of having each perf-stat session to read its own perf_events, bperf uses
> BPF programs to read the perf_events and aggregate readings to BPF maps.
> Then, the perf-stat session(s) reads the values from these BPF maps.
>
> Please refer to the comment before the definition of bperf_ops for the
> description of bperf architecture.

Interesting!  Actually I thought about something similar before,
but my BPF knowledge is outdated.  So I need to catch up but
failed to have some time for it so far. ;-)

>
> bperf is off by default. To enable it, pass --use-bpf option to perf-stat.
> bperf uses a BPF hashmap to share information about BPF programs and maps
> used by bperf. This map is pinned to bpffs. The default address is
> /sys/fs/bpf/bperf_attr_map. The user could change the address with option
> --attr-map.
>
> ---
> Known limitations:
> 1. Do not support per cgroup events;
> 2. Do not support monitoring of BPF program (perf-stat -b);
> 3. Do not support event groups.

In my case, per cgroup event counting is very important.
And I'd like to do that with lots of cpus and cgroups.
So I'm working on an in-kernel solution (without BPF),
I hope to share it soon.

And for event groups, it seems the current implementation
cannot handle more than one event (not even in a group).
That could be a serious limitation..

>
> The following commands have been tested:
>
>    perf stat --use-bpf -e cycles -a
>    perf stat --use-bpf -e cycles -C 1,3,4
>    perf stat --use-bpf -e cycles -p 123
>    perf stat --use-bpf -e cycles -t 100,101

Hmm... so it loads both leader and follower programs if needed, right?
Does it support multiple followers with different targets at the same time?

Thanks,
Namhyung
