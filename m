Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D26D4243C2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 19:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238664AbhJFRQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 13:16:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:57626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229835AbhJFRQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 13:16:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A1B2760F58;
        Wed,  6 Oct 2021 17:14:41 +0000 (UTC)
Date:   Wed, 6 Oct 2021 18:14:38 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/arm64: add memory layout with 4KB pages +
 VA39-bit
Message-ID: <YV3ZfmSHHKSWfDQu@arm.com>
References: <20210930185026.1609f12e@xhacker.debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210930185026.1609f12e@xhacker.debian>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 06:50:26PM +0800, Jisheng Zhang wrote:
> The 4KB pages + 3 levels (39-bit) combination is also widely used in
> arm64 world, add the memory layout description for this combination.
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>  Documentation/arm64/memory.rst | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/Documentation/arm64/memory.rst b/Documentation/arm64/memory.rst
> index 901cd094f4ec..d1745b570f0c 100644
> --- a/Documentation/arm64/memory.rst
> +++ b/Documentation/arm64/memory.rst
> @@ -26,6 +26,23 @@ The swapper_pg_dir address is written to TTBR1 and never written to
>  TTBR0.
>  
>  
> +AArch64 Linux memory layout with 4KB pages + 3 levels (39-bit)::
> +  Start			End			Size		Use
> +  -----------------------------------------------------------------------
> +  0000000000000000	0000007fffffffff	 512GB		user
> +  ffffff8000000000	ffffffbfffffffff	 256GB		kernel logical memory map
> + [ffffffb000000000	ffffffbfffffffff]	  64GB		[kasan shadow region]
> +  ffffffc000000000	ffffffc007ffffff	 128MB		bpf jit region
> +  ffffffc008000000	ffffffc00fffffff	 128MB		modules
> +  ffffffc010000000	fffffffdefffffff      253440MB		vmalloc
> +  fffffffdf0000000	fffffffdfdffffff	 224MB		fixed mappings (top down)
> +  fffffffdfe000000	fffffffdfe7fffff	   8MB		[guard region]
> +  fffffffdfe800000	fffffffdff7fffff	  16MB		PCI I/O space
> +  fffffffdff800000	fffffffdffffffff	   8MB		[guard region]
> +  fffffffe00000000	ffffffffefffffff	   4GB		vmemmap
> +  ffffffff00000000	ffffffffffffffff	   4GB		[guard region]

I wouldn't bother maintaining these. There are other combinations that
people may use. The 4KB + 48-bit VA is defconfig while 64KB + 52-bit was
more interesting, so we thought it would be useful.

I'm more inclined to remove them altogether and maybe just add some
high-level ascii art as per the log of commit f4693c2716b3 ("arm64: mm:
extend linear region for 52-bit VA configurations").

-- 
Catalin
