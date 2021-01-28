Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3E77307B83
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 17:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbhA1Q5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 11:57:17 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:11482 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbhA1Q4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 11:56:51 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6012eca90000>; Thu, 28 Jan 2021 08:56:09 -0800
Received: from [10.2.82.52] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 28 Jan
 2021 16:56:07 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Dave Hansen <dave.hansen@intel.com>
CC:     Saravanan D <saravanand@fb.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        <x86@kernel.org>, <dave.hansen@linux.intel.com>, <luto@kernel.org>,
        <peterz@infradead.org>, <corbet@lwn.net>, <willy@infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        <linux-doc@vger.kernel.org>, <linux-mm@kvack.org>,
        <songliubraving@fb.com>
Subject: Re: [PATCH V5] x86/mm: Tracking linear mapping split events
Date:   Thu, 28 Jan 2021 11:56:05 -0500
X-Mailer: MailMate (1.14r5757)
Message-ID: <33B5B608-4D74-4221-AB0F-AEEBA170AF84@nvidia.com>
In-Reply-To: <15a29679-ea0b-d1c8-1a1f-698d3db35293@intel.com>
References: <20210128045153.GW308988@casper.infradead.org>
 <20210128104934.2916679-1-saravanand@fb.com>
 <EBB7E363-FE25-453C-89C6-9FC4A90615B9@nvidia.com>
 <15a29679-ea0b-d1c8-1a1f-698d3db35293@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
        boundary="=_MailMate_D2AC2C86-6398-4A40-A664-B827FF98A4B6_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1611852969; bh=TqHTHtpr92THE4RjCQocs8iwlOpyElibdaaOo1NcySU=;
        h=From:To:CC:Subject:Date:X-Mailer:Message-ID:In-Reply-To:
         References:MIME-Version:Content-Type:X-Originating-IP:
         X-ClientProxiedBy;
        b=FKiel3XQq1Kxt1ppXI/o6tWHRIp75XA3+YvmTLCUha+QJtstNeqlSJ+i0FVjCEFg8
         6RzA0bzztU1asF0ryVE4A14eRzGqEfNchfa3/gm7rxVaQK4tk8mGqiznHdMbkUsZtc
         9pgKbwqdRBzy67qOFur45OqAvGzMdWLMSIPNkcfOqNT0lN24Og8RAU5eB7/CBrstX4
         kyGTjtyA6g8p96TbXcKQksLAS5ocar3ce+qqbgCfGcuXOTGwkJ+KRc1iYgLq5m4PQP
         g4be4l92oaUB5dXlFKrLgzJAdheL38mw+aMSav5CeIEevIBL+wH3FpCNctyQK/MCYe
         FGykOccYJv+uw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_D2AC2C86-6398-4A40-A664-B827FF98A4B6_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 28 Jan 2021, at 11:41, Dave Hansen wrote:

> On 1/28/21 8:33 AM, Zi Yan wrote:
>>> One of the many lasting (as we don't coalesce back) sources for
>>> huge page splits is tracing as the granular page
>>> attribute/permission changes would force the kernel to split code
>>> segments mapped to huge pages to smaller ones thereby increasing
>>> the probability of TLB miss/reload even after tracing has been
>>> stopped.
>> It is interesting to see this statement saying splitting kernel
>> direct mappings causes performance loss, when Zhengjun (cc=E2=80=99d) =
from
>> Intel recently posted a kernel direct mapping performance report[1]
>> saying 1GB mappings are good but not much better than 2MB and 4KB
>> mappings.
>
> No, that's not what the report said.
>
> *Overall*, there is no clear winner between 4k, 2M and 1G.  In other
> words, no one page size is best for *ALL* workloads.
>
> There were *ABSOLUTELY* individual workloads in those tests that saw
> significant deltas between the direct map sizes.  There are also
> real-world workloads that feel the impact here.

Yes, it is what I understand from the report. But this patch says
=E2=80=9C
Maintaining huge direct mapped pages greatly reduces TLB miss pressure.
The splintering of huge direct pages into smaller ones does result in
a measurable performance hit caused by frequent TLB miss and reloads.
=E2=80=9D,

indicating large mappings (2MB, 1GB) are generally better. It is
different from what the report said, right?

The above text could be improved to make sure readers get both sides
of the story and not get afraid of performance loss after seeing
a lot of direct_map_xxx_splits events.



=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_D2AC2C86-6398-4A40-A664-B827FF98A4B6_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmAS7KUPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKYdMQAKBobb76q21Ixb/TD/fyvGsflD/C65TLw6Sq
vEf2JEsBDBhZEJkY3/MeDeeNp6sCYM1qrF9bkvBjZRJN2gP/XF7W0biSY1V2DDYx
q2aC6/i8Qo1K3MkEPbKCjx/hmM9Ap2vepsT7nZh58QsZyW830wpUlpOPsIPDziUX
f66xKC4OsqSW1X1DcAj3R3Deb6eXwMX/naPAF3uu01KaW5zZYaLRSHi/nJ8bMR4c
mx4eFShbKDpCAICr8KEY94PK7WlrJxV4K1kDSjE9ZMk4fkTPa+bqvxNj4fyc/05d
vTfwqOXzQZZt1Uesiu4Cq/BoyosqhEhd2kkChFgkspTxBzGaRJ4eyGCmxROwaDWn
Yp3JGqvgdozOw/EErB3Y1SSCmQZkuVszDj2+rsAPB2WhqyeH7o5+5RivGPTML6go
FHP2UdXY5kcC8rxktoyTmgCkRfZPnD8EHOubdz9xqn+MddZNDCKpb1KpLZx7iDtW
LbBbdemC0JdVl9k16LaO1724RzarfbAnoYo1kRXi+pRqBmaMZ2lqYjE8B7DGL4Lc
qJxryKnlEnFbVpTX/M1TndhpvCWca67OeJNVioTcgIU/KEf/FfbnCtwQMB5WTcKj
zOtC8EGQmW1e/uDxXhRSLrpy+UtsEz8mxQJJqxG2Q6SjL4CRNgsLm2r7mO132GHh
GCz+1PqC
=iChr
-----END PGP SIGNATURE-----

--=_MailMate_D2AC2C86-6398-4A40-A664-B827FF98A4B6_=--
