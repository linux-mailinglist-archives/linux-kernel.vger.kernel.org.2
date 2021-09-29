Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35A6541C3EE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 13:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343528AbhI2L4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 07:56:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:50678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343559AbhI2L4h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 07:56:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B2A456136A;
        Wed, 29 Sep 2021 11:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632916493;
        bh=EZ71/Hs+sFEq9J5Fv5IdbNz2X8Ij31zbmQ2wxKWDiOo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F3Euc0uHxd7XebKMfcFXFKgfeD+VCo37VEbfQm/1QSkarQTeqTCKd1XGhkyiyWd/u
         utkV8LHwJsfRVKvvL9/omgl8Tq3cl0S5G4jFq0BUlCFptDvatQ2Kq51nWoUu93aRCc
         YchiKm313sbqrLCEDDSLBpqXEwH0/n5Kd/MYzEAVsdWSdN9Ln06J9M7tO6fI4VW8St
         OrRRBX2+IFfANR2SRMoSa5glpF8rjPyycAvBet1NqBD1Ob+idAlCV949ktkT2pQjJb
         KBM+f9kahwmVQ+xuxWsvg4bwE1R2f/sNPi2R2Li3M4NVxejUoCo7m9MY7RN6bLzc4+
         wvkksbgUu/uaA==
Date:   Wed, 29 Sep 2021 12:54:48 +0100
From:   Will Deacon <will@kernel.org>
To:     yee.lee@mediatek.com
Cc:     linux-kernel@vger.kernel.org, nicholas.Tang@mediatek.com,
        Kuan-Ying.lee@mediatek.com, chinwen.chang@mediatek.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH] scs: Release kasan vmalloc poison in scs_free process
Message-ID: <20210929115447.GA21631@willie-the-truck>
References: <20210923095316.13867-1-yee.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210923095316.13867-1-yee.lee@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 05:53:12PM +0800, yee.lee@mediatek.com wrote:
> From: Yee Lee <yee.lee@mediatek.com>
> 
> Since scs allocation has been moved to vmalloc region, the
> shadow stack is protected by kasan_posion_vmalloc.
> However, the vfree_atomic operation needs to access
> its context for scs_free process and causes kasan error
> as the dump info below.
> 
> This patch Adds kasan_unpoison_vmalloc() before vfree_atomic,
> which aligns to the prior flow as using kmem_cache.
> The vmalloc region will go back posioned in the following
> vumap() operations.
> 
>  ==================================================================
>  BUG: KASAN: vmalloc-out-of-bounds in llist_add_batch+0x60/0xd4
>  Write of size 8 at addr ffff8000100b9000 by task kthreadd/2
> 
>  CPU: 0 PID: 2 Comm: kthreadd Not tainted 5.15.0-rc2-11681-(skip)
>  Hardware name: linux,dummy-virt (DT)
>  Call trace:
>   dump_backtrace+0x0/0x43c
>   show_stack+0x1c/0x2c
>   dump_stack_lvl+0x68/0x84
>   print_address_description+0x80/0x394
>   kasan_report+0x180/0x1dc
>   __asan_report_store8_noabort+0x48/0x58
>   llist_add_batch+0x60/0xd4
>   vfree_atomic+0x60/0xe0
>   scs_free+0x1dc/0x1fc
>   scs_release+0xa4/0xd4
>   free_task+0x30/0xe4

Thanks, I can reproduce this easily with mainline. We only recently gained
vmalloc support for kasan on arm64, so that's probably why we didn't spot
this earlier.

> diff --git a/kernel/scs.c b/kernel/scs.c
> index e2a71fc82fa0..25c0d8e416e6 100644
> --- a/kernel/scs.c
> +++ b/kernel/scs.c
> @@ -68,6 +68,7 @@ void scs_free(void *s)
>  
>  	__scs_account(s, -1);
>  
> +	kasan_unpoison_vmalloc(s, SCS_SIZE);
>  	/*
>  	 * We cannot sleep as this can be called in interrupt context,
>  	 * so use this_cpu_cmpxchg to update the cache, and vfree_atomic

I don't think we should be unpoisoning the stack pages if we're putting
them back on to the local cache -- unpoisoning happens on the alloc path
in that case anyway so that we can zero them.

So how about sending a v2 with this moved a bit later (see below)? With
that change:

Acked-by: Will Deacon <will@kernel.org>
Tested-by: Will Deacon <will@kernel.org>

Thanks,

Will

--->8

diff --git a/kernel/scs.c b/kernel/scs.c
index e2a71fc82fa0..579841be8864 100644
--- a/kernel/scs.c
+++ b/kernel/scs.c
@@ -78,6 +78,7 @@ void scs_free(void *s)
                if (this_cpu_cmpxchg(scs_cache[i], 0, s) == NULL)
                        return;
 
+       kasan_unpoison_vmalloc(s, SCS_SIZE);
        vfree_atomic(s);
 }
