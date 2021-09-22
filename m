Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCF8C4144ED
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 11:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234252AbhIVJPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 05:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233741AbhIVJPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 05:15:44 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44B9C061574;
        Wed, 22 Sep 2021 02:14:14 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id i132so7584901qke.1;
        Wed, 22 Sep 2021 02:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=r8/U5lhFhptIEj0YScg0hSUpvj2Pgosre/gr4ODgB5s=;
        b=dDuVpMj2Ae6qRegobVXGfopn8pjKX0AMRL82MzRNRDu+GttaejhnWni8uoZrQjRrP4
         Yui66eF5A3wtcHwksE0seeMUwPjbzBB5EThhWJdOEoCcrJyiF5sE08i5TD9NdL870kYh
         EdUeX94tHmSvtVl1OzvJuyM9r6oS7IaDL5AuNfueb2DKYcFpSNv0oKFjimzXaWa5+n6a
         haDUDoVb03wMseGCw01qPiTwottZx62jRqbavs7d+k4kYH5B1pXAmP2xgb57G75gFRvm
         cdrOxGq4dtoASjeUUOKH+Rc6XMI7oIvGn/4FdmTdkzU+PI+Ai50wye/nfOaSRY4UGB7J
         ymvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=r8/U5lhFhptIEj0YScg0hSUpvj2Pgosre/gr4ODgB5s=;
        b=FKmokXaeD3UrDJxkVJJMl02Z5nEdFwHY+5gxt57rC0tb1N50oGKXm8Zc8ijqWpATyd
         FID9aDfJntSl7vFHpFj0KXb4YmCZI23+09/YCf9w4wre6iZv/b6CNNQIU4SpkWMzJ1LJ
         6myCjC52RzRhEOsCCQdO6NSNSzAVuSdlBc63syHKlVesvCo0xD2Dxc1Wh54iNpHcAaow
         shPMMZ5JkyeID0Ug4GWz1OxsyiCGDI4XVA1f0odqxkyu4a0nlIU4DJw0wH0oNQCMirEF
         Ynv0yizA1yb/dQ9O/+2an5WSXDRjOOgmFm5/PSUb6NDUOPG4PH/xQ39qo73vhg8d0SlH
         yvgA==
X-Gm-Message-State: AOAM530eIn8mmwS4BcFMxoGDCAjBbdfMXkoNOUdNJK+vKvT+A6gagYQp
        7AeBIVt5PDWvPaONnJX34aY1caZZIS5l0gjl4P8=
X-Google-Smtp-Source: ABdhPJw0isA2c57xhycThegrIms8reGZh0oxHfr3J2t/iZmmcplr+bD/0vczyCZa/RuTZdPPQ2dPbpQZeondKZiAoVc=
X-Received: by 2002:a25:d9c8:: with SMTP id q191mr46022669ybg.61.1632302053817;
 Wed, 22 Sep 2021 02:14:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210918113201.4133-1-yaozhenguo1@gmail.com> <YUY989PRsrVdHmSq@kernel.org>
In-Reply-To: <YUY989PRsrVdHmSq@kernel.org>
From:   zhenguo yao <yaozhenguo1@gmail.com>
Date:   Wed, 22 Sep 2021 17:14:02 +0800
Message-ID: <CA+WzAR=u5RzdOQ7DVWTQPRwSWpnD8fBZLL=CJFey4vMPBZ5x=g@mail.gmail.com>
Subject: Re: [PATCH v5] hugetlbfs: Extend the definition of hugepages
 parameter to support node allocation
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, corbet@lwn.net,
        Andrew Morton <akpm@linux-foundation.org>, yaozhenguo@jd.com,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your review.

