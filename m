Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3889134E1C5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 09:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhC3HJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 03:09:11 -0400
Received: from mail-bn7nam10on2070.outbound.protection.outlook.com ([40.107.92.70]:54368
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231311AbhC3HIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 03:08:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ehJLIrbC+13oSqGLaK5tzdxrS0IMKChJHYjZwPbVWfoORNZP2mCgt4h1D8vty5TpKDH2zM9BjDK9MV/f7XhQ3MW1qLFR29rujnkGf66S4w41R/JLBP95sNMH8O/phs62kP+C0QyVJ/if5zOHFrHLFU9jrM6FMUUIC1bybCZSS44JnbwHyH8p/742ScmV64MXLrMlqElVOj9OhVBJRMIVC3iCs+oZeDY/VzgPVm8tCxmPUYWrS/BSWWt2E0+cUTyPUsXBxxkbHZDBywnICkmRzju7KKZWI+rFUA1KZ5M4klNMNdW3USRUpgMkzQ/9Cg3dtZBTJraMYAxta/74vt37mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6vpCZEFzG57rjUG29JbHXmRKAxf1axGUR6d1EQCmO5c=;
 b=AR3lmz0ZLYP2MXhpMes2/S57vKsn5EZvKVXPH+87xlMpD8lJhmIbsvcoK9E4N6JOLfRYivZs5g7J6UXoKezo0HxyuxFdsBIqsyNPgEuwMBpheRNU/T1xrvtvE0Htd4VnkHCnaOqDo08IbLMZu+GjIY6vYw1TKyKY0+WtZ+7Pb0a5oxHFc+lCYnNd3kVvAfQH4ZhZMiaDVOUXQVUQPRkU8Lijc7OoGJszC6yoFjMzgPXMTtsjH4/YJI/91eAGX3McFJ9tepQXPLKfhAVmBZGxDSWP3U08kBt5HG6/w9WCvCXlpT7vycjsZyaLHDXEDE1QUek8tl5pww8EDAuPKgBayQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6vpCZEFzG57rjUG29JbHXmRKAxf1axGUR6d1EQCmO5c=;
 b=ZhM7NdQd/RV13VecxW3FZdxXMDUvrdRy34IvVf7BIi+bY+e2cezcXjO/RCrodSTVY1FDG2eJFc2OCmvUDke1aYT6uRyqn+Nyqao0HIXcu7tuS7C2FJkg6Gi/6Pa8t9NSNBFe0tij5d0ogIcF73VhEFv3JzMWFZOi0vkQt+s9vhK5EDsIoDZgicivOKpF8YM8zl0j9nnz5kM/nUufFZew5R2USCpQdrNkEttP9b+AW2hmjFIFKhiik3dAkLWOfC6ieaM7xhTYJZkOo1XTYq0MeUEkpV4SoiYSwa4u4Ig2537P8QKYytaFc//20ShH7J6IaQ0+jMlmhcw5fatWkzILcQ==
Received: from DM5PR20CA0002.namprd20.prod.outlook.com (2603:10b6:3:93::12) by
 SJ0PR12MB5406.namprd12.prod.outlook.com (2603:10b6:a03:3ae::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.24; Tue, 30 Mar 2021 07:08:35 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:93:cafe::99) by DM5PR20CA0002.outlook.office365.com
 (2603:10b6:3:93::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend
 Transport; Tue, 30 Mar 2021 07:08:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; linux-foundation.org; dkim=none (message not
 signed) header.d=none;linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3955.18 via Frontend Transport; Tue, 30 Mar 2021 07:08:35 +0000
Received: from [10.2.63.109] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 30 Mar
 2021 07:08:34 +0000
Subject: Re: [PATCH] mm: gup: remove FOLL_SPLIT
To:     Yang Shi <shy828301@gmail.com>, <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20210329193828.179993-1-shy828301@gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <624d1172-cdf9-ce82-aa0b-6646f3bee757@nvidia.com>
Date:   Tue, 30 Mar 2021 00:08:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210329193828.179993-1-shy828301@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c8e2230-fb35-4030-ece6-08d8f34aa27e
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5406:
X-Microsoft-Antispam-PRVS: <SJ0PR12MB54061925E4311A54DAD9A293A87D9@SJ0PR12MB5406.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:901;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mlqW6706IY+Hs3cD61nr/X8dEuTWYo0eBqdyzrTwvXU+7x5SVZ5zqQqPPZxpc3QQvdJ6z7haq4o9HuV4TKNUXnFz5ZanZarnFVdjgt05xb4M+KZoeIszDKxkPmXxI6HGxLLwELTeZc4UqwGCtTcGKsJH+/nrY+yEFhHe1nE0RIoF2CZQTS1aviHDJCCdva9YBzTbAM/f9Exn6qgMz3O+5W7eQ31bFV2+L8EVa7oXRzpoaM6gpVSltnVL0kla2fga9nOUIoeGYDOf0l+eZvYm+sT65RP7j4nUrYXrOuV6TSoGMTPyWO10JmPQn1ZJn9u1C9++gwRjRQ2pCCU6BJ7yWWECxXp5763ROc9CBzxneDO5wjrLESe587PPZohj4c/9Qj16MwdqXCWyuBb8hVr4M3wI5fBCnR6R6/XLiGaU87YV9LQ0qRF2TYmCt6ABrBqbNsvNnH+0gWH54RrTcxtIIZLhmmtB3B35wQwmVGQTnHCvhuzEMcnfmrG4v9gcWOfcZtJYJiURg/J0K8tRsKKzvCCm+88WDkAf8HiHkIH74J8VDG0Iv4GExL4z+L2r/PUbfTiUpG/L3g53npffsLPyIPGddiP9HvqZJbe2JNTGqhO0jHkbP+kV6R6zRF1L8BnO832DOIIbEIILS/4Nuj+EOW+mblsXxfqLAhvxTLiR49d3CDT5RZZdNn+FYWRAMLEo
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(39860400002)(136003)(46966006)(36840700001)(70206006)(478600001)(54906003)(110136005)(16526019)(426003)(83380400001)(4326008)(2616005)(336012)(186003)(36906005)(316002)(8676002)(47076005)(36860700001)(70586007)(26005)(31686004)(2906002)(82310400003)(86362001)(356005)(5660300002)(8936002)(16576012)(36756003)(82740400003)(7636003)(31696002)(53546011)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 07:08:35.0782
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c8e2230-fb35-4030-ece6-08d8f34aa27e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5406
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/21 12:38 PM, Yang Shi wrote:
> Since commit 5a52c9df62b4 ("uprobe: use FOLL_SPLIT_PMD instead of FOLL_SPLIT")
> and commit ba925fa35057 ("s390/gmap: improve THP splitting") FOLL_SPLIT
> has not been used anymore.  Remove the dead code.
> 
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
>   include/linux/mm.h |  1 -
>   mm/gup.c           | 28 ++--------------------------
>   2 files changed, 2 insertions(+), 27 deletions(-)
> 

Looks nice.

As long as I'm running git grep here, there is one more search hit that should also
be fixed up, as part of a "remove FOLL_SPLIT" patch:

git grep -nw FOLL_SPLIT
Documentation/vm/transhuge.rst:57:follow_page, the FOLL_SPLIT bit can be specified as a parameter to

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard
NVIDIA

> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 8ba434287387..3568836841f9 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2780,7 +2780,6 @@ struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
>   #define FOLL_NOWAIT	0x20	/* if a disk transfer is needed, start the IO
>   				 * and return without waiting upon it */
>   #define FOLL_POPULATE	0x40	/* fault in page */
> -#define FOLL_SPLIT	0x80	/* don't return transhuge pages, split them */
>   #define FOLL_HWPOISON	0x100	/* check page is hwpoisoned */
>   #define FOLL_NUMA	0x200	/* force NUMA hinting page fault */
>   #define FOLL_MIGRATION	0x400	/* wait for page to replace migration entry */
> diff --git a/mm/gup.c b/mm/gup.c
> index e40579624f10..f3d45a8f18ae 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -435,18 +435,6 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
>   		}
>   	}
>   
> -	if (flags & FOLL_SPLIT && PageTransCompound(page)) {
> -		get_page(page);
> -		pte_unmap_unlock(ptep, ptl);
> -		lock_page(page);
> -		ret = split_huge_page(page);
> -		unlock_page(page);
> -		put_page(page);
> -		if (ret)
> -			return ERR_PTR(ret);
> -		goto retry;
> -	}
> -
>   	/* try_grab_page() does nothing unless FOLL_GET or FOLL_PIN is set. */
>   	if (unlikely(!try_grab_page(page, flags))) {
>   		page = ERR_PTR(-ENOMEM);
> @@ -591,7 +579,7 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
>   		spin_unlock(ptl);
>   		return follow_page_pte(vma, address, pmd, flags, &ctx->pgmap);
>   	}
> -	if (flags & (FOLL_SPLIT | FOLL_SPLIT_PMD)) {
> +	if (flags & FOLL_SPLIT_PMD) {
>   		int ret;
>   		page = pmd_page(*pmd);
>   		if (is_huge_zero_page(page)) {
> @@ -600,19 +588,7 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
>   			split_huge_pmd(vma, pmd, address);
>   			if (pmd_trans_unstable(pmd))
>   				ret = -EBUSY;
> -		} else if (flags & FOLL_SPLIT) {
> -			if (unlikely(!try_get_page(page))) {
> -				spin_unlock(ptl);
> -				return ERR_PTR(-ENOMEM);
> -			}
> -			spin_unlock(ptl);
> -			lock_page(page);
> -			ret = split_huge_page(page);
> -			unlock_page(page);
> -			put_page(page);
> -			if (pmd_none(*pmd))
> -				return no_page_table(vma, flags);
> -		} else {  /* flags & FOLL_SPLIT_PMD */
> +		} else {
>   			spin_unlock(ptl);
>   			split_huge_pmd(vma, pmd, address);
>   			ret = pte_alloc(mm, pmd) ? -ENOMEM : 0;
> 

