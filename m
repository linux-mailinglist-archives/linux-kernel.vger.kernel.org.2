Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0837D3F7609
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 15:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241322AbhHYNlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 09:41:39 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:53280 "EHLO
        mx0a-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239203AbhHYNli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 09:41:38 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
        by mx0a-002c1b01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17P9UjNC004958;
        Wed, 25 Aug 2021 06:40:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=ZqOH3TJb/iYXsbNMB4mhnRRTbHkdGykmrz6jNRxOjQM=;
 b=oL5fTgklR5/ItCpihQ4s7Ymkql9lGDHyX0q2tHiz/SXcU/+43VbilzTxZX/BTzPAwsTS
 guOHi2i1Yhy1+r2bdWWZA7xqotQJYa3XOvym6X2GqNX3Y7sDUtOd6aKH9YYWDMtgtHrz
 nL0n/b3AkRHlLWjcZsMuFGbHZQZx9LcnF+5iQBJahqQXa8yEeT5jldpU8cfLUx/b8moy
 SbbWpqqwbjLlCdhM8T2rwodXX5RcVEqb27QINeODTTCjegjASbYwz5N8GYrpCWnjNH3O
 1uKU17oEOTIH7+MEVoDNiaU4hvRf83nZvDcJgKzpa67iL3D+M73q5gL2LYau302ckajY Cg== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by mx0a-002c1b01.pphosted.com with ESMTP id 3ank9vgevq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Aug 2021 06:40:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SJcA4MvuADEkVjCvCcTrIlr03DXI6J07nYEyU5AcpqkZBrVzrTnhQoMxUi/c3zHJ5XuzMRm+3q3mvZboMDW8IUwfEy8aeo/EPxZ1vAM852MQpiQY4jntAoLHoSqabkcYvlmmc9c6+iF5RaWZWNye7Vtkx7lqbBLIM4yW3/9FBO5Y9iURLD4fXhlEsKt1W1mPIdMVgeT8FXftyTZi0LQe+7CqR1cjkZEW8aWCtCOggFqOLIagmT4AqbAh/tWLcAgfBSxNpOJTIx9pJ7v3HMQydkwU8R5oLq28ivk5aU+xDVbUQhZD/P8pmn42c0w01Zbuwq2tniE7zVU0dodzjhOQbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZqOH3TJb/iYXsbNMB4mhnRRTbHkdGykmrz6jNRxOjQM=;
 b=JzpNGkLFtFZTeaXM+SFbKMrgABorKZow9JMpbn/YoY1FEPmFoMkltg4kTJX/VtZx99vCmZNiP7eNJZ3YzNAvTKYgQgnvGruSrPZiNaVwkOlZTjTSRQPKWh6+qH0erzDdXf3KwkPHzs7fst4Jfp6zfwwTbnHenLM+BE4qB/yzC4jVba+tlu2H2acBwUScl0RfbKgdDw/j2miKVBxt0Qs/qm9dBzrVDSZYWw11rKX6oiJcr+kCESv7GlheIQn+F6hUAusFBNZwmpp3GnEf1TPRrYq7AUVsSada0KOuw58GkTxeHw6e1aC2qI3wZ+PrAB1gTMWtP8KuXz8GfA0aunhdsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from BYAPR02MB5575.namprd02.prod.outlook.com (2603:10b6:a03:a6::24)
 by BY5PR02MB6308.namprd02.prod.outlook.com (2603:10b6:a03:1b1::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.21; Wed, 25 Aug
 2021 13:40:13 +0000
Received: from BYAPR02MB5575.namprd02.prod.outlook.com
 ([fe80::4528:8175:6b4a:70eb]) by BYAPR02MB5575.namprd02.prod.outlook.com
 ([fe80::4528:8175:6b4a:70eb%7]) with mapi id 15.20.4457.018; Wed, 25 Aug 2021
 13:40:13 +0000
From:   Tiberiu Georgescu <tiberiu.georgescu@nutanix.com>
To:     Peter Xu <peterx@redhat.com>
CC:     David Hildenbrand <david@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Alistair Popple <apopple@nvidia.com>,
        Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Carl Waldspurger [C]" <carl.waldspurger@nutanix.com>,
        Florian Schmidt <flosch@nutanix.com>,
        Jonathan Davies <jond@nutanix.com>,
        Chris Riches <chris.riches@nutanix.com>
Subject: Re: [PATCH RFC 0/4] mm: Enable PM_SWAP for shmem with PTE_MARKER
Thread-Topic: [PATCH RFC 0/4] mm: Enable PM_SWAP for shmem with PTE_MARKER
Thread-Index: AQHXizvfxbSDphJsCEy6t9AqGpL5qqt3d0AAgACHggCAABs6gIAAGzmAgADJJACAAJ7TgIAABe+AgAFamQCAACqDAIABiCIAgAAnsYCAB37yAA==
Date:   Wed, 25 Aug 2021 13:40:13 +0000
Message-ID: <53EBB3A1-06C0-418A-B20E-5BFD5212D7C3@nutanix.com>
References: <16a765e7-c2a3-982a-e585-c04067766e3f@redhat.com>
 <YRvtPrPmAorX+KY5@t490s> <c4adbba1-2299-f87c-1893-e83af9beadbc@redhat.com>
 <YRwa6+jx5PukCn53@t490s> <c29a9994-8fa3-d36d-d973-f99314c243cf@redhat.com>
 <7F645772-1212-4F0D-88AF-2569D5BBC2CD@nutanix.com>
 <6ab58270-c487-2a56-b522-ea5100edb13c@redhat.com>
 <0A4C4E37-88C9-4490-9D8B-6990D805F447@nutanix.com>
 <5766d353-6ff8-fdfa-f8f9-764e8de9b5aa@redhat.com>
 <B130B700-B3DB-4D07-A632-73030BCBC715@nutanix.com> <YR/+gfL8RCP8XoB1@t490s>
In-Reply-To: <YR/+gfL8RCP8XoB1@t490s>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nutanix.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: debd25d2-aed7-4bbd-92a3-08d967cddd97
x-ms-traffictypediagnostic: BY5PR02MB6308:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR02MB6308557A3E2F102AC0E97249E6C69@BY5PR02MB6308.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iHLWvvXSY4sC+B1k4VQEzKxbrgOgM7/rzCxI4TmU2+tbMPz8laBOm3Y3wnoiDHDQ1DNhh2qLU5vDoDInDbcoLUjaOrgBNxLGT9mCStVjiYSq8EoIOENu4SVCIEJL0SEEg5tgLLHzRbTBgFh3nN5QyGi6h3qZbMukvjQQOr9aZzDOzLHCP03uh+h37s/snCqNOeo9c+8R/ea/fcwmW+8W/MKIftF/boeNqj91T/KEa8+9XWscP/y5fAbWYAitUQ74RdH1XzNq7CxvlDdsJIV6iZ+8W80bYP2lgVdQIXSnpWdDlxWVHYOlL3IlbPAagD2rTK+/SzSl8qyQtT0AzXALRt+i6wf+7w4OX1cSWjT/g2qeNMqwCRHUAdQ1pvbDbDK5kLA8lxOeYe80Y+TrXhQDOlzWBE2oOGxFAVngnQ0gkbDcVyPkzff6tjmyFZfdBkk4FzcYMXV9yr8leIbaJYYSMgBPlKYQwi+2/R5r+QVa25EjXBVXkQit3GLSYDbo8GxcB/glSHNhABuYSQcNDUmM9Gs8FZ+JyykjETmXeq6G4YMD+k0x/ZbbS3UGO0tdi1PFwuFHr3zhkHrQR22320g+xaw+f6kUr6pxLlxTrgqGYD91kepz+h0Z4vhX5XivTCKC4hk4Po4QuaA4/si3bmZtcmoF7urgFKigi65038Jlso0oW+pNRtnzubr9wGqA6ibsC/+tU0G0xWRoGhgRNi+U8h5Gu8XtqIxtDIWzKoQOzsJINJ9+JM5ndjRqpJyRVtqr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB5575.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(366004)(346002)(396003)(136003)(7416002)(122000001)(186003)(38100700002)(36756003)(8676002)(38070700005)(54906003)(316002)(2906002)(478600001)(6506007)(5660300002)(107886003)(44832011)(66446008)(64756008)(66946007)(33656002)(6486002)(66556008)(91956017)(6512007)(66476007)(76116006)(71200400001)(8936002)(86362001)(4326008)(6916009)(2616005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vSd7NP6LkvTdhlzxh1T8oK6O/LQu1e1vjCjHlTZ6VmKW7JPRJQhnvVw92bNp?=
 =?us-ascii?Q?KxIIdc5qzcyMAKyEcXT4X3XWR+6nYszD+8Zjg6SpENPsR+TsB7hgvS4YPKxe?=
 =?us-ascii?Q?cXY+QNI9qusFkAraNhNsp2zZmLBgD5yoeyGcdkGZgcyWVP6fLfzg6P/DkQiH?=
 =?us-ascii?Q?Swu+qQydqGPczILOL3hnq2XgA9fW2EPMu0DOePpaEvprtJl5VkDC+rn1xPN5?=
 =?us-ascii?Q?q3jMV4hlWcdJiA93zLssCJkqKnkgX+hEVWOisaf6BYDix1U7YxoQxcUinQt/?=
 =?us-ascii?Q?5TetvUug2qUas81pmEs3a49cg8vdH3PXHmJ40UiiiMXkNdqpYoW1BoHHY1kK?=
 =?us-ascii?Q?O3E3DNovj26mJvAecg8hIaYsi9UAyARx/coaHKnNwm4Aeovwgc2ViaLvBHP4?=
 =?us-ascii?Q?3iPQarrVtC77wgLYpHbb842h8/aB3JZhU8KjpS9mvBMt8pJMy7JwjnGMwNVq?=
 =?us-ascii?Q?LxrH4mfmLwZJVjTtyGLvdX49W5VKHi/swQj2/2WwKGxt4pMZqBvN8SGjuUdg?=
 =?us-ascii?Q?B6ZwevfprgmzPW6OZ52P2OTGxS5yemIsPZOo5pcMOyo/gtgIc5Xi1aKKRhbG?=
 =?us-ascii?Q?V/UPXnSC8mavF/nWe783dJCS+cwQv6JBpm8CXofTDxE7MLZyHFy5CugwnBqb?=
 =?us-ascii?Q?JVhGO4HdPSNfCiesmtSenJh+puppVfqcoP1I0H2vNZo9JCY7kbxk6SrA1i2c?=
 =?us-ascii?Q?5RzRpSdZgaoF/j3w4rgNmX1kq/l6H5Ukcw9mt83f2f9IlOixgXJ8QSCqOch+?=
 =?us-ascii?Q?FbafaEfqUqLxBbAlA1pAGb4Boa5Whj0mns5R6aHoPQ/B0fiyC6PxvbVVxIW7?=
 =?us-ascii?Q?YxQqrMySsn6LcDKUHnVYy+N5z029z+0snGEokra/MpYZwzjOhxCzJ099A82I?=
 =?us-ascii?Q?AluC/SehrvoEvQ2wlqlFaUrv7wXbzfuQHMIc8Qmny+ilouI6BENQ9SBZ2adZ?=
 =?us-ascii?Q?/gxQoub39y6zOonmPhnNutf9iP/UY3Qtzej1vEWw7RHe2GsRE8nl4NsG3bq5?=
 =?us-ascii?Q?vEk2ukgIvKCaxR7dmP1KbZe8eOIF4klmj8YYJOw9pZv5IFf29AjDj59nZSp5?=
 =?us-ascii?Q?VEMGv7ZguzG/bisOEz1Ap/20yPpQTVPh+ZsBwPWNuFHt7GRneEGFEnCYWc8o?=
 =?us-ascii?Q?apM/SBmckuGBWnJ++DVjs1NOWqyLg+xuBReEM5wT9fYU6PGJp4t7C7+q61mY?=
 =?us-ascii?Q?1p7whtfumWCRcCsaFyZ+/DfZSnpl55uGIS2Tgbanw7xXA2E++KPkChlH5Hy6?=
 =?us-ascii?Q?VywxxBWratMisQhws4a7KHVLyYdJKT4R5RsNTS+rHSOmk7GLWeQCEhscLcXN?=
 =?us-ascii?Q?fRvDRSCajVKhujOzTSv3AYi4++wBuidBLuz4IXSxr8JCjhFrXad9cJ7ZFDL5?=
 =?us-ascii?Q?/TYeJOw/MZKQYJyLx15SKpto/FPmTZm3hDmoAe/htsQSaBZVTg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <83C8A7118B253443AE7C471903CB4AB7@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB5575.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: debd25d2-aed7-4bbd-92a3-08d967cddd97
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2021 13:40:13.2251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jkPAtricttTuywWLwhjiARjqfqOjuIx3Ou2PzuRveZ6SfRxYnfl4sw4SUYqXAedlKJRQWaxIWoqGqggD4t0Zg5pNR8kluD96LCwp03IwgEU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6308
X-Proofpoint-ORIG-GUID: 52OOihKsqKENnHfslrACviB2H8eJcvSv
X-Proofpoint-GUID: 52OOihKsqKENnHfslrACviB2H8eJcvSv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-08-25_05,2021-08-25_02,2020-04-07_01
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Peter, sorry for the late reply,

> On Fri, Aug 20, 2021 at 04:49:58PM +0000, Tiberiu Georgescu wrote:
>> Firstly, I am worried lseek with the SEEK_HOLE flag would page in pages =
from
>> swap, so using it would be a direct factor on its own output. If people =
are working
>> on Live Migration, this would not be ideal. I am not 100% sure this is h=
ow lseek
>> works, so please feel free to contradict me, but I think it would swap i=
n some
>> of the pages that it seeks through, if not all, to figure out when to st=
op. Unless it
>> leverages the page cache somehow, or an internal bitmap.
>=20
> It shouldn't.  Man page is clear on that:
>=20
>       SEEK_DATA
>              Adjust the file offset to the next location in the file grea=
ter
>              than or equal to offset containing data.  If offset points t=
o
>              data, then the file offset is set to offset.

Ok, I got to test it out and you are right. lseek does not swap in pages. T=
hat is
great news.
>=20
> Again, I think your requirement is different from CRIU, so I think mincor=
e() is
> the right thing for you.
>=20
>>=20
>> Secondly, mincore() could return some "false positives" for this particu=
lar use
>> case. That is because it returns flag=3D1 for pages which are still in t=
he swap
>> cache, so the output becomes ambiguous.
>=20
> I don't think so; mincore() should return flag=3D0 if it's either in swap=
 cache
> or even got dropped from it.  I think its name/doc also shows that in the=
 fact
> that "as long as it's not in RAM, the flag is cleared".  That's why I thi=
nk
> that should indeed be what you're looking for, if swp entry can be ignore=
d.
> More below on that.

By saying there are "false positives", I do not mean that the mincore() wou=
ld
not work as expected, only that its definition is a little more subtle than=
 that. And
that it does not suit our needs entirely by itself.

I tested mincore() compared to the pagemap, and I discovered that there are
more flags set to 1 (not necessarily contiguous) compared to the pages page=
map=20
was reporting as present. By also looking through the code, I could only co=
nclude
that pages in the swap cache were considered "still in RAM", so were set to=
 1 as
well. When looking into what the swap cache does, it makes sense.

We could use mincore() and pagemap to find the pages in the swap cache.

In short, mincore() is not enough because it does not differentiate between
present pages and swap-cache entries, as both are in RAM, but the latter
is also in swap. It can be used with other tools to get more specific infor=
mation
though, so it is useful.
>=20
> Note that my series is as you mentioned missing the changes to support
> mincore() (otherwise I'll know the existance of it!).  It'll be trivial t=
o add
> that, but let's see whether mincore() will satisfy your need.

We are currently trying to make use of all tools that we have learned of so=
 far
during our discussions (lseek, map_files, even mincore) to get the informat=
ion
that we need about swap pages. In theory, for many of our use cases, a
combination of 2 or 3 should be enough.

It is a little more convoluted than a simple pagemap call, but it can be mo=
re
versatile (using lseek to skip multiple unallocated pages). As to whether t=
he swap
bit (and more) should be eventually added on the pagemap, maybe this topic
makes more sense to continue on the Documentation thread.
>=20
> [...]
>=20
>> It is possible for the swap device to be network attached and shared, so=
 multiple
>> hosts would need to understand its content. Then it is no longer interna=
l to one
>> kernel only.
>>=20
>> By being swap-aware, we can skip swapped-out pages during migration (to =
prevent IO and potential thrashing), and transfer those pages in another wa=
y that
>> is zero-copy.
>=20
> That sounds reasonable, but I'm not aware of any user-API that exposes sw=
ap
> entries to userspace, or is there one?

Good question. AFAIK, the swap device can be retrieved by using the swap ty=
pe,
which is part of the swap entry. During our discussions, I was always assum=
ing
that, if the pagemap entry kept track of the swap offset, it would keep tra=
ck of the
swap type and, conversely, the swap device as well. Sorry if I haven't made=
 this
assumption clear until now.

So we were relying on the pagemap to expose swap entry information. Seeing =
it
works for private pages, we thought it made sense to have worked on shared =
pages as well.
>=20
> I.e., how do you know which swap device is which?  How do you guarantee t=
he
> kernel swp entry information won't change along with time?

I don't think we can guarantee it unless we halt the guest. But QEMU does m=
ost
migration work in pre-copy using a best-effort approach anyway.

So, having a way to retrieve temporary, but accurate information about swap
entries (i.e. post-patch pagemap) should be enough to guarantee a smoother
migration process. It is intended to be repeated, unless there is no change
between iterations.

--
Kind regards,

Tibi

