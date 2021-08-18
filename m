Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 869823F0AC1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 20:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbhHRSD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 14:03:59 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:33724 "EHLO
        mx0a-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229448AbhHRSD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 14:03:57 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
        by mx0a-002c1b01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17IHakIp017154;
        Wed, 18 Aug 2021 11:03:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=G/MU/CnAdk/i4IPOAFfm1QLbeQfEaU4VFq0jbdwKbWs=;
 b=krK/udp0EOqimCutTck0WvBcrIC6YoHJvLJr63QSkc8cfG78KRfAuQmvNNo/yfyXF9LK
 SX1JaQT3RYQjCIMhQVMbvKz9l1+qg4S7pdE0vwepnfOP+KjJZ1b+ETSZKs0exYOSPbsC
 kBHjFxps5khh2C5+AAMmg/ILFPk2bz9ZNYuyaZMONqgcI2QIHXYyGitTMjfCDfxZvRDb
 /spqanmEV1v0eeuocqPJ26LpaLAKfq24wub610kPRw8HuPnvz71kOK9wYf/jLH20qr7h
 Ivy2FX3ea8vA/eun02ngQrBytBSLMWALmN3Cn/9T5cW8H0hPIt0BPgOMqYVr6Ps6YNWw QA== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by mx0a-002c1b01.pphosted.com with ESMTP id 3ah6rtr1xj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Aug 2021 11:03:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lwFRyWby33DI+FRktNYAryH3hXrVUePKfCOP2yvm7xvdzoLAC9d+H3wGabtfYuJdTKdF+B5J5CmUU0mVmREuexZbQoNoMIVQ95TPhXAdy+kx4yiDXepYf3sZ+18w4SKYlWlIy9wc2j4HOoRc043Rm9/aHxEmgCGESUsIwJ7QAbvhwL3Bc5rpg5zgpbvVSQtTAvgWGTvuXuRKcDfqE7FHExdeTdl8Lk2FL8lYep1FvuVY7qBVL7Gw1na3rrI/ibFComhqp1n2JOxrxJ3XgE1pCGt0UKbPH880uX4DWEnDgYGDWhIIlaZEbOZ/wIsytaF/cbm1toSZuTI+oADR70ZhYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G/MU/CnAdk/i4IPOAFfm1QLbeQfEaU4VFq0jbdwKbWs=;
 b=DQbQh0CMdnsZK+UbrD8gN6jupdxqoSjrRuApw23CnSqQUbCi2rBz0aRKDWByMwOTeyGJHpdirSzyt4v6RPgQZb68StjxyLZ5byu//HxOPs3+c2ec8KcmgozGr3IljJdqlYEdWEjp3uJ91s7iqNLfYju2A2J7c0aUzqX81XOVBdk/OBZ6N3jf3A+rmhLb1szGF62l1F2BJp7R8wSdba0q1U/DYxssSPOwL2G9FVstpjTvkFIvPXvJKYM+WsgN2iiNBd+wdcUq/qfpW167ugyg63gfzmsan9d3Uofg7tO/HTv4TKiIXqQypi/r+KXgvlfqeeeP6cZpJXL4V2ZRPkcpHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from DM6PR02MB5578.namprd02.prod.outlook.com (2603:10b6:5:79::13) by
 DM8PR02MB8154.namprd02.prod.outlook.com (2603:10b6:8:1b::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.16; Wed, 18 Aug 2021 18:02:59 +0000
Received: from DM6PR02MB5578.namprd02.prod.outlook.com
 ([fe80::5116:80a5:77d9:fcc4]) by DM6PR02MB5578.namprd02.prod.outlook.com
 ([fe80::5116:80a5:77d9:fcc4%7]) with mapi id 15.20.4415.024; Wed, 18 Aug 2021
 18:02:59 +0000
From:   Tiberiu Georgescu <tiberiu.georgescu@nutanix.com>
To:     Peter Xu <peterx@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Alistair Popple <apopple@nvidia.com>,
        Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Carl Waldspurger [C]" <carl.waldspurger@nutanix.com>,
        Jonathan Davies <jond@nutanix.com>,
        Florian Schmidt <flosch@nutanix.com>
Subject: Re: [PATCH RFC 4/4] mm: Install marker pte when page out for shmem
 pages
Thread-Topic: [PATCH RFC 4/4] mm: Install marker pte when page out for shmem
 pages
Thread-Index: AQHXizvk75H5GcOBbk6XpDvivARYyKtxlnAAgAAMGwCAB/2KAA==
Date:   Wed, 18 Aug 2021 18:02:59 +0000
Message-ID: <92E38805-D138-45A1-8205-0138F92765C3@nutanix.com>
References: <20210807032521.7591-1-peterx@redhat.com>
 <20210807032521.7591-5-peterx@redhat.com>
 <C0DB3FED-F779-4838-9697-D05BE96C3514@nutanix.com>
 <YRaXZgBuoYX0sPhS@xz-m1.local>
In-Reply-To: <YRaXZgBuoYX0sPhS@xz-m1.local>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nutanix.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8fe9de0b-85d8-4625-138d-08d962726a1d
x-ms-traffictypediagnostic: DM8PR02MB8154:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM8PR02MB815441ABB8C698888E895491E6FF9@DM8PR02MB8154.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8AgGvSFTr90SuXyRLrEAzIH85lnR8UaAuSBIhQTAxfvw6sDQwyH9xslE4FsI8sTYp9DjBr2VyUVabNtb5rtkMgop9QvVoe8Wa3/PCaK2R4RNuRUsjTdyECxVJ78LbOcJeAipK048+3et8Tf3LRO/3EMYItLp4IUo9ZcLdpeq386GERi515gTksyAJ2TyoXi8EZHwmtKbNqGulIXbSXtzSEAlCe1Tcjm5cLDl9/9r2M5YrU54xZ/zuhjRXaI2qfsj4WPDrzG+76FvdznyB2j3kZCsPSAny+AJ2sHF204lb+E/JchzeujUOxjrprOy9FkVeB0todu0JuRJtAg6ZHUO7eK5KawGWjxIYpLamdX6oMXzBZ3mNaKAjZLX4ssdPoGVBQw8PmDaEb/aQRprgbwZzeWdkQhDkGWddz/esLhWHB7B4k0lxD1Ok/kMH39qQlRYzPN/wac/3bJ8CFR9IU6JDFxSwUydKCRNNiIiG9uwqhRUavUU/Xyo/GJTO013RJ8KobC0OROhwWqfUD7HNNczZblFBh1/9+ih1LPWbMsKJczYDYOUti0zp4FHY6qTuRFwJCKorUA9DagEDi5C7f5NFDqLqmOMlaqndjA0BAvSs58wuV+huPG0tRc1xEC7kcTDtHKSCSIsnNE+GLpNkTqy7fGhqD+HE+px3sJ5QCaaBWO048XHSeAC1MmObGXO5vQTDyNxqvRgBQWG03jVtf9i6k5vHI/A5NGPKVIQetReugOKb0H3tE7aWn61TwMsXZ1ie0eWbkq9GfAYyno2i+JIQfPwDgMrw/Ue2JLB7N0TFJLyJGwmUt6CdHbmfKbhGldA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR02MB5578.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(376002)(39860400002)(396003)(136003)(6916009)(2616005)(8676002)(33656002)(66446008)(76116006)(122000001)(478600001)(64756008)(86362001)(316002)(6506007)(8936002)(53546011)(38070700005)(966005)(54906003)(5660300002)(36756003)(6486002)(71200400001)(6512007)(83380400001)(38100700002)(91956017)(44832011)(107886003)(7416002)(4326008)(186003)(2906002)(66946007)(66476007)(66556008)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fOBbVDIGGjwzzNLcAP3Q4eoYeLFT+KtJiGowh176IBBrfKAma2bH8ESkqH4i?=
 =?us-ascii?Q?ilRA497Ini0YRRCaiI5UXplhmi/YWsjgI0Fnh+8LrHyEfQDSIGs1tEM/+9xT?=
 =?us-ascii?Q?7x0NuPxZRX1S5zy3jG/5teB6btnsiYsZkyNguENn1ssWGhUSzAxWB/TazFHi?=
 =?us-ascii?Q?v2X9+vqcjfBc9xbb6oUg+vgIKLjC9QatevlVu1nybiehhE0sbzFLdb1WSNCJ?=
 =?us-ascii?Q?Bu7CLoS/NBpajtNkgf43MFxTnaRWdVL/kSnqIxnHrHm0d8roC4IsIiEyKCkU?=
 =?us-ascii?Q?h+ec7nnECGzfVD2QWefMZSLeTUc8RBzJiec2TuaARPrje/9jAmJijioJ+Qbl?=
 =?us-ascii?Q?IVqY3lHix6vAr+XftUEPBwgRkgSy/4XeJlNiwPAgXEqIjzskiEzw24gtQup1?=
 =?us-ascii?Q?sm+aKWrm3Ppdknp1U9pG5eF7uk1EMRCclVSzdBZsUYp83e+gXsN8nwMYIB0t?=
 =?us-ascii?Q?O/FH/sXm9FyWXhgCt7MJ0opmY2zTNlAj5kBAIstYVdw4FeNbLMUCvxvrXz9H?=
 =?us-ascii?Q?3RD049w/hVq0b/aq/XjRGqglCuxuwrcquBE1GdHImERF5s4yrtwdikvGo75r?=
 =?us-ascii?Q?bSLrJ5A+k/+jxVIveU6l49bzFK2O/BI+QnBufhKBFQsd1RF9P1KZL2pqxa3Z?=
 =?us-ascii?Q?XsoXLHcB9yg5Ba8b5sxTLuug0CqI3X86v1YM+0bbQkOBfVIb3deJxbaoh4bN?=
 =?us-ascii?Q?MhP4hSPKqayfq4zr26F66E81F9/Au/cH+uAcVmSVPI2t2tk3Gbv0xk9d+7qI?=
 =?us-ascii?Q?PtLBChZRzo7AxdqUtdANrjaJq1M8sCFCNI9icm+1I+4oSS8qgT8lXSkkzWGD?=
 =?us-ascii?Q?/kJghTFyIz6XT3FWpSJEHlIM/SbBdZmPF+ZPbryAoVJlMvi3ZfnD0pEogFLh?=
 =?us-ascii?Q?Hw4g5vCvjDpax/EOeaGJmUATPgY01PFz+PA7yga/vNxvDPQevqQwmnBPM6Gl?=
 =?us-ascii?Q?vL6HrQsHaCf2c73HLAPYaIr/xiW4hi9K2dcDUoWqQN8SMrrkq8MU9Ce+dGpe?=
 =?us-ascii?Q?YJ2pIFhFiPAL1qogONXMKNMtdmp0Z6zqB4h1rtcRs5W3MiN/f6Lx85NTlfwk?=
 =?us-ascii?Q?t8P+9sCitNpVgtXHhSbxYUazuWBSYabY90Kku54ifBlqqzBudtQSzUblblvn?=
 =?us-ascii?Q?TjUCiaMsQy10EDEOssaZ2aBcc9wbVOOiD5q2hre6yMkAgv4T/wOLOHRAKMSy?=
 =?us-ascii?Q?xWqNzAz5bx/J8aR8nW5WVLP4I/+Eg3WBQwzRlfBiZ7g88hEBGv4lIUraIN+j?=
 =?us-ascii?Q?i/6Kkpzy2VHjf6mYJep9Nkgj0LYyfgwGc19u4VMqYaP5MMq1V62mYPE6EJxg?=
 =?us-ascii?Q?HxVke57oDSjgjNw7995oYrRrHPhQuWtLUj1ieBToV29PrjblMGI3f6CV2chU?=
 =?us-ascii?Q?IUP16YFHL0CQNsK7gPe4dZHtPrgf?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C2811362BDD5234AAEB96CE2FFF00EB4@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB5578.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fe9de0b-85d8-4625-138d-08d962726a1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2021 18:02:59.4800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IJFiUil0QrbRd2PiP+j+UJk9wKvqVrmKhF2/aH7QHXYQcweecveXcio7MufbO2y5VELo1VxVeoQjoBMbosqtrW9jQgVZF9zBJfviVs+v7XQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB8154
X-Proofpoint-ORIG-GUID: 987SEwYsT2a-i-dapUygQbqjI7m8cxhi
X-Proofpoint-GUID: 987SEwYsT2a-i-dapUygQbqjI7m8cxhi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-08-18_06,2021-08-17_02,2020-04-07_01
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 13 Aug 2021, at 17:01, Peter Xu <peterx@redhat.com> wrote:
>=20
> On Fri, Aug 13, 2021 at 03:18:22PM +0000, Tiberiu Georgescu wrote:
>> Hello Peter,
>=20
> Hi, Tiberiu,
>=20
>>=20
>> Sorry for commenting so late.
>=20
> No worry on that.  I appreciate a lot your follow up on this problem.
>=20
>>=20
>>> On 7 Aug 2021, at 04:25, Peter Xu <peterx@redhat.com> wrote:
>>>=20
>>> When shmem pages are swapped out, instead of clearing the pte entry, we=
 leave a
>>> marker pte showing that this page is swapped out as a hint for pagemap.=
  A new
>>> TTU flag is introduced to identify this case.
>>>=20
>>> This can be useful for detecting swapped out cold shmem pages.  Then af=
ter some
>>> memory background scanning work (which will fault in the shmem page and
>>> confusing page reclaim), we can do MADV_PAGEOUT explicitly on this page=
 to swap
>>> it out again as we know it was cold.
>>>=20
>>> For pagemap, we don't need to explicitly set PM_SWAP bit, because by na=
ture
>>> SWP_PTE_MARKER ptes are already counted as PM_SWAP due to it's format a=
s swap.
>>>=20
>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>> ---
>>> fs/proc/task_mmu.c   |  1 +
>>> include/linux/rmap.h |  1 +
>>> mm/rmap.c            | 19 +++++++++++++++++++
>>> mm/vmscan.c          |  2 +-
>>> 4 files changed, 22 insertions(+), 1 deletion(-)
>>>=20
>>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>>> index eb97468dfe4c..21b8594abc1d 100644
>>> --- a/fs/proc/task_mmu.c
>>> +++ b/fs/proc/task_mmu.c
>>> @@ -1384,6 +1384,7 @@ static pagemap_entry_t pte_to_pagemap_entry(struc=
t pagemapread *pm,
>>> 		if (pm->show_pfn)
>>> 			frame =3D swp_type(entry) |
>>> 				(swp_offset(entry) << MAX_SWAPFILES_SHIFT);
>>> +		/* NOTE: this covers PTE_MARKER_PAGEOUT too */
>>> 		flags |=3D PM_SWAP;
>>> 		if (is_pfn_swap_entry(entry))
>>> 			page =3D pfn_swap_entry_to_page(entry);
>>> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
>>> index c976cc6de257..318a0e95c7fb 100644
>>> --- a/include/linux/rmap.h
>>> +++ b/include/linux/rmap.h
>>> @@ -95,6 +95,7 @@ enum ttu_flags {
>>> 					 * do a final flush if necessary */
>>> 	TTU_RMAP_LOCKED		=3D 0x80,	/* do not grab rmap lock:
>>> 					 * caller holds it */
>>> +	TTU_HINT_PAGEOUT	=3D 0x100, /* Hint for pageout operation */
>>> };
>>>=20
>>> #ifdef CONFIG_MMU
>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>> index b9eb5c12f3fe..24a70b36b6da 100644
>>> --- a/mm/rmap.c
>>> +++ b/mm/rmap.c
>>> @@ -1384,6 +1384,22 @@ void page_remove_rmap(struct page *page, bool co=
mpound)
>>> 	unlock_page_memcg(page);
>>> }
>>>=20
>>> +static inline void
>>> +pte_marker_install(struct vm_area_struct *vma, pte_t *pte,
>>> +		   struct page *page, unsigned long address)
>>> +{
>>> +#ifdef CONFIG_PTE_MARKER_PAGEOUT
>>> +	swp_entry_t entry;
>>> +	pte_t pteval;
>>> +
>>> +	if (vma_is_shmem(vma) && !PageAnon(page) && pte_none(*pte)) {
>>> +		entry =3D make_pte_marker_entry(PTE_MARKER_PAGEOUT);
>>> +		pteval =3D swp_entry_to_pte(entry);
>>> +		set_pte_at(vma->vm_mm, address, pte, pteval);
>>> +	}
>>> +#endif
>>> +}
>>> +
>>> /*
>>> * @arg: enum ttu_flags will be passed to this argument
>>> */
>>> @@ -1628,6 +1644,9 @@ static bool try_to_unmap_one(struct page *page, s=
truct vm_area_struct *vma,
>>> 			 */
>>> 			dec_mm_counter(mm, mm_counter_file(page));
>>> 		}
>>> +
>>> +		if (flags & TTU_HINT_PAGEOUT)
>>> +			pte_marker_install(vma, pvmw.pte, page, address);
>>> discard:
>>> 		/*
>>> 		 * No need to call mmu_notifier_invalidate_range() it has be
>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>> index 4620df62f0ff..4754af6fa24b 100644
>>> --- a/mm/vmscan.c
>>> +++ b/mm/vmscan.c
>>> @@ -1493,7 +1493,7 @@ static unsigned int shrink_page_list(struct list_=
head *page_list,
>>> 		 * processes. Try to unmap it here.
>>> 		 */
>>> 		if (page_mapped(page)) {
>>> -			enum ttu_flags flags =3D TTU_BATCH_FLUSH;
>>> +			enum ttu_flags flags =3D TTU_BATCH_FLUSH | TTU_HINT_PAGEOUT;
>>> 			bool was_swapbacked =3D PageSwapBacked(page);
>>>=20
>>> 			if (unlikely(PageTransHuge(page)))
>>> --=20
>>> 2.32.0
>>>=20
>> The RFC looks good to me. It makes it much cleaner to verify whether the=
 page
>> is in swap or not, and there is great performance benefit compared to my=
 patch.
>>=20
>> Currently, your patch does not have a way of putting the swap offset ont=
o the
>> entry when a shared page is swapped, so it does not cover all use cases
>> IMO.
>=20
> Could you remind me on why you need the swap offset?  I was trying to
> understand your scenaior and I hope I summarized it right: what we want t=
o do
> is being able to MADV_PAGEOUT pages that was swapped out.  Then IIUC the
> PM_SWAP bit should be enough for it.  Did I miss something important?

That's right, PM_SWAP is enough for that use cases. However, there are
more optimisations we are considering for QEMU live migration that require
access to the swap offset as well. For one of those, we need a mechanism in
place to make a page's swap offset accessible outside kernel space. This is
where our patches would come in.
>=20
>>=20
>> To counter that, I added my patch on top of yours. By making use of your
>> mechanism, we don't need to read the page cache xarray when we pages
>> are definitely none. This reduces much unnecessary overhead.
>>=20
>> Main diff in fs/proc/task_mmu.c:pte_to_pagemap_entry():
>>        } else if (is_swap_pte(pte)) {
>>                swp_entry_t entry;
>>                ...
>>                entry =3D pte_to_swp_entry(pte);
>> +               if (is_pte_marker_entry(entry)) {
>> +                       void *xa_entry =3D get_xa_entry_at_vma_addr(vma,=
 addr);
>>                ...
>>=20
>> For reference: https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lo=
re.kernel.org_lkml_20210730160826.63785-2D1-2Dtiberiu.georgescu-40nutanix.c=
om_&d=3DDwIBaQ&c=3Ds883GpUCOChKOHiocYtGcg&r=3DrRM5dtWOv0DNo5dDxZ2U16jl4WAw6=
ql5szOKa9cu_RA&m=3DQsruIxW9oyVSF9YCw783f9XnUlbHz5DSUTClk6tXsoE&s=3D6WWxG1Nw=
Jf-GfMYNQgGIb0rCozmhWxHnTZaCL9cBrt4&e=3D .
>>=20
>> After some preliminary performance tests on VMs, I noticed a significant
>> performance improvement in my patch, when yours is added. Here is the
>> most interesting result:
>>=20
>> Program I tested it on: Same as https://urldefense.proofpoint.com/v2/url=
?u=3Dhttps-3A__lore.kernel.org_lkml_20210730160826.63785-2D1-2Dtiberiu.geor=
gescu-40nutanix.com_&d=3DDwIBaQ&c=3Ds883GpUCOChKOHiocYtGcg&r=3DrRM5dtWOv0DN=
o5dDxZ2U16jl4WAw6ql5szOKa9cu_RA&m=3DQsruIxW9oyVSF9YCw783f9XnUlbHz5DSUTClk6t=
XsoE&s=3D6WWxG1NwJf-GfMYNQgGIb0rCozmhWxHnTZaCL9cBrt4&e=3D=20
>>=20
>> Specs:
>>    Memory: 32GB memory, 64GB swap
>>    Params: 16GB allocated shmem, 50% dirty, 4GB cgroup, no batching
>>=20
>> In short, the pagemap read deals with=20
>>    * ~4GB of physical memory (present pages),=20
>>    * ~4GB in swap (swapped pages)
>>    * 8GB non-dirty (none pages).
>>=20
>> Results:
>> +------------+-------+-------+
>> | Peter\Tibi |  Pre  | Post  | (in seconds)
>> +------------+-------+-------+
>> | Pre        | 11.82 | 38.44 |
>> | Post       | 13.28 | 22.34 |
>> +------------+-------+-------+
>>=20
>> With your patch, mine yields the results in twice the time, compared to =
4x.
>> I am aware it is not ideal, but until it is decided whether a whole diff=
erent
>> system is preferred to PTE markers, our solutions together currently del=
iver
>> the best performance for correctness. Thank you for finding this solutio=
n.
>=20
> Thanks for trying that out!  It's great to know these test results.
>=20
>>=20
>> I am happy to introduce a configuration variable to enable my pagemap
>> patch only if necessary.
>=20
> Right.  We can use a config for that, but I didn't mention when replying =
to
> your previous patchset because I thought w/ or w/o the config it should s=
till
> be better to use the pte markers because it should be more efficient.
>=20
> However I think I need to double check I didn't miss anything that you're
> looking for. E.g. I need to understand why swp offset matters here as I a=
sked.
> I must confess that cannot be trivially done with pte markers yet - keepi=
ng a
> swap hint is definitely not the same story as keeping a swp entry.

I am well aware. Initially, I considered doing something similar. When I fo=
und out
there was already backend in place that keeps track of the swap location (i=
.e. page cache), I thought it was unnecessary to duplicate it into PTE, so =
I just
extracted it in the pagemap. This way, the overhead was only applied when
retrieving pagemap data, not over the whole kernel.

>=20
>> Either way, if performance is a must, batching is still the best way to
>> access multiple pagemap entries.
>=20
> I agree, especially when we have pmd pgtable locks things can happen
> concurrently.
>=20
> It's just that it's a pity the major overhead comparing to the old way is=
 at
> page cache look up, especially as you pointed out - the capability to ide=
ntify
> used ptes with empty ptes matters.  That's kind of orthogonal to batching=
 to me.
>=20
> Thanks,
>=20
> --=20
> Peter Xu

--
Kind regards,

Tibi Georgescu

