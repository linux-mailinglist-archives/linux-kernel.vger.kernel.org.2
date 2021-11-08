Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D49B4478AC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 03:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236830AbhKHCy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 21:54:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbhKHCy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 21:54:27 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A3AC061570
        for <linux-kernel@vger.kernel.org>; Sun,  7 Nov 2021 18:51:43 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id v7so39842555ybq.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Nov 2021 18:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tUppml2Ur1MclUPf5DAubL+CMswUCyiQzxbAp3SgOe4=;
        b=A4bIWnER9ccOIcxjms9w/pbuLJsmQUzIKX6pNGx+ciIG8ZcjnnY1ZYGUkn7TByfZHs
         es7EetthkYtrJloTwcn75U1ofO7btvOyp9ihBKuOg+p1dEDg2DzxlcSeJIa7rRZfd551
         bhSWDt1xWEqyco8FSQtNgl22PtPD8Q9l3zXaPE5YU4537Ewz71aK9Z3fSts8bMzZRg1y
         zzXNSqbMyhhozi1hQYBCFLIVL8er3AZ6e9jLEqmzgtkKzNtpj0rphcHK90RlLT7uRtEm
         dHUaVVZlqebt/DRkI6TiugGA4CBtC5Pf6fY3xeM7RNELoHmS0+Zn7lXkNxESWcI3ZYNl
         FPqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tUppml2Ur1MclUPf5DAubL+CMswUCyiQzxbAp3SgOe4=;
        b=qXVbcdAp7csg0droDSM+v1nxBBr1pL+D8zftkmRchZl1lhSa+Ul6T9i/05UidFNuoS
         jdpUEhsswlgHVwXKDE3z3zvRnmcM/UtrvO7ywRZ3EkK+GA4tpChHNeuYPi/8Se6td81M
         ugncgVWU7SsHSa1zP5Li+LOv7ac5suGC5D/u/U3hej2kMGIwBho6oH565zQCUsVqDPGk
         fYVVuGMmXqKCkTtS4ApHbLD5aCxPgOwqIURTH5kp62D2qd0205+Hu0oH3jZszKm200T3
         LnKBLvZidwUoV0p2YCKzEYq/CkHuHoKjl8MZlCv7keZ0HLPzRYIg6Ei1p+Jmu+jyjtxR
         Qbfg==
X-Gm-Message-State: AOAM532QUk57RcoxhB442qwrXTKR9AaGTwq8cXS2F86kpKjCQjgHvFau
        0/xqc44jpRT5+UPkaqLDolsW4igR1lJQQQt7ucFQpA==
X-Google-Smtp-Source: ABdhPJwgGENN+iNUdfQPUZ+a8WKfHIj6nU3swasJfa9CZnE61enxXZCsRk/JTG2wdSkBW08dlSjbZlsiNWfmVi4xODE=
X-Received: by 2002:a25:59d5:: with SMTP id n204mr78204390ybb.189.1636339902313;
 Sun, 07 Nov 2021 18:51:42 -0800 (PST)
MIME-Version: 1.0
References: <20211104045347.218528-1-almasrymina@google.com>
 <CAMZfGtWv+L37JXikOAnBWLEGhu8baReVsDWGFH+CnTeWKTQy2Q@mail.gmail.com> <CAHS8izMqHtJR4FR5DvyV0e0g+_pdCoDm6qWV_R6YpN7YrSZ9ig@mail.gmail.com>
In-Reply-To: <CAHS8izMqHtJR4FR5DvyV0e0g+_pdCoDm6qWV_R6YpN7YrSZ9ig@mail.gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 8 Nov 2021 10:51:05 +0800
Message-ID: <CAMZfGtUKS0WPGsUffJUD-953LEEZYvwS8FvUKwCMuydU8gyLBA@mail.gmail.com>
Subject: Re: [PATCH v3] hugetlb: Add hugetlb.*.numa_stat file
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

