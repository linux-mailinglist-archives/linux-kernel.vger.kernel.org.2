Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49FDC444D11
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 02:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbhKDBqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 21:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbhKDBqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 21:46:06 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89252C061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 18:43:29 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id r28so4022797pga.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 18:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Zu2L09NtxFlN1ySA5mYoaq0U+EJdR6jUGDLT7PYjGdw=;
        b=iBFLo8UHnTHtTFbzB5VPU6Wu2s5lLvAih9iC20lrbBuz45TP0mcA5JCZ0MmwhhInpr
         VMRIQoSqt0wbTVQ4nOHQ9JK2viXpNrm7QYwfEDbHJTC3MEDqw9jeWrO9gjhdBanGlOaO
         75QtwKS9fCXWiBG9bTg4AYOCwdg7+D2JTnVl6nC1s4nh36WLgSXbSahenRKSaRDGrtGR
         gOah1RkozIxZ/JFtwk2NKOXJEDX2GWZAfyMYu0w+7hYloqnefibQn9bS7BIb/2bbnIZa
         p6U6Pfeby6omTy/dVbrYKjAu+qxxKizo9GmWs6GJ5yTTlYaLGxBT8zs9AvcelsrwctV+
         v7YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Zu2L09NtxFlN1ySA5mYoaq0U+EJdR6jUGDLT7PYjGdw=;
        b=vCDpecAlIayvd9myRVIBsnMgkj7fP9GMAd8g5tzZ8MSc1HadqMAx0EwcRq6LgGDBGy
         FDUW9zSoAQq0aAi5gG6uhMHvcTu4pIestZIccXGC2iyq1UCIqo/wtuYG+RKUz9elTLUS
         PQGo8riPb5LIMrfPpbogJMYCk4IzJsVmtlxZdad6bmPCATJGI0oPGoj7YVNFnYeTBrME
         KcPWnnWvpgulV/ascB2+UcLIx2by50vWxpSCCzRvILmakmycuVcqZdRToAerlYz4mm5o
         stYh/07szGyb0xditWtrcLGOgbjLtAILNEL4xPx0JxaZTRfhl7g0YYJUD8fXpKERyq+C
         0Lkg==
X-Gm-Message-State: AOAM532NBdlN9kjPjsOvB1YfY9SIuR1Yn3A2G60cF7PUJF2/U/0mWKUh
        GxnudbTQYqQGkq60NjTe9YG7x7CTZRmmSiP6SpFRXg==
X-Google-Smtp-Source: ABdhPJypAMAHBEt+rmpPb2gTdoxbWgH7ogi5U5RrB6UuHYmN9ecv90VU+YOJ7dzZNiOh4fHooJrdoxB1g/DK9nsCiMM=
X-Received: by 2002:a62:77d5:0:b0:480:7025:396e with SMTP id
 s204-20020a6277d5000000b004807025396emr34788888pfc.21.1635990208733; Wed, 03
 Nov 2021 18:43:28 -0700 (PDT)
MIME-Version: 1.0
References: <20211020190952.2658759-1-almasrymina@google.com> <CAMZfGtUDZVMHOJ0VQ0UAG=f-7vs6km_=BY3gYVe-E2txGvURsA@mail.gmail.com>
In-Reply-To: <CAMZfGtUDZVMHOJ0VQ0UAG=f-7vs6km_=BY3gYVe-E2txGvURsA@mail.gmail.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Wed, 3 Nov 2021 18:43:17 -0700
Message-ID: <CAHS8izPHP54CP67Z-sz7Wzgqhq2++kePa_TLtvbP_9H2t7Pf6Q@mail.gmail.com>
Subject: Re: [PATCH v2] hugetlb: Add hugetlb.*.numa_stat file
To:     Muchun Song <songmuchun@bytedance.com>,
        Shakeel Butt <shakeelb@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Jue Wang <juew@google.com>, Yang Yao <ygyao@google.com>,
        Joanna Li <joannali@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 1, 2021 at 10:12 PM Muchun Song <songmuchun@bytedance.com> wrot=
