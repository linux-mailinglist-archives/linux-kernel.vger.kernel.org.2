Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A27DA330EC9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 14:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbhCHNAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 08:00:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:52510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229655AbhCHM7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 07:59:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A40A364FB3;
        Mon,  8 Mar 2021 12:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615208391;
        bh=wxbL/Pa2LuwpiP3JjTmeepdQiCQNIv7MrwRtEg7zXKs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Axro0NZGoslIDIELA+vcrcmqfYkqa2Kispoq8GG1PhQ+GbLbBiVjYT8i8jgLKG4+t
         0fv43dyqgy73NVWZvlxfP7NEXWO08+h2cNMWE5stsP7Xn2lITSc9qLMVnWFStmBVXE
         vs1r1s8hmLch1KCzGcG4ydisTj2Ge23kJtK8xl42cLMN2A8UiDNErKDw5DcZHIFbD6
         9K8aQt38rkcpeItasZYjaZvhNVeGX18YxVC/VGGk2v8hRYu0rhxACMwLvrBvkRVoeZ
         F7aueLZ/eZ9SROhzZ4ZBToOl9R3Tct1GI87ov0yEXcXIT5M1xYVSUtTNMog3TwlzFj
         rbibwoRAigyVA==
Date:   Mon, 8 Mar 2021 12:59:46 +0000
From:   Will Deacon <will@kernel.org>
To:     Barry Song <song.bao.hua@hisilicon.com>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxarm@openeuler.org, Mel Gorman <mgorman@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] Documentation/features: mark BATCHED_UNMAP_TLB_FLUSH
 doesn't apply to ARM64
Message-ID: <20210308125946.GA26015@willie-the-truck>
References: <20210223003230.11976-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210223003230.11976-1-song.bao.hua@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 23, 2021 at 01:32:30PM +1300, Barry Song wrote:
> BATCHED_UNMAP_TLB_FLUSH is used on x86 to do batched tlb shootdown by
> sending one IPI to TLB flush all entries after unmapping pages rather
> than sending an IPI to flush each individual entry.
> On arm64, tlb shootdown is done by hardware. Flush instructions are
> innershareable. The local flushes are limited to the boot (1 per CPU)
> and when a task is getting a new ASID.
> So marking this feature as "TODO" is not proper. ".." isn't good as
> well. So this patch adds a "N/A" for this kind of features which are
> not needed on some architectures.
> 
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> ---
>  Documentation/features/arch-support.txt        | 1 +
>  Documentation/features/vm/TLB/arch-support.txt | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/features/arch-support.txt b/Documentation/features/arch-support.txt
> index d22a1095e661..118ae031840b 100644
> --- a/Documentation/features/arch-support.txt
> +++ b/Documentation/features/arch-support.txt
> @@ -8,4 +8,5 @@ The meaning of entries in the tables is:
>      | ok |  # feature supported by the architecture
>      |TODO|  # feature not yet supported by the architecture
>      | .. |  # feature cannot be supported by the hardware
> +    | N/A|  # feature doesn't apply to the architecture
>  
> diff --git a/Documentation/features/vm/TLB/arch-support.txt b/Documentation/features/vm/TLB/arch-support.txt
> index 30f75a79ce01..0d070f9f98d8 100644
> --- a/Documentation/features/vm/TLB/arch-support.txt
> +++ b/Documentation/features/vm/TLB/arch-support.txt
> @@ -9,7 +9,7 @@
>      |       alpha: | TODO |
>      |         arc: | TODO |
>      |         arm: | TODO |
> -    |       arm64: | TODO |
> +    |       arm64: | N/A  |
>      |         c6x: |  ..  |
>      |        csky: | TODO |
>      |       h8300: |  ..  |

Acked-by: Will Deacon <will@kernel.org>

Will
