Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF5F2421245
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 17:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233469AbhJDPIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 11:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235470AbhJDPIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 11:08:17 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91954C061746;
        Mon,  4 Oct 2021 08:06:28 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id z5so38412058ybj.2;
        Mon, 04 Oct 2021 08:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8Pu8pf1f+7G+p8+pWv9PSKj8EqDugIcZxa3mIg5M3hs=;
        b=ONVLWuDyZs2LA6vbzOOCty8fD1qdmRXhtuXbZMvYHqqWAo8hDxSKbf0M+b1M3Q9uK9
         KnY/tnHWlL3U/v4LJSWj5VNFKUXNYRY/QS4VK9ju77VtMP95KNUMD8cd8iECm+BeKKvK
         sBGyw6rJeLvHtBSyiC5p6CY2nxwk8v8I7JszuR6YhKH1VHReili21FrnFfmYD9GnLmuU
         F8cGPYxAr1rC1Mbu/yuGZ7+RCInGD9gjsY7Zq2BA6QBamWBMbgFAcdpv5nupLNh9WbaQ
         wglmDJxafuck7Dwn1N88v2wDqrfEG/aRRGkpfMW/BQ9bmWDSsFuQLorOXGL07+5FZWyy
         ux/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8Pu8pf1f+7G+p8+pWv9PSKj8EqDugIcZxa3mIg5M3hs=;
        b=rVHsCLY/Zm4EYhljghhvJ4/goDU3z2P6J5RiIZZvvvQntTrYGaMRrNTGdn5g+75gay
         Zi9bD5wyPnk6VD1jTYK0Rs4G1DDGoz3t4GR5hJj1jGuTCO4FPW0v9jR0Q2nEyNsdVxes
         9aJuYAic0iMjoODlAmKIfd5noSkarSvMvfp+5FcLA+3PUlrFmPzMXk7YcBiJ0OQ3dl//
         M+5T3U7DEqDGKrQErzLL0QLxtxxBU1fWV66UC4DI+yAoFRNGLxb2pZ0bEL+g/Bunyu60
         hHQ8AGpb9Fryv/bHr/3H40uVQ9TldqFkR/e2I8wkDy2dbDknff5UzbxeQCeJtrUIg4LF
         yGSg==
X-Gm-Message-State: AOAM532oMMqLYet6GfuuPvVhe0okvLXqBwAjkRiaVv1zSMJszCnHDjhA
        AmKO1X4PB2+x+M9hbs3OWBI3PIEmBXL47JjqBTg=
X-Google-Smtp-Source: ABdhPJxLrTvu2rer/kRMf8Ssl+uuhhAokV6x8LnGGd4Sxc4dBulNik9s9bWQUbc4l/GTiXWaR3wjh+E2Tsk6vFLoib0=
X-Received: by 2002:a25:d70d:: with SMTP id o13mr15939063ybg.239.1633359987618;
 Mon, 04 Oct 2021 08:06:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210927104149.46884-1-yaozhenguo1@gmail.com> <c83bffef-53ca-5448-38b5-27282ba97499@oracle.com>
In-Reply-To: <c83bffef-53ca-5448-38b5-27282ba97499@oracle.com>
From:   Zhenguo Yao <yaozhenguo1@gmail.com>
Date:   Mon, 4 Oct 2021 23:06:15 +0800
Message-ID: <CA+WzAR=eVOYamSoEyuphiL89qXh+=0kBZAPkxAnuqamMWgrTSQ@mail.gmail.com>
Subject: Re: [PATCH v7] hugetlbfs: Extend the definition of hugepages
 parameter to support node allocation
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        corbet@lwn.net, Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, yaozhenguo@jd.com,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike:

Thanks for your review. I notice that this patch has already been in
linux-next. Do I need to submit another version of this patch or
provide a new patch to fix the problems  you pointed out?

