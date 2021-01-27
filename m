Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5E1930537E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 07:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbhA0Guh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 01:50:37 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:4408 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbhA0DIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 22:08:06 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6010d5030002>; Tue, 26 Jan 2021 18:50:43 -0800
Received: from [10.2.60.78] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 27 Jan
 2021 02:50:42 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     Jason Gunthorpe <jgg@ziepe.ca>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Joao Martins <joao.m.martins@oracle.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH 2/2] mm/hugetlb: refactor subpage recording
Date:   Tue, 26 Jan 2021 21:50:39 -0500
X-Mailer: MailMate (1.14r5757)
Message-ID: <312AECBD-CA6D-4E93-A6C1-1DF87BABD92D@nvidia.com>
In-Reply-To: <20210127022438.GQ308988@casper.infradead.org>
References: <20210125205744.10203-1-joao.m.martins@oracle.com>
 <20210125205744.10203-3-joao.m.martins@oracle.com>
 <3d34111f-8365-ab95-af11-aaf4825204be@oracle.com>
 <1ae0313d-de9b-4553-1f68-04c4f5a3f7eb@oracle.com>
 <4d3914e9-f448-8a86-9fc6-e71cec581115@oracle.com>
 <20210127000730.GB4605@ziepe.ca>
 <20210127022438.GQ308988@casper.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
        boundary="=_MailMate_88D40994-FB9F-47F5-A5B5-7CF8DD2CED57_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1611715843; bh=s7xFaUhFO88fRKxEAGhG4DMo2AeV+7GmmcYGcIKfYdA=;
        h=From:To:CC:Subject:Date:X-Mailer:Message-ID:In-Reply-To:
         References:MIME-Version:Content-Type:X-Originating-IP:
         X-ClientProxiedBy;
        b=a5Ki29wL31hxvIApzSt21NW+eu9vYlVaGVzCC7Ep27Oq7gcOLxBS3DBCHnhk79msU
         K9lEg/vSE75RcE9BLFJGASLMKe+VeNpqCL7bNVe5/pznh2KZLxF130MkW3gH9tNiwg
         l0R99mOkqHzTskrkIqn/PbIJ4i2ZYoSlK7w44ia1+rTs8Ifxs4C7c5EA7CDoB6VdiG
         qJ6aeDHlkFHv66jqV/J0FRR+K9oHCNpfpd/E7LZktS64ZOnGHebmWUVbV2XLEgVJu8
         hwt+kKovmGJY9txoMyJmDox/lGS0K6h0/KrT9X2/FFhEeBPyrQzA386/RqmCp1uBNx
         zE8JHON2zlgDQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_88D40994-FB9F-47F5-A5B5-7CF8DD2CED57_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 26 Jan 2021, at 21:24, Matthew Wilcox wrote:

> On Tue, Jan 26, 2021 at 08:07:30PM -0400, Jason Gunthorpe wrote:
>> I'm looking at Matt's folio patches and see:
>>
>> +static inline struct folio *next_folio(struct folio *folio)
>> +{
>> +       return folio + folio_nr_pages(folio);
>> +}
>
> This is a replacement for places that would do 'page++'.  eg it's
> used by the bio iterator where we already checked that the phys addr
> and the struct page are contiguous.
>
>> And checking page_trans_huge_mapcount():
>>
>> 	for (i =3D 0; i < thp_nr_pages(page); i++) {
>> 		mapcount =3D atomic_read(&page[i]._mapcount) + 1;
>
> I think we are guaranteed this for transparent huge pages.  At least
> for now.  Zi Yan may have some thoughts for his work on 1GB transhuge
> pages ...

It should work for 1GB THP too. My implementation allocates 1GB pages
from cma_alloc(), which calls alloc_contig_range(). At least for now
subpages from a 1GB THP are physically contiguous.

It will be a concern if we use other ways (like migrating in-use pages)
of forming 1GB THPs. Thanks for pointing this out.

>
>> And we have the same logic in hmm_vma_walk_pud():
>>
>> 	if (pud_huge(pud) && pud_devmap(pud)) {
>> 		pfn =3D pud_pfn(pud) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
>> 		for (i =3D 0; i < npages; ++i, ++pfn)
>> 			hmm_pfns[i] =3D pfn | cpu_flags;
>>
>> So, if page[n] does not access the tail pages of a compound we have
>> many more people who are surprised by this than just GUP.
>>
>> Where are these special rules for hugetlb compound tails documented?
>> Why does it need to be like this?
>>
>> Isn't it saner to forbid a compound and its tails from being
>> non-linear in the page array? That limits when compounds can be
>> created, but seems more likely to happen than a full mm audit to find
>> all the places that assume linearity.
>>
>> Jason


=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_88D40994-FB9F-47F5-A5B5-7CF8DD2CED57_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmAQ1P8PHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKC+YP/30mcSCERlPzEMO34xHUhgnJXYMbnXVwwoxe
nCoZ/vhKmOsHw13Xn9Edt5slluex4Tg21GYNVNUWFQo+H/WdApQ5UbDGb2mynj15
iU4vjkyj/I1C1LvD+EYRL0+J6HJotRQFgOWbwhp5RHQR/1N3YnH5i+Flag+AhMQZ
Jg5+dEVl5IKo81PcD+dSEMm5K2Npk/UrFoRUMT/MXCb/REqGyinrhv9p+3y7uZ3c
euRfbCv8LW0DBS4qeRckLHqnNeDpXRwNblBNhXUJD7It0Hn3H5JB0MDWgvgv1fwE
z/Zxk/sJ8hxNgdXazdxT32DMYVlvEnxYsIMnh6QD9ElyoQR2LcV7NcE6P8YQ1YxE
1aEpPSOxuSTErRLCZrtILdE0nnsuF0yeCi3t6ZJXa1ietnT72BYGQXEtYoeiCmNE
SoYy7Zr/PciA+1BxsjOWQbbR8Fvkb96sPvHnzErBCBYA13GHMWlcH9z/BZI3tWA5
AYP5gmPW/zLF5/6/rnkACkRRkp5jTexDEAdbinfsX+htEB+JI20o+y6tsgSwZR2X
qqmAXExrKdFvx+Prm+aKlomW04w5AIgpMBOgkbNBBGr25Agux/R/tZyGkDWbUWfy
fHuML+cDl0b5m9E31gX+jdnygt6AlMrAlrBVwo087ZFBq5lYpGbBXYoIDLbvtmhf
loAWTa9v
=d+R/
-----END PGP SIGNATURE-----

--=_MailMate_88D40994-FB9F-47F5-A5B5-7CF8DD2CED57_=--
