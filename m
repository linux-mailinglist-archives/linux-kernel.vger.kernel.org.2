Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D71EF32300D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 18:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233776AbhBWR4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 12:56:24 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:46514 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233148AbhBWR4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 12:56:09 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11NHrvQL070451;
        Tue, 23 Feb 2021 17:54:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=etpcwjD0BTMmQ+6E11FlEsw23Md0adL7kYyFnQ6BUjY=;
 b=fttzfHQvmU1kscBruM4nPL7HO3rZQMY5HkxKzTjV13fkVAF0Ar8G85g1dtyXGrS7jr/k
 kaWDxKnfbO1hmfNbf6UVrN3aEW2SmE2kVHsJGT/0W1r7ph5l3G2QaAX7lvCZ2NzLiuLa
 Nqq5f0D8dys77gGMrF8owZntYbFRxXAq8tow6msXXmuCDDTijilsaac0xmndM2y62Y0c
 Obft2QGrLVRDj9aHd9Plbg7q7laKh99ny4MmyWmjcbq2zt1nLtUX21Xj59vHl1glL1ko
 ivwtouT0S7AECIEegPZ7PVGwISq/nkOgyg66zI8PuUQUQGAN4jjP18RSjiZqglPUn2Gh IA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 36ttcm89jg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Feb 2021 17:54:43 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11NHoRhb146666;
        Tue, 23 Feb 2021 17:54:42 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by aserp3030.oracle.com with ESMTP id 36v9m4wrsv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Feb 2021 17:54:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IYJqvHCo94V99uc+pu1FaLq8i3aufFyCSSEqtWZgjBPBKpCzx9/QpvWwVE3uSpGpo202MAszeC9+w0vSohRjCCoCAgbyhxRZgr/tnhhrDw3qrKtKWYrG5KTmZaxNkti8I0dh3LE6MS6KBl4zgGP7pKyQAGtCDHY07sUthMJb5VwLGd2POAuAdBUI34NGPf6f1PT1JxdK3o7xAW398Rz0a9+dp9wSYYG2FbMrldCxfZzZEraZzrjuud65Qgz0U7YJGpa8CWVPtoRTeNVexHqrkdlkSvj18fN4EDllwJhtgraJecZ1SEQFqAfd489oh3IHCTbfbs8CVNlEDVT/ueh62A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=etpcwjD0BTMmQ+6E11FlEsw23Md0adL7kYyFnQ6BUjY=;
 b=QBEWLMZuQMSnCgs9sXRqyR7+V55MzqhpY/+J2UzR4btn8TBCUiTzv3k09mqFerTUHzqbmLkW8agH0pRtG0zPlidUcGqZKzqUQs3Rl9Htt06Doc1/851s/rky11yI96FCXBJRJUOmlLMR3PbeFAcDg+d6gIu1PniKzegnKtgP4MTnU4Ip0HLJCOtm/bJPFInmUAb/LSkG5cXYIfh8S/skEWWcT+QMp3Xpas+7rTdZIo/TvENfaeypiTJTpeknTQcy1W1mefSTIR8i9p/R5T4mU8Uf0lGkAsXU+EvZupel7rc49KFJ/sFCJDl0ATKYvkjGdZ/0eXxALsCdoWr9h8n0uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=etpcwjD0BTMmQ+6E11FlEsw23Md0adL7kYyFnQ6BUjY=;
 b=m7YobEJycPezwbQAU7j/MaLPpSt78XIHRRZ/NAD3vlXToUTO1jKAnFJp+2J9uLNUTGG6TakA3sAQC982Zb14ALdU9647xBUrl+9QUAf8rTIO72mTo9OeoCcwXX9gTvl9rrhULPBXeYOqU7SzpBPxO3wE4CzMN5ofhkat/XI/cHs=
Received: from BN8PR10MB3571.namprd10.prod.outlook.com (2603:10b6:408:ad::23)
 by BN6PR10MB1636.namprd10.prod.outlook.com (2603:10b6:405:6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31; Tue, 23 Feb
 2021 17:54:39 +0000
Received: from BN8PR10MB3571.namprd10.prod.outlook.com
 ([fe80::6d3a:d67:bd69:3d43]) by BN8PR10MB3571.namprd10.prod.outlook.com
 ([fe80::6d3a:d67:bd69:3d43%7]) with mapi id 15.20.3868.033; Tue, 23 Feb 2021
 17:54:39 +0000
From:   Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
To:     Baoquan He <bhe@redhat.com>, Kairui Song <kasong@redhat.com>
CC:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Ingo Molnar <mingo@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        John Donnelly <john.p.donnelly@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        kexec mailing list <kexec@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH v3 1/1] kernel/crash_core: Add crashkernel=auto for vmcore
 creation
