Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAEF40C5F8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 15:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233505AbhIONMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 09:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233325AbhIONMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 09:12:48 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037AFC061574;
        Wed, 15 Sep 2021 06:11:30 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id z5so5701178ybj.2;
        Wed, 15 Sep 2021 06:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ED99zdvhstpRwne3A80pR035C5tjOiYeGYSORJ4vyUI=;
        b=mRApUvE7DCV++1EHNPSejp0a8tIpDWVQyTQSaND0kFtCoc3Il7ld7oNoRb6KEhENtS
         A3Tn2QgUKG9V+tc0gVthsKJg5W+Hh9X0spx7d1SF4Y7ROkmGWIgtLy1Y28+ROoCqHpYF
         +pybtnFOOpkCZrQwqQGG/eRkRSgxrgDd9eC5eHKF7NYZamPYNM+Ts1ajOuQmWnpc3sBg
         ocmt5prfqE93rt5stU/aARYzd30pgt3tXVQAisv4u+WJZE8d5EC+ytWJF4k1Yexcp8OK
         RlJLcUFkKiwlOdgU04t0eUKRWvSLHF0yByB0waEcj8svBd6DjIflAF55DsVLCIMw0m/o
         /sPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ED99zdvhstpRwne3A80pR035C5tjOiYeGYSORJ4vyUI=;
        b=0CiqLKZeT1xxqLj5woN4sg9xdCu95dweZNBs4apKIV+zvT6z8SBLtZf4eQaQUH/ojs
         32PkVgWw+g1g1TGCybuPjswn6K5r1fEhEH7IKgTeHr8p1bYpsfOig7vP+ZjPKtfxgCaw
         TbTK+jeBNISC0PaQZ7WdUBrA+ke6RLPDphEEOCM+GQn3I8HIr+MXzV/LpqPnz7srdi+2
         8kWVJyVzKLoW+IkgrWHIVYsLb36eXQJ9dhF3JD0EBNIKmRqmMaRsol3hZimv4khBHdRK
         F65MJkbuPiIWkNWGfwoqnyb3AsbhtYpTLxhTdNmoD0yHTmIb6Rrag2chzmSLMm7cj9Iz
         Qb7w==
X-Gm-Message-State: AOAM53046XA7d5Rd1JouDscNAVZ3gYlTZ16sshcQ2WG51KpSOXCaTpuO
        bVUgaBPpTM+zFCLWeyB9omq3NddfbG4V9JzvfF8=
X-Google-Smtp-Source: ABdhPJyxDnkgfri42t9pLIdq//afItaRTyEbocdXWj3uaAT0K+adBcfzVFKBOm6slfbiHx+FjL9MadGg5Z3COebWstc=
X-Received: by 2002:a25:d9c8:: with SMTP id q191mr6344715ybg.61.1631711489262;
 Wed, 15 Sep 2021 06:11:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210909141655.87821-1-yaozhenguo1@gmail.com> <20210914205001.7ccc7ef3dd76a9ec551b370e@linux-foundation.org>
In-Reply-To: <20210914205001.7ccc7ef3dd76a9ec551b370e@linux-foundation.org>
From:   zhenguo yao <yaozhenguo1@gmail.com>
Date:   Wed, 15 Sep 2021 21:11:18 +0800
Message-ID: <CA+WzARmsPT46ck17-96cJVWE-=QEK8QobRFnCnEcNxsd42zNTw@mail.gmail.com>
Subject: Re: [PATCH v4] hugetlbfs: Extend the definition of hugepages
 parameter to support node allocation
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Cc:     corbet@lwn.net, yaozhenguo@jd.com,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@linux-foundation.org> =E4=BA=8E2021=E5=B9=B49=E6=9C=881=
5=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=8811:50=E5=86=99=E9=81=93=EF=
=BC=9A
>
> On Thu,  9 Sep 2021 22:16:55 +0800 yaozhenguo <yaozhenguo1@gmail.com> wro=
te:
>
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
> > ...
> >
> > @@ -2842,10 +2843,75 @@ static void __init gather_bootmem_prealloc(void=
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
>
> We try very hard to avoid adding BUG calls.  Is there any way in which
> this code can emit a WARNing then permit the kernel to keep operating?
>
Maybe we can rewrite it as below:
                        if (WARN(!IS_ALIGNED(virt_to_phys(m),
huge_page_size(h)),
                                "HugeTLB: page addr:%p is not aligned\n", m=
))
                                break;
@Mike,  Do you think it's OK?
> > +                     /*
> > +                      * Put them into a private list first because mem=
_map
> > +                      * is not up yet
> > +                      */
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
> > +             cond_resched();
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
>