On Mon, Nov 8, 2021 at 7:09 AM Mina Almasry <almasrymina@google.com> wrote:
>
> On Fri, Nov 5, 2021 at 11:55 PM Muchun Song <songmuchun@bytedance.com> wr=
ote:
> >
> > On Thu, Nov 4, 2021 at 12:53 PM Mina Almasry <almasrymina@google.com> w=
rote:
> > >
> > > For hugetlb backed jobs/VMs it's critical to understand the numa
> > > information for the memory backing these jobs to deliver optimal
> > > performance.
> > >
> > > Currently this technically can be queried from /proc/self/numa_maps, =
but
> > > there are significant issues with that. Namely:
> > > 1. Memory can be mapped on unmapped.
> > > 2. numa_maps are per process and need to be aggregated across all
> > >    processes in the cgroup. For shared memory this is more involved a=
s
> > >    the userspace needs to make sure it doesn't double count shared
> > >    mappings.
> > > 3. I believe querying numa_maps needs to hold the mmap_lock which add=
s
> > >    to the contention on this lock.
> > >
> > > For these reasons I propose simply adding hugetlb.*.numa_stat file,
> > > which shows the numa information of the cgroup similarly to
> > > memory.numa_stat.
> > >
> > > On cgroup-v2:
> > >    cat /sys/fs/cgroup/unified/test/hugetlb.2MB.numa_stat
> > >    total=3D2097152 N0=3D2097152 N1=3D0
> > >
> > > On cgroup-v1:
> > >    cat /sys/fs/cgroup/hugetlb/test/hugetlb.2MB.numa_stat
> > >    total=3D2097152 N0=3D2097152 N1=3D0
> > >    hierarichal_total=3D2097152 N0=3D2097152 N1=3D0
> > >
> > > This patch was tested manually by allocating hugetlb memory and query=
ing
> > > the hugetlb.*.numa_stat file of the cgroup and its parents.
> > > =EF=BF=BC
> > > Cc: Mike Kravetz <mike.kravetz@oracle.com>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: Shuah Khan <shuah@kernel.org>
> > > Cc: Miaohe Lin <linmiaohe@huawei.com>
> > > Cc: Oscar Salvador <osalvador@suse.de>
> > > Cc: Michal Hocko <mhocko@suse.com>
> > > Cc: Muchun Song <songmuchun@bytedance.com>
> > > Cc: David Rientjes <rientjes@google.com>
> > > Cc: Shakeel Butt <shakeelb@google.com>
> > > Cc: Jue Wang <juew@google.com>
> > > Cc: Yang Yao <ygyao@google.com>
> > > Cc: Joanna Li <joannali@google.com>
> > > Cc: Cannon Matthews <cannonmatthews@google.com>
> > > Cc: linux-mm@kvack.org
> > > Cc: linux-kernel@vger.kernel.org
> > >
> > > Signed-off-by: Mina Almasry <almasrymina@google.com>
> > >
> > > ---
> > >
> > > Changes in v3:
> > > - Fixed typos (sorry!)
> > > - Used conventional locations for cgroups mount points in docs/commit
> > > message.
> > > - Updated docs.
> > > - Handle kzalloc_node failure, and proper deallocation of per node da=
ta.
> > > - Use struct_size() to calculate the struct size.
> > > - Use nr_node_ids instead of MAX_NUMNODES.
> > > - Updated comments per multi-line comment pattern.
> > >
> > > Changes in v2:
> > > - Fix warning Reported-by: kernel test robot <lkp@intel.com>
> > > ---
> > >  .../admin-guide/cgroup-v1/hugetlb.rst         |   4 +
> > >  Documentation/admin-guide/cgroup-v2.rst       |   5 +
> > >  include/linux/hugetlb.h                       |   4 +-
> > >  include/linux/hugetlb_cgroup.h                |   7 ++
> > >  mm/hugetlb_cgroup.c                           | 116 ++++++++++++++++=
--
> > >  .../testing/selftests/vm/write_to_hugetlbfs.c |   9 +-
> > >  6 files changed, 132 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/Documentation/admin-guide/cgroup-v1/hugetlb.rst b/Docume=
ntation/admin-guide/cgroup-v1/hugetlb.rst
> > > index 338f2c7d7a1c..0fa724d82abb 100644
> > > --- a/Documentation/admin-guide/cgroup-v1/hugetlb.rst
> > > +++ b/Documentation/admin-guide/cgroup-v1/hugetlb.rst
> > > @@ -29,12 +29,14 @@ Brief summary of control files::
> > >   hugetlb.<hugepagesize>.max_usage_in_bytes             # show max "h=
ugepagesize" hugetlb  usage recorded
> > >   hugetlb.<hugepagesize>.usage_in_bytes                 # show curren=
t usage for "hugepagesize" hugetlb
> > >   hugetlb.<hugepagesize>.failcnt                        # show the nu=
mber of allocation failure due to HugeTLB usage limit
> > > + hugetlb.<hugepagesize>.numa_stat                      # show the nu=
ma information of the hugetlb memory charged to this cgroup
> > >
> > >  For a system supporting three hugepage sizes (64k, 32M and 1G), the =
control
> > >  files include::
> > >
> > >    hugetlb.1GB.limit_in_bytes
> > >    hugetlb.1GB.max_usage_in_bytes
> > > +  hugetlb.1GB.numa_stat
> > >    hugetlb.1GB.usage_in_bytes
> > >    hugetlb.1GB.failcnt
> > >    hugetlb.1GB.rsvd.limit_in_bytes
> > > @@ -43,6 +45,7 @@ files include::
> > >    hugetlb.1GB.rsvd.failcnt
> > >    hugetlb.64KB.limit_in_bytes
> > >    hugetlb.64KB.max_usage_in_bytes
> > > +  hugetlb.64KB.numa_stat
> > >    hugetlb.64KB.usage_in_bytes
> > >    hugetlb.64KB.failcnt
> > >    hugetlb.64KB.rsvd.limit_in_bytes
> > > @@ -51,6 +54,7 @@ files include::
> > >    hugetlb.64KB.rsvd.failcnt
> > >    hugetlb.32MB.limit_in_bytes
> > >    hugetlb.32MB.max_usage_in_bytes
> > > +  hugetlb.32MB.numa_stat
> > >    hugetlb.32MB.usage_in_bytes
> > >    hugetlb.32MB.failcnt
> > >    hugetlb.32MB.rsvd.limit_in_bytes
> > > diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/=
admin-guide/cgroup-v2.rst
> > > index 4d8c27eca96b..356847f8f008 100644
> > > --- a/Documentation/admin-guide/cgroup-v2.rst
> > > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > > @@ -2252,6 +2252,11 @@ HugeTLB Interface Files
> > >         are local to the cgroup i.e. not hierarchical. The file modif=
ied event
> > >         generated on this file reflects only the local events.
> > >
> > > +  hugetlb.<hugepagesize>.numa_stat
> > > +       Similar to memory.numa_stat, it shows the numa information of=
 the
