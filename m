Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A22233A815
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 21:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233841AbhCNU7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 16:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbhCNU6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 16:58:49 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA85DC061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 13:58:48 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id m22so53725716lfg.5
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 13:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+6Di/Guy0IiLQUX4jWIlkT7I+6XHE/84/IRYxlv8c/I=;
        b=QFI2F/wwMxZYsp5KsWQ8CwWKELPlhpD2ZGNvO+1vzxC+a4k0X4d8fSilP6Wl2ws4s5
         NbEPosz7r+pOalhoaqZYJLyxtjZ2D3yI8Vk6EnNYA4DQEQZLLt9Qpf/Tj6nMnUclbXyG
         PmiJOZH8HINpiRBURmPW81mAC4Z/Vj/KkXhZ69TkHFuKMr3uluWHW82ektNF73jr5x5A
         dIGJCjzYAb7RIaJUqZA1USveLPqPM04/t+/Fk+cb7NBmb3rxf/cGS5i7EPYukqBVmCmX
         vzusxYlossm2OC7svX/oVxzkXMpPG6Ua5zucLEKx9vkGY6lvuR1k4sXvV8BJNXVSSmcU
         KjoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+6Di/Guy0IiLQUX4jWIlkT7I+6XHE/84/IRYxlv8c/I=;
        b=nUXzhwCHvKYiNLlRzWVGOZHNRBp7GPkxKGm5YQmMexK0DdxJY+k3qhb2oTAVAUjeeU
         42LbyQvtWf54bWQCxMcjd32WeSYQc/DrXPq3S3/sIOIadBVv/yi6/h0D8u7fTVmsXlnH
         2a8ssqGC5vFvNH8WLEv968kdO8EtE93N13oIm4XzLFEiMJZZkSPEZ6J9eidHnW3NUGUL
         dsoCtWbiD0b4BV/KPOV88Z2Qidt70SgPjikmdVzxM2zKDV/sLGGGf6RRnj+B0eAFuN+U
         EdarMSOyrev18j0zPaQUOGtFA158NdPUkpi27eIHCxAyeLzIlQXCXB97ZSxPSJrPni5n
         Yjsg==
X-Gm-Message-State: AOAM531Q/R7OGu7Z/T8oYBQkCTk2vaUH+clkH5KhapEvoFZHFvoTEnAD
        zbozoq3rwR5WuSvjdNh9S3ww6posAga6M3rlBivmRQ==
X-Google-Smtp-Source: ABdhPJymNe0gWeDhOnFG1Pw30LoYMn9W1Y1JQ4wpMCETqOJ2d1ujk5rrAIX0IpHLkXL3Ix7isKa6YGwkybZ1hmyMXMw=
X-Received: by 2002:a05:6512:39c9:: with SMTP id k9mr5804908lfu.432.1615755527065;
 Sun, 14 Mar 2021 13:58:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210311004449.1170308-1-ying.huang@intel.com>
 <CALvZod7QNEXdKCJ3H3eoZKsRj5jtOESkmHm1dTC-ZjSBAcW7ng@mail.gmail.com> <87v99yvzq8.fsf@yhuang-dev.intel.com>
In-Reply-To: <87v99yvzq8.fsf@yhuang-dev.intel.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Sun, 14 Mar 2021 13:58:33 -0700
Message-ID: <CALvZod6HC-oDQJgQxh=sJi91y0_SK2xuMMW35aac0YURjbPEOQ@mail.gmail.com>
Subject: Re: [PATCH] vmscan: retry without cache trim mode if nothing scanned
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Michal Hocko <mhocko@suse.cz>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 12:52 AM Huang, Ying <ying.huang@intel.com> wrote:
>
> Hi, Butt,
>
> Shakeel Butt <shakeelb@google.com> writes:
>
> > On Wed, Mar 10, 2021 at 4:47 PM Huang, Ying <ying.huang@intel.com> wrote:
> >>
> >> From: Huang Ying <ying.huang@intel.com>
> >>
> >> In shrink_node(), to determine whether to enable cache trim mode, the
> >> LRU size is gotten via lruvec_page_state().  That gets the value from
> >> a per-CPU counter (mem_cgroup_per_node->lruvec_stat[]).  The error of
> >> the per-CPU counter from CPU local counting and the descendant memory
> >> cgroups may cause some issues.  We run into this in 0-Day performance
> >> test.
> >>
> >> 0-Day uses the RAM file system as root file system, so the number of
> >> the reclaimable file pages is very small.  In the swap testing, the
> >> inactive file LRU list will become almost empty soon.  But the size of
> >> the inactive file LRU list gotten from the per-CPU counter may keep a
> >> much larger value (say, 33, 50, etc.).  This will enable cache trim
> >> mode, but nothing can be scanned in fact.  The following pattern
> >> repeats for long time in the test,
> >>
> >> priority        inactive_file_size      cache_trim_mode
> >> 12              33                      0
> >> 11              33                      0
> >> ...
> >> 6               33                      0
> >> 5               33                      1
> >> ...
> >> 1               33                      1
> >>
> >> That is, the cache_trim_mode will be enabled wrongly when the scan
> >> priority decreases to 5.  And the problem will not be recovered for
> >> long time.
> >>
> >> It's hard to get the more accurate size of the inactive file list
> >> without much more overhead.  And it's hard to estimate the error of
> >> the per-CPU counter too, because there may be many descendant memory
> >> cgroups.  But after the actual scanning, if nothing can be scanned
> >> with the cache trim mode, it should be wrong to enable the cache trim
> >> mode.  So we can retry with the cache trim mode disabled.  This patch
> >> implement this policy.
> >
> > Instead of playing with the already complicated heuristics, we should
> > improve the accuracy of the lruvec stats. Johannes already fixed the
> > memcg stats using rstat infrastructure and Tejun has suggestions on
> > how to use rstat infrastructure efficiently for lruvec stats at
> > https://lore.kernel.org/linux-mm/YCFgr300eRiEZwpL@slm.duckdns.org/.
>
> Thanks for your information!  It should be better if we can improve the
> accuracy of lruvec stats without much overhead.  But that may be not a
> easy task.
>
> If my understanding were correct, what Tejun suggested is to add a fast
> read interface to rstat to be used in hot path.  And its accuracy is
> similar as that of traditional per-CPU counter.  But if we can regularly
> update the lruvec rstat with something like vmstat_update(), that should
> be OK for the issue described in this patch.
>

This is also my understanding. Tejun, please correct us if we misunderstood you.

BTW Johannes was working on rstat-based lruvec stats patch. Johannes,
are you planning to work on the optimization Tejun has suggested.
