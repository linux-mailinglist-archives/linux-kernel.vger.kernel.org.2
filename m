Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98C1F3FC7B6
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 14:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbhHaM7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 08:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbhHaM7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 08:59:09 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B403C061575;
        Tue, 31 Aug 2021 05:58:14 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id r4so34738461ybp.4;
        Tue, 31 Aug 2021 05:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JMsTpTVMZq7gvmUh021z/8rT9+eN/7M8i1ngOTsjSWA=;
        b=OXMxALOe+FCfcQe/n3ihBjok/iVHCWyLDFtlrKC7wFwRP2GjJKWPG+xTqGFa/OPVXQ
         kjrR3Ee9VooNLQ6Vow88RMvWkNVg27WEwGzQx90ymC4zbusFwJ4MOQulwgxqt+P0eRia
         oP9CbKfIxB02gCIusMiXE/TeKMInZ+nGSQ83mw7pgu8AqshGiUlOysgOF8MhUG08hghj
         44RIkOPVAV/aCtJyU083vGJh23BwbsmZe7UaTrkYz6nb1VFDNiKh2vrcLk/WpKQE1fhw
         UUlqbXUh1kbTPPHtctHYHRFUeOUGxvsBYKKmcLn5OYYM67/nWztbnWWJ0n/V9ETIDPj6
         ptnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JMsTpTVMZq7gvmUh021z/8rT9+eN/7M8i1ngOTsjSWA=;
        b=H8GmFrt1hu/aDYd7GrF4zlEzV9xOfWXkfutU9WtkRp0mtpp1JhUy5c+/PT6x2dThIj
         kuZhi/AX76EY7zT/8PXq2TpSvLUhxx8MPeeIOLu8SMqqFCN78YoJ2W8fr9gAE5TK/uTR
         FXUNLSj7j/aLfQqzSrk2ZD7YwR8p3PTsApM+Dyr0Vltm7ONnKOGxzfLoAKhat3EBqjLu
         9HUnF7v6C+WetmaiFr+5uhxj3GksEUW+UUYeLDCmt86jdMwp/DiZ/uKYH81TVUalgBjl
         XJEoN9S4E4E8Cdg4XwbQhCLbZLnXpIEQw//JcJQB/GTvrd5wUc5DExiguZiaRnXW7Lvq
         CDCA==
X-Gm-Message-State: AOAM532opbjATD9TcqXuVfU70/S5GqAHRE24u7/ims/oX1zQTHmGqGQa
        Nis2x0X2t7lVYlx+e+NgLITUtQCwoTKxYvI/Y184w+Pd7KrGUtPNVP0=
X-Google-Smtp-Source: ABdhPJy1/E33qmF4jE+jHaOS377/qj7jDf1eRXxnZd/UpjLbqi2Fp0+Wi5RHqtyRRvtx/Pfz3GFt8SAfIU7xKhIGCi4=
X-Received: by 2002:a25:b7c8:: with SMTP id u8mr29928219ybj.268.1630414693732;
 Tue, 31 Aug 2021 05:58:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210827015839.90219-1-yaozhenguo1@gmail.com> <cb57eb20-4812-674c-5488-277449cc06f8@oracle.com>
In-Reply-To: <cb57eb20-4812-674c-5488-277449cc06f8@oracle.com>
From:   zhenguo yao <yaozhenguo1@gmail.com>
Date:   Tue, 31 Aug 2021 20:58:02 +0800
Message-ID: <CA+WzAR=8y7fi007ccHM7pZyKFy5xB4BATN23UdSk-4HTxxz2KQ@mail.gmail.com>
Subject: Re: [v2] hugetlbfs: Extend the definition of hugepages parameter to
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

thanks for your review. I will fix all in the next version and do a fully t=
est.

