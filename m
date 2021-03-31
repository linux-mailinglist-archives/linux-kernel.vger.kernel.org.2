Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E819A34F57A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 02:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbhCaA2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 20:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbhCaA2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 20:28:20 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91D5C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 17:28:19 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id b4so26486313lfi.6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 17:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1cv7lLfghP1Iplp/hAe0FKDdnNBVuJ0m8vGvM7Ky2GY=;
        b=LUWalD0ZKI8m3/8ws2U1R9cKhzvVEE8ZXL1jnnHaRB0hPlC9XelvwMiaO4hEl/m186
         VaLaI9FB38PWu1TJYiNcmHWicQPvp0uG3d2nQXMyL7n8PGVKo8ZEgiZ//KNP9zzw0oz5
         x3POwWHcxIHM33aAQRSTBodiW3OBXjAYhb0KthStXZr6a1SrqNSovgG3J/iftaUkzy92
         G4VqcHdmQKZqwqLWdPUanSmXutoaOC/c/ttM3WUD7ZdlelCAWQ6nb1Pn4NI31qR/QnK/
         9bWdAm8/gFGRvCByS6ykpBfJlZBpdut0c9fPbNrKNwJqT9uphY4eQsPhdGmHdIAkPy2p
         XD4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1cv7lLfghP1Iplp/hAe0FKDdnNBVuJ0m8vGvM7Ky2GY=;
        b=rwqxvySqbWcm51C2SPyLm4Kv1P1qq1tvwMOD7tjGSJHCMlFPeWTeDxDtAxrkbrMoma
         xL0V5mEZyfKkk/NCAP+bgfInEmTwvJ94fqw7r56BJ/Mhg55vsVeFF4Py0VFLShvQEtHT
         oAd0yz14qJOg/qs/zwunrkB51dxd8aHILXZPFN2A/3qPWm876fdJByFw0BepBEMEM++Z
         G7ry4tmLMIOb7q2TAMmkGX5U3Hm2hWgovc2lPn/ijqu94g/Rl5rtv50+00xgtS+r16WA
         dd4riZpMzHCkIvAYbiJVsC66gASe5x61TEfupl2IEiOvMAmv0yV+nYeTP2Iv4Q4CpWRi
         5mEg==
X-Gm-Message-State: AOAM532tagpBflMQI4kVMHhGnMiLysqaXCdTsUlIiJy0xRSgn/vmigIU
        2jOWYXfcKbq1dp1zeb8M0jR/x8A6HvJrcCInX08PbA==
X-Google-Smtp-Source: ABdhPJyxesGnlIEAzu+klNre9N8aN6gRtEWSNL9sbHRRtHrhdTo5FEe7AgGTZdu4xQndQZX8OgrKnIY0GN/M3c2Y34A=
X-Received: by 2002:a19:e0d:: with SMTP id 13mr458683lfo.549.1617150498014;
 Tue, 30 Mar 2021 17:28:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210330101531.82752-1-songmuchun@bytedance.com>
 <CALvZod4xHNmTQMd+zg71s7uyXUHEfwnQ-zqRXSWphwi9RogeNg@mail.gmail.com> <YGOTrAf5bRBRJaBP@cmpxchg.org>
In-Reply-To: <YGOTrAf5bRBRJaBP@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 30 Mar 2021 17:28:06 -0700
Message-ID: <CALvZod6zOUBBBbEcAxbYxDgwGUwtZht8EhB_ygm25bAsssZj5Q@mail.gmail.com>
Subject: Re: [RFC PATCH 00/15] Use obj_cgroup APIs to charge the LRU pages
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Greg Thelen <gthelen@google.com>, Roman Gushchin <guro@fb.com>,
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

On Tue, Mar 30, 2021 at 2:10 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
[...]
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

Indeed you are right. Even if the physical representation of the tree
has changed, the logical picture remains the same.

[Subconsciously I was sad that we will lose the information about the
origin memcg of the page for debugging purposes but then I thought if
we really need it then we can just add that metadata in the obj_cgroup
object. So, never mind.]

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

We didn't really have any issue regarding CPU or IO but that might be
due to our unique setup (i.e. no local disk).

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

I was bundling the scenario you mentioned with (2) i.e. the filesystem
persists across multiple subsequent instances of the same job.

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

I will give more thought on this idea and see where it goes.

>
> But again, this is a useful discussion to have, but I don't quite see
> why it's relevant to Muchun's patches. They're purely an optimization.
>
> So I'd like to clear that up first before going further.

I think we are on the same page i.e. these patches change the physical
representation of the memcg tree but logically it remains the same and
fixes the zombie memcg issue.
