Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D86C53F1BFA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 16:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240635AbhHSOzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 10:55:13 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:6208 "EHLO
        mx0a-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238590AbhHSOzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 10:55:12 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
        by mx0a-002c1b01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17JD1Uxa021025;
        Thu, 19 Aug 2021 07:54:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=IM5RmDRvziA25hmHBTq2Mtlsl5pcKgyyDRvK2Cp9i14=;
 b=f++PfSw62mP+RYM2czcj26igx1BiLSAHIIGq6/7QUttRkgWge10sWxET7iOmKfD1jdQ7
 Szd1JRsadgCvpVfk4GqRdCWmouELWwDc6jSvjuFtUPt3ekEmW6/IPNcE4oQp3opVFYx8
 b/CZAJjlBO2/TpYfx7QjJZw9phcil8DmqgCmacyN09E263M1WXEJKTJkg/1QEE4RkL9x
 jkpJf3eJWxOnxjpd/GpwfZBuA51wcULFqhGVCmSXZwt8nQxtQqE9DP34/ldjfQGMJB0p
 1yzloF1dvEZqhcO/gbCX7zNDmKTVz5gP/7nzn7KfSMTL17ekaCcYgREEQaxUpmAMfZ3i +g== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by mx0a-002c1b01.pphosted.com with ESMTP id 3ah4xg4daa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Aug 2021 07:54:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nwFrlTuInzlSN/BBRBz4mnUrS4m1Sg77hEpVc9Kje1Xol1et+ShZxS2XRtJYL/JngwaS2P3SFYVQxkWOqgXF/0LFdEAxkKOWpzrLOGshZJSg8zgWrWNZu0QsXJIrhpu2Gu6GplhZNed4iWLOIogJOi0y5fARnVbLdwD8NMcgNLDTS4Zbn0EW07A4yqupk9iO665OOObGHr6trJ0uccQ5d77/nT6jDMtYZspr65OdAYxhpp42ErdXjDHqLNRPtKBqJb7MLmTOF2dtD1jNgh+gEdLUStHT5Yscb8hRSznPbeNxLjhE+ictip05hQrQ02/9o7DBXkwo2U02joMlw2PQhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IM5RmDRvziA25hmHBTq2Mtlsl5pcKgyyDRvK2Cp9i14=;
 b=L7GBllBXvXEBV3L0q58jwd0Ou7oyNuxeHIHDhSb0H/fsyUw4B023EpDMisClJYykppBOsCcgtOhy4wu3ck/bF1idiRwjW9IsPv0Aaaa1S0NNODi54g2Es/c3bcsubiYBYqZi1soH9Qv4avO3+FHJeZkFPSoCisGN9Ek7ipkok6DEDe26Slra5wUFJACqiTr2XAZtivmUc3EHXE3ivUrmY9paARGrhxvmJ66tHXrf5dpXjItpoJ18rvr9FDDpQUrDjm6miot4u0A1HD0N02ceuQ7Rr9QHtHxljprf2ILOYuvaCG+pNKb4wr7hONQsR0LTXTA3S+ZZdylE+RpDKEP2gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from DM6PR02MB5578.namprd02.prod.outlook.com (2603:10b6:5:79::13) by
 DM6PR02MB6009.namprd02.prod.outlook.com (2603:10b6:5:154::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.19; Thu, 19 Aug 2021 14:54:18 +0000
Received: from DM6PR02MB5578.namprd02.prod.outlook.com
 ([fe80::5116:80a5:77d9:fcc4]) by DM6PR02MB5578.namprd02.prod.outlook.com
 ([fe80::5116:80a5:77d9:fcc4%7]) with mapi id 15.20.4415.025; Thu, 19 Aug 2021
 14:54:18 +0000
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
Thread-Index: AQHXizvfxbSDphJsCEy6t9AqGpL5qqt3d0AAgACHggCAABs6gIAAGzmAgADJJACAAJ7TgIAABe+AgAFamQA=
Date:   Thu, 19 Aug 2021 14:54:18 +0000
Message-ID: <0A4C4E37-88C9-4490-9D8B-6990D805F447@nutanix.com>
References: <20210807032521.7591-1-peterx@redhat.com>
 <16a765e7-c2a3-982a-e585-c04067766e3f@redhat.com> <YRvtPrPmAorX+KY5@t490s>
 <c4adbba1-2299-f87c-1893-e83af9beadbc@redhat.com> <YRwa6+jx5PukCn53@t490s>
 <c29a9994-8fa3-d36d-d973-f99314c243cf@redhat.com>
 <7F645772-1212-4F0D-88AF-2569D5BBC2CD@nutanix.com>
 <6ab58270-c487-2a56-b522-ea5100edb13c@redhat.com>
In-Reply-To: <6ab58270-c487-2a56-b522-ea5100edb13c@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nutanix.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c54ba51-5493-41b4-f157-08d9632138d1
x-ms-traffictypediagnostic: DM6PR02MB6009:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR02MB600998F5214F5FF8CBD9BC9EE6C09@DM6PR02MB6009.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4H95ue3WIMEzinIQKGW6+21PZkYh8XTDAijqOIu0dQbRjYKgE3J2mkBjKfrON3qGN+NL93FYMSWI52INJu8CWUlxxYGkv/W5qIWZ9iUGFenWWORZdnf7X99m4zhLxT8XjwsQyt393Tur9IncuEJBWgdaPqjyNonp8/o1QxupuuWWjix/JhjRi8VWXq6JiprAUVA3RQkLWH130V7Y+oEyjprnRyautEmdp8iBxNY51cFddC3vbygrWTcKNNQ7gjYxpBP8tqhfZrk8lXWYZcmrKvSqjr0DKhHswdQAxgO+6A+ZmdzaSMkVtKfyaiO0fhfeiGQPlgCUIodK1UM55qLYNTqtBoBmWHpq8oHCj6T/d+1e7qAqQbGr25vCt8J7TxzM8Xt+3A3yDaabrvR8gClB1PICf3+XT5ASwDwaIkYsoxNxASkyqsC4NKiuDffynfHlUpZ4hQ+ctYWC8lSrN8wcZCYXM+08nk3nVqjJVP+n7oD6SLg44573QIrT12lP2oxB/5vm0jcjPl/9EbuJQwbg19U04HwirTi7U5dnWsE/S71Bv7dfeI9dnODSPVovvZKqUHfa8f0Kq9c3sZwFsYbnbabA8np1aazBEu4ivJ7UC4e/IGTPSZR2KLNUOqboblhpxa0rYcFlgjfU69Bkmhj6UOv0gUbPk9W5OziFum34C6WkeiuF5esD2lScrGOqkdc5qTd61UBWq1FHddOwoa1iIO9MmYFJHpXwYRLa/AHrdl0GFGTyxp5RDGpictB7qDDejX+fLSioftrrI/zY/Rc1HHs8nvJ9F9gWMMFr8ny3x+nO+gaQtWjhGpjzNyMfaHF8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR02MB5578.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(136003)(346002)(396003)(366004)(5660300002)(7416002)(66946007)(36756003)(44832011)(966005)(66476007)(6486002)(91956017)(64756008)(8936002)(33656002)(316002)(2906002)(76116006)(186003)(4326008)(66556008)(83380400001)(6512007)(86362001)(478600001)(54906003)(38100700002)(66446008)(122000001)(6916009)(38070700005)(6506007)(53546011)(107886003)(2616005)(71200400001)(8676002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DlKLj2bMhy803JZBU6Hsw6tVhaFHuiLZ7lPX8EHIXk/+PqPkvCdJrSOLNUlz?=
 =?us-ascii?Q?xF0ybTyrg4L87SAkNLMrOEvpJAz5Lv84AoBhdWN28VFcaPK8n91rU8QZmh+T?=
 =?us-ascii?Q?F6AOuLvyY5ErzU1+4emtIBzs3QtIdCD16FsQ3eVmuhyYHlmdExaXj6TbJFBx?=
 =?us-ascii?Q?ITAg8yHoUsvtqXHOpzr34Gtaw9toDUMd5me1y0CDqNrjpiTbbi1yNFjTZRYw?=
 =?us-ascii?Q?kJRTO504XQJsp3BRp2tAbVcVKvsDlDW/ssdX2orsDhUzHJkMfFGaTexRFnUL?=
 =?us-ascii?Q?l/zBSy0/aUxQjfsRf6bncNYQ/e4B87mfv9BANfUduqHUJNdZTSuBtCDV/tWS?=
 =?us-ascii?Q?Rse5RfmGCF/dzYBitWhu80BBgYIa8JJ0pq9J5GnZymNzIQfI8vYZihF9QDzi?=
 =?us-ascii?Q?2yzQ81R6SBlmfB5YmTU/0/fH2kwb6j6Zvw5izfUApDEZwhZCjzO4BLKwxM+p?=
 =?us-ascii?Q?fz62ysiiB7aoP0DVghEuC9Bby7RHrrf0EsboWjMXzP1wjVr8MtxQ1a/YovOY?=
 =?us-ascii?Q?Yk5tbPnUm3tN22MRzbmNQwiQW6oNaw1/oYDgimrTd2tkV3kWqWSUKCYfzCrX?=
 =?us-ascii?Q?1E0bpUsF/S5Z+Po7Gf8cbGJNaEOi6dpA3LG0V6HIjDNSROhHBmBqwqTR/nk9?=
 =?us-ascii?Q?s6SHYeGB+tujNv2n3prA043TlRxlW1qEOCOXTcKElql960Ms0miGzF7E+hWY?=
 =?us-ascii?Q?kEBvQ+A5RRpPt+hJd6i0t+Uhpdf0Q6fqCotkK/5t6u4VTTSKM7ZDD66cN9n9?=
 =?us-ascii?Q?ZGJ1sPScBDGjsdquv6kjLkZYOIoAmRDGFjH4sFSCjq+CTmVDWwzixFy3Rylr?=
 =?us-ascii?Q?asu47BY/RCdvHRndkkW0cPl+iyQGWKPW4j71aQnGtcarxjaHDVJ5ikrl1tkQ?=
 =?us-ascii?Q?IhCdS8QMmLQzcGOFhV5fLVs4EhYfCZ3iUg3gU+e8isAbtzvb+NXNnY0QQV3V?=
 =?us-ascii?Q?oOCUNK/hgt8F3KohlzQRgvCzNKOcoUNN2VV6a4D/I6qA9Zzdpte46dBLfCeD?=
 =?us-ascii?Q?og6WlD0to+vEh9dsJ1w5zOirKugpxLB/FQEXFrJwXmx0StFREO9FlJ/0L7gP?=
 =?us-ascii?Q?IL9q/zdqgeU2dL6H7G4FxkSvwBGCMnIYr1PUMK0WbwvbwCwMcqSFE1qJ2eDM?=
 =?us-ascii?Q?KkafpGLk2yZ/DQl31gu4h/hD870zQZjbh38NfCVwwP72EQKV9w9E8d+ECQls?=
 =?us-ascii?Q?D5zHM22sw+ch3fvrBbwpxs+C9WSbE7vHztEjEK0bWyF8YsKHri49bLcgtHZO?=
 =?us-ascii?Q?EW48/lCZBBUjb2oyuEGU9mXQ/SroEwe9XuYRhW4Muz10oekAriKMY3YApG7X?=
 =?us-ascii?Q?eS4r35dpt6tj4yRUqcu/wy9tSxZBpr3Br9BzjbhxmOavedv5/OskHlmeqaaV?=
 =?us-ascii?Q?TE2elJfBrw9jB9radIWknhJ4q4vv?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7AD82B1FE26C96489D6ADBC85614B319@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB5578.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c54ba51-5493-41b4-f157-08d9632138d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2021 14:54:18.6700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: suPpFgOIZ+TWSYU/CrYGyVoZZWgVSgbESJ5tN6dQv9lRsxSsATRaW6FWkLWV7+n421eGiKMM2OAEH0q2PXcWGBAWEuiU+N8PliFLvv61b3Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6009
X-Proofpoint-GUID: OHX3Xoi1LigEoUu7xiRkyj9FA9Dy0EqH
X-Proofpoint-ORIG-GUID: OHX3Xoi1LigEoUu7xiRkyj9FA9Dy0EqH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-08-19_07,2021-08-17_02,2020-04-07_01
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 18 Aug 2021, at 19:13, David Hildenbrand <david@redhat.com> wrote:
>=20
>>>=20
>>>> I'm now wondering whether for Tiberiu's case mincore() can also be use=
d.  It
>>>> should just still be a bit slow because it'll look up the cache too, b=
ut it
>>>> should work similarly like the original proposal.
>> I am afraid that the information returned by mincore is a little too vag=
ue to be of better help, compared to what the pagemap should provide in the=
ory. I will have a look to see whether lseek on
>> proc/map_files works as a "PM_SWAP" equivalent. However, the swap offset=
 would still be missing.
>=20
> Well, with mincore() you could at least decide "page is present" vs. "pag=
e is swapped or not existent". At least for making pageout decisions it sho=
uldn't really matter, no? madvise(MADV_PAGEOUT) on a hole is a nop.

I think you are right. In the optimisation we first presented, we should be=
 able to
send the madvise(MADV_PAGEOUT) call even if the page is none quite safely
and get the wanted behaviour. Also, the "is_present" or "is_swap_or_none"
question can be answered by the current pagemap too. Nice catch.

However, not all use cases are the same. AFAIK, there is still no way to fi=
gure
out whether a shared page is swapped out or none unless it is directly
read/accessed after a pagemap check. Bringing a page into memory to check
if it previously was in swap does not seem ideal.

Also, we still have no mechanism to retrieve the swap offsets of shmem page=
s
AFAIK. There is one more QEMU optimisation we are working on that requires
these mappings available outside of kernel space.
>=20
> But I'm not 100% sure what exactly your use case is here and what you wou=
ld really need, so you know best :)

Maybe, but I am always open to (m)advise :)
>=20
>>>=20
>>> Very right, maybe we can just avoid tampering with pagemap on shmem com=
pletely (which sounds like an excellent idea to me) and document it as "On =
shared memory, we will never indicate SWAPPED if the pages have been swappe=
d out. Further, PRESENT might be under-indicated: if a shared page is curre=
ntly not mapped into the page table of a process.". I saw there was a relat=
ed, proposed doc update, maybe we can finetune that.
>>>=20
>> We could take into consideration an alternative approach to retrieving t=
he shared page info in user
>> space, like storing it in sys/fs instead of per process. However, just l=
eaving the pagemap functionality
>> incomplete, and not providing an alternative to retrieve the missing inf=
ormation, does not seem right. Updating the docs with a "can't do" should b=
e temporary, until an alternative or fix.
>=20
> As I stated before, making pagemap less broken is not a good idea IMHO. E=
ither make it really correct or just leave it all broken -- and document th=
at e.g., other interfaces (lseek) shall be used. It sounds like they exist =
and are good enough for CRUI.
>=20
> And TBH, if other interfaces already exist and get the job done, I'm more=
 than happy that we can avoid mixing more shmem stuff into pagemap and tryi=
