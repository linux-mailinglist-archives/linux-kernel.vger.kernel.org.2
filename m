Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5FA30FA7D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 19:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238777AbhBDR7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 12:59:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:38334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238430AbhBDR5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 12:57:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6061964E16;
        Thu,  4 Feb 2021 17:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612461427;
        bh=3sPIg9fnAown5IUecDaUUMqiHn7bKJeyVpbW19hTsso=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fvZC0GgAhbuDO6RriMojAl/CW+Fp3wdv9ID1v6pR5TsmJRuUTuY3Yk4dEnvXcfstE
         2S7BoGrI11pVfImSibDzFy3l9+tRdSS1jqpVHwGPN7ldhHUL7Eo7iHkJpEWpD4s8Bf
         zMI+nTiKiWxrJBnGhVEcPL5AXZCxn8enHrCLxdMpdeWuscnZO2q5FFeiVKzA9TThTO
         3fjCXiLzybhHWpVLQQwBDyNuF0tsp+E6UarJkit7bwil7PB1+jaiRS0y/s/8cB+W6s
         V05v52MdeOXWXxplLWoeWSwvs3oOISA6vUGgdjFq3yd2r5u7TEvsQ39PFF3KlW0cWF
         ztCFT1Up4ukXg==
Date:   Thu, 4 Feb 2021 17:57:00 +0000
From:   Will Deacon <will@kernel.org>
To:     Lecopzer Chen <lecopzer@gmail.com>
Cc:     akpm@linux-foundation.org, andreyknvl@google.com, ardb@kernel.org,
        aryabinin@virtuozzo.com, broonie@kernel.org,
        catalin.marinas@arm.com, dan.j.williams@intel.com,
        dvyukov@google.com, glider@google.com, gustavoars@kernel.org,
        kasan-dev@googlegroups.com, lecopzer.chen@mediatek.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-mm@kvack.org,
        linux@roeck-us.net, robin.murphy@arm.com, rppt@kernel.org,
        tyhicks@linux.microsoft.com, vincenzo.frascino@arm.com,
        yj.chiang@mediatek.com
Subject: Re: [PATCH v2 0/4] arm64: kasan: support CONFIG_KASAN_VMALLOC
Message-ID: <20210204175659.GC21303@willie-the-truck>
References: <20210204124914.GC20468@willie-the-truck>
 <20210204155346.88028-1-lecopzer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204155346.88028-1-lecopzer@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 11:53:46PM +0800, Lecopzer Chen wrote:
> > On Sat, Jan 09, 2021 at 06:32:48PM +0800, Lecopzer Chen wrote:
> > > Linux supports KAsan for VMALLOC since commit 3c5c3cfb9ef4da9
> > > ("kasan: support backing vmalloc space with real shadow memory")
> > > 
> > > Acroding to how x86 ported it [1], they early allocated p4d and pgd,
> > > but in arm64 I just simulate how KAsan supports MODULES_VADDR in arm64
> > > by not to populate the vmalloc area except for kimg address.
> > 
> > The one thing I've failed to grok from your series is how you deal with
> > vmalloc allocations where the shadow overlaps with the shadow which has
> > already been allocated for the kernel image. Please can you explain?
> 
> 
> The most key point is we don't map anything in the vmalloc shadow address.
> So we don't care where the kernel image locate inside vmalloc area.
> 
>   kasan_map_populate(kimg_shadow_start, kimg_shadow_end,...)
> 
> Kernel image was populated with real mapping in its shadow address.
> I `bypass' the whole shadow of vmalloc area, the only place you can find
> about vmalloc_shadow is
> 	kasan_populate_early_shadow((void *)vmalloc_shadow_end,
> 			(void *)KASAN_SHADOW_END);
> 
> 	-----------  vmalloc_shadow_start
>  |           |
>  |           | 
>  |           | <= non-mapping
>  |           |
>  |           |
>  |-----------|
>  |///////////|<- kimage shadow with page table mapping.
>  |-----------|
>  |           |
>  |           | <= non-mapping
>  |           |
>  ------------- vmalloc_shadow_end
>  |00000000000|
>  |00000000000| <= Zero shadow
>  |00000000000|
>  ------------- KASAN_SHADOW_END
> 
> vmalloc shadow will be mapped 'ondemend', see kasan_populate_vmalloc()
> in mm/vmalloc.c in detail.
> So the shadow of vmalloc will be allocated later if anyone use its va.

Indeed, but the question I'm asking is what happens when an on-demand shadow
allocation from vmalloc overlaps with the shadow that we allocated early for
the kernel image?

Sounds like I have to go and read the code...

Will