Mike Kravetz <mike.kravetz@oracle.com> =E4=BA=8E2021=E5=B9=B410=E6=9C=882=
=E6=97=A5=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=886:33=E5=86=99=E9=81=93=EF=BC=
=9A
>
> On 9/27/21 3:41 AM, Zhenguo Yao wrote:
> > We can specify the number of hugepages to allocate at boot. But the
> > hugepages is balanced in all nodes at present. In some scenarios,
> > we only need hugepages in one node. For example: DPDK needs hugepages
> > which are in the same node as NIC. if DPDK needs four hugepages of 1G
> > size in node1 and system has 16 numa nodes. We must reserve 64 hugepage=
s
> > in kernel cmdline. But, only four hugepages are used. The others should
> > be free after boot. If the system memory is low(for example: 64G), it w=
ill
> > be an impossible task. So, Extending hugepages parameter to support
> > specifying hugepages at a specific node.
> > For example add following parameter:
> >
> > hugepagesz=3D1G hugepages=3D0:1,1:3
> >
> > It will allocate 1 hugepage in node0 and 3 hugepages in node1.
> >
> > Signed-off-by: Zhenguo Yao <yaozhenguo1@gmail.com>
>
> Thanks for your continued efforts!  And, thank you Mike R. for your
> input.
>
> Just a few very minor comments below.  Everything else looks good.
> With suggested updates,
>
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
>
> > ---
> > v6->v7 changes:
> >       - replace nodes_weight(node_states[N_MEMORY] with nr_online_nodes=
.
> > v5->v6 changes:
> >       - Remove v5 codes: using return value to disable node specific al=
loc.
> >       - Add node_specific_alloc_support weak function to disable node
> >         specific alloc when arch can't support it.
> >       - Remove useless variable addr in alloc_bootmem_huge_page.
> >       - Add powerpc version of node_specific_alloc_support when
> >         CONFIG_PPC_BOOK3S_64 is defined.
> > v4->v5 changes:
> >       - remove BUG_ON in __alloc_bootmem_huge_page.
> >       - add nid parameter in __alloc_bootmem_huge_page to support
> >         called in both specific node alloc and normal alloc.
> >       - do normal alloc if architecture can't support node specific all=
oc.
> >       - return -1 in powerpc version of alloc_bootmem_huge_page when
> >         nid is not NUMA_NO_NODE.
> > v3->v4 changes:
> >       - fix wrong behavior for parameter:
> >         hugepages=3D0:1,1:3 default_hugepagesz=3D1G
> >       - make the change of documentation more reasonable.
> > v2->v3 changes:
> >       - Skip gigantic hugepages allocation if hugetlb_cma is enabled.
> >       - Fix wrong behavior for parameter:
> >         hugepagesz=3D2M hugepages=3D2 hugepages=3D5.
> >       - Update hugetlbpage.rst.
> >       - Fix side effects which v2 brings in.
> >       - add cond_resched in hugetlb_hstate_alloc_pages_onenode.
> > v1->v2 changes:
> >       - add checking for max node to avoid array out of bounds.
> >       - fix wrong max_huge_pages after failed allocation.
> >       - fix wrong behavior when parsing parameter: hugepages=3D0:1,2,3:=
4.
> >       - return 0 when parsing invalid parameter in hugepages_setup
> > ---
> >  .../admin-guide/kernel-parameters.txt         |   8 +-
> >  Documentation/admin-guide/mm/hugetlbpage.rst  |  12 +-
> >  arch/powerpc/mm/hugetlbpage.c                 |   9 +-
> >  include/linux/hugetlb.h                       |   6 +-
> >  mm/hugetlb.c                                  | 153 +++++++++++++++---
> >  5 files changed, 157 insertions(+), 31 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Document=
ation/admin-guide/kernel-parameters.txt
> > index 91ba391f9b32..9b3d8791586d 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -1599,9 +1599,11 @@
> >                       the number of pages of hugepagesz to be allocated=
.
> >                       If this is the first HugeTLB parameter on the com=
mand
> >                       line, it specifies the number of pages to allocat=
e for
> > -                     the default huge page size.  See also
> > -                     Documentation/admin-guide/mm/hugetlbpage.rst.
> > -                     Format: <integer>
> > +                     the default huge page size. If using node format,=
 the
> > +                     number of pages to allocate per-node can be speci=
fied.
> > +                     See also Documentation/admin-guide/mm/hugetlbpage=
.rst.
> > +                     Format: <integer> or (node format)
> > +                             <node>:<integer>[,<node>:<integer>]
> >
> >       hugepagesz=3D
> >                       [HW] The size of the HugeTLB pages.  This is used=
 in
> > diff --git a/Documentation/admin-guide/mm/hugetlbpage.rst b/Documentati=
on/admin-guide/mm/hugetlbpage.rst
> > index 8abaeb144e44..d70828c07658 100644
> > --- a/Documentation/admin-guide/mm/hugetlbpage.rst
> > +++ b/Documentation/admin-guide/mm/hugetlbpage.rst
> > @@ -128,7 +128,9 @@ hugepages
> >       implicitly specifies the number of huge pages of default size to
> >       allocate.  If the number of huge pages of default size is implici=
tly
> >       specified, it can not be overwritten by a hugepagesz,hugepages
> > -     parameter pair for the default size.
> > +     parameter pair for the default size.  This parameter also has a
> > +     node format.  The node format specifies the number of huge pages
> > +     to allocate on specific nodes.
> >
> >       For example, on an architecture with 2M default huge page size::
> >
> > @@ -138,6 +140,14 @@ hugepages
> >       indicating that the hugepages=3D512 parameter is ignored.  If a h=
ugepages
> >       parameter is preceded by an invalid hugepagesz parameter, it will
> >       be ignored.
> > +
> > +     Node format example::
> > +
> > +             hugepagesz=3D2M hugepages=3D0:1,1:2
> > +
> > +     It will allocate 1 2M hugepage on node0 and 2 2M hugepages on nod=
e1.
> > +     If the node number is invalid,  the parameter will be ignored.
> > +
> >  default_hugepagesz
> >       Specify the default huge page size.  This parameter can
> >       only be specified once on the command line.  default_hugepagesz c=
an
> > diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpag=
e.c
> > index 9a75ba078e1b..dd40ce6e7565 100644
> > --- a/arch/powerpc/mm/hugetlbpage.c
> > +++ b/arch/powerpc/mm/hugetlbpage.c
> > @@ -229,17 +229,22 @@ static int __init pseries_alloc_bootmem_huge_page=
(struct hstate *hstate)
> >       m->hstate =3D hstate;
> >       return 1;
> >  }
> > +
> > +bool __init node_specific_alloc_support(void)
> > +{
> > +     return false;
> > +}
> >  #endif
> >
> >
> > -int __init alloc_bootmem_huge_page(struct hstate *h)
> > +int __init alloc_bootmem_huge_page(struct hstate *h, int nid)
> >  {
> >
> >  #ifdef CONFIG_PPC_BOOK3S_64
> >       if (firmware_has_feature(FW_FEATURE_LPAR) && !radix_enabled())
> >               return pseries_alloc_bootmem_huge_page(h);
> >  #endif
> > -     return __alloc_bootmem_huge_page(h);
> > +     return __alloc_bootmem_huge_page(h, nid);
> >  }
> >
> >  #ifndef CONFIG_PPC_BOOK3S_64
> > diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> > index 1faebe1cd0ed..3504e407567c 100644
> > --- a/include/linux/hugetlb.h
> > +++ b/include/linux/hugetlb.h
> > @@ -605,6 +605,7 @@ struct hstate {
> >       unsigned long nr_overcommit_huge_pages;
> >       struct list_head hugepage_activelist;
> >       struct list_head hugepage_freelists[MAX_NUMNODES];
> > +     unsigned int max_huge_pages_node[MAX_NUMNODES];
> >       unsigned int nr_huge_pages_node[MAX_NUMNODES];
> >       unsigned int free_huge_pages_node[MAX_NUMNODES];
> >       unsigned int surplus_huge_pages_node[MAX_NUMNODES];
> > @@ -637,8 +638,9 @@ void restore_reserve_on_error(struct hstate *h, str=
uct vm_area_struct *vma,
> >                               unsigned long address, struct page *page)=
;
> >
> >  /* arch callback */
> > -int __init __alloc_bootmem_huge_page(struct hstate *h);
> > -int __init alloc_bootmem_huge_page(struct hstate *h);
> > +int __init __alloc_bootmem_huge_page(struct hstate *h, int nid);
> > +int __init alloc_bootmem_huge_page(struct hstate *h, int nid);
> > +bool __init node_specific_alloc_support(void);
>
> Agree with Mike R. that hugetlb should be in the name.
>
> >
> >  void __init hugetlb_add_hstate(unsigned order);
> >  bool __init arch_hugetlb_valid_size(unsigned long size);
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 95dc7b83381f..ca00676a1bdd 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -66,6 +66,7 @@ static struct hstate * __initdata parsed_hstate;
> >  static unsigned long __initdata default_hstate_max_huge_pages;
> >  static bool __initdata parsed_valid_hugepagesz =3D true;
> >  static bool __initdata parsed_default_hugepagesz;
> > +static unsigned int default_hugepages_in_node[MAX_NUMNODES] __initdata=
;
> >
> >  /*
> >   * Protects updates to hugepage_freelists, hugepage_activelist, nr_hug=
e_pages,
> > @@ -2868,33 +2869,41 @@ struct page *alloc_huge_page(struct vm_area_str=
uct *vma,
> >       return ERR_PTR(-ENOSPC);
> >  }
> >
> > -int alloc_bootmem_huge_page(struct hstate *h)
> > +int alloc_bootmem_huge_page(struct hstate *h, int nid)
> >       __attribute__ ((weak, alias("__alloc_bootmem_huge_page")));
> > -int __alloc_bootmem_huge_page(struct hstate *h)
> > +int __alloc_bootmem_huge_page(struct hstate *h, int nid)
> >  {
> >       struct huge_bootmem_page *m;
> >       int nr_nodes, node;
> >
> > +     if (nid >=3D nr_online_nodes)
> > +             return 0;
> > +     /* do node specific alloc */
> > +     if (nid !=3D NUMA_NO_NODE) {
> > +             m =3D memblock_alloc_try_nid_raw(huge_page_size(h), huge_=
page_size(h),
> > +                             0, MEMBLOCK_ALLOC_ACCESSIBLE, nid);
> > +             if (m)
> > +                     goto found;
> > +             else
> > +                     return 0;
> > +     }
> > +     /* do all node balanced alloc */
>
> I'm sure you saw Smatch does not like this comment.  Perhaps,
>         /* allocate from next node when distributing huge pages */
>
> >       for_each_node_mask_to_alloc(h, nr_nodes, node, &node_states[N_MEM=
ORY]) {
> > -             void *addr;
> > -
> > -             addr =3D memblock_alloc_try_nid_raw(
> > +             m =3D memblock_alloc_try_nid_raw(
> >                               huge_page_size(h), huge_page_size(h),
> >                               0, MEMBLOCK_ALLOC_ACCESSIBLE, node);
> > -             if (addr) {
> > -                     /*
> > -                      * Use the beginning of the huge page to store th=
e
> > -                      * huge_bootmem_page struct (until gather_bootmem
> > -                      * puts them into the mem_map).
> > -                      */
> > -                     m =3D addr;
> > +             /*
> > +              * Use the beginning of the huge page to store the
> > +              * huge_bootmem_page struct (until gather_bootmem
> > +              * puts them into the mem_map).
> > +              */
> > +             if (m)
> >                       goto found;
> > -             }
> > +             else
> > +                     return 0;
> >       }
> > -     return 0;
> >
> >  found:
> > -     BUG_ON(!IS_ALIGNED(virt_to_phys(m), huge_page_size(h)));
> >       /* Put them into a private list first because mem_map is not up y=
et */
> >       INIT_LIST_HEAD(&m->list);
> >       list_add(&m->list, &huge_boot_pages);
> > @@ -2934,12 +2943,61 @@ static void __init gather_bootmem_prealloc(void=
)
> >               cond_resched();
> >       }
> >  }
> > +static void __init hugetlb_hstate_alloc_pages_onenode(struct hstate *h=
, int nid)
> > +{
> > +     unsigned long i;
> > +     char buf[32];
> > +
> > +     for (i =3D 0; i < h->max_huge_pages_node[nid]; ++i) {
> > +             if (hstate_is_gigantic(h)) {
> > +                     if (!alloc_bootmem_huge_page(h, nid))
> > +                             break;
> > +             } else {
> > +                     struct page *page;
> > +                     gfp_t gfp_mask =3D htlb_alloc_mask(h) | __GFP_THI=
SNODE;
> > +
> > +                     page =3D alloc_fresh_huge_page(h, gfp_mask, nid,
> > +                                     &node_states[N_MEMORY], NULL);
> > +                     if (!page)
> > +                             break;
> > +                     put_page(page); /* free it into the hugepage allo=
cator */
> > +             }
> > +             cond_resched();
> > +     }
> > +     if (i =3D=3D h->max_huge_pages_node[nid])
> > +             return;
> > +
> > +     string_get_size(huge_page_size(h), 1, STRING_UNITS_2, buf, 32);
> > +     pr_warn("HugeTLB: allocating %u of page size %s failed node%d.  O=
nly allocated %lu hugepages.\n",
> > +             h->max_huge_pages_node[nid], buf, nid, i);
> > +     h->max_huge_pages -=3D (h->max_huge_pages_node[nid] - i);
> > +     h->max_huge_pages_node[nid] =3D i;
> > +}
> >
> >  static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
> >  {
> >       unsigned long i;
> >       nodemask_t *node_alloc_noretry;
> > +     bool node_specific_alloc =3D false;
> > +
> > +     /* skip gigantic hugepages allocation if hugetlb_cma enabled */
> > +     if (hstate_is_gigantic(h) && hugetlb_cma_size) {
> > +             pr_warn_once("HugeTLB: hugetlb_cma is enabled, skip boot =
time allocation\n");
> > +             return;
> > +     }
> > +
> > +     /* do node specific alloc */
> > +     for (i =3D 0; i < nr_online_nodes; i++) {
> > +             if (h->max_huge_pages_node[i] > 0) {
> > +                     hugetlb_hstate_alloc_pages_onenode(h, i);
> > +                     node_specific_alloc =3D true;
> > +             }
> > +     }
> >
> > +     if (node_specific_alloc)
> > +             return;
> > +
> > +     /* bellow will do all node balanced alloc */
>
>            below
>
> >       if (!hstate_is_gigantic(h)) {
> >               /*
> >                * Bit mask controlling how hard we retry per-node alloca=
tions.
> > @@ -2960,11 +3018,7 @@ static void __init hugetlb_hstate_alloc_pages(st=
ruct hstate *h)
> >
> >       for (i =3D 0; i < h->max_huge_pages; ++i) {
> >               if (hstate_is_gigantic(h)) {
> > -                     if (hugetlb_cma_size) {
> > -                             pr_warn_once("HugeTLB: hugetlb_cma is ena=
bled, skip boot time allocation\n");
> > -                             goto free;
> > -                     }
> > -                     if (!alloc_bootmem_huge_page(h))
> > +                     if (!alloc_bootmem_huge_page(h, NUMA_NO_NODE))
> >                               break;
> >               } else if (!alloc_pool_huge_page(h,
> >                                        &node_states[N_MEMORY],
> > @@ -2980,7 +3034,6 @@ static void __init hugetlb_hstate_alloc_pages(str=
uct hstate *h)
> >                       h->max_huge_pages, buf, i);
> >               h->max_huge_pages =3D i;
> >       }
> > -free:
> >       kfree(node_alloc_noretry);
> >  }
> >
> > @@ -3671,6 +3724,11 @@ static int __init hugetlb_init(void)
>
> >                       default_hstate.max_huge_pages =3D
> >                               default_hstate_max_huge_pages;
> > +
> > +                     for (i =3D 0; i < nr_online_nodes; i++)
> > +                             if (default_hugepages_in_node[i] > 0)
> > +                                     default_hstate.max_huge_pages_nod=
e[i] =3D
> > +                                             default_hugepages_in_node=
[i];
>
> Very minor nit.  Not necessary to change.
> The 'if (default_hugepages_in_node[i] > 0)' is not really needed.  I am
> not sure if any potential speed up by the check would be noticable.  You
> need to 'read' every value in the array.
>
> >               }
> >       }
> >
> > @@ -3731,6 +3789,10 @@ void __init hugetlb_add_hstate(unsigned int orde=
r)
> >       parsed_hstate =3D h;
> >  }
> >
> > +bool __init __weak node_specific_alloc_support(void)
> > +{
> > +     return true;
> > +}
> >  /*
> >   * hugepages command line processing
> >   * hugepages normally follows a valid hugepagsz or default_hugepagsz
> > @@ -3742,6 +3804,10 @@ static int __init hugepages_setup(char *s)
> >  {
> >       unsigned long *mhp;
> >       static unsigned long *last_mhp;
> > +     int node =3D NUMA_NO_NODE;
> > +     int count;
> > +     unsigned long tmp;
> > +     char *p =3D s;
> >
> >       if (!parsed_valid_hugepagesz) {
> >               pr_warn("HugeTLB: hugepages=3D%s does not follow a valid =
hugepagesz, ignoring\n", s);
> > @@ -3765,8 +3831,40 @@ static int __init hugepages_setup(char *s)
> >               return 0;
> >       }
> >
> > -     if (sscanf(s, "%lu", mhp) <=3D 0)
> > -             *mhp =3D 0;
> > +     while (*p) {
> > +             count =3D 0;
> > +             if (sscanf(p, "%lu%n", &tmp, &count) !=3D 1)
> > +                     goto invalid;
> > +             /* Parameter is node format */
> > +             if (p[count] =3D=3D ':') {
> > +                     if (!node_specific_alloc_support()) {
> > +                             pr_warn("HugeTLB: architecture can't supp=
ort node specific alloc, ignoring!\n");
> > +                             return 0;
> > +                     }
> > +                     node =3D tmp;
> > +                     p +=3D count + 1;
> > +                     if (node < 0 || node >=3D nr_online_nodes)
> > +                             goto invalid;
> > +                     /* Parse hugepages */
> > +                     if (sscanf(p, "%lu%n", &tmp, &count) !=3D 1)
> > +                             goto invalid;
> > +                     if (!hugetlb_max_hstate)
> > +                             default_hugepages_in_node[node] =3D tmp;
> > +                     else
> > +                             parsed_hstate->max_huge_pages_node[node] =
=3D tmp;
> > +                     *mhp +=3D tmp;
> > +                     /* Go to parse next node*/
> > +                     if (p[count] =3D=3D ',')
> > +                             p +=3D count + 1;
> > +                     else
> > +                             break;
> > +             } else {
> > +                     if (p !=3D s)
> > +                             goto invalid;
> > +                     *mhp =3D tmp;
> > +                     break;
> > +             }
> > +     }
> >
> >       /*
> >        * Global state is always initialized later in hugetlb_init.
> > @@ -3779,6 +3877,10 @@ static int __init hugepages_setup(char *s)
> >       last_mhp =3D mhp;
> >
> >       return 1;
> > +
> > +invalid:
> > +     pr_warn("HugeTLB: Invalid hugepages parameter %s\n", p);
> > +     return 0;
> >  }
> >  __setup("hugepages=3D", hugepages_setup);
> >
> > @@ -3840,6 +3942,7 @@ __setup("hugepagesz=3D", hugepagesz_setup);
> >  static int __init default_hugepagesz_setup(char *s)
> >  {
> >       unsigned long size;
> > +     int i;
> >
> >       parsed_valid_hugepagesz =3D false;
> >       if (parsed_default_hugepagesz) {
> > @@ -3868,6 +3971,10 @@ static int __init default_hugepagesz_setup(char =
*s)
> >        */
> >       if (default_hstate_max_huge_pages) {
> >               default_hstate.max_huge_pages =3D default_hstate_max_huge=
_pages;
> > +             for (i =3D 0; i < nr_online_nodes; i++)
> > +                     if (default_hugepages_in_node[i] > 0)
> > +                             default_hstate.max_huge_pages_node[i] =3D
> > +                                     default_hugepages_in_node[i];
>
> Same minor nit as in hugetlb_init.
>
> >               if (hstate_is_gigantic(&default_hstate))
> >                       hugetlb_hstate_alloc_pages(&default_hstate);
> >               default_hstate_max_huge_pages =3D 0;
> >
>
> --
> Mike Kravetz
