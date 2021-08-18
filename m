Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF813F0A92
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 19:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhHRRxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 13:53:48 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:43414 "EHLO
        mx0b-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229558AbhHRRxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 13:53:45 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17IGUo87025498;
        Wed, 18 Aug 2021 10:52:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=UoQ89djYtu5hf1eFp4H+8HQe5R4bZEBTYH39dRx2fNE=;
 b=aN4S5Xdx8P9FYDM0JGSDSvaCM6d0Me9//32s3F6GLrr7/IuHsp+yu6Cwm9akS+4V7LyI
 0xu+/fz50EkSh/FkydqdD8yqrlgEfqAhrlHw4XrN0gqJu1Q+6by8EmJ7s9hKgN04cSgK
 AOjKqx0wEAYM4Gye0qtz0S5iVQcAm7ZvtakxcOfAN10Q5nnTDy2f28JM4XU19w+zi4Ui
 6NwwpfMXcj35NtYxOBHsULZXZhnI7rUayh1hi4Tr5FtBLPY6CXzVIB8Y2tS5peMdgcFg
 2z0TT8LYqA4kkfh59xiy6xwk+yiazGPFpN0wqB7km/je9Drg9X/naYJUqc5gB6i1tGoW hw== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by mx0b-002c1b01.pphosted.com with ESMTP id 3agyajh221-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Aug 2021 10:52:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T7WXoorprlFIFwIZIpWquCWKUbX4vlVFEWqAXOVz2luDW43dkC8XKLWbuJAccBsy1a8e200JOzko9qGSdrcy4LJG7IQCfajv++dQhDOndqr/+WyT4qMzorFfEntGyQG9ejRLIviWXxIBIoSNlsHFVWy9WO8jlnAe/rgQunFmUt5TnX68YgZ4Ki8b8Nbr0FYvWDjJQAKpP9O2EoM2NlKoLRcRSKm1AhwQWuiigmI6MVoIHCng9bFAFpqs6ZBUnZtavtGwzywzTxrPa6nrpMUGrx2Wspf/0BS+iR/47ZW50LuPSkqmZi3lpMmrVOM0xl6Vu20F1jvbIsOtTfff5dfDVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UoQ89djYtu5hf1eFp4H+8HQe5R4bZEBTYH39dRx2fNE=;
 b=ANz8EZuAXGJyVOkPkUEYvANl2UhkYlT1hy2Dt5m+VowMbjEBdeKOIYsv9gKmj3o+PxY+FPOxqYX/QXH01Uh+c57xpg7v+DKMBJ1ylIOPhnkSDCOdWnchRB15OYaU/8/xm6ZzUYda5K6IZdLJa7xoKZGKYB+/X4WlNyNzvg1NWLQU+QTdTzOWzKN8YQB3xgxxociMgU6TL/2EvkuqxckKzWwXe6qdpcy7iVmQRKZvdtoHEukmRhhlkiwdXnmew0ClJY9ay54g0DmPynPAmJHEGn71hxeSUQ4dFanJJLSQJZVzyW3HLvwmvXmqOvrnG3CHO78eGsp0g8Q/zojlOU5Wdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from DM6PR02MB5578.namprd02.prod.outlook.com (2603:10b6:5:79::13) by
 DM8PR02MB8263.namprd02.prod.outlook.com (2603:10b6:5:314::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.17; Wed, 18 Aug 2021 17:52:33 +0000
Received: from DM6PR02MB5578.namprd02.prod.outlook.com
 ([fe80::5116:80a5:77d9:fcc4]) by DM6PR02MB5578.namprd02.prod.outlook.com
 ([fe80::5116:80a5:77d9:fcc4%7]) with mapi id 15.20.4415.024; Wed, 18 Aug 2021
 17:52:33 +0000
From:   Tiberiu Georgescu <tiberiu.georgescu@nutanix.com>
To:     David Hildenbrand <david@redhat.com>
CC:     Peter Xu <peterx@redhat.com>,
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
        Jonathan Davies <jond@nutanix.com>
Subject: Re: [PATCH RFC 0/4] mm: Enable PM_SWAP for shmem with PTE_MARKER
Thread-Topic: [PATCH RFC 0/4] mm: Enable PM_SWAP for shmem with PTE_MARKER
Thread-Index: AQHXizvfxbSDphJsCEy6t9AqGpL5qqt3d0AAgACHggCAABs6gIAAGzmAgADJJACAAJ7TgA==
Date:   Wed, 18 Aug 2021 17:52:33 +0000
Message-ID: <7F645772-1212-4F0D-88AF-2569D5BBC2CD@nutanix.com>
References: <20210807032521.7591-1-peterx@redhat.com>
 <16a765e7-c2a3-982a-e585-c04067766e3f@redhat.com> <YRvtPrPmAorX+KY5@t490s>
 <c4adbba1-2299-f87c-1893-e83af9beadbc@redhat.com> <YRwa6+jx5PukCn53@t490s>
 <c29a9994-8fa3-d36d-d973-f99314c243cf@redhat.com>
In-Reply-To: <c29a9994-8fa3-d36d-d973-f99314c243cf@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nutanix.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b343ae15-9f99-40df-585c-08d96270f512
x-ms-traffictypediagnostic: DM8PR02MB8263:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM8PR02MB826394B15E72F7274C944BFDE6FF9@DM8PR02MB8263.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VBi91mpENZBgBImwu1Db5DYC8ZK6wCxXRdUk0TCj5NQ9wOc4L5ZQzUwTrQwdf89fQOBcrOCkI5uZ/0imQpgSLFGGUwjR3dE+S8Ftn/NFOXpRBpfvRDXhAWXIrjVn3ReZbqFsCcTq8SQ9oBQVpPL8BqR3tIwqn5/gD7i/JnBvm/TqqKREepcjMvu5SVtTrDRaB3hX2g/5MCVWChv4ux/5Vjra+MqVCjP9LK5PXgZvRVi5JWbKBsw62Yw9vLV0LVLn+qZ2tS6PNaSvwZxP4OMGWInBvWvWptJnXe8ccOCN4hBkd0ZjsHMTesLszq1mzEIGIJuFdpswjIMG4zwoBJpw+qDxLVsaZsd+dy7yAmAKdzHF3eJTVtifWmUpJ20ok4nTmmcZoO4TTQZcXC+j8ECwzeQtRvDtv8oc5OGVP21DPpRkkGVeZeV7HcGH9BBAQQPqD9MSLekak6OZy2sfL7qVt89RhNko3+lb3iIPjRD2G3Q+CzAezHXXEn+z922BK2xOC+cEpNNa1KvMaK/hdQfiLFl2HOuDuQyJjYIojOdKXdCrBkqaY5qBkjzUDHPsNDvJIGD0D7X/zWOLqNPu2D26otaFaMaigIdtw1KTbbpqOmJMty0d/GW8fGMPctnchSIWUC92nZ/NT21EOVqf3okUC4brf+oF6GrplVJfSSilbRkdt/T8N4kO+jOdwE8/UQ6LZpG+RIZ87pt6IoKXxMffKl+FZQbGGbQSHYPWvtAyRihBaAHLaiZbdDC82gImnbbNH47yOv3Yb3ku8KyLtDfUFwMcDzGP2qcz2SDeTtROTBhMmSVtpQreLyduZgQCfYBHxwqtUTkpheFJfGlVRdvoB0j2KMdsx4O9ea/StqMvPEs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR02MB5578.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(39860400002)(376002)(366004)(396003)(76116006)(66946007)(186003)(66476007)(6486002)(91956017)(107886003)(38100700002)(66556008)(5660300002)(6916009)(6512007)(64756008)(54906003)(122000001)(316002)(66446008)(6506007)(36756003)(7416002)(53546011)(38070700005)(86362001)(83380400001)(71200400001)(478600001)(33656002)(2616005)(966005)(44832011)(2906002)(8676002)(8936002)(4326008)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PCgi4qkbsVFNYGpZtguQbgiVFEYYUcXKagG02P+e8LvCDAq1q17euCa3wCtV?=
 =?us-ascii?Q?oauEcgc+v/yRQBVmkLRr6s/G2P0s1H5pT0NLAN7JSm4SR3plgS3lGiARGW7f?=
 =?us-ascii?Q?LgzNSAjnD9Kcx80iVDaTvor0LoN7IAqiageqbKcpKisg4ORdggItsXI2BJG0?=
 =?us-ascii?Q?UBukKu/CBIHsKpi8V2NunSORLXBwTCaybuXy9mFFdRoY5vdSiVqnlQhMr23w?=
 =?us-ascii?Q?1nTcsF0aabH6lgBHI/34WvBgTmHncrG/cNO/Tem9y9v+eOB5Z/dvKPSYf7dl?=
 =?us-ascii?Q?o8lOHwzNShg1FcojPUD6XsCrunwFu+8nigIEGoQW6taA/+1S6/LoF/s3ig8B?=
 =?us-ascii?Q?SU/Qa4vbKbvfn+NTHiSRyODSywkqphotwhOXhV3lWHpFvLrqCiSCbBS24qiL?=
 =?us-ascii?Q?oGyHW7rytyjgfMvM4qKIZBDi3rBamVtO839rB5bubOTo1rFyjmJNnk2oH6vs?=
 =?us-ascii?Q?FnqCDgjoG5WuWxURiRVqCfMXPwX+HAgnShFtTW/Ql/f4IqPb9zeQcV5iLmfT?=
 =?us-ascii?Q?1U6FqBd2b3LYJsHN4ZxWxVkrc1p1xRX2XG5WnjzD68HAECKZs3913oFFCxOl?=
 =?us-ascii?Q?t013SFaZLtvVYQSObcx994xq3GG71/49GLp8F7AXPsZigVcdoBSb4VMudOPD?=
 =?us-ascii?Q?9K7xmyWJMHHR+Kwq5hvvo1eu3X7PymiHy0gCzn1DfegGW7k4FjlVqJet7k0R?=
 =?us-ascii?Q?PCL4sVZuPWRLwyMzaon/+63id8ijgoETsBimqXU1foxGbucvrThJh6k6wIQf?=
 =?us-ascii?Q?BJyWqZhqTXskxrqZfNC5M2zfWAvLRAEfMpBuQzY+Upq9B4Wg5/tEs7b2tD7h?=
 =?us-ascii?Q?PZt74wWYrQBMRMfk0K3x0iqncW+2NB0l31+377B3MDk5BSqYCCJnwEQ8v+rs?=
 =?us-ascii?Q?uSp2dZYWP7q49zJiwwZsAHRu1FDyZue2ggg/xJKUDAORBIo71orArpVDZYR8?=
 =?us-ascii?Q?BbDLL/VmZomIfAw/XQzqqDlOfgw7P+fOgnlIIpYKsRRzRwXiwnR0a9bHO8WP?=
 =?us-ascii?Q?M8mNZnNGMjSq675q2XCCRx51HV+vS8qbNbpZXSIgLIr0kUVuTuNqQwpMBfc9?=
 =?us-ascii?Q?i/xVVMKzFpn11pVg3CP9c4fodNCOtpfa1OUg2ImC4v9DVCBxmaLY18zbB1rG?=
 =?us-ascii?Q?Ib2k6LMhDZ0WxowxTOg3uNohRZ1l9PSZ+4/8ps6OscVU5+8H7BwMwinBAMTG?=
 =?us-ascii?Q?S/FAUhYbxQGfhMTWIHm4IyvqBaTWFMC7923imuTNSQILI+YyYLZATkUKjNIh?=
 =?us-ascii?Q?xugtCSMX3/JRJZj9gh8xhGBN/HYfdwAyhjG/GH9LRLDZ3Kt2rEDnJwu+w8bA?=
 =?us-ascii?Q?T/LorV2YyoijVdrydra8DufWzqYvMbDshh+P6dqDIScVmmXqLTJryd7TdvD0?=
 =?us-ascii?Q?JRpPVcLMUhlKHqj//TEnaTK0YriV?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3F85C26B2E6DF54C81E3B7B727A40BB2@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB5578.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b343ae15-9f99-40df-585c-08d96270f512
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2021 17:52:33.6095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TMVOZfI6b013+AcVHO9FtB7E2bxbtQ/dIAtqQJBmsB7P789Ss7ulSCpCWznYnm/+rrTiCx0P/5MjcoPcVGKSJBeCnA49oCSGhSPZCq96uPU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB8263
X-Proofpoint-GUID: gvCIRpMaOgKz_i5uC_9jZWeF5eHfFCYB
X-Proofpoint-ORIG-GUID: gvCIRpMaOgKz_i5uC_9jZWeF5eHfFCYB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-08-18_06,2021-08-17_02,2020-04-07_01
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 18 Aug 2021, at 09:24, David Hildenbrand <david@redhat.com> wrote:
>=20
> On 17.08.21 22:24, Peter Xu wrote:
>> On Tue, Aug 17, 2021 at 08:46:45PM +0200, David Hildenbrand wrote:
>>>> Please have a look at current pagemap impl in pte_to_pagemap_entry(). =
 It's not
>>>> accurate from the 1st day, imho.  E.g., when a page is being migrated =
from numa
>>>> node 1 to node 2, we'll mark it PM_SWAP but I think it's not the case.=
  We can
>>>> make it more accurate, but I think it's fine, because it's a hint.
>>>=20
>>> That inconsistency doesn't really matter as you can determine if someth=
ing
>>> is present and worth dumping if it's either swapped or present. As long=
 as
>>> it's one of both but not simply nothing.
>>>=20
>>> I will shamelessly reference
>>> tools/testing/selftests/vm/madv_populate.c:pagemap_is_populated() that
>>> checks exactly for that (the test case uses only private anonymous memo=
ry).
>> Then I think the MADV_POPULATE_READ|WRITE test cases shouldn't depend on
>> PM_SWAP for that when it goes beyond anonymous private memories - when s=
hmem
>> swapped out the pte can be none, then the test case can fail even if it
>> shouldn't, imho.
>=20
> Exactly, because the pagemap is fairly completely broken for shmem.
>=20
>> The mincore() syscall seems to be ideally the thing you may want to make=
 it
>> accurate, but again it's not a problem for current anonymous private mem=
ories.
>=20
> I haven't checked the details, but I believe the mincore() syscall won't =
report swapped out pages. At least according to its documentation:
>=20
> "mincore()  returns a vector that indicates whether pages of the calling =
process's virtual memory are resident in core (RAM), and so will not cause =
a disk access  (page  fault)  if  referenced."
>=20
> (to protect it from swapping and relying on mincore() we would have to ml=
ock that memory; we'd want MCL_ONFAULT to be able to test MADV_POPULATE_REA=
D|WRITE; or we'd just want to rely on lseek)

After some digging and testing, I found out that the docs for mincore() are=
 a little outdated, and that
the RFC has an unexpected side effect on the sys call.

The output vector is supposed to set the flag to 1 if the page it indicates=
 was present in either the
page cache or the swap cache. I would like to highlight that if a page got =
swapped out and reached
swap (i.e. page content no longer stored in the swap cache), the flag gets =
set to 0.

So indeed, mincore does not report swapped out pages, but AFAIK, it does re=
ports pages which are
still in the swap cache.

There was an attempt to rework mincore altogether and make it retrieve mapp=
ings instead [1], but
was quickly reverted [2] because the removed functionality was necessary fo=
r some long functioning systems.

On Peter's RFC, it now looks like mincore()'s flags are set to 1 for any sh=
ared page that has been
dirtied, whether it is still present, in swap cache or it arrived in swap. =
AFAIK, only none pages have
their flags set to zero. For private pages, mincore still seems to behave n=
ormally.

[1] https://github.com/torvalds/linux/commit/574823bfab82d9d8fa47f422778043=
fbb4b4f50e
[2] https://github.com/torvalds/linux/commit/30bac164aca750892b93eef350439a=
0562a68647

>=20
>>>=20
>>>>=20
>>>>> Take CRIU as an example, it has to be correct even if a process would=
 remap a
>>>>> memory region, fork() and unmap in the parent as far as I understand,=
 ...
>>>>=20
>>>> Are you talking about dirty bit or swap bit?  I'm a bit confused on wh=
y swap
>>>> bit needs to be accurate.  Maybe you mean the dirty bit?
>>>=20
>>> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__criu.org_Shared-=
5Fmemory&d=3DDwIDaQ&c=3Ds883GpUCOChKOHiocYtGcg&r=3DrRM5dtWOv0DNo5dDxZ2U16jl=
4WAw6ql5szOKa9cu_RA&m=3DA5H_4nfdW_jAPHckF-cuCBfRHsm2aij-cr-mELX0uww&s=3DDZg=
iYWJgLokyZkBYd5VKOnr5Fbj63aAc01Fu2BPE8Lc&e=3D=20
>>> "Dumping present pages"
>>>=20
>>> "... CRIU does not dump all of the data. Instead, it determines which p=
ages
>>> contain it, and only dumps those pages. This is done similarly to how
>>> regular memory dumping and restoring works, i.e. by looking for PRESENT=
 or
>>> SWAPPED bits in owners' pagemap entries."
>>>=20
>>> -> Neither PRESENT nor SWAPPED results in memory not getting dumped, wh=
ich
>>> makes perfect sense.
>>>=20
>>> 1) Process A sets up shared memory and writes data to it.
>>> 2) System swaps out memory, hints are setup.
>>> 3) Process A forks Process B, hints are not copied.
>>> 4) Process A unmaps shared memory, hints are dropped.
>>> 5) CRIU migrates process A and B and migrates only PRESENT or SWAPPED i=
n
>>> pagemap.
>>> 6) Process B uses memory in shared memory region. Pages were not migrat=
ed.
>>>=20
>>> Just one example; feel free to correct me.
>> I think pte marker won't crash criu, what will happen is that it'll see =
more
>> ptes that used to be none that become the pte markers.  This reminded me=
 that
