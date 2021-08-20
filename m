Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD0613F31B9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 18:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbhHTQvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 12:51:16 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:7688 "EHLO
        mx0b-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230036AbhHTQvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 12:51:12 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17KGf46B025773;
        Fri, 20 Aug 2021 09:50:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=ZhDeRT229q9sJ49Iy1/hDc3BxPhIBg5eqWW9lE6RK1c=;
 b=aGECvL8eCsZyFDTLzY06M/lGf6NOVmb/vt1gNOMSxC0zH29lN8MTqHPwkCgrVE3WT2sm
 NnDJYO4F7mTqlRLY+DNtmbkrq+8/w+grV428LBo0S6Pxv53m90aIi61r+ltqEXAKhfAs
 nGMjOpvZZTwfKUEYmdg2p48KY5LBN8LrCKb/RohH+KnXh8KWdNG3Hg0GL+VLa8XYU3ps
 N0UW9X0AlCD8j/iZb9fGekufbT+Jz90jwTV15aBDIoGmobK1Vvt9/+z8u1lzGTmJDxG0
 lO/Bg2msQZhtTgATq2HQ7MHGCO2LXdPo8rCBXm2bwik65wozty/sp+/BND8QVLSiGgE7 jw== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0b-002c1b01.pphosted.com with ESMTP id 3ajcuk0ymq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Aug 2021 09:50:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B6yvIs+xerNT20JIhdYGe+6DhRVwbZHywJQfS+7YZJZnWs4Zzjwy08Ks6CXRWKXScc0wnTlYCtp/TXwlXi6Wy2H5SnduYh5j329FRLnNHq2PxxzndVagQWf502AnhMW5SFV/w4+Zv3FmN+b1Nn/yW6o8mJpgFZ3MQ7QAcA/71CIExNoz4GMoRutsoyyigMUicF/hRr4dVL6g09DDOByew6hbaWtEpkfAr6lgG/FJYdfbnej1Cqw0ijA+85bGBN9vNgxXJqG9JLBW3FfezqtyuQaUskCJ7PviXWzh7oDc98lruRGiNLazAfXyvHcXhWp4O8E0af10cgjlYqifMhhR7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZhDeRT229q9sJ49Iy1/hDc3BxPhIBg5eqWW9lE6RK1c=;
 b=lwBo4OTVWwvkqaBjzzJofY7GdqEgJfgH47zTslehN8earjHJmcWmlih9j00DhRkDYKavSdrKtpy7EL1GRragUi8wUNItSKbMh/osoY7ykRDhtFyjcw9awCOu1Uyc1L4yjSL8wmsQ1Gl/olyFowmvzzA4nurs0gjNIj2QTsG2dJ9Y8t9db1/njdnY+Sgp4YKglx1whNueU7A/3XFce+0VqNZIkhbxC/bVZXn23xgmzpkjlOMEP+epFv0cbWs4EB/vbl8FzHiwE4apq9KkRW33eNeV8c4JpHb5ENVw4J7zCUDJtfAUSRl+7fnb8wHsyqPjeO4Y+Fn+S6/hUQazPVXHtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from BL0PR02MB5569.namprd02.prod.outlook.com (2603:10b6:208:8f::26)
 by MN2PR02MB6110.namprd02.prod.outlook.com (2603:10b6:208:1bf::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 16:49:59 +0000
Received: from BL0PR02MB5569.namprd02.prod.outlook.com
 ([fe80::b80d:b2e0:3182:7a4c]) by BL0PR02MB5569.namprd02.prod.outlook.com
 ([fe80::b80d:b2e0:3182:7a4c%6]) with mapi id 15.20.4415.024; Fri, 20 Aug 2021
 16:49:58 +0000
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
Thread-Index: AQHXizvfxbSDphJsCEy6t9AqGpL5qqt3d0AAgACHggCAABs6gIAAGzmAgADJJACAAJ7TgIAABe+AgAFamQCAACqDAIABiCIA
Date:   Fri, 20 Aug 2021 16:49:58 +0000
Message-ID: <B130B700-B3DB-4D07-A632-73030BCBC715@nutanix.com>
References: <20210807032521.7591-1-peterx@redhat.com>
 <16a765e7-c2a3-982a-e585-c04067766e3f@redhat.com> <YRvtPrPmAorX+KY5@t490s>
 <c4adbba1-2299-f87c-1893-e83af9beadbc@redhat.com> <YRwa6+jx5PukCn53@t490s>
 <c29a9994-8fa3-d36d-d973-f99314c243cf@redhat.com>
 <7F645772-1212-4F0D-88AF-2569D5BBC2CD@nutanix.com>
 <6ab58270-c487-2a56-b522-ea5100edb13c@redhat.com>
 <0A4C4E37-88C9-4490-9D8B-6990D805F447@nutanix.com>
 <5766d353-6ff8-fdfa-f8f9-764e8de9b5aa@redhat.com>
In-Reply-To: <5766d353-6ff8-fdfa-f8f9-764e8de9b5aa@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nutanix.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cac7ca1c-8ef5-4cc8-3d6b-08d963fa8be0
x-ms-traffictypediagnostic: MN2PR02MB6110:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR02MB611082D2D93D1732D573BE0AE6C19@MN2PR02MB6110.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JpGJsTWvwclclbFTc1IVrb+nIlqOQHHBbVXwwyU7W5+pmWxMpNkJvENM36TKfP7BCjmBSpUWHEGqNfSqPT99LuDvm6wkKfOI4Q5Oew257ty8kg6ADUSIDpgSK6Z3v8dcKEtkAihTu7AZlbHEmA7J+4F+vcdkzPI00RV8JSFMgJNVwxsT99FUCO7oxzn/UeElSKq2fsGSRtOAso340kpdnyx0UnB69ioXTgKZQ9wDNz7qgEtqdT5GDDKPzfXBDnoXwA14/YvdXw2NIW2RIwHbrwrDz2zCDGnPJ5+kEfWvvWVmxi1u01sREOwXXoYy69z5BgbgsTsNyz6H/JXJOihV4dOyi6Ep41eU4DrhTulMVcQ/eA16CvkR2dKImJ0Qnf1ZbSUOHx86HkTLSNG6N79jCDSBS/Z9xA3Cv0AxYuJqQWdpoj6EsfSWBGwcQCm88j8jEPuYPqB/Yrw5abScrnyNvJ2xdym15u00w4eBQezXdxwRPvyzwPJqlNDgBIZthySqtGA4lOklhGd8R3spCYev5xXPtUcBv7QiDjY08ML5VXqtLqKsVdc8QpbK0AKVlNjEkxdH1g0gT276qGotkgEiYrZza6zrjO663v+rmCQD8lJfaYqrItRWD+Q7j71v8HLFsrxK0CgaP3u6IxoEyuQVRxqSRSPsLUx6sRkHxMEgjEUKNeSafC2K5BnckcDRQcZr5X7ymbNCRiiKf2WCyXE1KS+XcJfkudzmCJCYrSEr2LXvSUfupwS10Xi9AQ/2k5SL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR02MB5569.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(346002)(39860400002)(136003)(376002)(316002)(54906003)(66446008)(91956017)(5660300002)(83380400001)(7416002)(4326008)(6486002)(66476007)(44832011)(122000001)(36756003)(33656002)(8676002)(6512007)(478600001)(86362001)(6916009)(2616005)(6506007)(71200400001)(8936002)(38070700005)(107886003)(2906002)(66556008)(76116006)(186003)(38100700002)(64756008)(66946007)(53546011)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZFwdfvrzwYbyIq/IGRwix+VZ3qQ1ZCVBVNFOGliOnuu0Mk4nPC9MOfYYfWdp?=
 =?us-ascii?Q?MNjDFG+Rd/sZn+QIXN0zXyJSGo/6nsJ38G935H2Iv/Nj77opdhsZF1I1rhnD?=
 =?us-ascii?Q?PrV4gX0UlZev/OT3otcz9B4hnify9d7D56J2+e8zFaV/du3cybhSTI2ll1hZ?=
 =?us-ascii?Q?NkSRVOMr6D0u6JrzN8NWsTn4cQtAhW5mvY8fn2m3uvaeDavjPGfdUcXpcxEO?=
 =?us-ascii?Q?EsZIBDYRQhhcElPb+XK/gd+uYH5Lt/8piRwqa/5IvvgQyc0GibCcgBKwOabQ?=
 =?us-ascii?Q?3u8i35QCOEbz5nb8RNxQKbg66LTOaLgPcPmjy3/0QT0X8GfuCEUdZ1x1XYZ+?=
 =?us-ascii?Q?UlU9YTdEPZ9H7GGGx1vO8tPwI5FzX8yiNuhfLRzp+d1h6W81pf6Y2JntNlPm?=
 =?us-ascii?Q?HL9YGLWVmD0KT0JHkCO9yROncU4N4RofyBps2fxbX3aX54qwufs/N67G7E7m?=
 =?us-ascii?Q?phnjSywKLpxuWagl1FPL97YbP2zx/gcG/7E5YwJiZCJ3StkPXvEokLUEQcYc?=
 =?us-ascii?Q?DVcGRYyptfmSj/g8+qlB37iAc61zZ2InzEwCpmmySrvgHU6VVnVf8Y6zBFuw?=
 =?us-ascii?Q?JhdCZdUEh4JNY35/LoFRjKVjCdJNjkVhjV6h7Ybewsum5vL7NgmvYGvCCDnn?=
 =?us-ascii?Q?PcXJRWJ7H9w4O5Jvh34gOPMf7dP9LQspUxeXwtseGLCgvlW5J8TdQAQRoqt3?=
 =?us-ascii?Q?Od56yMW+D1ZOpjEt2KFoUjTNcVSeADxTDwOJYDilnuwomAkYwObXfqZj7/bD?=
 =?us-ascii?Q?Eqnk9VHLv2klYftFQONDzaAqsnunLqRqbTNI7ArHl2CAgFl3SwpiJ6Q/9NWt?=
 =?us-ascii?Q?gkhDNfOgicqIlhr3Zi5iFVd8i0MLSi/iMkabm0dcd6+dsAgMW2Ejl/b7oVIK?=
 =?us-ascii?Q?HfmZFEffBUjSj4pdRPP9nEVDlzdtbGwNpxjvZUcRqjvLF3kCZTjXjIivaRWB?=
 =?us-ascii?Q?jPEunCXv06SCpVnLuyi2rXyf7N1BcawsuaxvDsRo/6p4A3azuxW9r+OtKJGE?=
 =?us-ascii?Q?XDvbvV3F3F/2qx9Q5dE5bHbhGUQC7m84/BzS9ZWTFzhlsnqKjNexZX9L29dd?=
 =?us-ascii?Q?L1Cj0t5DCML5Txip0ppNXQiqVKqPjca75hU+acdPmm6crcgIfkVIRaf3nLhO?=
 =?us-ascii?Q?H2QxQDv5IAMiBhN5hqBS9UedneH6jsQibzCDS0r7DbrfkPsCuWAzffC1JFNl?=
 =?us-ascii?Q?TwO23abavluBICaJ14FFkR3sCEMaIVoXVQXrtqEDznPbKDlEYKeDO6HMcANk?=
 =?us-ascii?Q?hq9Ne3U1U8CpUtjy6VRQXuBBC7pK7kwhK5zZpPApRpWAZsvUWiw7ESXNoGZO?=
 =?us-ascii?Q?/uQ2CJ+qic8axvbNWGMzME8zVkgFFGHomkWApKh+R88cAe85eUGDKywBi3tx?=
 =?us-ascii?Q?f2SUyJ45d6kJf1lF4UsXCuwCZGtN?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <06CB4D8BE5490749BF459D334A247926@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR02MB5569.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cac7ca1c-8ef5-4cc8-3d6b-08d963fa8be0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2021 16:49:58.6719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pXzv8QibPE+PVZ7vB1afthYHJ6yoaga/n7UmZ1Zn+TeatnioGP5AJeVUMFBeNOIPVJ22ofP9WTH2li6kaXGKCgk1k9yBpHtu2HXJmpKLlFM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6110
X-Proofpoint-GUID: pAfmbb6uILhXkwdRJbKn7eapQSPuAnq2
X-Proofpoint-ORIG-GUID: pAfmbb6uILhXkwdRJbKn7eapQSPuAnq2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-08-20_06,2021-08-20_03,2020-04-07_01
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 19 Aug 2021, at 18:26, David Hildenbrand <david@redhat.com> wrote:
>=20
> On 19.08.21 16:54, Tiberiu Georgescu wrote:
>>> On 18 Aug 2021, at 19:13, David Hildenbrand <david@redhat.com> wrote:
>>>=20
>>>>>=20
>>>>>> I'm now wondering whether for Tiberiu's case mincore() can also be u=
sed.  It
>>>>>> should just still be a bit slow because it'll look up the cache too,=
 but it
>>>>>> should work similarly like the original proposal.
>>>> I am afraid that the information returned by mincore is a little too v=
ague to be of better help, compared to what the pagemap should provide in t=
heory. I will have a look to see whether lseek on
>>>> proc/map_files works as a "PM_SWAP" equivalent. However, the swap offs=
et would still be missing.
>>>=20
>>> Well, with mincore() you could at least decide "page is present" vs. "p=
age is swapped or not existent". At least for making pageout decisions it s=
houldn't really matter, no? madvise(MADV_PAGEOUT) on a hole is a nop.
>> I think you are right. In the optimisation we first presented, we should=
 be able to
>> send the madvise(MADV_PAGEOUT) call even if the page is none quite safel=
y
>> and get the wanted behaviour. Also, the "is_present" or "is_swap_or_none=
"
>> question can be answered by the current pagemap too. Nice catch.
>> However, not all use cases are the same. AFAIK, there is still no way to=
 figure
>> out whether a shared page is swapped out or none unless it is directly
>> read/accessed after a pagemap check. Bringing a page into memory to chec=
k
>> if it previously was in swap does not seem ideal.
>=20
> Well, you can lseek() to remove all the holes and use mincore() to remove=
 all in-memory pages. You're left with the swapped ones. Not the most effic=
ient interface maybe, but there is a way :)

