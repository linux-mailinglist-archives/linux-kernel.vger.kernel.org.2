Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49CB63E3CE1
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Aug 2021 23:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbhHHVRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 17:17:17 -0400
Received: from mail-bn7nam10on2048.outbound.protection.outlook.com ([40.107.92.48]:36609
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230003AbhHHVRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 17:17:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ezKaxppymbnbmTgsJewFJdoMO3Q4cEoKpW9GpxidOzE7aqMBianG+BiaHKJ5OVjnvKRlw6AfCp+n29IMULNuGIngyuR4N+Pky6hc9KUTpTDdLNZVMVcs/jw/GwpCpXCKwhB5CgBXLTSuGGw/BJmH10u9y6Sr9Xn1Au7cZjPg49MVWetZIFQQhlt8soell9YHu8x7qPKpvPOoxwC42Nay9DKJmrzoPvldtaGohAv+PeS7EhRKdbSKp2dQ4804tbUUG+00pOTzwUw+hijVDwK4Ys9MxX4zVpdhlr3g9tzQJRc2RkmT7Qp0OWJ/LB+D/GrS/Pm/WNJFWqhDTXwzQvO2ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vy7D/M2VsuAs/Ho12wG4SFnG0/JUKKqFm+AeaE1ocCU=;
 b=PM7FcUwj+O5UfS4flscvbHP/iPOM+AHeNe63ajdxt/YhWtxTxTtT8FE1fGVhiFWN24viXZTN410/GHOXu5dRvRq1i4Xny5L7Mmf5ZVNr+kRYhgDEmP5RlaVRHnA7MRDQjmjplrPbJnaj1R1sVuAXfmUMTlreKAb5vdbHWWjmq8shL+UkqemAMO0oyDLaOH9+GaRtAe81qtpqkPKjUovMhivF+f7xaJtytzxKdBLpFvRmwmPgdMWwLI0guCeJi/u8LA0WQUAr+wbPlkEMlV8fWsBdkYNbSoSzENedR4MshXv3NlC98kK8yvgulq4nmnXs1LwjY+tK71MwO9L6Qcen/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=linux.ibm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vy7D/M2VsuAs/Ho12wG4SFnG0/JUKKqFm+AeaE1ocCU=;
 b=GGU1KhprkOx9owspt8L6p7P/JV6h1ttVy8lA/FlTMlP2U1UYf6RztpafqN/DDGii2iMp/qiw5yJPRt2g9mGDJk/4Z5I/iZIKATNMUicjDjhDVhSyJUAFTtZBrXVwjOVWsLaOC9WaQEn/c2St9h1Eho+NkA5PQ9t95ZonEDPXEl8iCayLdNTkA8c2MZRWUjLzT/+A1Bje2qpmfh9N3oi8gpcXd4+3gduKQ1xnW8fbiO4aljfLTnbFs/uDQgrTBGMYVxs40bxUvPkBbfyhTxl4hQDQ+bwwzib5pPZhEA0t+YyWDgQWxnX29OqlqKBiiTr800SInjlR0nytGfgusTR3vA==
Received: from BN0PR04CA0071.namprd04.prod.outlook.com (2603:10b6:408:ea::16)
 by MN2PR12MB3616.namprd12.prod.outlook.com (2603:10b6:208:cc::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15; Sun, 8 Aug
 2021 21:16:55 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::a1) by BN0PR04CA0071.outlook.office365.com
 (2603:10b6:408:ea::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend
 Transport; Sun, 8 Aug 2021 21:16:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4394.16 via Frontend Transport; Sun, 8 Aug 2021 21:16:54 +0000
Received: from [10.2.53.40] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 8 Aug
 2021 21:16:54 +0000
Subject: Re: [PATCH 4/5] mm: gup: fix potential pgmap refcnt leak in
 __gup_device_huge()
To:     Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>, <imbrenda@linux.ibm.com>,
        <kirill.shutemov@linux.intel.com>, <jack@suse.cz>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20210807093620.21347-1-linmiaohe@huawei.com>
 <20210807093620.21347-5-linmiaohe@huawei.com>
 <20210807114112.6e45b31c65dd62169fee8718@linux-foundation.org>
 <20210807114545.eaee318909a9215c4e056aa3@linux-foundation.org>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <87f2ff42-9d96-3ecb-dada-d347a3fa95e6@nvidia.com>
Date:   Sun, 8 Aug 2021 14:16:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210807114545.eaee318909a9215c4e056aa3@linux-foundation.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db02165d-85af-44dc-f623-08d95ab1d945
X-MS-TrafficTypeDiagnostic: MN2PR12MB3616:
X-Microsoft-Antispam-PRVS: <MN2PR12MB361601822CF5D59F32EA9C97A8F59@MN2PR12MB3616.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 31++7QEwlNtJ+7xUrcnzO291D+xITwQJZsI8sSPwVthnd15MFi5mCs1d3vNBKfboE7zHWS43jnBMZ3/Q2+23zuI2sXYS2zB+JkHKwGjEiReYchbtdCIuAQt4/Nc/3AL4Fbsq0gg22+I7fpL3KJgKtuj9K1WFmwV2Pv1sIViVCulZjGxro5TMzVnCunLye8T3p4/1INE6ZqucFLU4u9/vLrL9vaR1aefaflFEfyQ61Bl7uo4DUXCPKwQFxxhhcYTUGIN808sQwm3hdEMh65rBSt+QpG5+PXkuX6suz5mDpVts6axfs6g/pg9QdKleKeIXq2GtQ0uNdem54HC25CKK1F3XKeumvGcRGlcyk8Sh9aDtqWcdrW9MnGBmckWLF+30BICVJGpHJUHo9dBj9HiNhqnQTZAv/NsJBLdpfp7i8XTr1V+9+WWEX5uHfkgr0RHsvAjQYnI+x14D0o2+XbF5ef8MiKljzAMrU6agktI36Mg5kMbqoXpp1itilqSk3em+7FXulZPrxNgNDr9Gg6zkR5MfJCOzYzmq18uWCHEiwGcLkeg5WjwFhwLuFJJwsYcdzy3iKiiA58aeEmoO5VdoKjy0CgHUTO77ezHJOdnpjMJsc9wxvmbRZCTxMI5h7Z/30yvTnghnvXFMF8QoDb45EDXeTNv+R9gOEhI8ihJnDbC/opmshpB0u6KzbA9tjTmUA9GSguhhL/vYiN8PXoXHQMXkb6IwZRm2E60Kv8I3rS86Z9VQWKou4C+xDAp8lmUZ6BAMoOCRXrzeeqkn8kdzNQ==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(376002)(396003)(346002)(39860400002)(36840700001)(46966006)(7636003)(8936002)(478600001)(5660300002)(31686004)(16526019)(186003)(336012)(70206006)(31696002)(53546011)(26005)(86362001)(36860700001)(47076005)(8676002)(70586007)(426003)(82310400003)(316002)(16576012)(2906002)(2616005)(36906005)(36756003)(110136005)(356005)(82740400003)(14583001)(2101003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2021 21:16:54.8928
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db02165d-85af-44dc-f623-08d95ab1d945
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3616
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/21 11:45 AM, Andrew Morton wrote:
> On Sat, 7 Aug 2021 11:41:12 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:
> 
>> We can simplify further, and remove the troublesome multiple return points?
>>
> 
> oops.

I sent a reviewed by to the "+" fixup email, but just realized that that did not
hit the main
  mailing list. So:



For the end result of these stacked fixes to this file:



Reviewed-by: John Hubbard <jhubbard@nvidia.com>



thanks,

-- 

John Hubbard

NVIDIA
> 
> --- a/mm/gup.c~mm-gup-fix-potential-pgmap-refcnt-leak-in-__gup_device_huge-fix-fix
> +++ a/mm/gup.c
> @@ -2240,6 +2240,7 @@ static int __gup_device_huge(unsigned lo
>   {
>   	int nr_start = *nr;
>   	struct dev_pagemap *pgmap = NULL;
> +	int ret = 1;
>   
>   	do {
>   		struct page *page = pfn_to_page(pfn);
> @@ -2247,12 +2248,14 @@ static int __gup_device_huge(unsigned lo
>   		pgmap = get_dev_pagemap(pfn, pgmap);
>   		if (unlikely(!pgmap)) {
>   			undo_dev_pagemap(nr, nr_start, flags, pages);
> +			ret = 0;
>   			break;
>   		}
>   		SetPageReferenced(page);
>   		pages[*nr] = page;
>   		if (unlikely(!try_grab_page(page, flags))) {
>   			undo_dev_pagemap(nr, nr_start, flags, pages);
> +			ret = 0;
>   			break;
>   		}
>   		(*nr)++;
> @@ -2260,7 +2263,7 @@ static int __gup_device_huge(unsigned lo
>   	} while (addr += PAGE_SIZE, addr != end);
>   
>   	put_dev_pagemap(pgmap);
> -	return 1;
> +	return ret;
>   }
>   
>   static int __gup_device_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
> 
> Not sure if it's worth bothering, really...
> 

