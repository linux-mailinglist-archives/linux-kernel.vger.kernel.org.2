Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 574A531860A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 09:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbhBKICI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 03:02:08 -0500
Received: from verein.lst.de ([213.95.11.211]:54377 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229918AbhBKIBr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 03:01:47 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7E66068B02; Thu, 11 Feb 2021 09:01:48 +0100 (CET)
Date:   Thu, 11 Feb 2021 09:01:48 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, akpm@linux-foundation.org,
        will@kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Christoph Hellwig <hch@lst.de>,
        David Hildenbrand <david@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] arm64/hugetlb: Enable HUGETLB_PAGE_SIZE_VARIABLE
Message-ID: <20210211080148.GB14448@lst.de>
References: <1613024531-19040-1-git-send-email-anshuman.khandual@arm.com> <1613024531-19040-3-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1613024531-19040-3-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021 at 11:52:10AM +0530, Anshuman Khandual wrote:
> MAX_ORDER which invariably depends on FORCE_MAX_ZONEORDER can be a variable
> for a given page size, depending on whether TRANSPARENT_HUGEPAGE is enabled
> or not. In certain page size and THP combinations HUGETLB_PAGE_ORDER can be
> greater than MAX_ORDER, making it unusable as pageblock_order.
> 
> This enables HUGETLB_PAGE_SIZE_VARIABLE making pageblock_order a variable
> rather than the compile time constant HUGETLB_PAGE_ORDER which could break
> MAX_ORDER rule for certain configurations.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  arch/arm64/Kconfig | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index f39568b28ec1..8e3a5578f663 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1909,6 +1909,10 @@ config ARCH_ENABLE_THP_MIGRATION
>  	def_bool y
>  	depends on TRANSPARENT_HUGEPAGE
>  
> +config HUGETLB_PAGE_SIZE_VARIABLE

Please move the definition of HUGETLB_PAGE_SIZE_VARIABLE to
mm/Kconfig and select it from the arch Kconfigfs instead of duplicating
the definition.
