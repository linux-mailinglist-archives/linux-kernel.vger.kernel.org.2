Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E92F044D010
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 03:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbhKKCjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 21:39:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233061AbhKKCjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 21:39:46 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E50C061766
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 18:36:57 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id 131so11392557ybc.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 18:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NqctALwMz4c+px2fGda2fQ0bf3yBC/4iDfvjem4l/kQ=;
        b=mWByVKqSmeYdggMqp+elJHoij/9RHfl/7mHDpsXDmQkVNRHdnG65lrh3s9/8+2Dd/R
         Wv2kELS1xvLjot1c1BWvssTMD8EcGmQg1ns2/P0IoTwwByUOD/zBMSPwILtmaYGDE4nK
         FXXNM7a3FndZAomXcKWnaRQMZ+/L0U8wTD+EnW7d4T7iVzImCtRLB7GsrPm4v4/1lUT6
         Na4z6j+LbY9QwpVJgzLSYow+ihmi10yPIKJ2mycy8sOHiM2iGvmKDBciVjpBzcg3CsWY
         6t3dzOh+ozcxj0a5m9L5YoLnbihSc5MSO6btDGDpBize8iunnZ+oluw8fPNaMVG20/Wm
         HUBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NqctALwMz4c+px2fGda2fQ0bf3yBC/4iDfvjem4l/kQ=;
        b=WlPfkP6RXzJ9gOEzVcklH6LSSCYSPbvNN9Nkw44AP25ocwGVEKLaSg1pLy3QOXjdtj
         cI0RdkMenlfmHQFviP03brUZJzAMmBuXYNztm/MG03bTwOpoBsfcVpR8O89QlVeTQrTP
         hv53QeZ12blSIHAZTxsoxFNuvCf7VdYqiPXDaKIkrPMVZQ4lm7ThEYBVK5aGzUmt1v2M
         tOQ+I2tE+9PhaLqoOBgJxGC40JPOSKdjIp2ZSNx6ZsSJ9zeg/rL5p3Y6Rsk7vUPG9SoE
         TpGn5r2up15j1+XsU+QbK3dWFFaMkv0qNDDY9B4OCMy5s9YpSeNNKp+U2C2YGlCOL6Im
         BQtg==
X-Gm-Message-State: AOAM532z4OBnHVQOZgPR6I/Xlc4ARZOp4Kif+O6LQQzkCirhJePs0EHI
        7P2aTzpwghyjXhBj9qxQR5XZtJInhfqFSHthQ7eozA==
X-Google-Smtp-Source: ABdhPJyHOm6Y4ULjM8ZgZDqdaUKlK/ybR/IFS8Rsc1lVKxANExzIIe2usY5PwMFzpu74QTqiu39euYf9Z5FNix5xGPg=
X-Received: by 2002:a25:b0a8:: with SMTP id f40mr4189292ybj.125.1636598216802;
 Wed, 10 Nov 2021 18:36:56 -0800 (PST)
MIME-Version: 1.0
References: <20211111015037.4092956-1-almasrymina@google.com>
In-Reply-To: <20211111015037.4092956-1-almasrymina@google.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 11 Nov 2021 10:36:20 +0800
Message-ID: <CAMZfGtWj5LU0ygDpH9B58R48kM8w3tnowQDD53VNMifSs5uvig@mail.gmail.com>
Subject: Re: [PATCH v6] hugetlb: Add hugetlb.*.numa_stat file
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

