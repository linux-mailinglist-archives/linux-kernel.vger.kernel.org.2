Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 270B83B9436
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 17:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233870AbhGAPoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 11:44:24 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:39909 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233478AbhGAPoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 11:44:23 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210701154150epoutp027ead1da1d0ce86904217a9693dac399c~NtQ2zGKVN3153031530epoutp02h
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 15:41:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210701154150epoutp027ead1da1d0ce86904217a9693dac399c~NtQ2zGKVN3153031530epoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1625154111;
        bh=2U2E8u41WugbOJ0EL/2uoi63WJGsKQwSDcXTdvOZrvQ=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=gc4kEKrpwIAXyS12lArNmghPjJgz4O1amaN/AG2pwE/PwqAvSUHdxWblrRx35V68u
         fe99N33P8+DHrg5D8QHXhKkoK40xBHIQ047VP5LJwkGONGcYylWk4DZnb/ChIS/6Wr
         SkkOPysmLQJ159uJ+FdG9BFu7I+83yU+uPNmj1pQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20210701154150epcas1p4bd34b6d04a6f41b33e80951795ff258c~NtQ2F-jec2365323653epcas1p4q;
        Thu,  1 Jul 2021 15:41:50 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.163]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4GG2Wc0TLqz4x9Pt; Thu,  1 Jul
        2021 15:41:48 +0000 (GMT)
X-AuditID: b6c32a35-447ff700000026e0-74-60dde23b4530
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        6E.13.09952.B32EDD06; Fri,  2 Jul 2021 00:41:47 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH] mm: sparse: pass section_nr to section_mark_present
Reply-To: ohoono.kwon@samsung.com
Sender: =?UTF-8?B?6raM7Jik7ZuI?= <ohoono.kwon@samsung.com>
From:   =?UTF-8?B?6raM7Jik7ZuI?= <ohoono.kwon@samsung.com>
To:     David Hildenbrand <david@redhat.com>,
        =?UTF-8?B?6raM7Jik7ZuI?= <ohoono.kwon@samsung.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mhocko@suse.com" <mhocko@suse.com>
CC:     "bhe@redhat.com" <bhe@redhat.com>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "ohkwon1043@gmail.com" <ohkwon1043@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <c5f8e6ae-9d2c-24a6-c21a-6c6c83912b35@redhat.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20210701154146epcms1p4398db5708796ae291b09db29240e5ed1@epcms1p4>
Date:   Fri, 02 Jul 2021 00:41:46 +0900
X-CMS-MailID: 20210701154146epcms1p4398db5708796ae291b09db29240e5ed1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHJsWRmVeSWpSXmKPExsWy7bCmnq71o7sJBjevmlrMWb+GzeL8g19s
        Fl/X/2K2uLxrDpvFvTX/WS3u9zlY7N3va7Hr5wpmixtTGtgcOD12zrrL7rHp0yR2jxMzfrN4
        TFh0gNHj/b6rbB59W1YxeqzfcpXF4/MmuQCOqBybjNTElNQihdS85PyUzLx0WyXv4HjneFMz
        A0NdQ0sLcyWFvMTcVFslF58AXbfMHKDrlBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkF
        KTkFhgYFesWJucWleel6yfm5VoYGBkamQJUJORmNzZ2sBbdzKj5N38rSwPg0s4uRk0NCwETi
        +4xvrF2MXBxCAjsYJR5PnszYxcjBwSsgKPF3hzBIjbCAh8SamfNZQcJCAooS2067QYStJKb1
        /WMCsdkELCSer/0JNkZEYB+jxK1JB9hBEswC7xklLiwShdjFKzGj/SkLhC0tsX35VkYQm1PA
        TmLSjd1QcVGJm6vfssPY74/NZ4SwRSRa751lhrAFJR783A0Vl5S42XaXBWSxhEA/o8T9dS1Q
        zgRGiSVPJrFBVJlLPNvQwg7xmK/Eqw45EJNFQFVizu1UiAoXiQ1TGlggbtaWWLbwNTNICbOA
        psT6XfoQJYoSO3/PZYQo4ZN497WHFeatHfOeMIGUSwBNXPbbA+bDvumXofZ7SPQtuAYN5ZOM
        Euc3bmWfwKgwCxHQs5AsnoWweAEj8ypGsdSC4tz01GLDAkPkuN3ECE6oWqY7GCe+/aB3iJGJ
        g/EQowQHs5II74TpdxOEeFMSK6tSi/Lji0pzUosPMZoCfTyRWUo0OR+Y0vNK4g1NjYyNjS1M
        zMzNTI2VxHl3sh1KEBJITyxJzU5NLUgtgulj4uCUamDa6TPxisNSh6WWWxnOCZ0v7wk8eUXQ
        3X5hzWudpOtXnNycFI6Hr5jOvebzgg6pkgPzdW5v/XrSuLvAOnWRsoxkzmWl5w4RYs9X7w8s
        Oza/8X9F9cYtTx9P0dqhF1m2/uKE+HaOGy373B6tOH/I5OLbXxan2v5FfRGsj11meuNygdRN
        I/O8/q9/O1onmvRvlNjVXbZk92WDR2eNl+Q2ZUzxS3pW3eR24sxO2Zl/i2b6rkkulBAPemp+
        dIH90jClgsg83tAO1XW6+TK7CvVPphzW2/Gl53nywb+vtp3edjIl3XNJ09TS54tb/zJ/Wslt
        +/Tnu7SrZXw5GfUnHh7Wa7T6YPa7dMWVk18CuB+2sT/TVmIpzkg01GIuKk4EALAdYhUxBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210701135543epcms1p84a043bf49757bafada0a773372611d69
