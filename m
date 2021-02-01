Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDECD30A676
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 12:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233577AbhBALZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 06:25:54 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:39387 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232573AbhBALZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 06:25:50 -0500
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210201112507epoutp03f3aa78c8dccfdd9b2cb6e38993b78620~fm-4avxPI2565225652epoutp03o
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 11:25:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210201112507epoutp03f3aa78c8dccfdd9b2cb6e38993b78620~fm-4avxPI2565225652epoutp03o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1612178707;
        bh=xfa+ZD9sU/d9GH2H0lz6/BB8rxDyXjp9It1WHZ8f4p4=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=UNSY7uY71VLNk/mKNz7cCS6vjS0ZZAJXpwsoM/jgLXoQvTu0cM922d2msOCy3Ne3Z
         qMWNyxu836futQtHukMswSmqWN7SOpkoFQgljbIJ8jc75ZjNMXhljIQjQ7n25/65Ti
         O99bunkiA+jMv6lEAfEsieySjBBSe1pkPMPhL7Sg=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20210201112506epcas5p4193bbf3463b74f3f2f3ab3940f202cd7~fm-4HMIdz2776527765epcas5p4E;
        Mon,  1 Feb 2021 11:25:06 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        8D.49.15682.215E7106; Mon,  1 Feb 2021 20:25:06 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20210201112425epcas5p3d53035b9a66bbf4e40cb9481b2fa6c2f~fm-RXpgew2727827278epcas5p3T;
        Mon,  1 Feb 2021 11:24:25 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210201112425epsmtrp24782a663b0440d8d017e28b2e491e5cf~fm-RW7NNN1008410084epsmtrp2P;
        Mon,  1 Feb 2021 11:24:25 +0000 (GMT)
