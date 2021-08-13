Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7BB3EB92E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 17:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243159AbhHMPWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 11:22:36 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:41032 "EHLO
        mx0b-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242850AbhHMPTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 11:19:10 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17DFHlT5001169;
        Fri, 13 Aug 2021 08:18:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=nspCT/WOgiCfl05pxrqHG0lxEALwEtPjF8tdWkT5y0w=;
 b=MubwpOkjG9He94VpwXXuj1j8W+VJtjKKAjjCG1Xu/HbiNs5sae2pJ7u66JnzELm4X/bI
 KjM0+hpnujAh1aFOcHYmkZZJYCXJ7qnpBKGzeU5btqdeKdzQcVoQcPJG3QxpS31Xi7+U
 ahSzeVOHUZcjIA2kWqnSjVHzHXU38fjzCwsqCLYuDp2QSYqzm5CWXHUO56149GYhwzsq
 WaOnAs0CpdbZIC6F45Q5BDHAPbXIUHt1oObsE4lVct5OcWS+1piuk3F/OUcarVGfMTgZ
 iGr/Yn/Bf5XzO3Uz4hO6HqcbxaB3L8YS9k5rLhL2OfXTCI6na+Sji6rm/JqxPezKGWLx /g== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        by mx0b-002c1b01.pphosted.com with ESMTP id 3ad6c3jd8h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Aug 2021 08:18:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WBhpvcVKv19rhu0NPrAcEblNdg5FY2ujaF6pdG0gzX20XF+QBrrR338SAPFZ1+z0tJxIH1eDOADlUtaXoUHOxu1ZLz1ie+VqMZcCD1Afb1sZDDTuSN7a+hrbHmgTBHy5IuxwPkEr5rBXensgCBrPZSzfesf5U5iopN7mVWDWBImOO3prp2Nl0ftSgT0IcXlNJPxU8+FGqt6B2D7uF0NBESCWLTzdiAsHZoO3kbW5ehPcuXfn709+5YUZHCk0EahO4L3fOS1XJ2TIo0c40oZXOKS4pJSs360kqZj8rkkyI+/k2cZswtdErWqJgHy0pPRy9tLMR1NDW9vt5tHi/HCLEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nspCT/WOgiCfl05pxrqHG0lxEALwEtPjF8tdWkT5y0w=;
 b=RIjcMdiJMO8U5YAKk/+Pgh0uLI1xblKog8AhHu3p5eRlq/j1ui3HCtlLJcCsqc9OH16234KFx/QCH71kaJan36aYJkN/zFG05jWdews6s6dP9r3ZDKOicQtkwzSApveXkV8Tbj2H765TUAAcqMU9dxfbHOP2L/dcOrHpHTfZ8F4WAIXSsCalcQbAHYBB2jyF/bZM9DaWuDwN3mBf7CvH86mkKF4C4TrHd/8YTZr75Ob2th5Jx1BRSseOYYRjIO+MGxQxCPgoq21c478PzfiWoW6+YBMzLwYfEhwwqi93efG6uvZaOT+l74QwXjxObjibAgkvaOPa9joIkvfDbLz6oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from DM6PR02MB5578.namprd02.prod.outlook.com (2603:10b6:5:79::13) by
 DM6PR02MB4812.namprd02.prod.outlook.com (2603:10b6:5:17::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4394.21; Fri, 13 Aug 2021 15:18:23 +0000
Received: from DM6PR02MB5578.namprd02.prod.outlook.com
 ([fe80::5116:80a5:77d9:fcc4]) by DM6PR02MB5578.namprd02.prod.outlook.com
 ([fe80::5116:80a5:77d9:fcc4%7]) with mapi id 15.20.4415.016; Fri, 13 Aug 2021
 15:18:23 +0000
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
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH RFC 4/4] mm: Install marker pte when page out for shmem
 pages
Thread-Topic: [PATCH RFC 4/4] mm: Install marker pte when page out for shmem
 pages
Thread-Index: AQHXizvk75H5GcOBbk6XpDvivARYyKtxlnAA
Date:   Fri, 13 Aug 2021 15:18:22 +0000
Message-ID: <C0DB3FED-F779-4838-9697-D05BE96C3514@nutanix.com>
References: <20210807032521.7591-1-peterx@redhat.com>
 <20210807032521.7591-5-peterx@redhat.com>
