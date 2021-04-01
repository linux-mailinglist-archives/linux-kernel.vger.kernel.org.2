Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE3B3521EC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 23:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235169AbhDAV5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 17:57:22 -0400
Received: from mail-bn8nam12on2080.outbound.protection.outlook.com ([40.107.237.80]:54144
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233974AbhDAV5V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 17:57:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jp0jZ2pLJwqRDagQm61EFVTNwuiwmEt+iIz8WbHnjGf5UdbAezXVV/hRmdN7vd+lTNDfovJbHnvG+oTjnUJZfO1nBCIEp0V1Iw6Ttjc0csk4if/g9IAshilLfAchFv/6OQwe778OPN8DoJelA6Gjkmkxe2aYN3cpp7soSalyzAWglEKuHAVA86dMH5eYRl3t51GdNtTM5NQ1O2xkI4NA63zpuWAxIafgXLOL2VZCcjpJBrN2Jt4JmBhw5g6tNOVD5N4s8wpbIf1xfPPRF7dlHOHt4wh4CvS1gvPVMVJwOCNTZCglrN28tiL/zvZUpCh5cbEpa/mzMo+Clpma2vLHDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kiF+Ekaciqls+yFBaM3+dQvUKpVWCYwn5J82sDaQ6XI=;
 b=DQA+Cr0fLUAM0byNVFdArSyJL9hObF0iCCYtEB8PhuqXTmHE6GYvbZaJE25WtjvgqshGWjUcJ0qKgfnnnBQyhYj9fV1AHVa5INnHgaJkIZH6M8YvDDf8Ht0/Tbx0AKo3c+Qs3MsgL7gH4HsyfPB7/yJpATNRWQZVikV8sNPuK+MEDQtcBN3OWXKL8dlp6aVnX1rgEkJQjpu/BT9TPRsMzEAL6Pau12HNn/ruHuGvA3kTeSiWtJOO4POmxJIq/WgHbMrGry0d/04Wez/lZOk7s/mx6fivTl4ez6DBDaeZ3zVmgUzeRO6enGu25CDsuohdpePbHwsmrjXVpCfKaKEbTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lwn.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kiF+Ekaciqls+yFBaM3+dQvUKpVWCYwn5J82sDaQ6XI=;
 b=h4JL8USQqOv21wyJSTmDsUY3NVN5uSYmbgBVCNxNm+jQTpf0S1nV7xEP/IWojPVCyRXKOMV5DzKDfD6EOyFtubxq9KH26pAjSmixl9UI3rI+3aaDj6/6P/8SReBUXIxn6l1lIp1uv5L8dJn0z7xQGOgdU4GjSmn7ZYd2Zox9Kk9eStRRRLbWrO4DmYFxJzAck3KTWQqv9OwQQX0Bxwq/FtqLKQ4zv8TVPZAuQoV04JnhUKf4uIxke9pPQpqYTJoEe1ViSYyfWNVfHquIvm4QdGDOQmWgk2z6bnlEHjy6SdlrLLykqwQeEWGjnAeZX407lXcmguLutW+fYiUIjWnw1A==
Received: from MWHPR04CA0039.namprd04.prod.outlook.com (2603:10b6:300:ee::25)
 by DM6PR12MB3435.namprd12.prod.outlook.com (2603:10b6:5:39::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Thu, 1 Apr
 2021 21:56:06 +0000
Received: from CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ee:cafe::b2) by MWHPR04CA0039.outlook.office365.com
 (2603:10b6:300:ee::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26 via Frontend
 Transport; Thu, 1 Apr 2021 21:56:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lwn.net; dkim=none (message not signed)
 header.d=none;lwn.net; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT068.mail.protection.outlook.com (10.13.175.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3999.28 via Frontend Transport; Thu, 1 Apr 2021 21:56:06 +0000
Received: from [10.2.63.109] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 1 Apr
 2021 21:56:06 +0000
Subject: Re: [PATCH v2 7/7] ABI: sysfs-kernel-mm-cma: fix two cross-references
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        <linux-kernel@vger.kernel.org>
References: <cover.1616668017.git.mchehab+huawei@kernel.org>
 <87907316390311c6b42e86c3ba9fb2f2903d9499.1616668017.git.mchehab+huawei@kernel.org>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <07220859-0a4e-34fb-9349-b3c7d011a108@nvidia.com>
Date:   Thu, 1 Apr 2021 14:56:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <87907316390311c6b42e86c3ba9fb2f2903d9499.1616668017.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e16a42ed-78b3-4827-e090-08d8f558f376
X-MS-TrafficTypeDiagnostic: DM6PR12MB3435:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3435977505BB1A1CD31BE0F8A87B9@DM6PR12MB3435.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lJtMtndmQc4ORwkz1oCa/HeiEMOg7oQQ9A6VW8Z8EO0GdNCFy5Iekp/zVlskUdhN7sOASDIVU3QwLqZnPPTyYQfXEaTZ0pdFVhAWZez6uRD9yoU15PlfZb/399b2YjfIhF74oUjexxkaUy9R+NmpAbYpy6pRJxbQmL7jQSDJ8W/hR0rysmffYbfp1qQadgYLmkNUDtRkSFLtXfYOiG2IKM2pu/28/Jbgvu0NlK6zitwkkMOK0ljk2R8L1hs9HoEnOAIhsb+aJ1bK5V3BExrMlzYsh9kdvFIejnd9LANEX3tRt1LvS2wGqiEXnN89T4RuQnistBG8gVTNiLwAYNrH49yyltpVAFUQAF5oPmNwXKrs9rbAaLl4Y4wYcjJwlcgo0dAK0kKJuDRPc+Y0JPwnpFnb44UH+XQ0njdl1Y9XanaEwiMb1uQTss00wASshiZ4FvMdui2vqXI2byy9lx8KogVZtSls54iP+ffYvpL2YotobkSOhaLpouoentFNUZoIwKMIXQSMoe1ROxADVLMTa5tJJN6Ek8JGI+GDG/+3vd9xtTZ5Fw3kwkvNw2zasL8RqUhQtSMmDZscPzwAQWb3BvJ4ecTrln1PVrpOc928bZZ8s0EOJC8eI0/2rUkjW5jLGJZBs8RfJi31EoHA464yoAxIIUdKZnZE5Qaqki+vF61tkvAH/d1aMTZePYegb7tJ
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(396003)(136003)(36840700001)(46966006)(16526019)(31686004)(356005)(86362001)(82310400003)(316002)(336012)(70206006)(82740400003)(47076005)(26005)(8936002)(70586007)(4326008)(54906003)(36756003)(36906005)(16576012)(110136005)(83380400001)(7636003)(2906002)(186003)(31696002)(53546011)(5660300002)(426003)(2616005)(8676002)(478600001)(36860700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 21:56:06.2457
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e16a42ed-78b3-4827-e090-08d8f558f376
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3435
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/21 3:38 AM, Mauro Carvalho Chehab wrote:
> Change the text in order to generate cross-references for
> alloc_pages_success and alloc_pages_fail symbols.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>   Documentation/ABI/testing/sysfs-kernel-mm-cma | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-cma b/Documentation/ABI/testing/sysfs-kernel-mm-cma
> index 02b2bb60c296..86e261185561 100644
> --- a/Documentation/ABI/testing/sysfs-kernel-mm-cma
> +++ b/Documentation/ABI/testing/sysfs-kernel-mm-cma
> @@ -5,12 +5,10 @@ Description:
>   		/sys/kernel/mm/cma/ contains a subdirectory for each CMA
>   		heap name (also sometimes called CMA areas).
>   
> -		Each CMA heap subdirectory (that is, each
> -		/sys/kernel/mm/cma/<cma-heap-name> directory) contains the
> -		following items:
> +		Each CMA heap subdirectory contains the following items:
>   
> -			alloc_pages_success
> -			alloc_pages_fail
> +			- /sys/kernel/mm/cma/<cma-heap-name>/alloc_pages_success
> +			- /sys/kernel/mm/cma/<cma-heap-name>/alloc_pages_fail
>   

I agree that this is clearer and easier on the reader, who can now see
directly what the full path to each item is.

As for calling it a "fix", that seems a bit much. It's an upgrade.
I'm not sure how many people realize that this sort of change causes
cross refs to magically start working. I certainly didn't until now.

But either way, this improvement is nice to have, so:

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard
NVIDIA

>   What:		/sys/kernel/mm/cma/<cma-heap-name>/alloc_pages_success
>   Date:		Feb 2021
> 

