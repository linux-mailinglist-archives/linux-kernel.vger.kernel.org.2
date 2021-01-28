Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB98307FB1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 21:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbhA1U2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 15:28:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:52538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231292AbhA1U1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 15:27:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8D79B64DA1;
        Thu, 28 Jan 2021 20:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611865616;
        bh=xUkEvlfwN3vzXkDI+dFINpbQYvnm02tIWsSrva06Mow=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZIVCMyxW5f7N7HczAlC51VnZLdKNmDnQ5813A/i/4BvDjLcbYVgSfU9dP6+p91Dcs
         pWmenLl/NjKmL5e8Bqv1uPG8U1sNRZW1+azBV8dAtylXAkZn1P0ueYlSOjbeh+qW0J
         w8sI1nrlvsLRzRTeWxIQqO1UE9FBkf/7gzkl3YDsggpFoTTSWmfN0Ojelan4XhEh1C
         cQfP+EsfGAQZYqDmuJtS9SWqfZ5MJ+yF/flmSWknlApj7EkjDAPaVugtb5uFSWTKft
         /Bv1CQQhtuiiSL2RDckGa4gsm3N5u1QRKO6fdpa+/otDLfm9QZMDNYR83zvZZio5Tp
         OqOzWSzsfGIvg==
Date:   Thu, 28 Jan 2021 20:26:49 +0000
From:   Will Deacon <will@kernel.org>
To:     Lecopzer Chen <lecopzer.chen@mediatek.com>
Cc:     akpm@linux-foundation.org, andreyknvl@google.com, ardb@kernel.org,
        aryabinin@virtuozzo.com, broonie@kernel.org,
        catalin.marinas@arm.com, dan.j.williams@intel.com,
        dvyukov@google.com, glider@google.com, gustavoars@kernel.org,
        kasan-dev@googlegroups.com, lecopzer@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-mm@kvack.org,
        linux@roeck-us.net, robin.murphy@arm.com, rppt@kernel.org,
        tyhicks@linux.microsoft.com, vincenzo.frascino@arm.com,
        yj.chiang@mediatek.com
Subject: Re: [PATCH v2 4/4] arm64: kaslr: support randomized module area with
 KASAN_VMALLOC
Message-ID: <20210128202648.GF3016@willie-the-truck>
References: <20210127230413.GA1016@willie-the-truck>
 <20210128085326.22553-1-lecopzer.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210128085326.22553-1-lecopzer.chen@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 04:53:26PM +0800, Lecopzer Chen wrote:
>  
> > On Sat, Jan 09, 2021 at 06:32:52PM +0800, Lecopzer Chen wrote:
> > > After KASAN_VMALLOC works in arm64, we can randomize module region
> > > into vmalloc area now.
> > > 
> > > Test:
> > > 	VMALLOC area ffffffc010000000 fffffffdf0000000
> > > 
> > > 	before the patch:
> > > 		module_alloc_base/end ffffffc008b80000 ffffffc010000000
> > > 	after the patch:
> > > 		module_alloc_base/end ffffffdcf4bed000 ffffffc010000000
> > > 
> > > 	And the function that insmod some modules is fine.
> > > 
> > > Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> > > Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
> > > ---
> > >  arch/arm64/kernel/kaslr.c  | 18 ++++++++++--------
> > >  arch/arm64/kernel/module.c | 16 +++++++++-------
> > >  2 files changed, 19 insertions(+), 15 deletions(-)
> > > 
> > > diff --git a/arch/arm64/kernel/kaslr.c b/arch/arm64/kernel/kaslr.c
> > > index 1c74c45b9494..a2858058e724 100644
> > > --- a/arch/arm64/kernel/kaslr.c
> > > +++ b/arch/arm64/kernel/kaslr.c
> > > @@ -161,15 +161,17 @@ u64 __init kaslr_early_init(u64 dt_phys)
> > >  	/* use the top 16 bits to randomize the linear region */
> > >  	memstart_offset_seed = seed >> 48;
> > >  
> > > -	if (IS_ENABLED(CONFIG_KASAN_GENERIC) ||
> > > -	    IS_ENABLED(CONFIG_KASAN_SW_TAGS))
> > > +	if (!IS_ENABLED(CONFIG_KASAN_VMALLOC) &&
> > > +	    (IS_ENABLED(CONFIG_KASAN_GENERIC) ||
> > 
> > CONFIG_KASAN_VMALLOC depends on CONFIG_KASAN_GENERIC so why is this
> > necessary?
> > 
> > Will
> 
> CONFIG_KASAN_VMALLOC=y means CONFIG_KASAN_GENERIC=y
> but CONFIG_KASAN_GENERIC=y doesn't means CONFIG_KASAN_VMALLOC=y
> 
> So this if-condition allows only KASAN rather than
> KASAN + KASAN_VMALLOC enabled.
> 
> Please correct me if I'm wrong.

Sorry, you're completely right -- I missed the '!' when I read this
initially.

Will
