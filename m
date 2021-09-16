Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECD840DCE7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 16:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238718AbhIPOf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 10:35:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:57426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238725AbhIPOft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 10:35:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 21B94611F2;
        Thu, 16 Sep 2021 14:34:27 +0000 (UTC)
Date:   Thu, 16 Sep 2021 15:34:25 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/mm/hotplug: Warn when memory limit has been reduced
Message-ID: <YUNV8fOxfSSFKZBK@arm.com>
References: <1631602270-29215-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1631602270-29215-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 12:21:10PM +0530, Anshuman Khandual wrote:
> If the max memory limit has been reduced with 'mem=' kernel command line
> option, there might be UEFI memory map described memory beyond that limit
> which could be hot removed. This might be problematic for subsequent kexec
> kernel which could just access such removed memory.
> 
> Memory offline notifier exists because there is no other way to block the
> removal of boot memory, only the offlining (which isn't actually a problem)
> But with 'mem=', there is no chance to stop such boot memory being offlined
> as it where never in use by the kernel. As 'mem=' is a debug only option on
> arm64 platform, just warn for such a situation and move on.

Just to make sure I understand, is the memory beyond the mem= limit
considered online by the core code and it can be subsequently offlined?
Looking at walk_system_ram_range(), it doesn't seem to care about the
removed memblock ranges. Would such memory beyond the mem= limit need to
have been onlined first?

> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index cfd9deb347c3..7ac39ee876c3 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -1627,6 +1627,18 @@ static int __init prevent_bootmem_remove_init(void)
>  	if (!IS_ENABLED(CONFIG_MEMORY_HOTREMOVE))
>  		return ret;
>  
> +	if (has_mem_limit_reduced()) {
> +		/*
> +		 * Physical memory limit has been reduced via the 'mem=' kernel
> +		 * command line option. Memory beyond reduced limit could now be
> +		 * removed and reassigned (guest ?) transparently to the kernel.
> +		 * This might cause subsequent kexec kernel to crash or at least
> +		 * corrupt the memory when accessing UEFI memory map enumerated
> +		 * boot memory which might have been repurposed.
> +		 */
> +		pr_warn("Memory limit reduced, kexec might be problematic\n");
> +	}

I'd actually move the warning to hotplug notifier callback rather than
the init function. I'd also make it pr_warn_once().

-- 
Catalin
