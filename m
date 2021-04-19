Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7E8A363FA4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 12:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238648AbhDSKdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 06:33:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:51338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238617AbhDSKc5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 06:32:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 020E361166;
        Mon, 19 Apr 2021 10:32:26 +0000 (UTC)
Date:   Mon, 19 Apr 2021 11:32:24 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: Move HOLES_IN_ZONE into mm
Message-ID: <20210419103223.GA3515@arm.com>
References: <20210417075946.181402-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210417075946.181402-1-wangkefeng.wang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 17, 2021 at 03:59:46PM +0800, Kefeng Wang wrote:
> commit a55749639dc1 ("ia64: drop marked broken DISCONTIGMEM and VIRTUAL_MEM_MAP")
> drop VIRTUAL_MEM_MAP, so there is no need HOLES_IN_ZONE on ia64.
> 
> Also move HOLES_IN_ZONE into mm/Kconfig, select it if architecture needs
> this feature.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  arch/arm64/Kconfig | 4 +---
>  arch/ia64/Kconfig  | 3 ---
>  arch/mips/Kconfig  | 3 ---
>  mm/Kconfig         | 3 +++
>  4 files changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index f0b17d758912..3c5a53e0db91 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -202,6 +202,7 @@ config ARM64
>  	select HAVE_KPROBES
>  	select HAVE_KRETPROBES
>  	select HAVE_GENERIC_VDSO
> +	select HOLES_IN_ZONE
>  	select IOMMU_DMA if IOMMU_SUPPORT
>  	select IRQ_DOMAIN
>  	select IRQ_FORCED_THREADING
> @@ -1053,9 +1054,6 @@ config NEED_PER_CPU_EMBED_FIRST_CHUNK
>  	def_bool y
>  	depends on NUMA
>  
> -config HOLES_IN_ZONE
> -	def_bool y
> -
>  source "kernel/Kconfig.hz"

For arm64:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
