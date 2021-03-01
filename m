Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFCA4328353
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 17:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237680AbhCAQPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 11:15:50 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:10662 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237535AbhCAQME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 11:12:04 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B603d12160002>; Mon, 01 Mar 2021 08:11:02 -0800
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 1 Mar
 2021 16:10:59 +0000
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 1 Mar
 2021 16:10:54 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Mon, 1 Mar 2021 16:10:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iIvfkYIldJFlB2bF9iVlVjYBgyx3WuWo60Tnp/Kz5ulnafHnu521giNPp005sUWEs31Nn3OSJBoAVz0R6yMBicmj7UvaVacJP9KLqNXCTcuwdSCsCKnNzqc58AJyWB6u62gaIwunOU34J+69ttCrwdF4O9bngupVyBlF8hBMwzZp0unZNZuYMCOJIZ51ZM8TAPIDJPYskgD1YofW5YNN1Dpc2D1FXgcRdshOT80IlpayuhJ5oFdj3pRZ6027DhpHiAvUUrjRDk8hgla6w2dyPdYGL4lTg9YSM0guw8qqq57bl7bQUYUtIknPswdJ8sBAS1CUPcjIviRWcPjAIrcx2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GVgJyOzesM6AuTpgAxp4tGR/vGa6dnCRQWH6QFebQWQ=;
 b=SUUiJQhWku40N/hWDe5iTtnaZcFF5XsrcKzdmpW+OeBiIuzlEx6UKW9ztbOkFKIEjIiTld023V+ANc2zMzF5lheF+ECT6r+IrLrfZFe047jMBmnz/mJNxgim5TeIwjwC3oStQQ6SFUIctBpzkO6aVhrVJXWbgPWpUb6/6QJFkyot4hgndVGa+PmCaXFLxsoKxOHjohS/g6ia7UWPPwe2pse/gfFNloQPpA0vHywrNho/rPDIxF4vt/mwJGhRO1lKUMBghLDqzBl0rkoIAxwvYI+0Z0oo4nVMyhpFIv9ww2XUlgDWhGS1RXZGTBCFarBZdpMEwDjrHQbyKS6Yu4cGWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3739.namprd12.prod.outlook.com (2603:10b6:5:1c4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.22; Mon, 1 Mar
 2021 16:10:51 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3890.026; Mon, 1 Mar 2021
 16:10:51 +0000
Date:   Mon, 1 Mar 2021 12:10:49 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Alistair Popple <apopple@nvidia.com>
CC:     <linux-mm@kvack.org>, <nouveau@lists.freedesktop.org>,
        <bskeggs@redhat.com>, <akpm@linux-foundation.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <jhubbard@nvidia.com>,
        <rcampbell@nvidia.com>, <jglisse@redhat.com>, <hch@infradead.org>,
        <daniel@ffwll.ch>
Subject: Re: [PATCH v3 3/8] mm/rmap: Split try_to_munlock from try_to_unmap
Message-ID: <20210301161049.GJ4247@nvidia.com>
References: <20210226071832.31547-1-apopple@nvidia.com>
 <20210226071832.31547-4-apopple@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210226071832.31547-4-apopple@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0158.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::13) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0158.namprd13.prod.outlook.com (2603:10b6:208:2bd::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.9 via Frontend Transport; Mon, 1 Mar 2021 16:10:50 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lGl8D-0032CY-C1; Mon, 01 Mar 2021 12:10:49 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1614615062; bh=GVgJyOzesM6AuTpgAxp4tGR/vGa6dnCRQWH6QFebQWQ=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Header;
        b=YS4YDlR5gI45XNcgZrRPC4haxzCo+qdJEB3GKWryFlod8PfutFipT8HmRj7hlcN81
         3b8f4faXlmGhZoQEd7yUvTvQe11b6eKb25dZB67C1C+iJGWvZQGXXh1Tb3ByW0nvnM
         384GgTA54dt7POC40CS7Eo3B6Afw21aEafWsVruiJH+x95LbbGy/OBq5fJ+TFR6988
         ikBUDL1yqe3Jz5SkLO3woY0mStNDl7/cMsVjR4O3Oq1sGiB8DK3z1YR/ESs9p1PEkF
         +n2vq8qK83YXOwdsaIpS6Ho8qk2hP12/Keyixo/8MZPznJvZDgXi95Tg4nm00oc/+q
         aP2ncZfW9MLMw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 06:18:27PM +1100, Alistair Popple wrote:
> The behaviour of try_to_unmap_one() is difficult to follow because it
> performs different operations based on a fairly large set of flags used
> in different combinations.
> 
> TTU_MUNLOCK is one such flag. However it is exclusively used by
> try_to_munlock() which specifies no other flags. Therefore rather than
> overload try_to_unmap_one() with unrelated behaviour split this out into
> it's own function and remove the flag.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> 
> 
> Given the comments on not needing to hold mmap_lock it was not 100% clear
> to me if it is safe to check vma->vma_flags & VM_LOCKED and if re-checking
> under the ptl was significant. I left the extra check in case it was, but
> it seems one of the checks is redunant as either the first check is racey
> or the second check is unneccsary.

The rmap doesn't hold the mmap_lock so I think both of these cases are
racey.

eg 

apply_vma_lock_flags()

	vma = find_vma(current->mm, start);
	if (!vma || vma->vm_start > start)
		return -ENOMEM;

	prev = vma->vm_prev;
	if (start > vma->vm_start)
		prev = vma;

	for (nstart = start ; ; ) {
		vm_flags_t newflags = vma->vm_flags & VM_LOCKED_CLEAR_MASK;

		newflags |= flags;
 [...]
mlock_fixup()
	/*
	 * vm_flags is protected by the mmap_lock held in write mode.
	 * It's okay if try_to_unmap_one unmaps a page just after we
	 * set VM_LOCKED, populate_vma_page_range will bring it back.
	 */

	if (lock)
		vma->vm_flags = newflags;
	else
               	vma->vm_flags &= VM_LOCKED_CLEAR_MASK;

Which is only done under the mmap_sem

> +static bool try_to_munlock_one(struct page *page, struct vm_area_struct *vma,
> +		     unsigned long address, void *arg)
> +{
> +	struct page_vma_mapped_walk pvmw = {
> +		.page = page,
> +		.vma = vma,
> +		.address = address,
> +	};
> +	bool ret = true;
> +
> +	/* munlock has nothing to gain from examining un-locked vmas */
> +	if (!(vma->vm_flags & VM_LOCKED))
> +		return true;

The mmap_sem can't be obtained in the rmap walkers due to lock
ordering, the various rmap locks are nested under the mmap_sem

So, when reading data that is not locked it should be written as:

   READ_ONCE(vma->vm_flags) & VM_LOCKED

> +	while (page_vma_mapped_walk(&pvmw)) {
> +		/*
> +		 * If the page is mlock()d, we cannot swap it out.
> +		 * If it's recently referenced (perhaps page_referenced
> +		 * skipped over this mm) then we should reactivate it.
> +		 */
> +		if (vma->vm_flags & VM_LOCKED) {

And since we write the data without holding the PTLs this looks
pointless, unless there is some other VM_LOCKED manipulation

Jason
