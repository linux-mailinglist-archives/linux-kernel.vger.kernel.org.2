Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF3363CED05
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 22:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352487AbhGSRlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 13:41:42 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:27808 "EHLO
        mx0b-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345150AbhGSQm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 12:42:58 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16JHCm4n010716;
        Mon, 19 Jul 2021 10:23:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=obgY/s5oiudGHNeEQKYS9tPlkRS9xKG61gG/AyAMAzs=;
 b=b1ONvR/aEjE1eH9X3PVLbPeuKge2+NtLGLpjhYeMe3MFGBgfFiVg3scvU4TDrAjnjV1j
 2VIqlcjzVlPQaZKrppi1KeJq/BgDEpnRHsiqm4bFpshnxU6HaKlv+oNx4Z7u/km2jNVE
 90MzzdvC/vKIWd5k/4MG8zKXjweHpWJbkPGtXfb3ujpUDQD3/Z/AKGZoFXFbObqgvTLH
 d78KOq1z1tZpoiHuvT4rbpfeoeuIou5II1+BvVFDyqKl0V0ottC7k8F8ZLWpiFOrD8ZY
 uz4zYmESoOr4BYBgKU+npf2Autv1gZNk0J43yPKAWcdl8nWF8wFtuSYpeVMRbvkB3Xkk oQ== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by mx0b-002c1b01.pphosted.com with ESMTP id 39w6ueru4v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Jul 2021 10:23:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SDgc7n7jK4VZOmQfGxAKPGFkCkDGffdIzMaDyQ3rjj9BsUYx4ps1O3w3v97mBoNIGbGhi6q3U7qzax6uOCmKX1dQSRwWkdBNmGouyGBJWHCEd3/agym3mmOyublegIES1Uc2HGDBms7KFBCXMM6vrFm70MgqPAJOB6ScO/S1KsxumfXKaC9w2yBtHQA448GkV4yNuBlPZiMQvG9GPPt7OdVDxmV2/Qp3O/KYjkusmk1Tsuidu+72P9gjndiyeUWY5lreZI2AAjEr20cAQj1XKtBXI3SJGPkaJd+9O3pb7JUOUOPvzMPkdcipoiegl2IIqWkeHSnsWJDJ6tzLf9GvnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=obgY/s5oiudGHNeEQKYS9tPlkRS9xKG61gG/AyAMAzs=;
 b=Lsa4l1MXb7tmKcOz+8BZQNOj7YF9OkbJa7KgvGCaRGMFVnUJk9Zo/J3pF9pA/qOobjP19RQqhZlNXMX32f/TDPYl0uI3hMjH6lV9yzp22ry61e9G60RB1COJizd/MieeegZq2KT/pE2xkAOmTsPegW6cV0xvBAtjpsaYTQ/rVf/nMN3AKidq9GIyEGKiatxebxrzN8iCXXJ63bA1WZuIVXae6S+TJJ2THLao2k5iWqXfwyPW8Cfw8HNXf/XorcTCF0T6VEtmjgK4yja00IqRFXehU5f/y+LI2RSwILeHJcA5uZu75RvaCARUuzLon7e++xb/ulmtjcVhyJFNe+IAeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from DM6PR02MB5578.namprd02.prod.outlook.com (2603:10b6:5:79::13) by
 DM6PR02MB6906.namprd02.prod.outlook.com (2603:10b6:5:257::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.22; Mon, 19 Jul 2021 17:23:14 +0000
Received: from DM6PR02MB5578.namprd02.prod.outlook.com
 ([fe80::159:22bc:800a:52b8]) by DM6PR02MB5578.namprd02.prod.outlook.com
 ([fe80::159:22bc:800a:52b8%6]) with mapi id 15.20.4331.033; Mon, 19 Jul 2021
 17:23:14 +0000
From:   Tiberiu Georgescu <tiberiu.georgescu@nutanix.com>
To:     Peter Xu <peterx@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Alistair Popple <apopple@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        "Carl Waldspurger [C]" <carl.waldspurger@nutanix.com>,
        Florian Schmidt <flosch@nutanix.com>
Subject: Re: [PATCH v5 24/26] mm/pagemap: Recognize uffd-wp bit for
 shmem/hugetlbfs
Thread-Topic: [PATCH v5 24/26] mm/pagemap: Recognize uffd-wp bit for
 shmem/hugetlbfs
Thread-Index: AQHXebZmBTPHtO67e0+5F2gnOfKvWatKFHUAgABnSwCAABZVAA==
Date:   Mon, 19 Jul 2021 17:23:14 +0000
Message-ID: <D2FD5D85-BA6D-492E-801F-E5003452DA70@nutanix.com>
References: <20210715201422.211004-1-peterx@redhat.com>
 <20210715201651.212134-1-peterx@redhat.com>
 <A83FCF8F-193E-4584-9442-C95B2635FD03@nutanix.com> <YPWiRsNaearMNB2g@t490s>
In-Reply-To: <YPWiRsNaearMNB2g@t490s>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nutanix.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ecf8ad84-ace9-4423-585d-08d94ad9e44a
x-ms-traffictypediagnostic: DM6PR02MB6906:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR02MB6906B6D20432273032925743E6E19@DM6PR02MB6906.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mYDade/ZJoso5bRpAckGEz8wyVonG9vHQmy7kd4cK06xBEMCX+MPgLTC+4sKdPACfM34jz6NUJMmWrG4ko9C6Iyw4XjcBIylf/T2rtkirBz9CGzylzDVtjVY3JP6GQjrme2ycc2agXp6GxWVjK/rUGOd7B9FWjPqem0kt8aErpmAnBPm2GxuC84RNEKtTnWbL31kl2jbqIMhjcKpBjjb1ieLRWfY/MF/wOBtLRmESHT0VcQh0XqLE2HZy2n6K4ezdzbd2hq3PjZDJ0k6Yf+JfqiiL/YoXkGqgPB85lf7jwoByHu2HAH7NUQFmHOCiKF2WX8UmH+0IRTCpVc8gQW66ZiT6/l/jQ0IovtgyR25XHEnz1hDNll5x7CXI8HyuP4ZiWEJ390bhZlTANq4u7pOyCiIqIa3lJa7gP48UYvTd5zRbdSrdIPPZSrhNv2TK5xeKzdR1AQ6BztT0RBRRyEPQkYO/CT8Lcsd0dPBULQXx29PEZIFFowRsT5F83nNQIzNv7ccicQUFb1r65kzsUDZKTwidUsEU0Sr1bc2khZqXQYMbrizOg7UrSjUXa32l7H2zUrhZtuKL+lFnxrcKIdJyNPJIWSccmHRzz+fpUx6SlEWh+oh0N7Z/nW+IT34o097UlPN8U1IEuH1TK8mpH4rh1UTvbFlIa/+Uhx9mUnFvC/+MrQV2PHm0RAEXEuXnLeZ670LeN+Ie1zqFS736zVFmrnIqFFIxrTAns3kDo0GHEg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR02MB5578.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(366004)(136003)(346002)(39860400002)(8676002)(6916009)(33656002)(54906003)(6506007)(316002)(36756003)(7416002)(186003)(8936002)(83380400001)(44832011)(86362001)(4326008)(91956017)(76116006)(53546011)(478600001)(2906002)(5660300002)(6486002)(2616005)(122000001)(107886003)(38100700002)(66556008)(66446008)(64756008)(6512007)(66946007)(71200400001)(66476007)(38070700004)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?m/O48KeMQLHl1hfYOh4JHvmKNh6UXIf80AxLcoeFc/af3GSBO0+eg62GGfg6?=
 =?us-ascii?Q?abI8DD+92wqQp33OPhLfPP4pValMgM/lC0yCMd+ELuqs4ITX0xLTbonyMRKD?=
 =?us-ascii?Q?+YGUJB0BsTUX72mdETKdScvHtdXF0TpXKopaPCWTY4QYmfrKgWkdaOl4acrC?=
 =?us-ascii?Q?BkNnZpJWnAdwEZtwFZQeLFSWBajo/Ax2SecVuuy3XgETClvbkCKTpl74nXKd?=
 =?us-ascii?Q?NWIZ3YjkSveeck90ydrmltPQIQSHFC6ZzsOUXVTh8yOkzUpKRfwZej9QazbX?=
 =?us-ascii?Q?WtqaDtvi8I5Pad03Dp2P46/fd4GS9o9cfcDlinoey6vQpWFMf7oyWk/fS9yb?=
 =?us-ascii?Q?DyINysdqpqlV/q0efO0hULp5D9rb57dx/du7MDvd5MZB8maMgKARfHT3lLAr?=
 =?us-ascii?Q?WpWT4+a6ssdCLzhaJRMgUtXcJygMVThpFSK5Q39PJkpW//aMi1PS6+pwHLTW?=
 =?us-ascii?Q?ad5VJzDFRsizEpHwJicF+BpsVU/+YR0DeBkCuTZ2yp1DpMoFdWjqaeMyUjCy?=
 =?us-ascii?Q?k4qMxtlYG1t9NtHdVxPK2K1+QYovd7jXXKLmvyyH5E4hoAvGDRcbymIqtPIn?=
 =?us-ascii?Q?Sa71eEArE0NDuLbL+p+1aaWUP6xZEmwjQvA+VkfHT3HKWMhl93VS6suaSTmF?=
 =?us-ascii?Q?JH4XNSBOVfk1WUxnknOXfKQCRL8I7W1G6iHSR/p0GQqSPnoqZyz5hWXEgBQL?=
 =?us-ascii?Q?ZslV9QUAPkw0DV/AuwZFnYng5Mlw8KZcypDNN2HKA6FYUIHo6Gs/SA5ta+vd?=
 =?us-ascii?Q?Gi3673X0C01i6AcpOvPwVjdMlCby+SeuQSiMHrVaSflmggW8+2028rgHj0I9?=
 =?us-ascii?Q?YrTLmT4JPU9sj1kM4XcQaq5d4kbIIv1+Gn/NeDKOlXSGWbXK1qWc6f0M0Hxd?=
 =?us-ascii?Q?mhpAH1H9dNyGfxKkZIquM/PIXW1nV/vZiVCEbTIz2TA7pKopyVj9d3Bh0pDL?=
 =?us-ascii?Q?acagqHESpZxOOHLe0N4CKioBg/E2ln3UcfUIlteSnQK5oicRBEXFbZ8iQTpH?=
 =?us-ascii?Q?cWAG52fyL/8LyZ7sOGUGx/1rc7hbrTU9dNzfLTsBdG/1dW4vQPVdOZ2L+W7D?=
 =?us-ascii?Q?ghaaKzFYtFm8kJTrrcivrO/rT1DxbmP5BqVLWd+ZVee+ZjFAYa9yH5p9i4kc?=
 =?us-ascii?Q?P9l/ZXWRo1CO/NvkI3mHOghhEqp4ZbqFP2WNigZGMXKm52Xr97oLoZvYuvae?=
 =?us-ascii?Q?fowQ0tlusbcqoFrRGKVLTqDSFQANEnnm1nVzUsuC+waJQ97SUpT1BR6pY7/R?=
 =?us-ascii?Q?aFNEGIOfFt4RgiJI0QDkmdLr/15h1Bj35LmtfJvAyaWQVLTZICi3ndP7r8IL?=
 =?us-ascii?Q?0LyCoQtqAav3SRdWbWCRSifaeIont5O6EiD2+xyzizlFwYnjfWC/+/H+7sUR?=
 =?us-ascii?Q?5w+PFKxaObD/MLx0aLA6wRVDRJVW?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9E0A2EA3E08C4A4B97606EFA4FEBE24C@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB5578.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecf8ad84-ace9-4423-585d-08d94ad9e44a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2021 17:23:14.6972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B7h7bQ13ABDxW3ODjUgs6fNaHFc0gTSsW15rVsC7OdWKPttmwE++1cFOmnXPVp6KUnkHhOa/c97L9Sf5wSxUozP/0oym2amNZ65oHlVrsDw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6906
X-Proofpoint-ORIG-GUID: kL65nqyQ4lE9FNPWi_QRdZWrU8q0EySJ
X-Proofpoint-GUID: kL65nqyQ4lE9FNPWi_QRdZWrU8q0EySJ
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-19_09:2021-07-19,2021-07-19 signatures=0
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 19 Jul 2021, at 17:03, Peter Xu <peterx@redhat.com> wrote:
>=20
> On Mon, Jul 19, 2021 at 09:53:36AM +0000, Tiberiu Georgescu wrote:
>>=20
>> Hello Peter,
>=20
> Hi, Tiberiu,
>=20
>>=20
>>> On 15 Jul 2021, at 21:16, Peter Xu <peterx@redhat.com> wrote:
>>>=20
>>> This requires the pagemap code to be able to recognize the newly introd=
uced
>>> swap special pte for uffd-wp, meanwhile the general case for hugetlb th=
at we
>>> recently start to support.  It should make pagemap uffd-wp support comp=
lete.
>>>=20
>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>> ---
>>> fs/proc/task_mmu.c | 7 +++++++
>>> 1 file changed, 7 insertions(+)
>>>=20
>>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>>> index 9c5af77b5290..988e29fa1f00 100644
>>> --- a/fs/proc/task_mmu.c
>>> +++ b/fs/proc/task_mmu.c
>>> @@ -1389,6 +1389,8 @@ static pagemap_entry_t pte_to_pagemap_entry(struc=
t pagemapread *pm,
>>> 		flags |=3D PM_SWAP;
>>> 		if (is_pfn_swap_entry(entry))
>>> 			page =3D pfn_swap_entry_to_page(entry);
>>> +	} else if (pte_swp_uffd_wp_special(pte)) {
>>> +		flags |=3D PM_UFFD_WP;
>>> 	}
>>=20
>> ^ Would it not be important to also add PM_SWAP to flags?
>=20
> Hmm, I'm not sure; it's the same as a none pte in this case, so imho we s=
till
> can't tell if it's swapped out or simply the pte got zapped but page cach=
e will
> still hit (even if being swapped out may be the most possible case).

Yeah, that's true. Come to think of it, we also can't tell none pte from sw=
apped
out shmem pages (all bits are cleared out).

>=20
> What we're clear is we know it's uffd wr-protected, so maybe setting PM_U=
FFD_WP
> is still the simplest?

That's right, but if we were to require any of the differentiations above, =
how
does keeping another bit on the special pte sound to you? One to signal the=
 location on swap or otherwise (none or zapped).

Is there any other clearer way to do it? We wouldn't want to overload the
special pte unnecessarily.

Thanks,

--
Tibi

