Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0C4A452B6C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 08:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbhKPHSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 02:18:42 -0500
Received: from mail-co1nam11on2064.outbound.protection.outlook.com ([40.107.220.64]:15394
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230191AbhKPHSi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 02:18:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TBGTigCXtgd95Fnnm/A1xxU861im5bK5fbdEKtZzQGWwSOvPBVKmPabXYUw+zdCmSq6xqYOzbnd69UiQeJaJ+XGO0AxmFYDt3G8LWeft7pJbjzEAQKe+5U1/ImFeaKJeT/9JIDgqE7ZJTpZFCIKSJIFq1Gr4ezLbzyv220l4OJQ0RzaqgAN5ErrV+UBMoBF+vizUhifygnBhRsBLFRs4Bry4Sq5KR0cbnEiW/ZsIjT1cmLL49eRWs2ZEvscV3LcFeDJJKhlZp8KtfIHJtNipCEj44Na7HE3j4KyemBabykJZKBJJSGFrMziJumyjk7q7T2Ig259C58R3CthqM+wtqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DCzarV9JGt0K2k9N4EFHF0BkeHQqEjKKUkjH/9qjqDU=;
 b=T8F/1GGbvN4LJt+wsFsbTtndvCuiYhpyZV7nrZes39z+IHo/HRlmaBXYSx50EPH5V2xd96QYKyIzbifptdNuCHRRse+j2JrrnRCkpP/65UyHEnKxdQmpHCp6VWrmWjgkA8yfeznKf+iQmvxc0ALtGnd0GK3hD+HKboIVNXv/HojR8xAdSaEO7X3UlwYpJ8PmoA66n3IaKEc5W7h0ehNUGHxNogin8mkg6ab8jYt7Xx+zWk1942/NXoSBsu4SK5CNrXJIc5PqnuDqaxnh0TnNcB0sGi40CHYQdq/DHWeGs+/9EHVt0n3/CdspvQm7QtxcKyIl1cFMM+sce7hHCvMDeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=kvack.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCzarV9JGt0K2k9N4EFHF0BkeHQqEjKKUkjH/9qjqDU=;
 b=UJl1Wy0c9RTRncMfs2cLsfiCzM+SqD0k4ZVomJ8iC52IYcPOK28ic6ObQrwK6wwFPaRm7hupwWJBORNLAa6t4V9/4mIQ4SMxZkOWiehMyg8zS2SWsmSOV+zsmjFuGGAIm7M3gf5PvNs9QvTEUdS/m33Kx/0O6s391GFQfiwseGeaevW63Uy8rFyZv6L5qLk8FLRub49TMMwWE6zSm4HTE3WPMJ9fwoQP+ob/4LR20RLInlon4PjwWyUe9KKCKrXbGeqFaoVnXsyNnLPJdJVb42vmXIPC1ckbXAxqcxN8hwlS2Ow9cEfLBQb0HYgDCM9aRU5lT4YkJ/iv0mfm49p69A==
Received: from BN1PR14CA0009.namprd14.prod.outlook.com (2603:10b6:408:e3::14)
 by MWHPR1201MB0045.namprd12.prod.outlook.com (2603:10b6:301:5a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Tue, 16 Nov
 2021 07:15:39 +0000
Received: from BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e3:cafe::49) by BN1PR14CA0009.outlook.office365.com
 (2603:10b6:408:e3::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27 via Frontend
 Transport; Tue, 16 Nov 2021 07:15:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT050.mail.protection.outlook.com (10.13.177.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4690.15 via Frontend Transport; Tue, 16 Nov 2021 07:15:38 +0000
Received: from nvdebian.localnet (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 16 Nov
 2021 07:15:36 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Jason Gunthorpe <jgg@nvidia.com>, <jglisse@redhat.com>,
        <jhubbard@nvidia.com>, <ziy@nvidia.com>, <rcampbell@nvidia.com>,
        <Felix.Kuehling@amd.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/hmm.c: Allow VM_MIXEDMAP to work with hmm_range_fault
Date:   Tue, 16 Nov 2021 18:15:34 +1100
Message-ID: <5228339.iium7KxlgL@nvdebian>
In-Reply-To: <20211115204842.78180ec7f4b0f51b538bbf55@linux-foundation.org>
References: <20211104012001.2555676-1-apopple@nvidia.com> <5535346.2Y9IAguWGx@nvdebian> <20211115204842.78180ec7f4b0f51b538bbf55@linux-foundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 335f4c3e-c97e-4a20-45d4-08d9a8d0e48f
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0045:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB00455A2A65DBA8404FCBB91CDF999@MWHPR1201MB0045.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BKNpxjKbbZKNh98nueWBWSnlGgltCDTwP3U+wx92+xuMct68o7Xg5KVb8Mb2rVrIt/i8Mz1165ebWXZVU9mQ7nZa1Rxfb/xR5g5/dMcax93aSrwlqOFOlOtRcJqUT6EeLukoR1A2zRNm09y1sVP0h5W5gCc4CDn1f6DyGBrYQj/z/xX/CsOLnshL3WQleHG7pNqE4zJ0Mg+QZ2+Nrd49iCjY3ij7ONcIEYDJiQUMBzLG2Y0mdCQXKh5CUKw67bErXNBCz/lSG8rSXAhP9sNMYeF7atc5LIUnbysjJyUQAVvc5pWvOc7+6Xu/p7we/FxuveG4ZiMHYUIo5t9F9ntqyimT5Vb1RW8YCLS0BZ6fgaXi7HVtT80zAvxInBU3gwAylCcg6hEG17xD1SNSLZUKXSF7G+gKB0lKrnO78ZVZP4a6sd7eajje0szhdNfURfnQeViYKMXYDKqYxi16wCrlf3yNUEv1Fw++XlvVBNhByQTilvnrGfpOPGAAep+dW4fW1qy6nIvErZseiM3iQsyfVwfh6JIl1Bf8BzEUqFaAIA+3HApZE3N8SiJzInEuR42ymbg08BuISR/nhq6l0sVpnlc1JAyp10WkwdoI5AJ7xlCDq4pnxVaBd+CP/PmvNDpTZ/7TQDaZz0UAZm18TaMLniqPyJ+dAUpFGleCgqwzThHVD5eXgIraWpSSQp0ype0RbhMekv5nifPScUp4Jg3l3rfzLIJxagbhEfzyCw+8ndxXf4DNulpAc2HLzp2dibZBe/SNGaiH/rXRR0SvLytTLCD63xqeburAE2o2JhFv1kRHACY3+AWsllIY+2UVbMO1
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(7636003)(6916009)(86362001)(356005)(47076005)(2906002)(83380400001)(4326008)(336012)(316002)(33716001)(70586007)(26005)(966005)(82310400003)(54906003)(186003)(16526019)(36860700001)(70206006)(8936002)(5660300002)(8676002)(36906005)(426003)(9686003)(9576002)(508600001)(39026012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 07:15:38.9315
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 335f4c3e-c97e-4a20-45d4-08d9a8d0e48f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0045
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 16 November 2021 3:48:42 PM AEDT Andrew Morton wrote:
> On Mon, 8 Nov 2021 18:58:01 +1100 Alistair Popple <apopple@nvidia.com> wrote:
> 
> > On Friday, 5 November 2021 11:25:57 PM AEDT Jason Gunthorpe wrote:
> > > On Thu, Nov 04, 2021 at 12:20:01PM +1100, Alistair Popple wrote:
> > > > hmm_range_fault() can be used instead of get_user_pages() for devices
> > > > which allow faulting however unlike get_user_pages() it will return an
> > > > error when used on a VM_MIXEDMAP range.
> > > > 
> > > > To make hmm_range_fault() more closely match get_user_pages() remove
> > > > this restriction. This requires dealing with the !ARCH_HAS_PTE_SPECIAL
> > > > case in hmm_vma_handle_pte(). Rather than replicating the logic of
> > > > vm_normal_page() call it directly and do a check for the zero pfn
> > > > similar to what get_user_pages() currently does.
> > > > 
> > > > Also add a test to hmm selftest to verify functionality.
> > > 
> > > Please add a fixes line
> > 
> > This has been the case since hmm_vma_get_pfns() was first introduced. Therefore
> > the fixes line is:
> > 
> > Fixes: da4c3c735ea4 ("mm/hmm/mirror: helper to snapshot CPU page table")
> > 
> > Should I send a v2 adding that tag or does Andrew normally pick these up along
> > with the Reviewed-by?
> 
> I got it.
> 
> It needed a bit of rework due to the newly-added !pte_devmap() change
> in hmm_vma_handle_pte().  Please check carefully?

Thanks. The rework looks good to me - changing pte_special() to
vm_insert_page() does not change the logic of the !pte_devmap() change. In
either case the value of pte_special() or vm_insert_page() is ignored when
pte_devmap()==True as intended by the !pte_devmap() change.

For good measure I rerun the HMM selftest as well.

> From: Alistair Popple <apopple@nvidia.com>
> Subject: mm/hmm.c: Allow VM_MIXEDMAP to work with hmm_range_fault
> 
> hmm_range_fault() can be used instead of get_user_pages() for devices
> which allow faulting however unlike get_user_pages() it will return an
> error when used on a VM_MIXEDMAP range.
> 
> To make hmm_range_fault() more closely match get_user_pages() remove
> this restriction. This requires dealing with the !ARCH_HAS_PTE_SPECIAL
> case in hmm_vma_handle_pte(). Rather than replicating the logic of
> vm_normal_page() call it directly and do a check for the zero pfn
> similar to what get_user_pages() currently does.
> 
> Also add a test to hmm selftest to verify functionality.
> 
> Link: https://lkml.kernel.org/r/20211104012001.2555676-1-apopple@nvidia.com
> Fixes: da4c3c735ea4 ("mm/hmm/mirror: helper to snapshot CPU page table")
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Cc: Jerome Glisse <jglisse@redhat.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  lib/test_hmm.c                         |   24 +++++++++++++
>  mm/hmm.c                               |    5 +-
>  tools/testing/selftests/vm/hmm-tests.c |   42 +++++++++++++++++++++++
>  3 files changed, 69 insertions(+), 2 deletions(-)
> 
> --- a/lib/test_hmm.c~mm-hmmc-allow-vm_mixedmap-to-work-with-hmm_range_fault
> +++ a/lib/test_hmm.c
> @@ -1086,9 +1086,33 @@ static long dmirror_fops_unlocked_ioctl(
>  	return 0;
>  }
>  
> +static int dmirror_fops_mmap(struct file *file, struct vm_area_struct *vma)
> +{
> +	unsigned long addr;
> +
> +	for (addr = vma->vm_start; addr < vma->vm_end; addr += PAGE_SIZE) {
> +		struct page *page;
> +		int ret;
> +
> +		page = alloc_page(GFP_KERNEL | __GFP_ZERO);
> +		if (!page)
> +			return -ENOMEM;
> +
> +		ret = vm_insert_page(vma, addr, page);
> +		if (ret) {
> +			__free_page(page);
> +			return ret;
> +		}
> +		put_page(page);
> +	}
> +
> +	return 0;
> +}
> +
>  static const struct file_operations dmirror_fops = {
>  	.open		= dmirror_fops_open,
>  	.release	= dmirror_fops_release,
> +	.mmap		= dmirror_fops_mmap,
>  	.unlocked_ioctl = dmirror_fops_unlocked_ioctl,
>  	.llseek		= default_llseek,
>  	.owner		= THIS_MODULE,
> --- a/mm/hmm.c~mm-hmmc-allow-vm_mixedmap-to-work-with-hmm_range_fault
> +++ a/mm/hmm.c
> @@ -300,7 +300,8 @@ static int hmm_vma_handle_pte(struct mm_
>  	 * Since each architecture defines a struct page for the zero page, just
>  	 * fall through and treat it like a normal page.
>  	 */
> -	if (pte_special(pte) && !pte_devmap(pte) &&
> +	if (!vm_normal_page(walk->vma, addr, pte) &&
> +	    !pte_devmap(pte) &&
>  	    !is_zero_pfn(pte_pfn(pte))) {
>  		if (hmm_pte_need_fault(hmm_vma_walk, pfn_req_flags, 0)) {
>  			pte_unmap(ptep);
> @@ -518,7 +519,7 @@ static int hmm_vma_walk_test(unsigned lo
>  	struct hmm_range *range = hmm_vma_walk->range;
>  	struct vm_area_struct *vma = walk->vma;
>  
> -	if (!(vma->vm_flags & (VM_IO | VM_PFNMAP | VM_MIXEDMAP)) &&
> +	if (!(vma->vm_flags & (VM_IO | VM_PFNMAP)) &&
>  	    vma->vm_flags & VM_READ)
>  		return 0;
>  
> --- a/tools/testing/selftests/vm/hmm-tests.c~mm-hmmc-allow-vm_mixedmap-to-work-with-hmm_range_fault
> +++ a/tools/testing/selftests/vm/hmm-tests.c
> @@ -1251,6 +1251,48 @@ TEST_F(hmm, anon_teardown)
>  /*
>   * Test memory snapshot without faulting in pages accessed by the device.
>   */
> +TEST_F(hmm, mixedmap)
> +{
> +	struct hmm_buffer *buffer;
> +	unsigned long npages;
> +	unsigned long size;
> +	unsigned char *m;
> +	int ret;
> +
> +	npages = 1;
> +	size = npages << self->page_shift;
> +
> +	buffer = malloc(sizeof(*buffer));
> +	ASSERT_NE(buffer, NULL);
> +
> +	buffer->fd = -1;
> +	buffer->size = size;
> +	buffer->mirror = malloc(npages);
> +	ASSERT_NE(buffer->mirror, NULL);
> +
> +
> +	/* Reserve a range of addresses. */
> +	buffer->ptr = mmap(NULL, size,
> +			   PROT_READ | PROT_WRITE,
> +			   MAP_PRIVATE,
> +			   self->fd, 0);
> +	ASSERT_NE(buffer->ptr, MAP_FAILED);
> +
> +	/* Simulate a device snapshotting CPU pagetables. */
> +	ret = hmm_dmirror_cmd(self->fd, HMM_DMIRROR_SNAPSHOT, buffer, npages);
> +	ASSERT_EQ(ret, 0);
> +	ASSERT_EQ(buffer->cpages, npages);
> +
> +	/* Check what the device saw. */
> +	m = buffer->mirror;
> +	ASSERT_EQ(m[0], HMM_DMIRROR_PROT_READ);
> +
> +	hmm_buffer_free(buffer);
> +}
> +
> +/*
> + * Test memory snapshot without faulting in pages accessed by the device.
> + */
>  TEST_F(hmm2, snapshot)
>  {
>  	struct hmm_buffer *buffer;
> _
> 
> 
> 