References: <c5f8e6ae-9d2c-24a6-c21a-6c6c83912b35@redhat.com>
        <20210701135543epcms1p84a043bf49757bafada0a773372611d69@epcms1p8>
        <CGME20210701135543epcms1p84a043bf49757bafada0a773372611d69@epcms1p4>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 01, 2021 at 04:34:13PM +0200, David Hildenbrand wrote:
> On 01.07.21 15:55, =EA=B6=8C=EC=98=A4=ED=9B=88=20wrote:=0D=0A>=20>=20With=
=20CONFIG_SPARSEMEM_EXTREME=20enabled,=20__section_nr()=20which=20converts=
=0D=0A>=20>=20mem_section=20to=20section_nr=20could=20be=20costly=20since=
=20it=20iterates=20all=0D=0A>=20>=20sections=20to=20check=20if=20the=20give=
n=20mem_section=20is=20in=20its=20range.=0D=0A>=20=20=0D=0A>=20It=20actuall=
y=20iterates=20all=20section=20roots.=0D=0A>=20=20=0D=0A>=20>=20=0D=0A>=20>=
=20On=20the=20other=20hand,=20__nr_to_section=20which=20converts=20section_=
nr=20to=0D=0A>=20>=20mem_section=20can=20be=20done=20in=20O(1).=0D=0A>=20>=
=20=0D=0A>=20>=20Let's=20pass=20section_nr=20instead=20of=20mem_section=20p=
tr=20to=20section_mark_present=0D=0A>=20>=20in=20order=20to=20reduce=20need=
less=20iterations.=0D=0A>=20=20=0D=0A>=20I'd=20expect=20this=20to=20be=20mo=
stly=20noise,=20especially=20as=20we=20iterate=20section=20=0D=0A>=20roots=
=20and=20for=20most=20(smallish)=20machines=20we=20might=20just=20work=20on=
=20the=20lowest=20=0D=0A>=20section=20roots=20only.=0D=0A>=20=20=0D=0A>=20C=
an=20you=20actually=20observe=20an=20improvement=20regarding=20boot=20times=
?=0D=0A>=20=20=0D=0A>=20Anyhow,=20looks=20straight=20forward=20to=20me,=20a=
lthough=20we=20might=20just=20reintroduce=20=0D=0A>=20similar=20patterns=20=
again=20easily=20if=20it's=20really=20just=20noise=20(see=20=0D=0A>=20find_=
memory_block()=20as=20used=20by).=20And=20it=20might=20allow=20for=20a=20ni=
ce=20cleanup=20=0D=0A>=20(see=20below).=0D=0A>=20=20=0D=0A>=20Reviewed-by:=
=20David=20Hildenbrand=20<david=40redhat.com>=0D=0A>=20=20=0D=0A>=20=20=0D=
=0A>=20Can=20you=20send=201)=20a=20patch=20to=20convert=20find_memory_block=
()=20as=20well=20and=202)=20a=20=0D=0A>=20patch=20to=20rip=20out=20__sectio=
n_nr()=20completely?=0D=0A>=20=20=0D=0A>=20>=20=0D=0A>=20>=20Signed-off-by:=
=20Ohhoon=20Kwon=20<ohoono.kwon=40samsung.com>=0D=0A>=20>=20---=0D=0A>=20>=
=20=20=20mm/sparse.c=20=7C=209=20+++++----=0D=0A>=20>=20=20=201=20file=20ch=
anged,=205=20insertions(+),=204=20deletions(-)=0D=0A>=20>=20=0D=0A>=20>=20d=
iff=20--git=20a/mm/sparse.c=20b/mm/sparse.c=0D=0A>=20>=20index=2055c18aff3e=
42..4a2700e9a65f=20100644=0D=0A>=20>=20---=20a/mm/sparse.c=0D=0A>=20>=20+++=
=20b/mm/sparse.c=0D=0A>=20>=20=40=40=20-186,13=20+186,14=20=40=40=20void=20=
__meminit=20mminit_validate_memmodel_limits(unsigned=20long=20*start_pfn,=
=0D=0A>=20>=20=20=20=20*=20those=20loops=20early.=0D=0A>=20>=20=20=20=20*/=
=0D=0A>=20>=20=20=20unsigned=20long=20__highest_present_section_nr;=0D=0A>=
=20>=20-static=20void=20section_mark_present(struct=20mem_section=20*ms)=0D=
=0A>=20>=20+static=20void=20section_mark_present(unsigned=20long=20section_=
nr)=0D=0A>=20>=20=20=20=7B=0D=0A>=20>=20-=20=20=20=20=20=20=20=20unsigned=
=20long=20section_nr=20=3D=20__section_nr(ms);=0D=0A>=20>=20+=20=20=20=20=
=20=20=20=20struct=20mem_section=20*ms;=0D=0A>=20>=20=20=20=0D=0A>=20>=20=
=20=20=20=20=20=20=20=20=20=20if=20(section_nr=20>=20__highest_present_sect=
ion_nr)=0D=0A>=20>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
__highest_present_section_nr=20=3D=20section_nr;=0D=0A>=20>=20=20=20=0D=0A>=
=20>=20+=20=20=20=20=20=20=20=20ms=20=3D=20__nr_to_section(section_nr);=0D=
=0A>=20>=20=20=20=20=20=20=20=20=20=20=20ms->section_mem_map=20=7C=3D=20SEC=
TION_MARKED_PRESENT;=0D=0A>=20>=20=20=20=7D=0D=0A>=20>=20=20=20=0D=0A>=20>=
=20=40=40=20-279,7=20+280,7=20=40=40=20static=20void=20__init=20memory_pres=
ent(int=20nid,=20unsigned=20long=20start,=20unsigned=20long=20en=0D=0A>=20>=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20if=20(=21ms->secti=
on_mem_map)=20=7B=0D=0A>=20>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20ms->section_mem_map=20=3D=20sparse_enco=
de_early_nid(nid)=20=7C=0D=0A>=20>=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20SECTION_IS_O=
NLINE;=0D=0A>=20>=20-=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20section_mark_present(ms);=0D=0A>=20>=20+=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20section_mark_prese=
nt(section);=0D=0A>=20>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=7D=0D=0A>=20>=20=20=20=20=20=20=20=20=20=20=20=7D=0D=0A>=20>=20=20=
=20=7D=0D=0A>=20>=20=40=40=20-933,7=20+934,7=20=40=40=20int=20__meminit=20s=
parse_add_section(int=20nid,=20unsigned=20long=20start_pfn,=0D=0A>=20>=20=
=20=20=0D=0A>=20>=20=20=20=20=20=20=20=20=20=20=20ms=20=3D=20__nr_to_sectio=
n(section_nr);=0D=0A>=20>=20=20=20=20=20=20=20=20=20=20=20set_section_nid(s=
ection_nr,=20nid);=0D=0A>=20>=20-=20=20=20=20=20=20=20=20section_mark_prese=
nt(ms);=0D=0A>=20>=20+=20=20=20=20=20=20=20=20section_mark_present(section_=
nr);=0D=0A>=20>=20=20=20=0D=0A>=20>=20=20=20=20=20=20=20=20=20=20=20/*=20Al=
ign=20memmap=20to=20section=20boundary=20in=20the=20subsection=20case=20*/=
=0D=0A>=20>=20=20=20=20=20=20=20=20=20=20=20if=20(section_nr_to_pfn(section=
_nr)=20=21=3D=20start_pfn)=0D=0A>=20>=20=0D=0A>=20=20=0D=0A>=20=20=0D=0A>=
=20--=20=0D=0A>=20Thanks,=0D=0A>=20=20=0D=0A>=20David=20/=20dhildenb=0D=0A>=
=20=20=0D=0ADear=20David.=0D=0A=0D=0AI=20tried=20to=20check=20on=20time=20f=
or=20memblocks_present,=20but=20when=20I=20tested=20with=20mobile=0D=0Aphon=
es=20with=208GB=20ram,=20the=20original=20binary=20took=200us=20either=20as=
=20well=20as=20the=0D=0Apatched=20binary.=0D=0AI'm=20not=20sure=20how=20the=
=20results=20would=20differ=20on=20huge=20systems=20with=20bigger=20ram.=0D=
=0AI=20agree=20that=20it=20could=20turn=20out=20to=20be=20just=20a=20noise,=
=20as=20you=20expected.=0D=0A=0D=0AHowever=20as=20you=20also=20mentioned,=
=20the=20patches=20will=20be=20straight=20forward=20when=20all=0D=0Acodes=
=20using=20__section_nr()=20are=20cleaned=20up=20nicely.=0D=0A=0D=0ABelow=
=20are=20the=20two=20patches=20that=20you=20asked=20for.=0D=0APlease=20tell=
=20me=20if=20you=20need=20me=20to=20send=20the=20patches=20in=20separate=20=
e-mails.=0D=0A=0D=0AThanks,=0D=0AOhhoon=20Kwon.=0D=0A=0D=0A>=20Can=20you=20=
send=201)=20a=20patch=20to=20convert=20find_memory_block()=20as=20well=20an=
d=202)=20a=20=0D=0A>=20patch=20to=20rip=20out=20__section_nr()=20completely=
?=0D=0A=0D=0A=0D=0A--------------------------------------------------------=
---------------------------------=0D=0A=0D=0A=0D=0A=5BPATCH=5D=20mm:=20spar=
se:=20pass=20section_nr=20to=20find_memory_block=0D=0A=0D=0AWith=20CONFIG_S=
PARSEMEM_EXTREME=20enabled,=20__section_nr()=20which=20converts=0D=0Amem_se=
ction=20to=20section_nr=20could=20be=20costly=20since=20it=20iterates=20all=
=0D=0Asections=20to=20check=20if=20the=20given=20mem_section=20is=20in=20it=
s=20range.=0D=0A=0D=0AOn=20the=20other=20hand,=20__nr_to_section=20which=20=
converts=20section_nr=20to=0D=0Amem_section=20can=20be=20done=20in=20O(1).=
=0D=0A=0D=0ALet's=20pass=20section_nr=20instead=20of=20mem_section=20ptr=20=
to=20find_memory_block=0D=0Ain=20order=20to=20reduce=20needless=20iteration=
s.=0D=0A=0D=0ASigned-off-by:=20Ohhoon=20Kwon=20<ohoono.kwon=40samsung.com>=
=0D=0A---=0D=0A=20arch/powerpc/platforms/pseries/hotplug-memory.c=20=7C=204=
=20+---=0D=0A=20drivers/base/memory.c=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=7C=204=20++--=0D=0A=20include=
/linux/memory.h=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=7C=202=20+-=0D=0A=203=20files=20changed,=204=20insertion=
s(+),=206=20deletions(-)=0D=0A=0D=0Adiff=20--git=20a/arch/powerpc/platforms=
/pseries/hotplug-memory.c=20b/arch/powerpc/platforms/pseries/hotplug-memory=
.c=0D=0Aindex=208377f1f7c78e..905790092e0e=20100644=0D=0A---=20a/arch/power=
pc/platforms/pseries/hotplug-memory.c=0D=0A+++=20b/arch/powerpc/platforms/p=
series/hotplug-memory.c=0D=0A=40=40=20-211,13=20+211,11=20=40=40=20static=
=20int=20update_lmb_associativity_index(struct=20drmem_lmb=20*lmb)=0D=0A=20=
static=20struct=20memory_block=20*lmb_to_memblock(struct=20drmem_lmb=20*lmb=
)=0D=0A=20=7B=0D=0A=20=09unsigned=20long=20section_nr;=0D=0A-=09struct=20me=
m_section=20*mem_sect;=0D=0A=20=09struct=20memory_block=20*mem_block;=0D=0A=
=20=0D=0A=20=09section_nr=20=3D=20pfn_to_section_nr(PFN_DOWN(lmb->base_addr=
));=0D=0A-=09mem_sect=20=3D=20__nr_to_section(section_nr);=0D=0A=20=0D=0A-=
=09mem_block=20=3D=20find_memory_block(mem_sect);=0D=0A+=09mem_block=20=3D=
=20find_memory_block(section_nr);=0D=0A=20=09return=20mem_block;=0D=0A=20=
=7D=0D=0A=20=0D=0Adiff=20--git=20a/drivers/base/memory.c=20b/drivers/base/m=
emory.c=0D=0Aindex=20d5ffaab3cb61..e31598955cc4=20100644=0D=0A---=20a/drive=
rs/base/memory.c=0D=0A+++=20b/drivers/base/memory.c=0D=0A=40=40=20-578,9=20=
+578,9=20=40=40=20static=20struct=20memory_block=20*find_memory_block_by_id=
(unsigned=20long=20block_id)=0D=0A=20/*=0D=0A=20=20*=20Called=20under=20dev=
ice_hotplug_lock.=0D=0A=20=20*/=0D=0A-struct=20memory_block=20*find_memory_=
block(struct=20mem_section=20*section)=0D=0A+struct=20memory_block=20*find_=
memory_block(unsigned=20long=20section_nr)=0D=0A=20=7B=0D=0A-=09unsigned=20=
long=20block_id=20=3D=20memory_block_id(__section_nr(section));=0D=0A+=09un=
signed=20long=20block_id=20=3D=20memory_block_id(section_nr);=0D=0A=20=0D=
=0A=20=09return=20find_memory_block_by_id(block_id);=0D=0A=20=7D=0D=0Adiff=
=20--git=20a/include/linux/memory.h=20b/include/linux/memory.h=0D=0Aindex=
=2097e92e8b556a..d9a0b61cd432=20100644=0D=0A---=20a/include/linux/memory.h=
=0D=0A+++=20b/include/linux/memory.h=0D=0A=40=40=20-90,7=20+90,7=20=40=40=
=20int=20create_memory_block_devices(unsigned=20long=20start,=20unsigned=20=
long=20size,=0D=0A=20void=20remove_memory_block_devices(unsigned=20long=20s=
tart,=20unsigned=20long=20size);=0D=0A=20extern=20void=20memory_dev_init(vo=
id);=0D=0A=20extern=20int=20memory_notify(unsigned=20long=20val,=20void=20*=
v);=0D=0A-extern=20struct=20memory_block=20*find_memory_block(struct=20mem_=
section=20*);=0D=0A+extern=20struct=20memory_block=20*find_memory_block(uns=
igned=20long=20section_nr);=0D=0A=20typedef=20int=20(*walk_memory_blocks_fu=
nc_t)(struct=20memory_block=20*,=20void=20*);=0D=0A=20extern=20int=20walk_m=
emory_blocks(unsigned=20long=20start,=20unsigned=20long=20size,=0D=0A=20=09=
=09=09=20=20=20=20=20=20void=20*arg,=20walk_memory_blocks_func_t=20func);=
=0D=0A--=20=0D=0A2.17.1=0D=0A=0D=0A=0D=0A----------------------------------=
-------------------------------------------------------=0D=0A=0D=0A=0D=0A=
=5BPATCH=5D=20mm:=20sparse:=20remove=20__section_nr()=20function=0D=0A=0D=
=0A__section_nr()=20was=20used=20to=20convert=20struct=20mem_section=20*=20=
to=20section_nr.=0D=0A=0D=0AWith=20CONFIG_SPARSEMEM_EXTREME=20enabled,=20ho=
wever,=20__section_nr()=20can=20be=0D=0Acostly=20since=20it=20iterates=20al=
l=20section=20roots=20to=20check=20if=20the=20given=0D=0Amem_section=20is=
=20in=20its=20range.=0D=0A=0D=0AOn=20the=20other=20hand,=20__nr_to_section=
=20which=20converts=20section_nr=20to=0D=0Amem_section=20can=20be=20done=20=
in=20O(1).=0D=0A=0D=0AThe=20only=20users=20of=20__section_nr()=20was=20sect=
ion_mark_present=20and=0D=0Afind_memory_block.=20Now=20since=20I=20changed=
=20both=20functions=20to=20use=20section_nr=0D=0Adirectly,=20let's=20remove=
=20__section_nr()=20since=20it=20has=20no=20users.=0D=0A=0D=0ASigned-off-by=
:=20Ohhoon=20Kwon=20<ohoono.kwon=40samsung.com>=0D=0A---=0D=0A=20include/li=
nux/mmzone.h=20=7C=20=201=20-=0D=0A=20mm/sparse.c=20=20=20=20=20=20=20=20=
=20=20=20=20=7C=2026=20--------------------------=0D=0A=202=20files=20chang=
ed,=2027=20deletions(-)=0D=0A=0D=0Adiff=20--git=20a/include/linux/mmzone.h=
=20b/include/linux/mmzone.h=0D=0Aindex=200d53eba1c383..8931f95cf885=2010064=
4=0D=0A---=20a/include/linux/mmzone.h=0D=0A+++=20b/include/linux/mmzone.h=
=0D=0A=40=40=20-1321,7=20+1321,6=20=40=40=20static=20inline=20struct=20mem_=
section=20*__nr_to_section(unsigned=20long=20nr)=0D=0A=20=09=09return=20NUL=
L;=0D=0A=20=09return=20&mem_section=5BSECTION_NR_TO_ROOT(nr)=5D=5Bnr=20&=20=
SECTION_ROOT_MASK=5D;=0D=0A=20=7D=0D=0A-extern=20unsigned=20long=20__sectio=
n_nr(struct=20mem_section=20*ms);=0D=0A=20extern=20size_t=20mem_section_usa=
ge_size(void);=0D=0A=20=0D=0A=20/*=0D=0Adiff=20--git=20a/mm/sparse.c=20b/mm=
/sparse.c=0D=0Aindex=204a2700e9a65f..1b32d15593e4=20100644=0D=0A---=20a/mm/=
sparse.c=0D=0A+++=20b/mm/sparse.c=0D=0A=40=40=20-108,32=20+108,6=20=40=40=
=20static=20inline=20int=20sparse_index_init(unsigned=20long=20section_nr,=
=20int=20nid)=0D=0A=20=7D=0D=0A=20=23endif=0D=0A=20=0D=0A-=23ifdef=20CONFIG=
_SPARSEMEM_EXTREME=0D=0A-unsigned=20long=20__section_nr(struct=20mem_sectio=
n=20*ms)=0D=0A-=7B=0D=0A-=09unsigned=20long=20root_nr;=0D=0A-=09struct=20me=
m_section=20*root=20=3D=20NULL;=0D=0A-=0D=0A-=09for=20(root_nr=20=3D=200;=
=20root_nr=20<=20NR_SECTION_ROOTS;=20root_nr++)=20=7B=0D=0A-=09=09root=20=
=3D=20__nr_to_section(root_nr=20*=20SECTIONS_PER_ROOT);=0D=0A-=09=09if=20(=
=21root)=0D=0A-=09=09=09continue;=0D=0A-=0D=0A-=09=09if=20((ms=20>=3D=20roo=
t)=20&&=20(ms=20<=20(root=20+=20SECTIONS_PER_ROOT)))=0D=0A-=09=09=20=20=20=
=20=20break;=0D=0A-=09=7D=0D=0A-=0D=0A-=09VM_BUG_ON(=21root);=0D=0A-=0D=0A-=
=09return=20(root_nr=20*=20SECTIONS_PER_ROOT)=20+=20(ms=20-=20root);=0D=0A-=
=7D=0D=0A-=23else=0D=0A-unsigned=20long=20__section_nr(struct=20mem_section=
=20*ms)=0D=0A-=7B=0D=0A-=09return=20(unsigned=20long)(ms=20-=20mem_section=
=5B0=5D);=0D=0A-=7D=0D=0A-=23endif=0D=0A-=0D=0A=20/*=0D=0A=20=20*=20During=
=20early=20boot,=20before=20section_mem_map=20is=20used=20for=20an=20actual=
=0D=0A=20=20*=20mem_map,=20we=20use=20section_mem_map=20to=20store=20the=20=
section's=20NUMA=0D=0A--=20=0D=0A2.17.1=0D=0A
