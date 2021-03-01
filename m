Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D922A3282A0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 16:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237322AbhCAPga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 10:36:30 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:4697 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237237AbhCAPgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 10:36:09 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B603d09be0007>; Mon, 01 Mar 2021 07:35:26 -0800
Received: from [10.2.62.13] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 1 Mar
 2021 15:35:24 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     David Hildenbrand <david@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v1] mm/page_alloc: drop pr_info_ratelimited() in
 alloc_contig_range()
Date:   Mon, 1 Mar 2021 10:35:22 -0500
X-Mailer: MailMate (1.14r5757)
Message-ID: <395622C6-F8D9-408D-B35B-17B16F1B5E77@nvidia.com>
In-Reply-To: <20210301150945.77012-1-david@redhat.com>
References: <20210301150945.77012-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
        boundary="=_MailMate_4DE8FF03-D3CA-4DB3-A579-7B9830E8D138_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1614612926; bh=mlhQ908O+sCee8WIaVYPJGEGthrRsdrP1NwFa/Q04FY=;
        h=From:To:CC:Subject:Date:X-Mailer:Message-ID:In-Reply-To:
         References:MIME-Version:Content-Type:X-Originating-IP:
         X-ClientProxiedBy;
        b=ONrAPlJIRGAQDmRsAIAmwk4l1cJfSksrX9LPBzg7hsJw8fGVVkME8LcwEqO09USX+
         rmkOWP67PLZQT8XZoNIa7q5d1uZ2pGvBw0RonplPNF4bo0fwC3rZu81HWOafmv0z/x
         96m9FMU8H9N3JMACInbdZ2J8kzJKYa9AnwuCwoOKcOrtEbKcpIRkLMF3CahxxOv2jw
         Lo9W2aAqSYVtSSXjpLTa5CSpj6JV+cdvGwxhpOwQFvdhMILrkPx3MljClnWdMSe4VA
         3BfzEl8DGiXgSnfyhQfJMXZiGMhRhXxTs+4jrjGLwdBQXzfTzeKOhDxsu5VIvmmojN
         LTumdxfOTZTwA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_4DE8FF03-D3CA-4DB3-A579-7B9830E8D138_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 1 Mar 2021, at 10:09, David Hildenbrand wrote:

> The information that some PFNs are busy is:
> a) not helpful for ordinary users: we don't even know *who* called
>    alloc_contig_range(). This is certainly not worth a pr_info.*().
> b) not really helpful for debugging: we don't have any details *why*
>    these PFNs are busy, and that is what we usually care about.
> c) not complete: there are other cases where we fail alloc_contig_range=
()
>    using different paths that are not getting recorded.
>
> For example, we reach this path once we succeeded in isolating pagebloc=
ks,
> but failed to migrate some pages - which can happen easily on
> ZONE_NORMAL (i.e., has_unmovable_pages() is racy) but also on ZONE_MOVA=
BLE
> i.e., we would have to retry longer to migrate).
>
> For example via virtio-mem when unplugging memory, we can create quite
> some noise (especially with ZONE_NORMAL) that is not of interest to
> users - it's expected that some allocations may fail as memory is busy.=

>
> Let's just drop that pr_info_ratelimit() and rather implement a dynamic=

> debugging mechanism in the future that can give us a better reason why
> alloc_contig_range() failed on specific pages.
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

LGTM. I agree that the printout is not quite useful.

Reviewed-by: Zi Yan <ziy@nvidia.com>


=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_4DE8FF03-D3CA-4DB3-A579-7B9830E8D138_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmA9CbsPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKyb4P/1ha6j2AhTzE2u9SupGjtogS2/KnuQ1BZbia
BCSikFAaAVEV17Fdm3VdajT0TKCzQCPM5xKO+PDfWyjhfeyNruvnFkISz4LmJV2R
lvHTLnl2JYeEA5rJfXvu8pIJJxci/QkngYvR0yViM2P0y2mfs8+Bfz+1Z2MaQ4l+
U6yOFGQURlcuMlbFaLdU2/7qZOb2bzR0iqpvF5AuY+sK0KzpF1yL/bFKYY72KqAJ
6CZY+nID2Cn6J59qfHTX1+BLtqzn1FTjuQ+poMmRTijd31x6K/DbPidjJYNXE+qG
uRwz31V4gAdflEypY5xmTKJAQp5v30FdHhINIP+KTTDnVzD9Dlfw8+tQhPFFNFv8
Lnv+Cxx/z9xAAMLmIiZ3TWpru0dNjbRd/XYlg1FViKJwKRNVGpgCuT7BgYiT148j
EGHPJVgICkXgPX0ADwKRlQ/W9xEn+M622IeLHsACGQzYyJoi3XegHBQhBDNkUpFv
EdTBF01KFvgJd3CQv8gVL7UZU97dll37Ef2JYGD8MsrruCCcriQn3zs0MtX/VkYn
ZkubLroJ+nbZVaFtihp1Sl1I5/qrV0jna/8IUG7wsXxrZMOefV6Suu1FYmqdLQ+D
gvoHHT9v+oogh727Inpv6vcQwzvJ4dCF2dYOlE2tYoEJPCT4YvmGS3mIp/sQq/NE
w+FIx5Nf
=DMSI
-----END PGP SIGNATURE-----

--=_MailMate_4DE8FF03-D3CA-4DB3-A579-7B9830E8D138_=--