On Thu, Nov 11, 2021 at 9:50 AM Mina Almasry <almasrymina@google.com> wrote=
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
> ---
>
> Changes in v6:
> - Changed usage from unsigned long to atomic_long_t
>
> Changes in v5:
> - Fixed commit message typo.
> - Fixed per node usage documentation to be in pages.
> - Removed unnecessary h_cg check.
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
>  mm/hugetlb_cgroup.c                           | 118 ++++++++++++++++--
>  5 files changed, 127 insertions(+), 11 deletions(-)
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
> index c137396129db..13aa0210ff70 100644
> --- a/include/linux/hugetlb_cgroup.h
> +++ b/include/linux/hugetlb_cgroup.h
> @@ -36,6 +36,11 @@ enum hugetlb_memory_event {
>         HUGETLB_NR_MEMORY_EVENTS,
>  };
>
> +struct hugetlb_cgroup_per_node {
> +       /* hugetlb usage in pages over all hstates. */
> +       atomic_long_t usage[HUGE_MAX_HSTATE];

Why do you use atomic? IIUC, 'usage' is always
increased/decreased under hugetlb_lock except
hugetlb_cgroup_read_numa_stat() which is always
reading it. So I think WRITE_ONCE/READ_ONCE
is enough.

Thanks.

> +};
> +
>  struct hugetlb_cgroup {
>         struct cgroup_subsys_state css;
>
> @@ -57,6 +62,8 @@ struct hugetlb_cgroup {
>
>         /* Handle for "hugetlb.events.local" */
>         struct cgroup_file events_local_file[HUGE_MAX_HSTATE];
> +
> +       struct hugetlb_cgroup_per_node *nodeinfo[];
>  };
>
>  static inline struct hugetlb_cgroup *
> diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
> index 5383023d0cca..be1f25a9ba28 100644
> --- a/mm/hugetlb_cgroup.c
> +++ b/mm/hugetlb_cgroup.c
> @@ -126,29 +126,58 @@ static void hugetlb_cgroup_init(struct hugetlb_cgro=
up *h_cgroup,
>         }
>  }
>
> +static void hugetlb_cgroup_free(struct hugetlb_cgroup *h_cgroup)
> +{
> +       int node;
> +
> +       for_each_node(node)
> +               kfree(h_cgroup->nodeinfo[node]);
> +       kfree(h_cgroup);
> +}
> +
>  static struct cgroup_subsys_state *
>  hugetlb_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
>  {
>         struct hugetlb_cgroup *parent_h_cgroup =3D hugetlb_cgroup_from_cs=
s(parent_css);
>         struct hugetlb_cgroup *h_cgroup;
> +       int node;
> +
> +       h_cgroup =3D kzalloc(struct_size(h_cgroup, nodeinfo, nr_node_ids)=
,
> +                          GFP_KERNEL);
>
> -       h_cgroup =3D kzalloc(sizeof(*h_cgroup), GFP_KERNEL);
>         if (!h_cgroup)
>                 return ERR_PTR(-ENOMEM);
>
>         if (!parent_h_cgroup)
>                 root_h_cgroup =3D h_cgroup;
>
> +       /*
> +        * TODO: this routine can waste much memory for nodes which will
> +        * never be onlined. It's better to use memory hotplug callback
> +        * function.
> +        */
> +       for_each_node(node) {
> +               /* Set node_to_alloc to -1 for offline nodes. */
> +               int node_to_alloc =3D
> +                       node_state(node, N_NORMAL_MEMORY) ? node : -1;
> +               h_cgroup->nodeinfo[node] =3D
> +                       kzalloc_node(sizeof(struct hugetlb_cgroup_per_nod=
e),
> +                                    GFP_KERNEL, node_to_alloc);
> +               if (!h_cgroup->nodeinfo[node])
> +                       goto fail_alloc_nodeinfo;
> +       }
> +
>         hugetlb_cgroup_init(h_cgroup, parent_h_cgroup);
>         return &h_cgroup->css;
> +
> +fail_alloc_nodeinfo:
> +       hugetlb_cgroup_free(h_cgroup);
> +       return ERR_PTR(-ENOMEM);
>  }
>
>  static void hugetlb_cgroup_css_free(struct cgroup_subsys_state *css)
>  {
> -       struct hugetlb_cgroup *h_cgroup;
> -
> -       h_cgroup =3D hugetlb_cgroup_from_css(css);
> -       kfree(h_cgroup);
> +       hugetlb_cgroup_free(hugetlb_cgroup_from_css(css));
>  }
>
>  /*
> @@ -292,7 +321,9 @@ static void __hugetlb_cgroup_commit_charge(int idx, u=
nsigned long nr_pages,
>                 return;
>
>         __set_hugetlb_cgroup(page, h_cg, rsvd);
> -       return;
> +       if (!rsvd)
> +               atomic_long_add(nr_pages,
> +                               &h_cg->nodeinfo[page_to_nid(page)]->usage=
[idx]);
>  }
>
>  void hugetlb_cgroup_commit_charge(int idx, unsigned long nr_pages,
> @@ -331,7 +362,9 @@ static void __hugetlb_cgroup_uncharge_page(int idx, u=
nsigned long nr_pages,
>
>         if (rsvd)
>                 css_put(&h_cg->css);
> -
> +       else
> +               atomic_long_sub(nr_pages,
> +                               &h_cg->nodeinfo[page_to_nid(page)]->usage=
[idx]);
>         return;

Could you remove "return" by the way?

>  }
>
> @@ -421,6 +454,61 @@ enum {
>         RES_RSVD_FAILCNT,
>  };
>
> +static int hugetlb_cgroup_read_numa_stat(struct seq_file *seq, void *dum=
my)
> +{
> +       int nid;
> +       struct cftype *cft =3D seq_cft(seq);
> +       int idx =3D MEMFILE_IDX(cft->private);
> +       bool legacy =3D MEMFILE_ATTR(cft->private);
> +       struct hugetlb_cgroup *h_cg =3D hugetlb_cgroup_from_css(seq_css(s=
eq));
> +       struct cgroup_subsys_state *css;
> +       unsigned long usage;
> +
> +       if (legacy) {
> +               /* Add up usage across all nodes for the non-hierarchical=
 total. */
