Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 266623A68B8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 16:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234405AbhFNOKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 10:10:43 -0400
Received: from foss.arm.com ([217.140.110.172]:37078 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233180AbhFNOKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 10:10:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C5B21FB;
        Mon, 14 Jun 2021 07:08:39 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.9.225])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E56BD3F70D;
        Mon, 14 Jun 2021 07:08:37 -0700 (PDT)
Date:   Mon, 14 Jun 2021 15:08:35 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        aisheng.dong@arm.com
Subject: Re: [PATCH] arm64/mm: Drop SWAPPER_INIT_MAP_SIZE
Message-ID: <20210614140835.GB27788@C02TD0UTHF1T.local>
References: <1623665411-20055-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1623665411-20055-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 03:40:11PM +0530, Anshuman Khandual wrote:
> The commit cdef5f6e9e0e ("arm64: mm: allocate pagetables anywhere") had
> dropped the last reference to SWAPPER_INIT_MAP_SIZE. Hence just clean up.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> This applies on v5.13-rc6.

Dong Aisheng had a patch to do this, along with a few other cleanup
patches:

https://lore.kernel.org/r/20210518101405.1048860-1-aisheng.dong@nxp.com

Thanks,
Mark.

> 
>  arch/arm64/include/asm/kernel-pgtable.h | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kernel-pgtable.h b/arch/arm64/include/asm/kernel-pgtable.h
> index a848da2b4d90..1260187adb31 100644
> --- a/arch/arm64/include/asm/kernel-pgtable.h
> +++ b/arch/arm64/include/asm/kernel-pgtable.h
> @@ -100,9 +100,6 @@
>  #define SWAPPER_TABLE_SHIFT	PMD_SHIFT
>  #endif
>  
> -/* The size of the initial kernel direct mapping */
> -#define SWAPPER_INIT_MAP_SIZE	(_AC(1, UL) << SWAPPER_TABLE_SHIFT)
> -
>  /*
>   * Initial memory map attributes.
>   */
> -- 
> 2.20.1
> 