Mike Kravetz <mike.kravetz@oracle.com> =E4=BA=8E2021=E5=B9=B48=E6=9C=8831=
=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=887:51=E5=86=99=E9=81=93=EF=BC=
=9A
>
> Thank you for continuing to work on this.  Some comments below.
>
> On 8/26/21 6:58 PM, yaozhenguo wrote:
> > We can specify the number of hugepages to allocate at boot. But the
> > hugepages is balanced in all nodes at present. In some scenarios,
> > we only need hugepags in one node. For example: DPDK needs hugepages
> > which is in the same node as NIC. if DPDK needs four hugepags of 1G
> > size in node1 and system has 16 numa nodes. We must reserve 64 hugepags
> > in kernel cmdline. But, only four hugepages is used. The others should
> > be free after boot.If the system memory is low(for example: 64G), it wi=
ll
> > be an impossible task. So, extend hugepages kernel parameter to specify
> > node number of hugepages to allocate at boot.
> > For example add following parameter:
> >
> > hugepagesz=3D1G hugepages=3D0:1,1:3
> >
> > It will allocate 1 hugepags in node0 and 3 hugepages in node1.
>                      hugepages
> >
> > Signed-off-by: yaozhenguo <yaozhenguo1@gmail.com>
> > ---
> > v2: 1. add checking for max node to avoid array out of bounds.
> >     2. fix wrong max_huge_pages after failed allocation.
> >     3. fix wrong behavior when parsing parameter: hugepages=3D0:1,2,3:4=
.
> >     4. return 0 when parsing invalid parameter in hugepages_setup
> > ---
> >  .../admin-guide/kernel-parameters.txt         |   8 +-
> >  include/linux/hugetlb.h                       |   1 +
> >  mm/hugetlb.c                                  | 133 ++++++++++++++++--
> >  3 files changed, 126 insertions(+), 16 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Document=
ation/admin-guide/kernel-parameters.txt
> > index bdb22006f..64a128924 100644
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
 It
> > +                     specifies numbers of hugepage in a specific node.
> > +                     See also Documentation/admin-guide/mm/hugetlbpage=
.rst.
>
> Documentation/admin-guide/mm/hugetlbpage.rst also describes the
> hugepages parameter.  It should also be updated.
>
ok.
> > +                     Format: <integer> or (node format)
> > +                             <node>:<numbers>[,<node>:<numbers>]
> >
> >       hugepagesz=3D
> >                       [HW] The size of the HugeTLB pages.  This is used=
 in
> > diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> > index f7ca1a387..5939ecd4f 100644
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
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index dfc940d52..9e9d94b2a 100644
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
> > @@ -2842,10 +2843,65 @@ static void __init gather_bootmem_prealloc(void=
)
> >       }
> >  }
> >
> > +static void __init hugetlb_hstate_alloc_pages_onenode(struct hstate *h=
, int nid)
> > +{
> > +     unsigned long i;
> > +     char buf[32];
> > +
> > +     for (i =3D 0; i < h->max_huge_pages_node[nid]; ++i) {
> > +             if (hstate_is_gigantic(h)) {
> > +                     struct huge_bootmem_page *m;
> > +                     void *addr;
> > +
> > +                     addr =3D memblock_alloc_try_nid_raw(
> > +                                     huge_page_size(h), huge_page_size=
(h),
> > +                                     0, MEMBLOCK_ALLOC_ACCESSIBLE, nid=
);
> > +                     if (!addr)
> > +                             break;
> > +                     m =3D addr;
> > +                     BUG_ON(!IS_ALIGNED(virt_to_phys(m), huge_page_siz=
e(h)));
> > +                     /* Put them into a private list first because mem=
_map is not up yet */
> > +                     INIT_LIST_HEAD(&m->list);
> > +                     list_add(&m->list, &huge_boot_pages);
> > +                     m->hstate =3D h;
> > +             } else {
> > +                     struct page *page;
> > +
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
> > +     }
> > +     if (i =3D=3D h->max_huge_pages_node[nid])
> > +             return;
> > +
> > +     string_get_size(huge_page_size(h), 1, STRING_UNITS_2, buf, 32);
> > +     pr_warn("HugeTLB: allocating %u of page size %s failed node%d.  O=
nly allocated %lu hugepages.\n",
> > +             h->max_huge_pages_node[nid], buf, nid, i);
> > +     h->max_huge_pages_node[nid] =3D i;
> > +     h->max_huge_pages -=3D (h->max_huge_pages_node[nid] - i);
> > +}
> > +
> >  static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
> >  {
> >       unsigned long i;
> >       nodemask_t *node_alloc_noretry;
> > +     bool hugetlb_node_set =3D false;
> > +
> > +     /* do node alloc */
> > +     for (i =3D 0; i < nodes_weight(node_states[N_MEMORY]); i++) {
> > +             if (h->max_huge_pages_node[i] > 0) {
> > +                     hugetlb_hstate_alloc_pages_onenode(h, i);
> > +                     hugetlb_node_set =3D true;
> > +             }
> > +     }
>
> How does this interact with the hugetlb_cma parameter?  Currently, boot
> time allocation of gigantic pages is skipped if hugetlb_cma is
> specified.  Looks like the above code will allocate them.
>
> This also brings up the quesiton,  Should hugetlb_cma be changed to be
> node specific as well?
>
> For now, I would keep the current behavior and skip all boot time
> allocation of gigantic pages if hugetlb_cma.
>
I will skip gigantic pages allocation when hugetlb_cma is enabled in
the next version.
For the function of hugetlb_cma node specific allocation, I think it's
also needed. I will send another patch for it later.
> > +
> > +     if (hugetlb_node_set)
> > +             return;
> >
> >       if (!hstate_is_gigantic(h)) {
> >               /*
> > @@ -3580,6 +3636,9 @@ static int __init hugetlb_init(void)
> >                               default_hstate_max_huge_pages;
> >               }
> >       }
> > +     for (i =3D 0; i < nodes_weight(node_states[N_MEMORY]); i++)
> > +             if (default_hugepages_in_node[i] > 0)
> > +                     default_hstate.max_huge_pages_node[i] =3D default=
_hugepages_in_node[i];
> >
> >       hugetlb_cma_check();
> >       hugetlb_init_hstates();
> > @@ -3649,6 +3708,11 @@ static int __init hugepages_setup(char *s)
> >  {
> >       unsigned long *mhp;
> >       static unsigned long *last_mhp;
> > +     unsigned int node =3D NUMA_NO_NODE;
> > +     int ret;
> > +     int count;
> > +     unsigned long tmp;
> > +     char *p =3D s;
> >
> >       if (!parsed_valid_hugepagesz) {
> >               pr_warn("HugeTLB: hugepages=3D%s does not follow a valid =
hugepagesz, ignoring\n", s);
> > @@ -3656,25 +3720,68 @@ static int __init hugepages_setup(char *s)
> >               return 0;
> >       }
> >
> > -     /*
> > -      * !hugetlb_max_hstate means we haven't parsed a hugepagesz=3D pa=
rameter
> > -      * yet, so this hugepages=3D parameter goes to the "default hstat=
e".
> > -      * Otherwise, it goes with the previously parsed hugepagesz or
> > -      * default_hugepagesz.
> > -      */
> > -     else if (!hugetlb_max_hstate)
> > -             mhp =3D &default_hstate_max_huge_pages;
> > -     else
> > -             mhp =3D &parsed_hstate->max_huge_pages;
> > +     while (*p) {
> > +             count =3D 0;
> > +             ret =3D sscanf(p, "%lu%n", &tmp, &count);
> > +             if (ret !=3D 1) {
> > +                     pr_warn("HugeTLB: Invalid hugepages parameter %s\=
n", p);
> > +                     return 0;
> > +             }
> > +             /* Parameter is node format */
> > +             if (p[count] =3D=3D ':') {
> > +                     node =3D tmp;
> > +                     p +=3D count + 1;
> > +                     if (node < 0 || node >=3D nodes_weight(node_state=
s[N_MEMORY])) {
> > +                             pr_warn("HugeTLB: Invalid hugepages param=
eter node:%d\n", node);
> > +                             return 0;
> > +                     }
> > +                     if (!hugetlb_max_hstate)
> > +                             mhp =3D (unsigned long *)
> > +                                     &(default_hugepages_in_node[node]=
);
> > +                     else
> > +                             mhp =3D (unsigned long *)
> > +                                     &(parsed_hstate->max_huge_pages_n=
ode[node]);
> > +                     /* Parse hugepages */
> > +                     ret =3D sscanf(p, "%lu%n", mhp, &count);
> > +                     if (ret !=3D 1) {
> > +                             pr_warn("HugeTLB: Invalid hugepages param=
eter %s\n", p);
> > +                             return 0;
> > +                     }
> > +                     if (!hugetlb_max_hstate)
> > +                             default_hstate_max_huge_pages +=3D *mhp;
> > +                     else
> > +                             parsed_hstate->max_huge_pages +=3D *mhp;
> > +                     /* Go to parse next node*/
> > +                     if (p[count] =3D=3D ',')
> > +                             p +=3D count + 1;
> > +                     else
> > +                             break;
> > +             } else if (p =3D=3D s) {
> > +
> > +                     /*
> > +                      * !hugetlb_max_hstate means we haven't parsed a =
hugepagesz=3D parameter
> > +                      * yet, so this hugepages=3D parameter goes to th=
e "default hstate".
> > +                      * Otherwise, it goes with the previously parsed =
hugepagesz or
> > +                      * default_hugepagesz.
> > +                      */
> > +                     if (!hugetlb_max_hstate) {
> > +                             default_hstate_max_huge_pages =3D tmp;
> > +                             mhp =3D &default_hstate_max_huge_pages;
> > +                     } else {
> > +                             parsed_hstate->max_huge_pages =3D tmp;
> > +                             mhp =3D &parsed_hstate->max_huge_pages;
> > +                     }
> > +                     break;
> > +             }
> > +             pr_warn("HugeTLB: Invalid hugepages parameter %s\n", p);
> > +             return 0;
> > +     }
> >
> >       if (mhp =3D=3D last_mhp) {
> >               pr_warn("HugeTLB: hugepages=3D specified twice without in=
terleaving hugepagesz=3D, ignoring hugepages=3D%s\n", s);
> >               return 0;
> >       }
>
> This check for 'mhp =3D=3D last_mhp' after setting parameters will result=
 in
> a change of behavior.  For example, consider the following command line
> options:
>
>         hugepagesz=3D2M hugepages=3D2 hugepages=3D5
>
> Before this change,
>
> # dmesg | grep -i huge
> [    0.000000] Command line: BOOT_IMAGE=3D/vmlinuz-5.14.0+.old root=3D/de=
v/mapper/fedora_new--host-root ro rd.lvm.lv=3Dfedora_new-host/root rd.lvm.l=
v=3Dfedora_new-host/swap console=3Dtty0 console=3DttyS0,115200 audit=3D0 tr=
ansparent_hugepage=3Dalways hugetlb_free_vmemmap=3Don hugepagesz=3D2M hugep=
ages=3D2 hugepages=3D5
> [    0.054206] Kernel command line: BOOT_IMAGE=3D/vmlinuz-5.14.0+.old roo=
t=3D/dev/mapper/fedora_new--host-root ro rd.lvm.lv=3Dfedora_new-host/root r=
d.lvm.lv=3Dfedora_new-host/swap console=3Dtty0 console=3DttyS0,115200 audit=
=3D0 transparent_hugepage=3Dalways hugetlb_free_vmemmap=3Don hugepagesz=3D2=
M hugepages=3D2 hugepages=3D5
> [    0.054271] HugeTLB: can free 6 vmemmap pages for hugepages-2048kB
> [    0.054282] HugeTLB: hugepages=3D specified twice without interleaving=
 hugepagesz=3D, ignoring hugepages=3D5
> [    0.054286] Unknown command line parameters: BOOT_IMAGE=3D/vmlinuz-5.1=
4.0+.old hugepages=3D5
> [    0.412456] HugeTLB: can free 4094 vmemmap pages for hugepages-1048576=
kB
> [    0.424527] HugeTLB registered 2.00 MiB page size, pre-allocated 2 pag=
es
> [    0.425459] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pag=
es
> [    5.168890]     hugepages=3D5
>
> After this change,
>
> # dmesg | grep -i huge
> [    0.000000] Command line: BOOT_IMAGE=3D/vmlinuz-5.14.0+ root=3D/dev/ma=
pper/fedora_new--host-root ro rd.lvm.lv=3Dfedora_new-host/root rd.lvm.lv=3D=
fedora_new-host/swap console=3Dtty0 console=3DttyS0,115200 audit=3D0 transp=
arent_hugepage=3Dalways hugetlb_free_vmemmap=3Don hugepagesz=3D2M hugepages=
=3D2 hugepages=3D5
> [    0.054569] Kernel command line: BOOT_IMAGE=3D/vmlinuz-5.14.0+ root=3D=
/dev/mapper/fedora_new--host-root ro rd.lvm.lv=3Dfedora_new-host/root rd.lv=
m.lv=3Dfedora_new-host/swap console=3Dtty0 console=3DttyS0,115200 audit=3D0=
 transparent_hugepage=3Dalways hugetlb_free_vmemmap=3Don hugepagesz=3D2M hu=
gepages=3D2 hugepages=3D5
> [    0.054636] HugeTLB: can free 6 vmemmap pages for hugepages-2048kB
> [    0.054647] HugeTLB: hugepages=3D specified twice without interleaving=
 hugepagesz=3D, ignoring hugepages=3D5
> [    0.054651] Unknown command line parameters: BOOT_IMAGE=3D/vmlinuz-5.1=
4.0+ hugepages=3D5
> [    0.413714] HugeTLB: can free 4094 vmemmap pages for hugepages-1048576=
kB
> [    0.427774] HugeTLB registered 2.00 MiB page size, pre-allocated 5 pag=
es
> [    0.428628] HugeTLB registered 1.
>
I will fix it in the next version
> --
> Mike Kravetz
>
> >
> > -     if (sscanf(s, "%lu", mhp) <=3D 0)
> > -             *mhp =3D 0;
> > -
> >       /*
> >        * Global state is always initialized later in hugetlb_init.
> >        * But we need to allocate gigantic hstates here early to still
> >
