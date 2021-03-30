Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3BBE34F123
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 20:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232819AbhC3SmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 14:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbhC3Sli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 14:41:38 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65254C061762
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 11:34:24 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id u10so21013948lju.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 11:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TOotaZ1871auGHiNnmRkwYZ1nFjr3BIDsT8kbzaoaws=;
        b=cfuA4VpJEcRZl5XvDIML2vmkn+UgzqbnbcbuAV6s5fg1aj8Q50DvUOwnVTpGszPmhY
         NcAsNl/xB9LoKcxwGP92Q3MAuWERLsGuEDsaSU0nMT1dtV+XyBvoJi/6wDwNeBTZ932N
         10orAzEaHmBSNLJRyv6b9PrbZYILSgRL/3V7gDXIh+yXhFEFICmsh/PZDcoGy5MM/0iQ
         cDruOYJuxalqbLTL2Y4RbAT3OfU/gU6xYU/K0w+hXY5NcZszr5mV8nuRqQ1LDu2qwSG+
         mRwYv0TLVWEa2OcnoebF0tia4/zOSK1gJhD2uwFbbgIraTwqIT+F/d536ech7U5ncDep
         JezQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TOotaZ1871auGHiNnmRkwYZ1nFjr3BIDsT8kbzaoaws=;
        b=OxxM5GTlVJcMojnGAAVuQmIk109tqwQGlZU6wlxk8bHjN/utC9ZRQlj4XupFcS0SsC
         /uI5fynTmwlwccp9QZPNVTpnUoWqGJNjuVpAFcGpcaIxEQv1K1nnnBQ3S5K0iqG3XnOG
         /wIP6YTgjue9z1e53elL4yKlXeX11KAq2uQk9Kz8m2HzZFLFM0h22VaQwB1ZrUCAvjm0
         q0cor1B2P3Zzl2SdhUw+2kRN8yWMXUcllmJxAZiadr1/1fKbCGkm+7FW1kP9duBjEi11
         kG4KDqVHRaq7NZLNTJUrKhRD1sL04RR8DqGaxdvvGlQcudDcWGQPwi+2sl4xnobC4MnP
         AqqA==
X-Gm-Message-State: AOAM53027p14Qk5XaFYC2FOnEu7T+hywjeKJISsXSXHFCh/H8cGk3vMO
        ClU80KTzZOwBL1dZY0NWURZ+qi5f5CyIELJjpTayLA==
X-Google-Smtp-Source: ABdhPJyILJdYB71C1rvE9h+GXTtg1sWhlEVeLTC2gns5HopDK4DsMmYlvG1efqjSlGrpuLZF80sX9p/A/wbcB8yGDSE=
X-Received: by 2002:a2e:8084:: with SMTP id i4mr22524055ljg.122.1617129262630;
 Tue, 30 Mar 2021 11:34:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210330101531.82752-1-songmuchun@bytedance.com>
In-Reply-To: <20210330101531.82752-1-songmuchun@bytedance.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 30 Mar 2021 11:34:11 -0700
Message-ID: <CALvZod4xHNmTQMd+zg71s7uyXUHEfwnQ-zqRXSWphwi9RogeNg@mail.gmail.com>
Subject: Re: [RFC PATCH 00/15] Use obj_cgroup APIs to charge the LRU pages
To:     Muchun Song <songmuchun@bytedance.com>,
        Greg Thelen <gthelen@google.com>
Cc:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 3:20 AM Muchun Song <songmuchun@bytedance.com> wrote:
>
> Since the following patchsets applied. All the kernel memory are charged
> with the new APIs of obj_cgroup.
>
>         [v17,00/19] The new cgroup slab memory controller
>         [v5,0/7] Use obj_cgroup APIs to charge kmem pages
>
> But user memory allocations (LRU pages) pinning memcgs for a long time -
> it exists at a larger scale and is causing recurring problems in the real
> world: page cache doesn't get reclaimed for a long time, or is used by the
> second, third, fourth, ... instance of the same job that was restarted into
> a new cgroup every time. Unreclaimable dying cgroups pile up, waste memory,
> and make page reclaim very inefficient.
>
> We can convert LRU pages and most other raw memcg pins to the objcg direction
> to fix this problem, and then the LRU pages will not pin the memcgs.
>
> This patchset aims to make the LRU pages to drop the reference to memory
> cgroup by using the APIs of obj_cgroup. Finally, we can see that the number
> of the dying cgroups will not increase if we run the following test script.
>
> ```bash
> #!/bin/bash
>
> cat /proc/cgroups | grep memory
>
> cd /sys/fs/cgroup/memory
>
> for i in range{1..500}
> do
>         mkdir test
>         echo $$ > test/cgroup.procs
>         sleep 60 &
>         echo $$ > cgroup.procs
>         echo `cat test/cgroup.procs` > cgroup.procs
>         rmdir test
> done
>
> cat /proc/cgroups | grep memory
> ```
>
> Patch 1 aims to fix page charging in page replacement.
> Patch 2-5 are code cleanup and simplification.
> Patch 6-15 convert LRU pages pin to the objcg direction.

The main concern I have with *just* reparenting LRU pages is that for
the long running systems, the root memcg will become a dumping ground.
In addition a job running multiple times on a machine will see
inconsistent memory usage if it re-accesses the file pages which were
reparented to the root memcg.

Please note that I do agree with the mentioned problem and we do see
this issue in our fleet. Internally we have a "memcg mount option"
feature which couples a file system with a memcg and all file pages
allocated on that file system will be charged to that memcg. Multiple
instances (concurrent or subsequent) of the job will use that file
system (with a dedicated memcg) without leaving the zombies behind. I
am not pushing for this solution as it comes with its own intricacies
(e.g. if memcg coupled with a file system has a limit, the oom
behavior would be awkward and therefore internally we don't put a
limit on such memcgs). Though I want this to be part of discussion.

I think the underlying reasons behind this issue are:

1) Filesystem shared by disjoint jobs.
2) For job dedicated filesystems, the lifetime of the filesystem is
different from the lifetime of the job.

For now, we have two potential solutions to the
zombies-due-to-offlined-LRU-pages i.e. (1) reparent and (2) pairing
memcg and filesystem. For reparenting, the cons are inconsistent
memory usage and root memcg potentially becoming dumping ground. For
pairing, the oom behavior is awkward which is the same for any type of
remote charging.

I am wondering how we can resolve the cons for each. To resolve the
root-memcg-dump issue in the reparenting, maybe we uncharge the page
when it reaches root and the next accesser will be charged. For
inconsistent memory usage, either users accept the inconsistency or
force reclaim before offline which will reduce the benefit of sharing
filesystem with subsequent instances of the job. For the pairing,
maybe we can punt to the user/admin to not set a limit on such memcg
to avoid awkward oom situations.

Thoughts?