In-Reply-To: <20210807032521.7591-5-peterx@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nutanix.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ccd3d8d-409d-40d9-7e9a-08d95e6d972c
x-ms-traffictypediagnostic: DM6PR02MB4812:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR02MB48122220CB320674D6ECD41CE6FA9@DM6PR02MB4812.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q9c/sfAjmpASI2yFRmcJcqZy5Ya6dnp5+exYR6aI/0IDWkOQ81M5S4PttFXINk4pTpPdd+R0p1S0IbSjUN2Ln1jYvhdNkcILE59O4BUJgdmAMItKIKO4BJkiigrSykFT6Yl803Mck6rndfEsU8rr+lGYKXbHRiAWNPqjCYTh/MJR3UqWj3W0eP6HM3Z/8ssZDafMunDuxfVx7+wVYoyFPMNs8okQNveIrgNtumcfuvB+FYRDvMtrrNSRxR4nuv7LTYHRQ19BlZkeZcyoJ/0Gwwb4T983hVlEiX9L2HlbJI7H+Ox9hJPzDcIDsQGkChZd6In9+WviS5RZoWETL5xwKV04txMium5jmVWhtFxOOGHBxNhROcgOpHAGr/inJH1XcD+7xdD6oHYqK7keCi/ZDMgbvOZ1CHvQqB0DJg7+lKOXxe7PXYeQrE3K4kphRXqBpzltDYeUjOB8PNmzaOn3nRwPYahSXbm3jGx4EE1R3NwdM65QIvjIQ5BdnE/upmp1PSlUJ09tDJMdLuYLef2DfZFSjKIyPz1WplpMyIK3zP5yM10vQDaJO5PbsPyU4P/2wznqvO7kSo8KFmpdCvNeQ22L0fufQucj1GaceoA7+9z//bv/rBO6U+TzaNDY3JIPdK9V6I8WqG9y2+SdA8Yd5FL6CKpvvCutcoC29gPqsgCdpOrbm6ESWT0GrTWSbgxuyIcMQe1m0gAW5vLIQ2cBz83v6ZsyBpTs7DTREQJguYkXpjj/NWk5Ae6DaPABnt3xOcIGYR34++LrUHJKWLBQXgwfopZbgGsFUixb9iixKc+FfBBE+IfJ0zUwx1SnMWF0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR02MB5578.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(346002)(396003)(366004)(376002)(6506007)(53546011)(8676002)(7416002)(8936002)(478600001)(54906003)(71200400001)(4326008)(316002)(966005)(38100700002)(6512007)(36756003)(86362001)(91956017)(76116006)(2616005)(5660300002)(66556008)(66476007)(6916009)(64756008)(2906002)(38070700005)(66946007)(83380400001)(66446008)(186003)(33656002)(122000001)(6486002)(44832011)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XALCfOx+CMzpZDk80y0s4nFpynAJh7uQU87DO6z51wW83RDATrP4U7R9jJ9O?=
 =?us-ascii?Q?4N7VMLlDxlvodAuPkPyzDBNrlftTUUOjLOXuwXQ3MJWfMXpIjzuL3U4NHLe1?=
 =?us-ascii?Q?Gv02Rd8Vked3aX8SB14nh/yAzoR/uUbcVJYmEumKk4GpEbwwfC+NraBJaUYY?=
 =?us-ascii?Q?rNn5geo3wNNtvm7AdstVN4d58leQNjz/WT7lGX1RMk/uWGM3eMEX70bzuIb/?=
 =?us-ascii?Q?+J5HsCrFr6hPlLtRiFKgDf/sHDuBOSjFlFa4FjuJP9Zk/+7V3KCaL6KA/uJK?=
 =?us-ascii?Q?wQUcZGJx0B4qNWwNfEqpwlbUn8YcmgbcBRRl5OOVOanO0bwxjBCNibk7SCFJ?=
 =?us-ascii?Q?KQD9iZ8yozb+BA2uzPf7pAcyHdlC0xogQ+wcIsIbvBvPf4bsmeV7B7QyNDgu?=
 =?us-ascii?Q?YVAwuN6rX7WlyP+5NihJWRkkP1OlmABi/GHl4qvFFxti5fyGGHApLEjuqbD4?=
 =?us-ascii?Q?EQnyL9lmvSar30mfq0IKEfRlQxJHhM3u7625bjYHa9BFQtB4InqSWXkT2adl?=
 =?us-ascii?Q?P4ygJft09mL2fc+9tFhdgPsC8cJmgX2CpdTPxv+/1sP0Gi2JaFynA8jrYc7V?=
 =?us-ascii?Q?s3edD9o2joZ0wYX2k7JubpEEJDJCu7xJc3x8/wP45XlKZ8V7az5xpP+3ZgDx?=
 =?us-ascii?Q?n0Wlgv20eGmp2DmfmsMgqtWFKTPSMzhkt9cDmUtIvNX9TUQ+YxNpQEwp5cAX?=
 =?us-ascii?Q?sR9HyPPrPjrgRFqWsgV7I+3E1GUtqFEXGK9+UwPEqEiflSpZlo7UyC0xJLwh?=
 =?us-ascii?Q?sXkZPB1Vsnq0E2Ow2azOiUz3Bg3uWLniLN/5HyMGQjsyOAlZvcbUN8gvG5kV?=
 =?us-ascii?Q?Bw/+7Ns5JOf98qo6Rg6FbAqwI6yNekQ1K5jvEqZJ/9clzF05Wpc0CtV5bJmZ?=
 =?us-ascii?Q?RXB+6QkTXVaK8JpqCSwCVRtukGX7UfVmcwjUtQAjp1L9GPf8YnBMNKmWO25V?=
 =?us-ascii?Q?2D8ms939QwOdyXupjd74CE+qGRDB8mIWahiaL6BMrjmYMW2hm/e5NYgzD5uF?=
 =?us-ascii?Q?jtQE4oow+fLIhGiu/x8mWEQYW9Z6ToqGd0F4KJxJd9Od7c3whZOF8G/YHPW8?=
 =?us-ascii?Q?0MFyUI6ntNFu+kB1Djxf13qutRW+G0AffbiOE7GcdG6eDcFfQOUJnxJYuB3P?=
 =?us-ascii?Q?puA5NaK1vUvg0bsG9Wk+WnMCylYnNOgopQPYT55xKUlj0I3VGNPpr5Iuh6Ky?=
 =?us-ascii?Q?dLUKUAOJnTNWg+y1taUHI1yJ17PeonaiBfsn3OYQIuWKJhZiRGwu7w01fMYo?=
 =?us-ascii?Q?Km9NTrC128Vv84wUFnwuyGF0mWAAe8eMSDVo+zVe6nebhN0Z4o2/6QRUyHYl?=
 =?us-ascii?Q?pEAF8RlWuWJYf8fnB+uoV+CIEa4ku4hC8P9UEG7qEp1BJm8SpfQ65ZRETRc/?=
 =?us-ascii?Q?f7O7NzqzOhoqYuQvskMM+GsNPACK?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D15C31F9E80D8C4CBD707979F1B3BB46@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB5578.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ccd3d8d-409d-40d9-7e9a-08d95e6d972c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2021 15:18:22.9568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EGreN+7K6EcZdDxQDRjQfNkMFOvo0UaF+P3sh8idNkEG/DmDch8b35C4tmaVRHQGElFBm0ymd4k++d4WyWEPpYVwBdXCdLACqVzQ1LgkxAo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4812