Mike Rapoport <rppt@kernel.org> =E4=BA=8E2021=E5=B9=B49=E6=9C=8819=E6=97=A5=
=E5=91=A8=E6=97=A5 =E4=B8=8A=E5=8D=883:28=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sat, Sep 18, 2021 at 07:32:01PM +0800, yaozhenguo wrote:
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
> > Signed-off-by: yaozhenguo <yaozhenguo1@gmail.com>
> > ---
> > v4->v5 changes:
> >       - remove BUG_ON in __alloc_bootmem_huge_page.
> >       - add nid parameter in __alloc_bootmem_huge_page to support
> >         called in both specific node alloc and normal alloc.
> >       - do normal alloc if architecture can't support node specific all=
oc.
> >       - return -1 in powerpc version of alloc_bootmem_huge_page when
> >         nid is not NUMA_NO_NODE.
>
> I think, node format should not be enabled on powerpc.  Rather than add a
> new return value to alloc_bootmem_huge_page() and add complex checks for
> -1, 0 and 1, it would be simpler to add a new weak function. The default
> implementation will return true and powerpc will have an override that
> returns false.
> This function can be called during command line parsing and if it returne=
d
> false the entire per-node allocation path would be disabled.
>
Seems more clearly and simpler. I will change it.
> >
> > ---
> >  .../admin-guide/kernel-parameters.txt         |   8 +-
> >  Documentation/admin-guide/mm/hugetlbpage.rst  |  12 +-
> >  arch/powerpc/mm/hugetlbpage.c                 |   8 +-
> >  include/linux/hugetlb.h                       |   5 +-
> >  mm/hugetlb.c                                  | 155 ++++++++++++++++--
> >  5 files changed, 166 insertions(+), 22 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Document=
ation/admin-guide/kernel-parameters.txt
> > index bdb22006f..a2046b2c5 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -1588,9 +1588,11 @@
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
> > index 8abaeb144..d70828c07 100644
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
> > index 9a75ba078..4a9cea714 100644
> > --- a/arch/powerpc/mm/hugetlbpage.c
> > +++ b/arch/powerpc/mm/hugetlbpage.c
> > @@ -19,6 +19,7 @@
> >  #include <linux/swap.h>
> >  #include <linux/swapops.h>
> >  #include <linux/kmemleak.h>
> > +#include <linux/numa.h>
> >  #include <asm/pgalloc.h>
> >  #include <asm/tlb.h>
> >  #include <asm/setup.h>
> > @@ -232,14 +233,17 @@ static int __init pseries_alloc_bootmem_huge_page=
(struct hstate *hstate)
> >  #endif
> >
> >
> > -int __init alloc_bootmem_huge_page(struct hstate *h)
> > +int __init alloc_bootmem_huge_page(struct hstate *h, int nid)
> >  {
> >
> >  #ifdef CONFIG_PPC_BOOK3S_64
> > +     /* Don't support node specific alloc */
> > +     if (nid !=3D NUMA_NO_NODE)
> > +             return -1;
> >       if (firmware_has_feature(FW_FEATURE_LPAR) && !radix_enabled())
> >               return pseries_alloc_bootmem_huge_page(h);
> >  #endif
> > -     return __alloc_bootmem_huge_page(h);
> > +     return __alloc_bootmem_huge_page(h, nid);
> >  }
> >
> >  #ifndef CONFIG_PPC_BOOK3S_64
> > diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> > index f7ca1a387..a9bdbc870 100644
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
> > @@ -637,8 +638,8 @@ void restore_reserve_on_error(struct hstate *h, str=
uct vm_area_struct *vma,
> >                               unsigned long address, struct page *page)=
;
> >
> >  /* arch callback */
> > -int __init __alloc_bootmem_huge_page(struct hstate *h);
> > -int __init alloc_bootmem_huge_page(struct hstate *h);
> > +int __init __alloc_bootmem_huge_page(struct hstate *h, int nid);
> > +int __init alloc_bootmem_huge_page(struct hstate *h, int nid);
> >
> >  void __init hugetlb_add_hstate(unsigned order);
> >  bool __init arch_hugetlb_valid_size(unsigned long size);
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index dfc940d52..f7aaca6ff 100644
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
> > @@ -2774,17 +2775,30 @@ struct page *alloc_huge_page(struct vm_area_str=
uct *vma,
> >       vma_end_reservation(h, vma, addr);
> >       return ERR_PTR(-ENOSPC);
> >  }
> > -
> > -int alloc_bootmem_huge_page(struct hstate *h)
> > +/*
> > + * Architecture version must provide there own node specific hugepage
>
>                                        ^ its
>
> > + * allocation code. If not, please return -1 when nid is not NUMA_NO_N=
ODE.
> > + */
> > +int alloc_bootmem_huge_page(struct hstate *h, int nid)
> >       __attribute__ ((weak, alias("__alloc_bootmem_huge_page")));
> > -int __alloc_bootmem_huge_page(struct hstate *h)
> > +int __alloc_bootmem_huge_page(struct hstate *h, int nid)
> >  {
> >       struct huge_bootmem_page *m;
> >       int nr_nodes, node;
> > +     void *addr =3D NULL;
> >
> > +     /* do node specific alloc */
> > +     if (nid !=3D NUMA_NO_NODE && nid < nodes_weight(node_states[N_MEM=
ORY])) {
> > +             addr =3D memblock_alloc_try_nid_raw(huge_page_size(h), hu=
ge_page_size(h),
> > +                             0, MEMBLOCK_ALLOC_ACCESSIBLE, nid);
> > +             if (addr) {
> > +                     m =3D addr;
> > +                     goto found;
> > +             } else {
> > +                     return 0;
> > +             }
>
>                 if (!addr)
>                         return 0;
>                 m =3D addr;
>                 goto found;
>
> seems simpler to me.
>
> Besides, I think addr is not needed at all, m can be assigned directly. I=
'd
> also rename it to e.g. page.
>
Yes,  addr seems useless. I will remove it.
> > +     }
> >       for_each_node_mask_to_alloc(h, nr_nodes, node, &node_states[N_MEM=
ORY]) {
> > -             void *addr;
> > -
> >               addr =3D memblock_alloc_try_nid_raw(
> >                               huge_page_size(h), huge_page_size(h),
> >                               0, MEMBLOCK_ALLOC_ACCESSIBLE, node);
> > @@ -2801,7 +2815,6 @@ int __alloc_bootmem_huge_page(struct hstate *h)
> >       return 0;
> >
> >  found:
> > -     BUG_ON(!IS_ALIGNED(virt_to_phys(m), huge_page_size(h)));
> >       /* Put them into a private list first because mem_map is not up y=
et */
> >       INIT_LIST_HEAD(&m->list);
> >       list_add(&m->list, &huge_boot_pages);
> > @@ -2841,11 +2854,83 @@ static void __init gather_bootmem_prealloc(void=
)
> >               cond_resched();
> >       }
> >  }
> > +/*
> > + * do node specific hugepage allocation
> > + * return  0: allocation is failed
> > + *      1: allocation is successful
> > + *      -1: alloc_bootmem_huge_page can't support node specific alloca=
tion
> > + */
> > +static int __init hugetlb_hstate_alloc_pages_onenode(struct hstate *h,=
 int nid)
