Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26FA036F832
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 11:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbhD3J4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 05:56:07 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:28571 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhD3J4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 05:56:06 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210430095517epoutp039e799349455b8cc7507fbd467f1528a8~6mikba-G62890928909epoutp03L
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 09:55:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210430095517epoutp039e799349455b8cc7507fbd467f1528a8~6mikba-G62890928909epoutp03L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1619776517;
        bh=fUivehtV9wCVFy2W9j9sM9jB8QKWOyfVzPxQFHzU67E=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=muRcI0VrEejdr7MfoFnQHN0UcZeRq7Vfq/0kuHUhBBoL50ox06/e8c6490ibOgLPn
         dhNSQCRXKRj3XX5OzRquapl/KxEnZkBQMIeWU1aUUfnrX7CzCWVyRIuGvlxgeocCW4
         6IpSN3b4lmlt7nROhoTLWMV8NmvuvtooYoQZAI88=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20210430095516epcas5p1012a62273f6134943e15153ab67ccb16~6mij3cG1L1593315933epcas5p1j;
        Fri, 30 Apr 2021 09:55:16 +0000 (GMT)
X-AuditID: b6c32a4b-7dfff7000000266b-4e-608bd4049782
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        01.D1.09835.404DB806; Fri, 30 Apr 2021 18:55:16 +0900 (KST)
Mime-Version: 1.0
Subject: RE:[PATCH 1/2] mm/kasan: avoid duplicate KASAN issues from
 reporting
Reply-To: maninder1.s@samsung.com
Sender: Maninder Singh <maninder1.s@samsung.com>
From:   Maninder Singh <maninder1.s@samsung.com>
To:     Dmitry Vyukov <dvyukov@google.com>
CC:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
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
Message-ID: <20210430095305epcms5p3b2bc2e22983b70ef82feeaa8bb08e04b@epcms5p3>
Date:   Fri, 30 Apr 2021 15:23:05 +0530
X-CMS-MailID: 20210430095305epcms5p3b2bc2e22983b70ef82feeaa8bb08e04b
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBKsWRmVeSWpSXmKPExsWy7bCmhi7Lle4Eg23PlS0u7k61mLN+DZvF
        94nT2S0mPGxjt2j/uJfZYsWz+0wWl3fNYbO4t+Y/q8XxrVuYLQ6dnMvowOWxc9Zddo8Fm0o9
        9kw8yeax6dMkdo8TM36zePRtWcXo8XmTXAB7FJdNSmpOZllqkb5dAlfGtLcZBeeyKs6t62Rt
        YHyT3sXIySEhYCKx+Mshti5GLg4hgd2MEid3PGLqYuTg4BUQlPi7QxikRljAX+Lpsi3sILaQ
        gKLEhRlrGEFKhAUMJH5t1QAJswnoSazatYcFxBYRUJNofN0DNpJZ4DWTxO22B+wQu3glZrQ/
        ZYGwpSW2L9/KCGGLStxc/ZYdxn5/bD5UXESi9d5ZZghbUOLBz91QcRmJ1Zt7WUAWSAh0M0o8
        /tEM1TyHUeLHEh8I21xi94Z5YMt4BXwlPk2cygZiswioSixa+4oVosZFYtWxI0wgNrOAtsSy
        ha+ZQR5jFtCUWL9LH6JEVmLqqXVQJXwSvb+fMMH8smMejK0q0XJzAyvMX58/foT60UNixe/D
        YCOFBAIl5vw1mMAoPwsRuLOQ7J2FsHcBI/MqRsnUguLc9NRi0wLjvNRyveLE3OLSvHS95Pzc
        TYzgxKPlvYPx0YMPeocYmTgYDzFKcDArifD+XteZIMSbklhZlVqUH19UmpNafIhRmoNFSZxX
        0Lk6QUggPbEkNTs1tSC1CCbLxMEp1cA0uaS8yfe/lwl719T9Aq69zxffLr3rxPed0VDtNcd0
        /wI7y21X393QdHott+Ts/CwTh9VOWfyCm4X7Z9zyfBG9nWXfLT+zPSskfWYsrfjx03bR1tCZ
        /WWcgZW+nUY1f9Yt0129XvXQw+StrfPM7PVdL4umzVM51mVbv9FVbgWr77aqu12fRJ9P9Vtw
        leuN6buwYq+1LxhUZ5d2LW7V+lcYqddpEnEmSmZFdIj38gl1t+1mdQfcUSt12fn4hkhy1rK/
        9YcaTk2fzcslNvcYpw1bo9RBZXaVv7OSTrO+sFvmWn+yvkDRY8nk5ODjqgfXvhG6+Kjv2pQw
        WYYuvdw99kqHDnscenHM5sfUr+fEddcosRRnJBpqMRcVJwIAuW77BqsDAAA=
