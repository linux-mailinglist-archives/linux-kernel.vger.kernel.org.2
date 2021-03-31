Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB8F734F77B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 05:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbhCaD21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 23:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232805AbhCaD2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 23:28:12 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64586C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 20:28:12 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id ay2so7200240plb.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 20:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KpZFTK58noK2ltkaepu2d5l9k3Dz5epYTricp34oM+s=;
        b=mC6zVvuMtByCNHP//V7PPGK7wmAcQVtjcyEJ6ols7fnADsMWeZV9Kgl7hHQY6YPdmg
         jjyHp5CtXiwaT5J3jYM4fgqnTnckOY+9hUWVYNeHEmy+5QStbd2QqKJ2KJz2h2Gj4G56
         O/AJ9C1vfg7t/L38m60B3UGuffIMG2IjQUhBvxurSfzGeKpSIZ1OtLdX+nQT+kaU7bjg
         wcPM2hg9WMbBYM4NFWXYXZ6e+oNXKvO3O5qJglciV/ovznSH4FEO/coBjrnf2Pz5TJjX
         k0ityWuJdCjzzA3+AxULwWuwyEXQ86alssaPy5Q4B8gUFhlz8FWYJXnr2GRf6m3azafR
         u2MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KpZFTK58noK2ltkaepu2d5l9k3Dz5epYTricp34oM+s=;
        b=HohT0r46ifqxkHrIVU9Y/CWx2BTVixFUusDhhMDAHuI6bjS7ee9AWKXT+h1DZc4vKW
         kLeMiX7Y0Fb4kYBz3XsqLn2H82vFh54c5lAT/OihkBVsqqSL1qg55uwsfCGL/teDHajD
         20J11CPDJWaqyPpJN/ov4LMStyEqBKT9VLJBQL+Qz/yzJCqbyeYPIpVqX6Bh2Hc4ZJ9C
         1czD/iivkjRPyzKt5nm8aHonGxGDZ0ImjDrRpiK+NufGTV1eLHAj6C2GDMzux7OmgVVh
         nwqxR1B5zlBPwT79Dmm6lWLVrut9DDRTrkM4eCs+/p74m+oamWZlnwx9a/4+k4VDontu
         6HnQ==
X-Gm-Message-State: AOAM530tsLP0ukhC/ObxlSFKmsMU+h+bp3rbkNEAmKqfK9X9HH+o4Qgn
        3HQGO+C2AGkJCx+CzoNIy8E=
X-Google-Smtp-Source: ABdhPJxozyVB7ia2jTcVulLic2F04rt8esVUHVn2MHo3hZ/ZYSae5i1CG88Ev9ZnePMnvhSg5OOYpw==
X-Received: by 2002:a17:902:cf83:b029:e7:3751:f308 with SMTP id l3-20020a170902cf83b02900e73751f308mr1358252ply.17.1617161291755;
        Tue, 30 Mar 2021 20:28:11 -0700 (PDT)
Received: from localhost (121-45-173-48.tpgi.com.au. [121.45.173.48])
        by smtp.gmail.com with ESMTPSA id t3sm392798pfg.176.2021.03.30.20.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 20:28:10 -0700 (PDT)
