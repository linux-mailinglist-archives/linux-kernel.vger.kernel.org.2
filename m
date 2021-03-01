Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D72C2328230
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 16:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236498AbhCAPSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 10:18:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:40900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237030AbhCAPST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 10:18:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E672D600CC;
        Mon,  1 Mar 2021 15:18:02 +0000 (UTC)
Date:   Mon, 1 Mar 2021 15:18:00 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Steve Capper <Steve.Capper@arm.com>
Subject: Re: [PATCH] arm64/mm: Drop THP conditionality from
 FORCE_MAX_ZONEORDER
Message-ID: <20210301151759.GC3250@arm.com>
References: <1614597914-28565-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1614597914-28565-1-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01, 2021 at 04:55:14PM +0530, Anshuman Khandual wrote:
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 9cd33c7be429..d4690326274a 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1156,8 +1156,8 @@ config XEN
>  
>  config FORCE_MAX_ZONEORDER
>  	int
> -	default "14" if (ARM64_64K_PAGES && TRANSPARENT_HUGEPAGE)
> -	default "12" if (ARM64_16K_PAGES && TRANSPARENT_HUGEPAGE)
> +	default "14" if ARM64_64K_PAGES
> +	default "12" if ARM64_16K_PAGES
>  	default "11"
>  	help
>  	  The kernel memory allocator divides physically contiguous memory

I think this makes sense. The original "14" was added by Steve C in
commit d03bb1455f3a ("ARM64: mm: Raise MAX_ORDER for 64KB pages and
THP.") back in 3.11. It looks like hugetlbfs (and the HUGETLB_PAGE_ORDER
definition) was added in the same kernel but we somehow missed the
!TRANSPARENT_HUGEPAGE case and smaller page order. The warning in
__fragmentation_index() was added much later in 4.14.

Anyway, the patch looks fine to me, we could apply it to some past
stable kernels:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

An alternative would have be to add a dependency on both
TRANSPARENT_HUGEPAGE and HUGETLB_PAGE but I'm not sure it's worth it.

-- 
Catalin
