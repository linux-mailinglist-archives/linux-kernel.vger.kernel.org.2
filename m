Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA203194B9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 21:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbhBKUsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 15:48:37 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:12728 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbhBKUsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 15:48:31 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B602597f50000>; Thu, 11 Feb 2021 12:47:49 -0800
Received: from [10.2.62.148] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 11 Feb
 2021 20:47:48 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
CC:     Joao Martins <joao.m.martins@oracle.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 2/2] mm/hugetlb: refactor subpage recording
Date:   Thu, 11 Feb 2021 15:47:46 -0500
X-Mailer: MailMate (1.14r5757)
Message-ID: <68570840-78E9-4B32-BE0B-B6DC60479DB0@nvidia.com>
In-Reply-To: <b550e766-b0fd-2c99-c82f-80e770e8a496@oracle.com>
References: <20210128182632.24562-1-joao.m.martins@oracle.com>
 <20210128182632.24562-3-joao.m.martins@oracle.com>
 <b550e766-b0fd-2c99-c82f-80e770e8a496@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
        boundary="=_MailMate_0AF41835-26CA-4A52-94E2-2B9F71480E0E_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1613076469; bh=FAs2MweUMgMz3RkofK3eIzkwTspP0Sgpwi0jMsprmgg=;
        h=From:To:CC:Subject:Date:X-Mailer:Message-ID:In-Reply-To:
         References:MIME-Version:Content-Type:X-Originating-IP:
         X-ClientProxiedBy;
        b=VGTNIRlKLRny7vyHrD9ap15OKywYJiSK1gG2U0bDlYRkhnKnGepn6VGZw2Gfnh/OX
         pLnXUQbfKtJAGdhTtHHo9ukxPW1Pto3QQ2iUz2psi07HVoJyf2fDUp5rpR6gMXIJhT
         hzGvOHcRZmRDAuzpgFAuRjjlzJnBXZdl6MVOeKMvrDArF7y8UnvjkOCdjUvwp9TU9h
         l8DOHiSaMrK1uh1IzmQbtZGuFinxxtaj7RwOhkjrfVNqY2N54DSL9WSppSLsGREp4I
         86m+H2X9eRGjATO792nBbNxQgSBZMx8jNh0lXsH/NqcYhfEhkNSFTxOlmycOh8yxiz
         YxChCjG2X9IrA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_0AF41835-26CA-4A52-94E2-2B9F71480E0E_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 28 Jan 2021, at 16:53, Mike Kravetz wrote:

> On 1/28/21 10:26 AM, Joao Martins wrote:
>> For a given hugepage backing a VA, there's a rather ineficient
>> loop which is solely responsible for storing subpages in GUP
>> @pages/@vmas array. For each subpage we check whether it's within
>> range or size of @pages and keep increment @pfn_offset and a couple
>> other variables per subpage iteration.
>>
>> Simplify this logic and minimize the cost of each iteration to just
>> store the output page/vma. Instead of incrementing number of @refs
>> iteratively, we do it through pre-calculation of @refs and only
>> with a tight loop for storing pinned subpages/vmas.
>>
>> Additionally, retain existing behaviour with using mem_map_offset()
>> when recording the subpages for configurations that don't have a
>> contiguous mem_map.
>>
>> pinning consequently improves bringing us close to
>> {pin,get}_user_pages_fast:
>>
>>   - 16G with 1G huge page size
>>   gup_test -f /mnt/huge/file -m 16384 -r 30 -L -S -n 512 -w
>>
>> PIN_LONGTERM_BENCHMARK: ~12.8k us -> ~5.8k us
>> PIN_FAST_BENCHMARK: ~3.7k us
>>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> ---
>>  mm/hugetlb.c | 49 ++++++++++++++++++++++++++++---------------------
>>  1 file changed, 28 insertions(+), 21 deletions(-)
>
> Thanks for updating this.
>
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
>
> I think there still is an open general question about whether we can al=
ways
> assume page structs are contiguous for really big pages.  That is outsi=
de

I do not think page structs need to be contiguous, but PFNs within a big =
page
need to be contiguous, at least based on existing code like mem_map_offse=
t() we have.
The assumption seems valid according to the existing big page allocation =
methods,
which use alloc_contig_pages() at the end of the day. alloc_contig_pages(=
)
calls pfn_range_valid_contig() to make sure all PFNs are contiguous.
On the other hand, the buddy allocator only merges contiguous PFNs, so th=
ere
will be no problem even if someone configures the buddy allocator to allo=
cate
gigantic pages.

Unless someone comes up with some fancy way of making page allocations fr=
om
contiguous page structs in SPARSEMEM_VMEMMAP case, where non-contiguous
PFNs with contiguous page structs are possible, or out of any adjacent
pages in !SPARSEMEM_VMEMMAP case, where non-contiguous page structs
and non-contiguous PFNs are possible, we should be good.


=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_0AF41835-26CA-4A52-94E2-2B9F71480E0E_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmAll/IPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKSP8P/2I97FZPzy/A05J1UHc/C31OtFe3IiNmXB83
6VQEl5AIyBo+BXmWQ5i7cBLp/ojPhOQLwKO+ygnawFHrw8pH0R0ZaWgkOCagvnuV
GJ9ZWHzW/PZeDoQO2K9FOvwMns4j59T/pF4AlBTjHWkJQ8284t4idCmnozWrk3MX
sjpkoO6WOOu20vAXmdsK1lKenOLQt+6mk4nW5wRh+0Py3jDygPRO7zVwegcxdfBA
0F0/+VzuIo0txlCauM9O4wykRs+TrGKudzpvShnqo/yn1mEcCWe6abIAgIP0mjRr
/af5ci+mNtHGHxCDPSijYBpW1h3sZifqvjxdmCfi46B5gY+LqgQGAoM6WgDEIkfs
9ISApkfEjtTdkO4UqM5GfFPxVvWCDR2xTxyISJGf6YGf5hjOvT9BpozcsPqkkyJN
PXAomnFtwZwfvIv1RKpa9yz64tkq+AEqIxvRvKVOT8wNq1U4Q6BxEx0JbjnD3234
hCRE3P80UrtXLyOJ8teBzHwx6iN2eTB9Qac1GTQHOqaHCCSqNs9NY8+tg/+X0y03
W1aoAxp8OGDt+iGElzUAgc3vX0SR0KQdhJBMPcWWVF0VQta4PSrykqs3BIh6ATbl
vm7dq0HnYI6GCE9MaAQk4aF11t+594NzmvYvvx5Pj3dzT1dQfaqVkQld2PFWWIz8
HyuA0xf5
=9RWM
-----END PGP SIGNATURE-----

--=_MailMate_0AF41835-26CA-4A52-94E2-2B9F71480E0E_=--