e:
>
> On Thu, Oct 21, 2021 at 3:09 AM Mina Almasry <almasrymina@google.com> wro=
te:
> >
> > For hugetlb backed jobs/VMs it's critical to understand the numa
> > information for the memory backing these jobs to deliver optimal
> > performance.
> >
> > Currently this techinically can be queried from /proc/self/numa_maps, b=
ut
> > there are significant issues with that. Namely:
> > 1. Memory can be mapped on unmapped.
> > 2. numa_maps are per process and need to be aggregaged across all
> >    proceses in the cgroup. For shared memory this is more involved as
> >    the userspace needs to make sure it doesn't double count shared
> >    mappings.
> > 3. I believe querying numa_maps needs to hold the mmap_lock which adds
> >    to the contention on this lock.
> >
> > For these reasons I propose simply adding hugetlb.*.numa_stat file,
> > which shows the numa information of the cgroup similarly to
> > memory.numa_stat.
> >
> > On cgroup-v2:
> >    cat /dev/cgroup/memory/test/hugetlb.2MB.numa_stat
> >    total=3D2097152 N0=3D2097152 N1=3D0
> >
> > On cgroup-v1:
> >    cat /dev/cgroup/memory/test/hugetlb.2MB.numa_stat
> >    total=3D2097152 N0=3D2097152 N1=3D0
> >    hierarichal_total=3D2097152 N0=3D2097152 N1=3D0
> >
> > This patch was tested manually by allocating hugetlb memory and queryin=
g
> > the hugetlb.*.numa_stat file of the cgroup and its parents.
> > =EF=BF=BC
> > Cc: Mike Kravetz <mike.kravetz@oracle.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Shuah Khan <shuah@kernel.org>
> > Cc: Miaohe Lin <linmiaohe@huawei.com>
> > Cc: Oscar Salvador <osalvador@suse.de>
> > Cc: Michal Hocko <mhocko@suse.com>
> > Cc: Muchun Song <songmuchun@bytedance.com>
> > Cc: David Rientjes <rientjes@google.com>
> > Cc: Jue Wang <juew@google.com>
> > Cc: Yang Yao <ygyao@google.com>
> > Cc: Joanna Li <joannali@google.com>
> > Cc: Cannon Matthews <cannonmatthews@google.com>
> > Cc: linux-mm@kvack.org
> > Cc: linux-kernel@vger.kernel.org
> >
> > Signed-off-by: Mina Almasry <almasrymina@google.com>
> >

Thank you very much Mike and Muchun for the review. I've uploaded v3
with the fixes!

> > ---
> >
> > Changes in v2:
> > - Fix warning Reported-by: kernel test robot <lkp@intel.com>
> > ---
> >  .../admin-guide/cgroup-v1/hugetlb.rst         |  4 +
> >  Documentation/admin-guide/cgroup-v2.rst       |  7 ++
> >  include/linux/hugetlb.h                       |  4 +-
> >  include/linux/hugetlb_cgroup.h                |  7 ++
> >  mm/hugetlb_cgroup.c                           | 93 +++++++++++++++++--
> >  .../testing/selftests/vm/write_to_hugetlbfs.c |  9 +-
> >  6 files changed, 113 insertions(+), 11 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/cgroup-v1/hugetlb.rst b/Document=
ation/admin-guide/cgroup-v1/hugetlb.rst
> > index 338f2c7d7a1c..0fa724d82abb 100644
> > --- a/Documentation/admin-guide/cgroup-v1/hugetlb.rst
> > +++ b/Documentation/admin-guide/cgroup-v1/hugetlb.rst
> > @@ -29,12 +29,14 @@ Brief summary of control files::
> >   hugetlb.<hugepagesize>.max_usage_in_bytes             # show max "hug=
epagesize" hugetlb  usage recorded
> >   hugetlb.<hugepagesize>.usage_in_bytes                 # show current =
usage for "hugepagesize" hugetlb
> >   hugetlb.<hugepagesize>.failcnt                        # show the numb=
er of allocation failure due to HugeTLB usage limit
> > + hugetlb.<hugepagesize>.numa_stat                      # show the numa=
 information of the hugetlb memory charged to this cgroup
