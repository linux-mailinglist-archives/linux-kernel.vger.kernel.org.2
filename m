Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06DBB3BF280
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 01:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbhGGXg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 19:36:56 -0400
Received: from mail-dm6nam11on2050.outbound.protection.outlook.com ([40.107.223.50]:60513
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229986AbhGGXgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 19:36:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LB8ctZFFTsWUzv71Z/jzuKjhGGCTD2vouV7dA2DrAxl/R/2H+b7CFjhBb4UzFDrISbjUeg3SywX97Njc96fae9nT6c+I+1e8ko+OjpsEoZ/xqeMMs+FVgrRpk4T6muNCH8hskOrQkVQ84G8zaMwfa2SO7UL7rrPWh46mSfqgLGY65Mnp/5OkaU495zL0nJTrtYinC+kKQOlYNqNc0jG+M37wkDIhl//1eD+Hlpq0sMBHQRQYKEFCdZ4AjO2oSkTyNM8ZXBXCrvjd8wpCgVnqlMjBd7Gw/LhSKiX17JZgL9l6lNpuMDAZLZREv/ngIV+7ekVKfLD/OoK7KCcKVJ1xBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9397/KiD12zJ6cIVVX4YnyuUNpd5SrZ+3vDL8N8abjQ=;
 b=NtR0pwuVFkuLSGutkf2XabUsSEpEyvHBCosQ1B2MH510DWyJY6jqAr7Uh7SvQGz0bcZj9Bj4PWSHrsBls+hR+aoI/EmZTPOcP6jj9dxQD4MWSX2h92gsuo2U3mWYC2tfX5upPanjTmRIL9x1Am5IbK1va4d2+s8P1YdNF+ed9xIXl5M3BZ1vvEwFOnM+4aq5ExHhvgImGrdCLRuUQBfXwAfbIVStebGzzIdR90Zns/A71Xjh8BUdTFd5MQ0FPwB/XVq76lOii7vZRTqa1lqu2hOcedbi6ubNT2tisX7WXMyNlcejXH2FCNyECUTS8LeBb8tNfTWERGnKBp+0I41yoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9397/KiD12zJ6cIVVX4YnyuUNpd5SrZ+3vDL8N8abjQ=;
 b=iYYUhX+wISw4/hQqRqmsb/l7ZpRWhIVEghGtJUu7xexyIrZo8lrmVh+iKC4b+cOP1dwD3xK782n9kHlGn3pkpYydE1Bv6PJdYF9tU1Ow8idboCragkg4VqGNm+a3KZCWlSfnDjBWRbBipZ967KgrksNOQfrW4MCMtf8BpNhbR51MfW/03Ogd09AhBJ3+/6w87zZ6qJk3CVYih4ku87Rekc7L/0yjD1a4zkQ8+asLA1ADBc5XfAYnWm2+GhTxpWbJohM7EpM+yDgSXngM2lUQM8GH6Fkv8RK346zVS0U3uSltVH5ddTuaa9B3uw74rXjHiMsP82CvvhZu7uRtdkZUYw==
Received: from BN6PR14CA0044.namprd14.prod.outlook.com (2603:10b6:404:13f::30)
 by BN6PR1201MB0226.namprd12.prod.outlook.com (2603:10b6:405:56::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.31; Wed, 7 Jul
 2021 23:34:11 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:13f:cafe::fd) by BN6PR14CA0044.outlook.office365.com
 (2603:10b6:404:13f::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend
 Transport; Wed, 7 Jul 2021 23:34:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 23:34:11 +0000
Received: from nvdebian.localnet (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 7 Jul
 2021 23:34:09 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     Hugh Dickins <hughd@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Christoph Hellwig <hch@lst.de>, Yang Shi <shy828301@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Shakeel Butt <shakeelb@google.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH 1/4] mm/rmap: fix comments left over from recent changes
Date:   Thu, 8 Jul 2021 09:34:06 +1000
Message-ID: <3151223.1VNOB2ufYa@nvdebian>
In-Reply-To: <563ce5b2-7a44-5b4d-1dfd-59a0e65932a9@google.com>
References: <563ce5b2-7a44-5b4d-1dfd-59a0e65932a9@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1dc7a24-6031-4eb9-07a5-08d9419fb98c
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0226:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0226E912D9FB87B90AFB1E8DDF1A9@BN6PR1201MB0226.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Riog5wFuGuGUv4KuA+jUYO8B1K5o4SU3997ZTaBvwtK7Kg2vgswzAP81rzijSC+z08mTCUCpefx8AtcvXXOBJy9axn/spo/aCb8jZuM4x7o8DHDBQykfO+MT6boI76rYVVQGYHx6JSC9KeHdtUAm6ZbLWeX9/h2Cnk6RmO4nJIxzYQHZeN+YowPzXnTaZV+L5LqyvurMd1TSEip9CMMLaeOR7rXHJ+2o//IzyQY05R/ebGz0htJ2tAyXlt/NVliEP7DnERMVg8zeklFjQYt6xkMs7OOipVnv0PZgrDp6x1LN2eD3OVSWA7H2xY/MDK78rIs+qfK24vz75sus8QOZCiMZj+fmj1QgjYsqbPH+lpWTMQ5k/g069h1GBenAFhItZWxRiyooNftdJuBQqSad8ZK0cb8R+LijsMBcFuY38NCRXWMbt+6Denc1GpzbnI/XFPBzY/2oxqKaYrdddGoopcttl/D+nakk9BpG8WbnO+0rIrIP5UXQi6BUfxsMKZgUYvGjx/L3yDSYlmpn+uYWFYtcOuaOETNzAR3HvLbUsI4PfAKCcwE4eiDknsn2r9HtFnXQcvb2EXOKQUaiX8kG5I8Y+G8gQNIexFMBD6JWYRp0DTAbgCQCIqGQvo5ndOa6vf1Y1DBZZZPglURZPm28+F/Goz0AL3zBhlWrqb4JZupWZaQlL8OU81XdgVTdEB43qQMRMYi4PhOGB3dmDWmQE7LNH3kNQeLPNsvkz9k36XU=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(396003)(346002)(36840700001)(46966006)(4326008)(8676002)(26005)(16526019)(336012)(5660300002)(54906003)(47076005)(7636003)(8936002)(356005)(36906005)(478600001)(9686003)(426003)(316002)(70206006)(9576002)(70586007)(6666004)(33716001)(36860700001)(82310400003)(6916009)(86362001)(83380400001)(186003)(82740400003)(2906002)(39026012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 23:34:11.6394
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1dc7a24-6031-4eb9-07a5-08d9419fb98c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0226
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 8 July 2021 6:06:17 AM AEST Hugh Dickins wrote:
> Parallel developments in mm/rmap.c have left behind some out-of-date
> comments: try_to_migrate_one() also accepts TTU_SYNC (already commented
> in try_to_migrate() itself), and try_to_migrate() returns nothing at all.
> 
> TTU_SPLIT_FREEZE has just been deleted, so reword the comment about it in
> mm/huge_memory.c; and TTU_IGNORE_ACCESS was removed in 5.11, so delete
> the "recently referenced" comment from try_to_unmap_one() (once upon a
> time the comment was near the removed codeblock, but they drifted apart).
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>

Reviewed-by: Alistair Popple <apopple@nvidia.com>

> ---
>  mm/huge_memory.c | 2 +-
>  mm/rmap.c        | 7 +------
>  2 files changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 8b731d53e9f4..afff3ac87067 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2331,7 +2331,7 @@ static void remap_page(struct page *page, unsigned int nr)
>  {
>  	int i;
>  
> -	/* If TTU_SPLIT_FREEZE is ever extended to file, remove this check */
> +	/* If unmap_page() uses try_to_migrate() on file, remove this check */
>  	if (!PageAnon(page))
>  		return;
>  	if (PageTransHuge(page)) {
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 37c24672125c..746013e282c3 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1439,8 +1439,6 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
>  	while (page_vma_mapped_walk(&pvmw)) {
>  		/*
>  		 * If the page is mlock()d, we cannot swap it out.
> -		 * If it's recently referenced (perhaps page_referenced
> -		 * skipped over this mm) then we should reactivate it.
>  		 */
>  		if (!(flags & TTU_IGNORE_MLOCK)) {
>  			if (vma->vm_flags & VM_LOCKED) {
> @@ -1687,8 +1685,7 @@ void try_to_unmap(struct page *page, enum ttu_flags flags)
>   * @arg: enum ttu_flags will be passed to this argument.
>   *
>   * If TTU_SPLIT_HUGE_PMD is specified any PMD mappings will be split into PTEs
> - * containing migration entries. This and TTU_RMAP_LOCKED are the only supported
> - * flags.
> + * containing migration entries.
>   */
>  static bool try_to_migrate_one(struct page *page, struct vm_area_struct *vma,
>  		     unsigned long address, void *arg)
> @@ -1928,8 +1925,6 @@ static bool try_to_migrate_one(struct page *page, struct vm_area_struct *vma,
>   *
>   * Tries to remove all the page table entries which are mapping this page and
>   * replace them with special swap entries. Caller must hold the page lock.
> - *
> - * If is successful, return true. Otherwise, false.
>   */
>  void try_to_migrate(struct page *page, enum ttu_flags flags)
>  {
> 




