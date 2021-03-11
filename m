Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D339D336954
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 01:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbhCKA6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 19:58:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhCKA6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 19:58:03 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893E2C061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 16:58:02 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id d3so36788926lfg.10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 16:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CrfiISBeWcM0aghiGCmSAIV9dxcofoH89E4I2n3l8ko=;
        b=fOC/xkbof84GSdDqGTqMuAYyiGl9AT6rEWRfjjF30HZBilUqm25UMz9Zh8pezHE+lY
         VrwLXmP2U2XJl0HYbYqDhCd5fZ1oImvNq3Uz259jpqJqG0sNu6Yr/EMbuhSJTMM9nRKo
         euin/u8aCf9vResvfQ5bxbg5AVU4TpRd1zmSok1+VFvnE1LeQKELyQ1cJtxjR4KKwKgm
         bSuSsrm1kh9KROHeh4624u58UIG8aXB27Z4Fp/xDPfcCAvlb4c9XPNnRlz3zbk0gXZi1
         mpCjKqw//YoPe2Khl+6Qx7ux47X7Eg47OQuDQss9gnQc55vAUhKdytduEXUN2s8bdYkp
         U2nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CrfiISBeWcM0aghiGCmSAIV9dxcofoH89E4I2n3l8ko=;
        b=pAl8VZlYCVAhoKYm/yCOHNHb1tW0ZmvtYfWoVg59iHL0FzHxybe19vyfkGKBaVp9ZJ
         nwK8S6buLAfMyJ3lelTuTjKTkwHIFUMwPx1jtwPARZvdgvvFc4bFfBcrP13luSBiytn7
         OF0E93n6pViv78YyPx2Rh8+pqcNwAzqN9VC9qJcFztuygZqMcMkMcRQqQZyuFFbGTWRT
         zzjLQPy3qV7wAEwDurK4sr0b+J5Js1m1Tae+WhwuSXlbU2CIhbglR1+1OK9ovEss+Q0V
         oM9Hhn/6cfkC1tzKLuzpQIU68Pxc93lgCBte9IUuDmfkZN35bWTJLWgc5SwHm8OuJhix
         aa5Q==
X-Gm-Message-State: AOAM532nzUrm+eZk6sbSiezS0g9sRBN4XcDBhAI6hpOEY6Jykxn1Z0a8
        g82I3yOAG9gMEwq5QlYs3J207ZigjsSxk97qRTGsNw==
X-Google-Smtp-Source: ABdhPJwMGRKq9/WgW0SNx8+uw2SlrViPc03sBFHB9sWqOYawhu2bCVGCKfQ+zEg9JyrhTauiMKXGeqYxoahn9yitUZo=
X-Received: by 2002:a19:3804:: with SMTP id f4mr721936lfa.117.1615424280844;
 Wed, 10 Mar 2021 16:58:00 -0800 (PST)
MIME-Version: 1.0
References: <20210311004449.1170308-1-ying.huang@intel.com>
In-Reply-To: <20210311004449.1170308-1-ying.huang@intel.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 10 Mar 2021 16:57:49 -0800
Message-ID: <CALvZod7QNEXdKCJ3H3eoZKsRj5jtOESkmHm1dTC-ZjSBAcW7ng@mail.gmail.com>
Subject: Re: [PATCH] vmscan: retry without cache trim mode if nothing scanned
To:     "Huang, Ying" <ying.huang@intel.com>, Tejun Heo <tj@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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

On Wed, Mar 10, 2021 at 4:47 PM Huang, Ying <ying.huang@intel.com> wrote:
>
> From: Huang Ying <ying.huang@intel.com>
>
> In shrink_node(), to determine whether to enable cache trim mode, the
> LRU size is gotten via lruvec_page_state().  That gets the value from
> a per-CPU counter (mem_cgroup_per_node->lruvec_stat[]).  The error of
> the per-CPU counter from CPU local counting and the descendant memory
> cgroups may cause some issues.  We run into this in 0-Day performance
> test.
>
> 0-Day uses the RAM file system as root file system, so the number of
> the reclaimable file pages is very small.  In the swap testing, the
> inactive file LRU list will become almost empty soon.  But the size of
> the inactive file LRU list gotten from the per-CPU counter may keep a
> much larger value (say, 33, 50, etc.).  This will enable cache trim
> mode, but nothing can be scanned in fact.  The following pattern
> repeats for long time in the test,
>
> priority        inactive_file_size      cache_trim_mode
> 12              33                      0
> 11              33                      0
> ...
> 6               33                      0
> 5               33                      1
> ...
> 1               33                      1
>
> That is, the cache_trim_mode will be enabled wrongly when the scan
> priority decreases to 5.  And the problem will not be recovered for
> long time.
>
> It's hard to get the more accurate size of the inactive file list
> without much more overhead.  And it's hard to estimate the error of
> the per-CPU counter too, because there may be many descendant memory
> cgroups.  But after the actual scanning, if nothing can be scanned
> with the cache trim mode, it should be wrong to enable the cache trim
> mode.  So we can retry with the cache trim mode disabled.  This patch
> implement this policy.

Instead of playing with the already complicated heuristics, we should
improve the accuracy of the lruvec stats. Johannes already fixed the
memcg stats using rstat infrastructure and Tejun has suggestions on
how to use rstat infrastructure efficiently for lruvec stats at
https://lore.kernel.org/linux-mm/YCFgr300eRiEZwpL@slm.duckdns.org/.
