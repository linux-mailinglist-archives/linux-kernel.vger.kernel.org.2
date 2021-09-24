Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 832C3417686
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 16:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346705AbhIXOGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 10:06:20 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:36396 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346508AbhIXOGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 10:06:20 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210924140445epoutp04ed424ad388daac11640bd4134516f46f~nxxWMsm7Z3152931529epoutp041
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 14:04:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210924140445epoutp04ed424ad388daac11640bd4134516f46f~nxxWMsm7Z3152931529epoutp041
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1632492285;
        bh=q/PUuhuvYBUXBqIqSskeFpdKmkneorz9MDlFxCuImqU=;
        h=Date:Subject:Reply-To:From:To:CC:In-Reply-To:References:From;
        b=QlVH4m/4YFpGIYAvYTAOVyAFMg3vHWsOHxIYQUXp969/07cNd7/VbSds65VEQGRKb
         QSjzOnfeCdlEclNPFeJ5d7/eSFZe2yZVGCZgQuS9qDp9basJ074eP3auIY5BnjqaRT
         HF5NPBqA6+mrMHv+8/3/Lq6esFrG9jBtr5JRV0Uw=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20210924140444epcas5p2a8f5e46bb991371c26cf32969c3f8947~nxxVZPM5t0443904439epcas5p26;
        Fri, 24 Sep 2021 14:04:44 +0000 (GMT)
X-AuditID: b6c32a49-10fff7000000e972-8a-614ddafc70c4
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        53.13.59762.CFADD416; Fri, 24 Sep 2021 23:04:44 +0900 (KST)
Date:   Fri, 24 Sep 2021 19:34:43 +0530
Message-ID: <1062227969.4242453.1632492283698@mail-kr5-0>
Mime-Version: 1.0
Subject: RE:(2) [Issue] timer callback registered with mod_timer is getting
 called beforetime
Reply-To: maninder1.s@samsung.com
Sender: Maninder Singh <maninder1.s@samsung.com>
From:   Maninder Singh <maninder1.s@samsung.com>
To:     Frederic Weisbecker <frederic@kernel.org>
CC:     "fweisbec@gmail.com" <fweisbec@gmail.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vaneet Narang <v.narang@samsung.com>,
        AMIT SAHRAWAT <a.sahrawat@samsung.com>,
        Chung-Ki Woo <chungki0201.woo@samsung.com>,
        Vishal Goel <vishal.goel@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20210924103812.GA142770@lothringen>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
X-CMS-MailID: 20210924140443epcms5p22d9d28335c2d6988b509e01ee4cc2f51
Content-Type: multipart/mixed;
        boundary="----=_Part_4242452_2101301166.1632492283698"
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLKsWRmVeSWpSXmKPExsWy7bCmhu6fW76JBo3XRC0u7k61OP39CrvF
        gqa9rBYzX3czWVzeNYfNYvW/U4wWmzdNZbY4dHIuo8W626cZHTg9ds66y+6xaVUnm8e7c+fY
        Pfq2rGL0+LxJLoA1issmJTUnsyy1SN8ugStjWsNy9oJbShWPT15ka2C8ItfFyMkhIWAi8eHy
        LaYuRi4OIYHdjBJ73q9nAkmwCKhK9P/sBrN5BSwlnvy/zdLFyAFkC0r83SEMYgoLxEtc+h0F
        UiEkoChxYcYaRoiwgcSvrRogYTYBPYlVu/awgNgiAroSy69tYAfZxCzwnEli+vlNrBAn8ErM
        aH/KAmFLS2xfvpURxOYUMJRYMeEYVI2oxM3Vb9lh7PfH5jNC2CISrffOMkPYghIPfu6GistI
        rN7cywKyTEKgm1Fi/bu9UM4MRomeR9OgOswl1i9ZxQ5ytYSAi8SfPguQMLNAuMT6rmesEDaf
        RO/vJ0wwh+6YB2OrSrTc3MAKc/Tnjx+hHvCQ2PK9lR0SnnsYJWac38w2gVFuFiLoZiFZAWHL
        S2x/O4cZpIRZQFNi/S59iLCaxJT+L2wQtplEQ/tUFghbUWJK90P2BYzsqxglUwuKc9NTi00L
        DPNSy/WKE3OLS/PS9ZLzczcxglOVlucOxrsPPugdYmTiYDzEqALU/mjD6guMUix5+XmpSiK8
        n294JQrxpiRWVqUW5ccXleakFh9ilOZgURLn/fjaMlFIID2xJDU7NbUgtQgmy8TBKdXA1Bhy
        kr9+SfTdsotvp62e8vKJK1PdgrTyTkuByXfSzyo2fYusuHZFa7K6ksZ99fJ7LOYs5S7vqpN8
        77zp7WNccyz42+T7r+Xnzt69/2OWWKSeMI+st+H7NXFy7AHNsb/0Vi2o85RYG3nO6Jruid7S
        dtmy/t51U9j2p93YGmE7N1/4vc78pQd1lSzS09yTzOOCMq9OOF/sOGXWLDd9d64la9KLVl/0
        FmCfcErIz/9qz9btN86mlN2ujU25LSsXmbbBdf/qHW8f6hz0Ff1de4TBiWGtQYO+lvsGuXCP
        bfyr2rdy+fyZJxy41+u6qFDm3mPaM31KUy/22Jp+6hf44JG5qdWkaMKBKNtX2tEaLreVWIoz
        Eg21mIuKEwEKuGfc0AMAAA==