Ok, that could work. Still, I have a couple of concerns.

Firstly, I am worried lseek with the SEEK_HOLE flag would page in pages fro=
m
swap, so using it would be a direct factor on its own output. If people are=
 working
on Live Migration, this would not be ideal. I am not 100% sure this is how =
lseek
works, so please feel free to contradict me, but I think it would swap in s=
ome
of the pages that it seeks through, if not all, to figure out when to stop.=
 Unless it
leverages the page cache somehow, or an internal bitmap.

Secondly, mincore() could return some "false positives" for this particular=
 use
case. That is because it returns flag=3D1 for pages which are still in the =
swap
cache, so the output becomes ambiguous.

I am not saying this is not something that would ever be needed. Some peopl=
e
could actually be looking for exactly this scenario, and lseeking during th=
e check
could be an advantage. Just that it does not look very flexible. That is wh=
y the
pagemap would have been ideal for us.

Alternatively, to get all logically swapped out pages, the lseek with pagem=
ap
should do the trick. As you said, we remove holes with lseek, but we remove
in-memory pages with is_present(pte) instead. This solution would still suf=
fer from=20
my first concern, but it should do the job.

>=20
>> Also, we still have no mechanism to retrieve the swap offsets of shmem p=
ages
>> AFAIK. There is one more QEMU optimisation we are working on that requir=
es
>> these mappings available outside of kernel space.
>=20
> How exactly would the swap offset really help? IMHO that's a kernel inter=
nal that shouldn't be of any value to user space -- it's merely for debuggi=
ng purposes. But I'd love to learn details.

