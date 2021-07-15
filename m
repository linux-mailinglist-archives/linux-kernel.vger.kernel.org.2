Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE6B3C97A2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 06:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237674AbhGOErH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 00:47:07 -0400
Received: from mail-dm6nam12on2083.outbound.protection.outlook.com ([40.107.243.83]:4321
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230256AbhGOErG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 00:47:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kv90uNmY8R4Vfk7NtukkOWEORBYC+Oq4ZQsQGg25KMCnWUXeziZKIDqn4jmjNi3Sen7p4z87SPG1FTzG+I5ue61bkEE3ONuuZknuXrnLns58ZQbXSzV1C/UL6BCm9/0+Aty0s4rJ7Uen9Pxm0gP2/CJ/mftzM5XCpkyFti5HDgwaCslIr/lHGMgGlQv6Ozfo/THrQCL7afDkv+eIn9ti/edNL1qTpGtCBOeiw3xln6BJxTZrP6YsSeV5RJO3IqJOBmWsgWokViTgtyi+64NWoY1/7DFM6EO57Oe6q1OmV9t5ZHk/3HKH8Tpjf0NqynsragD4qOjSthlaCOXpew/gDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mVGWvoB2IGwoNBsAtn0dydCdtBKFlCrZkbSKK/EZYaE=;
 b=E+IcT0/l+V3w770vlzoxO+t1e/YReLLm3Cmqb5Wdl9kAUKnkFkTM/wSMyqFDDuq7Wmz4OERz687LBER+tKl4g8HmQ/RrdmF8XVZ+dOAKRmaMeDeXa2SzISpmdi7l6BisD+9XlkpZFiNVapwgpZp7nKyVxv4xhwzBgl8eaBoh6dUPQCOLyeX5I/qveRdMFEmf9vJBtQJY5Q7kVGJ6WhiM51Wc0pf2E+exKC/ysTiLMn8KGNF1jJ+lzsC+hrWzDFkvLQ5kNYYW2WrUB2EQnoHNGOcTL0crVBOnW6trldT/IdF6j6dDlmxBySZWWqv0KMANbLCafIQskS3YqozDf0btyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mVGWvoB2IGwoNBsAtn0dydCdtBKFlCrZkbSKK/EZYaE=;
 b=lJ4gPrrqDc6k9xls028MttBvcrk+jy7shXMIJKaxLZfDUxpUWjNF85H2x0l5zOjLgXQPymx35j0pGeXhbvuzAjWKYRp1BbXVPLzvdcF67HCbz+Y0MPELzNxAmz53LzA1TyWZjR8NEXiVJSxSG2u6PFIIcYkLVmTOz17JKHEn2vRX0Npz40Qmcap/tdLAbVUF7tuuCYjaB/gYJ5ip7fRy7zo4gFuUdYpbkOlNpjMnn8yOEQtj+ydYiAvvqIgGYKGHFjB7IXQyFYhm3STMOCczlE02OwrRlGXPaaOs8q8xfqS6OgkkphfsAs3DwTXwqrx2Z/v5qCvW37wqwJrIoM6ubA==
Received: from DM5PR19CA0062.namprd19.prod.outlook.com (2603:10b6:3:116::24)
 by PH0PR12MB5500.namprd12.prod.outlook.com (2603:10b6:510:ef::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Thu, 15 Jul
 2021 04:44:12 +0000
Received: from DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:116:cafe::87) by DM5PR19CA0062.outlook.office365.com
 (2603:10b6:3:116::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Thu, 15 Jul 2021 04:44:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT016.mail.protection.outlook.com (10.13.173.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4331.21 via Frontend Transport; Thu, 15 Jul 2021 04:44:11 +0000
Received: from [10.40.102.103] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 15 Jul
 2021 04:44:06 +0000
Subject: Re: [Patch V2 0/2] iommu/arm-smmu: Fix races in iommu domain/group
 creation
To:     <robin.murphy@arm.com>, <will@kernel.org>, <vdumpa@nvidia.com>
CC:     <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1623961837-12540-1-git-send-email-amhetre@nvidia.com>
From:   Ashish Mhetre <amhetre@nvidia.com>
Message-ID: <984e45e9-5dc0-fcdc-fa60-179faccb3715@nvidia.com>
Date:   Thu, 15 Jul 2021 10:14:04 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1623961837-12540-1-git-send-email-amhetre@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 347b066e-bd09-4f44-b815-08d9474b30c0
X-MS-TrafficTypeDiagnostic: PH0PR12MB5500:
X-Microsoft-Antispam-PRVS: <PH0PR12MB550022CCED633794FA5367A8CA129@PH0PR12MB5500.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F66/Wjd4+r/9Rbn52tOhKR8yTSefX1L+c7GDNRmXAOXxHm2uMsDbRyg5+QpBu6A17RrtHxHA3IeNqxT96zOpZ0M5gNjsZElShCUOZrB7SniExdvppLTFTQ8/ilCrRmUf9Id1ThXik8VEBq1KtA1DXtugv57UeDmHdctGpJVwDjPwKCmygwWq5HHA2lK8JdjgzWs6tJdpamM25ug3ZRRmPmmVEQiL1JEy0YWq1bMXL1Egjj3nHG6C//BIOWe1vUk6jCIavMYlWhAiquYIXLkf+ZJ6mKj0V6KS2aZv65Ou6RMe10PRt0n2f1LjF+brFg7Vwqt518jHog2BIngd43Ep7e4YP03sd1ZVOZGe+4LszkWGyAtU9N3ZgE3YnV6+OhjZClBdz1287x8hz+Hf5wogrXMdTbJ4Dy/Ki0MdOXLhRJiaajix2VCq4SsZY+d5g7FNlFrSU9fyXWgGOIjBSsfhimxp2jzTntkpCzRFVV6Y80BRtvQiDMqH61tRPW7r3P3MOQjhRXrIwVDfJ2ETTFS/LgcY7GcT2SZ/hlRk2R1EHMFwpgSPRY7psV2pCtvkEsF/C9SxDVl+dM3reX7rqd8BAtAQEKU0nNx2i1Wf8RzkPmWbF0ChnU9AZ/2B89iX6tHQW+v1NMQ4KH6QqzckuNM5TX5ss2gSZiB6A9xxAeBKPpvdBeK41bbD/PU1OJgLivpnd4nuzguQI16xZ1Hq9fbCnMH9TyvJBb4wPPoBs+sAhbpe7GDm9teNdOCMpCv6Zzj7lzj3teemWUrMwS8yQTCAxQ==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(39860400002)(346002)(376002)(136003)(46966006)(36840700001)(34020700004)(186003)(16526019)(36906005)(4744005)(36860700001)(110136005)(82310400003)(83380400001)(16576012)(31696002)(7636003)(86362001)(4326008)(316002)(54906003)(31686004)(356005)(336012)(53546011)(478600001)(36756003)(47076005)(2906002)(8936002)(426003)(82740400003)(5660300002)(6636002)(8676002)(26005)(2616005)(70586007)(70206006)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 04:44:11.4562
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 347b066e-bd09-4f44-b815-08d9474b30c0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5500
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/18/2021 2:00 AM, Ashish Mhetre wrote:
> Multiple iommu domains and iommu groups are getting created for the devices
> sharing same SID. It is expected for devices sharing same SID to be in same
> iommu group and same iommu domain.
> This is leading to context faults when one device is accessing IOVA from
> other device which shouldn't be the case for devices sharing same SID.
> Fix this by protecting iommu domain and iommu group creation with mutexes.
> 
> Ashish Mhetre (1):
>    iommu: Fix race condition during default domain allocation
> 
> Krishna Reddy (1):
>    iommu/arm-smmu: Fix race condition during iommu_group creation
> 
>   drivers/iommu/arm/arm-smmu/arm-smmu.c | 6 +++++-
>   drivers/iommu/iommu.c                 | 2 ++
>   2 files changed, 7 insertions(+), 1 deletion(-)
> 

Hi,

Can you please help in reviewing this V2 change? Please let me know if 
anymore changes are required.

Thanks,
Ashish Mhetre
