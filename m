Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A58E33EA61
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 08:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbhCQHOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 03:14:06 -0400
Received: from mail-mw2nam12on2076.outbound.protection.outlook.com ([40.107.244.76]:41697
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229613AbhCQHNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 03:13:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fuoAnUv2AQJYmb0tcLxUUTlNTMEMHqSt4bo5lQyCjc2bCK4T7wq2oPBP14VGqd/d6K82XGlm9yr4CH9curf3yhnous70EHvveIN3Ll2zE+hZoHGbHs7grf6nKFv3oX1mTZ6SQbpqSobqT20Q1DXYw378JbJQ8DLqNvQE03Hz54CSevLXsTICj4Zn3ZsjLAsgEue1CsRxAJIkw2tp8LrBZwOB+nBzj4+ph6MVqF2AF0Y2UCY5pY+XSDC0FO7apgErLIlCgrJNnFXlIZ4i3ztLkg44It7fQbzPr9OvQv9GvohVtiOUcmG+1AbnJs0UowGcfktlsMUMmgM3WTxRsKbwrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f60tpCnGSFr4GSsWBg6jb073WSHjsrb1Wlbbkol7ing=;
 b=f8mHAo2P9PeQtfCFKPOz0tW0xtLfi5HGJjA0EvGOFIPe3u/+n9TXKb5iOkTHlF3tAFQ6Hfiit+isWyF6fzEYbzPIot3TLq+ZDGWHPXEYwFV62xFlts/G3KCdB9Sqh8WvOeX6Ov1xUwoAripz/c1Qymn62/YAk0I1gK6lSrXQGWq2PvoVE+wVnU8KyerT3au/Z2+Qpdh6Qk1C/TDTC//3Ao0vucY1TRF3VswKvw2VrO/yQy8qqPwrK+s5n1qISWoM1cw0JLbloAh8CM9yeZJ/3+bYHt0ktQ3jkd61ZvDpdUQWvh20g2znmQlvzf7F6ZWhvwwj3USCm+0p7HTVcjJyUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f60tpCnGSFr4GSsWBg6jb073WSHjsrb1Wlbbkol7ing=;
 b=iJm3fkunu1m1huSDvD27PnQSoKzW6UNg0CIvposh0PHojM4bJdr3QTo945GJ3j6FoOn9LMs3hNY8dLu8uqYnMRAyUiWIXyPgbmDFdDZNH0P3XWD5NDkiJhP9+BKfUS7BzXu44qDaz5LL0h7Xxo45I+uMLmhtGkRZlEXNt9sWzmSq2adK5baya6Dc6aJkA4TVskkHif9ugBMX/reM7k/mHkJpvOW9+3dkL8Tms8RCRsR7TLPHMa+n87GXNB9cu5OulFagW6WUqrAmUYXCP+1vHJUqa9zBH8zCIQuw7PMOoZVHhSB76AkapXaX2pv2In18IDRJS9fo4h4/WYW56DXadA==
Received: from MW3PR05CA0029.namprd05.prod.outlook.com (2603:10b6:303:2b::34)
 by DM6PR12MB4957.namprd12.prod.outlook.com (2603:10b6:5:20d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Wed, 17 Mar
 2021 07:13:45 +0000
Received: from CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::e9) by MW3PR05CA0029.outlook.office365.com
 (2603:10b6:303:2b::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.9 via Frontend
 Transport; Wed, 17 Mar 2021 07:13:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT043.mail.protection.outlook.com (10.13.174.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3955.18 via Frontend Transport; Wed, 17 Mar 2021 07:13:45 +0000
Received: from [10.2.48.16] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 17 Mar
 2021 07:13:44 +0000
Subject: Re: [PATCH] mm: cma: Fix potential null dereference on pointer cma
To:     Colin King <colin.king@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-mm@kvack.org>
CC:     <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210316100433.17665-1-colin.king@canonical.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <c2881c32-4354-437d-749c-d6dd419e5a4d@nvidia.com>
Date:   Wed, 17 Mar 2021 00:13:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210316100433.17665-1-colin.king@canonical.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ee14521-9ffb-409c-09e6-08d8e9143414
X-MS-TrafficTypeDiagnostic: DM6PR12MB4957:
X-Microsoft-Antispam-PRVS: <DM6PR12MB49576532D879B45719B315A9A86A9@DM6PR12MB4957.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qOd91svkMcFhen3vJ40q1fgi71QAk1efqwA+OW3PIV9aeNVOclZbv3JQWvDUGfAnb1e/La+sPSvnQwGrWdf1PirSeYZ53qG9gShMJNCL2hFxoYNX3j5XHgqQOy0978T7UtUTpN3QlPAbxh+lEk5lqC2zFScM+vYCx8Doy/wuZ3XnfRJZDMJd+kc5SwRY7HfxL5GPDahqkt946kIuuqHtYU1kIB3eSNG1Hv6euus4pULKyX2Yh2vrBx8U1i7DQMAZdH5M9N0P5dcYY+tG90gmdGIyP0vbbFCt/BJd13j3wR4gvZqW9rkWliBi0MjuG9q1U8M9XuIdJTmZRHVBYujBk92CJKh7SmtyQPLN+RNAvB7tVDUzEaBMUA0EmkhneC37yW7GI5PGRGqErC4+5mLT0EbOB9vcKIu0vWnYdkkwD6JgfUXcZ0H7euhgR1/hMie1CV54wII1Kb7VEj1PIKOSke7O22E6m+e1req6I9TEcoy08d7/IDqTEe1h48W8g4MF6N6mmrFn9SNbl4paZewOwfhVVVEC6Ky0DEwQota1BRlfFOJV1LgOYW5+Zp5wXllGX1Ln1HmSz0shxBjkhEg7CDPjJhyNj+MCfDNEXzuSllKzP5sAsKPRfWk4v899Tf7DUBK+TnGpodCOagtmeU+KcGoh/DVwwsSPiMxYafpeBxVIp7ecqBCGmUtR0LdyXzeGmit8Pq2/gvTjT59Bxle0Fg==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(39860400002)(136003)(396003)(346002)(36840700001)(46966006)(70586007)(478600001)(34020700004)(53546011)(356005)(31696002)(4326008)(6666004)(16576012)(54906003)(26005)(186003)(16526019)(2906002)(110136005)(8936002)(36906005)(83380400001)(36756003)(70206006)(2616005)(426003)(336012)(31686004)(8676002)(47076005)(86362001)(82740400003)(36860700001)(5660300002)(7636003)(316002)(82310400003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2021 07:13:45.1583
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ee14521-9ffb-409c-09e6-08d8e9143414
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4957
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/16/21 3:04 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> At the start of the function there is a null pointer check on cma
> and then branch to error handling label 'out'.  The subsequent call
> to cma_sysfs_fail_pages_count dereferences cma, hence there is a
> potential null pointer deference issue.  Fix this by only calling

As far as I can tell, it's not possible to actually cause that null
failure with the existing kernel code paths.  *Might* be worth mentioning
that here (unless I'm wrong), but either way, looks good, so:

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard
NVIDIA

> cma_sysfs_fail_pages_count if cma is not null.
> 
> Addresses-Coverity: ("Dereference after null check")
> Fixes: dc4764f7e9ac ("mm: cma: support sysfs")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   mm/cma.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/cma.c b/mm/cma.c
> index 6d4dbafdb318..90e27458ddb7 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -512,7 +512,8 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
>   		cma_sysfs_alloc_pages_count(cma, count);
>   	} else {
>   		count_vm_event(CMA_ALLOC_FAIL);
> -		cma_sysfs_fail_pages_count(cma, count);
> +		if (cma)
> +			cma_sysfs_fail_pages_count(cma, count);
>   	}
>   
>   	return page;
> 

