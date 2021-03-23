Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A30A3460CF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 15:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbhCWOBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 10:01:00 -0400
Received: from mail-dm6nam10on2075.outbound.protection.outlook.com ([40.107.93.75]:38881
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231673AbhCWOAf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 10:00:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JVJXkx7jgB0ja4yC4A4Ik4tOlmD5L8fBaBiJGNgXrPxw4gDsCYZ+IMwr5ee/PVUFLH8Y/52gqJpZRkz6t4+pN2n5ydOr4b7EY2AgZu8bFZvIurYnzgltZJGaGKWHM4w/UCKng7jOj2CeRAzNEyFiWq3bHNkA2R5ei5AjiqWwudsfj31lTZ9QmQwpy08398tZtHWmpDubkNK5001L/ZQuOgFgbs+PpM4X5pFftclDMQWuL6WLzUziVtnuBNQfZKjkNe8dPwAOksKvNlj/PFNzlWMzZrR9P6i9wT5PiOegDvTcK03XQeSy+hjg3+QqZMsbcWUX5woR6fqWR4cF71vdRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DHycayn9ix6vUCMv1LnAgZz4RkGDoqE1skPzhC1JoHM=;
 b=cUXARedwwJCQ6saWtC2j9//f1DwFJXbTuppo1ZUIVkUD9alUygKG64Fv0Y5iHZUCAQ0GW0wCsT+AGRXXLJNjbpvd/wtifclnY/9+98+9LbPvuLSNLzD5fw7IyR5UoL2M28wFkLphk3D/olTwbBVk8a1+3am7XD5WYRuK/ltD8o4ZTsoFQiGOLDz5mo4DkoyXn820ytuslbEd2dAuNXpyh4sS0wzw23X4ytqabMCM+pdXzuEcNZ0+WUTMwteAgexvepTY+tyzb80CSp34a84wWyGt5r3440JNvDFziv3xAIZzH2Sf3JHixcEyJDCh3DCqy76RAMlWr8ileqAXc+A9Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DHycayn9ix6vUCMv1LnAgZz4RkGDoqE1skPzhC1JoHM=;
 b=AJFePgLhGb+hoJ6m/IJMH4Nqh+EI1qBn4Y6VbSDTwVeU/vT7CNiPZZ+Xg8mPWoWLq3xWDmh/2HjezcJfIaG3ZrF7aCTIz/jdnHK6lsHF3hAYP5PY6ZZ7N1/yHH0Zw8Ve1ClRHQRNlRYH8hTclaBMofB9JA9T6V9chLq8pBeG+IWyIoNJjaaIhky8O8DirRRtXA5M2+Xg6wXem1GZr4nOgbxvzfxMCJGsB76R7qe+t8wCNiG66KlXK0njWcAos/QWBUuKOJcEPtVKzMsO+rTbdYVCj1yXG09okAuN+fMJieTfh2AqWr1+Dtw0DKN+FZJb13flI3TVz1iUWJRY7qB1jQ==
Authentication-Results: shipmail.org; dkim=none (message not signed)
 header.d=none;shipmail.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3116.namprd12.prod.outlook.com (2603:10b6:5:38::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Tue, 23 Mar
 2021 14:00:33 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3955.027; Tue, 23 Mar 2021
 14:00:33 +0000
Date:   Tue, 23 Mar 2021 11:00:30 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Thomas =?utf-8?B?SGVsbHN0csO2bSAoSW50ZWwp?= 
        <thomas_os@shipmail.org>
Cc:     dri-devel@lists.freedesktop.org,
        Christian Koenig <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] mm,drm/ttm: Use VM_PFNMAP for TTM vmas
Message-ID: <20210323140030.GE2356281@nvidia.com>
References: <20210321184529.59006-1-thomas_os@shipmail.org>
 <20210321184529.59006-3-thomas_os@shipmail.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210321184529.59006-3-thomas_os@shipmail.org>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: BY3PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::17) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by BY3PR03CA0012.namprd03.prod.outlook.com (2603:10b6:a03:39a::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Tue, 23 Mar 2021 14:00:32 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lOhaA-001Wl7-7n; Tue, 23 Mar 2021 11:00:30 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7af1a308-2e62-4254-3e73-08d8ee04067d
X-MS-TrafficTypeDiagnostic: DM6PR12MB3116:
X-Microsoft-Antispam-PRVS: <DM6PR12MB311620F3A993021D00512461C2649@DM6PR12MB3116.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sunbpQdh1t3+nHq3Fcr45x/60D8C8GSx1zvJsBDNAwZTe663cPYvY7g9b55S2YeF5OarhRQZdsHPKV5OHRRZpXrFcywXLJi+BdpZxxQpl4SoGZjBITcpp5AUX2hE3yR7A0kJHpdP7eafHQLfXr9A4dQWaBIq475TLenVWZvseeaku71l6v+nqekVcmpypLOTSkobG10ui+4mz6da2v6LD0jKaseJ57aLE8HXW4buWW8OL00BDlNUDj86LNNiR+J/6OVMizum1Fc7cdcOX9NX817u0NgpFpuB3cG4RAljBArd3fNf4DfftsZkEt+UMgHRQ8/NiO+gZsCN3VqbT/qWglTYHqIKJCgIg41mJPO1s7N+hg6CLX4bI92ZIxL1IbFS4nAH1LDwkO9PsDso//aDVxMHl5UioPRbpU6IAkXysbKIDx4+jRsUqqbcjwX8tQ4nn58DhhKPAsXzkMEvVQ/CGCbTXKZ8fh0Odwiyay7ippePjsGKhhiOhvnJPxZ8jylnrXDmKT0lqJtZn/4X9hyXckeW8eHUoumbEiRaUz4U+txtz1rovFXIo9bbwls+WE9Pgjcp4O6vNpNDgiYZ/DiPCREN8HS6WJ5WhpEP0efuhkz4U/N/2pDw1DbfKgNuM+k1H8hMS7ea06m08tUDgQo+jF22lT8Dfj3X9MQFcRqPqQ0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(366004)(39860400002)(396003)(376002)(83380400001)(4326008)(2906002)(6916009)(66476007)(33656002)(426003)(66946007)(8676002)(8936002)(478600001)(2616005)(66556008)(54906003)(9746002)(38100700001)(26005)(186003)(86362001)(5660300002)(66574015)(1076003)(36756003)(316002)(9786002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VTVKdElVRVVuNENCWFpaZHhlWERsUk9TZHg3VkJXSm5jdUQraEh4bG1KZGdF?=
 =?utf-8?B?UzVJRUdCUHM3bVZhdTdBbE5xNXY5dkNIQ1paVU9iYVFpUTBCaGpEanU5Uk5S?=
 =?utf-8?B?TE9WbkZsSUdrTVNaTlJORWxzQXUzcFJyVTF2TDRackFTU0tQenpGeEEyU3ps?=
 =?utf-8?B?MTVKUHhZUE5Cczh0RDJMMVFWOEc0ZWFEd0QyMHZPT0Ewd3FCQTBJU0syVi85?=
 =?utf-8?B?UkhqWGw5OEpaaU1TM1luYUhGR0xQbXVKVmEzYmZpMnVnUTR0RlFtNGJGZVlu?=
 =?utf-8?B?U1ZFakUzUVZCeEY0N2JZSUhUVlNmK0tZQXNJbjhLQUtVUmE3ZzVxbTBjMVJh?=
 =?utf-8?B?TUZpZ0RKOGJJc2x5dlBHL25zVGNaaFVMZERXbVNmVllYOVhMaWVWYnRvb1Y0?=
 =?utf-8?B?MDlvelA2cVVKdjNkdGlweGEramJyMVc3QWIzRWRPVVNZS1ZraVE4azllb0JY?=
 =?utf-8?B?cGRSYUJxdFZleGhHZFNaQnpzb3A2dDJJUmN4eStYYVVJWE9mQU1QN3FFMVF6?=
 =?utf-8?B?QjdBN05ZNytBdDhXZVlycFNWZXdoNmdEd2NPVlZreTdoNGFwbmNaT0ZJbnFv?=
 =?utf-8?B?Y09jNEsreitrWUFBY1FGZm4wUFBjbHA3YlJ2Q3Iwdmh3MTZ3Y3dBd01VVzNB?=
 =?utf-8?B?WmpjMmpndFZCWks5Q1BzcnMzVndOWXB6RWxxdTlhYmJiVlpnbkw1R0hIMzRU?=
 =?utf-8?B?TnFYOGFEdHY1QTJKblJObURMZlJGZGpDRi9IY3NYRjIwdnhIc3RGR0phQTBR?=
 =?utf-8?B?YmNqVHZrdWdIa2RsbEdSL2RxYkJXVTU4QVcwVmQ1OWpRREtOeEF4L2FxS2JT?=
 =?utf-8?B?NVhsMVJMRDR6WVdHSVJEclhKdTlhMDlNWkh1bjljcGxqNWp3QmdvZkNKMEc0?=
 =?utf-8?B?S2M1V0hub09yWkVvZWd2cDhvWHlhMDVjbEY4NzBPbjU5eWhmUUJLUXg2b1ZE?=
 =?utf-8?B?bEZwS3lndVlrY1B2MTV1b3dxbHJrb25kT2h3NkZLNlFlb1p5OUhycThqMGUz?=
 =?utf-8?B?NDBnaU1jbXkzaExaTys0dkgzK25WTkhRRS9oSWxVL2dWWlZWTFBHMnlCMGU5?=
 =?utf-8?B?cGh1OFRBVldaRklhVUFnVmI1UFIvWTNqVTI2Rm5vQVRvWHl1TW5rRlYwbmVT?=
 =?utf-8?B?RXpSdHZ2TFM2eGpUcC9VQVdmTmd2SjNITzF4RnJGdXkzOGV2NzhmQkZXeGRO?=
 =?utf-8?B?OUFSc3F4MHZCbzdvZWxQTWdBTTJRY2Z5VFRwa29EMCtyOWpxQWQvUEMrclFW?=
 =?utf-8?B?bENRTGN0MkVTL1JGOVJTd1ZtUkUyclZ5TnFpV2R6QzlSbUtYSDZmclZOVEFP?=
 =?utf-8?B?UFBrWnlFQnpucmhXZWNzNTVleVB5ZmpVNDA3eGlOa3hyamtURm16VGN1MkFn?=
 =?utf-8?B?QXVpOWsvVW93NGppZkhKbkMxTmxzdUZncDlWS01VUWRDdEVPU0s5ZG1xdXk2?=
 =?utf-8?B?MjNCRjBGYmJQT29kQmdQRVJoamZXajFZQm1WK1Y5ZkVBRnR3ckFrbFhzK1lv?=
 =?utf-8?B?SWM4U1ZEa3NRQk0rUXRpN2FKQzZjOXhuS1lDc2lYTG5BbU1mclEvcmsxSHZ0?=
 =?utf-8?B?ck5jWEtCSm9DNG04TzhUY25uWm1KQVhRVjJLNXZVazVMY09Ed1dmV0NvYmh5?=
 =?utf-8?B?akVkZlpZWWVuUWhvcTg5dWZsNnIzcnVCWVQ2cXJ6VDBFUE93NmxKWXl3Tmxy?=
 =?utf-8?B?ZjdPdUVraDV6NlRFeEM0cy9IQ2pTQVJNYXNCRmVFS2JSRTlOejFBa2FLeGVT?=
 =?utf-8?Q?tPYt1GgV0r+Hdqz7Oawwjwnq8rXyslJpEEmkhDD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7af1a308-2e62-4254-3e73-08d8ee04067d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2021 14:00:33.0645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QLRmUBpe0rLKwJVHgUZvumkd9lKevPqQEyxSVA7aTFTKesNxLwVo1+zCHq5apG/Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3116
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 21, 2021 at 07:45:29PM +0100, Thomas Hellström (Intel) wrote:
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
>  drivers/gpu/drm/ttm/ttm_bo_vm.c | 22 ++++++++--------------
>  include/linux/mm.h              |  5 +++++
>  mm/internal.h                   |  5 -----
>  3 files changed, 13 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_vm.c
> index 1c34983480e5..708c6fb9be81 100644
> +++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
> @@ -372,12 +372,7 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
>  		 * at arbitrary times while the data is mmap'ed.
>  		 * See vmf_insert_mixed_prot() for a discussion.
>  		 */
> -		if (vma->vm_flags & VM_MIXEDMAP)
> -			ret = vmf_insert_mixed_prot(vma, address,
> -						    __pfn_to_pfn_t(pfn, PFN_DEV),
> -						    prot);
> -		else
> -			ret = vmf_insert_pfn_prot(vma, address, pfn, prot);
> +		ret = vmf_insert_pfn_prot(vma, address, pfn, prot);
>  
>  		/* Never error on prefaulted PTEs */
>  		if (unlikely((ret & VM_FAULT_ERROR))) {
> @@ -555,18 +550,14 @@ static void ttm_bo_mmap_vma_setup(struct ttm_buffer_object *bo, struct vm_area_s
>  	 * Note: We're transferring the bo reference to
>  	 * vma->vm_private_data here.
>  	 */
> -
>  	vma->vm_private_data = bo;
>  
>  	/*
> -	 * We'd like to use VM_PFNMAP on shared mappings, where
> -	 * (vma->vm_flags & VM_SHARED) != 0, for performance reasons,
> -	 * but for some reason VM_PFNMAP + x86 PAT + write-combine is very
> -	 * bad for performance. Until that has been sorted out, use
> -	 * VM_MIXEDMAP on all mappings. See freedesktop.org bug #75719
> +	 * PFNMAP forces us to block COW mappings in mmap(),
> +	 * and with MIXEDMAP we would incorrectly allow fast gup
> +	 * on TTM memory on architectures that don't have pte_special.
>  	 */
> -	vma->vm_flags |= VM_MIXEDMAP;
> -	vma->vm_flags |= VM_IO | VM_DONTEXPAND | VM_DONTDUMP;
> +	vma->vm_flags |= VM_PFNMAP | VM_IO | VM_DONTEXPAND | VM_DONTDUMP;
>  }
>  
>  int ttm_bo_mmap(struct file *filp, struct vm_area_struct *vma,
> @@ -579,6 +570,9 @@ int ttm_bo_mmap(struct file *filp, struct vm_area_struct *vma,
>  	if (unlikely(vma->vm_pgoff < DRM_FILE_PAGE_OFFSET_START))
>  		return -EINVAL;
>  
> +	if (unlikely(is_cow_mapping(vma->vm_flags)))
> +		return -EINVAL;
> +
>  	bo = ttm_bo_vm_lookup(bdev, vma->vm_pgoff, vma_pages(vma));
>  	if (unlikely(!bo))
>  		return -EINVAL;
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 77e64e3eac80..c6ebf7f9ddbb 100644
> +++ b/include/linux/mm.h
> @@ -686,6 +686,11 @@ static inline bool vma_is_accessible(struct vm_area_struct *vma)
>  	return vma->vm_flags & VM_ACCESS_FLAGS;
>  }
>  
> +static inline bool is_cow_mapping(vm_flags_t flags)
> +{
> +	return (flags & (VM_SHARED | VM_MAYWRITE)) == VM_MAYWRITE;
> +}

Most driver places are just banning VM_SHARED.

I see you copied this from remap_pfn_range(), but that logic is so
special I'm not sure..

Can the user mprotect the write back on with the above logic? Do we
need VM_DENYWRITE too?

Jason
