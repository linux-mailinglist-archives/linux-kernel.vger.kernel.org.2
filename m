Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0A593FED8D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 14:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344127AbhIBMM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 08:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240886AbhIBMM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 08:12:26 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEE4C061575;
        Thu,  2 Sep 2021 05:11:26 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id n126so3357579ybf.6;
        Thu, 02 Sep 2021 05:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lA7U5Gs1pe3fxJpY0tBfoQlgJS/Jxw3bWbYORjCx7fE=;
        b=U4Tfr9XZSBNEmwd6jiLTvDrJ+r2Aadm4+Q0JUb9paTY/Qf23lYaKG7Z2lA3s/AL6i7
         giNC6Ng5QjYxsFONLWkmGKQOEjw93Is9epoXVInACYJjITZJv6FTvD2Cc0f2C266SgEQ
         +jtMCVqLDieYAMTUGOHpq9jswQxOeBKoP1sh8A8ykEjUVSHMdPlLepdLJdY09BnAAF3C
         lKW94nRHoFUJoc9nbMBtlH2qEOahzTI658bgmEuKH/t5LiUE/FtVaK+Ove/7/BXtk2ha
         eYKqTOqsddmBqm6+mUmOCKjj2cUodkoXzw3fDH3Zh/Cb1o0ONcLEFahmFwWjOPCYbVXE
         b5zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lA7U5Gs1pe3fxJpY0tBfoQlgJS/Jxw3bWbYORjCx7fE=;
        b=qp84uYeVfu5apLH8RAaREnKCw/69rL08pRF9tU6p9GuOYVOFP8m1elwuaH3TFdxdNt
         zfDUNm+gI/Kx9JIE44LLBkM5IWepO+j0GrN0eV+TIEgxLeC8qtM3wpcCuLB92p8ymsAi
         ZgY3/WWG2/ftRPQ8ukxjoUTy94ChrXYraXVL6IueNhqilZxpqmVfw19XEt5MkhRBGCru
         0ACO2jDzGSFsyzexqbrPdiWoGnk0suuzqLlvbTj2Mdwx8zbwq7ZNuRHpWMPKWepJUjXI
         3z9l1Zy5y32gnUVlKeNxuRS07QlKvsUPmXA67eyfL7fheNEaxoZ0dib19voPX13SlGAN
         BdVw==
X-Gm-Message-State: AOAM531KMeILUPXo+VvnUHpNSJ/Ui73ep/LM6tq9w4LwK+f8uW5Fy8Qf
        esM3hKohv9062goHu4wDIJyf9u/4b1fXN74z/Ko=
X-Google-Smtp-Source: ABdhPJyCKVZu5rQzGyqfkkVY0fJLQGCEqa42NFkGZ32EzedKiv8r+mf3FzhKVh9+OW1a68nbPKtlqMNRlEbAe+Oq0gw=
X-Received: by 2002:a25:54b:: with SMTP id 72mr3982528ybf.237.1630584685756;
 Thu, 02 Sep 2021 05:11:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210902065902.81943-1-yaozhenguo1@gmail.com>
In-Reply-To: <20210902065902.81943-1-yaozhenguo1@gmail.com>
From:   zhenguo yao <yaozhenguo1@gmail.com>
Date:   Thu, 2 Sep 2021 20:11:14 +0800
Message-ID: <CA+WzARkfvpja3t4oZAmi7+XZXBaPv3uCnL6ngbywvHqv07Lj8g@mail.gmail.com>
Subject: Re: [v3] hugetlbfs: Extend the definition of hugepages parameter to
 support node allocation
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     corbet@lwn.net, Andrew Morton <akpm@linux-foundation.org>,
        yaozhenguo@jd.com, Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cc linux-mm@kvack.org

