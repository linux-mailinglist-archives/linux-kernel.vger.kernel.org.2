Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C12EE3BF26C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 01:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhGGX2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 19:28:23 -0400
Received: from mail-mw2nam10on2049.outbound.protection.outlook.com ([40.107.94.49]:64257
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230029AbhGGX2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 19:28:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QySDjtmd6vlXdeaK0a6WbezSpoIsuj1xMu97Z09oZzt/sY330+IInyEbKDnv8341PS3k7AymfgrnGxlALWHMQx6hsssPP1EV8soxYHNSNc4lDyt5NhSXpCpzgtZVXN4gX3pz1/8MoVPhGq/44yuB3EqXjySw1Ln15KguzMqaZR3kEnP9BkG+LhxIAPeDnU3qdzYTbUnvip6oPoRaSP+T5Z1SRVPs9KL8p62TX1r2VoiJkHJfPp6QAsW806FJ8ZrbeDPDpzRaHI671TNtIcS+93zMORFftlA487Pw24076IrGbRfQSL3lvE2pAkpMh6xlv+TXXqu2ZYlUb3aURdB9JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQPFQaX8hF9PWP0xmBCLhgvXczth5wOSQMI2myO1Q9c=;
 b=TctfWjKVax4eGowJF3NZYbJatjMBxh8eKwCFdTyAQQ7KT/m9tkoBlfySn2VtbvTd4DmLelPevcopwyAegVX4XyGAYTXl2PSVnKgM+hOhxOPD5B65FWUgIrw8LotSUPj0iBiBtsscb4toCs73Vbcqx+gzJ9DTlF3i3Ty18zgCZEp/djFSLp4G/XB87ydhY0IL8qjAfFfTl3l772xC8MB1STUanfgnQlfK0w3htVWDpVGj3C8SMb0LkcStu9vc+vaBrkmClNFRBMWjhhNAaeQAiEqM35n1PkGKwybpz9HmrHX8wEbGKvSPMc5Bp3Ul33MAYxLqAdCJDDZH5tpVv5b3kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQPFQaX8hF9PWP0xmBCLhgvXczth5wOSQMI2myO1Q9c=;
 b=bYUkHTUkb78hFVw8K/ujG605ZjrKfz6NKgu75vNduOfzz+cbapywpjjs6qLfLvePZ5f1g2tf2NYZ6Qb5FRIHhfQe25rJVMXdHyWS+v9dLvVj9UT7nRvuHv8O54Lq5O7H9x2Hdw6XJ0Dwa6dEp5wqyoFi07wQevCG/CMxPvLdnbYckb2TEgp/tUPVtZ0kLhFgAM4z2luIorFCdF5+BW2hbNF3FhbgDkj1N8Sx+in66Sxtus9aS2gJqI6wuIEDej8H6LypLo4yYLHPVd94ocAKGikvRDR2k4sANczTcE4kLYmn+3DJr2ATgjRJczB0yzlPrk0zwV/7IPWTG020MNjBlQ==
Received: from DM5PR06CA0030.namprd06.prod.outlook.com (2603:10b6:3:5d::16) by
 DM6PR12MB4958.namprd12.prod.outlook.com (2603:10b6:5:20a::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4308.20; Wed, 7 Jul 2021 23:25:39 +0000
Received: from DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:5d:cafe::6f) by DM5PR06CA0030.outlook.office365.com
 (2603:10b6:3:5d::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend
 Transport; Wed, 7 Jul 2021 23:25:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT035.mail.protection.outlook.com (10.13.172.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 23:25:39 +0000
Received: from nvdebian.localnet (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 7 Jul
 2021 23:25:29 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     Hugh Dickins <hughd@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Christoph Hellwig <hch@lst.de>, Yang Shi <shy828301@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Shakeel Butt <shakeelb@google.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH 4/4] mm/rmap: try_to_migrate() skip zone_device !device_private
Date:   Thu, 8 Jul 2021 09:25:27 +1000
Message-ID: <10361513.bhMGeGFVFl@nvdebian>
In-Reply-To: <1241d356-8ec9-f47b-a5ec-9b2bf66d242@google.com>
References: <563ce5b2-7a44-5b4d-1dfd-59a0e65932a9@google.com> <1241d356-8ec9-f47b-a5ec-9b2bf66d242@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 463de85e-6421-41b6-6799-08d9419e8824
X-MS-TrafficTypeDiagnostic: DM6PR12MB4958:
X-Microsoft-Antispam-PRVS: <DM6PR12MB495893BFD4C81A1AF6BDE9E8DF1A9@DM6PR12MB4958.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RzvuxCorO9dx2CEMBuHHBr5gGIkV+Fb53DkktVkrsO8R4Td3HpQWebKqEKsEJXZzebbOHspDDuXzShPHYCu2dCgH2sRiZHB9Wiahx7vdmmw3f9P/rzROXnI2r1s28+v/1XqiucOqLtbBrsphtMTApmyX/oOHDBQqDPy5bOTpvq5fWVMuB4ryO1V0oS009jwEJMdE/pPugpuMjuXgOpx1rTlp7TS0PgukR8Zd2OvZvDmugViIwZ39M90fIMJa6vpai2cshZh9kCZnCmVUoyJUD0ri0r4F9sv7T+xDW52UPNGYwJz8aW0xjaAqmT5h0GNWvYRr7GISxAsVKW5dawhSqLF1UQfR67/GPC6Ds2cbuwYxOThFObTEEnxufT4dtIcDJtQNelQFZGQOLbmmkpc87NgQnISw5NTiIu/4B+4rv8Q6SxlDdClBXUhVIK9zZtP2manzUoduCLTxYCZo2bIYDWBVStl+B1mxJa+TPjr1Xn+gVm48kYeGQQFYCEM7YlX1PeiFGE0bwXaTYYtpzsmxBZcNDbroxpZtb0XnACqVE763jKkpVla0RcefB9JJP/Am092uyCYcVzkDBn8qkedZ9BzhOvWQfXh3qMCQGIquE1bkqibKoBdCpqKPEuF+JFC+ZAYI21nVoaKLk/FEbeaEOiJsKX/lkj3nW7zhRbkQjdH14q2kmAe1zcdDJlDlZjmA8+fF6vG413Yy+pInnEp02Q==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(39860400002)(346002)(36840700001)(46966006)(9686003)(5660300002)(36860700001)(478600001)(316002)(47076005)(2906002)(36906005)(8936002)(9576002)(54906003)(6916009)(70206006)(8676002)(26005)(4326008)(82740400003)(83380400001)(426003)(7636003)(33716001)(82310400003)(70586007)(186003)(336012)(86362001)(16526019)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 23:25:39.3381
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 463de85e-6421-41b6-6799-08d9419e8824
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4958
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I know a bit about device private pages but not so much other variants.
try_to_migrate_one() will work with private pages so in general that check
still looks good.

Reviewed-by: Alistair Popple <apopple@nvidia.com>

On Thursday, 8 July 2021 6:13:33 AM AEST Hugh Dickins wrote:
> I know nothing about zone_device pages and !device_private pages; but
> if try_to_migrate_one() will do nothing for them, then it's better that
> try_to_migrate() filter them first, than trawl through all their vmas.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
>  mm/rmap.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 1235368f0628..795f9d5f8386 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1703,9 +1703,6 @@ static bool try_to_migrate_one(struct page *page, struct vm_area_struct *vma,
>  	struct mmu_notifier_range range;
>  	enum ttu_flags flags = (enum ttu_flags)(long)arg;
>  
> -	if (is_zone_device_page(page) && !is_device_private_page(page))
> -		return true;
> -
>  	/*
>  	 * When racing against e.g. zap_pte_range() on another cpu,
>  	 * in between its ptep_get_and_clear_full() and page_remove_rmap(),
> @@ -1944,6 +1941,9 @@ void try_to_migrate(struct page *page, enum ttu_flags flags)
>  					TTU_SYNC)))
>  		return;
>  
> +	if (is_zone_device_page(page) && !is_device_private_page(page))
> +		return;
> +
>  	/*
>  	 * During exec, a temporary VMA is setup and later moved.
>  	 * The VMA is moved under the anon_vma lock but not the
> 