X-Proofpoint-ORIG-GUID: xLDAk5lHsU77TOr_d7jOv3ZVjhPAKa1N
X-Proofpoint-GUID: xLDAk5lHsU77TOr_d7jOv3ZVjhPAKa1N
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-13_05:2021-08-13,2021-08-13 signatures=0
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Peter,

Sorry for commenting so late.

> On 7 Aug 2021, at 04:25, Peter Xu <peterx@redhat.com> wrote:
>=20
> When shmem pages are swapped out, instead of clearing the pte entry, we l=
eave a
> marker pte showing that this page is swapped out as a hint for pagemap.  =
A new
> TTU flag is introduced to identify this case.
>=20
> This can be useful for detecting swapped out cold shmem pages.  Then afte=
r some
> memory background scanning work (which will fault in the shmem page and
> confusing page reclaim), we can do MADV_PAGEOUT explicitly on this page t=
o swap
> it out again as we know it was cold.
>=20
> For pagemap, we don't need to explicitly set PM_SWAP bit, because by natu=
re
> SWP_PTE_MARKER ptes are already counted as PM_SWAP due to it's format as =
swap.
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
> fs/proc/task_mmu.c   |  1 +
> include/linux/rmap.h |  1 +
> mm/rmap.c            | 19 +++++++++++++++++++
> mm/vmscan.c          |  2 +-
> 4 files changed, 22 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index eb97468dfe4c..21b8594abc1d 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1384,6 +1384,7 @@ static pagemap_entry_t pte_to_pagemap_entry(struct =
pagemapread *pm,
> 		if (pm->show_pfn)
> 			frame =3D swp_type(entry) |
> 				(swp_offset(entry) << MAX_SWAPFILES_SHIFT);
> +		/* NOTE: this covers PTE_MARKER_PAGEOUT too */
> 		flags |=3D PM_SWAP;
> 		if (is_pfn_swap_entry(entry))
> 			page =3D pfn_swap_entry_to_page(entry);
> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index c976cc6de257..318a0e95c7fb 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -95,6 +95,7 @@ enum ttu_flags {
> 					 * do a final flush if necessary */
> 	TTU_RMAP_LOCKED		=3D 0x80,	/* do not grab rmap lock:
> 					 * caller holds it */
> +	TTU_HINT_PAGEOUT	=3D 0x100, /* Hint for pageout operation */
> };
>=20
> #ifdef CONFIG_MMU
> diff --git a/mm/rmap.c b/mm/rmap.c
> index b9eb5c12f3fe..24a70b36b6da 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1384,6 +1384,22 @@ void page_remove_rmap(struct page *page, bool comp=
ound)
> 	unlock_page_memcg(page);
> }
>=20
> +static inline void
> +pte_marker_install(struct vm_area_struct *vma, pte_t *pte,
> +		   struct page *page, unsigned long address)
> +{
> +#ifdef CONFIG_PTE_MARKER_PAGEOUT
> +	swp_entry_t entry;
> +	pte_t pteval;
> +
> +	if (vma_is_shmem(vma) && !PageAnon(page) && pte_none(*pte)) {
> +		entry =3D make_pte_marker_entry(PTE_MARKER_PAGEOUT);
> +		pteval =3D swp_entry_to_pte(entry);
> +		set_pte_at(vma->vm_mm, address, pte, pteval);
> +	}
> +#endif
> +}
> +
> /*
>  * @arg: enum ttu_flags will be passed to this argument
>  */
> @@ -1628,6 +1644,9 @@ static bool try_to_unmap_one(struct page *page, str=
uct vm_area_struct *vma,
> 			 */
> 			dec_mm_counter(mm, mm_counter_file(page));
> 		}
> +
> +		if (flags & TTU_HINT_PAGEOUT)
> +			pte_marker_install(vma, pvmw.pte, page, address);
> discard:
> 		/*
> 		 * No need to call mmu_notifier_invalidate_range() it has be
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 4620df62f0ff..4754af6fa24b 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1493,7 +1493,7 @@ static unsigned int shrink_page_list(struct list_he=
ad *page_list,
> 		 * processes. Try to unmap it here.
> 		 */
> 		if (page_mapped(page)) {
> -			enum ttu_flags flags =3D TTU_BATCH_FLUSH;
> +			enum ttu_flags flags =3D TTU_BATCH_FLUSH | TTU_HINT_PAGEOUT;
> 			bool was_swapbacked =3D PageSwapBacked(page);
>=20
> 			if (unlikely(PageTransHuge(page)))
> --=20
> 2.32.0
>=20
The RFC looks good to me. It makes it much cleaner to verify whether the pa=
ge
is in swap or not, and there is great performance benefit compared to my pa=
tch.

Currently, your patch does not have a way of putting the swap offset onto t=
he
entry when a shared page is swapped, so it does not cover all use cases
IMO.

To counter that, I added my patch on top of yours. By making use of your
mechanism, we don't need to read the page cache xarray when we pages
are definitely none. This reduces much unnecessary overhead.

Main diff in fs/proc/task_mmu.c:pte_to_pagemap_entry():
        } else if (is_swap_pte(pte)) {
                swp_entry_t entry;
                ...
                entry =3D pte_to_swp_entry(pte);
+               if (is_pte_marker_entry(entry)) {
+                       void *xa_entry =3D get_xa_entry_at_vma_addr(vma, ad=
dr);
                ...

For reference: https://lore.kernel.org/lkml/20210730160826.63785-1-tiberiu.=
georgescu@nutanix.com/.

After some preliminary performance tests on VMs, I noticed a significant
performance improvement in my patch, when yours is added. Here is the
most interesting result:

Program I tested it on: Same as https://lore.kernel.org/lkml/20210730160826=
.63785-1-tiberiu.georgescu@nutanix.com/

Specs:
    Memory: 32GB memory, 64GB swap
    Params: 16GB allocated shmem, 50% dirty, 4GB cgroup, no batching

In short, the pagemap read deals with=20
    * ~4GB of physical memory (present pages),=20
    * ~4GB in swap (swapped pages)
    * 8GB non-dirty (none pages).

Results:
+------------+-------+-------+
| Peter\Tibi |  Pre  | Post  | (in seconds)
+------------+-------+-------+
| Pre        | 11.82 | 38.44 |
| Post       | 13.28 | 22.34 |
+------------+-------+-------+

With your patch, mine yields the results in twice the time, compared to 4x.
I am aware it is not ideal, but until it is decided whether a whole differe=
nt
system is preferred to PTE markers, our solutions together currently delive=
r
the best performance for correctness. Thank you for finding this solution.

I am happy to introduce a configuration variable to enable my pagemap
patch only if necessary. Either way, if performance is a must, batching is =
still
the best way to access multiple pagemap entries.

Looking forward to updates,
Tibi=
