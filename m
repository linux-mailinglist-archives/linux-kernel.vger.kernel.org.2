Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB0D932DE1F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 00:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbhCDXyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 18:54:55 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:1668 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhCDXyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 18:54:54 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6041734e0000>; Thu, 04 Mar 2021 15:54:54 -0800
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 4 Mar
 2021 23:54:54 +0000
Received: from nvdebian.localnet (172.20.145.6) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 4 Mar 2021
 23:54:51 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     Zi Yan <ziy@nvidia.com>
CC:     <linux-mm@kvack.org>, <nouveau@lists.freedesktop.org>,
        <bskeggs@redhat.com>, <akpm@linux-foundation.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <jhubbard@nvidia.com>,
        <rcampbell@nvidia.com>, <jglisse@redhat.com>, <jgg@nvidia.com>,
        <hch@infradead.org>, <daniel@ffwll.ch>
Subject: Re: [PATCH v3 4/8] mm/rmap: Split migration into its own function
Date:   Fri, 5 Mar 2021 10:54:48 +1100
Message-ID: <84997524.IMQpRet0Aq@nvdebian>
In-Reply-To: <E93F89E1-3CE2-4CA3-97D9-6BCED78E1001@nvidia.com>
References: <20210226071832.31547-1-apopple@nvidia.com> <20210226071832.31547-5-apopple@nvidia.com> <E93F89E1-3CE2-4CA3-97D9-6BCED78E1001@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1614902094; bh=F3stMHCU+5ii6x1iy3omj83ayupI0P+Mr9dS1o5FIt0=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Transfer-Encoding:Content-Type:
         X-Originating-IP:X-ClientProxiedBy;
        b=NpU2unlnheR6/rs4Zkq9TpQwW8Ut3zxi8Pn9daVGKPN2Zf3wm0lvYJ/fXsPnTrJ2C
         8r6FecCuivTyRTi4tEnX/gdG9VaTETErNKJhNRJW79HRPU3l70FQFYUPIkhEgdY7tX
         YIlY/ILaZKek6pTrRHqTdQ0bbLwCKcvyZQIUXQp259KaTmOAv19PPuEro7v397+5Ru
         zN6MpkzlSUiIVTJVHly9G9jlXozppR3Xo1drI0n42SmVmEVacBDR8DiJef1PPXPiVo
         gD39vcJO1NY/MhM/r142FNOwKGLtl9ekatblvwVaSTLNgcdn4994m2D59bfjPvLnRH
         5WIgHVadyysng==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 3 March 2021 9:08:15 AM AEDT Zi Yan wrote:
> On 26 Feb 2021, at 2:18, Alistair Popple wrote:

> > diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> > index 7f1ee411bd7b..77fa17de51d7 100644
> > --- a/include/linux/rmap.h
> > +++ b/include/linux/rmap.h
> > @@ -86,8 +86,6 @@ struct anon_vma_chain {
> >  };
> >
> >  enum ttu_flags {
> > -	TTU_MIGRATION		=3D 0x1,	/* migration mode */
> > -
> >  	TTU_SPLIT_HUGE_PMD	=3D 0x4,	/* split huge PMD if any */
>=20
> It implies freeze in try_to_migrate() and no freeze in try_to_unmap(). I=
=20
think
> we need some comments here, above try_to_migrate(), and above try_to_unma=
p()
> to clarify the implication.

Sure. This confused me for a bit and I was initially tempted to leave=20
TTU_SPLIT_FREEZE as a separate mode flag but looking at what freeze actuall=
y=20
does it made sense to remove it because try_to_migrate() is for installing=
=20
migration entries (which is what freeze does) and try_to_unmap() just unmap=
s.=20
So I'll add some comments to that effect.
=20
> >  	TTU_IGNORE_MLOCK	=3D 0x8,	/* ignore mlock */
> >  	TTU_IGNORE_HWPOISON	=3D 0x20,	/* corrupted page is recoverable */
> > @@ -96,7 +94,6 @@ enum ttu_flags {
> >  					 * do a final flush if necessary */
> >  	TTU_RMAP_LOCKED		=3D 0x80,	/* do not grab rmap lock:
> >  					 * caller holds it */
> > -	TTU_SPLIT_FREEZE	=3D 0x100,		/* freeze pte under splitting thp */
> >  };
> >
> >  #ifdef CONFIG_MMU
> > @@ -193,6 +190,7 @@ static inline void page_dup_rmap(struct page *page,=
=20
bool compound)
> >  int page_referenced(struct page *, int is_locked,
> >  			struct mem_cgroup *memcg, unsigned long *vm_flags);
> >
> > +bool try_to_migrate(struct page *page, enum ttu_flags flags);
> >  bool try_to_unmap(struct page *, enum ttu_flags flags);
> >
> >  /* Avoid racy checks */
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index d00b93dc2d9e..357052a4567b 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -2351,16 +2351,16 @@ void vma_adjust_trans_huge(struct vm_area_struc=
t=20
*vma,
> >
> >  static void unmap_page(struct page *page)
> >  {
> > -	enum ttu_flags ttu_flags =3D TTU_IGNORE_MLOCK |
> > -		TTU_RMAP_LOCKED | TTU_SPLIT_HUGE_PMD;
> > +	enum ttu_flags ttu_flags =3D TTU_RMAP_LOCKED | TTU_SPLIT_HUGE_PMD;
> >  	bool unmap_success;
> >
> >  	VM_BUG_ON_PAGE(!PageHead(page), page);
> >
> >  	if (PageAnon(page))
> > -		ttu_flags |=3D TTU_SPLIT_FREEZE;
> > -
> > -	unmap_success =3D try_to_unmap(page, ttu_flags);
> > +		unmap_success =3D try_to_migrate(page, ttu_flags);
> > +	else
> > +		unmap_success =3D try_to_unmap(page, ttu_flags |
> > +						TTU_IGNORE_MLOCK);
>=20
> I think we need a comment here about why anonymous pages need=20
try_to_migrate()
> and others need try_to_unmap().

Historically this comes from baa355fd3314 ("thp: file pages support for=20
split_huge_page()") which says:

"We don't setup migration entries. Just unmap pages. It helps handling case=
s=20
when i_size is in the middle of the page: no need handle unmap pages beyond=
=20
i_size manually."

But I'll add a comment here, thanks.

 - Alistair

> Thanks.
>=20
> =E2=80=94
> Best Regards,
> Yan Zi




