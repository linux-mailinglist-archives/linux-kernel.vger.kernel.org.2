Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6849245462A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 13:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237191AbhKQMLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 07:11:14 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:52448 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235835AbhKQMLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 07:11:12 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20211117120812euoutp02fae820fea88108aea09239eb96ee04fa~4VBAYZyz22409024090euoutp02Y;
        Wed, 17 Nov 2021 12:08:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20211117120812euoutp02fae820fea88108aea09239eb96ee04fa~4VBAYZyz22409024090euoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1637150892;
        bh=6WfyiZlASDAvUJCykLfAtnjv9iibBvw6tJ3yedKkhl8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sXBdMfUbK0hzblacMCemqoLAScqRljCXYyJOMmDI+xFEYpTPFMXvd9g6NIyQaDC2R
         60AVybC2pzGBrjsV2bR5tMsTm8jnXtae5WlT2y8SMdCvaIcWGPFdvy+RQDdnwWLv6G
         cK1kClYkMTpzIKOxYf59N6E4kx6Qm3Z94F1sdEOk=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20211117120812eucas1p24947e4250246ec2d3089fbf58a2d524a~4VA-_ExMD2355223552eucas1p2t;
        Wed, 17 Nov 2021 12:08:12 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 64.01.10260.BA0F4916; Wed, 17
        Nov 2021 12:08:11 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20211117120811eucas1p1cdc0aa3ab93d11cebf85592d4e98f0c7~4VA-fkAC21668616686eucas1p1D;
        Wed, 17 Nov 2021 12:08:11 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20211117120811eusmtrp1f313702c63953bd87e3c2d5da3186136~4VA-e5J7a0742707427eusmtrp1G;
        Wed, 17 Nov 2021 12:08:11 +0000 (GMT)
X-AuditID: cbfec7f5-bf3ff70000002814-54-6194f0abb756
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id CA.9C.09404.CA0F4916; Wed, 17
        Nov 2021 12:08:12 +0000 (GMT)
Received: from localhost (unknown [106.120.51.46]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20211117120811eusmtip2bdaa750859cdd23aca4fcf071d8f7cd0~4VA-P72no0120801208eusmtip2A;
        Wed, 17 Nov 2021 12:08:11 +0000 (GMT)
From:   Lukasz Stelmach <l.stelmach@samsung.com>
To:     Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] get_maintainer: look for configuration files in
 ./scripts
