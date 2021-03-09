Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B437F3327FD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 15:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhCIOCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 09:02:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:58008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231268AbhCIOCE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 09:02:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D91DA6509B;
        Tue,  9 Mar 2021 14:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615298524;
        bh=mVmvzbUnC1iFIvL06ompUep0zuEOPa7esezXGaZR3xs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M1TPzKY9K3PDhx5XL6nTaNgm9qKBWf0xAIkdNin5oagRpNtVWCtiwFANJXtXuCx2g
         2oG23QrNOefEahGmYa3323KlT37yZ0CDUZTtrsKJOvpijl7w9ru41ZxChMLAeNIPpJ
         1yVRUz4n76cDsKGHbZsbggS01ak8pYRm1+izGodcDxeQel4swB45cVAoLsd3IAYvem
         ud/W5TK9T4DKUlDBeu1lLyhLJA8A2Bhvzi+stEbryMPh3KRKmzPweiUIHbQnxfWwQZ
         cs6O+Uy6usYceXKVxWLuEZ25TYp3JoL7n/WGOHM+D3hPPpFQqUcYYOhyxEiDISP6BT
         cPESkBi2qgWvA==
Date:   Tue, 9 Mar 2021 14:01:59 +0000
From:   Will Deacon <will@kernel.org>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Atish Patra <atish.patra@wdc.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/arch_numa: remove rebudant setup_per_cpu_areas()
Message-ID: <20210309140159.GA28395@willie-the-truck>
References: <20210309102138.41170-1-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210309102138.41170-1-kernelfans@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[typo in subject "rebudant"]

On Tue, Mar 09, 2021 at 06:21:38PM +0800, Pingfan Liu wrote:
> There are two identical implementations of setup_per_cpu_areas() in
> mm/percpu.c and drivers/base/arch_numa.c.
> 
> Hence removing the one in arch_numa.c. And let arm64 drop
> HAVE_SETUP_PER_CPU_AREA.
> 
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Atish Patra <atish.patra@wdc.com>
> Cc: linux-kernel@vger.kernel.org
> To: linux-arm-kernel@lists.infradead.org
> ---
>  arch/arm64/Kconfig       |  4 ----
>  drivers/base/arch_numa.c | 22 ----------------------
>  2 files changed, 26 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 1f212b47a48a..d4bf8be0c3d5 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1022,10 +1022,6 @@ config USE_PERCPU_NUMA_NODE_ID
>  	def_bool y
>  	depends on NUMA
>  
> -config HAVE_SETUP_PER_CPU_AREA
> -	def_bool y
> -	depends on NUMA
> -
>  config NEED_PER_CPU_EMBED_FIRST_CHUNK
>  	def_bool y
>  	depends on NUMA
> diff --git a/drivers/base/arch_numa.c b/drivers/base/arch_numa.c
> index 4cc4e117727d..23e1e419a83d 100644
> --- a/drivers/base/arch_numa.c
> +++ b/drivers/base/arch_numa.c
> @@ -167,28 +167,6 @@ static void __init pcpu_fc_free(void *ptr, size_t size)
>  {
>  	memblock_free_early(__pa(ptr), size);
>  }
> -
> -void __init setup_per_cpu_areas(void)
> -{
> -	unsigned long delta;
> -	unsigned int cpu;
> -	int rc;
> -
> -	/*
> -	 * Always reserve area for module percpu variables.  That's
> -	 * what the legacy allocator did.
> -	 */
> -	rc = pcpu_embed_first_chunk(PERCPU_MODULE_RESERVE,
> -				    PERCPU_DYNAMIC_RESERVE, PAGE_SIZE,
> -				    pcpu_cpu_distance,
> -				    pcpu_fc_alloc, pcpu_fc_free);

This doesn't look identical to the version in mm/percpu.c -- that one passes
NULL instead of 'pcpu_cpu_distance' and tries to allocate the pcpu memory on
the relevant NUMA nodes. In fact, if you could remove this function, you
could probably remove the whole HAVE_SETUP_PER_CPU_AREA block here as the
other functions are just used as helpers. So I'm not sure this is valid.

Will
