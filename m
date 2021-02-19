Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7092331FF55
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 20:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbhBSTS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 14:18:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:56412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229725AbhBSTSx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 14:18:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0D6A164E15;
        Fri, 19 Feb 2021 19:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613762293;
        bh=Nh1g4Cl03duznMm2PeHMKLPYAO5dMbJjFdDxNT2KAss=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AdgROnoKSCedc1SEauF3FJpf73XnKvbhHAUliQOGa59+/mXLlVIYEEfIDMvxYyMSE
         gEdOz20c7k6P3P4HDlKud0Ew9408Xu+IOjlsCMUcRLCkprSU6KNzK4VR6yypnLqwpW
         Xi5KhTKQDPGQm2uLnoBgbz7fAPTr2XlLbVELDYKMAcAaC56ZPBb43iTfzrakuB3HV6
         ZMsv3D6DGwT6388VGgdOYYp4Ib78ouhrwIfK8kRLRBS2FrsGmWOaKeRu1UpxJ/ssyg
         QtyWQonUQwgvxihl/YeTgkIW+K3bZF3ZEgT++b9AZiEqrBOpQChjLF94MhV7sMP1x3
         5BTnvOE9s4mZg==
Date:   Fri, 19 Feb 2021 19:18:07 +0000
From:   Will Deacon <will@kernel.org>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     tyhicks@linux.microsoft.com, jmorris@namei.org,
        catalin.marinas@arm.com, akpm@linux-foundation.org,
        anshuman.khandual@arm.com, rppt@kernel.org, logang@deltatee.com,
        ardb@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, mhocko@suse.com, linux-mm@kvack.org
Subject: Re: [PATCH v3 1/1] arm64: mm: correct the inside linear map range
 during hotplug check
Message-ID: <20210219191807.GB6683@willie-the-truck>
References: <20210216150351.129018-1-pasha.tatashin@soleen.com>
 <20210216150351.129018-2-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210216150351.129018-2-pasha.tatashin@soleen.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 16, 2021 at 10:03:51AM -0500, Pavel Tatashin wrote:
> Memory hotplug may fail on systems with CONFIG_RANDOMIZE_BASE because the
> linear map range is not checked correctly.
> 
> The start physical address that linear map covers can be actually at the
> end of the range because of randomization. Check that and if so reduce it
> to 0.
> 
> This can be verified on QEMU with setting kaslr-seed to ~0ul:
> 
> memstart_offset_seed = 0xffff
> START: __pa(_PAGE_OFFSET(vabits_actual)) = ffff9000c0000000
> END:   __pa(PAGE_END - 1) =  1000bfffffff
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> Fixes: 58284a901b42 ("arm64/mm: Validate hotplug range before creating linear mapping")
> Tested-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> ---
>  arch/arm64/mm/mmu.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)

I tried to queue this as a fix, but unfortunately it doesn't apply.
Please can you send a v4 based on the arm64 for-next/fixes branch?

Thanks,

Will
