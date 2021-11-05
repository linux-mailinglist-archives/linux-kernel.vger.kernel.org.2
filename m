Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59720446284
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 12:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbhKELIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 07:08:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:37048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231312AbhKELIp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 07:08:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9EBBF6008E;
        Fri,  5 Nov 2021 11:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636110366;
        bh=gJsm1IizLqHIU46nqJ2PCv1weO5m/+2Lhx/GTelVNiA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uKknH7Xo3L4tFaDX1x10uGTlyVBD8Pp4ABE1Nd6UfR4udeBpijbZRzg2e/wl1LBDi
         oU7vKRK6ylEEkUbz6G2lXztI5Z56Z1/C/jWh2euo0IRIb3z9doWrztVJuejnH4XNmj
         wp4FYpWDS3vR91479Qi8qBmLwsxkXj7gfKB/NXKB3TxhGj432VRQBMAwsWVifm5OM2
         lz8EeR9tRp8idUnHCk47LG7uL5nCfRzH7+qg4g+dUTx9rWnMVGRk57ujHNhiyIRqLI
         adN/QVDYKJsQ+S1aOJLIsJeEn+hkIu2Bhltdxbjdhm0TYWiCeTGdQgesPgunBPQ3ow
         zGCcD9kAFT/NQ==
Date:   Fri, 5 Nov 2021 13:05:58 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Qian Cai <quic_qiancai@quicinc.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: Track no early_pgtable_alloc() for kmemleak
Message-ID: <YYUQFv4osDcMt0mS@kernel.org>
References: <20211104155623.11158-1-quic_qiancai@quicinc.com>
 <YYQTKRrDIJbkcplr@kernel.org>
 <9bb6fe11-c10a-a373-9288-d44a5ba976fa@quicinc.com>
 <YYUChdTeXP/OQUwS@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYUChdTeXP/OQUwS@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2021 at 10:08:05AM +0000, Catalin Marinas wrote:
> On Thu, Nov 04, 2021 at 01:57:03PM -0400, Qian Cai wrote:
> > On 11/4/21 1:06 PM, Mike Rapoport wrote:
> > > I think I'll be better to rename MEMBLOCK_ALLOC_KASAN to, say,
> > > MEMBLOCK_ALLOC_NOKMEMLEAK and use that for both KASAN and page table cases.
> > 
> > Okay, that would look a bit nicer.
> 
> Or MEMBLOCK_ALLOC_ACCESSIBLE_NOLEAKTRACE to match SLAB_NOLEAKTRACE and
> also hint that it's accessible memory.

Hmm, I think MEMBLOCK_ALLOC_NOLEAKTRACE is enough. Having a constant
instead of end limit already implies there is no limit and when we update
the API to use lower bits or a dedicated 'flags' we won't need to change
the flag name as well.

> > > But more generally, we are going to hit this again and again.
> > > Couldn't we add a memblock allocation as a mean to get more memory to
> > > kmemleak::mem_pool_alloc()?
> > 
> > For the last 5 years, this is the second time I am ware of this kind of
> > issue just because of the 64KB->4KB switch on those servers, although I
> > agree it could happen again in the future due to some new debugging
> > features etc. I don't feel a strong need to rewrite it now though. Not
> > sure if Catalin saw things differently. Anyway, Mike, do you agree that
> > we could rewrite that separately in the future?
> 
> I was talking to Mike on IRC last night and I think you still need a
> flag, otherwise you could get a recursive memblock -> kmemleak ->
> memblock call (that's why we have SLAB_NOLEAKTRACE). So for the time
> being, a new MEMBLOCK_* definition would do.
> 
> I wonder whether we could actually use the bottom bits in the end/limit
> as actual flags so one can do (MEMBLOCK_ALLOC_ACCESSIBLE |
> MEMBLOCK_NOLEAKTRACE). But that could be for a separate clean-up.

We never restricted end/limit to be on a word boundary, but I doubt that in
practice we'd ever have the low bits set.

I'm not entirely happy with using end limit parameter for this, I'd like to
see how much churn it will be to extend some of memblock_*_alloc with an
explicit flags parameter.

--
Sincerely yours,
Mike.
