Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA82544BBAC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 07:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbhKJGbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 01:31:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbhKJGbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 01:31:09 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722FEC061766
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 22:28:22 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id q74so3718960ybq.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 22:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AyFThLvs6UKw51gxhNX63dY3arYNMwAczrnoeEvicwM=;
        b=zmLZ5Ns3XHuwD2JA3cwajolo6nj4tD86lMFefSH0AgKDjQ/Ygjz6KXhxkdV6ar09WP
         QWb1LvLCmPn2l24KzVKS8n4GXntRuWkomu+r6x0QDPgEg3VreGKclK34hIZxEJU+F7h7
         omfRnLdJMPjaGluYhdCRLWUTyO5HkzT3Ax6qWtfnkjr52gn8tzfOUWCsqZeFvgkayjDL
         kAXoEqFssJXYRknpebP+VCL+q74N+RjkEdYmQs7//3znXMbT6UQ30nzedl+ETmKM0T9D
         iexQfz9yNPGjhoh/Wc9A1zR4/brxWOgCBnPLy22qREapoyXZ1Q5bb/ghjwjvhhZrHWUQ
         v6OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AyFThLvs6UKw51gxhNX63dY3arYNMwAczrnoeEvicwM=;
        b=YTZyjSfKDG7pO/h/pGNIDt0aM8TsMTasN3a/PArNhKMRCYbTRJKSPjHhsHDW8HLZDE
         gZ2so0i9w10JdvGMgI3Q5NG0uN4UTKaPS9tYyBoc6N2uo42rLQbYy8ric8yLqKCMtr3F
         aVi5i/ZW4RFwDSx+XMecJyUqxfIQ5Xw4dj+jNbV1OUQuyp9+BVjrxf6k2kLGuNUPEbAu
         aQRXKn18V5zsK4g5SoMENs3cHFyO7/KUbvj6f+HZmhJ9G5GfXkEyiIzXywMk9ztHez/6
         rQeBntHIEvVjVE6MNQBxzzEog9stsBmRJmSjq5tukDLiPS/GzXIWPePUz8vVDjEZkC2o
         qQuA==
X-Gm-Message-State: AOAM530nFNxby0fpd8PhUglPMnc9e4+QurnqiEb0m+qJhcBIKCwYpdGH
        WkiezGx1YtpTtdO0kTDCgpg4j5qMfoCr/88C6b2pTg==
X-Google-Smtp-Source: ABdhPJwC7qskfs7QwZHbFyDxilMDue9zV6YG5pMGj0/sEbIADyRB1Y6lEadH5n/8f/+S7jw3uQGIC6W8cxVFJInuzyY=
X-Received: by 2002:a5b:648:: with SMTP id o8mr16035315ybq.208.1636525701723;
 Tue, 09 Nov 2021 22:28:21 -0800 (PST)
MIME-Version: 1.0
References: <20211108210456.1745788-1-almasrymina@google.com>
In-Reply-To: <20211108210456.1745788-1-almasrymina@google.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 10 Nov 2021 14:27:43 +0800
Message-ID: <CAMZfGtUs6JHg7j2jQHkdywDVFXRzQTTH-ObVfDTLN90yfbKnpA@mail.gmail.com>
Subject: Re: [PATCH v4] hugetlb: Add hugetlb.*.numa_stat file
To:     Mina Almasry <almasrymina@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>, Jue Wang <juew@google.com>,
        Yang Yao <ygyao@google.com>, Joanna Li <joannali@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 9, 2021 at 5:04 AM Mina Almasry <almasrymina@google.com> wrote:
