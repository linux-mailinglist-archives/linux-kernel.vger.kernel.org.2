Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F05A3B8F35
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 10:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235564AbhGAI7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 04:59:25 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:51475 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235088AbhGAI7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 04:59:25 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210701085653epoutp01995134a2b6427e2511328f6b5eccdc58~NnvSAjCtB1204312043epoutp01M
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 08:56:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210701085653epoutp01995134a2b6427e2511328f6b5eccdc58~NnvSAjCtB1204312043epoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1625129813;
        bh=xCqYRwFEWIqfm8OHdKKtjgw0rGwmtaPI8w8XRpMJlhU=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=S2/ijBNq7qOh5keGh6tp7+Wi0eQ0lfgOvFrJ/a/S0MCp2S/cnHZC5aRNlWL/2sGLG
         z9y1XAWd+ZARpl4swulxEz1kH1nKkAMoo0QTdSJdsBwE1JEHzI12SwNep8NwMIGTNx
         seUBFXLLbwrGN8numi/g/jVQh3gSNvKl1Ukof3w8=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210701085652epcas1p11fc53fb9cfafb5eb29a1a70e41449e36~NnvRf7zza2531625316epcas1p1_;
        Thu,  1 Jul 2021 08:56:52 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.159]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4GFsXM6Y68z4x9QJ; Thu,  1 Jul
        2021 08:56:51 +0000 (GMT)
X-AuditID: b6c32a35-9fad2a80000026e0-34-60dd835264dd
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        28.05.09952.2538DD06; Thu,  1 Jul 2021 17:56:50 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH] mm: cleancache: fix potential race in cleancache apis
Reply-To: ohoono.kwon@samsung.com
Sender: =?UTF-8?B?6raM7Jik7ZuI?= <ohoono.kwon@samsung.com>
From:   =?UTF-8?B?6raM7Jik7ZuI?= <ohoono.kwon@samsung.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        =?UTF-8?B?6raM7Jik7ZuI?= <ohoono.kwon@samsung.com>
CC:     Matthew Wilcox <willy@infradead.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        "ohkwon1043@gmail.com" <ohkwon1043@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <YN1ZjHx74KUzA4Rs@kroah.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20210701085650epcms1p381d6d9c0052408c2ba011777fe3e74ba@epcms1p3>
Date:   Thu, 01 Jul 2021 17:56:50 +0900
X-CMS-MailID: 20210701085650epcms1p381d6d9c0052408c2ba011777fe3e74ba
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNJsWRmVeSWpSXmKPExsWy7bCmvm5Q890Eg8YJIhZz1q9hs2hevJ7N
        Ytnip4wWl3fNYbO4t+Y/q8Xe/b4Wu36uYLb4/WMOmwOHx85Zd9k9Nq/Q8tj0aRK7x4kZv1k8
        9s9dw+7x8ektFo++LasYPT5vkgvgiMqxyUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0
        MFdSyEvMTbVVcvEJ0HXLzAE6TEmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYGhQ
        oFecmFtcmpeul5yfa2VoYGBkClSZkJPx6esH9oLDuhVdJ/czNjBO1+li5OSQEDCR2Pp9DXMX
        IxeHkMAORolXCw6wdTFycPAKCEr83SEMUiMs4CVx618DM0hYSEBRYttpN4iwlcS0vn9MIDab
        gIXE87U/WUFsEYFiiZYvSxhBRjILbGWS6Hp3nRliF6/EjPanLBC2tMT25VsZQWxOAU2JE19/
        sEPERSVurn4LZ78/Np8RwhaRaL13FmqOoMSDn7uh4pISN9vusoAskxDoZ5S4v64FypnAKLHk
        ySQ2iCpziWcbWsCm8gr4SvRf+Ad2KouAqsTp/9ehtrlIrFl0CewdZgFtiWULX4N9zAx03fpd
        +hAlihI7f89lhCjhk3j3tYcV5rEd854wgZRLAI1c9tsD5se+6ZehLvCQOHrlGzSc7zBJrP/4
        hXUCo8IsRFDPQrJ4FsLiBYzMqxjFUguKc9NTiw0LDJFjdxMjOJVqme5gnPj2g94hRiYOxkOM
        EhzMSiK8UTtvJwjxpiRWVqUW5ccXleakFh9iNAV6eSKzlGhyPjCZ55XEG5oaGRsbW5iYmZuZ
        GiuJ8+5kO5QgJJCeWJKanZpakFoE08fEwSnVwLT4x6PDPkF5wg9eXOhssedadeX4yk8cR/iV
        ji1eJDlR3+PLl3lhm/hspTszmY/Z5e6Ze9r5H9eRi2ndn9MFJ7EVhVkFG4WGxz0NOt1Z7+Ee
        GHSm7MDcP1zNh87tSmQ5xsXV1tdov/rz3rcdZ2Ys0K72jeSZfPz6nH/P67VmbGYO8sk7I+Le
        c6Rp1sXgJbZRyfb63XHyz2faJ636ptDCUO7YerFqxjJNHtfp0Su/V3U8cxJ60jfHwOvq+Yh3
        yXNvOPO5hPy5nVT3btobxqauvyF3bgcI/+jMFO0VZ5a80any403cy5NOny8fLc9cM32xmNpV
        jdTvWWun5Z66pLFzQ2jm/x49zufhQgXshzRfXlBiKc5INNRiLipOBAAJGG7JLgQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210630073310epcms1p2ad6803cfd9dbc8ab501c4c99f799f4da