Date:   Wed, 31 Mar 2021 14:28:07 +1100
From:   Balbir Singh <bsingharora@gmail.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Greg Thelen <gthelen@google.com>, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>
Subject: Re: [RFC PATCH 00/15] Use obj_cgroup APIs to charge the LRU pages
Message-ID: <20210331032807.GS77072@balbir-desktop>
References: <20210330101531.82752-1-songmuchun@bytedance.com>
 <CALvZod4xHNmTQMd+zg71s7uyXUHEfwnQ-zqRXSWphwi9RogeNg@mail.gmail.com>
 <YGOTrAf5bRBRJaBP@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGOTrAf5bRBRJaBP@cmpxchg.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 05:10:04PM -0400, Johannes Weiner wrote:
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
> I don't understand how Muchun's patches are supposed to *change* the
> behavior the way you are describing it. This IS today's behavior.
> 
> We have hierarchical accounting, and a page that belongs to a leaf
> cgroup will automatically belong to all its parents.
> 
> Further, if you delete a cgroup today, the abandoned cache will stay
> physically linked to that cgroup, but that zombie group no longer acts
> as a control structure: it imposes no limit and no protection; the
> pages will be reclaimed as if it WERE linked to the parent.
> 
> For all intents and purposes, when you delete a cgroup today, its
> remaining pages ARE dumped onto the parent.
> 
> The only difference is that today they pointlessly pin the leaf cgroup
> as a holding vessel - which is then round-robin'd from the parent
> during reclaim in order to pretend that all these child pages actually
> ARE linked to the parent's LRU list.
> 
> Remember how we used to have every page physically linked to multiple
> lrus? The leaf cgroup and the root?
> 
> All pages always belong to the (virtual) LRU list of all ancestor
> cgroups. The only thing Muchun changes is that they no longer pin a
> cgroup that has no semantical meaning anymore (because it's neither
> visible to the user nor exerts any contol over the pages anymore).
> 
> Maybe I'm missing something that either you or Roman can explain to
> me. But this series looks like a (rare) pure win.
> 
> Whether you like the current semantics is a separate discussion IMO.
> 
> > Please note that I do agree with the mentioned problem and we do see
> > this issue in our fleet. Internally we have a "memcg mount option"
> > feature which couples a file system with a memcg and all file pages
> > allocated on that file system will be charged to that memcg. Multiple
> > instances (concurrent or subsequent) of the job will use that file
> > system (with a dedicated memcg) without leaving the zombies behind. I
> > am not pushing for this solution as it comes with its own intricacies
> > (e.g. if memcg coupled with a file system has a limit, the oom
> > behavior would be awkward and therefore internally we don't put a
> > limit on such memcgs). Though I want this to be part of discussion.
> 
> Right, you disconnect memory from the tasks that are allocating it,
> and so you can't assign culpability when you need to.
> 
> OOM is one thing, but there are also CPU cycles and IO bandwidth
> consumed during reclaim.
> 
> > I think the underlying reasons behind this issue are:
> > 
> > 1) Filesystem shared by disjoint jobs.
> > 2) For job dedicated filesystems, the lifetime of the filesystem is
> > different from the lifetime of the job.
> 
> There is also the case of deleting a cgroup just to recreate it right
> after for the same job. Many job managers do this on restart right now
> - like systemd, and what we're using in our fleet. This seems
> avoidable by recycling a group for another instance of the same job.
> 
> Sharing is a more difficult discussion. If you access a page that you
> share with another cgroup, it may or may not be subject to your own or
> your buddy's memory limits. The only limit it is guaranteed to be
> subjected to is that of your parent. So One thing I could imagine is,
> instead of having a separate cgroup outside the hierarchy, we would
> reparent live pages the second they are accessed from a foreign
> cgroup. And reparent them until you reach the first common ancestor.
> 
> This way, when you mount a filesystem shared by two jobs, you can put
> them into a joint subtree, and the root level of this subtree captures
> all the memory (as well as the reclaim CPU and IO) used by the two
> jobs - the private portions and the shared portions - and doesn't make
> them the liability of jobs in the system that DON'T share the same fs.
> 
> But again, this is a useful discussion to have, but I don't quite see
> why it's relevant to Muchun's patches. They're purely an optimization.
> 
> So I'd like to clear that up first before going further.
>

I suspect a lot of the issue really is the lack of lockstepping
between a page (unmapped page cache) and the corresponding memcgroups
lifecycle. When we delete a memcgroup, we sort of lose accounting
(depending on the inheriting parent) and ideally we want to bring back
the accounting when the page is reused in a different cgroup (almost
like first touch). I would like to look at the patches and see if they
do solve the issue that leads to zombie cgroups hanging around. In my experience,
the combination of namespaces and number of cgroups (several of which could
be zombies), does not scale well.

Balbir Singh.
