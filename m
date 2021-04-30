Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4D936F836
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 11:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbhD3J4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 05:56:15 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:16575 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhD3J4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 05:56:14 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210430095524epoutp018628394d64cdbdd7dd9f408a23343dec~6mirUJy9g1011010110epoutp01D
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 09:55:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210430095524epoutp018628394d64cdbdd7dd9f408a23343dec~6mirUJy9g1011010110epoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1619776524;
        bh=gmKvS5TifIGVW/3+aVfJX/p//lGXqtywtz6SAyT62nk=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=hQYTF5vHNDsodcIID9YuUXEMg1/dIQ0e16R9867tHkExptfJjjJwhjmJRBo+PGiLt
         7Z5RlUtOOYL7YUIA55HEj4HgU/suB+NpW/BL9mjX3Qqxl9FLT9TRb1VFdMB31TwaAg
         kZY1Dv5jtcdLTtVudQTz3Bdk4OWgnYJDjOjQc0iE=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20210430095524epcas5p44f3cc997f2fefd401f1fbc8673f3f889~6miq28yBo2787027870epcas5p4v;
        Fri, 30 Apr 2021 09:55:24 +0000 (GMT)
X-AuditID: b6c32a4b-7c9ff7000000266b-65-608bd40c1e80
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4B.F1.09835.C04DB806; Fri, 30 Apr 2021 18:55:24 +0900 (KST)
Mime-Version: 1.0
Subject: RE:[PATCH 1/2] mm/kasan: avoid duplicate KASAN issues from
 reporting
Reply-To: maninder1.s@samsung.com
Sender: Maninder Singh <maninder1.s@samsung.com>
From:   Maninder Singh <maninder1.s@samsung.com>
To:     Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>
CC:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        AMIT SAHRAWAT <a.sahrawat@samsung.com>,
        Vaneet Narang <v.narang@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20210430095350epcms5p12b7d36494bbdfc17d795796697f0a649@epcms5p1>
Date:   Fri, 30 Apr 2021 15:23:50 +0530
X-CMS-MailID: 20210430095350epcms5p12b7d36494bbdfc17d795796697f0a649
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsWy7bCmli7Ple4Eg1ln2S0u7k61mLN+DZvF
        94nT2S0mPGxjt2g7s53Vov3jXmaLFc/uM1lc3jWHzeLemv+sFse3bmG2OHRyLqMDt8fOWXfZ
        PRZsKvXYM/Ekm8emT5PYPU7M+M3i0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBnbv/1lKuiV
        rmjcwd7AuFGqi5GTQ0LARKLp6FxmEFtIYDejxPrPtl2MHBy8AoISf3cIg4SFBfwlni7bwg5R
        oihxYcYaRpASYQEDiV9bNUDCbAJ6Eqt27WEBsUUEvCVWHjsIVMLFwSzwh0mibUonG8QqXokZ
        7U9ZIGxpie3LtzJC2KISN1e/ZYex3x+bDxUXkWi9d5YZwhaUePBzN1RcRmL15l4WkAUSAt2M
        Eo9/NEM1z2GU+LHEB8I2l9i9YR4LxC++EtcvWYGEWQRUJbatmgl1j4vEoobpYDazgLbEsoWv
        mUHKmQU0Jdbv0ocokZWYemodE0QJn0Tv7ydMMK/smAdjq0q03NzACvPW548foV70kFjx+zDY
        SCGBQIlla2smMMrPQoTtLCR7ZyHsXcDIvIpRMrWgODc9tdi0wDgvtVyvODG3uDQvXS85P3cT
        Izj9aHnvYHz04IPeIUYmDsZDjBIczEoivL/XdSYI8aYkVlalFuXHF5XmpBYfYpTmYFES5xV0
        rk4QEkhPLEnNTk0tSC2CyTJxcEo1MJ2PCr0n5+ReJ9Lx4ZvofrPt02epZWu5lJ61Pt/OUnWp
        YG9ulP6BGes2KFo0fK2Zm+69Z8bDdA/Z+KnKiiVvdqevNFnWMOGvwMMypXcKCsx9qm9nFaQ9
        8tf+c9RmooiK1rYNuSJMkwo0i/aJ9jyb9nf6gzM/jMIZLuvdPfnzxec/xfvty3x43mp31uoo
        3JjYqtMcoFGy4MztSh9+i92fOtT+L9/lsOfv9+51wUuu3du2yebTthMN5osPtiQk9elWRAXo
        3ZkieXHapgSOplAeobS6dNEUm2yzlvprE/NPNIa78Z+85DGheM3d/qWast46axzv/dZQXP9x
        jrjKNSfBxdaqJ1f5JRULFCRo2HC9V2Ipzkg01GIuKk4EAH+jHQ6uAwAA