References: <YN1ZjHx74KUzA4Rs@kroah.com> <YNxjoxBNdWm604FU@kroah.com>
        <20210630073310epcms1p2ad6803cfd9dbc8ab501c4c99f799f4da@epcms1p2>
        <YNwnqOuFlIG6Jofy@kroah.com> <YNxVAZDttnWncNUy@casper.infradead.org>
        <20210701050644epcms1p5ceaf654fdabec4a126081f9edcbb3fff@epcms1p5>
        <CGME20210630073310epcms1p2ad6803cfd9dbc8ab501c4c99f799f4da@epcms1p3>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 01, 2021 at 07:58:36AM +0200, gregkh=40linuxfoundation.org wrot=
e:
> On Thu, Jul 01, 2021 at 02:06:44PM +0900, =EA=B6=8C=EC=98=A4=ED=9B=88=20w=
rote:=0D=0A>=20>=20On=20Wed,=20Jun=2030,=202021=20at=2002:29:23PM=20+0200,=
=20gregkh=40linuxfoundation.org=20wrote:=0D=0A>=20>=20>=20On=20Wed,=20Jun=
=2030,=202021=20at=2012:26:57PM=20+0100,=20Matthew=20Wilcox=20wrote:=0D=0A>=
=20>=20>=20>=20On=20Wed,=20Jun=2030,=202021=20at=2010:13:28AM=20+0200,=20gr=
egkh=40linuxfoundation.org=20wrote:=0D=0A>=20>=20>=20>=20>=20On=20Wed,=20Ju=
n=2030,=202021=20at=2004:33:10PM=20+0900,=20=EA=B6=8C=EC=98=A4=ED=9B=88=20w=
rote:=0D=0A>=20>=20>=20>=20>=20>=20Current=20cleancache=20api=20implementat=
ion=20has=20potential=20race=20as=20follows,=0D=0A>=20>=20>=20>=20>=20>=20w=
hich=20might=20lead=20to=20corruption=20in=20filesystems=20using=20cleancac=
he.=0D=0A>=20>=20>=20>=20>=20>=20=0D=0A>=20>=20>=20>=20>=20>=20thread=200=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20thread=201=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20thread=202=0D=0A>=
=20>=20>=20>=20>=20>=20=0D=0A>=20>=20>=20>=20>=20>=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20in=20put_page=0D=0A>=20>=
=20>=20>=20>=20>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20get=20pool_id=20K=20for=20fs1=0D=0A>=20>=20>=20>=20>=20>=
=20invalidate_fs=20on=20fs1=0D=0A>=20>=20>=20>=20>=20>=20frees=20pool_id=20=
K=0D=0A>=20>=20>=20>=20>=20>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20init_fs=20for=20fs2=0D=
=0A>=20>=20>=20>=20>=20>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20allocates=20pool_id=20K=0D=0A>=
=20>=20>=20>=20>=20>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20put_page=20puts=20page=0D=0A>=20>=20>=20>=20>=20>=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20whi=
ch=20belongs=20to=20fs1=0D=0A>=20>=20>=20>=20>=20>=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20into=20cleancache=20pool=
=20for=20fs2=0D=0A>=20>=20>=20>=20>=20>=20=0D=0A>=20>=20>=20>=20>=20>=20At=
=20this=20point,=20a=20file=20cache=20which=20originally=20belongs=20to=20f=
s1=20might=20be=0D=0A>=20>=20>=20>=20>=20>=20copied=20back=20to=20cleancach=
e=20pool=20of=20fs2,=20which=20might=20be=20later=20used=20as=20if=0D=0A>=
=20>=20>=20>=20>=20>=20it=20were=20normal=20cleancache=20of=20fs2,=20and=20=
could=20eventually=20corrupt=20fs2=20when=0D=0A>=20>=20>=20>=20>=20>=20flus=
hed=20back.=0D=0A>=20>=20>=20>=20>=20>=20=0D=0A>=20>=20>=20>=20>=20>=20Add=
=20rwlock=20in=20order=20to=20synchronize=20invalidate_fs=20with=20other=20=
cleancache=0D=0A>=20>=20>=20>=20>=20>=20operations.=0D=0A>=20>=20>=20>=20>=
=20>=20=0D=0A>=20>=20>=20>=20>=20>=20In=20normal=20situations=20where=20fil=
esystems=20are=20not=20frequently=20mounted=20or=0D=0A>=20>=20>=20>=20>=20>=
=20unmounted,=20there=20will=20be=20little=20performance=20impact=20since=
=0D=0A>=20>=20>=20>=20>=20>=20read_lock/read_unlock=20apis=20are=20used.=0D=
=0A>=20>=20>=20>=20>=20>=20=0D=0A>=20>=20>=20>=20>=20>=20Signed-off-by:=20O=
hhoon=20Kwon=20<ohoono.kwon=40samsung.com>=0D=0A>=20>=20>=20>=20>=20=0D=0A>=
=20>=20>=20>=20>=20What=20commit=20does=20this=20fix?=20=20Should=20it=20go=
=20to=20stable=20kernels?=0D=0A>=20>=20>=20>=20=0D=0A>=20>=20>=20>=20I=20ha=
ve=20a=20commit=20I=20haven't=20submitted=20yet=20with=20this=20changelog:=
=0D=0A>=20>=20>=20>=20=0D=0A>=20>=20>=20>=20=20=20=20=20Remove=20cleancache=
=0D=0A>=20>=20>=20>=20=0D=0A>=20>=20>=20>=20=20=20=20=20The=20last=20cleanc=
ache=20backend=20was=20deleted=20in=20v5.3=20(=22xen:=20remove=20tmem=0D=0A=
>=20>=20>=20>=20=20=20=20=20driver=22),=20so=20it=20has=20been=20unused=20s=
ince.=20=20Remove=20all=20its=20filesystem=20hooks.=0D=0A>=20>=20>=20>=20=
=0D=0A>=20>=20>=20>=20=20=20=20=20Signed-off-by:=20Matthew=20Wilcox=20(Orac=
le)=20<willy=40infradead.org>=0D=0A>=20>=20>=20=20=0D=0A>=20>=20>=20That's=
=20even=20better=21=0D=0A>=20>=20>=20=20=0D=0A>=20>=20>=20But=20if=20so,=20=
how=20is=20the=20above=20reported=20problem=20even=20a=20problem=20if=20no=
=20one=20is=0D=0A>=20>=20>=20using=20cleancache?=0D=0A>=20>=20>=20=20=0D=0A=
>=20>=20>=20thanks,=0D=0A>=20>=20>=20=20=0D=0A>=20>=20>=20greg=20k-h=0D=0A>=
=20>=20>=20=0D=0A>=20>=20Dear=20all.=0D=0A>=20>=20=0D=0A>=20>=20We=20are=20=
using=20Cleancache=20APIs=20for=20our=20proprietary=20feature=20in=20Samsun=
g.=0D=0A>=20>=20As=20Wilcox=20mentioned,=20however,=20there=20is=20no=20cle=
ancache=20backend=20in=20current=20kernel=0D=0A>=20>=20mainline.=0D=0A>=20>=
=20So=20if=20the=20race=20patch=20shall=20be=20accepted,=20then=20it=20seem=
s=20unnecessary=20to=20patch=20=0D=0A>=20>=20previous=20stable=20kernels.=
=0D=0A>=20>=20=0D=0A>=20>=20Meanwhile,=20I=20personally=20think=20cleancach=
e=20API=20still=20has=20potential=20to=20be=20a=20good=0D=0A>=20>=20materia=
l=20when=20used=20with=20new=20arising=20technologies=20such=20as=20pmem=20=
or=20NVMe.=0D=0A>=20>=20=0D=0A>=20>=20So=20I=20suggest=20to=20postpone=20re=
moving=20cleancache=20for=20a=20while.=0D=0A>=20=20=0D=0A>=20If=20there=20a=
re=20no=20in-kernel=20users,=20it=20needs=20to=20be=20removed.=20=20If=20yo=
u=20rely=20on=0D=0A>=20this,=20wonderful,=20please=20submit=20your=20code=
=20as=20soon=20as=20possible.=0D=0A>=20=20=0D=0A>=20thanks,=0D=0A>=20=20=0D=
=0A>=20greg=20k-h=0D=0A>=20=0D=0AWe=20will=20discuss=20internally=20and=20s=
ee=20if=20we=20can=20submit=20our=20feature.=0D=0A=0D=0AThanks,=0D=0AOhhoon=
=20Kwon