yaozhenguo <yaozhenguo1@gmail.com> =E4=BA=8E2021=E5=B9=B49=E6=9C=882=E6=97=
=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=882:59=E5=86=99=E9=81=93=EF=BC=9A
>
> We can specify the number of hugepages to allocate at boot. But the
> hugepages is balanced in all nodes at present. In some scenarios,
> we only need hugepages in one node. For example: DPDK needs hugepages
> which is in the same node as NIC. if DPDK needs four hugepages of 1G
> size in node1 and system has 16 numa nodes. We must reserve 64 hugepages
> in kernel cmdline. But, only four hugepages are used. The others should
> be free after boot.If the system memory is low(for example: 64G), it will
> be an impossible task. So, extend hugepages kernel parameter to specify
> node number of hugepages to allocate at boot.
> For example add following parameter:
>
> hugepagesz=3D1G hugepages=3D0:1,1:3
>
> It will allocate 1 hugepages in node0 and 3 hugepages in node1.
>
> Signed-off-by: yaozhenguo <yaozhenguo1@gmail.com>
> ---
> v3:     1. Skip gigantic hugepages allocation if hugetlb_cma is enabled.
>         2. Fix wrong behavior for parameter: hugepagesz=3D2M hugepages=3D=
2 hugepages=3D5.
>         3. Update hugetlbpage.rst.
>         4. Fix side effects which v2 brings in.
>         5. add cond_resched in hugetlb_hstate_alloc_pages_onenode.
> ---
>  .../admin-guide/kernel-parameters.txt         |   8 +-
>  Documentation/admin-guide/mm/hugetlbpage.rst  |  12 +-
>  include/linux/hugetlb.h                       |   1 +
>  mm/hugetlb.c                                  | 116 ++++++++++++++++--
>  4 files changed, 126 insertions(+), 11 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index bdb22006f..64a128924 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1588,9 +1588,11 @@
>                         the number of pages of hugepagesz to be allocated=
.
>                         If this is the first HugeTLB parameter on the com=
mand
>                         line, it specifies the number of pages to allocat=
e for
> -                       the default huge page size.  See also
> -                       Documentation/admin-guide/mm/hugetlbpage.rst.
> -                       Format: <integer>
> +                       the default huge page size. If using node format,=
 It
> +                       specifies numbers of hugepage in a specific node.
> +                       See also Documentation/admin-guide/mm/hugetlbpage=
.rst.
> +                       Format: <integer> or (node format)
> +                               <node>:<numbers>[,<node>:<numbers>]
>
>         hugepagesz=3D
>                         [HW] The size of the HugeTLB pages.  This is used=
 in