> > +{
> > +     unsigned long i;
> > +     char buf[32];
> > +     int ret =3D 1;
> > +
> > +     for (i =3D 0; i < h->max_huge_pages_node[nid]; ++i) {
> > +             if (hstate_is_gigantic(h)) {
> > +                     ret =3D alloc_bootmem_huge_page(h, nid);
> > +                     if (ret =3D=3D 0 || ret =3D=3D -1)
> > +                             break;
> > +             } else {
> > +                     struct page *page;
> > +                     gfp_t gfp_mask =3D htlb_alloc_mask(h) | __GFP_THI=
SNODE;
> > +
> > +                     page =3D alloc_fresh_huge_page(h, gfp_mask, nid,
> > +                                     &node_states[N_MEMORY], NULL);
> > +                     if (!page) {
> > +                             ret =3D 0;
> > +                             break;
> > +                     }
> > +                     put_page(page); /* free it into the hugepage allo=
cator */
> > +             }
> > +             cond_resched();
> > +     }
> > +     if (i =3D=3D h->max_huge_pages_node[nid])
> > +             return ret;
> > +
> > +     string_get_size(huge_page_size(h), 1, STRING_UNITS_2, buf, 32);
> > +     pr_warn("HugeTLB: allocating %u of page size %s failed node%d.  O=
nly allocated %lu hugepages.\n",
> > +             h->max_huge_pages_node[nid], buf, nid, i);
> > +     /*
> > +      * we need h->max_huge_pages to do normal alloc,
> > +      * when alloc_bootm_huge_page can't support node specific allocat=
ion.
> > +      */
> > +     if (ret !=3D -1)
> > +             h->max_huge_pages -=3D (h->max_huge_pages_node[nid] - i);
> > +     h->max_huge_pages_node[nid] =3D i;
> > +     return ret;
> > +}
> >
> >  static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
> >  {
> >       unsigned long i;
> >       nodemask_t *node_alloc_noretry;
> > +     bool hugetlb_node_set =3D false;
> > +
> > +     /* skip gigantic hugepages allocation if hugetlb_cma enabled */
> > +     if (hstate_is_gigantic(h) && hugetlb_cma_size) {
> > +             pr_warn_once("HugeTLB: hugetlb_cma is enabled, skip boot =
time allocation\n");
> > +             return;
> > +     }
> > +
> > +     /* do node alloc */
> > +     for (i =3D 0; i < nodes_weight(node_states[N_MEMORY]); i++) {
> > +             if (h->max_huge_pages_node[i] > 0) {
> > +                     /*
> > +                      * if hugetlb_hstate_alloc_pages_onenode return -=
1
> > +                      * architecture version alloc_bootmem_huge_page
> > +                      * can't support node specific alloc for gigantic
> > +                      * hugepage, so goto normal alloc.
> > +                      */
> > +                     if (hugetlb_hstate_alloc_pages_onenode(h, i) =3D=
=3D -1)
> > +                             pr_warn_once("HugeTLB: architecture can't=
 support node specific alloc, skip!\n");
> > +                     else
> > +                             hugetlb_node_set =3D true;
> > +             }
> > +     }
> > +
> > +     if (hugetlb_node_set)
> > +             return;
>
> If I understand correctly, this means that even if the allocation fails f=
or
> some of the nodes explicitly set in hugepages=3Dnid:pages,..., we won't t=
ry
> allocate more huge pages and silently ignore the failure. Is this the
> intended behaviour?
>
Yes, If the allocation is failed in some specific nodes. We just print
warning messages
in hugetlb_hstate_alloc_pages_onenode to remind the user to use
appropriate hugepages
parameters or check the system and do not try to allocate more huge pages.

hugetlb_node_set is used here to judge whether it is node specific
alloc in this =E2=80=9Chstate=E2=80=9D.
If it is a node specific allocation for this =E2=80=9Chstate=E2=80=9D, we s=
hould not
do old path(bellow code)
allocation whether the node specific allocation is successful or not.
> >
> >       if (!hstate_is_gigantic(h)) {
> >               /*
> > @@ -2867,11 +2952,7 @@ static void __init hugetlb_hstate_alloc_pages(st=
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
> > @@ -2887,7 +2968,6 @@ static void __init hugetlb_hstate_alloc_pages(str=
uct hstate *h)
> >                       h->max_huge_pages, buf, i);
> >               h->max_huge_pages =3D i;
> >       }
> > -free:
> >       kfree(node_alloc_noretry);
> >  }
> >
>
> --
> Sincerely yours,
> Mike.
