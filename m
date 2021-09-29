Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C41D41CA84
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 18:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345960AbhI2QpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 12:45:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:44054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229561AbhI2QpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 12:45:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B826161411;
        Wed, 29 Sep 2021 16:43:37 +0000 (UTC)
Date:   Wed, 29 Sep 2021 17:43:34 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     jmorris@namei.org, sashal@kernel.org, ebiederm@xmission.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, linux-mm@kvack.org, mark.rutland@arm.com,
        steve.capper@arm.com, rfontana@redhat.com, tglx@linutronix.de,
        selindag@gmail.com, tyhicks@linux.microsoft.com,
        kernelfans@gmail.com, akpm@linux-foundation.org,
        madvenka@linux.microsoft.com
Subject: Re: [PATCH v17 15/15] arm64: trans_pgd: remove trans_pgd_map_page()
Message-ID: <YVSXtswhm6iTC3yz@arm.com>
References: <20210916231325.125533-1-pasha.tatashin@soleen.com>
 <20210916231325.125533-16-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916231325.125533-16-pasha.tatashin@soleen.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021 at 07:13:25PM -0400, Pasha Tatashin wrote:
> The intend of trans_pgd_map_page() was to map contiguous range of VA
> memory to the memory that is getting relocated during kexec. However,
> since we are now using linear map instead of contiguous range this
> function is not needed
> 
> Suggested-by: Pingfan Liu <kernelfans@gmail.com>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  arch/arm64/include/asm/trans_pgd.h |  5 +--
>  arch/arm64/mm/trans_pgd.c          | 57 ------------------------------
>  2 files changed, 1 insertion(+), 61 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/trans_pgd.h b/arch/arm64/include/asm/trans_pgd.h
> index 7b04d32b102c..033d400a4ea4 100644
> --- a/arch/arm64/include/asm/trans_pgd.h
> +++ b/arch/arm64/include/asm/trans_pgd.h
> @@ -15,7 +15,7 @@
>  /*
>   * trans_alloc_page
>   *	- Allocator that should return exactly one zeroed page, if this
> - *	  allocator fails, trans_pgd_create_copy() and trans_pgd_map_page()
> + *	  allocator fails, trans_pgd_create_copy() and trans_pgd_idmap_page()
>   *	  return -ENOMEM error.
>   *
>   * trans_alloc_arg
> @@ -30,9 +30,6 @@ struct trans_pgd_info {
>  int trans_pgd_create_copy(struct trans_pgd_info *info, pgd_t **trans_pgd,
>  			  unsigned long start, unsigned long end);
>  
> -int trans_pgd_map_page(struct trans_pgd_info *info, pgd_t *trans_pgd,
> -		       void *page, unsigned long dst_addr, pgprot_t pgprot);

So this function never got used in mainline after commit 7018d467ff2d
("arm64: trans_pgd: hibernate: idmap the single page that holds the copy
page routines"). I guess it's because we merged part of v10 of this
series and in v12 you dropped the contiguous VA range in favour of a
copy of the linear map.

-- 
Catalin