>
> For hugetlb backed jobs/VMs it's critical to understand the numa
> information for the memory backing these jobs to deliver optimal
> performance.
>
> Currently this technically can be queried from /proc/self/numa_maps, but
> there are significant issues with that. Namely:
> 1. Memory can be mapped on unmapped.
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
> ---
>
> Changes in v4:
> - Removed unnecessary braces.
> - usage is now counted in pages instead of bytes.
> - Reverted unneeded changes to write_to_hugetlbfs.c
>
> Changes in v3:
> - Fixed typos (sorry!)
> - Used conventional locations for cgroups mount points in docs/commit
> message.
> - Updated docs.
> - Handle kzalloc_node failure, and proper deallocation of per node data.
> - Use struct_size() to calculate the struct size.
> - Use nr_node_ids instead of MAX_NUMNODES.
> - Updated comments per multi-line comment pattern.
>
> Changes in v2:
> - Fix warning Reported-by: kernel test robot <lkp@intel.com>
> ---
>  .../admin-guide/cgroup-v1/hugetlb.rst         |   4 +
>  Documentation/admin-guide/cgroup-v2.rst       |   5 +
>  include/linux/hugetlb.h                       |   4 +-
>  include/linux/hugetlb_cgroup.h                |   7 ++
>  mm/hugetlb_cgroup.c                           | 113 ++++++++++++++++--
>  5 files changed, 122 insertions(+), 11 deletions(-)
>
> diff --git a/Documentation/admin-guide/cgroup-v1/hugetlb.rst b/Documentat=
ion/admin-guide/cgroup-v1/hugetlb.rst
> index 338f2c7d7a1c..0fa724d82abb 100644
> --- a/Documentation/admin-guide/cgroup-v1/hugetlb.rst
> +++ b/Documentation/admin-guide/cgroup-v1/hugetlb.rst
> @@ -29,12 +29,14 @@ Brief summary of control files::
>   hugetlb.<hugepagesize>.max_usage_in_bytes             # show max "hugep=
agesize" hugetlb  usage recorded
>   hugetlb.<hugepagesize>.usage_in_bytes                 # show current us=
age for "hugepagesize" hugetlb
>   hugetlb.<hugepagesize>.failcnt                        # show the number=
 of allocation failure due to HugeTLB usage limit
> + hugetlb.<hugepagesize>.numa_stat                      # show the numa i=
nformation of the hugetlb memory charged to this cgroup
>
>  For a system supporting three hugepage sizes (64k, 32M and 1G), the cont=
rol
>  files include::
>
>    hugetlb.1GB.limit_in_bytes
>    hugetlb.1GB.max_usage_in_bytes
> +  hugetlb.1GB.numa_stat
>    hugetlb.1GB.usage_in_bytes
>    hugetlb.1GB.failcnt
>    hugetlb.1GB.rsvd.limit_in_bytes
> @@ -43,6 +45,7 @@ files include::
>    hugetlb.1GB.rsvd.failcnt
>    hugetlb.64KB.limit_in_bytes
>    hugetlb.64KB.max_usage_in_bytes
> +  hugetlb.64KB.numa_stat
>    hugetlb.64KB.usage_in_bytes
>    hugetlb.64KB.failcnt
>    hugetlb.64KB.rsvd.limit_in_bytes
> @@ -51,6 +54,7 @@ files include::
>    hugetlb.64KB.rsvd.failcnt
>    hugetlb.32MB.limit_in_bytes
>    hugetlb.32MB.max_usage_in_bytes
> +  hugetlb.32MB.numa_stat
>    hugetlb.32MB.usage_in_bytes
>    hugetlb.32MB.failcnt
>    hugetlb.32MB.rsvd.limit_in_bytes
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admi=
n-guide/cgroup-v2.rst
> index 4d8c27eca96b..356847f8f008 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -2252,6 +2252,11 @@ HugeTLB Interface Files
>         are local to the cgroup i.e. not hierarchical. The file modified =
event
>         generated on this file reflects only the local events.
>
> +  hugetlb.<hugepagesize>.numa_stat
> +       Similar to memory.numa_stat, it shows the numa information of the
> +        hugetlb pages of <hugepagesize> in this cgroup.  Only active in
> +        use hugetlb pages are included.  The per-node values are in byte=
s.
> +
>  Misc
>  ----
>
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 1faebe1cd0ed..0445faaa636e 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -613,8 +613,8 @@ struct hstate {
>  #endif
>  #ifdef CONFIG_CGROUP_HUGETLB
>         /* cgroup control files */
> -       struct cftype cgroup_files_dfl[7];
> -       struct cftype cgroup_files_legacy[9];
> +       struct cftype cgroup_files_dfl[8];
> +       struct cftype cgroup_files_legacy[10];
>  #endif
>         char name[HSTATE_NAME_LEN];
>  };
> diff --git a/include/linux/hugetlb_cgroup.h b/include/linux/hugetlb_cgrou=
p.h
> index c137396129db..54ff6ec68ed3 100644
> --- a/include/linux/hugetlb_cgroup.h
> +++ b/include/linux/hugetlb_cgroup.h
> @@ -36,6 +36,11 @@ enum hugetlb_memory_event {
>         HUGETLB_NR_MEMORY_EVENTS,
>  };
>
> +struct hugetlb_cgroup_per_node {
> +       /* hugetlb usage in bytes over all hstates. */

The accounting unit is pages not bytes here.

Thanks.
