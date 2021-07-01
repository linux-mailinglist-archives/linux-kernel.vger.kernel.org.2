Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27CD83B8D4F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 07:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbhGAFJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 01:09:19 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:33484 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhGAFJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 01:09:18 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210701050646epoutp022c08e6d5971f6fa3a814a2e34b83d3d7~NkmXrr2L-1632616326epoutp02N
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 05:06:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210701050646epoutp022c08e6d5971f6fa3a814a2e34b83d3d7~NkmXrr2L-1632616326epoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1625116007;
        bh=Y6ptCkRzt+ukPgeWud4JsXHQcvHw2fahz0U8y6ETKLo=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=AnTcEtwYrnd4PxcaCw0TeWvyMmACa+BNl03kvmj9krTb8MinFd5iotH/H2TQIux/l
         qh7IAvffus8DWuoZSeOXR76mVUJqnsNBdA8DoiRiYRKYbmxVwGfcVvq8gtHDbLhPad
         i9dG5T1837me7FqNH1WrUgbwj8xqJYqJoLBrIUeM=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20210701050646epcas1p4f2734bdc1e1376b8483aea31fa944010~NkmXOiDb81858318583epcas1p4g;
        Thu,  1 Jul 2021 05:06:46 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.163]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4GFmQr3Cqbz4x9Pt; Thu,  1 Jul
        2021 05:06:44 +0000 (GMT)
X-AuditID: b6c32a39-86dff70000002572-14-60dd4d64da50
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        90.09.09586.46D4DD06; Thu,  1 Jul 2021 14:06:44 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH] mm: cleancache: fix potential race in cleancache apis
Reply-To: ohoono.kwon@samsung.com
Sender: =?UTF-8?B?6raM7Jik7ZuI?= <ohoono.kwon@samsung.com>
From:   =?UTF-8?B?6raM7Jik7ZuI?= <ohoono.kwon@samsung.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Matthew Wilcox <willy@infradead.org>
CC:     =?UTF-8?B?6raM7Jik7ZuI?= <ohoono.kwon@samsung.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        "ohkwon1043@gmail.com" <ohkwon1043@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <YNxjoxBNdWm604FU@kroah.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20210701050644epcms1p5ceaf654fdabec4a126081f9edcbb3fff@epcms1p5>
Date:   Thu, 01 Jul 2021 14:06:44 +0900
X-CMS-MailID: 20210701050644epcms1p5ceaf654fdabec4a126081f9edcbb3fff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJJsWRmVeSWpSXmKPExsWy7bCmrm6K790Eg7bt4hZz1q9hs2hevJ7N
        Ytnip4wWl3fNYbO4t+Y/q8Xe/b4Wu36uYLb4/WMOmwOHx85Zd9k9Nq/Q8tj0aRK7x4kZv1k8
        9s9dw+7x8ektFo++LasYPT5vkgvgiMqxyUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0
        MFdSyEvMTbVVcvEJ0HXLzAE6TEmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYGhQ
        oFecmFtcmpeul5yfa2VoYGBkClSZkJOxf4FLwV2Vis17P7M1MN5W7mLk5JAQMJFYeuwnUxcj
        F4eQwA5GiTNzlzF2MXJw8AoISvzdIQxSIyzgJXHrXwMzSFhIQFFi22k3iLCVxLS+f0wgNpuA
        hcTztT9ZQWwRgVSJjjPXwUYyCxxmkphxqYsdYhevxIz2pywQtrTE9uVbGUFsTgFNid9trWwQ
        cVGJm6vfssPY74/NZ4SwRSRa751lhrAFJR783A0Vl5S42XaXBWSZhEA/o8T9dS1QzgRGiSVP
        JkFNNZd4tqEFbCqvgK9E/+f7YKeyCKhKfP+5FGqqi8TKfSfBrmMW0JZYtvA12MfMQNet36UP
        UaIosfP3XEaIEj6Jd197WGEe2zHvCRNIuQTQyGW/PWB+7Jt+GeoCD4mjV76BbRIS+M0osWk7
        2wRGhVmIkJ6FZO8shL0LGJlXMYqlFhTnpqcWGxaYIsftJkZwGtWy3ME4/e0HvUOMTByMhxgl
        OJiVRHijdt5OEOJNSaysSi3Kjy8qzUktPsRoCvTxRGYp0eR8YCLPK4k3NDUyNja2MDEzNzM1
        VhLn3cl2KEFIID2xJDU7NbUgtQimj4mDU6qBKTLigENa83LNVxssS3O23k3XMevd7sTdZXZc
        6ZzccwNGiek7Hm1+cijIv2jt+f11l36YHin7X82UbhVfv/h60jQff8Mpd7ZNCJupe2DOR9V1
        b7aH/7gS+XDu/k69Z/vZozOufLrJ7e5/Im0hw+r4VqlDrOEvWm2K9Ry4Px1zqGh+cs1G92hr
        856vdb0+5b8iA96d7qja6Z7hv6S7vCmz+pWmJk/wVJ5Lhz9tuDa5bG1UYtPZHdmua8oTD0ps
        C9RMC7XZduW0vMEB0cLDB9fnb9QvnsBY/YThVrKA1GKvp/v3c6mxlDqfiTdJTq8/uKw/84kZ
        90L1F3N5rxrct1U1tjKtf1fP8i5k4oG+qUw/lViKMxINtZiLihMBZh/DIiwEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210630073310epcms1p2ad6803cfd9dbc8ab501c4c99f799f4da