>> maybe I should teach up mincore() syscall to also be aware of the pte ma=
rker at
>> least, and all non_swap_entry() callers.

I think in mincore_pte_range, the call to non_swap_entry(entry) could retur=
n true, setting the flag on
the vector to 1 prematurely. Please read my comment above.
>=20
> I haven't checked what mincore() is doing, but from what I understand whe=
n reading the CRIU doc and the mincore() doc, it does the right thing witho=
ut requiring any fiddling with pte marker hints. I assume you merely have a=
 performance improvement in mind.
>=20
>>>=20
>>>=20
>>> There is notion of the mincore() systemcall:
>>>=20
>>> "There is one particular feature of shared memory dumps worth mentionin=
g.
>>> Sometimes, a shared memory page can exist in the kernel, but it is not
>>> mapped to any process. CRIU detects such pages by calling mincore() on =
the
>>> shmem segment, which reports back the page in-memory status. The mincor=
e
>>> bitmap is when ANDed with the per-process ones. "
>>>=20
>>> Not sure if they actually mean ORed, because otherwise they'd be losing
>>> pages that have been swapped out. "mincore() returns a vector that indi=
cates
>>> whether pages of the calling process's virtual memory are resident in c=
ore
>>> (RAM)"
>> I am wildly guessing they ORed the two just because PM_SWAP is not worki=
ng
>> properly for shmem, so the OR happens only for shmem.  Criu may not only=
 rely