Thread-Topic: [PATCH v3 1/1] kernel/crash_core: Add crashkernel=auto for
 vmcore creation
Thread-Index: AQHXAKDx99DSVPZnmE6mqOBmmu0RtKpdMteAgAiDIgCAACAGgIAAQqcA
Date:   Tue, 23 Feb 2021 17:54:39 +0000
Message-ID: <277127DD-9294-46D7-B05D-15275EF1B93B@oracle.com>
References: <20210211180814.69708-1-saeed.mirzamohammadi@oracle.com>
 <20210218020203.GC2871@MiWiFi-R3L-srv>
 <CACPcB9d7-kJR7OG2OrLcAhFhiMO26PB82Uv9bK9FkCfH__zWZQ@mail.gmail.com>
 <20210223135605.GA3553@MiWiFi-R3L-srv>
In-Reply-To: <20210223135605.GA3553@MiWiFi-R3L-srv>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [136.52.113.136]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f86a7304-f23d-4bd8-561c-08d8d824175c
x-ms-traffictypediagnostic: BN6PR10MB1636:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR10MB16365BC4D7D2E6E34E729FC5F1809@BN6PR10MB1636.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DFiET14sCTYu7QLtJ1+s5bkBA/6ZLslO5qRti0acZ38S/9bufxhWai6Yo32W2nhSWn/Dfa3azmy7I3ztnyZ04SZwpwNjbGQAswbQ66dzgVSFMKyYQhDf+FcKhfoEnaEk/qG48e1bZ0IQjUiapTTQwhiobNBGn1GjlKcLIbS33pHLrhFl00if2HWNvP4W11fgXQc3FDIYVWwyzcM893L0IAkkXOsPCjJsXwbZ3+fLxApnA9xeLpDdTyvRCIdoTQPUnqzInlZC22x8tA2//zVWgwyn0ApO6BH2T00vQ9TPrfbcKNWXelAJox9kTdPFsjsxLS2UcZ3ku1A8UVkbGtywKlag/8GWfKwkt7UxEnK7RgbQAGjONFEGa61HgLCGoFwCaXyh7fNax/cRvlr9LK8VXegBYYCQe5NyTyxeY2Blk6IVSKHYzR4IwlPZf18qwZLmV7AyotI1qizB1mFT8GWbYaHjjimmUqPo7t4EAc9M+cZdS5VFvFLIbKOMMiLj2AjCshp8Dw7FPNP5LU1pUGfDj6cWfs0FJ9EpSwB6iRIB3L4luv7YOeflTHidyPuj3uClGduyDrrXM/MEUoWl/9TWwGAQRHxf1G8nptlIJVpXLmK5WVmnre2Ba2bSJTxXaJsdqBmw8uXb3LBacNg3YfEzCHelMPtueVPp2xU52cIlqEg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3571.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(136003)(346002)(396003)(366004)(66556008)(64756008)(66476007)(4326008)(33656002)(110136005)(6486002)(44832011)(6512007)(86362001)(71200400001)(2616005)(478600001)(54906003)(26005)(107886003)(66446008)(76116006)(186003)(5660300002)(966005)(66946007)(316002)(53546011)(36756003)(2906002)(8676002)(8936002)(83380400001)(6506007)(7416002)(91956017)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?5hCZtgtoaxs+932C0DiDtR3vs+nYFPUN4psooIjs4VEVC2954KY4d8BdV+hP?=
 =?us-ascii?Q?yCtzgFUpzsteSv3RIwNUVRcSJCCx9gmipDsCjcfrt8IUUbbstKCMcHUPSo79?=
 =?us-ascii?Q?nOrWWgzkAo7UaY9PXCirOaG9iziknRLDZslQcWXzJyDMZZzrNldf5jKAS/Mj?=
 =?us-ascii?Q?aLCUdyiegR2dnLA+gIEv5LxHkEUTZ7jvNddKC0plEJZw+8dLcumGew8lmb7o?=
 =?us-ascii?Q?Dz+TCj2l9Detu4HNurhT/Rvw5YIVKPi0J+Kr6oxnTM1W3aukJjMtTykjDTv6?=
 =?us-ascii?Q?X+1hRwYmNo/vx9nu2PQ19cp+8s8GjCwRrdhwwOSEnEAs0gG9QHirr9p4NjFI?=
 =?us-ascii?Q?JeWacmO/EqYp1tEQr4b09GYK943eJMs8GsZdxeddKGYMbJEnBAogJqRDhAw8?=
 =?us-ascii?Q?jfCQ09A1UEe2RY7Hc56ODaaq/kJ/d95Vy7MxahzDADcjVShZJL92ep84+o3T?=
 =?us-ascii?Q?NV3aQa2bSDPqAkDK1f89asa+x4nDDBymXhalYD2LdKmg/hP8a8Hkrbewd9+S?=
 =?us-ascii?Q?GTlvqO8cojOxFev6bC6Ap/LyTV+0sXAHV/SHPHBHdV5EsOUD7CNmjI5Zu7At?=
 =?us-ascii?Q?vo+KRyGxvroumPhGNWduwN3uqmiOqWYxJ24widRtoQsOPlQsUyMWrv2c2PHG?=
 =?us-ascii?Q?yvHCOUROGu3aGFuQCLRlK61OraFc9z632EO2ObdJfBBs12XV78oZIqS55aH5?=
 =?us-ascii?Q?H0baqlIOhBoNH7IUEJIPyLpxAO7jVpoRuqwhXRC01OgrIgsJ3l5odX2MNk1X?=
 =?us-ascii?Q?ARJ/5KkDZsf6/K4xFkiUiU0lTUKx7S6OhVv86eANOPIDgzaR19CvLWnjqwpC?=
 =?us-ascii?Q?DxfMmSeLSKZTIYiMW+xucWJQAJjUKejP0U8LDiJdAOxv7Mx6JQjsoqJViRRR?=
 =?us-ascii?Q?1w9Q9cu1vqQ4D7RmcMeIUH6ixqIVqCe13hDhh0vPWEZazjBRGnDLBZz0ZmvO?=
 =?us-ascii?Q?zetZVM51qvg7v4ZQ6LTUzVPj8p51AdV8AzD3EsPGsJD0TG0u0YfKzKuVOpfF?=
 =?us-ascii?Q?FSkJjFa3CkUgs1LbTRj1zfkcKVOZmedaiHzZmXmDALwOZA4jai0qiepwstW5?=
 =?us-ascii?Q?iD4QYMHxnem9vahySuzfwbT+R0hKxpQjtwwNhyjiIHdTiIBvO9VMZ2m1mNY9?=
 =?us-ascii?Q?XGU/rrz6ouFiuuoHIuWjb3yTQDRdZiGUahkCXxQyOPwypkh02E6p5BZV07BV?=
 =?us-ascii?Q?laEgje82ApZWBZtvHhCbcUTIrsNWUaxpFRfOIZSozFL1Buasq3CYjD6klWl3?=
 =?us-ascii?Q?Zl+xcHJVG8DO1sFM4Du+pSWTxOcIUCO8G8K/Tj0DYG+8ptXQYuZifjW6HONR?=
 =?us-ascii?Q?Z7nSw/1D3LAQs9NXAKW7FS/a?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7D34A01A774BA7459C32BD985212D743@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3571.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f86a7304-f23d-4bd8-561c-08d8d824175c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2021 17:54:39.1776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VybAPeuee5ioXRzrJvL3+BNkrEOeiveT6Gxko6KWJdH/GNJIiBpjPJZcy8JtY2aA4mhuOyeSqt62esX+ivREmO2l1EjzahcXlY9D8GnO9cQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1636
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9904 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102230150
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9904 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102230150
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 23, 2021, at 5:56 AM, Baoquan He <bhe@redhat.com> wrote:
>=20
> On 02/23/21 at 08:01pm, Kairui Song wrote:
>> On Thu, Feb 18, 2021 at 10:03 AM Baoquan He <bhe@redhat.com> wrote:
>>>=20
>>> On 02/11/21 at 10:08am, Saeed Mirzamohammadi wrote:
> ...
>>>> diff --git a/arch/Kconfig b/arch/Kconfig
>>>> index af14a567b493..f87c88ffa2f8 100644
>>>> --- a/arch/Kconfig
>>>> +++ b/arch/Kconfig
>>>> @@ -14,6 +14,30 @@ menu "General architecture-dependent options"
>>>> config CRASH_CORE
>>>>      bool
>>>>=20
>>>> +if CRASH_CORE
>>>> +
>>>> +config CRASH_AUTO_STR
>>>> +     string "Memory reserved for crash kernel"
>>>> +     depends on CRASH_CORE
>>>> +     default "1G-64G:128M,64G-1T:256M,1T-:512M"
>>>> +     help
>>>> +       This configures the reserved memory dependent
>>>> +       on the value of System RAM. The syntax is:
>>>> +       crashkernel=3D<range1>:<size1>[,<range2>:<size2>,...][@offset]
>>>> +                   range=3Dstart-[end]
>>>> +
>>>> +       For example:
>>>> +           crashkernel=3D512M-2G:64M,2G-:128M
>>>> +
>>>> +       This would mean:
>>>> +
>>>> +           1) if the RAM is smaller than 512M, then don't reserve any=
thing
>>>> +              (this is the "rescue" case)
>>>> +           2) if the RAM size is between 512M and 2G (exclusive), the=
n reserve 64M
>>>> +           3) if the RAM size is larger than 2G, then reserve 128M
>>>> +
>>>> +endif # CRASH_CORE
>>>=20
>>> Wondering if this CRASH_CORE ifdeffery is a little redundent here
>>> since CRASH_CORE dependency has been added. Except of this, I like this
>>> patch. As we discussed in private threads, we can try to push it into
>>> mainline and continue improving later.
>>>=20
>>=20
>> I believe "if CRASH_CORE" is not needed as it already "depends on
>> CRASH_CORE", tested with CRASH_CORE=3Dy or 'not set', it just works.
>=20
> Thanks for testing and confirmation, Kairui.
>=20
> Saeed, can you post a v4 with CRASH_CORE ifdeffery removed? Maybe this
> week?

