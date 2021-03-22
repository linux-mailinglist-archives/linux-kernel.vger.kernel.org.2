Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 588CA343AE2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 08:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbhCVHsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 03:48:32 -0400
Received: from mail-eopbgr770053.outbound.protection.outlook.com ([40.107.77.53]:55255
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229728AbhCVHsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 03:48:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=np9OgNpo+wB0bbCA6C+xBlRsGgDB8CRKP9LqjSKmmuAmPFHMb5fRLkYq8Pob34QugaFOPOySPHqjsvFWfMNzk9JRPSLsUCZR2Ra10bqWvrvsPZgVOKBYlHROkWWicNQhIP5yipwkpY4us6iQxr9/OkxLma4PVpAEljtKSqXxmQEAIbAgI5lNS89Gki3ziaRpObmw1cnZgDOHwV+xBbkAKey1KhHHD1bk0haj0A9v0R2nRZkWB545niuheRyCSmtiJ6md+8HgFfki4Njv+aUzP65Vs0ELgAtZdihVb11jnhYj9D/JmnImA6I6g54gvOTVIwbLdeIcvJDCnlCF1iZtVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S2/XlEC8HKFSARSgLacW0LK2SGE785lVBTxU3wDC2Yo=;
 b=Yjk/MR+I561Xgg7xKjvIMYR0OYa5Xgk3XLtvedfb3JoKSj24p7pNDKeiUwtWg5Uuq6lpmwTFT8sr7Uw66yvaEb7EZ36lkDu+8tA0VhHyEhG9GjkHNl2I8MsYySxLh4c9xvu+DhGVhjOPkPr1gJ5stFYF16TYs1tnsCRug1GyRHGVMREHHOZuqVhH0Y1alGi+afLNQy9/7NpmeVUBOSs8jZ3Ex081iqAW2I2n+Xpi8MmVEpI8GyyW+RDdNU5YNx2k9pbdhX2AJz1+F+ypcq3USO/OOKal2VcNxVJIP/wyfmMvxc/CNs8OF4mk/ODXowZ5u8q7xr80VKeUCuFH5BbJag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S2/XlEC8HKFSARSgLacW0LK2SGE785lVBTxU3wDC2Yo=;
 b=kbuktm/wq0QNcDC2GPgQT/XCltHLBNLFtbBQ+GoS+aZA2MU424vpGcnENb7AyoE1PZ1oYVPtq6D0JzS+/Z+VSq6P9qyNJ5wSV5+rldGvPL4HdDrFjGmDFhGgI9wvHWTUNRhJfR+hfupplXzLcLMn/CZbDPtPkycoH3Io0pqNjUM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4782.namprd12.prod.outlook.com (2603:10b6:208:a3::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Mon, 22 Mar
 2021 07:47:57 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3955.027; Mon, 22 Mar 2021
 07:47:57 +0000
Subject: Re: [RFC PATCH 2/2] mm,drm/ttm: Use VM_PFNMAP for TTM vmas
To:     =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28Intel=29?= 
        <thomas_os@shipmail.org>, dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210321184529.59006-1-thomas_os@shipmail.org>
 <20210321184529.59006-3-thomas_os@shipmail.org>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <d49fad17-f515-d4f2-cef2-4108c8375747@amd.com>
Date:   Mon, 22 Mar 2021 08:47:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210321184529.59006-3-thomas_os@shipmail.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:e345:6f8e:fa4b:2c52]
X-ClientProxiedBy: AM4PR07CA0011.eurprd07.prod.outlook.com
 (2603:10a6:205:1::24) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:e345:6f8e:fa4b:2c52] (2a02:908:1252:fb60:e345:6f8e:fa4b:2c52) by AM4PR07CA0011.eurprd07.prod.outlook.com (2603:10a6:205:1::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.9 via Frontend Transport; Mon, 22 Mar 2021 07:47:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d7e13fc3-fa3f-4432-c0b5-08d8ed06cec5
X-MS-TrafficTypeDiagnostic: MN2PR12MB4782:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4782D56B30DD233D7F2F6FF883659@MN2PR12MB4782.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BN7a4MPcUYURNHQGCs+JmUKp7/MfN5OuBV1JmnJx+aC7iQbTMmi+bPlkryDeNylBmQDHJKpPVq8uoL+o6wInCtTcamo7q24waw4RFTZrBzsm9axb963dD8E8L+oJDcNIouT2WRE7ydPw0rXEklSLy7oe90p2hNxPWCuCIMoHYbJ3wWP9zNRu/f3khfGbcyDfbRn1+DWQ37wsfxUCZA7KXAjo0ExYwyPzm2Zt0Dnz4DMhlcxktOtRUBqchInPVdA/3obp7O+EJecGMQnS3Be3aKMpDDIkr4/GIJL+pYGtPeAqbrD7TiFBBNonT3JpU68AwjQatDkchjsrCu9fDZ9rPfDY47m1GTw0fHq0Rrw4H5rllrIeZWZLBUZTZqDXfc7pdGswm5S7qAOWPraPPWt4frSUjN+Lut7PVmV83hIo8EYroQa01EoePYweCwV+Ek17BsTMtdwM414bE6P7tcA1YBHUXkVNVv4eRltQUdqAA4+epdoS00xUam2kerFJfFC8yxDxE13s3PUwm4NQp64JUxplc2XC5j5wPz738Kf7kVP7u2JknL8l6ZyWCW2KGWPVY85Exui73SwPg8B57N2i/sOtpvZuxx/Q1ndXd19ZgAa6ugtNlwDzPK6w6PnNUEV2EcWGKXYtNur+xEzPYmf92uLhtepiwVkUzosJKAHaPuqu8actNDrksblvgtFPPSdV9XHYcgSBub3pXhzyLLiPM4eTs9NHUOio8hPmxXbWd2Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(6486002)(2906002)(16526019)(186003)(6666004)(66556008)(86362001)(52116002)(5660300002)(4326008)(54906003)(66574015)(2616005)(316002)(8936002)(31686004)(31696002)(36756003)(38100700001)(66946007)(478600001)(66476007)(83380400001)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WjJMN0pYNzc1aExteVFSSUVUQktiTkc2Ty91bCtTUVFUSXFrYWZvTHBKMngz?=
 =?utf-8?B?OHkyZlFRaXBGTUd2aFY1MW1xRlR1aEtNRlBSeUpOd3BYYmRrc1kxUk1vcGJW?=
 =?utf-8?B?TlJEbCtVdWhFT253ZGNGa3d0L0dTL3luNC8rbkZ2cXo3VkcrL0d3eENUMVY4?=
 =?utf-8?B?SGtLMVM0T3NwWVZ5RGhuRytLT1ZCNXpJa0RTTi96L1k1MUdZS3JCbUMzeWdV?=
 =?utf-8?B?dmdxNU1LQ1RPRlBORWhUSXQxU2xnUTlGQUtQMTlJZCtWMXJrK0FnNUs5M2dV?=
 =?utf-8?B?YkpvVHkwb29uL1RDRWxSb0IrS25PUWtwS1dUbGgvajBwRkRCY3ZXMFlyKzE4?=
 =?utf-8?B?LytlcHduTkFiY0VYUmRXYVNIV2hDQVFVNHlORTRZRkVZZEpwcG5ZZXlBbGNv?=
 =?utf-8?B?RzlKZW9BaFNyTjUzY2IxbS9ablJqSGFZNDVGc0g2dVQ3QWpmSWtJb21Salh6?=
 =?utf-8?B?eDY4SDVyZHZOKy9SeDJnMXZwMHVkdURkSTJMbjNtdjhVNTdpbTEwRWlBc3NL?=
 =?utf-8?B?eDZuS2tVU2Z2VUl2TzNLZVl2QWFuc0xzSXhFYjdqS1lyYkw4Z3RTUkVGMXdQ?=
 =?utf-8?B?dzdZT3NsZUxQdlhyZXQ3VkUyNHZPbDQwYnlZZXpSbjZwcXJMeVNjTlhIeUc1?=
 =?utf-8?B?WEhsSEw3K2g5M2NYRDVNYXBkT1RIVHgxTm0rYVJKMnlsZjkwZVhmeldpb1lE?=
 =?utf-8?B?UlRSNFV0RGsrTS9ZSEw2VFZ3alc5bW11QThUN1puOFg2dS9nMW9EdTY2OFpj?=
 =?utf-8?B?YjlIdEZuU29rcDl5d1M4aTJqVWJNdVlZRHhCNTJiNGRXZjA2VXp2MkdEZkVE?=
 =?utf-8?B?c2xtVTZndy9HMFNoOEtNTkZvb3NlQkUrc0dqODBTZ1hOWng2cDRaaDloMVJO?=
 =?utf-8?B?QmZadVJYVlBGb1Y2dlZUYlNmTmgzOGdob3h2SHFvTVk0SE5tZHFsZitVWk1l?=
 =?utf-8?B?SDRQT0haNVRicE9yT3ZReUtSSExGWHNrek9aODJpeTZDc2lxTEs2Nmw5MGlm?=
 =?utf-8?B?emx6bmxqaitjZERMWG1EVHR4K1dqYkNZVXZ1L3RPYWlFckczMUEvUlYvOHU5?=
 =?utf-8?B?NHF4cVo5aUkyMGJFSmlpeHRtb0xKTTBDT2pOcUxrT2NYQmQ2dUhma0d1VHJM?=
 =?utf-8?B?TE55eElxd29taitFMXE2SCtHSWZidDcxSWJ5amQ2WHZZNnRyQllCMVU2aXBs?=
 =?utf-8?B?K2hsQTZ4QUkzUldwSkhiMUh0cFBCOFRJUjBCUzZKWlB2YnlUNDYxcWh4RHp5?=
 =?utf-8?B?dmtOT0xpMXFVMVJKclFkbHBhWDNHUTJGUEZ4bGozVGdGOGhqT0RvbXBDOVpp?=
 =?utf-8?B?cVFITmEzMTJGOWtpYnZ4VHMrSElxOUo4SWhaV2FhWE00Q1IvZGFKT2hGaTRE?=
 =?utf-8?B?ckJUeFpMZ3pYOWFpcHpteEpJeUJwemFaUm41bXNTQVEvaFZtM1lCSWZPd3JE?=
 =?utf-8?B?UUxwRHo5dFhrT09FaFAwMjBwRHZvY2hFdGNGOS9SalNKVWhMRFJ2YW5pRHdp?=
 =?utf-8?B?Tmk5Mk0vUExVNjBFaWN2ZE1SeUdmQjBTb2VuVHNjeHNrTWZtWjNpbzkwZmli?=
 =?utf-8?B?THZ3N2pmbzZtYnVGQkFLMVh6RUd0R2pvbHRLQlB4S1E3a0JEY3daaTdCdktS?=
 =?utf-8?B?aDNxS2ppWEJoRFZpYUN6WEltcW95aUVtVnhITzhQanNBSGNvUnpVNU9aY2dl?=
 =?utf-8?B?dXpRMm1TYkp6LzBqK2RjTTZwMjNsYnErQU5kRUc3UlpxdDRRWWJsRlduZmRU?=
 =?utf-8?B?Z3hLUWZLWGgxQlMrSDc5ZnVOQWoxeWxUaDZCOU9DaG5sOThWeHNwTnFsTi9P?=
 =?utf-8?B?V0ordlREbmh1b1JFNXpOeWtaMTRnWmY0aGs5WjZKTnNsbUh0UkppY0g2cG5y?=
 =?utf-8?Q?zJ4usjshRj7lD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7e13fc3-fa3f-4432-c0b5-08d8ed06cec5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2021 07:47:57.0816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hbKgCOKgpwovKhgPbUa06LwAC6h2AWzy0dVEYs7KKdFkyggI0j+cO3pYm/ooCBKt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4782
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 21.03.21 um 19:45 schrieb Thomas Hellström (Intel):
> To block fast gup we need to make sure TTM ptes are always special.
> With MIXEDMAP we, on architectures that don't support pte_special,
> insert normal ptes, but OTOH on those architectures, fast is not
> supported.
> At the same time, the function documentation to vm_normal_page() suggests
> that ptes pointing to system memory pages of MIXEDMAP vmas are always
> normal, but that doesn't seem consistent with what's implemented in
> vmf_insert_mixed(). I'm thus not entirely sure this patch is actually
> needed.
>
> But to make sure and to avoid also normal (non-fast) gup, make all
> TTM vmas PFNMAP. With PFNMAP we can't allow COW mappings
> anymore so make is_cow_mapping() available and use it to reject
> COW mappigs at mmap time.

I would separate the disallowing of COW mapping from the PFN change. I'm 
pretty sure that COW mappings never worked on TTM BOs in the first place.

But either way this patch is Reviewed-by: Christian König 
<christian.koenig@amd.com>.

Thanks,
Christian.

>
> There was previously a comment in the code that WC mappings together
> with x86 PAT + PFNMAP was bad for performance. However from looking at
> vmf_insert_mixed() it looks like in the current code PFNMAP and MIXEDMAP
> are handled the same for architectures that support pte_special. This
> means there should not be a performance difference anymore, but this
> needs to be verified.
>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Cc: linux-mm@kvack.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Thomas Hellström (Intel) <thomas_os@shipmail.org>
> ---
>   drivers/gpu/drm/ttm/ttm_bo_vm.c | 22 ++++++++--------------
>   include/linux/mm.h              |  5 +++++
>   mm/internal.h                   |  5 -----
>   3 files changed, 13 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_vm.c
> index 1c34983480e5..708c6fb9be81 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
> @@ -372,12 +372,7 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
>   		 * at arbitrary times while the data is mmap'ed.
>   		 * See vmf_insert_mixed_prot() for a discussion.
>   		 */
> -		if (vma->vm_flags & VM_MIXEDMAP)
> -			ret = vmf_insert_mixed_prot(vma, address,
> -						    __pfn_to_pfn_t(pfn, PFN_DEV),
> -						    prot);
> -		else
> -			ret = vmf_insert_pfn_prot(vma, address, pfn, prot);
> +		ret = vmf_insert_pfn_prot(vma, address, pfn, prot);
>   
>   		/* Never error on prefaulted PTEs */
>   		if (unlikely((ret & VM_FAULT_ERROR))) {
> @@ -555,18 +550,14 @@ static void ttm_bo_mmap_vma_setup(struct ttm_buffer_object *bo, struct vm_area_s
>   	 * Note: We're transferring the bo reference to
>   	 * vma->vm_private_data here.
>   	 */
> -
>   	vma->vm_private_data = bo;
>   
>   	/*
> -	 * We'd like to use VM_PFNMAP on shared mappings, where
> -	 * (vma->vm_flags & VM_SHARED) != 0, for performance reasons,
> -	 * but for some reason VM_PFNMAP + x86 PAT + write-combine is very
> -	 * bad for performance. Until that has been sorted out, use
> -	 * VM_MIXEDMAP on all mappings. See freedesktop.org bug #75719
> +	 * PFNMAP forces us to block COW mappings in mmap(),
> +	 * and with MIXEDMAP we would incorrectly allow fast gup
> +	 * on TTM memory on architectures that don't have pte_special.
>   	 */
> -	vma->vm_flags |= VM_MIXEDMAP;
> -	vma->vm_flags |= VM_IO | VM_DONTEXPAND | VM_DONTDUMP;
> +	vma->vm_flags |= VM_PFNMAP | VM_IO | VM_DONTEXPAND | VM_DONTDUMP;
>   }
>   
>   int ttm_bo_mmap(struct file *filp, struct vm_area_struct *vma,
> @@ -579,6 +570,9 @@ int ttm_bo_mmap(struct file *filp, struct vm_area_struct *vma,
>   	if (unlikely(vma->vm_pgoff < DRM_FILE_PAGE_OFFSET_START))
>   		return -EINVAL;
>   
> +	if (unlikely(is_cow_mapping(vma->vm_flags)))
> +		return -EINVAL;
> +
>   	bo = ttm_bo_vm_lookup(bdev, vma->vm_pgoff, vma_pages(vma));
>   	if (unlikely(!bo))
>   		return -EINVAL;
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 77e64e3eac80..c6ebf7f9ddbb 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -686,6 +686,11 @@ static inline bool vma_is_accessible(struct vm_area_struct *vma)
>   	return vma->vm_flags & VM_ACCESS_FLAGS;
>   }
>   
> +static inline bool is_cow_mapping(vm_flags_t flags)
> +{
> +	return (flags & (VM_SHARED | VM_MAYWRITE)) == VM_MAYWRITE;
> +}
> +
>   #ifdef CONFIG_SHMEM
>   /*
>    * The vma_is_shmem is not inline because it is used only by slow
> diff --git a/mm/internal.h b/mm/internal.h
> index 9902648f2206..1432feec62df 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -296,11 +296,6 @@ static inline unsigned int buddy_order(struct page *page)
>    */
>   #define buddy_order_unsafe(page)	READ_ONCE(page_private(page))
>   
> -static inline bool is_cow_mapping(vm_flags_t flags)
> -{
> -	return (flags & (VM_SHARED | VM_MAYWRITE)) == VM_MAYWRITE;
> -}
> -
>   /*
>    * These three helpers classifies VMAs for virtual memory accounting.
>    */