It is possible for the swap device to be network attached and shared, so mu=
ltiple
hosts would need to understand its content. Then it is no longer internal t=
o one
kernel only.

By being swap-aware, we can skip swapped-out pages during migration (to pre=
vent IO and potential thrashing), and transfer those pages in another way t=
hat
is zero-copy.
>=20
> [...]
>=20
>>> If it has an fd and we can punch that into syscalls, we should much rat=
her use that fd to lookup stuff then going via process page tables -- if po=
ssible of course (to be evaluated, because I haven't looked into the CRIU d=
etails and how they use lseek with anonymous shared memory).
>> I found out that it is possible to retrieve the fds of shmem/tmpfs file =
allocations
>> using proc/pid/map_files, which is neat. Still, CRIU does not seem to ca=
re
>> whether a page is swapped out or just empty, only if it is present on pa=
ge cache.
>> The holes that lseek finds would not be able to infer this difference, A=
FAIK. Will
>> test the behaviour to make sure.
>=20
> CRIU wants to migrate everything. lseek() gives you the definitive answer=
 what needs migration -- if it's swapped out or resident. Just skip the hol=
es.

Thank you for the summary. I see why the use case is sufficient for CRIU th=
en.
In our case, the optimisations aim to make the migration on QEMU swap aware=
.

--
Kind regards,
Tibi Georgescu

