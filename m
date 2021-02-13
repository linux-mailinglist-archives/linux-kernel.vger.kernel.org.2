Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDDAC31ACAA
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 16:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbhBMPot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 10:44:49 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:17438 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhBMPoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 10:44:46 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6027f3c40003>; Sat, 13 Feb 2021 07:44:04 -0800
Received: from [10.2.62.148] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sat, 13 Feb
 2021 15:44:03 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
CC:     Joao Martins <joao.m.martins@oracle.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 2/2] mm/hugetlb: refactor subpage recording
Date:   Sat, 13 Feb 2021 10:44:01 -0500
X-Mailer: MailMate (1.14r5757)
Message-ID: <16F7C58B-4D79-41C5-9B64-A1A1628F4AF2@nvidia.com>
In-Reply-To: <07b6b61a-2a78-4f49-70f8-e387462a95cc@oracle.com>
References: <20210128182632.24562-1-joao.m.martins@oracle.com>
 <20210128182632.24562-3-joao.m.martins@oracle.com>
 <b550e766-b0fd-2c99-c82f-80e770e8a496@oracle.com>
 <68570840-78E9-4B32-BE0B-B6DC60479DB0@nvidia.com>
 <07b6b61a-2a78-4f49-70f8-e387462a95cc@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
        boundary="=_MailMate_96F6469A-4C8D-4F0E-97F7-490F2651EC01_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1613231044; bh=QXX+CV5QfFm0oPQgkKRV3hzs1IcvASz4ufSN9DIKVbw=;
        h=From:To:CC:Subject:Date:X-Mailer:Message-ID:In-Reply-To:
         References:MIME-Version:Content-Type:X-Originating-IP:
         X-ClientProxiedBy;
        b=jSy+TG6CRKyLKh+FwiPOPLAS8jtAtgbZkY1qTpO7FgUl6bfrnbw5TVxSZMun+lp9J
         YyIfayJ4/X+gZ0xSv+qGSv4kKdowuB1QhllY317fngm+i19KuQ+frfYn6vrRWcHRRZ
         xf/Opd0Dw3X/q+HUug/226kB5Ax1CjxMjAVwH1QOKyc2GKyKqlE03IdDgxszKia0b0
         iuecd55zp5S1ldJ2puFfSAgrIdS6TMqktQqvsHMpczHo0ikV3kO2yt6pjCzgT+OZGV
         0aRFXrawNze9DA4bQl2YNIYBsIbNVBjk1HTAufgzOIW+omQDinKGnGPjGUVSnesxcb
         IHiQT6rQ0Z81A==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_96F6469A-4C8D-4F0E-97F7-490F2651EC01_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 11 Feb 2021, at 18:44, Mike Kravetz wrote:

> On 2/11/21 12:47 PM, Zi Yan wrote:
>> On 28 Jan 2021, at 16:53, Mike Kravetz wrote:
>>
>>> On 1/28/21 10:26 AM, Joao Martins wrote:
>>>> For a given hugepage backing a VA, there's a rather ineficient
>>>> loop which is solely responsible for storing subpages in GUP
>>>> @pages/@vmas array. For each subpage we check whether it's within
>>>> range or size of @pages and keep increment @pfn_offset and a couple
>>>> other variables per subpage iteration.
>>>>
>>>> Simplify this logic and minimize the cost of each iteration to just
>>>> store the output page/vma. Instead of incrementing number of @refs
>>>> iteratively, we do it through pre-calculation of @refs and only
>>>> with a tight loop for storing pinned subpages/vmas.
>>>>
>>>> Additionally, retain existing behaviour with using mem_map_offset()
>>>> when recording the subpages for configurations that don't have a
>>>> contiguous mem_map.
>>>>
>>>> pinning consequently improves bringing us close to
>>>> {pin,get}_user_pages_fast:
>>>>
>>>>   - 16G with 1G huge page size
>>>>   gup_test -f /mnt/huge/file -m 16384 -r 30 -L -S -n 512 -w
>>>>
>>>> PIN_LONGTERM_BENCHMARK: ~12.8k us -> ~5.8k us
>>>> PIN_FAST_BENCHMARK: ~3.7k us
>>>>
>>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>>> ---
>>>>  mm/hugetlb.c | 49 ++++++++++++++++++++++++++++---------------------=

>>>>  1 file changed, 28 insertions(+), 21 deletions(-)
>>>
>>> Thanks for updating this.
>>>
>>> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
>>>
>>> I think there still is an open general question about whether we can =
always
>>> assume page structs are contiguous for really big pages.  That is out=
side
>>
>> I do not think page structs need to be contiguous, but PFNs within a b=
ig page
>> need to be contiguous, at least based on existing code like mem_map_of=
fset() we have.
>
> Thanks for looking Zi,
> Yes, PFNs need to be contiguous.  Also, as you say page structs do not =
need
> to be contiguous.  The issue is that there is code that assumes page st=
ructs
> are contiguous for gigantic pages.  hugetlb code does not make this ass=
umption
> and does a pfn_to_page() when looping through page structs for gigantic=
 pages.
