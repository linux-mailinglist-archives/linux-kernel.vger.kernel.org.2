Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32C403E4703
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 15:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234486AbhHIN7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 09:59:50 -0400
Received: from mail-bn1nam07on2053.outbound.protection.outlook.com ([40.107.212.53]:21943
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233420AbhHIN7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 09:59:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cXoXuPSOi9fO+sRoivr4jY+UW0ogSlhEM2DRGyt2C+iq219SLRSEmBr5+fmi48cpKFMQWPn2lN7pNOheHXVGauBzCHnGiCTNcgtaq2fM9sB0qoJli1bUwqT4SWfTfzS0qqx32YHhsBEwvjzZTD1qLp1VKO5SGh2obqkG/M28ZvfVUgtIzN3rrRniOY43YAc8hAL5sHgb0X1kDfwOTJ2Cy8CfGL0IxQuM/5rnKhe2M4/eDTCi8Oj56xugc9KnLIHP6oIL82wdXj7201cAlbSkK3hPSI0jxRQQw2fFjvjc3msnaXzSRo/JH7AH9UJ9frlC5XbIHwgnp17NECc+phIdig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3eRbWHhZzn2awKNSPyPO8fgLWujwhN/CWNBwNS/d8I4=;
 b=TvTOiruy1FdRkTkgJPfEajrX4/cOGcDu4E9g/ZNKK3hug9ZD+ZKFrhN8Ew7IXfXMKrhYvvaVaNgbe+0lfJu85+G//K1P9LBLCXBB7Kg3+Yi7g3UQWtDMAmNPoEaeen4SXhGRkFFSL0QGtF6E0CAGvMoRx7Srj/pVpScWfFApoELnDkGQjVuhl2+i1UFt9ilP113Au8nnwM8kn316BfGlsGgYpj39ZKVAs39E3u1jfEoeeZ+QSDprPOBlhMBFu1TsXILGEmWep8GI+ChGTq9dUnUIlZNKs2Rp0MZ4tsFSTdNdU1EUEiSUhLLYJ1driU6jb4BSF/CpawqzvF2nM+wyjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=kvack.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3eRbWHhZzn2awKNSPyPO8fgLWujwhN/CWNBwNS/d8I4=;
 b=H0ast6D3L6M2wWCepqGqgq8Blet9raVlKFIJP3ktge4HUHz4rR+7ruBIjzrQC1nMOE6nx7sCuB32pFfCo/pfU4d1yLxSQn4vMC4Orgf7BFH13VLPip4Ky9TjaWEHtl+VGmHk4zJfAMv8dGeMRoM0Mv9rZhjGypPIN7+tl1atRbumURjazv2G8FBQSVO+heSzvAGN9lTepPtu6lPYtqLpmvv9xeRjRMFd9BWwKzdUbGt/FvYLCSh/9evVdVvzVqljbyZygqw8XNj3ytkdbE0qhUnSxCv3itHodWhS2SarLbWxmmD3bP6RcMMJYUrHSY5H50sDTxcnevLf5hrKTsuCAQ==
Received: from BN6PR19CA0088.namprd19.prod.outlook.com (2603:10b6:404:133::26)
 by DM6PR12MB3737.namprd12.prod.outlook.com (2603:10b6:5:1c5::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Mon, 9 Aug
 2021 13:59:21 +0000
Received: from BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:133:cafe::56) by BN6PR19CA0088.outlook.office365.com
 (2603:10b6:404:133::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16 via Frontend
 Transport; Mon, 9 Aug 2021 13:59:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT062.mail.protection.outlook.com (10.13.177.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4394.16 via Frontend Transport; Mon, 9 Aug 2021 13:59:20 +0000
Received: from nvdebian.localnet (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 9 Aug
 2021 13:59:19 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
CC:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/5] mm: migrate: Fix the incorrect function name in comments
Date:   Mon, 9 Aug 2021 23:59:17 +1000
Message-ID: <3794249.AHpkRrbP1t@nvdebian>
In-Reply-To: <433d0be927c0cae047a4ca04feff0a1dccefe324.1628174413.git.baolin.wang@linux.alibaba.com>
References: <cover.1628174413.git.baolin.wang@linux.alibaba.com> <433d0be927c0cae047a4ca04feff0a1dccefe324.1628174413.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b327992f-629a-425d-7a18-08d95b3de324
X-MS-TrafficTypeDiagnostic: DM6PR12MB3737:
X-Microsoft-Antispam-PRVS: <DM6PR12MB37379E78496EA0505FE253EADFF69@DM6PR12MB3737.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:446;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RpPbRIZ55vGNCYfS+XGO9Gi40mjUNULDnE3OsZqIsT8dXtuE0SJheqO7uU73+B7vcWHoa/PiLqeeok9rPHKOI5STctYXnBh+HcxL4VyffFkuo/tHVgToKODtfUzzOyHRRlELcx6G7zxwv1RJKTsPaoQItiTZkfDb0JFS08qMhbIDhSY/pqfTvJkp8YuKfx10hnANQofEdpUEsFga8yN29TK8Iv5CJIJhfJ9azvR6RIr7iBmQVxjBMaLvUKMcjc8yqD2aHVZPaQm9pidzEu/ihZ+FlefopUBQ709wJ1fvrAazPWvma8e8jzLHX92QAmGWk3mbI9f+y/8/t7ziio155Hx+T+tawj3xNHl5RZsWWDz3//dndGHCxKy9EVY3DwX3dU17Sqxpf76KJ4q7DrNeWXwWS/XCmRb2zTtRdDAHqQVO3FPLEMLCb6xhDroH/T/S1acmCLD+Kc54p/mtlJP4yDUntNBTwI0NjMopPAWsBjKoTdvLN+zYFFwNqqvfEid4WTTqUu4Kc6XGjy0gOY9A28ftn8MoIhnSORQkJCc7kl/M1/2AbY09mN9YurIpviDHuQRro8N6RW6R1NxiRRfIjRAAR57ci9JmptjlZjZhUVqBjwBN5IKEA+Cpev1el5VjULsxI8YekX/nvI1D7YygAoAB3YWRGDskDyBFvolMSv2qdZCVpZWb9idMh2slQ0bP2og2P287UvjdjWXKFGCNXFiGrz6TNJ3yc+h2pGWN9Y8=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(39860400002)(396003)(36840700001)(46966006)(9576002)(8936002)(70586007)(36860700001)(8676002)(82310400003)(83380400001)(70206006)(47076005)(36906005)(2906002)(316002)(356005)(33716001)(6916009)(9686003)(7636003)(478600001)(186003)(54906003)(336012)(82740400003)(426003)(5660300002)(16526019)(26005)(86362001)(4326008)(39026012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2021 13:59:20.9038
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b327992f-629a-425d-7a18-08d95b3de324
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3737
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for catching that.

Reviewed-by: Alistair Popple <apopple@nvidia.com>

On Friday, 6 August 2021 1:05:58 AM AEST Baolin Wang wrote:
> since commit a98a2f0c8ce1 ("mm/rmap: split migration into its own function"),
> the migration ptes establishment has been split into a separate
> try_to_migrate() function, thus update the related comments.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  mm/migrate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index eeba4c6..6f048a8 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1005,7 +1005,7 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
>  	}
>  
>  	/*
> -	 * By try_to_unmap(), page->mapcount goes down to 0 here. In this case,
> +	 * By try_to_migrate(), page->mapcount goes down to 0 here. In this case,
>  	 * we cannot notice that anon_vma is freed while we migrates a page.
>  	 * This get_anon_vma() delays freeing anon_vma pointer until the end
>  	 * of migration. File cache pages are no problem because of page_lock()
> 