> > > +        hugetlb pages of <hugepagesize> in this cgroup.  Only active=
 in
> > > +        use hugetlb pages are included.  The per-node values are in =
bytes.
> > > +
> > >  Misc
> > >  ----
> > >
> > > diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> > > index 1faebe1cd0ed..0445faaa636e 100644
> > > --- a/include/linux/hugetlb.h
> > > +++ b/include/linux/hugetlb.h
> > > @@ -613,8 +613,8 @@ struct hstate {
> > >  #endif
> > >  #ifdef CONFIG_CGROUP_HUGETLB
> > >         /* cgroup control files */
> > > -       struct cftype cgroup_files_dfl[7];
> > > -       struct cftype cgroup_files_legacy[9];
> > > +       struct cftype cgroup_files_dfl[8];
> > > +       struct cftype cgroup_files_legacy[10];
> > >  #endif
> > >         char name[HSTATE_NAME_LEN];
> > >  };
> > > diff --git a/include/linux/hugetlb_cgroup.h b/include/linux/hugetlb_c=
group.h
> > > index c137396129db..54ff6ec68ed3 100644
> > > --- a/include/linux/hugetlb_cgroup.h
> > > +++ b/include/linux/hugetlb_cgroup.h
> > > @@ -36,6 +36,11 @@ enum hugetlb_memory_event {
> > >         HUGETLB_NR_MEMORY_EVENTS,
> > >  };
> > >
> > > +struct hugetlb_cgroup_per_node {
> > > +       /* hugetlb usage in bytes over all hstates. */
> > > +       unsigned long usage[HUGE_MAX_HSTATE];
> > > +};
> > > +
> > >  struct hugetlb_cgroup {
> > >         struct cgroup_subsys_state css;
> > >
> > > @@ -57,6 +62,8 @@ struct hugetlb_cgroup {
> > >
> > >         /* Handle for "hugetlb.events.local" */
> > >         struct cgroup_file events_local_file[HUGE_MAX_HSTATE];
> > > +
> > > +       struct hugetlb_cgroup_per_node *nodeinfo[];
> > >  };
> > >
> > >  static inline struct hugetlb_cgroup *
> > > diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
> > > index 5383023d0cca..6be6dfb4f7a7 100644
> > > --- a/mm/hugetlb_cgroup.c
> > > +++ b/mm/hugetlb_cgroup.c
> > > @@ -126,29 +126,59 @@ static void hugetlb_cgroup_init(struct hugetlb_=
cgroup *h_cgroup,
> > >         }
> > >  }
> > >
> > > +static void hugetlb_cgroup_free(struct hugetlb_cgroup *h_cgroup)
> > > +{
> > > +       int node;
> > > +
> > > +       for_each_node(node) {
> > > +               kfree(h_cgroup->nodeinfo[node]);
> > > +       }
> >
> > Braces {} are not necessary for single statement blocks.
> >
>
> Will be removed in v4.
>
> > > +       kfree(h_cgroup);
> > > +}
> > > +
> > >  static struct cgroup_subsys_state *
> > >  hugetlb_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
> > >  {
> > >         struct hugetlb_cgroup *parent_h_cgroup =3D hugetlb_cgroup_fro=
m_css(parent_css);
> > >         struct hugetlb_cgroup *h_cgroup;
> > > +       int node;
> > > +
> > > +       h_cgroup =3D kzalloc(struct_size(h_cgroup, nodeinfo, nr_node_=
ids),
> > > +                          GFP_KERNEL);
> > >
> > > -       h_cgroup =3D kzalloc(sizeof(*h_cgroup), GFP_KERNEL);
> > >         if (!h_cgroup)
> > >                 return ERR_PTR(-ENOMEM);
> > >
> > >         if (!parent_h_cgroup)
> > >                 root_h_cgroup =3D h_cgroup;
> > >
> > > +       /*
> > > +        * TODO: this routine can waste much memory for nodes which w=
ill
> > > +        * never be onlined. It's better to use memory hotplug callba=
ck
> > > +        * function.
> > > +        */
> > > +       for_each_node(node) {
> > > +               /* Set node_to_alloc to -1 for offline nodes. */
> > > +               int node_to_alloc =3D
> > > +                       node_state(node, N_NORMAL_MEMORY) ? node : -1=
;
> > > +               h_cgroup->nodeinfo[node] =3D
> > > +                       kzalloc_node(sizeof(struct hugetlb_cgroup_per=
_node),
> > > +                                    GFP_KERNEL, node_to_alloc);
> > > +               if (!h_cgroup->nodeinfo[node])
> > > +                       goto fail_alloc_nodeinfo;
> > > +       }
> > > +
> > >         hugetlb_cgroup_init(h_cgroup, parent_h_cgroup);
> > >         return &h_cgroup->css;
> > > +
> > > +fail_alloc_nodeinfo:
> > > +       hugetlb_cgroup_free(h_cgroup);
> > > +       return ERR_PTR(-ENOMEM);
> > >  }
> > >
> > >  static void hugetlb_cgroup_css_free(struct cgroup_subsys_state *css)
> > >  {
> > > -       struct hugetlb_cgroup *h_cgroup;
> > > -
> > > -       h_cgroup =3D hugetlb_cgroup_from_css(css);
> > > -       kfree(h_cgroup);
> > > +       hugetlb_cgroup_free(hugetlb_cgroup_from_css(css));
> > >  }
> > >
> > >  /*
> > > @@ -292,7 +322,9 @@ static void __hugetlb_cgroup_commit_charge(int id=
x, unsigned long nr_pages,
> > >                 return;
> > >
> > >         __set_hugetlb_cgroup(page, h_cg, rsvd);
> > > -       return;
> > > +       if (!rsvd && h_cg)
> > > +               h_cg->nodeinfo[page_to_nid(page)]->usage[idx] +=3D nr=
_pages
> > > +                                                                << P=
AGE_SHIFT;
> >
> > How about changing the unit from byte to page? In this case, we
> > do not need to do shift operations here. When the user reads
> > numa_stat, then converting the pages to bytes for them.
> >
>
> So all the other hugetlb_cgroup interfaces (max, current,
> usage_in_bytes, limit_in_bytes), are in bytes and not pages, and
> memory.numa_stat is also in bytes. I think providing consistency here
> is a really good thing.

I mean accounting with pages but showing with bytes, which is more
efficient and does not break consistency.

>
> > >  }
> > >
> > >  void hugetlb_cgroup_commit_charge(int idx, unsigned long nr_pages,
> > > @@ -331,7 +363,9 @@ static void __hugetlb_cgroup_uncharge_page(int id=
x, unsigned long nr_pages,
> > >
> > >         if (rsvd)
> > >                 css_put(&h_cg->css);
> > > -
> > > +       else
> > > +               h_cg->nodeinfo[page_to_nid(page)]->usage[idx] -=3D nr=
_pages
> > > +                                                                << P=
AGE_SHIFT;
> > >         return;
> > >  }
> > >
> > > @@ -421,6 +455,58 @@ enum {
> > >         RES_RSVD_FAILCNT,
> > >  };
> > >
> > > +static int hugetlb_cgroup_read_numa_stat(struct seq_file *seq, void =
*dummy)
> > > +{
> > > +       int nid;
> > > +       struct cftype *cft =3D seq_cft(seq);
> > > +       int idx =3D MEMFILE_IDX(cft->private);
> > > +       bool legacy =3D MEMFILE_ATTR(cft->private);
> > > +       struct hugetlb_cgroup *h_cg =3D hugetlb_cgroup_from_css(seq_c=
ss(seq));
> > > +       struct cgroup_subsys_state *css;
> > > +       unsigned long usage;
> > > +
> > > +       if (legacy) {
> > > +               /* Add up usage across all nodes for the non-hierarch=
ical total. */
> > > +               usage =3D 0;
> > > +               for_each_node_state(nid, N_MEMORY)
> > > +                       usage +=3D h_cg->nodeinfo[nid]->usage[idx];
> > > +               seq_printf(seq, "total=3D%lu", usage);