>> on mincore() because they also want the dirty bits.
>> Btw, I noticed in 2016 criu switched from mincore() to lseek():
>> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__github.com_checkp=
oint-2Drestore_criu_commit_1821acedd04b602b37b587eac5a481094b6274ae&d=3DDwI=
DaQ&c=3Ds883GpUCOChKOHiocYtGcg&r=3DrRM5dtWOv0DNo5dDxZ2U16jl4WAw6ql5szOKa9cu=
_RA&m=3DA5H_4nfdW_jAPHckF-cuCBfRHsm2aij-cr-mELX0uww&s=3Dkel85AR7AGZnvBymbM7=
QEwc770HGO2koka-kTiF-r5U&e=3D=20
>=20
> Interesting. That's certainly what we want when it comes to skipping hole=
s in files. (before reading that, I wasn't even aware that mincore() existe=
d)
>=20
>> Criu should want to know "whether this page has valid data" not "whether=
 this
>> page has swapped out", so lseek() seems to be more suitable, which I'm n=
ot
>> aware of before.
>=20
> Again, just as you, I learned a lot :)

Same :)
>=20
>> I'm now wondering whether for Tiberiu's case mincore() can also be used.=
  It
>> should just still be a bit slow because it'll look up the cache too, but=
 it
>> should work similarly like the original proposal.

I am afraid that the information returned by mincore is a little too vague =
to be of better help, compared to what the pagemap should provide in theory=
. I will have a look to see whether lseek on
proc/map_files works as a "PM_SWAP" equivalent. However, the swap offset wo=
uld still be missing.
>=20
> Very right, maybe we can just avoid tampering with pagemap on shmem compl=
etely (which sounds like an excellent idea to me) and document it as "On sh=
ared memory, we will never indicate SWAPPED if the pages have been swapped =
out. Further, PRESENT might be under-indicated: if a shared page is current=
ly not mapped into the page table of a process.". I saw there was a related=
, proposed doc update, maybe we can finetune that.
>=20
We could take into consideration an alternative approach to retrieving the =
shared page info in user
space, like storing it in sys/fs instead of per process. However, just leav=
ing the pagemap functionality
incomplete, and not providing an alternative to retrieve the missing inform=
ation, does not seem right. Updating the docs with a "can't do" should be t=
emporary, until an alternative or fix.

Also, I think you are talking about my own doc update patch[3]. If not, ple=
ase share a link with your
next reply.

[3] https://marc.info/?m=3D162878395426774
>=20
> --=20
> Thanks,
>=20
> David / dhildenb
--
Kind regards,

Tibi Georgescu

