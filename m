Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6108744CD5D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 23:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234116AbhKJXC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 18:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233583AbhKJXCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 18:02:24 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA328C061766
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 14:59:36 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id m9so4813523iop.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 14:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+JlQfRhSHIQumShIo8LIt8iJ9iwe6QLgwaUh4qxgdH8=;
        b=m9mMxsf2J/5hzPfi1EyzhuX/LUx23jCdEmbTTL8w5RqbmubEipFXtJ/UIdXiYwQThu
         xyrmYAwkvpOdyeiGyNcLFRp27DKZ67wCrSz2u0LqddsMIN+6jArJhFfx+9U9D9Ehz9Dz
         6ENjRpygKOtqOcInoGqhv63hDaB1+JHwkrtfnAtKotqhz09z2w2B2XVU0WTriClNDkj3
         qY371361T5iI84L3OcLyvT6qnT5bEfs5JKaUaavlF4cfb1OH4iimvvr51RYR79y5kIc7
         0hQ9D+/zUvWuxFpoyj7WSuwdVkm0Ut716Tj8uq6FOjc0fvcOBBp3HPa1OfHGLo5zS/sF
         bkaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+JlQfRhSHIQumShIo8LIt8iJ9iwe6QLgwaUh4qxgdH8=;
        b=FWcT+AUykTEaMwadn9Y60Taf+0hXsEBZS0x0Yyx/Ka6OisCDO8bmVn+tmqKHj7aY/V
         4dkdg24Vks8QZseYEzZSEGiaOqYrbiWYxn0WoNqTLaVWAi9/40dMhyIAhQMrCF8wwpXz
         CeHsh1dCot84+89OoLc/l6Qdc014oZ0Ea+JHsGZJtkhtW8VFVUBO9rtA1ivlh2XY0Rn5
         AIBWU4emVScnX054X0xvKH/QswMM7NVXV3pd3DoHarOPSSLG48nqtG5u4Haj0cmEiHLH
         Ogg6kLfEU7xGn7Az6omfOZaRTxPz/llZziU1kpQcBN6sjddIr8gQFYsIXfkSC6heQN8s
         IlDg==
X-Gm-Message-State: AOAM533ySnw6BjuxY0sg2uTscpY0jVTqTY2g3Yoz4ESvxXuCzhJc9xyL
        9aSuAdXiVJ+s2UWWOEGXvACQ17Ql3FSN+pWWBcXo9w==
X-Google-Smtp-Source: ABdhPJz4h5QttK7JZ/ccpGgBYt9Y4qBUzjRohviQsLr3lRwEBxbOy9y9B1T3JOMDRBiVZdQ+xFBrC9nKkJC4xi3vEOk=
X-Received: by 2002:a5e:cb0d:: with SMTP id p13mr1805128iom.71.1636585176019;
 Wed, 10 Nov 2021 14:59:36 -0800 (PST)
