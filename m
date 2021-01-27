Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE19306068
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 17:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236879AbhA0P7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 10:59:53 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:9679 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343499AbhA0P6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 10:58:52 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B60118d930000>; Wed, 27 Jan 2021 07:58:11 -0800
Received: from [10.2.60.78] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 27 Jan
 2021 15:58:09 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     David Hildenbrand <david@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: Re: [PATCH v1 1/2] mm/cma: expose all pages to the buddy if
 activation of an area fails
Date:   Wed, 27 Jan 2021 10:58:07 -0500
X-Mailer: MailMate (1.14r5757)
Message-ID: <F48ADDA3-7860-4F30-A3E8-B778359D10AA@nvidia.com>
In-Reply-To: <20210127101813.6370-2-david@redhat.com>
References: <20210127101813.6370-1-david@redhat.com>
 <20210127101813.6370-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
        boundary="=_MailMate_C33B7D64-5C83-4FBC-BA12-F7A9307092F5_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1611763091; bh=9f29pbSqkFcdd7oAkk+SxFMIq+bbPbn8eq0ySyEkrP8=;
        h=From:To:CC:Subject:Date:X-Mailer:Message-ID:In-Reply-To:
         References:MIME-Version:Content-Type:X-Originating-IP:
         X-ClientProxiedBy;
        b=ah2XlkaWBFiiZS0L9idrb9CF+xCVfPvoK3ioAPJQ4Uhc0WVBrrMJPJA8RUI/PRWmp
         Nn7Cf34Ip2pyzXs8ESvPdjyJtPMIsttP58MurpzmtYX0QOc7WjzFCh+f6Yccole0wO
         gkTZUW5ZMcR7kT55+8CYBNJNpMMI13q+3+dW6ER7YBe+cadDphDNWIfU4/bJ8Cxx//
         X+Yzx1AdQiBb66jOWBZ9Zmi+Qw+WJ0sOvSjhawUlMBNrVktOfwcuPtwaE3LuYPlfnW
         H5k8LQMj3hDXeXXbHjBK2kB71uHI+/Qd+quW1j+XJxspawmdXYb5KLyfdssuxAa8aY
         4rkT6re6/mE6g==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_C33B7D64-5C83-4FBC-BA12-F7A9307092F5_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 27 Jan 2021, at 5:18, David Hildenbrand wrote:

> Right now, if activation fails, we might already have exposed some page=
s to
> the buddy for CMA use (although they will never get actually used by CM=
A),
> and some pages won't be exposed to the buddy at all.
>
> Let's check for "single zone" early and on error, don't expose any page=
s
> for CMA use - instead, expose them to the buddy available for any use.
> Simply call free_reserved_page() on every single page - easier than
> going via free_reserved_area(), converting back and forth between pfns
> and virt addresses.
>
> In addition, make sure to fixup totalcma_pages properly.
>
> Example: 6 GiB QEMU VM with "... hugetlb_cma=3D2G movablecore=3D20% ...=
":
>   [    0.006891] hugetlb_cma: reserve 2048 MiB, up to 2048 MiB per node=

>   [    0.006893] cma: Reserved 2048 MiB at 0x0000000100000000
>   [    0.006893] hugetlb_cma: reserved 2048 MiB on node 0
>   ...
>   [    0.175433] cma: CMA area hugetlb0 could not be activated
>
> Before this patch:
>   # cat /proc/meminfo
>   MemTotal:        5867348 kB
>   MemFree:         5692808 kB
>   MemAvailable:    5542516 kB
>   ...
>   CmaTotal:        2097152 kB
>   CmaFree:         1884160 kB
>
> After this patch:
>   # cat /proc/meminfo
>   MemTotal:        6077308 kB
>   MemFree:         5904208 kB
>   MemAvailable:    5747968 kB
>   ...
>   CmaTotal:              0 kB
>   CmaFree:               0 kB
>
> Note: cma_init_reserved_mem() makes sure that we always cover full
> pageblocks / MAX_ORDER - 1 pages.
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/cma.c | 43 +++++++++++++++++++++----------------------
>  1 file changed, 21 insertions(+), 22 deletions(-)

LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>

=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_C33B7D64-5C83-4FBC-BA12-F7A9307092F5_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmARjY8PHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKyU4P/22fuj51aHN6OYJfCdJFXadykeJMaDU8w57E
P7k1tXv7vtcg7TWJBZLNLLVNU8myIzGs2Buj948GqSv0eiRzIElRx/5XWIjA6zz2
JJw8uY8NfoQcma0ooVxO7rf7TYU0sqwVXMy55yKvnP0jmMqnvcxgh4w47tWJHgno
8PiC49x00WmS6V/LO4/ve2qe65un0u7moyaf+7Ev1h9n2Dk9t8yR6jTAoq0nUIUo
uRyuX0Rhc3o/1aic9vbN1aT/CF9b23utOdiwjGo2cWn0lIL8CLZKJ1Cu6UXsjV80
upibyL6hfsy8oXfH81BbLcuCCbslLKyxm+MPaAk81HgVdg9S0Joho6PGR82tpkmO
3vlIkhrNQ0USB9XaqJr2eYs8t2Zu0kABmonuJbbArBwDmRrDc5E5XKNgTA1XztiD
Gxr2W85AJBexWySTc68YQEWJUhL+LJ5cqCsQg/C835ZLXGEMgirBiXeKzybTwwhh
FbBiFzHFb5sN0aVC9RfM3IPQJ/dSWK3kIBe4l3EVS6Z0mWKzBAtJ54JOiTQSU5Ke
MUBrvYUeFJdpaghds4G8iTfovDDyuG6UbZnK8v+/HdA2Z2RCvLTsDeMCziqvDtrh
6iT5Uu4GbXb62iAFtAtU5Ll+5K1s5YXa8I1vCWPGcKM3bqH/IFTBLzz4R+OR2Wkl
F4+Y+kxh
=drxX
-----END PGP SIGNATURE-----

--=_MailMate_C33B7D64-5C83-4FBC-BA12-F7A9307092F5_=--