X-CMS-RootMailID: 20210422081531epcas5p23d6c72ebf28a23b2efc150d581319ffa
References: <CGME20210422081531epcas5p23d6c72ebf28a23b2efc150d581319ffa@epcms5p3>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi=C2=A0Dmitry,=0D=0A=C2=A0=0D=0ASorry=C2=A0for=C2=A0late=C2=A0response.=0D=
=0A=C2=A0=0D=0A>=C2=A0---=C2=A0a/mm/kasan/kasan.h=0D=0A>=C2=A0+++=C2=A0b/mm=
/kasan/kasan.h=0D=0A>=C2=A0=40=40=C2=A0-102,6=C2=A0+102,12=C2=A0=40=40=C2=
=A0struct=C2=A0kasan_access_info=C2=A0=7B=0D=0A>=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned=C2=A0long=C2=A0ip;=0D=0A>=C2=A0=C2=A0=
=7D;=0D=0A>=0D=0A>>=C2=A0+struct=C2=A0kasan_record=C2=A0=7B=0D=0A>>=C2=A0+=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0depot_stack_handle_t=C2=A0=C2=A0=
=C2=A0=C2=A0bt_handle;=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0depot_stack_handle_t=C2=A0=C2=A0=C2=A0=C2=A0alloc_handle;=0D=0A>>=C2=
=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0depot_stack_handle_t=C2=A0=C2=
=A0=C2=A0=C2=A0free_handle;=0D=0A>>=C2=A0+=7D;=0D=0A>=C2=A0=0D=0A>Hi=C2=A0M=
aninder,=0D=0A>=C2=A0=0D=0A>There=C2=A0is=C2=A0no=C2=A0need=C2=A0to=C2=A0de=
clare=C2=A0this=C2=A0in=C2=A0the=C2=A0header,=C2=A0it=C2=A0can=C2=A0be=C2=
=A0declared=0D=0A>more=C2=A0locally=C2=A0in=C2=A0report.h.=0D=0A>=C2=A0=0D=
=0A=C2=A0=0D=0AActual=C2=A0we=C2=A0=C2=A0wanted=C2=A0to=C2=A0send=C2=A0both=
=C2=A0patches=C2=A0in=C2=A01=C2=A0patch,=C2=A0then=C2=A0we=C2=A0though=C2=
=A0=0D=0Ato=C2=A0break=C2=A0in=C2=A02=C2=A0ideas=C2=A0for=C2=A0better=C2=A0=
review,=C2=A0first=C2=A0one=C2=A0is=C2=A0to=C2=A0give=C2=A0idea=0D=0Aof=C2=
=A0remove=C2=A0duplicate=C2=A0KASAN=C2=A0errors=C2=A0and=C2=A0second=C2=A0i=
s=C2=A0to=C2=A0save=C2=A0KASAN=C2=A0metadata.=0D=0Aand=C2=A0structure=C2=A0=
was=C2=A0required=C2=A0in=C2=A0other=C2=A0files=C2=A0in=C2=A0second=C2=A0pa=
tch=C2=A0so=C2=A0it=C2=A0was=C2=A0=0D=0Adecalred=C2=A0in=C2=A0header=0D=0A=
=C2=A0=0D=0A>>=C2=A0+=0D=0A>>=C2=A0=C2=A0/*=C2=A0The=C2=A0layout=C2=A0of=C2=
=A0struct=C2=A0dictated=C2=A0by=C2=A0compiler=C2=A0*/=0D=0A>>=C2=A0=C2=A0st=
ruct=C2=A0kasan_source_location=C2=A0=7B=0D=0A>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0const=C2=A0char=C2=A0*filename;=0D=0A>>=C2=A0dif=
f=C2=A0--git=C2=A0a/mm/kasan/report.c=C2=A0b/mm/kasan/report.c=0D=0A>>=C2=
=A0index=C2=A087b271206163..4576de76991b=C2=A0100644=0D=0A>>=C2=A0---=C2=A0=
a/mm/kasan/report.c=0D=0A>>=C2=A0+++=C2=A0b/mm/kasan/report.c=0D=0A>>=C2=A0=
=40=40=C2=A0-39,6=C2=A0+39,10=C2=A0=40=40=C2=A0static=C2=A0unsigned=C2=A0lo=
ng=C2=A0kasan_flags;=0D=0A>>=C2=A0=C2=A0=23define=C2=A0KASAN_BIT_REPORTED=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00=0D=0A>>=C2=A0=C2=A0=23define=C2=A0KASAN_BIT=
_MULTI_SHOT=C2=A0=C2=A0=C2=A01=0D=0A>>=0D=0A>>=C2=A0+=23define=C2=A0MAX_REC=
ORDS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0(200)=0D=0A>=C2=A0=0D=0A>s/MAX_RECORDS/KASAN_MAX_RECORDS/=0D=0A=C2=A0=0D=
=0AOK=0D=0A=C2=A0=0D=0A>>=C2=A0+static=C2=A0struct=C2=A0kasan_record=C2=A0k=
asan_records=5BMAX_RECORDS=5D;=0D=0A>=C2=A0=0D=0A>Since=C2=A0all=C2=A0field=
s=C2=A0in=C2=A0kasan_record=C2=A0are=C2=A0stack=C2=A0handles,=C2=A0the=C2=
=A0code=C2=A0will=C2=A0be=0D=0A>simpler=C2=A0and=C2=A0more=C2=A0uniform,=C2=
=A0if=C2=A0we=C2=A0store=C2=A0just=C2=A0an=C2=A0array=C2=A0of=C2=A0handles=
=C2=A0w/o=0D=0A>distinguishing=C2=A0between=C2=A0alloc/free/access.=0D=0A=
=C2=A0=0D=0AOk=C2=A0got=C2=A0your=C2=A0point.=0D=0A=C2=A0=0D=0A>>=C2=A0+sta=
tic=C2=A0int=C2=A0stored_kasan_records;=0D=0A>>=C2=A0+=0D=0A>>=C2=A0=C2=A0b=
ool=C2=A0kasan_save_enable_multi_shot(void)=0D=0A>>=C2=A0=C2=A0=7B=0D=0A>>=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return=C2=A0test_and_=
set_bit(KASAN_BIT_MULTI_SHOT,=C2=A0&kasan_flags);=0D=0A>>=C2=A0=40=40=C2=A0=
-360,6=C2=A0+364,65=C2=A0=40=40=C2=A0void=C2=A0kasan_report_invalid_free(vo=
id=C2=A0*object,=C2=A0unsigned=C2=A0long=C2=A0ip)=0D=0A>>=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0end_report(&flags,=C2=A0(unsigned=C2=A0=
long)object);=0D=0A>>=C2=A0=C2=A0=7D=0D=0A>>=0D=0A>>=C2=A0+/*=0D=0A>>=C2=A0=
+=C2=A0*=C2=A0=40save_report()=0D=0A>>=C2=A0+=C2=A0*=0D=0A>>=C2=A0+=C2=A0*=
=C2=A0returns=C2=A0false=C2=A0if=C2=A0same=C2=A0record=C2=A0is=C2=A0already=
=C2=A0saved.=0D=0A>=C2=A0=0D=0A>s/same/the=C2=A0same/=0D=0A>=C2=A0=0D=0A>>=
=C2=A0+=C2=A0*=C2=A0returns=C2=A0true=C2=A0if=C2=A0its=C2=A0new=C2=A0record=
=C2=A0and=C2=A0saved=C2=A0in=C2=A0database=C2=A0of=C2=A0KASAN.=0D=0A>=C2=A0=
=0D=0A>s/its/it's/=0D=0A>s/database/the=C2=A0database/=0D=0A=C2=A0=0D=0Aok=
=0D=0A=C2=A0=0D=0A>>=C2=A0+static=C2=A0bool=C2=A0save_report(void=C2=A0*add=
r,=C2=A0struct=C2=A0kasan_access_info=C2=A0*info,=C2=A0u8=C2=A0tag,=C2=A0un=
signed=C2=A0long=C2=A0*flags)=0D=0A>>=C2=A0+=7B=0D=0A>>=C2=A0+=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct=C2=A0kasan_record=C2=A0record=C2=A0=3D=
=C2=A0=7B0=7D;=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0depo=
t_stack_handle_t=C2=A0bt_handle;=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0int=C2=A0i=C2=A0=3D=C2=A00;=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0const=C2=A0char=C2=A0*bug_type;=0D=0A>>=C2=A0+=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct=C2=A0kasan_alloc_meta=C2=A0*a=
lloc_meta;=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct=
=C2=A0kasan_track=C2=A0*free_track;=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0struct=C2=A0page=C2=A0*page;=0D=0A>>=C2=A0+=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool=C2=A0ret=C2=A0=3D=C2=A0true;=0D=0A>>=C2=
=A0+=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kasan_disable_=
current();=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0spin_loc=
k_irqsave(&report_lock,=C2=A0*flags);=0D=0A>=C2=A0=0D=0A>Reusing=C2=A0the=
=C2=A0caller=C2=A0flags=C2=A0looks=C2=A0strange,=C2=A0do=C2=A0we=C2=A0need=
=C2=A0it?=0D=0A>But=C2=A0also=C2=A0the=C2=A0very=C2=A0next=C2=A0function=C2=
=A0start_report()=C2=A0also=C2=A0does=C2=A0the=C2=A0same=0D=0A>dance:=C2=A0=
kasan_disable_current/spin_lock_irqsave.=C2=A0It=C2=A0feels=C2=A0reasonable=
=C2=A0to=0D=0A>lock=C2=A0once,=C2=A0check=C2=A0for=C2=A0dups=C2=A0and=C2=A0=
return=C2=A0early=C2=A0if=C2=A0it's=C2=A0a=C2=A0dup.=0D=0A=C2=A0=0D=0Aok,=
=C2=A0will=C2=A0check=C2=A0that=C2=A0(if=C2=A0only=C2=A0first=C2=A0patch=C2=
=A0seems=C2=A0to=C2=A0be=C2=A0good=C2=A0for=C2=A0mainline)=0D=0A=C2=A0=0D=
=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bug_type=C2=A0=3D=C2=
=A0kasan_get_bug_type(info);=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0page=C2=A0=3D=C2=A0kasan_addr_to_page(addr);=0D=0A>>=C2=A0+=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bt_handle=C2=A0=3D=C2=A0kasan_save_s=
tack(GFP_KERNEL);=0D=0A>=C2=A0=0D=0A=C2=A0=0D=0AOK=0D=0A>=C2=A0=0D=0A>>=C2=
=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if=C2=A0(page=C2=A0&&=C2=A0Pa=
geSlab(page))=C2=A0=7B=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct=C2=A0kmem_cach=
e=C2=A0*cache=C2=A0=3D=C2=A0page->slab_cache;=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
void=C2=A0*object=C2=A0=3D=C2=A0nearest_obj(cache,=C2=A0page,=C2=A0addr);=
=0D=0A>=C2=A0=0D=0A>Since=C2=A0you=C2=A0already=C2=A0declare=C2=A0new=C2=A0=
var=C2=A0in=C2=A0this=C2=A0block,=C2=A0move=0D=0A>alloc_meta/free_track=C2=
=A0here=C2=A0as=C2=A0well.=0D=0A=C2=A0=0D=0Aok=0D=0A=C2=A0=0D=0A>>=C2=A0+=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0alloc_meta=C2=A0=3D=C2=A0kasan_get_alloc_meta(cache,=C2=A0ob=
ject);=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0free_track=C2=A0=3D=C2=A0kasan_get_free=
_track(cache,=C2=A0object,=C2=A0tag);=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0record=
.alloc_handle=C2=A0=3D=C2=A0alloc_meta->alloc_track.stack;=0D=0A>>=C2=A0+=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0if=C2=A0(free_track)=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0record.free_handle=C2=A0=3D=C2=A0fre=
e_track->stack;=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=7D=
=0D=0A>>=C2=A0+=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rec=
ord.bt_handle=C2=A0=3D=C2=A0bt_handle;=0D=0A>>=C2=A0+=0D=0A>>=C2=A0+=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0for=C2=A0(i=C2=A0=3D=C2=A00;=C2=A0i=C2=
=A0<=C2=A0stored_kasan_records;=C2=A0i++)=C2=A0=7B=0D=0A>>=C2=A0+=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0if=C2=A0(record.bt_handle=C2=A0=21=3D=C2=A0kasan_records=5Bi=5D.bt_ha=
ndle)=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0continue;=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if=C2=A0(record.alloc_handl=
e=C2=A0=21=3D=C2=A0kasan_records=5Bi=5D.alloc_handle)=0D=0A>>=C2=A0+=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0continue;=0D=0A>>=
=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0if=C2=A0(=21strncmp(=22use-after-free=22,=C2=A0bug_=
type,=C2=A015)=C2=A0&&=0D=0A>=C2=A0=0D=0A>Comparing=C2=A0strings=C2=A0is=C2=
=A0unreliable=C2=A0and=C2=A0will=C2=A0break=C2=A0in=C2=A0future.=C2=A0Compa=
re=0D=0A>handle=C2=A0with=C2=A00=C2=A0instead,=C2=A0you=C2=A0already=C2=A0a=
ssume=C2=A0that=C2=A00=C2=A0handle=C2=A0is=C2=A0=22no=0D=0A>handle=22.=0D=
=0A=C2=A0=0D=0AOk=C2=A0will=C2=A0check=C2=A0that=C2=A0also=0D=0A=C2=A0=0D=
=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
(record.free_handle=C2=A0=21=3D=C2=A0kasan_records=5Bi=5D.free_handle))=0D=
=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
continue;=0D=0A>>=C2=A0+=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret=C2=A0=3D=C2=A0fal=
se;=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0goto=C2=A0done;=0D=0A>>=C2=A0+=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=7D=0D=0A>>=C2=A0+=0D=0A>>=C2=A0+=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0memcpy(&kasan_records=5Bstored_kasan_records=
=5D,=C2=A0&record,=C2=A0sizeof(struct=C2=A0kasan_record));=0D=0A>>=C2=A0+=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0stored_kasan_records++;=0D=0A>=C2=
=A0=0D=0A>I=C2=A0think=C2=A0you=C2=A0just=C2=A0introduced=C2=A0an=C2=A0out-=
of-bounds=C2=A0write=C2=A0into=C2=A0KASAN,=C2=A0check=0D=0A>for=C2=A0MAX_RE=
CORDS=C2=A0;)=0D=0A=C2=A0=0D=0A=C2=A0=0D=0A:),=C2=A0it=C2=A0was=C2=A0taken=
=C2=A0care=C2=A0in=C2=A0second=C2=A0patch=C2=A0=5B2/2=5D=0D=0A=C2=A0=0D=0A>=
=C2=A0=0D=0A>>=C2=A0+=0D=0A>>=C2=A0+done:=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0spin_unlock_irqrestore(&report_lock,=C2=A0*flags);=
=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kasan_enable_curre=
nt();=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return=C2=A0r=
et;=0D=0A>>=C2=A0+=7D=0D=0A>>=C2=A0+=0D=0A>>=C2=A0=C2=A0static=C2=A0void=C2=
=A0__kasan_report(unsigned=C2=A0long=C2=A0addr,=C2=A0size_t=C2=A0size,=C2=
=A0bool=C2=A0is_write,=0D=0A>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0unsigned=C2=A0long=C2=A0ip)=0D=0A>>=C2=A0=C2=A0=7B=0D=0A>>=C2=A0=40=40=
=C2=A0-388,6=C2=A0+451,10=C2=A0=40=40=C2=A0static=C2=A0void=C2=A0__kasan_re=
port(unsigned=C2=A0long=C2=A0addr,=C2=A0size_t=C2=A0size,=C2=A0bool=C2=A0is=
_write,=0D=0A>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0info.i=
s_write=C2=A0=3D=C2=A0is_write;=0D=0A>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0info.ip=C2=A0=3D=C2=A0ip;=0D=0A>>=0D=0A>>=C2=A0+=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if=C2=A0(addr_has_metadata(untagged_addr)=
=C2=A0&&=0D=0A>=C2=A0=0D=0A>Why=C2=A0addr_has_metadata=C2=A0check?=0D=0A>Th=
e=C2=A0kernel=C2=A0will=C2=A0probably=C2=A0crash=C2=A0later=C2=A0anyway,=C2=
=A0but=C2=A0from=C2=A0point=C2=A0of=C2=A0view=C2=A0of=0D=0A>this=C2=A0code,=
=C2=A0I=C2=A0don't=C2=A0see=C2=A0reasons=C2=A0to=C2=A0not=C2=A0dedup=C2=A0w=
ild=C2=A0accesses.=0D=0A=C2=A0=0D=0AJust=C2=A0to=C2=A0align=C2=A0with=C2=A0=
current=C2=A0code.=0D=0A=C2=A0=0D=0A=C2=A0=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=21=
save_report(untagged_addr,=C2=A0&info,=C2=A0get_tag(tagged_addr),=C2=A0&fla=
gs))=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return;=0D=0A>>=C2=A0+=0D=0A>>=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0start_report(&flags);=0D=0A>>=
=0D=0A>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0print_error_d=
escription(&info);=0D=0A>>=C2=A0--=0D=0A>>=C2=A02.17.1=0D=0A>>=0D=0A=C2=A0=
=0D=0AI=C2=A0will=C2=A0revert=C2=A0on=C2=A0other=C2=A0threads=C2=A0also=5B2=
/2=5D,=C2=A0and=C2=A0then=C2=A0please=C2=A0let=C2=A0me=C2=A0know=0D=0Aif=C2=
=A0only=C2=A0first=C2=A0patch=C2=A0can=C2=A0be=C2=A0good=C2=A0for=C2=A0main=
line=C2=A0=0D=0A=C2=A0=0D=0A=C2=A0=0D=0AThanks,=0D=0AManinder=C2=A0Singh=0D=
=0A=C2=A0