> >
> >  For a system supporting three hugepage sizes (64k, 32M and 1G), the co=
ntrol
> >  files include::
> >
> >    hugetlb.1GB.limit_in_bytes
> >    hugetlb.1GB.max_usage_in_bytes
> > +  hugetlb.1GB.numa_stat
> >    hugetlb.1GB.usage_in_bytes
> >    hugetlb.1GB.failcnt
> >    hugetlb.1GB.rsvd.limit_in_bytes
> > @@ -43,6 +45,7 @@ files include::
> >    hugetlb.1GB.rsvd.failcnt
> >    hugetlb.64KB.limit_in_bytes
> >    hugetlb.64KB.max_usage_in_bytes
> > +  hugetlb.64KB.numa_stat
> >    hugetlb.64KB.usage_in_bytes
> >    hugetlb.64KB.failcnt
> >    hugetlb.64KB.rsvd.limit_in_bytes
> > @@ -51,6 +54,7 @@ files include::
> >    hugetlb.64KB.rsvd.failcnt
> >    hugetlb.32MB.limit_in_bytes
> >    hugetlb.32MB.max_usage_in_bytes
> > +  hugetlb.32MB.numa_stat
> >    hugetlb.32MB.usage_in_bytes
> >    hugetlb.32MB.failcnt
> >    hugetlb.32MB.rsvd.limit_in_bytes
> > diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/ad=
min-guide/cgroup-v2.rst
> > index 4d8c27eca96b..8ba0d6aadd2c 100644
> > --- a/Documentation/admin-guide/cgroup-v2.rst
> > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > @@ -2252,6 +2252,13 @@ HugeTLB Interface Files
> >         are local to the cgroup i.e. not hierarchical. The file modifie=
d event
> >         generated on this file reflects only the local events.
> >
> > +  hugetlb.<hugepagesize>.numa_stat
> > +       Similar to memory.numa_stat, it shows the numa information of t=
he
> > +       memory in this cgroup:
> > +
> > +       /dev/cgroup/memory/test # cat hugetlb.2MB.numa_stat
> > +       total=3D0 N0=3D0 N1=3D0
> > +
> >  Misc
> >  ----
> >
> > diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> > index 1faebe1cd0ed..0445faaa636e 100644
> > --- a/include/linux/hugetlb.h
> > +++ b/include/linux/hugetlb.h
> > @@ -613,8 +613,8 @@ struct hstate {
> >  #endif
> >  #ifdef CONFIG_CGROUP_HUGETLB
> >         /* cgroup control files */
> > -       struct cftype cgroup_files_dfl[7];
> > -       struct cftype cgroup_files_legacy[9];
> > +       struct cftype cgroup_files_dfl[8];
> > +       struct cftype cgroup_files_legacy[10];
> >  #endif
> >         char name[HSTATE_NAME_LEN];
> >  };
> > diff --git a/include/linux/hugetlb_cgroup.h b/include/linux/hugetlb_cgr=
oup.h
> > index c137396129db..54ff6ec68ed3 100644
> > --- a/include/linux/hugetlb_cgroup.h
> > +++ b/include/linux/hugetlb_cgroup.h
> > @@ -36,6 +36,11 @@ enum hugetlb_memory_event {
> >         HUGETLB_NR_MEMORY_EVENTS,
> >  };
> >
> > +struct hugetlb_cgroup_per_node {
> > +       /* hugetlb usage in bytes over all hstates. */
> > +       unsigned long usage[HUGE_MAX_HSTATE];
> > +};
> > +
> >  struct hugetlb_cgroup {
> >         struct cgroup_subsys_state css;
> >
> > @@ -57,6 +62,8 @@ struct hugetlb_cgroup {
> >
> >         /* Handle for "hugetlb.events.local" */
> >         struct cgroup_file events_local_file[HUGE_MAX_HSTATE];
> > +
> > +       struct hugetlb_cgroup_per_node *nodeinfo[];
> >  };
> >
> >  static inline struct hugetlb_cgroup *
> > diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
> > index 5383023d0cca..4b807292f7e8 100644
> > --- a/mm/hugetlb_cgroup.c
> > +++ b/mm/hugetlb_cgroup.c
> > @@ -92,6 +92,7 @@ static void hugetlb_cgroup_init(struct hugetlb_cgroup=
 *h_cgroup,
> >                                 struct hugetlb_cgroup *parent_h_cgroup)
> >  {
> >         int idx;
> > +       int node;
> >
> >         for (idx =3D 0; idx < HUGE_MAX_HSTATE; idx++) {
> >                 struct page_counter *fault_parent =3D NULL;
> > @@ -124,6 +125,15 @@ static void hugetlb_cgroup_init(struct hugetlb_cgr=
oup *h_cgroup,
> >                         limit);
> >                 VM_BUG_ON(ret);
> >         }
> > +
> > +       for_each_node(node) {
> > +               /* Set node_to_alloc to -1 for offline nodes. */
> > +               int node_to_alloc =3D
> > +                       node_state(node, N_NORMAL_MEMORY) ? node : -1;
> > +               h_cgroup->nodeinfo[node] =3D
> > +                       kzalloc_node(sizeof(struct hugetlb_cgroup_per_n=
ode),
> > +                                    GFP_KERNEL, node_to_alloc);
> > +       }
> >  }
> >
> >  static struct cgroup_subsys_state *
> > @@ -132,7 +142,10 @@ hugetlb_cgroup_css_alloc(struct cgroup_subsys_stat=
e *parent_css)
> >         struct hugetlb_cgroup *parent_h_cgroup =3D hugetlb_cgroup_from_=
css(parent_css);
> >         struct hugetlb_cgroup *h_cgroup;
> >
> > -       h_cgroup =3D kzalloc(sizeof(*h_cgroup), GFP_KERNEL);
> > +       unsigned int size =3D
> > +               sizeof(*h_cgroup) +
> > +               MAX_NUMNODES * sizeof(struct hugetlb_cgroup_per_node *)=
;
> > +       h_cgroup =3D kzalloc(size, GFP_KERNEL);
>
> I recommend using struct_size() to calculate the allocated size like
> following.
>
>   h_cgroup =3D kzalloc(struct_size(h_cgroup, nodeinfo, MAX_NUMNODES), GFP=
_KERNEL);
>
> I also have a question, can't we replace MAX_NUMNODES with
> nr_node_ids here? In that case, we can save some memory.
>
> >         if (!h_cgroup)
> >                 return ERR_PTR(-ENOMEM);
> >
> > @@ -292,7 +305,9 @@ static void __hugetlb_cgroup_commit_charge(int idx,=
 unsigned long nr_pages,
> >                 return;
> >
> >         __set_hugetlb_cgroup(page, h_cg, rsvd);
> > -       return;
> > +       if (!rsvd && h_cg)
> > +               h_cg->nodeinfo[page_to_nid(page)]->usage[idx] +=3D nr_p=
ages
> > +                                                                << PAG=
E_SHIFT;
> >  }
> >
> >  void hugetlb_cgroup_commit_charge(int idx, unsigned long nr_pages,
> > @@ -331,7 +346,9 @@ static void __hugetlb_cgroup_uncharge_page(int idx,=
 unsigned long nr_pages,
> >
> >         if (rsvd)
> >                 css_put(&h_cg->css);
> > -
> > +       else
> > +               h_cg->nodeinfo[page_to_nid(page)]->usage[idx] -=3D nr_p=
ages
> > +                                                                << PAG=
E_SHIFT;
> >         return;
> >  }
> >
> > @@ -421,6 +438,56 @@ enum {
> >         RES_RSVD_FAILCNT,
> >  };
> >
> > +static int hugetlb_cgroup_read_numa_stat(struct seq_file *seq, void *d=
ummy)
> > +{
> > +       int nid;
> > +       struct cftype *cft =3D seq_cft(seq);
> > +       int idx =3D MEMFILE_IDX(cft->private);
> > +       bool legacy =3D MEMFILE_ATTR(cft->private);
> > +       struct hugetlb_cgroup *h_cg =3D hugetlb_cgroup_from_css(seq_css=
(seq));
> > +       struct cgroup_subsys_state *css;
> > +       unsigned long usage;
> > +
> > +       if (legacy) {
> > +               /* Add up usage across all nodes for the non-hierarchic=
al total. */
> > +               usage =3D 0;
> > +               for_each_node_state(nid, N_MEMORY)
> > +                       usage +=3D h_cg->nodeinfo[nid]->usage[idx];
> > +               seq_printf(seq, "total=3D%lu", usage);
> > +
> > +               /* Simply print the per-node usage for the non-hierarch=
ical total. */
> > +               for_each_node_state(nid, N_MEMORY)
> > +                       seq_printf(seq, " N%d=3D%lu", nid,
> > +                                  h_cg->nodeinfo[nid]->usage[idx]);
> > +               seq_putc(seq, '\n');
> > +       }
> > +
> > +       /* The hierarchical total is pretty much the value recorded by =
the
> > +        * counter, so use that.
> > +        */
>
> Please use the following pattern for multi-line comments.
>
> /*
>  * Comments.
>  */
>
> > +       seq_printf(seq, "%stotal=3D%lu", legacy ? "hierarichal_" : "",
> > +                  page_counter_read(&h_cg->hugepage[idx]) * PAGE_SIZE)=
;
> > +
> > +       /* For each node, transverse the css tree to obtain the hierari=
chal
> > +        * node usage.
> > +        */
>
> Same here.
>
> > +       for_each_node_state(nid, N_MEMORY) {
> > +               usage =3D 0;
> > +               rcu_read_lock();
> > +               css_for_each_descendant_pre(css, &h_cg->css) {
> > +                       usage +=3D hugetlb_cgroup_from_css(css)
> > +                                        ->nodeinfo[nid]
> > +                                        ->usage[idx];
> > +               }
> > +               rcu_read_unlock();
> > +               seq_printf(seq, " N%d=3D%lu", nid, usage);
> > +       }
> > +
> > +       seq_putc(seq, '\n');
> > +
> > +       return 0;
> > +}
> > +
> >  static u64 hugetlb_cgroup_read_u64(struct cgroup_subsys_state *css,
> >                                    struct cftype *cft)
> >  {
> > @@ -654,8 +721,14 @@ static void __init __hugetlb_cgroup_file_dfl_init(=
int idx)
> >         cft->seq_show =3D hugetlb_cgroup_read_u64_max;
> >         cft->flags =3D CFTYPE_NOT_ON_ROOT;
> >
> > -       /* Add the events file */
> > +       /* Add the numa stat file */
> >         cft =3D &h->cgroup_files_dfl[4];
>
> Why not use &h->cgroup_files_dfl[6] as a numa stat file?
> It could be simple just like you did in
> __hugetlb_cgroup_file_legacy_init().
>
> Thanks.
>
> > +       snprintf(cft->name, MAX_CFTYPE_NAME, "%s.numa_stat", buf);
> > +       cft->seq_show =3D hugetlb_cgroup_read_numa_stat;
> > +       cft->flags =3D CFTYPE_NOT_ON_ROOT;
> > +
> > +       /* Add the events file */
> > +       cft =3D &h->cgroup_files_dfl[5];
> >         snprintf(cft->name, MAX_CFTYPE_NAME, "%s.events", buf);
> >         cft->private =3D MEMFILE_PRIVATE(idx, 0);
> >         cft->seq_show =3D hugetlb_events_show;
> > @@ -663,7 +736,7 @@ static void __init __hugetlb_cgroup_file_dfl_init(i=
nt idx)
> >         cft->flags =3D CFTYPE_NOT_ON_ROOT;
> >
> >         /* Add the events.local file */
> > -       cft =3D &h->cgroup_files_dfl[5];
> > +       cft =3D &h->cgroup_files_dfl[6];
> >         snprintf(cft->name, MAX_CFTYPE_NAME, "%s.events.local", buf);
> >         cft->private =3D MEMFILE_PRIVATE(idx, 0);
> >         cft->seq_show =3D hugetlb_events_local_show;
> > @@ -672,7 +745,7 @@ static void __init __hugetlb_cgroup_file_dfl_init(i=
nt idx)
> >         cft->flags =3D CFTYPE_NOT_ON_ROOT;
> >
> >         /* NULL terminate the last cft */
> > -       cft =3D &h->cgroup_files_dfl[6];
> > +       cft =3D &h->cgroup_files_dfl[7];
> >         memset(cft, 0, sizeof(*cft));
> >
> >         WARN_ON(cgroup_add_dfl_cftypes(&hugetlb_cgrp_subsys,
> > @@ -742,8 +815,14 @@ static void __init __hugetlb_cgroup_file_legacy_in=
it(int idx)
> >         cft->write =3D hugetlb_cgroup_reset;
> >         cft->read_u64 =3D hugetlb_cgroup_read_u64;
> >
> > +       /* Add the numa stat file */
> > +       cft =3D &h->cgroup_files_dfl[8];
> > +       snprintf(cft->name, MAX_CFTYPE_NAME, "%s.numa_stat", buf);
> > +       cft->private =3D MEMFILE_PRIVATE(idx, 1);
> > +       cft->seq_show =3D hugetlb_cgroup_read_numa_stat;
> > +
> >         /* NULL terminate the last cft */
> > -       cft =3D &h->cgroup_files_legacy[8];
> > +       cft =3D &h->cgroup_files_legacy[9];
> >         memset(cft, 0, sizeof(*cft));
> >
> >         WARN_ON(cgroup_add_legacy_cftypes(&hugetlb_cgrp_subsys,
> > diff --git a/tools/testing/selftests/vm/write_to_hugetlbfs.c b/tools/te=
sting/selftests/vm/write_to_hugetlbfs.c
> > index 6a2caba19ee1..d2da6315a40c 100644
> > --- a/tools/testing/selftests/vm/write_to_hugetlbfs.c
> > +++ b/tools/testing/selftests/vm/write_to_hugetlbfs.c
> > @@ -37,8 +37,8 @@ static int shmid;
> >  static void exit_usage(void)
> >  {
> >         printf("Usage: %s -p <path to hugetlbfs file> -s <size to map> =
"
> > -              "[-m <0=3Dhugetlbfs | 1=3Dmmap(MAP_HUGETLB)>] [-l] [-r] =
"
> > -              "[-o] [-w] [-n]\n",
> > +              "[-m <0=3Dhugetlbfs | 1=3Dmmap(MAP_HUGETLB)>] [-l(sleep)=
] [-r(private)] "
> > +              "[-o(populate)] [-w(rite)] [-n(o-reserve)]\n",
> >                self);
> >         exit(EXIT_FAILURE);
> >  }
> > @@ -161,6 +161,11 @@ int main(int argc, char **argv)
> >         else
> >                 printf("RESERVE mapping.\n");
> >
> > +       if (want_sleep)
> > +               printf("Sleeping\n");
> > +       else
> > +               printf("Not sleeping\n");
> > +
> >         switch (method) {
> >         case HUGETLBFS:
> >                 printf("Allocating using HUGETLBFS.\n");
> > --
> > 2.33.0.1079.g6e70778dc9-goog
