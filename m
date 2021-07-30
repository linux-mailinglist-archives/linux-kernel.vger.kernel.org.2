Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48B423DB855
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 14:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238859AbhG3MJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 08:09:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:46984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230374AbhG3MI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 08:08:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 95AB260C41;
        Fri, 30 Jul 2021 12:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627646934;
        bh=M7th4EX1NwjixElyQ+siOpGB0QDUZKEFgXwsXUSmKGM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q4LLV/n9aEO/KTfoV4dsUyswAIgnkTNG6uHeStzM+UpUhLGMzkKWMWygc7u6cl9Zl
         sGikOQiABWQDyyWwqZB8dgpVo0DRPWEEJOu4ZLebEs3qE78cPlwfeWe+l4L3SRefXf
         f1uNT8WvKIUthKl2CXvqaoEjQlZTD7eeLahXkdFKgEgIqZKUrC5q8t08bGH7ivqEyS
         mPpsjfRM7MZe43BkO2EYYonl35rrQsMvmy7GnUAvmBI91NIPUrhQ8RgyrhVCuDThzb
         8jg9EUrNsWKIh7/d6eg5pHR2A3jbNcvC20BNuPyWombTKs8HMsaGAstY6SUVcFmE/e
         FtNJplezw2zSw==
Date:   Fri, 30 Jul 2021 13:08:49 +0100
From:   Will Deacon <will@kernel.org>
To:     Barry Song <song.bao.hua@hisilicon.com>
Cc:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        mark.rutland@arm.com, tyhicks@linux.microsoft.com,
        linux@roeck-us.net, maz@kernel.org, tabba@google.com,
        lecopzer.chen@mediatek.com, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@arm.com>,
        Qi Liu <liuqi115@huawei.com>
Subject: Re: [PATCH] arm64: fix the doc of RANDOMIZE_MODULE_REGION_FULL
Message-ID: <20210730120849.GB23589@willie-the-truck>
References: <20210730105056.19784-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210730105056.19784-1-song.bao.hua@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2021 at 10:50:56PM +1200, Barry Song wrote:
> Obviously kaslr is setting the module region to 2GB rather than 4GB since
> commit b2eed9b588112 ("arm64/kernel: kaslr: reduce module randomization
> range to 2 GB").
> On the other hand, module_alloc() can fall back to a 2GB window even though
> RANDOMIZE_MODULE_REGION_FULL is not set. In this case, PLT is still needed.
> So fix the doc to be more precise to avoid any confusion to the readers of
> the code.
> 
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Ard Biesheuvel <ard.biesheuvel@arm.com>
> Cc: Qi Liu <liuqi115@huawei.com>
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> ---
>  arch/arm64/Kconfig        | 7 ++++---
>  arch/arm64/kernel/kaslr.c | 4 +++-
>  2 files changed, 7 insertions(+), 4 deletions(-)

Ack for the general idea, but I think this still isn't quite right...

> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index b5b13a932561..525c1f0b2430 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1800,11 +1800,11 @@ config RANDOMIZE_BASE
>  	  If unsure, say N.
>  
>  config RANDOMIZE_MODULE_REGION_FULL
> -	bool "Randomize the module region over a 4 GB range"
> +	bool "Randomize the module region over a 2 GB range"
>  	depends on RANDOMIZE_BASE
>  	default y
>  	help
> -	  Randomizes the location of the module region inside a 4 GB window
> +	  Randomizes the location of the module region inside a 2 GB window
>  	  covering the core kernel. This way, it is less likely for modules
>  	  to leak information about the location of core kernel data structures
>  	  but it does imply that function calls between modules and the core
> @@ -1812,7 +1812,8 @@ config RANDOMIZE_MODULE_REGION_FULL
>  
>  	  When this option is not set, the module region will be randomized over
>  	  a limited range that contains the [_stext, _etext] interval of the
> -	  core kernel, so branch relocations are always in range.
> +	  core kernel, so branch relocations are almost always in range unless
> +	  the region is exhausted and we fall back to a larger 2GB area.

Hmm, that's only true if ARM64_MODULE_PLTS=y.

Will
