Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAB7E44BB93
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 07:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbhKJGSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 01:18:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbhKJGSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 01:18:33 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C089C061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 22:15:46 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id u11so3445202lfs.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 22:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ARSK0cg4/6NHBj4tfDTKrSqHGxGMsCi0gZOBsxNv34c=;
        b=iIvJ/mQaK75oY0ILMPmphXn6KGLwriMbLrlq8BQJE75g7Z5VlwBbyMeak3hmBPkSV1
         uIqUs3ZizLuXTOP5jCT+0C8oSCwh6TGsU3UzoJwoSZXEQeYpq/OnTmDIKZ4sGZgW5645
         6IS8GT/yQSTp/DJVOODXKwQThwM6fRm6ECXQm7rE1Rd5wVc772FoJAo5mrI/MyUR7Q9p
         N9+5myhZUYqF73GUFyey9bbhZts+VMY5pfqDDDOLTjQZVxCBZ8uBCN+xTJrTFRem7geC
         QPd5KWCM683+UD7d9vxxFUDu6SYpBSDYfIy6gnoS0P4gZ7WzZgIf8vTop9XMhvzA+VZB
         gwYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ARSK0cg4/6NHBj4tfDTKrSqHGxGMsCi0gZOBsxNv34c=;
        b=oJY/OPDaTrm6DhsL451o0agtD2C4F2jDabrjRjXhpyDeuuW4gmC43qd0HahCycy5n4
         VkbGUOj4tOcVOZsMZWN+nQCZtwmNmiKTpSJFo6rO+u49X1u2ut2tk0CguLHGsy4M+jCz
         YUX0LKf9Cl4SsjMza1r219CTMlqjXumwizwUsvKdcPio8tgAp6wVSPsb8b6atiLUIxwB
         duZPp/6wtraQYY+PhxbUIQ72Co5JxFbU8oDlxtoa5kmndL3+qg8zaSsg3cmJDTKt/Xdj
         SmGzVD9PIkflgDyPAmE7G0VVsdplp2IjT3hG4FXHdgvEVnA0QKFhz1jps0Oc6AIxJUm+
         jkPQ==
X-Gm-Message-State: AOAM532wVk9gUkeSZd4LyP3NiEtTbImK3ruobDBVLjWO82V7aSl1oGmm
        kxUCihSFGU14j0XUFYd9oYjM5F2cMMlK9dmdL2nneA==
X-Google-Smtp-Source: ABdhPJzEuts2Wq3m6pYbXEvCLg6uwHkaX5Xg5ZfKEWfhYNEo0Gwq67i0x6s9PNQ1Aq7J2ER/UUX4pI4a+10R/yZ0IkE=
X-Received: by 2002:ac2:51b0:: with SMTP id f16mr12709591lfk.20.1636524944785;
 Tue, 09 Nov 2021 22:15:44 -0800 (PST)
MIME-Version: 1.0
References: <20211108210456.1745788-1-almasrymina@google.com>
In-Reply-To: <20211108210456.1745788-1-almasrymina@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 9 Nov 2021 22:15:33 -0800
Message-ID: <CALvZod6_iWt9v=0mmHoeZpBtCGhjuDo9OusoamFUTh2BxceXFg@mail.gmail.com>
Subject: Re: [PATCH v4] hugetlb: Add hugetlb.*.numa_stat file
To:     Mina Almasry <almasrymina@google.com>
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

On Mon, Nov 8, 2021 at 1:05 PM Mina Almasry <almasrymina@google.com> wrote:
>
> For hugetlb backed jobs/VMs it's critical to understand the numa
> information for the memory backing these jobs to deliver optimal
> performance.
>
> Currently this technically can be queried from /proc/self/numa_maps, but
> there are significant issues with that. Namely:
> 1. Memory can be mapped on unmapped.

or*

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
[...]

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
> +       unsigned long usage[HUGE_MAX_HSTATE];

Should we use atomic here? Is this safe for all archs?

[...]

>
>  /*
> @@ -292,7 +321,8 @@ static void __hugetlb_cgroup_commit_charge(int idx, u=
nsigned long nr_pages,
>                 return;
>
>         __set_hugetlb_cgroup(page, h_cg, rsvd);
> -       return;
> +       if (!rsvd && h_cg)

No need to check h_cg.

> +               h_cg->nodeinfo[page_to_nid(page)]->usage[idx] +=3D nr_pag=
es;
>  }
>
>  void hugetlb_cgroup_commit_charge(int idx, unsigned long nr_pages,
> @@ -331,7 +361,8 @@ static void __hugetlb_cgroup_uncharge_page(int idx, u=
nsigned long nr_pages,
>
>         if (rsvd)
>                 css_put(&h_cg->css);
> -
> +       else
> +               h_cg->nodeinfo[page_to_nid(page)]->usage[idx] -=3D nr_pag=
es;
>         return;
>  }
>
> @@ -421,6 +452,58 @@ enum {
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
> +                       usage +=3D h_cg->nodeinfo[nid]->usage[idx];
> +               seq_printf(seq, "total=3D%lu", usage * PAGE_SIZE);
> +
> +               /* Simply print the per-node usage for the non-hierarchic=
al total. */
> +               for_each_node_state(nid, N_MEMORY)
> +                       seq_printf(seq, " N%d=3D%lu", nid,
> +                                  h_cg->nodeinfo[nid]->usage[idx] * PAGE=
_SIZE);
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

This will be slow. Do you really want to traverse the hugetlb-cgroup
tree that many times? We had similar issues with memcg stats as well
but got resolved with rstat.

Though I feel like hugetlb-cgroup is not that worried about
performance. There is no batching in the charging and uncharging
codepaths.

> +                       usage +=3D hugetlb_cgroup_from_css(css)
> +                                        ->nodeinfo[nid]
> +                                        ->usage[idx];
> +               }
> +               rcu_read_unlock();
> +               seq_printf(seq, " N%d=3D%lu", nid, usage * PAGE_SIZE);
> +       }
> +
> +       seq_putc(seq, '\n');
> +
> +       return 0;
> +}