MIME-Version: 1.0
References: <20211108210456.1745788-1-almasrymina@google.com> <CALvZod6_iWt9v=0mmHoeZpBtCGhjuDo9OusoamFUTh2BxceXFg@mail.gmail.com>
In-Reply-To: <CALvZod6_iWt9v=0mmHoeZpBtCGhjuDo9OusoamFUTh2BxceXFg@mail.gmail.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Wed, 10 Nov 2021 14:59:24 -0800
Message-ID: <CAHS8izM18OPZzdvWgQuD-0F2ZmTqYeTOuStcOpERVii70F1jDg@mail.gmail.com>
Subject: Re: [PATCH v4] hugetlb: Add hugetlb.*.numa_stat file
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
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
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 9, 2021 at 10:15 PM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Mon, Nov 8, 2021 at 1:05 PM Mina Almasry <almasrymina@google.com> wrot=
e:
> >
> > For hugetlb backed jobs/VMs it's critical to understand the numa
> > information for the memory backing these jobs to deliver optimal
> > performance.
> >
> > Currently this technically can be queried from /proc/self/numa_maps, bu=
t
> > there are significant issues with that. Namely:
> > 1. Memory can be mapped on unmapped.
>
> or*
>
> > 2. numa_maps are per process and need to be aggregated across all
> >    processes in the cgroup. For shared memory this is more involved as
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
> >    cat /sys/fs/cgroup/unified/test/hugetlb.2MB.numa_stat
> >    total=3D2097152 N0=3D2097152 N1=3D0
> >
> > On cgroup-v1:
> >    cat /sys/fs/cgroup/hugetlb/test/hugetlb.2MB.numa_stat
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
> > Cc: Shakeel Butt <shakeelb@google.com>
> > Cc: Jue Wang <juew@google.com>
> > Cc: Yang Yao <ygyao@google.com>
> > Cc: Joanna Li <joannali@google.com>
> > Cc: Cannon Matthews <cannonmatthews@google.com>
> > Cc: linux-mm@kvack.org
> > Cc: linux-kernel@vger.kernel.org
> >
> > Signed-off-by: Mina Almasry <almasrymina@google.com>
> >
> [...]
>
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
>
> Should we use atomic here? Is this safe for all archs?
>
> [...]
>
> >
> >  /*
> > @@ -292,7 +321,8 @@ static void __hugetlb_cgroup_commit_charge(int idx,=
 unsigned long nr_pages,
> >                 return;
> >
> >         __set_hugetlb_cgroup(page, h_cg, rsvd);
> > -       return;
> > +       if (!rsvd && h_cg)
>
> No need to check h_cg.
>
> > +               h_cg->nodeinfo[page_to_nid(page)]->usage[idx] +=3D nr_p=
ages;
> >  }
> >
> >  void hugetlb_cgroup_commit_charge(int idx, unsigned long nr_pages,
> > @@ -331,7 +361,8 @@ static void __hugetlb_cgroup_uncharge_page(int idx,=
 unsigned long nr_pages,
> >
> >         if (rsvd)
> >                 css_put(&h_cg->css);
> > -
> > +       else
> > +               h_cg->nodeinfo[page_to_nid(page)]->usage[idx] -=3D nr_p=
ages;
> >         return;
> >  }
> >
> > @@ -421,6 +452,58 @@ enum {
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
> > +               seq_printf(seq, "total=3D%lu", usage * PAGE_SIZE);
> > +
> > +               /* Simply print the per-node usage for the non-hierarch=
ical total. */
> > +               for_each_node_state(nid, N_MEMORY)
> > +                       seq_printf(seq, " N%d=3D%lu", nid,
> > +                                  h_cg->nodeinfo[nid]->usage[idx] * PA=
GE_SIZE);
> > +               seq_putc(seq, '\n');
> > +       }
> > +
> > +       /*
> > +        * The hierarchical total is pretty much the value recorded by =
the
> > +        * counter, so use that.
> > +        */
> > +       seq_printf(seq, "%stotal=3D%lu", legacy ? "hierarichal_" : "",
> > +                  page_counter_read(&h_cg->hugepage[idx]) * PAGE_SIZE)=
;
> > +
> > +       /*
> > +        * For each node, transverse the css tree to obtain the hierari=
chal
> > +        * node usage.
> > +        */
> > +       for_each_node_state(nid, N_MEMORY) {
> > +               usage =3D 0;
> > +               rcu_read_lock();
> > +               css_for_each_descendant_pre(css, &h_cg->css) {
>
> This will be slow. Do you really want to traverse the hugetlb-cgroup
> tree that many times? We had similar issues with memcg stats as well
> but got resolved with rstat.
>
> Though I feel like hugetlb-cgroup is not that worried about
> performance. There is no batching in the charging and uncharging
> codepaths.
>

I'm not seeing a way to get this info without paying the cost to
transverse the tree somewhere (either at charge time or at collection
time). I think maybe we can wait and see if there are issues with the
performance and if so we can adopt the memcg solutions or something
else.

Thank you for reviewing. I'm about to upload v5 with fixes.

> > +                       usage +=3D hugetlb_cgroup_from_css(css)
> > +                                        ->nodeinfo[nid]
> > +                                        ->usage[idx];
> > +               }
> > +               rcu_read_unlock();
> > +               seq_printf(seq, " N%d=3D%lu", nid, usage * PAGE_SIZE);
> > +       }
> > +
> > +       seq_putc(seq, '\n');
> > +
> > +       return 0;
> > +}
