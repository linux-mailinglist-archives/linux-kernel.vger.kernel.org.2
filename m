Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91AB63C7EFA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 09:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238141AbhGNHJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 03:09:45 -0400
Received: from mail-dm6nam10on2055.outbound.protection.outlook.com ([40.107.93.55]:13318
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238104AbhGNHJo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 03:09:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NsouuCCIekB6fO7DyFldObI6540D6DnM/+YKEK5vGDvLyNMS1wf6BxzXuqYC4KoCizO4U/FUiMdrbbXEKmHJyobECG4qo5CSzUVFYpvDOM0Yph59slojgT8t1au0xnEyVoIUOWE7TGqoRTHuXS/GapUn/4ANPPvy+Nwfa75iDFhbIgIfvFgIWvtt9PDm28vaq0svsYK72hCext6n2y4q2ARJC7Yos/B214q6e3CRTqoZRcSRZmRyBwZOYrwqojeI4QYzvecMZWh4PyFWhUBPhrir6FVr+rLEenvRblK3+6PFhIiwYzz8N0R9GB+tXk/PYhRKaB3IeeP6S5gawwI0WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C62KPp6ERYeKZX/v98Owgzsq0n40YHcEQ0PdoQZfHFo=;
 b=j9Eb5kfXLlj6oxxUEWsPOSQNgEHlfULiP5idN+b65PF9zpOZewx3Mf+IrbmZlIMr4pz5Lx9FFJsuac/dJpnKcKc6Ak0Fwyfw/Wza4uOjX6vqsNNffLP7aUFmReio+Ku/wUb1vhJOTjv9SEboQRUClejK8G5GakVGZk69PwWSJUa+LYMvmbJL3j9B6RG5Z2WUiaA8cklZ37+RvHKiGJcum6zXQVbIJVQhHtJGSJXWCRJqYkddVj8Kg1pFCXE4+k1jWC39d/EprDkN/YyIHJqdNFycbltDLT0ihlEEb9HJqVIdLluMGYTjWUmGNeTfHX10yrWps226xhHylatReY8Yug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=windriver.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C62KPp6ERYeKZX/v98Owgzsq0n40YHcEQ0PdoQZfHFo=;
 b=ns4h2LolXr6ABu+m6KK83iPYo0B9FRdICaDo5SqVeh+ZhuKcQp8797pVP/Ha4UBKkjPhc47rRW5NTvo6gZeXvOele9ZULID71zGquhDVP33KgXHGn+X9ap1TQlJ0JB9shxHvmLIaoO5pS97v4/qOulF9Llr4GOaYn4ccOv5KZPcnN/1Nq++Dhm/YjeFUz+RaSH96eD6hepehI2ANwbjn5AYErl72ffIPahNwbGGFxGgbpXt/pBpbu3DdMqi4BjLl5b5eY+exIw6kZf1NTzKst0a1yIiWri5ugmEOlrboad4WmnZlhOlqp0WxpkzG5gUym2lUVj8Ql2acvz1qViMzKA==
Received: from DM5PR1401CA0019.namprd14.prod.outlook.com (2603:10b6:4:4a::29)
 by CY4PR12MB1431.namprd12.prod.outlook.com (2603:10b6:903:43::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Wed, 14 Jul
 2021 07:06:51 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4a:cafe::b1) by DM5PR1401CA0019.outlook.office365.com
 (2603:10b6:4:4a::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend
 Transport; Wed, 14 Jul 2021 07:06:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; windriver.com; dkim=none (message not signed)
 header.d=none;windriver.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4331.21 via Frontend Transport; Wed, 14 Jul 2021 07:06:51 +0000
Received: from [10.2.84.248] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 14 Jul
 2021 07:06:50 +0000
Subject: Re: [PATCH 4/4] Revert "mm/page_alloc: make should_fail_alloc_page()
 static"
To:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        Zhang Qiang <Qiang.Zhang@windriver.com>,
        Yanfei Xu <yanfei.xu@windriver.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Matteo Croce <mcroce@microsoft.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210713152100.10381-1-mgorman@techsingularity.net>
 <20210713152100.10381-5-mgorman@techsingularity.net>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <fb642720-b651-e93f-4656-7042493efba8@nvidia.com>
Date:   Wed, 14 Jul 2021 00:06:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210713152100.10381-5-mgorman@techsingularity.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef2c47eb-96f2-439b-8ece-08d94695f442
X-MS-TrafficTypeDiagnostic: CY4PR12MB1431:
X-Microsoft-Antispam-PRVS: <CY4PR12MB14315FFD2CAAB9AF91F44F25A8139@CY4PR12MB1431.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:747;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R1JbVqwtUJv5DhIKwStR7wR6mdTyGivhHpPJtsY1HwMmoQliSZ3/M9oZkJd3bv2YLbUsNxMiF+96gYCqVehAjKYOUBBC4cPmP6uLMoGTbT4H916j2VgH4Vrx/SqjrceqqnPhXU1r+jCCfRMfImeOfX4eyd7KewLjzHd1YKdSG/MMmWHsHOjjQIx8M1YMv87KszIGv7KfkNuq3s0bYZssQ4R2WotU/uQpPEmLzXZsnWMnQeewRdSnE+0Dtw66E/UbCvmor32M+UJMIR/i8HRyNMUGP0Ss4F9hDg0CltlZRjCTTh2dSiCbddwYofJlXtldjIL9jZxfL86EoPK09QQ5SBEt5hKNLJBUiz+MYpcy1hdq8FZ0xrOtoPUnyF9CiVHTA7Lel2Of/ab8LhdmZwxHS8jfsxcCKmZiNOVXieWfl2iXmMMg3wDvIVIubZZv+n5j9NoxLUtGVqNMj3E/SKFJd0EYNy3AGvt7zjvBemc8TQ10LJY5rXcVXjx7VnJwd4WIsuxo9Ivo8I79iEUopHNXIUJjBAvwuectci1btXJ33sVKBAqeb9HHuPv1GIjY6+Fy/nq/WutQBCeNXbsvHjrD/JxsZ4Td/IMU7U+W2TlglLTxZ8XMJk7rHHEA+/1uKcaF8PukKfqf9FR3H771Yq3G+gVtKILAsCiW6tD21uVduGC0decG7QRbUJNuv0yZUIJlxcB2YG6zgjIDL4vamXQunRTL1BQIx7a2tPgZxa+nRdSkKuYw5/khV4Q+/4/mu1tf5t2M4AGsncf193Nyo5cCWYGgKWCGTZnaulryZKAfzZ9hdICSXUBnNGPpd4uHZNs91zWAP2cXjZA7Xsk3I9GJOyBE3Kg+JQCc1Bz5Hjdhd9Y=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(136003)(39860400002)(46966006)(36840700001)(31686004)(8676002)(336012)(110136005)(70206006)(26005)(45080400002)(478600001)(53546011)(70586007)(36756003)(5660300002)(16576012)(86362001)(83380400001)(4326008)(966005)(8936002)(31696002)(7416002)(54906003)(36906005)(47076005)(316002)(426003)(2616005)(7636003)(34020700004)(2906002)(82310400003)(82740400003)(356005)(16526019)(186003)(36860700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 07:06:51.0500
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef2c47eb-96f2-439b-8ece-08d94695f442
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1431
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/13/21 8:21 AM, Mel Gorman wrote:
> From: Matteo Croce <mcroce@microsoft.com>
> 
> This reverts commit f7173090033c70886d925995e9dfdfb76dbb2441.
> 
> Fix an unresolved symbol error when CONFIG_DEBUG_INFO_BTF=y:
> 
>    LD      vmlinux
>    BTFIDS  vmlinux
> FAILED unresolved symbol should_fail_alloc_page
> make: *** [Makefile:1199: vmlinux] Error 255
> make: *** Deleting file 'vmlinux'

Yes! I ran into this yesterday. Your patch fixes this build failure
for me, so feel free to add:

Tested-by: John Hubbard <jhubbard@nvidia.com>


However, I should add that I'm still seeing another build failure, after
fixing the above:

LD      vmlinux
BTFIDS  vmlinux
FAILED elf_update(WRITE): no error
make: *** [Makefile:1176: vmlinux] Error 255
make: *** Deleting file 'vmlinux'


...and un-setting CONFIG_DEBUG_INFO_BTF makes that disappear. Maybe someone
who is understands the BTFIDS build step can shed some light on that; I'm
not there yet. :)


thanks,
-- 
John Hubbard
NVIDIA

> 
> Fixes: f7173090033c ("mm/page_alloc: make should_fail_alloc_page() static")
> Signed-off-by: Matteo Croce <mcroce@microsoft.com>
> Acked-by: Mel Gorman <mgorman@techsingularity.net>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> Link: https://lore.kernel.org/r/20210708191128.153796-1-mcroce@linux.microsoft.com
> ---
>   mm/page_alloc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index c66f1e6204c2..3e97e68aef7a 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3820,7 +3820,7 @@ static inline bool __should_fail_alloc_page(gfp_t gfp_mask, unsigned int order)
>   
>   #endif /* CONFIG_FAIL_PAGE_ALLOC */
>   
> -static noinline bool should_fail_alloc_page(gfp_t gfp_mask, unsigned int order)
> +noinline bool should_fail_alloc_page(gfp_t gfp_mask, unsigned int order)
>   {
>   	return __should_fail_alloc_page(gfp_mask, order);
>   }
> 

