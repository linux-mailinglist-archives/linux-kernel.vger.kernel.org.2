Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB0041BEC6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 07:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244274AbhI2FkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 01:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243585AbhI2FkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 01:40:07 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CADC06161C;
        Tue, 28 Sep 2021 22:38:26 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id b82so2825273ybg.1;
        Tue, 28 Sep 2021 22:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5ztsiqAX3AYgWG18b943VFbtp7/SfntcI2880JjxeAU=;
        b=f1d6CzJbbhEpoUsytAYkt/ziq9L+2m2NcmNHs3VOKO09Hty1IGqtaIs4JsoS/kdCC3
         wMQF5JWof7knpNS3wDzN+XuhNcKDHD/eqoULwFstloRUQerKzijmhjSqd8lh1bpQpYpO
         yTJCSWVyvMAq6Q6y/pAmaQyArgYHXUexSDX157lMQPDeexslCa9zFp1R++qrB2vMRERA
         rE4DfzR18mycN9q8Lr0sC4d/Pqk3R93uKjCg3Vz+Ga96ItbTlcjhUKHIfdE0GiW6HQWJ
         33Nclt37+5g07AMXv/HzcehbgLcDLhCXDgQajCNJ96W1Tw/Hms4G9e0FgqBTh2Zs27Ea
         FL3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5ztsiqAX3AYgWG18b943VFbtp7/SfntcI2880JjxeAU=;
        b=s+c/oWygOewnJRp5MOM58CUWwgTI7Ucs3vlrprhKmchBqGRgs6mYsI33ATRaf/eBkd
         0VD+6XEpDLo8o4r3CA5LL85Jr8mAJPcVbIPqEv/NkX1GZEP0bB5f/loVbmhCRH66e9dc
         oVmOUR7kXs4s+T/fFyUIoriukIhV6/0CuIARvUvX7MGre9Cunrq1bZbyeGF6b9T1mA0S
         KwfJmQ5h2AiQU6TChXZPoJGKS35Kuhf4ZPFN8uZUEL70+HJrNEyL6B5M94iE7Vq0mYaP
         Kvpuo2uqbyaoU7pA5rPpFi0rbFWctAx7rlHBMK08r+yPhdKondNs8v9FwJx9/0EVYxix
         rdxQ==
X-Gm-Message-State: AOAM531W0bzMkAtP+ATteXSneuRXR1Re30MBCi08/uDQjHlFcJ/7Hj6R
        JloRkA3LaWqiDmRJ8kDginrAw+NLGac9YRQWJ2g=
X-Google-Smtp-Source: ABdhPJxe/ywDtg1YeCswW8swTkhx53zYX0oC7IN4j3bnhNTvMGH/NngSiQvuhMiTuZNEAr/cDBCGChTcWMI7jgwUnRc=
X-Received: by 2002:a25:30c2:: with SMTP id w185mr11165444ybw.321.1632893906007;
 Tue, 28 Sep 2021 22:38:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210927104149.46884-1-yaozhenguo1@gmail.com> <YVNHIzpmxSotbbBX@kernel.org>
In-Reply-To: <YVNHIzpmxSotbbBX@kernel.org>
From:   Zhenguo Yao <yaozhenguo1@gmail.com>
Date:   Wed, 29 Sep 2021 13:38:15 +0800
Message-ID: <CA+WzARnv0Ju8F_Dei+BBU8jHtVWJj12uJ2w9He1pF7R9ZzGMQQ@mail.gmail.com>
Subject: Re: [PATCH v7] hugetlbfs: Extend the definition of hugepages
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

Thanks for your advice.

Mike Rapoport <rppt@kernel.org> =E4=BA=8E2021=E5=B9=B49=E6=9C=8829=E6=97=A5=
=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=8812:47=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi,
>
> On Mon, Sep 27, 2021 at 06:41:49PM +0800, Zhenguo Yao wrote:
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
> > ---
>
> ...
>
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
>
> I'd suggest to namespace this to hugetlb, e.g.
>
> hugetlb_node_alloc_supported()
>
Looks good to me.
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
>
> ...
>
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
>
> Nit: you could make it a bit simpler with
>
>                 if (!m)
>                         return 0;
>                 goto found;
>
Looks more regular.
> > +     }
> > +     /* do all node balanced alloc */
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
>
> ditto
>
> >       }
> > -     return 0;
> >
> >  found:
> > -     BUG_ON(!IS_ALIGNED(virt_to_phys(m), huge_page_size(h)));
> >       /* Put them into a private list first because mem_map is not up y=
et */
> >       INIT_LIST_HEAD(&m->list);
> >       list_add(&m->list, &huge_boot_pages);
>
> --
> Sincerely yours,
> Mike.
