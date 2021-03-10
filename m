Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E81343345BB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 18:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233516AbhCJRwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 12:52:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:54416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233188AbhCJRwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 12:52:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DDAC564F88;
        Wed, 10 Mar 2021 17:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615398733;
        bh=doWCBtbU+Cvcw96n3h3mK98dT2eO39OIy2ytJMx9y/o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HbRFL6X5Fj+AzjAFIKT3gv0fcYLF1E5iyuyY2AkOGAb/8SEZ5IPqYn7G4WZa59r5n
         WFCAPpUY7qEj4NodwwJZcjTihZlXG8Cg8G13rBFScGLFM16DRsS+BKt8ESUxy/fjwU
         +o9RBuNIg5aOL4qRt67mY+FLFe7CpxM3HgMH1S3iaa44NaAYV43VtaQIXLLi+EuetB
         1n2jCS1hsduX/AE/aYKU/Qups/RX/lfHLGogmOv3syLcQy0YAumSWiC9tEXYUCqCAG
         7B0tbgk8Y8cj56IfHj1tKRAuHmDInG5Gfh9gBaxHtsKN6XzyB0rH21XSR3vKUF9Axz
         NjNyB5KTb+oHg==
Date:   Wed, 10 Mar 2021 19:52:03 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     x86@kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Baoquan He <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>,
        David Hildenbrand <david@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>, Qian Cai <cai@lca.pw>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v3 0/2] x86/setup: consolidate early memory reservations
Message-ID: <YEkHQ4PnxJkqJeoU@kernel.org>
References: <20210302100406.22059-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302100406.22059-1-rppt@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any comments on these?

On Tue, Mar 02, 2021 at 12:04:04PM +0200, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Hi,
> 
> David noticed that we do some of memblock_reserve() calls after allocations
> are possible:
> 
> https://lore.kernel.org/lkml/6ba6bde3-1520-5cd0-f987-32d543f0b79f@redhat.com
> 
> The below patches consolidate early memory reservations done during
> setup_arch() so that memory used by firmware, bootloader, kernel text/data
> and the memory that should be excluded from the available memory for
> whatever other reason is reserved before memblock allocations are possible.
> 
> The patches are rebased on v5.12-rc1 and I think x86 tree is the best way
> to merge them.
> 
> v3:
> * rebase on v5.12-rc1
> 
> v2: https://lore.kernel.org/lkml/20210128105711.10428-1-rppt@kernel.org
> * get rid of trim_platform_memory_ranges() and call trim_snb_memory()
>   directly, per Boris comments
> * massage changelog and comments to use passive voice, per Boris
> * add Acked-by and Reviewed-by, thanks Boris and David
> 
> v1: https://lore.kernel.org/lkml/20210115083255.12744-1-rppt@kernel.org
> 
> Mike Rapoport (2):
>   x86/setup: consolidate early memory reservations
>   x86/setup: merge several reservations of start of the memory
> 
>  arch/x86/kernel/setup.c | 95 ++++++++++++++++++++---------------------
>  1 file changed, 46 insertions(+), 49 deletions(-)
> 
> -- 
> 2.28.0
> 

-- 
Sincerely yours,
Mike.
