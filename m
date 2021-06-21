Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 868DD3AE8F4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 14:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbhFUMWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 08:22:41 -0400
Received: from mail-dm6nam11on2070.outbound.protection.outlook.com ([40.107.223.70]:11940
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229621AbhFUMWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 08:22:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MRK8aLTMTUYHnF6FO86EBDWENA6TeYgqR7HQgz542dF2xIoE+cPFtB8RXQcM5qmbVq0m9DQpjNG+bTjW2hj/VnUNKIpYv3zHN8yN6XW3tUsEV4R+WlH1eIvU+wHpuD9bbjwu7f4Qzf2mYKyYzdNse+1WUq1ER4Hy68QUZ4UGoGOtGdq943GVFujBM9HTpndbIgZ3CjXkczjngWGiZU8Fc8+tojlVEp/FMsWw35fVMQNoqEi2Cr8sn/gPBXLsWtQVgrSKcs6NOWgI9LCvuc1F2kKd3+nRvx6fJepu3zYfcfgEBwrzNUKY48uJASdtkwiWOnPo+Gw8N+VGqxDjzkFWBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFz/GKhX4If0APAqvL/Qrxz4n+2mDLjjUNJIdxRs6rE=;
 b=Swd4I6BLZgCw5JxM057bBF7A0LN3aQo32sbDMFVKUiPgdBlCoq5zaigKsYYdJHdVG1pqSfx4ahUGY0RzGiKGsSe1RjKotfEUqDvHsv+m6y0NShKYTW45CQzuy/Jg/BIZ1kFwHy+Lr07FGbVbib3X0EqF7Y3uNTQYUf4t0V6eyKF6rnXkyOAoiKlzjkmhz2RqY/TwpigpIG1VLzSzSMejox7WHUPdCsfiHkawxRYDsR9Pi3NBbjEeVlJyZGIoH+X3lL3EmILhTKblIo62ZelijgNaWss3DLemh+eDtS3mfFhRrlI5tS//23vMotsy/jZtFvOtBO4Cgz78XgA/+vM/kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFz/GKhX4If0APAqvL/Qrxz4n+2mDLjjUNJIdxRs6rE=;
 b=rM+Htl/kllsb3eWv8K2qMU6UuC/AJ9xxpLeYBNy0DcDgcv/35fE9cXdJexnPtJ7Hs1cuEbqvffzWVME5C0ttUE7J/l0PmY++jzhzqvItc389RkZDHlKzftIDe+3gZthjy5hjLvBLUlVtB1utuMy25wCkP6CER3UH1Td7C2Ohvi6x1bu2OgJ59b4PiYjhdnnoaLe1i5jWu4VO6Zh94RTDCut2u/U079UMaXAmyNQlIVq+bJt4IhWK10M+Ly5AVZw4StHywPJAZMqgSGWOQXRapeSfnKv1JTN1mL00LYGoVsz3u+8Qw38AHVz7s5oSNzPJatgJ4pKtZfmbTWTXzHOzuw==
Received: from DM5PR04CA0041.namprd04.prod.outlook.com (2603:10b6:3:12b::27)
 by DM6PR12MB3324.namprd12.prod.outlook.com (2603:10b6:5:11e::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Mon, 21 Jun
 2021 12:20:22 +0000
Received: from DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:12b:cafe::2a) by DM5PR04CA0041.outlook.office365.com
 (2603:10b6:3:12b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21 via Frontend
 Transport; Mon, 21 Jun 2021 12:20:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; linux-foundation.org; dkim=none (message not
 signed) header.d=none;linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT030.mail.protection.outlook.com (10.13.172.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4242.16 via Frontend Transport; Mon, 21 Jun 2021 12:20:22 +0000
Received: from nvdebian.localnet (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 21 Jun
 2021 12:20:19 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     Peter Xu <peterx@redhat.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH v3 07/27] mm: Drop first_index/last_index in zap_details
Date:   Mon, 21 Jun 2021 22:20:17 +1000
Message-ID: <3005339.A0vROtebHW@nvdebian>
In-Reply-To: <20210527202126.30790-1-peterx@redhat.com>
References: <20210527201927.29586-1-peterx@redhat.com> <20210527202126.30790-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 935db238-39c9-4cf0-414a-08d934aef113
X-MS-TrafficTypeDiagnostic: DM6PR12MB3324:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3324867F9DCFDBA1BD099552DF0A9@DM6PR12MB3324.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uESCH8jH5e7+rPr9Dr0ZLkhpFdE9md5somkX5B+gMJ80K5r6Ac7StpLHFF/ADOowonIdXlmwaUJ9HWw+tSv7opnY9jHtipa3Z30t1lZ4QhHjYuccLjD5qGbKuF1NCevoC3ow4lTMZOP0MghpZE55f0G9LJLo/UN63Rr1W3rgY/p3wHrFukNx1bCFRCxwIQc602x9UG6v586T7CcRWq0A+tpQgTeCnjgwYgpMkqqcjCns6F0zvbQiV2sF2DTC9RmCkfGKLUdvdJAHlDEEQJ4Ba+gh8xPAQZaZP+Ov54KEmquIIKW3jTITmzm0fEbe025VlPLPAk6i4DRxQTf12KdOCw8Syc3c7JRBtdtWhn5fTMMRec6KqvWR0yoE/vlZOLQ9YwK6HqM8j3eQK8GS0mSoRB/tiHuKUyE+Pl9DEQmujyNKHbCOYjuJHJskMm8KOD066ImVCcsnv55N3eDtctkNIduC4vUKAsLDNm3v+Sp6RDT4CdJCVPIswPgIcdELO2B5I3MtNEvpnqbEAyY79d0StsSoUi3TVhkG/7yKew6UXCxiRKeyLE+GXLjYzg8ApceVkL89JDod51HE4Ud5d6I0wZ6y9lib3KVMIJVbOraXXdc8PMYjdxzi3zw/DMbySZ1fuSsZiXRKymZw1fHfSGeHss+ujLm6ryUAgVig6hfnzL+01ZkvZuLA8chAmZs4foA0
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(136003)(396003)(36840700001)(46966006)(356005)(33716001)(186003)(36906005)(16526019)(336012)(426003)(316002)(6916009)(4326008)(82310400003)(2906002)(82740400003)(26005)(86362001)(5660300002)(70206006)(7416002)(54906003)(83380400001)(7636003)(8936002)(47076005)(9576002)(9686003)(8676002)(70586007)(478600001)(36860700001)(39026012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 12:20:22.1991
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 935db238-39c9-4cf0-414a-08d934aef113
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3324
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To me this looks like a good clean up that won't change any behaviour:

Reviewed-by: Alistair Popple <apopple@nvidia.com>

On Friday, 28 May 2021 6:21:26 AM AEST Peter Xu wrote:
> The first_index/last_index parameters in zap_details are actually only used in
> unmap_mapping_range_tree().  At the meantime, this function is only called by
> unmap_mapping_pages() once.  Instead of passing these two variables through the
> whole stack of page zapping code, remove them from zap_details and let them
> simply be parameters of unmap_mapping_range_tree(), which is inlined.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/linux/mm.h |  2 --
>  mm/memory.c        | 20 ++++++++++----------
>  2 files changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index ef9ea6dfefff..db155be8e66c 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1726,8 +1726,6 @@ extern void user_shm_unlock(size_t, struct user_struct *);
>   */
>  struct zap_details {
>  	struct address_space *check_mapping;	/* Check page->mapping if set */
> -	pgoff_t	first_index;			/* Lowest page->index to unmap */
> -	pgoff_t last_index;			/* Highest page->index to unmap */
>  };
>  
>  struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
> diff --git a/mm/memory.c b/mm/memory.c
> index 45a2f71e447a..27cf8a6375c6 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3305,20 +3305,20 @@ static void unmap_mapping_range_vma(struct vm_area_struct *vma,
>  }
>  
>  static inline void unmap_mapping_range_tree(struct rb_root_cached *root,
> +					    pgoff_t first_index,
> +					    pgoff_t last_index,
>  					    struct zap_details *details)
>  {
>  	struct vm_area_struct *vma;
>  	pgoff_t vba, vea, zba, zea;
>  
> -	vma_interval_tree_foreach(vma, root,
> -			details->first_index, details->last_index) {
> -
> +	vma_interval_tree_foreach(vma, root, first_index, last_index) {
>  		vba = vma->vm_pgoff;
>  		vea = vba + vma_pages(vma) - 1;
> -		zba = details->first_index;
> +		zba = first_index;
>  		if (zba < vba)
>  			zba = vba;
> -		zea = details->last_index;
> +		zea = last_index;
>  		if (zea > vea)
>  			zea = vea;
>  
> @@ -3344,17 +3344,17 @@ static inline void unmap_mapping_range_tree(struct rb_root_cached *root,
>  void unmap_mapping_pages(struct address_space *mapping, pgoff_t start,
>  		pgoff_t nr, bool even_cows)
>  {
> +	pgoff_t	first_index = start, last_index = start + nr - 1;
>  	struct zap_details details = { };
>  
>  	details.check_mapping = even_cows ? NULL : mapping;
> -	details.first_index = start;
> -	details.last_index = start + nr - 1;
> -	if (details.last_index < details.first_index)
> -		details.last_index = ULONG_MAX;
> +	if (last_index < first_index)
> +		last_index = ULONG_MAX;
>  
>  	i_mmap_lock_write(mapping);
>  	if (unlikely(!RB_EMPTY_ROOT(&mapping->i_mmap.rb_root)))
> -		unmap_mapping_range_tree(&mapping->i_mmap, &details);
> +		unmap_mapping_range_tree(&mapping->i_mmap, first_index,
> +					 last_index, &details);
>  	i_mmap_unlock_write(mapping);
>  }
>  
> 