>
> I do not believe this to be a huge issue.  In most cases CONFIG_VIRTUAL=
_MEM_MAP
> is defined and struct pages can be accessed contiguously.  I 'think' we=
 could
> run into problems with CONFIG_SPARSEMEM and without CONFIG_VIRTUAL_MEM_=
MAP
> and doing hotplug operations.  However, I still need to look into more.=


Yeah, you are right about this. The combination of CONFIG_SPARSEMEM,
!CONFIG_SPARSEMEM_VMEMMAP and doing hotplug does cause errors, as simple =
as
dynamically reserving gigantic hugetlb pages then freeing them in a syste=
m
with CONFIG_SPARSEMEM_VMEMMAP not set and some hotplug memory.

Here are the steps to reproduce:
0. Configure a kernel with CONFIG_SPARSEMEM_VMEMMAP not set.
1. Create a VM using qemu with =E2=80=9C-m size=3D8g,slots=3D16,maxmem=3D=
16g=E2=80=9D to enable hotplug.
2. After boot the machine, add large enough memory using
   =E2=80=9Cobject_add memory-backend-ram,id=3Dmem1,size=3D7g=E2=80=9D an=
d
   =E2=80=9Cdevice_add pc-dimm,id=3Ddimm1,memdev=3Dmem1=E2=80=9D.
3. In the guest OS, online all hot-plugged memory. My VM has 128MB memory=
 block size.
If you have larger memory block size, I think you will need to plug in mo=
re memory.
4. Reserve gigantic hugetlb pages so that hot-plugged memory will be used=
=2E I reserved
12GB, like =E2=80=9Cecho 12 | sudo tee /sys/kernel/mm/hugepages/hugepages=
-1048576kB/nr_hugepages=E2=80=9D.
5. Free all hugetlb gigantic pages,
=E2=80=9Cecho 0 | sudo tee /sys/kernel/mm/hugepages/hugepages-1048576kB/n=
r_hugepages=E2=80=9D.
6. You will get =E2=80=9CBUG: Bad page state in process =E2=80=A6=E2=80=9D=
 errors.

The patch below can fix the error, but I suspect there might be other pla=
ces missing
the necessary mem_map_next() too.

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 4bdb58ab14cb..aae99c6984f3 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1319,7 +1319,8 @@ static void update_and_free_page(struct hstate *h, =
struct page *page)
        h->nr_huge_pages--;
        h->nr_huge_pages_node[page_to_nid(page)]--;
        for (i =3D 0; i < pages_per_huge_page(h); i++) {
-               page[i].flags &=3D ~(1 << PG_locked | 1 << PG_error |
+               struct page *subpage =3D mem_map_next(subpage, page, i);
+               subpage->flags &=3D ~(1 << PG_locked | 1 << PG_error |
                                1 << PG_referenced | 1 << PG_dirty |
                                1 << PG_active | 1 << PG_private |
                                1 << PG_writeback);


=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_96F6469A-4C8D-4F0E-97F7-490F2651EC01_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmAn88EPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKVSMP/2jOJVjmdWmlSYcxtk/H0i/RS2wS2qGHxZ5a
0R90w4fAO37OHNQzlPKVOh+kTacOl1hK4q1Rbhk1HgZtvbVXcSOrmijR+0vJbpSh
BiVYcBUjvUO8BtIrLP+ndEBNHDqnqSEpcrW1ia/mhKsQq7S2OmGYQPlDs8ES3cIq
MzUd+ewsk6vPCiloqEaN1xIpDgNoWP9TALSR/BAlHmt0ij+ejQc9uOZ/11P2IBqk
kAwCi/tRcgrfUJn/FKQFpUhuGWpFWL2AxFsnPdZd1eYOIosPZQFcYCOC4q5HDzNE
ANXcHtEYugMGP1fmBnIiE3ERqMH8ZUlYgxU5KGIrSVckqBhu7ElHM1X8137sGSyK
/RrXz7zOb/2RAjKVA0mabbppZGDMyfOF1IPLqr/P21H3IgHAvU3esGqHUqmQzsa0
YX2ndCQ8VRPkwn7phzu8M1xUZzESO9jJjt2ZBYN85QWHESyx0UBb4x4xdMg0TfIi
jnrVk+nfKA79pQIhkFIeyC17rii+jcLo7YHScQfHIs19rZhgWCxB9iTzGIS9YPRm
V8vnaspyz9sz99XyQgZ5tRaRBE4V38qfsu9C6uVFH5zxRnT/i08rC7LWxYIlUFoE
CjBr7jP2cTu0uOPvqPOoD9MJKlb9KNu7VRLOHw4glZpI2l4MRq5PSgI8FrMf662N
RNPwtL04
=Ct5t
-----END PGP SIGNATURE-----

--=_MailMate_96F6469A-4C8D-4F0E-97F7-490F2651EC01_=--
