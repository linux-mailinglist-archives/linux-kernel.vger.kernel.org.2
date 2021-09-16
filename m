Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7B440ED9C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 00:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241340AbhIPW7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 18:59:05 -0400
Received: from mail-sn1anam02on2055.outbound.protection.outlook.com ([40.107.96.55]:44996
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235315AbhIPW7E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 18:59:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iPFyCGbmlwYpOQI/gFTc62Vkzh51F143pHJGSnCoI2pAz8Wi8BNeAJXntpGhypIcPpoA7nyXZUFiT1/t4jTjm55j0RMK32mbNl5dbMjv6ZfciQKFWmTEUNj6IjHm3P5mrZCn0W8Y6giiuqZHiDCaEkl76Q+LhBTVMu9msCmDomVoZAL+KlD7ItzXevnesI8gyfVQ/J9Eckpeyosxkfzozp8i5SDxj12MjahdHZDjozzpvLjm8zwzt5b8BiKW1WYluivEp+dDH+dGCy3O68jeqv9W88wNtoSMblR3PfZS954VUxUNr4d8I0D5LPwL+B5FSSs4tWBuSxy+oIoaQQJLAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=+Vk6bc/jEnR7OanHHQQqiLUcoHigTqsJLs2CmvnbQGk=;
 b=i8bBxjMNyalCq2ROdxjm0b57SEl9mZ8pwVHailVGAW9Ur4i41Wm/6H6BJBHg92+orTNsjjWfMqAqgGaL8Kd2ynQ1k2sPLPyiXLVQYhVT0s5NNDcz04g9Rdtg1v6/PTistPikL3P7/k93TYOpoRHSBw39nUo7mBdmXIt9IIGH/UxiROCwfpd0KKbS1hLY5zPrcXZnn2PKF//DFcazkW5VGpAcOvmDN3mhhq7G48NDX3VxnfprXjzuPxWbj97JCtilN2o77CKAItsVd+ojiMVKTgkoSTg/4ghY8C8QrcTbKVEuVpbCl4Dczz+KS++kMg2j4VPB1Kk04WDQiJ73guk+dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Vk6bc/jEnR7OanHHQQqiLUcoHigTqsJLs2CmvnbQGk=;
 b=OFoz+R6sWL8byklg1RhODZA53gcpDPs+IZ3JV8e9Xt8ORBxZqZi5roOS7yciWM7q2ovo0Oer8j70B025s6Nwk87+ldqogpcmMmeMCVMz5M/wjuLEb3yms+1mScX1dw8J7wUHsQAX4jZNL8ZDdYPK8didiJARpiB5+Mu0A8+Bmm1r/G0Z6QOUh5kk4rUzt0stQb6PWBBM6NgsdQ4+249PA9lmSVk+7lFsRB5rAJ4sJv3RoySMOhIdNZGYfOtUmSr6BG1VPxvpzvZzc2hI3g3oWe6AA4oNi07iNzwFywxKzUtxmLDT0XEvuUFSjL2wazEnYtW9PP2P0qpdfk4hhfGa9Q==
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4140.namprd12.prod.outlook.com (2603:10b6:5:221::13)
 by DM6PR12MB4284.namprd12.prod.outlook.com (2603:10b6:5:21a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Thu, 16 Sep
 2021 22:57:41 +0000
Received: from DM6PR12MB4140.namprd12.prod.outlook.com
 ([fe80::4971:dc6a:3ca0:aa25]) by DM6PR12MB4140.namprd12.prod.outlook.com
 ([fe80::4971:dc6a:3ca0:aa25%8]) with mapi id 15.20.4523.016; Thu, 16 Sep 2021
 22:57:41 +0000
Message-ID: <b99f88db-edeb-fab1-803e-5e083594bec8@nvidia.com>
Date:   Thu, 16 Sep 2021 15:57:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH] mm/hugetlb: Drop __unmap_hugepage_range definition from
 hugetlb.h
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
References: <20210916212816.86838-1-peterx@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20210916212816.86838-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0351.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::26) To DM6PR12MB4140.namprd12.prod.outlook.com
 (2603:10b6:5:221::13)