Date:   Wed, 17 Nov 2021 13:07:58 +0100
In-Reply-To: <6358495179b8abceafb651e58e933b8cf3a8ff1f.camel@perches.com>
        (Joe Perches's message of "Tue, 16 Nov 2021 15:10:21 -0800")
Message-ID: <dleftjczmzgf35.fsf%l.stelmach@samsung.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg="pgp-sha256";
        protocol="application/pgp-signature"
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se1BMcRTH/fbedm87bW6rdGweKc2kRkUeSV6DscjblNdM7uiqtG21a3uY
        UaEHoWybSWv1Em2ttjRbzE7DTCplI4YhpFIUCdVuhhij9q4Z/33O+Z7vefzmR2D8YisBESE+
        RkvElMiFzcXrmn+2L9AM51I+OsUiP1XVTbbfle4+3O+ZXsX2q2x8y1mDC1su/8KFpooXmDBL
        V4GExprZO/D93IBQWhQRR0u8Vx3ihj/vmxPzmUwwNWqxFFRjm4msCSAXg155GmUiLsEn1QjG
        lM0YE5gQXJJ/4DCBEYG6Vc/6Z7n7qceKEcoQ/OztsAQDCIznXuKZiCDYpBdUVu6dNNiTgdBf
        /5I9yRi5Ha53VZt5GrkH2ofU+CTjpBukGd+Zp1mTZxD0qhRoUuCRy+DOaKmZHcjl8Lt/hMPk
        7aA1/z3ONI2C/PYh8xFAdhLQMVBsWXU9fFS24AxPg8EHOg7DM8GgOG9eFMhkUOQsZbznEdSp
        fljqV0Dn43E2U7MWFPVSBm2h44sdM9YWcuryMCbNgzPpfMY4D7TZ9ZYmArgwqEYMC+GeotDy
        oCoEJd1F+EXkrPzvGuV/1ygn2mLkfKjSezNpT7hR/BljeCVotd/wImRVgRxpmTQqjJb6iul4
        LykVJZWJw7wOR0fVoImfY/jzYOwOUg+OeDUgFoEa0LwJc2+15gkS4OJoMe1izws9rqD4vFAq
        8TgtiQ6RyES0tAE5EbiLI8/+dwrFJ8OoY3QkTcfQkn8qi7AWpLCoGeJY56zo3Y8800ofBfnq
        k5wRWmdwr4pHTam7Mr+46zWyxLPf+8vTMkqzmvbVbynmH1xqox2e6hCeuu3PFI/rbiU9rvcz
        Towqnp6z1ztdGx/vtXlY0LJkTlneK748OCPi9q8GE1FY0Lw6cPRTm0BpOGV8m5G+d3Xg5ulf
        12qPXk2OTO3eEOe0JMF6U+yYKeBWQKOo7btjss/OFJz7tT1pSmR+7glRSDjHdf6RmHXPf8xI
        2yq/khsTz3sWm2qlo974p7+++rRWJi8jME7RQFNXl6+uOTIkyM345HGb96ykwp5b/u84ctZ0
        p5K27OAWw0j5RhvtSY1mboG8r1YmdpAfELjg0nBqoQcmkVJ/ASiPgoG0AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsVy+t/xe7prPkxJNPj3i91izvo1bBaz7z9m
        sbi8aw6bxdojd9kdWDxOzPjN4vFl1TVmj74tqxg9Pm+SC2CJ0rMpyi8tSVXIyC8usVWKNrQw
        0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0Mu48li+4LVAxZcj65gbGDfxdTFyckgI
        mEjse/mAtYuRi0NIYCmjxJXHzYxdjBxACSmJlXPTIWqEJf5c62IDsYUEnjJKTHuSBVLCJqAn
        sXZtBEhYRMBH4tme62AlzAJ+Enc2TWIFsYUFQiTOv1nBAtHqIfHrwAl2EJtFQFWi9fNDdpC1
        nAIdjBIbllxnBknwCphL7Pi0hBHEFhWwlPjz7CM7RFxQ4uTMJywQC7Ilvq5+zjyBUWAWktQs
        JKlZQOcxC2hKrN+lDxHWlli28DUzhG0rsW7de5YFjKyrGEVSS4tz03OLjfSKE3OLS/PS9ZLz
        czcxAqNl27GfW3Ywrnz1Ue8QIxMH4yFGFaDORxtWX2CUYsnLz0tVEuFNqZqcKMSbklhZlVqU
        H19UmpNafIjRFOi3icxSosn5wDjOK4k3NDMwNTQxszQwtTQzVhLn9SzoSBQSSE8sSc1OTS1I
        LYLpY+LglGpgMnDVf7CuM+fVxCN5u9pY2s6fj7ziyXArWD1ud+DPro/8N2xCNTR8Dl/V+xbI
        fjnRoIL79amD8jdkFu9q3u79ZfPF86tUoz2a6z67L1owiyvjXc9D53jZexPOx8les5W34Yy9
        cJJ7k/je6gOll+dXddz2TNx95u2ss6KT7irHL9uX/LM8cekcXt0a3cKltW8mzudVzLPYv/PK
        ljXTFrEu3K1nu7nHWMvmc/Q1idjgnPpWh/s8Ztc0j6x8xuvFdXdr4/aPln1pV7bu8DWZdEKZ
        4a2bhlNH0L5L0Tubr99/8T133cJdAkEv7n7SWv572fGEr2+jf695GGj87GfQndYn+cnOpjN3
        nDl3IvdK6l3WuRuVWIozEg21mIuKEwHRdxbTKwMAAA==
X-CMS-MailID: 20211117120811eucas1p1cdc0aa3ab93d11cebf85592d4e98f0c7
X-Msg-Generator: CA
X-RootMTR: 20211117120811eucas1p1cdc0aa3ab93d11cebf85592d4e98f0c7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20211117120811eucas1p1cdc0aa3ab93d11cebf85592d4e98f0c7
References: <6358495179b8abceafb651e58e933b8cf3a8ff1f.camel@perches.com>
        <CGME20211117120811eucas1p1cdc0aa3ab93d11cebf85592d4e98f0c7@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

It was <2021-11-16 wto 15:10>, when Joe Perches wrote:
> On Tue, 2021-11-16 at 22:34 +0100, =C5=81ukasz Stelmach wrote:
>> Change ".scripts" to "./scripts" as described in commit bcde44ed7d2a
>> ("scripts/get_maintainer.pl: use .get_maintainer.conf from . then $HOME
>> then scripts").
>
> The intent there was to use the <kernel_tree>/scripts directory

I am afraid bcde44ed7d2a[1] removed references to ${lk_path} and made
git_maintainer.pl look for the files in the directory the script is
invoked from.

> Adding . to that would change that.

Andrew points out[2] that some we might need to include .scripts
too. Where do we expect the config files to be (do comment)?

.                   - current directory (?)
${lk_path}/         - the top directory of source tree
${HOME}/            - per-user
${lk_path}/scripts  - how is this dfferent from ${lk_path}?
${lk_path}/.scripts - Andrew says someone might have started using it

I'd also add in this commit or another
${XDG_CONFIG_HOME}/get_maintainers. However, I think files in this
directory should be named conf and ignore instead of
.get_maintainer.conf and get_maintainer.ignore (respectively).


[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3Dbcde44ed7d2a
[2] https://lore.kernel.org/lkml/20211116135627.321aa8ef46ee389cf66692df@li=
nux-foundation.org/
=2D-=20
=C5=81ukasz Stelmach
Samsung R&D Institute Poland
Samsung Electronics

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXpuyqjq9kGEVr9UQsK4enJilgBAFAmGU8J4ACgkQsK4enJil
gBCZmggAhLC3PyMdHpaR6kj2II9NuWyyUChrj5l5xgo7vX9kyEOgl7fTS13KHfEf
hymgTWo+zhxE34ilpCcNM++mpkcyo2ICx1e/gVwh4erRGQPzt/Qg0JY1c1w6c6TT
Wzf55uSBByiVFEgmamHzy+mURVh6yJ9NqBI5zDokiHdzts3/IwDcP4+uQhnNwcvX
lmlQQRfIpc2B8LxETCbI6ngpO9Qa0MRtL6H9OtURwBumUSWWtUHBhGLzFSdthpaF
M9KGdwgN50QOCvAmgXHaijrki1/yjC7rNjXyG7iELvAaa7Nz6MqbAyeM3ju0eMjt
pJCwG2ht6Sjl0mIpnpaLeanVOe0vMg==
=PmqH
-----END PGP SIGNATURE-----
--=-=-=--