References: <YNxjoxBNdWm604FU@kroah.com>
        <20210630073310epcms1p2ad6803cfd9dbc8ab501c4c99f799f4da@epcms1p2>
        <YNwnqOuFlIG6Jofy@kroah.com> <YNxVAZDttnWncNUy@casper.infradead.org>
        <CGME20210630073310epcms1p2ad6803cfd9dbc8ab501c4c99f799f4da@epcms1p5>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 1, 2021 at 02:06:45PM +0900, =EA=B6=8C=EC=98=A4=ED=9B=88=20wrot=
e:=0D=0A>=20On=20Wed,=20Jun=2030,=202021=20at=2012:26:57PM=20+0100,=20Matth=
ew=20Wilcox=20wrote:=0D=0A>=20>=20On=20Wed,=20Jun=2030,=202021=20at=2010:13=
:28AM=20+0200,=20gregkh=40linuxfoundation.org=20wrote:=0D=0A>=20>=20>=20On=
=20Wed,=20Jun=2030,=202021=20at=2004:33:10PM=20+0900,=20=EA=B6=8C=EC=98=A4=
=ED=9B=88=20wrote:=0D=0A>=20>=20>=20>=20Current=20cleancache=20api=20implem=
entation=20has=20potential=20race=20as=20follows,=0D=0A>=20>=20>=20>=20whic=
h=20might=20lead=20to=20corruption=20in=20filesystems=20using=20cleancache.=
=0D=0A>=20>=20>=20>=20=0D=0A>=20>=20>=20>=20thread=200=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20thread=201=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20thread=202=0D=0A>=20>=20>=20>=20=0D=0A>=
=20>=20>=20>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20in=20put_page=0D=0A>=20>=20>=20>=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20get=20pool_id=20K=20for=20fs1=
=0D=0A>=20>=20>=20>=20invalidate_fs=20on=20fs1=0D=0A>=20>=20>=20>=20frees=
=20pool_id=20K=0D=0A>=20>=20>=20>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20init_fs=20for=20fs2=
=0D=0A>=20>=20>=20>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20allocates=20pool_id=20K=0D=0A>=20=
>=20>=20>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20put_page=20puts=20page=0D=0A>=20>=20>=20>=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20which=20belongs=20to=20f=
s1=0D=0A>=20>=20>=20>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20into=20cleancache=20pool=20for=20fs2=0D=0A>=20>=20>=20=
>=20=0D=0A>=20>=20>=20>=20At=20this=20point,=20a=20file=20cache=20which=20o=
riginally=20belongs=20to=20fs1=20might=20be=0D=0A>=20>=20>=20>=20copied=20b=
ack=20to=20cleancache=20pool=20of=20fs2,=20which=20might=20be=20later=20use=
d=20as=20if=0D=0A>=20>=20>=20>=20it=20were=20normal=20cleancache=20of=20fs2=
,=20and=20could=20eventually=20corrupt=20fs2=20when=0D=0A>=20>=20>=20>=20fl=
ushed=20back.=0D=0A>=20>=20>=20>=20=0D=0A>=20>=20>=20>=20Add=20rwlock=20in=
=20order=20to=20synchronize=20invalidate_fs=20with=20other=20cleancache=0D=
=0A>=20>=20>=20>=20operations.=0D=0A>=20>=20>=20>=20=0D=0A>=20>=20>=20>=20I=
n=20normal=20situations=20where=20filesystems=20are=20not=20frequently=20mo=
unted=20or=0D=0A>=20>=20>=20>=20unmounted,=20there=20will=20be=20little=20p=
erformance=20impact=20since=0D=0A>=20>=20>=20>=20read_lock/read_unlock=20ap=
is=20are=20used.=0D=0A>=20>=20>=20>=20=0D=0A>=20>=20>=20>=20Signed-off-by:=
=20Ohhoon=20Kwon=20<ohoono.kwon=40samsung.com>=0D=0A>=20>=20>=20=0D=0A>=20>=
=20>=20What=20commit=20does=20this=20fix?=20=20Should=20it=20go=20to=20stab=
le=20kernels?=0D=0A>=20>=20=0D=0A>=20>=20I=20have=20a=20commit=20I=20haven'=
t=20submitted=20yet=20with=20this=20changelog:=0D=0A>=20>=20=0D=0A>=20>=20=
=20=20=20=20Remove=20cleancache=0D=0A>=20>=20=0D=0A>=20>=20=20=20=20=20The=
=20last=20cleancache=20backend=20was=20deleted=20in=20v5.3=20(=22xen:=20rem=
ove=20tmem=0D=0A>=20>=20=20=20=20=20driver=22),=20so=20it=20has=20been=20un=
used=20since.=20=20Remove=20all=20its=20filesystem=20hooks.=0D=0A>=20>=20=
=0D=0A>=20>=20=20=20=20=20Signed-off-by:=20Matthew=20Wilcox=20(Oracle)=20<w=
illy=40infradead.org>=0D=0A>=20=20=0D=0A>=20That's=20even=20better=21=0D=0A=
>=20=20=0D=0A>=20But=20if=20so,=20how=20is=20the=20above=20reported=20probl=
em=20even=20a=20problem=20if=20no=20one=20is=0D=0A>=20using=20cleancache?=
=0D=0A>=20=20=0D=0A>=20thanks,=0D=0A>=20=20=0D=0A>=20greg=20k-h=0D=0A>=20=
=0D=0ADear=20all.=0D=0A=0D=0AWe=20are=20using=20Cleancache=20APIs=20for=20o=
ur=20proprietary=20feature=20in=20Samsung.=0D=0AAs=20Wilcox=20mentioned,=20=
however,=20there=20is=20no=20cleancache=20backend=20in=20current=20kernel=
=0D=0Amainline.=0D=0ASo=20if=20the=20race=20patch=20shall=20be=20accepted,=
=20then=20it=20seems=20unnecessary=20to=20patch=20=0D=0Aprevious=20stable=
=20kernels.=0D=0A=0D=0AMeanwhile,=20I=20personally=20think=20cleancache=20A=
PI=20still=20has=20potential=20to=20be=20a=20good=0D=0Amaterial=20when=20us=
ed=20with=20new=20arising=20technologies=20such=20as=20pmem=20or=20NVMe.=0D=
=0A=0D=0ASo=20I=20suggest=20to=20postpone=20removing=20cleancache=20for=20a=
=20while.=0D=0A=0D=0AThanks,=0D=0AOhhoon=20Kwon.
