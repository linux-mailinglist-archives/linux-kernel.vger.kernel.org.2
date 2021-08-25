Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 044533F7356
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 12:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238882AbhHYKdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 06:33:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:42242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237180AbhHYKdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 06:33:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EE2FF61139;
        Wed, 25 Aug 2021 10:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629887548;
        bh=LBkEVhXk6nP+PCt46F0eZs1fuqXceK0E7MqW8V2Hc8U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i/W8C9NRzVDY6t5f5deJdUpGbBfcDy5CEjRlBFvhSZ7Vo7ehuzLwapvfO7Ob5lnCk
         /ZQpwFPe1VDf2kihwnsKuQ3UkqehyM6Fq2/Z9zhiMnQh6A2BYuEDnrdFDQ6Mda5JV7
         G47H96SylwEZ5Ae9Lx+2V1zkc/AKdhzRrI1Am6mAM8SBGLlgvc+SQBcc9UcgS2r+S4
         ct+8jWCrHWG9UXjn6fTAfqCZjcjlVABTUXkkk65rESQqx1ftwYJsL0W6k1rQGI47/g
         PjsO6YYgU10R16U5oeZmMM7IFdN35oCYGB/11A5SgFecabqKQQ6E9uei2zLwv4Zh5Y
         qZZm5bUUkgOrw==
Date:   Wed, 25 Aug 2021 11:32:23 +0100
From:   Will Deacon <will@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Alex Bee <knaerzche@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [BUG 5.14] arm64/mm: dma memory mapping fails (in some cases)
Message-ID: <20210825103223.GE24546@willie-the-truck>
References: <d3a3c828-b777-faf8-e901-904995688437@gmail.com>
 <20210824173741.GC623@arm.com>
 <YSU6NVZ3j0XCurWC@kernel.org>
 <0908ce39-7e30-91fa-68ef-11620f9596ae@arm.com>
 <60a11eba-2910-3b5f-ef96-97d4556c1596@redhat.com>
 <20210825102044.GA3420@arm.com>
 <20210825102856.GD24546@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210825102856.GD24546@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 11:28:56AM +0100, Will Deacon wrote:
> On Wed, Aug 25, 2021 at 11:20:46AM +0100, Catalin Marinas wrote:
> > Given how later we are in the -rc cycle, I suggest we revert Anshuman's
> > commit 16c9afc77660 ("arm64/mm: drop HAVE_ARCH_PFN_VALID") and try to
> > assess the implications in 5.15 (the patch doesn't seem to have the
> > arm64 maintainers' ack anyway ;)).
> 
> I'll stick the revert (below) into kernelci now so we can get some coverage
> in case it breaks something else.

Bah, having said that...

> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index fcb535560028..ee70f21a79d5 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -1463,15 +1463,6 @@ static inline int pfn_valid(unsigned long pfn)
>  {
>  	struct mem_section *ms;
>  
> -	/*
> -	 * Ensure the upper PAGE_SHIFT bits are clear in the
> -	 * pfn. Else it might lead to false positives when
> -	 * some of the upper bits are set, but the lower bits
> -	 * match a valid pfn.
> -	 */
> -	if (PHYS_PFN(PFN_PHYS(pfn)) != pfn)
> -		return 0;
> -

I suppose we should leave this bit as-is, since the whole point here is
trying to minimise the impact on other architectures.

Will
