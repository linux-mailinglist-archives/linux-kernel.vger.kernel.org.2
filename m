Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 977DB31118E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 20:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbhBESMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 13:12:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:59758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231876AbhBESGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 13:06:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8735764FB9;
        Fri,  5 Feb 2021 19:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612554484;
        bh=GZ+b1kU4JUoiFiBwyWo3d5VZBweulhY5fb5aylFJK0M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TNSRusS29OM3NmEFZXrF8kbEORqk9Y9/ujpQm2/Cd02gVQdkSRe9c/tTdpdIFVG+R
         Slv3/yry59xcJI5l2g8H2mF1l3NenR4n+eyhSK1+m+Tqt5IqeYCXMkB95c2UFACvzd
         O3HxgN6fcA43asBKrO8Z3Ue6YONW9PsVvzOTIFk5YFoAEvOLanH9RW9adE6c3tCbE1
         kP211K7KRN55TEUfLh3rfklKH1x/qDAPSm1ccsQ3bqFKmzXpBWTDr9JdhCT4G8gyZn
         w0qrLcbxvfyw9ZYROSUj0HJsgkbCUrcpAuydwb5IXnuFR+HjFmSBx8IseTtRWGA2+X
         WSDlQLhJ5tLqg==
Date:   Fri, 5 Feb 2021 21:47:54 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Baoquan He <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>,
        David Hildenbrand <david@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>, Qian Cai <cai@lca.pw>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v2 0/2] x86/setup: consolidate early memory reservations
Message-ID: <20210205194754.GT242749@kernel.org>
References: <20210128105711.10428-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210128105711.10428-1-rppt@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Any comments on this?

On Thu, Jan 28, 2021 at 12:57:09PM +0200, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Hi,
> 
> David noticed that we do some of memblock_reserve() calls after allocations
> are possible:
> 
> https://lore.kernel.org/lkml/6ba6bde3-1520-5cd0-f987-32d543f0b79f@redhat.com
> 
> For now there is no actual problem because in top-down mode we allocate
> from the end of the memory and in bottom-up mode we allocate above the
> kernel image. But there is a patch in the mm tree that allow bottom-up
> allocations below the kernel:
> 
> https://lore.kernel.org/lkml/20201217201214.3414100-2-guro@fb.com
> 
> and with this change we may get a memory corruption if an allocation steps
> on some of the firmware areas that are yet to be reserved.
> 
> The below patches consolidate early memory reservations done during
> setup_arch() so that memory used by firmware, bootloader, kernel text/data
> and the memory that should be excluded from the available memory for
> whatever other reason is reserved before memblock allocations are possible.
> 
> The patches are vs v5.11-rc3-mmots-2021-01-12-02-00 as I think they are
> prerequisite for the memblock bottom-up changes, but if needed I can rebase
> then on another tree.
> 
> v2:
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
>  arch/x86/kernel/setup.c | 96 ++++++++++++++++++-----------------------
>  1 file changed, 42 insertions(+), 54 deletions(-)
> 
> -- 
> 2.28.0
> 

-- 
Sincerely yours,
Mike.
