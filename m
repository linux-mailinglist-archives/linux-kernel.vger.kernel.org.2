Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15ED33687FA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 22:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239629AbhDVUbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 16:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239582AbhDVUa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 16:30:59 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D559AC06138E
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 13:30:17 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id n127so12991389wmb.5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 13:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qTXaC1wPEXm+1mH+sfanrRo5t3eGOrK+943dNeKI5PI=;
        b=Mv1iID0++5aYuTRy8gJ7E446Qv3c1dwpyzCp3Mw1OzqQP4kK6ul9Pmc8MVTClhG9JX
         jhUKGNk+E3O1WnKLWVgur3xmReqG7fgI2v1KmiRyjWwOacMJKqlUMcuptfi81vpfGz6P
         9E/I7ev22JkBQ5v/g2pzGvucaGbveYuWUNy6cku2cLea3+3iAudaCGxA0PPt/7lFSjWo
         JU3k9T+T7gqmzXf6xA3fssPYENofZtpVgYjL3phbSEEVjgryh+kx6JK491tZ0w+jiz/p
         89qch0L5tgYKE7min2nIa3kNjExfwTIrouuucOrkXIDBbzlTXX7d46phlc353HcOsNtk
         /6Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qTXaC1wPEXm+1mH+sfanrRo5t3eGOrK+943dNeKI5PI=;
        b=ZCh4JeCjVcnAgLL93ulv+DmQxbyqi9CBK1BnoUO7uJRX4s8j0TtatZbue9I4gZgPrU
         IRL/VIaIc6mpmvELnkMPCmDadBnzHfpsNs0YADKAzgeV+kpVuoW4ivIaX6odom+yRLys
         Q86lfX4JykW2vL+sTRiEu7cxD6PtnI75zK+Pa9CdFOiGscCw0CA9f3R8odD9uz88xW+2
         rXhNph38hE9kIgv6ABdUpr0vF+xVnm4X7SmfhWOMjkxjSkvKEgrKSLJcFyaH1nhMuB6z
         MKU/xevTRnXZDkroo3uuC6TuR8dUv6st4rFHuEbziCrriZBf+xXVY58SCepNyQF+6Lbl
         q9Qw==
X-Gm-Message-State: AOAM533kkB1mK8l/T09Z5DVPYcu3zRsCEym/IDpcPnZSgyZbWL0ukX+2
        f+OV89Rz2HCVxnr6pba0qfcwHla7YE+5rfWWDFh5mUv6M96Trw==
X-Google-Smtp-Source: ABdhPJwKfuvvO29EX0aKtGbGqfFKejpXbrFZXDhFroou6tGq5CzaaGIbXZ4Zbm90HzwU/UO29cN87tsZx2XgC5tWBME=
X-Received: by 2002:a7b:ce8a:: with SMTP id q10mr561453wmj.101.1619123416372;
 Thu, 22 Apr 2021 13:30:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210416023536.168632-1-zhengjun.xing@linux.intel.com>
 <7b7a1c09-3d16-e199-15d2-ccea906d4a66@linux.intel.com> <YIGuvh70JbE1Cx4U@google.com>
 <a085478d-5118-cdff-c611-1649fce7a650@linux.intel.com>
In-Reply-To: <a085478d-5118-cdff-c611-1649fce7a650@linux.intel.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Thu, 22 Apr 2021 14:30:04 -0600
Message-ID: <CAOUHufbVmsvWQ-_PSn8CCanuJqRR6Tmj01s17WvKsc3pRa87xw@mail.gmail.com>
Subject: Re: [RFC] mm/vmscan.c: avoid possible long latency caused by too_many_isolated()
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Huang Ying <ying.huang@intel.com>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>, wfg@mail.ustc.edu.cn
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 2:17 PM Tim Chen <tim.c.chen@linux.intel.com> wrote:
>
>
>
> On 4/22/21 10:13 AM, Yu Zhao wrote:
>
> > @@ -3302,6 +3252,7 @@ static bool throttle_direct_reclaim(gfp_t gfp_mask, struct zonelist *zonelist,
> >  unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
> >                               gfp_t gfp_mask, nodemask_t *nodemask)
> >  {
> > +     int nr_cpus;
> >       unsigned long nr_reclaimed;
> >       struct scan_control sc = {
> >               .nr_to_reclaim = SWAP_CLUSTER_MAX,
> > @@ -3334,8 +3285,17 @@ unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
> >       set_task_reclaim_state(current, &sc.reclaim_state);
> >       trace_mm_vmscan_direct_reclaim_begin(order, sc.gfp_mask);
> >
> > +     nr_cpus = current_is_kswapd() ? 0 : num_online_cpus();
> > +     while (nr_cpus && !atomic_add_unless(&pgdat->nr_reclaimers, 1, nr_cpus)) {
> > +             if (schedule_timeout_killable(HZ / 10))
>
> 100 msec seems like a long time to wait.  The original code in shrink_inactive_list
> choose 100 msec sleep because the sleep happens only once in the while loop and 100 msec was
> used to check for stalling.  In this case the loop can go on for a while and the
> #reclaimers can go down below the sooner than 100 msec. Seems like it should be checked
> more often.

You are not looking at the original code -- the original code sleeps
indefinitely. It was changed by commit db73ee0d46 to fix a problem
that doesn't apply to the code above.

HZ/10 is purely arbitrary but that's ok because we assume normally
nobody hits it. If you do often, we need to figure out why and how not
to hit it so often.
