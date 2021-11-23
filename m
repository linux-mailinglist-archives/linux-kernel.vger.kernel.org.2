Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7124599A5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 02:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbhKWBYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 20:24:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbhKWBYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 20:24:19 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F58C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 17:21:12 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id i63so7684999lji.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 17:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PZNVY9+03dEFejIwzLUj2PbaiVC1vy5FYIvkJizW4dQ=;
        b=CUvfp14TbL49LRiKzGVqTH2EYU63uY6IsAJcq5kvTwhdkLT5s1JIargoRqeM6fpkEm
         LFMO5UIM+oAVs07AlSdrpr5zZIJmQHqSz8d0xEHXO/6QkDzo2z7WN70mjVjOSjDPrQzj
         v3HALSn4twgfz2FdbNk6l4GBYfoaMWqi/YiSJ/Fu6tYQbVh5242dK3h+mJBxSnXlALUV
         uJO/eIlyVe5K1AjcEK8oqYVhOKsxWw0R5zowd15VsE7pqg/H2BnP7l9Twy/g6NY9H9HM
         TVNK7fFUbOP58/IGQeb+O9qHIHzn6fBXcmTk/GnDSf2zcFbrx8fsb+UEJrCrSF06DywY
         hIOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PZNVY9+03dEFejIwzLUj2PbaiVC1vy5FYIvkJizW4dQ=;
        b=vE7GEbDIun4Nq57hQnEyYsSO2zB12f7//mUBrC03MuglO4YB76qjJVrJ6WwnmWbTty
         lkrg5e73tN8/KJdLXElN+cImQhj8LMehF9czXZTOjezksNW0NcUQIslRXiv979pROYk1
         ry0gy/ZLRqOYhsGdTXZ+B8t+DYPZ+YT3CMSzGlhXabcTvCmtijO/pc0KmIFt3QEyI0nm
         BclToC7k9KH06ABDNL2SHeAIiHZNVOmVWdUmPeWQSb+ZjuhSRG7Hwj9au1//osqiJ0oU
         SbuNRBiMmSXG9nzC/xFS6M0ZCOr5ucY7kvo8oBLABiFajDxEjLvv1DRuWrHVQ4sP0YoN
         9IZg==
X-Gm-Message-State: AOAM53092bdO/N/7ZOjxnZyZmo7vE9Ra4I1zkLzqMzjzH0qwMoh+PB47
        haY4ibnh5MqF1zmH/90oyMnY0E7qkyBw/NuBDcxFIg==
X-Google-Smtp-Source: ABdhPJzdBbddli4+dHgpML9E8V8zH8wRcIUvFDly89JkVjxpJyrwxoG82YtIxjNz4+uZvgEakw7l+ou6zPMFsmdliKM=
X-Received: by 2002:a05:651c:545:: with SMTP id q5mr833343ljp.202.1637630470541;
 Mon, 22 Nov 2021 17:21:10 -0800 (PST)
MIME-Version: 1.0
References: <20211123001020.4083653-1-almasrymina@google.com>
In-Reply-To: <20211123001020.4083653-1-almasrymina@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 22 Nov 2021 17:20:59 -0800
Message-ID: <CALvZod6gy6HNq5zmjwpOfG2K5RwCDnyBEPBr1wK8H6nk77UM9A@mail.gmail.com>
Subject: Re: [PATCH v8] hugetlb: Add hugetlb.*.numa_stat file
To:     Mina Almasry <almasrymina@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Rientjes <rientjes@google.com>,
        Jue Wang <juew@google.com>, Yang Yao <ygyao@google.com>,
        Joanna Li <joannali@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2021 at 4:10 PM Mina Almasry <almasrymina@google.com> wrote=
:
>
> For hugetlb backed jobs/VMs it's critical to understand the numa
> information for the memory backing these jobs to deliver optimal
> performance.
>
> Currently this technically can be queried from /proc/self/numa_maps, but
> there are significant issues with that. Namely:
> 1. Memory can be mapped or unmapped.
> 2. numa_maps are per process and need to be aggregated across all
>    processes in the cgroup. For shared memory this is more involved as
>    the userspace needs to make sure it doesn't double count shared
>    mappings.
> 3. I believe querying numa_maps needs to hold the mmap_lock which adds
>    to the contention on this lock.
>
> For these reasons I propose simply adding hugetlb.*.numa_stat file,
> which shows the numa information of the cgroup similarly to
> memory.numa_stat.
>
> On cgroup-v2:
>    cat /sys/fs/cgroup/unified/test/hugetlb.2MB.numa_stat
>    total=3D2097152 N0=3D2097152 N1=3D0
>
> On cgroup-v1:
>    cat /sys/fs/cgroup/hugetlb/test/hugetlb.2MB.numa_stat
>    total=3D2097152 N0=3D2097152 N1=3D0
>    hierarichal_total=3D2097152 N0=3D2097152 N1=3D0
>
> This patch was tested manually by allocating hugetlb memory and querying
> the hugetlb.*.numa_stat file of the cgroup and its parents.
> =EF=BF=BC
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Miaohe Lin <linmiaohe@huawei.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Muchun Song <songmuchun@bytedance.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Jue Wang <juew@google.com>
> Cc: Yang Yao <ygyao@google.com>
> Cc: Joanna Li <joannali@google.com>
> Cc: Cannon Matthews <cannonmatthews@google.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