ng to compensate performance problems by introducing inconsistency.
>=20
> If it has an fd and we can punch that into syscalls, we should much rathe=
r use that fd to lookup stuff then going via process page tables -- if poss=
ible of course (to be evaluated, because I haven't looked into the CRIU det=
ails and how they use lseek with anonymous shared memory).

I found out that it is possible to retrieve the fds of shmem/tmpfs file all=
ocations
using proc/pid/map_files, which is neat. Still, CRIU does not seem to care
whether a page is swapped out or just empty, only if it is present on page =
cache.
The holes that lseek finds would not be able to infer this difference, AFAI=
K. Will
test the behaviour to make sure.
>=20
>> Also, I think you are talking about my own doc update patch[3]. If not, =
please share a link with your
>> next reply.
>> [3] https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__marc.info_-3F=
m-3D162878395426774&d=3DDwIDaQ&c=3Ds883GpUCOChKOHiocYtGcg&r=3DrRM5dtWOv0DNo=
5dDxZ2U16jl4WAw6ql5szOKa9cu_RA&m=3DT9yjhM3vhL_Ip2wxg2x-BZclbbY3WAO5Oc-y7IqN=
s7Y&s=3DHujDmGVIi1iXQ22oWF_GE-sPxvQ2ORTcCWEfnpqq35o&e=3D=20
>=20
> No, that's it.
>=20
Great, I'll head right there.

--
Kind regards,

Tibi=
