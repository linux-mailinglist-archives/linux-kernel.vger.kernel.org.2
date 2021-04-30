Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09EC636F837
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 11:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbhD3J4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 05:56:21 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:16655 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbhD3J4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 05:56:20 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210430095531epoutp016f60eeb1481eee9028c5a2da9c40bfe2~6mix81DoM1011010110epoutp01G
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 09:55:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210430095531epoutp016f60eeb1481eee9028c5a2da9c40bfe2~6mix81DoM1011010110epoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1619776531;
        bh=uSqL/N/2DSTcGGCi0K+7p33lEueoqIaUGi/6k7rkfTY=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=p23mXhWNJv6ceadsHBv2OvfP8m4pX4XFWjOKZTIr2AIwUNYy+FIjl0qcs2bONK5fw
         xxRelezmbPWgwtMPWLaBSmyhye252wRbWR2NT8vTdOT4IPX38vQ/idOeTrw9CjCkNg
         4EzlDHNQLgEuNdgJ5wZkLLJrZmS/W4Tptt2NC3so=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20210430095531epcas5p1aba86c36c84bbe54529cbbf1cac3da1c~6mixbq5D51593315933epcas5p13;
        Fri, 30 Apr 2021 09:55:31 +0000 (GMT)
X-AuditID: b6c32a49-bf1ff70000002586-a6-608bd4132d2e
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4B.8F.09606.314DB806; Fri, 30 Apr 2021 18:55:31 +0900 (KST)
Mime-Version: 1.0
Subject: RE:[PATCH 2/2] mm/kasan: proc interface to read KASAN errors at any
 time
Reply-To: maninder1.s@samsung.com
Sender: Maninder Singh <maninder1.s@samsung.com>
From:   Maninder Singh <maninder1.s@samsung.com>
To:     Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>
CC:     Marco Elver <elver@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        AMIT SAHRAWAT <a.sahrawat@samsung.com>,
        Vaneet Narang <v.narang@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20210430095433epcms5p53089199bdd0411193fb9a1154c57a24f@epcms5p5>
Date:   Fri, 30 Apr 2021 15:24:33 +0530
X-CMS-MailID: 20210430095433epcms5p53089199bdd0411193fb9a1154c57a24f
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHKsWRmVeSWpSXmKPExsWy7bCmpq7wle4Egw3/eCwu7k61mLN+DZvF
        94nT2S0mPGxjt2g7s53Vov3jXmaLFc/uM1lc3jWHzeLemv+sFse3bmG2OHRyLqMDt8fOWXfZ
        PRZsKvXYM/Ekm8emT5PYPU7M+M3i0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBlP171nK5go
        XvFii2sD42GxLkZODgkBE4l7X2YzdTFycQgJ7GaUePBkF0sXIwcHr4CgxN8dwiA1wgLBEvef
        X2cDsYUEFCUuzFjDCFIiLGAg8WurBkiYTUBPYtWuPSwgtohAoMSyHcfARjILPGKSWLviCBvE
        Ll6JGe1PWSBsaYnty7cyQtiiEjdXv2WHsd8fmw8VF5FovXeWGcIWlHjwczdUXEZi9eZeFpAF
        EgLdjBKPfzRDNc9hlPixxAfCNpfYvWEe2DJeAV+J9c0NYDaLgKpE++UGVogaF4m1ExaDDWUW
        0JZYtvA1M8hjzAKaEut36UOUyEpMPbWOCaKET6L39xMmmF92zIOxVSVabm5ghfnr88ePUD96
        SCw8/poFEm6BEhsXb2OZwCg/CxG6s5AsnoWweAEj8ypGydSC4tz01GLTAsO81HK94sTc4tK8
        dL3k/NxNjOAkpOW5g/Hugw96hxiZOBgPMUpwMCuJ8P5e15kgxJuSWFmVWpQfX1Sak1p8iFGa
        g0VJnFfQuTpBSCA9sSQ1OzW1ILUIJsvEwSnVwDSld1HtNLfjN3esk/4kwpx21Omn6YxDO9aY
        +MkdeqsvoHiAW/3M+a49qy9K/BGdKqnu+czlYyrf0uaZMrMc7x6fceyedqGmWOctmVSR23e2
        LucXm9VxIOig4p13y02fs6wLOWzmHaFXGMYpY6pyh8X4yM+kBWFaf/sUAibLtYXOE3KpaGEN
        sY8w05Zd/4PlSQTvvdopke3flpf/McjZ3lGWOoNpVbWjXuDZ2V+8I8V3P0w88aFHJFjY2/KL
        sJC8pQuv6DNf/+MKl6LfSwVIFU6Rly//mSN2qaiNZdq+o4+by8Lf5nT4z/oWHL5Z4s7S8FMy
        u3h2Nayq4+SUqdEJU7JcNenSpw08fPrVVu2/lFiKMxINtZiLihMBkoJfNrEDAAA=
