Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36BC441C25A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 12:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245377AbhI2KMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 06:12:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:46946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245414AbhI2KMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 06:12:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C5A1960FE8;
        Wed, 29 Sep 2021 10:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632910234;
        bh=6IHLSvP1ghkbN4FLAePFphEp0d1TKXf3K9nSYoznCts=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S1V/sH/4H3EJ/BmcXmIZpvD4yVuGZuAfNQdj2vBTZQsBId/EZCvalXaGyiKVKz+Ec
         5aVsReMKETH94yaATug7Gv5l9OsGW8y0PjnyqCNhOW8VGm1yd6GYJ5HPKSg2+5MWmK
         tT+ScPofCmeYdR+HpNim8sn3bnNAnpftwVWL+YR9xTa1VnllfApPT2dSKOLRy6tBmL
         scKLgM/douszxH6mFYLpAO+dLzIkScz5mMBZ2kuV6l6wgM6nYJKw0nKlSfDQC9oB/7
         x4hrUCcjBjqMpZ6inq6C+sP0uUrvHRFAW26lJODv2oYEOPCf/9mYiaRMMIXpYAw3UI
         POfPtCyNgrASA==
Date:   Wed, 29 Sep 2021 11:10:29 +0100
From:   Will Deacon <will@kernel.org>
To:     Chris Goldsworthy <quic_cgoldswo@quicinc.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
Subject: Re: [RFC] arm64: mm: update max_pfn after memory hotplug
Message-ID: <20210929101028.GB21057@willie-the-truck>
References: <cover.1632437225.git.quic_cgoldswo@quicinc.com>
 <595d09279824faf1f54961cef52b745609b05d97.1632437225.git.quic_cgoldswo@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <595d09279824faf1f54961cef52b745609b05d97.1632437225.git.quic_cgoldswo@quicinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 03:54:48PM -0700, Chris Goldsworthy wrote:
> From: Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
> 
> After new memory blocks have been hotplugged, max_pfn and max_low_pfn
> needs updating to reflect on new PFNs being hot added to system.
> 
> Signed-off-by: Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
> Signed-off-by: Chris Goldsworthy <quic_cgoldswo@quicinc.com>
> ---
>  arch/arm64/mm/mmu.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index cfd9deb..fd85b51 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -1499,6 +1499,11 @@ int arch_add_memory(int nid, u64 start, u64 size,
>  	if (ret)
>  		__remove_pgd_mapping(swapper_pg_dir,
>  				     __phys_to_virt(start), size);
> +	else {
> +		max_pfn = PFN_UP(start + size);
> +		max_low_pfn = max_pfn;
> +	}

We use 'max_pfn' as part of the argument to set_max_mapnr(). Does that need
updating as well?

Do we have sufficient locking to ensure nobody is looking at max_pfn or
max_low_pfn while we update them?

Will