X-CMS-RootMailID: 20210924065310epcms5p69dd47a510faaa6bf68c243e02f2d0186
References: <20210924103812.GA142770@lothringen>
        <20210924065310epcms5p69dd47a510faaa6bf68c243e02f2d0186@epcms5p6>
        <CGME20210924065310epcms5p69dd47a510faaa6bf68c243e02f2d0186@epcms5p2>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_4242452_2101301166.1632492283698
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"


Hi Frederic,


> > Is it known behaviour for timers?
> > because only 1 CPU is assigned to update jiffies work to call do_timer utill unless it goes to idle state and pass ownership to other CPU.
> > 
> > we tried by making all CPU to handle code for jiffies updation (it will add performance hit)
> > but then no issue of abrupt jiffies change occured on system.
>  
> First of all, are you meeting this issue specifically on NOHZ_FULL? Because
> there is a pending fix for a related matter there:

No, this is not our case.

>  
>       https://lore.kernel.org/lkml/20210915142303.24297-1-frederic@kernel.org/
>  
> As for what you're reporting here, I think the core problem is the fact that the
> timekeeper (jiffies updater) is stuck with IRQs disabled for way too long. Even
> one millisecond is too much to tolerate. Do you have any idea about the source of
> that situation?
>  

Yes, definately interrupts should not be disabled for so long,
but sometimes there are 3rd party drivers/vendors module code can cause issue,
and it can be the same case and we are trying to reproduce issue again and check code path.

So we had 2 doubts:
(1) In this explained case timer callback will be called early right? 
(2) What if jiffies updation can be done by any of the CPU rather that making one
CPU owner? can it cause any side effectes? one we know is performance, there will be redundant calls
from other CPUs.

        /* Check, if the jiffies need an update */
        if (tick_do_timer_cpu == cpu)
                tick_do_update_jiffies64(now);


On our target, there is a race condition when irq_disable code path scheduled on same CPU
which is responsible for jiffies updation and in parallel CPU1 registers evet callback for 20/30 ms.
and due to abrupt jiffies change callback triggered within 1 ms of actual time, which cause actual
issue.

Thanks
Maninder Singh
 
 
------=_Part_4242452_2101301166.1632492283698
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="rcptInfo.txt"
Content-Transfer-Encoding: base64

DQogICA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT0NCiAgICAgIFN1YmplY3QgICAgOiBSZTogW0lzc3VlXSB0aW1l
ciBjYWxsYmFjayByZWdpc3RlcmVkIHdpdGggbW9kX3RpbWVyIGlzIGdldHRpbmcgY2FsbGVkIGJl
Zm9yZXRpbWUNCiAgICAgIEZyb20gICAgICAgOiBudWxsDQogICAgICBTZW50IERhdGUgIDogMjAy
MS0wOS0yNCAxNjowOCAgR01UKzU6MzANCiAgID09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KICAgICAgICAgICAg
ICAgICAgTmFtZSAgICAgICAgICAgICAgICBUeXBlICAgICAgICAgIEpvYiBUaXRsZSAgICAgICAg
ICAgICAgICAgICAgICAgRGVwdC4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQ29tcGFu
eSAgICAgICAgICAgICAgICANCiAgID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KICAgICAgTWFuaW5kZXIgU2lu
Z2ggICAgICAgICAgICAgICAgIFRPICAgICAgICAgU3RhZmYgRW5naW5lZXIgICAgICAgICAgICAg
U3lzdGVtIFMvVyBHcm91cCAvU1JJLURlbGhpICAgICAgICAgICAgICAgU2Ftc3VuZ8KgRWxlY3Ry
b25pY3PCoA0KICAgICAgZndlaXNiZWNAZ21haWwuY29tICAgICAgICAgICAgIENDDQogICAgICB0
Z2x4QGxpbnV0cm9uaXguZGUgICAgICAgICAgICAgQ0MNCiAgICAgIG1pbmdvQGtlcm5lbC5vcmcg
ICAgICAgICAgICAgICBDQw0KICAgICAgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZyAgIEND
DQogICAgICBWYW5lZXQgTmFyYW5nICAgICAgICAgICAgICAgICAgQ0MgICAgICAgICBTdGFmZiBF
bmdpbmVlciAgICAgICAgICAgICBTeXN0ZW0gUy9XIEdyb3VwIC9TUkktRGVsaGkgICAgICAgICAg
ICAgICBTYW1zdW5nIEVsZWN0cm9uaWNzDQogICAgICBBTUlUIFNBSFJBV0FUICAgICAgICAgICAg
ICAgICAgQ0MgICAgICAgICBTdGFmZiBFbmdpbmVlci9IZWFkIG8uLi4gICBTeXN0ZW0gUy9XIEdy
b3VwIC9TUkktRGVsaGkgICAgICAgICAgICAgICBTYW1zdW5nwqBFbGVjdHJvbmljcw0KICAgICAg
Q2h1bmctS2kgV29vICAgICAgICAgICAgICAgICAgIENDICAgICAgICAgUHJpbmNpcGFsIEVuZ2lu
ZWVyICAgICAgICAgUy9XIFBsYXRmb3JtIFImRCBMYWIuICAgICAgICAgICAgICAgICAgICAgU2Ft
c3VuZyBFbGVjdHJvbmljcw0KICAgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo=

------=_Part_4242452_2101301166.1632492283698--