Here it could be like this.

seq_printf(seq, "total=3D%lu", usage * PAGE_SIZE);

Thanks.

> > > +
> > > +               /* Simply print the per-node usage for the non-hierar=
chical total. */
> > > +               for_each_node_state(nid, N_MEMORY)
> > > +                       seq_printf(seq, " N%d=3D%lu", nid,
> > > +                                  h_cg->nodeinfo[nid]->usage[idx]);
> > > +               seq_putc(seq, '\n');
> > > +       }
> > > +
> > > +       /*
> > > +        * The hierarchical total is pretty much the value recorded b=
y the
> > > +        * counter, so use that.
> > > +        */
> > > +       seq_printf(seq, "%stotal=3D%lu", legacy ? "hierarichal_" : ""=
,
> > > +                  page_counter_read(&h_cg->hugepage[idx]) * PAGE_SIZ=
E);
> > > +
> > > +       /*
> > > +        * For each node, transverse the css tree to obtain the hiera=
richal
> > > +        * node usage.
> > > +        */
> > > +       for_each_node_state(nid, N_MEMORY) {
> > > +               usage =3D 0;
> > > +               rcu_read_lock();
> > > +               css_for_each_descendant_pre(css, &h_cg->css) {
> > > +                       usage +=3D hugetlb_cgroup_from_css(css)
> > > +                                        ->nodeinfo[nid]
> > > +                                        ->usage[idx];
> > > +               }
> > > +               rcu_read_unlock();
> > > +               seq_printf(seq, " N%d=3D%lu", nid, usage);
> > > +       }
> > > +
> > > +       seq_putc(seq, '\n');
> > > +
> > > +       return 0;
> > > +}
> > > +
> > >  static u64 hugetlb_cgroup_read_u64(struct cgroup_subsys_state *css,
> > >                                    struct cftype *cft)
> > >  {
> > > @@ -671,8 +757,14 @@ static void __init __hugetlb_cgroup_file_dfl_ini=
t(int idx)
> > >                                     events_local_file[idx]);
> > >         cft->flags =3D CFTYPE_NOT_ON_ROOT;
> > >
> > > -       /* NULL terminate the last cft */
> > > +       /* Add the numa stat file */
> > >         cft =3D &h->cgroup_files_dfl[6];
> > > +       snprintf(cft->name, MAX_CFTYPE_NAME, "%s.numa_stat", buf);
> > > +       cft->seq_show =3D hugetlb_cgroup_read_numa_stat;
> > > +       cft->flags =3D CFTYPE_NOT_ON_ROOT;
> > > +
> > > +       /* NULL terminate the last cft */
> > > +       cft =3D &h->cgroup_files_dfl[7];
> > >         memset(cft, 0, sizeof(*cft));
> > >
> > >         WARN_ON(cgroup_add_dfl_cftypes(&hugetlb_cgrp_subsys,
> > > @@ -742,8 +834,14 @@ static void __init __hugetlb_cgroup_file_legacy_=
init(int idx)
> > >         cft->write =3D hugetlb_cgroup_reset;
> > >         cft->read_u64 =3D hugetlb_cgroup_read_u64;
> > >
> > > +       /* Add the numa stat file */
> > > +       cft =3D &h->cgroup_files_dfl[8];
> > > +       snprintf(cft->name, MAX_CFTYPE_NAME, "%s.numa_stat", buf);
> > > +       cft->private =3D MEMFILE_PRIVATE(idx, 1);
> > > +       cft->seq_show =3D hugetlb_cgroup_read_numa_stat;
> > > +
> > >         /* NULL terminate the last cft */
> > > -       cft =3D &h->cgroup_files_legacy[8];
> > > +       cft =3D &h->cgroup_files_legacy[9];
> > >         memset(cft, 0, sizeof(*cft));
> > >
> > >         WARN_ON(cgroup_add_legacy_cftypes(&hugetlb_cgrp_subsys,
> > > diff --git a/tools/testing/selftests/vm/write_to_hugetlbfs.c b/tools/=
testing/selftests/vm/write_to_hugetlbfs.c
> > > index 6a2caba19ee1..d2da6315a40c 100644
> > > --- a/tools/testing/selftests/vm/write_to_hugetlbfs.c
> > > +++ b/tools/testing/selftests/vm/write_to_hugetlbfs.c
> > > @@ -37,8 +37,8 @@ static int shmid;
> > >  static void exit_usage(void)
> > >  {
> > >         printf("Usage: %s -p <path to hugetlbfs file> -s <size to map=
> "
> > > -              "[-m <0=3Dhugetlbfs | 1=3Dmmap(MAP_HUGETLB)>] [-l] [-r=
] "
> > > -              "[-o] [-w] [-n]\n",
> > > +              "[-m <0=3Dhugetlbfs | 1=3Dmmap(MAP_HUGETLB)>] [-l(slee=
p)] [-r(private)] "
> > > +              "[-o(populate)] [-w(rite)] [-n(o-reserve)]\n",
> >
> > Why do those changes? It seems like it does not belong
> > to this patch. Please explain why you did this in changelog
> > and separate those lines into another patch.
> >
> > Thanks.
> >
>
> So I used writo_to_hugetlbfs to test this patch, and I forgot what the
> flags do so I clarified them, but sure yes these changes aren't
> related to numa_stat. I'll drop them from v4 and I can always upload
> them later.
>
> > >                self);
> > >         exit(EXIT_FAILURE);
> > >  }
> > > @@ -161,6 +161,11 @@ int main(int argc, char **argv)
> > >         else
> > >                 printf("RESERVE mapping.\n");
> > >
> > > +       if (want_sleep)
> > > +               printf("Sleeping\n");
> > > +       else
> > > +               printf("Not sleeping\n");
> > > +
> > >         switch (method) {
> > >         case HUGETLBFS:
> > >                 printf("Allocating using HUGETLBFS.\n");
> > > --
> > > 2.33.1.1089.g2158813163f-goog