MIME-Version: 1.0
Received: from [10.2.60.80] (216.228.112.21) by SJ0PR03CA0351.namprd03.prod.outlook.com (2603:10b6:a03:39c::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Thu, 16 Sep 2021 22:57:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2550507f-3d49-458f-6d25-08d97965630b
X-MS-TrafficTypeDiagnostic: DM6PR12MB4284:
X-Microsoft-Antispam-PRVS: <DM6PR12MB42848FCAFB38DDA818C53E7EA8DC9@DM6PR12MB4284.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NEp0dNean3KkjlNKSxmlW1C0i8Kwp4iwpavUQPQgnyvUXtc2j2iCqNDKPI52JdE3MW6C/sT99ZlUvgJatYjLYWinmlvtsphpHiwVHIwMhcvgseJTNO8Z72rqofQEGgfKxd9MeU5XgIFiszPZzJGDMjo6dm7Ymy/bF4BEzlZX5wRV+9Q4H0wpOI7E0sM50mGQWzuaRXAO0pdD/0MZBquHanu5xC2ErrkL9BT4W4+k2nboD1osOKviVTawgVt/pOAO1V9C72u2z0HMpLhwx9FCOcqsk1PrJPPe1lD5M3xqcxBnDnoRl8avzNiAcOF6eE8TK6y77Qc2cOTiDajwJckCzF4u+X5YO1RKiiStzCQIerGATpOnmHHSJQzfqInj+AZ5Tqum3xiP6AZZ7R4iPPDZjngmUFgDITH++TkHY0P/icshDpQF/YIOXTQ1CMIQupLgpiv1ogk7ua2iMXvyoUn26gv/LJ2/wJeS1j/Zc5qRL6FiugFMV0AkKRO8WAapEm9WMYe7dUKqNC4T0Kks2k6K5RmyVBiOw9n9oxvOzd/awYltSGICWjJDOx6VTOgw4/1mh1SDzBU/863GV8WYHNbkP2KrZTzbwaOt+GfSJOWbLW7uyOPm2uB0ekUl9+KXzc6xjPzNcKag5AA9ENf035lywfwhOfdiHp9FEoxMZQYqKI/0EiSIuEXy/jK0TLGDcgxnHLwzfayjf+lbZjVrWOuygypr7jIwaUFSSN8p83DyTMQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4140.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(54906003)(508600001)(36756003)(66556008)(6486002)(66476007)(66946007)(186003)(4326008)(8676002)(31686004)(26005)(53546011)(86362001)(2906002)(956004)(2616005)(31696002)(316002)(16576012)(38100700002)(83380400001)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckRRaEJaRHVzM2hwSzFId2dybk5PNW9pazFMa2hWcjUwaWtCOGdxdUJrL2ZI?=
 =?utf-8?B?SWx5SkFkZ29jdkMxeXlyVFBZU1FBZXY1aVRaeGZBcGVCa013aFM1R0R5cC9Z?=
 =?utf-8?B?bFRsN2t0WkxBSVlrYi9JVTllcGRBdU1PQ0d6YjJLWW5ya0s0eEEwOVl2MkRt?=
 =?utf-8?B?UG1Ga1N6dExLV3dLbGh4MWRPRlNtYnhqVlBSV3FXSTU2R1JCYmwwbDlyOHNQ?=
 =?utf-8?B?QTlkQTQ0TWtwYVAzcTF6VDJQV1RxWVRadVpZUVVQbTNsNkxaZ0VrQnk4NUhm?=
 =?utf-8?B?Wi9ROW5VNFVxV0oyVC81U2pDWi9vQVNOR2pDbTFzNWYybGhXaWZOWk9xQlda?=
 =?utf-8?B?bDlZTjBXTWFzbzd1M3FPTmFiY3JQRElUN1dhNzFnN0VWZ1ZOWTl3VEhKbzc5?=
 =?utf-8?B?cFppenE5MzZEWjgvSENPTjhrRXhPVmVBR3RhRGpxRzhudWEwRm9WSHZQbytQ?=
 =?utf-8?B?NnBjb2dlNWFVc0hBdit3ZkdRNW1LU1FYMjMya2txY3ppUVQ2WjU2ckRWeXND?=
 =?utf-8?B?WHM5anNrM1pVT0JmUlBtamZ3K0NzVDl2T1ZJUzBhMDJwWFEwYmxVVDMwNERy?=
 =?utf-8?B?ZTVGVnQ4cUwwOUJaNFZYNUhqMzJOdkhSck03TXZIVk5DcFdPK0lxTGtXVDFh?=
 =?utf-8?B?Ly8zVjRZOTZRR09RZk81KytTajZwbFJOUkhUMS9RT2I0RC9oamsyQkRkZ05k?=
 =?utf-8?B?S0U4S2MveGhaNC9RY3ZScEFyVUVnREpZNlo3YlhUZys4ZHZjTEU1ZllHYmZh?=
 =?utf-8?B?QlVyblIxU2pZSVJJMm5NYXN2ajhrbXUyYWNGMFJFZ1JyWTZuZC9IaTZvL3Zz?=
 =?utf-8?B?NGlVL1h1MzAwSUJidzhNY3FOZkNPNTdzVTcxbzgyQzA1VTJYRVpZMnBSa3lB?=
 =?utf-8?B?ZnhNeVVnUFVPUjFDaGdoK051d3l1Y3BDaktyYjhaVHUrVCtNSDI4dm5TdTFC?=
 =?utf-8?B?UTBMZFNJb2VUUGxyb0VxazhxUzRxVmx2Tll4N09nSTAzekZCL2NGQ1hscEhy?=
 =?utf-8?B?WG13VWJiQWRxc3Z5RUhZV3IvMWFTZENsWER2dXRrWkZXZ1NFblQvWS9tN2pG?=
 =?utf-8?B?alZuNjR6UVZYODdlTzlkbGtzazNrUFo0ZTBoMnduZWlwZE5Pdi9wZTlGTTIw?=
 =?utf-8?B?ZU5oVkh1Y3oxamo4QkJnWVUvcGVBNHNPNTFiK3pUT1dPUFRybWdXZkZCSVJC?=
 =?utf-8?B?UWVZVEZBZGNmUFpMSVA3dGhtWGpiR1dieHZGVHZWc3RKbzZ1bDJuVmcwdDhx?=
 =?utf-8?B?OXFZRW0xdCs4elVzSmJHTVpmMXl3cFhYbUJVbVRVUVNFM1g0SUlkTGh2RUN6?=
 =?utf-8?B?U2lWbkxBN1RhOUNHN2lWYU5iK3ozb2Q0TDArSUp1clhHV2c5Rk4yb0RnWG41?=
 =?utf-8?B?YTl0Z280anNweXJnZnFHRU5mUUNpU2FyYkJxdDNWaHRsTGk2bG12MEt5VHJG?=
 =?utf-8?B?TXNwQjE4SFFSYjRFK05TQmEzRVk2TjFzeDIzS214MTNkb2VGTDNOMVNHSW01?=
 =?utf-8?B?QThSSTBYOGlablo1RVdLdElMbklMN3RqYzBLQVNXd2xVZEZTM2d2UjFqSUtF?=
 =?utf-8?B?bEEySFIvd1JKM2YydmJqQ08zOHlGT1NIRzVyQmZyLzF5OVVyMlcrRTJ6SEw3?=
 =?utf-8?B?eGZuU0wvU1g4aUdBcGlqTTJPUnFqMGp6UkRGM2dJUVdUMWtDVVNDMi9JY0Fo?=
 =?utf-8?B?M1lkdGsvc3F0WFFaRmtKbWtadDdqMnlIY0Y1Vkc3eUFhSDVYQ053ZGs2cm44?=
 =?utf-8?Q?GtPghujcTkehpWZijZC76k8Zo2+kcGulNGV4Mlt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2550507f-3d49-458f-6d25-08d97965630b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4140.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2021 22:57:41.1450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: raUG/leiIZrhetwktEDDuPBiXY2bvW5pgijEO4a8zQMxu1MRiH0jFKlnb9wdjp3rW7uXx6/hhq+QeGpSUF4BiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4284
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/16/21 14:28, Peter Xu wrote:
> Drop it in the header since it's only used in hugetlb.c.

Hi Peter,

Tiny documentation tweak: could the above line please be changed to
something approximately like this:

"Remove __unmap_hugepage_range() from the header file, because it is
only used in the .c file."

?

Because: "drop it in" is so close to "drop it into" (which means, "add
it to"), that it's actually reading a lot like the opposite of what you
intend to say.

> 
> Suggested-by: Mike Kravetz <mike.kravetz@oracle.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   include/linux/hugetlb.h | 10 ----------
>   mm/hugetlb.c            |  6 +++---
>   2 files changed, 3 insertions(+), 13 deletions(-)


The change itself looks accurate for the current top of tree, so:

Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard
NVIDIA

> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 1faebe1cd0ed..3cbf60464398 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -143,9 +143,6 @@ void __unmap_hugepage_range_final(struct mmu_gather *tlb,
>   			  struct vm_area_struct *vma,
>   			  unsigned long start, unsigned long end,
>   			  struct page *ref_page);
> -void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
> -				unsigned long start, unsigned long end,
> -				struct page *ref_page);
>   void hugetlb_report_meminfo(struct seq_file *);
>   int hugetlb_report_node_meminfo(char *buf, int len, int nid);
>   void hugetlb_show_meminfo(void);
> @@ -385,13 +382,6 @@ static inline void __unmap_hugepage_range_final(struct mmu_gather *tlb,
>   	BUG();
>   }
>   
> -static inline void __unmap_hugepage_range(struct mmu_gather *tlb,
> -			struct vm_area_struct *vma, unsigned long start,
> -			unsigned long end, struct page *ref_page)
> -{
> -	BUG();
> -}
> -
>   static inline vm_fault_t hugetlb_fault(struct mm_struct *mm,
>   			struct vm_area_struct *vma, unsigned long address,
>   			unsigned int flags)
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 95dc7b83381f..d394d9545c4e 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4426,9 +4426,9 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
>   	return ret;
>   }
>   
> -void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
> -			    unsigned long start, unsigned long end,
> -			    struct page *ref_page)
> +static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
> +				   unsigned long start, unsigned long end,
> +				   struct page *ref_page)
>   {
>   	struct mm_struct *mm = vma->vm_mm;
>   	unsigned long address;
> 


