Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA5C3297DE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 10:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244747AbhCAW7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 17:59:41 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:13209 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238631AbhCARuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 12:50:09 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B603d29230000>; Mon, 01 Mar 2021 09:49:23 -0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 1 Mar
 2021 17:49:20 +0000
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 1 Mar
 2021 17:46:46 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Mon, 1 Mar 2021 17:46:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EFVbnwnrw8qnly/zwDwfbu+B94qDVwSg3iuERtvKOGPh4Y22OMfahxfI9Ie74AvbWF1cwwWy/2Cj7tOcC0VaQUp7KB9Vd6mbI8x+LC2TGzspQMPlZ+XdlDeUyiJk69DJnftqYvmclYhrBGled0gZKsftrOTLi/fiO5N3S6IKPxu73MJ3pfZHJiDvCXcoF6R+orT/fEScVedMvxudcNLDQg2shcxfxPre+ViaV7YoEWhUd7t7Kuu7Kw/k7zGCy8vEVgjOT3fMUrvq1ibbZdxMGO//DhFbC85uCnK+B+aUxeunzv8M7PifAiLwQoKfjXUx4m0iMIahWfewzYK23SffMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y8pdUlkTt7laEoofqh+gCwYtoAFeW/XvvLozoOUJdds=;
 b=IVoNxQsXijD7eGHGmSHm2UfKhgfr11UZ35gle62wNb/GyVSL7V4Sj9+Dl3t/RQZ2Ux0vmxjriE0Z9W1JmpU2TK/7R6zy1kV0fVtotjmRcYFhEM8ChXKQpoYrNFImoEYAQo10kOW/ZZvJH75HYXZ3JRO+hcDtmt8UlA6fazqpR0dDgqsnzGDLm4rHrm+AeAF1bMXXGiW97ydj17jLuWBRuaoZ4ay/xSO34x5zJehXPjRxXe/pySQvytUsdW++LPgAF332jW8oT954iJuM3ObEMC7c+LGUs61X3Y50emCCprRy7cpeUrXk3kIC6HJ/11Hk2hxmTh5nF6cJhTL5X+1KrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3833.namprd12.prod.outlook.com (2603:10b6:5:1cf::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Mon, 1 Mar
 2021 17:46:43 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3890.026; Mon, 1 Mar 2021
 17:46:43 +0000
Date:   Mon, 1 Mar 2021 13:46:42 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Alistair Popple <apopple@nvidia.com>
CC:     <linux-mm@kvack.org>, <nouveau@lists.freedesktop.org>,
        <bskeggs@redhat.com>, <akpm@linux-foundation.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <jhubbard@nvidia.com>,
        <rcampbell@nvidia.com>, <jglisse@redhat.com>, <hch@infradead.org>,
        <daniel@ffwll.ch>
Subject: Re: [PATCH v3 1/8] mm: Remove special swap entry functions
Message-ID: <20210301174642.GP4247@nvidia.com>
References: <20210226071832.31547-1-apopple@nvidia.com>
 <20210226071832.31547-2-apopple@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210226071832.31547-2-apopple@nvidia.com>
X-ClientProxiedBy: BL0PR0102CA0061.prod.exchangelabs.com
 (2603:10b6:208:25::38) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL0PR0102CA0061.prod.exchangelabs.com (2603:10b6:208:25::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Mon, 1 Mar 2021 17:46:43 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lGmd0-0033mo-3R; Mon, 01 Mar 2021 13:46:42 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1614620963; bh=Y8pdUlkTt7laEoofqh+gCwYtoAFeW/XvvLozoOUJdds=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Header;
        b=WQek7+9WJID/D6OIMheZEoOPDcWZGUB5ZPAr6KaS7u8L9vDATkZMXw5QBb4cV4wJ5
         i1Fs1mBiT0/wKq7K+3SJ3e+x2Oj353Rh9acmIyg8whhpOPl2UiyiXKrZ0ppddJsCwd
         wtW2k7cZy9GEYxh4c0wKaFoJ0qfsgg3XRYNzjhRQjSLYd3jvDbgL9A2+TdgShRCzNk
         JLaAA6z/HVfn1lJz2LdyJNRTycw7yntrOgdwqJIFD3An5xh9AEO8heby/yOZE4OcGw
         AmTK9kotlxGE41E7tqbBe9EM4esvk3ACNAyFCP5MbbpEs1CHImbQ2EIOHj60JN2c1h
         On9fWJPWy2Z5A==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 06:18:25PM +1100, Alistair Popple wrote:
> Remove the migration and device private entry_to_page() and
> entry_to_pfn() inline functions and instead open code them directly.
> This results in shorter code which is easier to understand.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> ---
>  arch/s390/mm/pgtable.c  |  2 +-
>  fs/proc/task_mmu.c      | 23 +++++++------------
>  include/linux/swap.h    |  4 ++--
>  include/linux/swapops.h | 51 ++++-------------------------------------
>  mm/hmm.c                |  5 ++--
>  mm/memcontrol.c         |  2 +-
>  mm/memory.c             | 10 ++++----
>  mm/migrate.c            |  6 ++---
>  mm/page_vma_mapped.c    |  6 ++---
>  9 files changed, 30 insertions(+), 79 deletions(-)

I wish you could come up with a more descriptive word that special
here

What I understand is this is true when the swap_offset is a pfn?

> -static inline struct page *migration_entry_to_page(swp_entry_t entry)
> -{
> -	struct page *p = pfn_to_page(swp_offset(entry));
> -	/*
> -	 * Any use of migration entries may only occur while the
> -	 * corresponding page is locked
> -	 */
> -	BUG_ON(!PageLocked(compound_head(p)));
> -	return p;

And this constraint has been completely lost?

A comment in front of the is_special_entry explaining all the rule
would help alot

Transformation looks fine otherwise

Jason