X-CMS-RootMailID: 20210422081531epcas5p23d6c72ebf28a23b2efc150d581319ffa
References: <CGME20210422081531epcas5p23d6c72ebf28a23b2efc150d581319ffa@epcms5p1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
=C2=A0=0D=0A>=0D=0A>=C2=A0>=C2=A0On=C2=A0Thu,=C2=A022=C2=A0Apr=C2=A02021=C2=
=A0at=C2=A011:17,=C2=A0Maninder=C2=A0Singh=C2=A0<maninder1.s=40samsung.com>=
=C2=A0wrote:=0D=0A>=C2=A0>=C2=A0>=0D=0A>=C2=A0>=C2=A0>=C2=A0when=C2=A0KASAN=
=C2=A0multishot=C2=A0is=C2=A0ON=C2=A0and=C2=A0some=C2=A0buggy=C2=A0code=C2=
=A0hits=C2=A0same=C2=A0code=C2=A0path=0D=0A>=C2=A0>=C2=A0>=C2=A0of=C2=A0KAS=
AN=C2=A0issue=C2=A0repetetively,=C2=A0it=C2=A0can=C2=A0flood=C2=A0logs=C2=
=A0on=C2=A0console.=0D=0A>=C2=A0>=C2=A0>=0D=0A>=C2=A0>=C2=A0>=C2=A0Check=C2=
=A0for=C2=A0allocaton,=C2=A0free=C2=A0and=C2=A0backtrace=C2=A0path=C2=A0at=
=C2=A0time=C2=A0of=C2=A0KASAN=C2=A0error,=0D=0A>=C2=A0>=C2=A0>=C2=A0if=C2=
=A0these=C2=A0are=C2=A0same=C2=A0then=C2=A0it=C2=A0is=C2=A0duplicate=C2=A0e=
rror=C2=A0and=C2=A0avoid=C2=A0these=C2=A0prints=0D=0A>=C2=A0>=C2=A0>=C2=A0f=
rom=C2=A0KASAN.=0D=0A>=C2=A0>=0D=0A>=C2=A0>=C2=A0On=C2=A0a=C2=A0more=C2=A0f=
undamental=C2=A0level,=C2=A0I=C2=A0think=C2=A0this=C2=A0sort=C2=A0of=C2=A0f=
iltering=C2=A0is=C2=A0the=0D=0A>=C2=A0>=C2=A0wrong=C2=A0solution=C2=A0to=C2=
=A0your=C2=A0problem.=C2=A0One=C2=A0reason=C2=A0why=C2=A0it's=C2=A0good=C2=
=A0that=0D=0A>=C2=A0>=C2=A0multishot=C2=A0is=C2=A0off=C2=A0by=C2=A0default=
=C2=A0is,=C2=A0because=C2=A0_every_=C2=A0KASAN=C2=A0report=C2=A0is=0D=0A>=
=C2=A0>=C2=A0critical=C2=A0and=C2=A0can=C2=A0destabilize=C2=A0the=C2=A0syst=
em.=C2=A0Therefore,=C2=A0any=C2=A0report=C2=A0after=0D=0A>=C2=A0>=C2=A0the=
=C2=A0first=C2=A0one=C2=A0might=C2=A0be=C2=A0completely=C2=A0bogus,=C2=A0be=
cause=C2=A0the=C2=A0system=C2=A0is=C2=A0in=C2=A0a=0D=0A>=C2=A0>=C2=A0potent=
ially=C2=A0bad=C2=A0state=C2=A0and=C2=A0its=C2=A0behaviour=C2=A0might=C2=A0=
be=C2=A0completely=C2=A0random.=0D=0A=C2=A0=0D=0AYes=C2=A0it's=C2=A0valid=
=C2=A0point=C2=A0,=C2=A0But=C2=A0in=C2=A0Some=C2=A0scenarios=C2=A0testing=
=C2=A0in=C2=A0production=C2=A0take=C2=A0time=C2=A0and=0D=0Awaiting=C2=A0for=
=C2=A0one=C2=A0issue=C2=A0fix=C2=A0takes=C2=A0time=C2=A0as=C2=A0there=C2=A0=
are=C2=A0multiple=C2=A0stakeholders=0D=0Ain=C2=A0modules.=C2=A0So=C2=A0we=
=C2=A0thought=C2=A0it=C2=A0was=C2=A0better=C2=A0to=C2=A0catch=C2=A0multiple=
=C2=A0issues=C2=A0in=C2=A0one=C2=A0long=C2=A0run.=0D=0A=C2=A0=0D=0A=C2=A0=
=0D=0A>=C2=A0>=C2=A0The=C2=A0correct=C2=A0solution=C2=A0is=C2=A0to=C2=A0not=
=C2=A0leave=C2=A0the=C2=A0system=C2=A0running,=C2=A0fix=C2=A0the=C2=A0first=
=0D=0A>=C2=A0>=C2=A0bug=C2=A0found,=C2=A0continue;=C2=A0rinse=C2=A0and=C2=
=A0repeat.=C2=A0Therefore,=C2=A0this=C2=A0patch=C2=A0adds=C2=A0a=0D=0A>=C2=
=A0>=C2=A0lot=C2=A0of=C2=A0code=C2=A0for=C2=A0little=C2=A0benefit.=0D=0A>=
=C2=A0=C2=A0=0D=0A>=C2=A0I=C2=A0agree=C2=A0with=C2=A0Marco=C2=A0here.=0D=0A=
>=C2=A0=C2=A0=0D=0A>=C2=A0It=C2=A0doesn't=C2=A0make=C2=A0sense=C2=A0to=C2=
=A0have=C2=A0this=C2=A0deduplication=C2=A0code=C2=A0in=C2=A0the=C2=A0kernel=
=0D=0A>=C2=A0anyway.=C2=A0If=C2=A0you=C2=A0want=C2=A0unique=C2=A0reports,=
=C2=A0write=C2=A0a=C2=A0userspace=C2=A0script=C2=A0that=0D=0A>=C2=A0parses=
=C2=A0dmesg=C2=A0and=C2=A0groups=C2=A0the=C2=A0reports.=0D=0A>=C2=A0=C2=A0=
=0D=0A=C2=A0=0D=0AYes=C2=A0agree,=C2=A0but=C2=A0issue=C2=A0is=C2=A0when=C2=
=A0multishot=C2=A0is=C2=A0ON,=C2=A0same=C2=A0KASAN=C2=A0error=0D=0Areports=
=C2=A0multiple=C2=A0time=C2=A0and=C2=A0can=C2=A0flood=C2=A0the=C2=A0serial=
=C2=A0logs.=0D=0Awhich=C2=A0can=C2=A0be=C2=A0avoided=C2=A0with=C2=A0patch=
=C2=A0=5B1/2=5D=0D=0A=C2=A0=0D=0AThanks,=0D=0AManinder=C2=A0Singh
