Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9865F34F391
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 23:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbhC3VbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 17:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233484AbhC3VaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 17:30:13 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9500DC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 14:30:12 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id i9so17394406qka.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 14:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=f6+kdF3w84398U9boaR1oDCvtDMpQlwaLI1pe9v7LEU=;
        b=l4wWAasd+fQ1CoQ244XlM39j95UJauD9/rzsA5OhzjMVjWodjd67VeWaVybPdWBQDM
         0x5rAfgDO7mA8Nih5wKFuYmQlebRfxqLpZTIHhITT47hwPEET6NhO+KX/ut4K/Y5Zc9p
         31v7HTic6qWUXBZ8fxel02TpEX4brjp4d4sdR/zpHxf1RHsiIZFRS5HcMVXi8u2JtK/r
         xcW6vjanW2eV035wTQ8ZlZuMqn3KhWsOTtrWWvnD6+k2u32a9Uk5dGCirzA3xadZy1x9
         VS7eI2iudpLhZEh7M5n+fIrvuH/FYYfCYXGpZr6iD55KSD1ONmGI6TPTXAsT9464JOzx
         G3mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f6+kdF3w84398U9boaR1oDCvtDMpQlwaLI1pe9v7LEU=;
        b=jgZiYqy/+XXJMl1PlH3U9yeFMSY8i0qMv3AFF6ROvp7VhgDPmRaJ0CFTQva5gjJ7mI
         x6g9TcnGtP5gkUSWwgmuLC+VEaAYNi6BkcXj0riFERfvOqOiPfCAKBBotJyi07XdSaLA
         sVpwNxjj54ABZCI9jBv79Vage++SXRXsM/VWfCqnl8ah1eB3FjicQT6/nsAAuRYHccyt
         Et7EzHLDPl1d10YyWs9Y33ovrgUmgR7wZx+TZvSJ7zKuvnDf96kVHZ1ZFPmbd0zJwhzx
         +/SbRrYI77bH7FFW7JTqiXwn7SQYqgVxDzYcMuYe38aGVnwky3tEgJ4OVR6IMoT1MyAc
         mH3A==
X-Gm-Message-State: AOAM5319+m8FpUjfjnfxblfm+d4958mJjm5FhvAcy2QprLJwoaxSSekf
        uaJkPZ3jwTenWQCmcwNfINy4ew==
X-Google-Smtp-Source: ABdhPJwaIYqbEC+s/0vdTMgrMXWBSmGbRDU+ifItr1s/7q4wx1LdTHYZEmRHKIqq+QKb5MEnKXlUSw==
X-Received: by 2002:a05:620a:b02:: with SMTP id t2mr310169qkg.128.1617139811787;
        Tue, 30 Mar 2021 14:30:11 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id 131sm17707274qkl.74.2021.03.30.14.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 14:30:11 -0700 (PDT)
Date:   Tue, 30 Mar 2021 17:30:10 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Greg Thelen <gthelen@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>
Subject: Re: [RFC PATCH 00/15] Use obj_cgroup APIs to charge the LRU pages
Message-ID: <YGOYYgWbwiYlKmzV@cmpxchg.org>
References: <20210330101531.82752-1-songmuchun@bytedance.com>
 <CALvZod4xHNmTQMd+zg71s7uyXUHEfwnQ-zqRXSWphwi9RogeNg@mail.gmail.com>
 <YGN0141iu5HTGiNJ@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGN0141iu5HTGiNJ@carbon.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 11:58:31AM -0700, Roman Gushchin wrote:
> On Tue, Mar 30, 2021 at 11:34:11AM -0700, Shakeel Butt wrote:
> > On Tue, Mar 30, 2021 at 3:20 AM Muchun Song <songmuchun@bytedance.com> wrote:
> > >
> > > Since the following patchsets applied. All the kernel memory are charged
> > > with the new APIs of obj_cgroup.
> > >
> > >         [v17,00/19] The new cgroup slab memory controller
> > >         [v5,0/7] Use obj_cgroup APIs to charge kmem pages
> > >
> > > But user memory allocations (LRU pages) pinning memcgs for a long time -
> > > it exists at a larger scale and is causing recurring problems in the real
> > > world: page cache doesn't get reclaimed for a long time, or is used by the
> > > second, third, fourth, ... instance of the same job that was restarted into
> > > a new cgroup every time. Unreclaimable dying cgroups pile up, waste memory,
> > > and make page reclaim very inefficient.
> > >
> > > We can convert LRU pages and most other raw memcg pins to the objcg direction
> > > to fix this problem, and then the LRU pages will not pin the memcgs.
> > >
> > > This patchset aims to make the LRU pages to drop the reference to memory
> > > cgroup by using the APIs of obj_cgroup. Finally, we can see that the number
> > > of the dying cgroups will not increase if we run the following test script.
> > >
> > > ```bash
> > > #!/bin/bash
> > >
> > > cat /proc/cgroups | grep memory
> > >
> > > cd /sys/fs/cgroup/memory
> > >
> > > for i in range{1..500}
> > > do
> > >         mkdir test
> > >         echo $$ > test/cgroup.procs
> > >         sleep 60 &
> > >         echo $$ > cgroup.procs
> > >         echo `cat test/cgroup.procs` > cgroup.procs
> > >         rmdir test
> > > done
> > >
> > > cat /proc/cgroups | grep memory
> > > ```
> > >
> > > Patch 1 aims to fix page charging in page replacement.
> > > Patch 2-5 are code cleanup and simplification.
> > > Patch 6-15 convert LRU pages pin to the objcg direction.
> > 
> > The main concern I have with *just* reparenting LRU pages is that for
> > the long running systems, the root memcg will become a dumping ground.
> > In addition a job running multiple times on a machine will see
> > inconsistent memory usage if it re-accesses the file pages which were
> > reparented to the root memcg.
> 
> I agree, but also the reparenting is not the perfect thing in a combination
> with any memory protections (e.g. memory.low).
> 
> Imagine the following configuration:
> workload.slice
> - workload_gen_1.service   memory.min = 30G
> - workload_gen_2.service   memory.min = 30G
> - workload_gen_3.service   memory.min = 30G
>   ...
> 
> Parent cgroup and several generations of the child cgroup, protected by a memory.low.
> Once the memory is getting reparented, it's not protected anymore.

That doesn't sound right.

A deleted cgroup today exerts no control over its abandoned
pages. css_reset() will blow out any control settings.

If you're talking about protection previously inherited by
workload.slice, that continues to apply as it always has.

None of this is really accidental. Per definition the workload.slice
control domain includes workload_gen_1.service. And per definition,
the workload_gen_1.service domain ceases to exist when you delete it.

There are no (or shouldn't be any!) semantic changes from the physical
unlinking from a dead control domain.

> Also, I'm somewhat concerned about the interaction of the reparenting
> with the writeback and dirty throttling. How does it work together?

What interaction specifically?

When you delete a cgroup that had both the block and the memory
controller enabled, the control domain of both goes away and it
becomes subject to whatever control domain is above it (if any).

A higher control domain in turn takes a recursive view of the subtree,
see mem_cgroup_wb_stats(), so when control is exerted, it applies
regardless of how and where pages are physically linked in children.

It's also already possible to enable e.g. block control only at a very
high level and memory control down to a lower level. Per design this
code can live with different domain sizes for memory and block.