X-AuditID: b6c32a49-8d5ff70000013d42-21-6017e512dac1
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        23.64.13470.9E4E7106; Mon,  1 Feb 2021 20:24:25 +0900 (KST)
Received: from shradhat02 (unknown [107.122.8.248]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20210201112424epsmtip22f9ff8961bf740016089423bb11fbd49~fm-QW-ST21708517085epsmtip2k;
        Mon,  1 Feb 2021 11:24:24 +0000 (GMT)
From:   "Shradha Todi" <shradha.t@samsung.com>
To:     "'Joe Perches'" <joe@perches.com>, <linux-kernel@vger.kernel.org>
Cc:     <apw@canonical.com>, <pankaj.dubey@samsung.com>,
        "'Lakshay Mehra'" <l.mehra@samsung.com>
In-Reply-To: <a04109c80ded369fcbf8829d3d9461be7528226d.camel@perches.com>
Subject: RE: [PATCH] checkpatch: add warning for line space after "Fixes:"
 tag
Date:   Mon, 1 Feb 2021 16:54:14 +0530
Message-ID: <19f201d6f88c$cba69450$62f3bcf0$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIMnVYZntJh0uLbgjY/HIK9LfURLgIA4OGsAOhu42+pwJPokA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsWy7bCmuq7QU/EEg/2txhYf1mpYzL7/mMXi
        zvMbjBaXd81hs1i09Qu7A6vHrIZeNo8vq64xe/RtWcXo8XmTXABLFJdNSmpOZllqkb5dAlfG
        3CltrAVHhSqmPzrP2MC4SrCLkZNDQsBE4uKVFWxdjFwcQgK7GSUezn0B5XxilOiZtoMRwvnG
        KLHk9SamLkYOsJafK1Ig4nsZJV48/8MK4bxglDh/9QkryFw2AR2JJ1f+MIPYIgKuElPnv2AC
        sZkF4iTe3joDFucU8JT4tOIhWFxYIEBi/9GJYDaLgIrEomebwGxeAUuJa1vus0HYghInZz5h
        gZijJ3Fj6hQ2CFtbYtnC18wQ/yhI/Hy6jBVir5PEtgfHoPaKS7w8eoQd5FAJgUYOiaNvj7FC
        NLhI3H/9FKpZWOLV8S3sELaUxOd3e9kg7HyJqReeskB8XyGxvKcOImwvceDKHBYIW1Zi6ql1
        ULv4JHp/P2GCiPNK7JgHYytLfPm7B6peUmLescusExiVZiF5bRaS12YheW0WkhcWMLKsYpRM
        LSjOTU8tNi0wzEst1ytOzC0uzUvXS87P3cQITjVanjsY7z74oHeIkYmD8RCjBAezkgjvqUli
        CUK8KYmVValF+fFFpTmpxYcYpTlYlMR5dxg8iBcSSE8sSc1OTS1ILYLJMnFwSjUwZTSuilTX
        8DkQqDUpXcO+LXhv3MQ/M9i9IqJX6Vx/pPkxbIdNntbfjEOOF55nfLJSZN61wfC6Wdf7ZhHT
        c5xfJWecYtb69vfAy4vfYti+hpzmV108x+1UosKvi8enKN5wOvLu8f5fHAuXP/ug+PevgnKT
        mMbEW4cX3T/OpdV238ZtRwXb24cyk/2+THq8jfv6i/87Rezimts532z6Z8K6dl+HbmXyqth5
        7Vfe1QvNfZxwg/vhV44ntUmsMarlx1OM1MT9HczjXlzZs29fxrGLW2VetJdaSfFqJTYpbjve
        e0zh9rP9XLpX9/Y1NxWX6/mm39+m2Oh2zP3Tzow7RTnF3nNvunw+dEeILXdlo+m990osxRmJ
        hlrMRcWJAAdSv1akAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrELMWRmVeSWpSXmKPExsWy7bCSvO7LJ+IJBrMe8Vl8WKthMfv+YxaL
        O89vMFpc3jWHzWLR1i/sDqwesxp62Ty+rLrG7NG3ZRWjx+dNcgEsUVw2Kak5mWWpRfp2CVwZ
        Fz9MZi1Yylsxf9NmpgbG/VxdjBwcEgImEj9XpHQxcnEICexmlPj79ydbFyMnUFxS4vPFdUwQ
        trDEyn/P2SGKnjFKrL02jREkwSagI/Hkyh9mEFtEwF1i+dw3YDazQILE+4u/WCAarjBKtFxs
        ZQdJcAp4Snxa8ZAJZLOwgJ9ET7skSJhFQEVi0bNNYMt4BSwlrm25zwZhC0qcnPmEBWKmgcT9
        Qx2sELa2xLKFr5khjlOQ+Pl0GSvEDU4S2x4cY4KoEZd4efQI+wRG4VlIRs1CMmoWklGzkLQs
        YGRZxSiZWlCcm55bbFhgmJdarlecmFtcmpeul5yfu4kRHC1amjsYt6/6oHeIkYmD8RCjBAez
        kgjvqUliCUK8KYmVValF+fFFpTmpxYcYpTlYlMR5L3SdjBcSSE8sSc1OTS1ILYLJMnFwSjUw
        rVDRVT4xbalh3+1dIt9q4gO+7K5kmz+vSE5EV96U75vvO+c4846pM3jf3C1SSHTojHT7kMrT
        8Tdq4yklHf8X9xUcbXpzrnxNSrB2m6fu0B8sPXnO9SMBS3fcUd7br1eaVhc75bHsrc7dbTGC
        eY/vuLCuEJS8fXzBJ8OVhzYeOFEiKJbCefiJBH+qYtnXxAbNfPNXuTf2v++YVPp5Y3ZKduRG
        u/9VJawq08XS5/79J7zIbKrclK1xyxLEPh2MLl7xfW6U531Bj0vzj1dvv9Xru681+8eiG+Zs
        +3s/HVjO8vPlfKNkp9uCX3WO1y1KyvHcYBJqkNVXJrZ4RvS6ddsdmwSLbmTkyE3VUo/s+Wig
        xFKckWioxVxUnAgA+LRHbgUDAAA=
X-CMS-MailID: 20210201112425epcas5p3d53035b9a66bbf4e40cb9481b2fa6c2f
X-Msg-Generator: CA
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210128152646epcas5p3e0ceb57e0a2e668b4281b5733dd117d4
References: <CGME20210128152646epcas5p3e0ceb57e0a2e668b4281b5733dd117d4@epcas5p3.samsung.com>
        <1611847603-15736-1-git-send-email-shradha.t@samsung.com>
        <a04109c80ded369fcbf8829d3d9461be7528226d.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Joe Perches <joe=40perches.com>
> Subject: Re: =5BPATCH=5D checkpatch: add warning for line space after
=22Fixes:=22 tag
>=20
> On Thu, 2021-01-28 at 20:56 +0530, Shradha Todi wrote:
> > Add a check to give warning for line break between Fixes tag
> > and signature tags as that is the commonly followed style.
> >
> > Also add a --fix option to delete space lines after =22Fixes:=22 tag.
> >
> > Signed-off-by: Lakshay Mehra <l.mehra=40samsung.com>
> > Signed-off-by: Shradha Todi <shradha.t=40samsung.com>
> > ---
> > =A0scripts/checkpatch.pl=20=7C=209=20+++++++++=0D=0A>=20>=20=A01=20file=
=20changed,=209=20insertions(+)=0D=0A>=20>=0D=0A>=20>=20diff=20--git=20a/sc=
ripts/checkpatch.pl=20b/scripts/checkpatch.pl=0D=0A>=20>=20index=2092e888e.=
.6c144c5=20100755=0D=0A>=20>=20---=20a/scripts/checkpatch.pl=0D=0A>=20>=20+=
++=20b/scripts/checkpatch.pl=0D=0A>=20>=20=40=40=20-3027,6=20+3027,15=20=40=
=40=20sub=20process=20=7B=0D=0A>=20>=20=A0=09=09=09=24commit_log_long_line=
=20=3D=201;=0D=0A>=20>=20=A0=09=09=7D=0D=0A>=20>=0D=0A>=20>=0D=0A>=20>=20+=
=23=20Check=20for=20no=20line=20break=20after=20Fixes=0D=0A>=20>=20+=09=09i=
f=20(=24line=20=3D=7E=20/=5E=5Cs*Fixes:/i=20&&=20=24rawlines=5B=24linenr=5D=
=20=3D=7E=0D=0A/=5E=5Cs*=24/)=20=7B=0D=0A>=20>=20+=09=09=09if=20(WARN(=22UN=
NECESSARY_NEWLINE=22,=0D=0A>=20>=20+=09=09=09=09=20=22Newline=20is=20not=20=
required=20after=20Fixes:=5Cn=22=20.=0D=0A>=20=24herecurr)=20&&=0D=0A>=20>=
=20+=09=09=09=20=20=20=20=24fix)=20=7B=0D=0A>=20>=20+=09=09=09=09fix_delete=
_line(=24fixlinenr+1,=20=24rawline);=0D=0A>=20>=20+=09=09=09=7D=0D=0A>=20>=
=20+=09=09=7D=0D=0A>=20=0D=0A>=20I=20think=20this=20isn't=20necessary=20and=
=20=24rawlines=5B=24linenr=5D=20may=20be=20not=20exist.=0D=0A>=20=0D=0A=0D=
=0AI=20recently=20submitted=20a=20patch=20with=20the=20fixes=20tag=20follow=
ed=20by=20a=20line=20break=0D=0Aand=20then=20SOB.=0D=0AI=20received=20a=20c=
omment=20saying=20=22no=20line=20space=20between=20Fixes=20and=20SOB=22=20=
=5B1=5D.=0D=0ASo=20my=20intention=20of=20adding=20this=20was=20to=20save=20=
the=20maintainers=20time=20from=20these=0D=0Asilly=20mistakes.=0D=0AAny=20s=
uggestions=20for=20improving=20this=20patch?=20Thanks=20a=20ton=20for=20the=
=20prompt=0D=0Areview.=0D=0A=5B1=5D:=20https://lkml.org/lkml/2021/1/6/291=
=0D=0A=0D=0A=0D=0A