Thanks Kairui and Baoquan for testing and review. I just sent the v4. Hope =
we move forward and apply this week.

Saeed

>=20
> Thanks
> Baoquan
>=20
>>=20
>>>> +
>>>> config KEXEC_CORE
>>>>      select CRASH_CORE
>>>>      bool
>>>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>>>> index 106e4500fd53..ab0a2b4b1ffa 100644
>>>> --- a/kernel/crash_core.c
>>>> +++ b/kernel/crash_core.c
>>>> @@ -7,6 +7,7 @@
>>>> #include <linux/crash_core.h>
>>>> #include <linux/utsname.h>
>>>> #include <linux/vmalloc.h>
>>>> +#include <linux/kexec.h>
>>>>=20
>>>> #include <asm/page.h>
>>>> #include <asm/sections.h>
>>>> @@ -250,6 +251,12 @@ static int __init __parse_crashkernel(char *cmdli=
ne,
>>>>      if (suffix)
>>>>              return parse_crashkernel_suffix(ck_cmdline, crash_size,
>>>>                              suffix);
>>>> +#ifdef CONFIG_CRASH_AUTO_STR
>>>> +     if (strncmp(ck_cmdline, "auto", 4) =3D=3D 0) {
>>>> +             ck_cmdline =3D CONFIG_CRASH_AUTO_STR;
>>>> +             pr_info("Using crashkernel=3Dauto, the size chosen is a =
best effort estimation.\n");
>>>> +     }
>>>> +#endif
>>>>      /*
>>>>       * if the commandline contains a ':', then that's the extended
>>>>       * syntax -- if not, it must be the classic syntax
>>>> --
>>>> 2.27.0
>>>>=20
>>>=20
>>>=20
>>> _______________________________________________
>>> kexec mailing list
>>> kexec@lists.infradead.org
>>> https://urldefense.com/v3/__http://lists.infradead.org/mailman/listinfo=
/kexec__;!!GqivPVa7Brio!MaBAPZr-j_WcNPodmosfVOyl0ipO6u22Ex-7gSi--wlwbmTgmkh=
sf-0yftioew3jnkS5WV5v$=20
>>>=20
>>=20
>>=20
>> --=20
>> Best Regards,
>> Kairui Song
>>=20
>=20