> diff --git a/Documentation/admin-guide/mm/hugetlbpage.rst b/Documentation=
/admin-guide/mm/hugetlbpage.rst
> index 8abaeb144..bc5f674ff 100644
> --- a/Documentation/admin-guide/mm/hugetlbpage.rst
> +++ b/Documentation/admin-guide/mm/hugetlbpage.rst
> @@ -128,7 +128,9 @@ hugepages
>         implicitly specifies the number of huge pages of default size to
>         allocate.  If the number of huge pages of default size is implici=
tly
>         specified, it can not be overwritten by a hugepagesz,hugepages
> -       parameter pair for the default size.
> +       parameter pair for the default size. This parameter also has node
> +       format. It specifies numbers of hugepage in a specific node when
> +       using node format.
>
>         For example, on an architecture with 2M default huge page size::
>
> @@ -138,6 +140,14 @@ hugepages
>         indicating that the hugepages=3D512 parameter is ignored.  If a h=
ugepages
>         parameter is preceded by an invalid hugepagesz parameter, it will
>         be ignored.
> +
> +       Node format example::
> +
> +               hugepagesz=3D2M hugepages=3D0:1,1:2
> +
> +       It will allocate 1 2M hugepages in node0 and 2 2M hugepages in no=
de1.
> +       If the node number exceeds the maximum node, the parameter will b=
e
> +       ignored.
>  default_hugepagesz
>         Specify the default huge page size.  This parameter can
>         only be specified once on the command line.  default_hugepagesz c=
an
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index f7ca1a387..5939ecd4f 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -605,6 +605,7 @@ struct hstate {
>         unsigned long nr_overcommit_huge_pages;
>         struct list_head hugepage_activelist;
>         struct list_head hugepage_freelists[MAX_NUMNODES];
> +       unsigned int max_huge_pages_node[MAX_NUMNODES];
>         unsigned int nr_huge_pages_node[MAX_NUMNODES];
>         unsigned int free_huge_pages_node[MAX_NUMNODES];
>         unsigned int surplus_huge_pages_node[MAX_NUMNODES];
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index dfc940d52..317f8fa21 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -66,6 +66,7 @@ static struct hstate * __initdata parsed_hstate;
>  static unsigned long __initdata default_hstate_max_huge_pages;
>  static bool __initdata parsed_valid_hugepagesz =3D true;
>  static bool __initdata parsed_default_hugepagesz;
> +static unsigned int default_hugepages_in_node[MAX_NUMNODES] __initdata;
>
>  /*
>   * Protects updates to hugepage_freelists, hugepage_activelist, nr_huge_=
pages,
> @@ -2842,10 +2843,75 @@ static void __init gather_bootmem_prealloc(void)
>         }
>  }
>
> +static void __init hugetlb_hstate_alloc_pages_onenode(struct hstate *h, =
int nid)
> +{
> +       unsigned long i;
> +       char buf[32];
> +
> +       for (i =3D 0; i < h->max_huge_pages_node[nid]; ++i) {
> +               if (hstate_is_gigantic(h)) {
> +                       struct huge_bootmem_page *m;
> +                       void *addr;
> +
> +                       addr =3D memblock_alloc_try_nid_raw(
> +                                       huge_page_size(h), huge_page_size=
(h),
> +                                       0, MEMBLOCK_ALLOC_ACCESSIBLE, nid=
);
> +                       if (!addr)
> +                               break;
> +                       m =3D addr;
> +                       BUG_ON(!IS_ALIGNED(virt_to_phys(m), huge_page_siz=
e(h)));
> +                       /*
> +                        * Put them into a private list first because mem=
_map
> +                        * is not up yet
> +                        */
> +                       INIT_LIST_HEAD(&m->list);
> +                       list_add(&m->list, &huge_boot_pages);
> +                       m->hstate =3D h;
> +               } else {
> +                       struct page *page;
> +
> +                       gfp_t gfp_mask =3D htlb_alloc_mask(h) | __GFP_THI=
SNODE;
> +
> +                       page =3D alloc_fresh_huge_page(h, gfp_mask, nid,
> +                                       &node_states[N_MEMORY], NULL);
> +                       if (!page)
> +                               break;
> +                       put_page(page); /* free it into the hugepage allo=
cator */
> +               }
> +               cond_resched();
> +       }
> +       if (i =3D=3D h->max_huge_pages_node[nid])
> +               return;
> +
> +       string_get_size(huge_page_size(h), 1, STRING_UNITS_2, buf, 32);
> +       pr_warn("HugeTLB: allocating %u of page size %s failed node%d.  O=
nly allocated %lu hugepages.\n",
> +               h->max_huge_pages_node[nid], buf, nid, i);
> +       h->max_huge_pages_node[nid] =3D i;
> +       h->max_huge_pages -=3D (h->max_huge_pages_node[nid] - i);
> +}
> +
>  static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
>  {
>         unsigned long i;
>         nodemask_t *node_alloc_noretry;
> +       bool hugetlb_node_set =3D false;
> +
> +       /* skip gigantic hugepages allocation if hugetlb_cma enabled */
> +       if (hstate_is_gigantic(h) && hugetlb_cma_size) {
> +               pr_warn_once("HugeTLB: hugetlb_cma is enabled, skip boot =
time allocation\n");
> +               return;
> +       }
> +
> +       /* do node alloc */
> +       for (i =3D 0; i < nodes_weight(node_states[N_MEMORY]); i++) {
> +               if (h->max_huge_pages_node[i] > 0) {
> +                       hugetlb_hstate_alloc_pages_onenode(h, i);
> +                       hugetlb_node_set =3D true;
> +               }
> +       }
> +
> +       if (hugetlb_node_set)
> +               return;
>
>         if (!hstate_is_gigantic(h)) {
>                 /*
> @@ -2867,10 +2933,6 @@ static void __init hugetlb_hstate_alloc_pages(stru=
ct hstate *h)
>
>         for (i =3D 0; i < h->max_huge_pages; ++i) {
>                 if (hstate_is_gigantic(h)) {
> -                       if (hugetlb_cma_size) {
> -                               pr_warn_once("HugeTLB: hugetlb_cma is ena=
bled, skip boot time allocation\n");
> -                               goto free;
> -                       }
>                         if (!alloc_bootmem_huge_page(h))
>                                 break;
>                 } else if (!alloc_pool_huge_page(h,
> @@ -2887,7 +2949,6 @@ static void __init hugetlb_hstate_alloc_pages(struc=
t hstate *h)
>                         h->max_huge_pages, buf, i);
>                 h->max_huge_pages =3D i;
>         }
> -free:
>         kfree(node_alloc_noretry);
>  }
>
> @@ -3580,6 +3641,10 @@ static int __init hugetlb_init(void)
>                                 default_hstate_max_huge_pages;
>                 }
>         }
> +       for (i =3D 0; i < nodes_weight(node_states[N_MEMORY]); i++)
> +               if (default_hugepages_in_node[i] > 0)
> +                       default_hstate.max_huge_pages_node[i] =3D
> +                                       default_hugepages_in_node[i];
>
>         hugetlb_cma_check();
>         hugetlb_init_hstates();
> @@ -3649,6 +3714,10 @@ static int __init hugepages_setup(char *s)
>  {
>         unsigned long *mhp;
>         static unsigned long *last_mhp;
> +       unsigned int node =3D NUMA_NO_NODE;
> +       int count;
> +       unsigned long tmp;
> +       char *p =3D s;
>
>         if (!parsed_valid_hugepagesz) {
>                 pr_warn("HugeTLB: hugepages=3D%s does not follow a valid =
hugepagesz, ignoring\n", s);
> @@ -3672,8 +3741,37 @@ static int __init hugepages_setup(char *s)
>                 return 0;
>         }
>
> -       if (sscanf(s, "%lu", mhp) <=3D 0)
> -               *mhp =3D 0;
> +       while (*p) {
> +               count =3D 0;
> +               if (sscanf(p, "%lu%n", &tmp, &count) !=3D 1)
> +                       goto invalid;
> +               /* Parameter is node format */
> +               if (p[count] =3D=3D ':') {
> +                       node =3D tmp;
> +                       p +=3D count + 1;
> +                       if (node < 0 ||
> +                               node >=3D nodes_weight(node_states[N_MEMO=
RY]))
> +                               goto invalid;
> +                       /* Parse hugepages */
> +                       if (sscanf(p, "%lu%n", &tmp, &count) !=3D 1)
> +                               goto invalid;
> +                       if (!hugetlb_max_hstate)
> +                               default_hugepages_in_node[node] =3D tmp;
> +                       else
> +                               parsed_hstate->max_huge_pages_node[node] =
=3D tmp;
> +                       *mhp +=3D tmp;
> +                       /* Go to parse next node*/
> +                       if (p[count] =3D=3D ',')
> +                               p +=3D count + 1;
> +                       else
> +                               break;
> +               } else {
> +                       if (p !=3D s)
> +                               goto invalid;
> +                       *mhp =3D tmp;
> +                       break;
> +               }
> +       }
>
>         /*
>          * Global state is always initialized later in hugetlb_init.
> @@ -3686,6 +3784,10 @@ static int __init hugepages_setup(char *s)
>         last_mhp =3D mhp;
>
>         return 1;
> +
> +invalid:
> +       pr_warn("HugeTLB: Invalid hugepages parameter %s\n", p);
> +       return 0;
>  }
>  __setup("hugepages=3D", hugepages_setup);
>
> --
> 2.27.0
>
