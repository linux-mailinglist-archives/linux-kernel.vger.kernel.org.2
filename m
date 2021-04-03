Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E0C3532C1
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 07:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234205AbhDCFrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 01:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbhDCFro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 01:47:44 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F20C0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 22:47:42 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id ha17so3590298pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 22:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V+wFWYRFis43GOTN2XRu8TgjxNZOmO8IgF4gRsiv9cA=;
        b=pMd1FbuvZ5E2fr1ocmyqnh+uLdNieVu/k08bIWoaWboRu1GuMhWuxbxzopnRIIA9lc
         zKwlsLoFQIrvZO9+Oo5f16yHnpzmH+iue6MrfQZ68f+gsl7xZ5h4aANWgAt4AjBkOBIn
         LczolwaRoieF168IcrjESxGMivxeYdlo7Pm9SyQ/si7aRk4o9K2fQKJkVd7bDtift8BP
         irNQU99mPX+t2pMHMjigsm8Gc9ruDFKeFl/YCvdAbROCuItCoolqDlnbbTsjNsM8SmMt
         RqMuLSmnqc5b8HrGIBHt14Fxr9KQXLtRLhBl5pAV9AM5fVsGMKr2+SMyr/9c/sjy9u4c
         nEdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V+wFWYRFis43GOTN2XRu8TgjxNZOmO8IgF4gRsiv9cA=;
        b=Fz0gkI6nwoD3AtPQBsbYHh+6LXk3MMf/UCsK0BBPYx3uZNgeC9gmIiwOIi+mG64MMG
         qYocvISpoDV3zMazsT9uqisbwXnuS8mZkikFVMWS4gs6pd8CUdzLcnGY2TGvW/4+irnb
         M/SVlCuf7byca03sD53e5D/yVlESTpx0dZy9rWfXzjlq4zZCC4N8Dp6ptOMFhjw7mQOH
         pO9lX90XakY1f/d64QdE/uSO56AnYkXt5cVwqemItkZ/tRoGx5xq28ACcSRlR/OYFH/p
         mfPQAP5vAUc1RbL08hH7xNVfx/kvBtDQppfhfqTgkvYi0jNzDymw9MBG/wKr7ui7AbWp
         BPJg==
X-Gm-Message-State: AOAM532acpdw0F5iN1UTAKJEftjEJvFBc7e2R11vw1YRxquI80Kgnswm
        UsIbBZsmTJ5LlNp9W6JjZDDs9UbRgXKr9NUD9JcoiA==
X-Google-Smtp-Source: ABdhPJzihZ9i7xdyKbcp25Pn/HT4uvsaH7n4VpVPtgIcyATKoF8snXQWFtthCIKS1/pr04vA/PHK/n8U/ZaD5DfL31I=
X-Received: by 2002:a17:90a:d991:: with SMTP id d17mr16762991pjv.229.1617428862110;
 Fri, 02 Apr 2021 22:47:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210402191638.3249835-1-schatzberg.dan@gmail.com> <20210402191638.3249835-3-schatzberg.dan@gmail.com>
In-Reply-To: <20210402191638.3249835-3-schatzberg.dan@gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Sat, 3 Apr 2021 13:47:05 +0800
Message-ID: <CAMZfGtVwxo-UMq8RD_2hpLAbhhYzSkDi_J7kQOJ3yzFz=-5USQ@mail.gmail.com>
Subject: Re: [External] [PATCH 2/3] mm: Charge active memcg when no mm is set
To:     Dan Schatzberg <schatzberg.dan@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>, Yang Shi <shy828301@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        Chris Down <chris@chrisdown.name>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 3, 2021 at 3:17 AM Dan Schatzberg <schatzberg.dan@gmail.com> wrote:
>
> set_active_memcg() worked for kernel allocations but was silently
> ignored for user pages.
>
> This patch establishes a precedence order for who gets charged:
>
> 1. If there is a memcg associated with the page already, that memcg is
>    charged. This happens during swapin.
>
> 2. If an explicit mm is passed, mm->memcg is charged. This happens
>    during page faults, which can be triggered in remote VMs (eg gup).
>
> 3. Otherwise consult the current process context. If there is an
>    active_memcg, use that. Otherwise, current->mm->memcg.
>
> Previously, if a NULL mm was passed to mem_cgroup_charge (case 3) it
> would always charge the root cgroup. Now it looks up the active_memcg
> first (falling back to charging the root cgroup if not set).
>
> Signed-off-by: Dan Schatzberg <schatzberg.dan@gmail.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Acked-by: Tejun Heo <tj@kernel.org>
> Acked-by: Chris Down <chris@chrisdown.name>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