X-CMS-RootMailID: 20210422081536epcas5p417c144cce0235933a1cd0f29ad55470a
References: <CGME20210422081536epcas5p417c144cce0235933a1cd0f29ad55470a@epcms5p5>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi=C2=A0Alex,=0D=0A=C2=A0=0D=0A=C2=A0=0D=0A>We've=C2=A0recently=C2=A0attemp=
ted=C2=A0to=C2=A0build=C2=A0a=C2=A0universal=C2=A0library=C2=A0capturing=C2=
=A0every=0D=0A>error=C2=A0report,=C2=A0but=C2=A0then=C2=A0were=C2=A0pointed=
=C2=A0to=C2=A0tracefs,=C2=A0which=C2=A0was=C2=A0just=C2=A0enough=0D=0A>for=
=C2=A0our=C2=A0purpose=C2=A0(https://protect2.fireeye.com/v1/url?k=3D36bfb1=
91-6924888b-36be3ade-0cc47a6cba04-0e7fd520f09636ee&q=3D1&e=3Da6b7f23a-98d4-=
4084-af0a-a88af0b4c9d0&u=3Dhttps%3A%2F%2Flkml.org%2Flkml%2F2021%2F1%2F15%2F=
609).=0D=0A>Greg=C2=A0also=C2=A0stated=C2=A0that=C2=A0procfs=C2=A0is=C2=A0a=
=C2=A0bad=C2=A0place=C2=A0for=C2=A0storing=C2=A0reports:=0D=0A>https://prot=
ect2.fireeye.com/v1/url?k=3D924a3ffc-cdd106e6-924bb4b3-0cc47a6cba04-882467c=
bf9e8b46f&q=3D1&e=3Da6b7f23a-98d4-4084-af0a-a88af0b4c9d0&u=3Dhttps%3A%2F%2F=
lkml.org%2Flkml%2F2021%2F1%2F15%2F929.=0D=0A>=C2=A0=0D=0A>Maninder,=C2=A0wh=
ich=C2=A0exactly=C2=A0problem=C2=A0are=C2=A0you=C2=A0trying=C2=A0to=C2=A0so=
lve?=0D=0A=C2=A0=0D=0A=C2=A0=0D=0AWe=C2=A0focussed=C2=A0on=C2=A02=C2=A0prob=
lems,=C2=A01=C2=A0is=C2=A0to=C2=A0remove=C2=A0duplicate=C2=A0error=C2=A0rep=
orting=0D=0Afrom=C2=A0KASAN=C2=A0when=C2=A0multishot=C2=A0is=C2=A0ON=0D=0A=
=C2=A0=0D=0Aand=C2=A0second=C2=A0was=C2=A0to=C2=A0save=C2=A0KASAN=C2=A0meta=
data=C2=A0(minimal)=C2=A0to=C2=A0regenerate=C2=A0same=C2=A0KASAN=C2=A0warni=
ngs=0D=0Awhen=C2=A0user=C2=A0reads=C2=A0new=C2=A0proc=C2=A0interface.=0D=0A=
=C2=A0=0D=0A>Note=C2=A0that=C2=A0KASAN=C2=A0already=C2=A0triggers=C2=A0a=C2=
=A0trace_error_report_end=C2=A0tracepoint=0D=0A>on=C2=A0every=C2=A0error=C2=
=A0report:=0D=0A>https://protect2.fireeye.com/v1/url?k=3D2d128c9c-7289b586-=
2d1307d3-0cc47a6cba04-3e939a06aa0346db&q=3D1&e=3Da6b7f23a-98d4-4084-af0a-a8=
8af0b4c9d0&u=3Dhttps%3A%2F%2Felixir.bootlin.com%2Flinux%2Fv5.12-rc8%2Fsourc=
e%2Fmm%2Fkasan%2Freport.c%23L90=0D=0A>Would=C2=A0it=C2=A0help=C2=A0if=C2=A0=
you=C2=A0used=C2=A0that=C2=A0one?=C2=A0It=C2=A0could=C2=A0probably=C2=A0be=
=C2=A0extended=C2=A0with=0D=0A>more=C2=A0parameters.=0D=0A>=C2=A0=0D=0A>Ano=
ther=C2=A0option=C2=A0if=C2=A0you=C2=A0want=C2=A0verbatim=C2=A0reports=C2=
=A0is=C2=A0to=C2=A0use=C2=A0the=C2=A0console=0D=0A>tracepoints,=C2=A0as=C2=
=A0this=C2=A0is=C2=A0done=C2=A0in=0D=0A>https://protect2.fireeye.com/v1/url=
?k=3D5f368dc2-00adb4d8-5f37068d-0cc47a6cba04-fe4efc4f73dbea2f&q=3D1&e=3Da6b=
7f23a-98d4-4084-af0a-a88af0b4c9d0&u=3Dhttps%3A%2F%2Felixir.bootlin.com%2Fli=
nux%2Fv5.12-rc8%2Fsource%2Fmm%2Fkfence%2Fkfence_test.c=0D=0A>Note=C2=A0that=
=C2=A0there=C2=A0are=C2=A0many=C2=A0caveats=C2=A0with=C2=A0error=C2=A0repor=
t=C2=A0collection=C2=A0(see=C2=A0the=0D=0A>links=C2=A0above),=C2=A0but=C2=
=A0for=C2=A0testing=C2=A0purpose=C2=A0it=C2=A0might=C2=A0be=C2=A0enough.=0D=
=0A>=C2=A0=0D=0A=C2=A0=0D=0AOk=C2=A0We=C2=A0will=C2=A0check=C2=A0these=C2=
=A0tracing=C2=A0methods=C2=A0also.=0D=0A=C2=A0=0D=0AThanks=0D=0AManinder=20=
Singh