> +               usage =3D 0;
> +               for_each_node_state(nid, N_MEMORY)
> +                       usage +=3D atomic_long_read(
> +                               &h_cg->nodeinfo[nid]->usage[idx]);
> +               seq_printf(seq, "total=3D%lu", usage * PAGE_SIZE);
> +
> +               /* Simply print the per-node usage for the non-hierarchic=
al total. */
> +               for_each_node_state(nid, N_MEMORY)
> +                       seq_printf(seq, " N%d=3D%lu", nid,
> +                                  atomic_long_read(
> +                                          &h_cg->nodeinfo[nid]->usage[id=
x]) *
> +                                          PAGE_SIZE);
> +               seq_putc(seq, '\n');
> +       }
> +
> +       /*
> +        * The hierarchical total is pretty much the value recorded by th=
e
> +        * counter, so use that.
> +        */
> +       seq_printf(seq, "%stotal=3D%lu", legacy ? "hierarichal_" : "",
> +                  page_counter_read(&h_cg->hugepage[idx]) * PAGE_SIZE);
> +
> +       /*
> +        * For each node, transverse the css tree to obtain the hierarich=
al
> +        * node usage.
> +        */
> +       for_each_node_state(nid, N_MEMORY) {
> +               usage =3D 0;
> +               rcu_read_lock();
> +               css_for_each_descendant_pre(css, &h_cg->css) {
> +                       usage +=3D atomic_long_read(&hugetlb_cgroup_from_=
css(css)
> +                                                          ->nodeinfo[nid=
]
> +                                                          ->usage[idx]);
> +               }
> +               rcu_read_unlock();
> +               seq_printf(seq, " N%d=3D%lu", nid, usage * PAGE_SIZE);
> +       }
> +
> +       seq_putc(seq, '\n');
> +
> +       return 0;
> +}
> +
>  static u64 hugetlb_cgroup_read_u64(struct cgroup_subsys_state *css,
>                                    struct cftype *cft)
>  {
> @@ -671,8 +759,14 @@ static void __init __hugetlb_cgroup_file_dfl_init(in=
t idx)
>                                     events_local_file[idx]);
>         cft->flags =3D CFTYPE_NOT_ON_ROOT;
>
> -       /* NULL terminate the last cft */
> +       /* Add the numa stat file */
>         cft =3D &h->cgroup_files_dfl[6];
> +       snprintf(cft->name, MAX_CFTYPE_NAME, "%s.numa_stat", buf);
> +       cft->seq_show =3D hugetlb_cgroup_read_numa_stat;
> +       cft->flags =3D CFTYPE_NOT_ON_ROOT;
> +
> +       /* NULL terminate the last cft */
> +       cft =3D &h->cgroup_files_dfl[7];
>         memset(cft, 0, sizeof(*cft));
>
>         WARN_ON(cgroup_add_dfl_cftypes(&hugetlb_cgrp_subsys,
> @@ -742,8 +836,14 @@ static void __init __hugetlb_cgroup_file_legacy_init=
(int idx)
>         cft->write =3D hugetlb_cgroup_reset;
>         cft->read_u64 =3D hugetlb_cgroup_read_u64;
>
> +       /* Add the numa stat file */
> +       cft =3D &h->cgroup_files_dfl[8];
> +       snprintf(cft->name, MAX_CFTYPE_NAME, "%s.numa_stat", buf);
> +       cft->private =3D MEMFILE_PRIVATE(idx, 1);
> +       cft->seq_show =3D hugetlb_cgroup_read_numa_stat;
> +
>         /* NULL terminate the last cft */
> -       cft =3D &h->cgroup_files_legacy[8];
> +       cft =3D &h->cgroup_files_legacy[9];
>         memset(cft, 0, sizeof(*cft));
>
>         WARN_ON(cgroup_add_legacy_cftypes(&hugetlb_cgrp_subsys,
> --
> 2.34.0.rc0.344.g81b53c2807-goog
