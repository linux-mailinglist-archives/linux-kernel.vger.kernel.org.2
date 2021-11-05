Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D23024461F3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 11:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233023AbhKEKKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 06:10:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:52922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230110AbhKEKKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 06:10:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 902CC611EE;
        Fri,  5 Nov 2021 10:08:08 +0000 (UTC)
Date:   Fri, 5 Nov 2021 10:08:05 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     Mike Rapoport <rppt@kernel.org>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: Track no early_pgtable_alloc() for kmemleak
Message-ID: <YYUChdTeXP/OQUwS@arm.com>
References: <20211104155623.11158-1-quic_qiancai@quicinc.com>
 <YYQTKRrDIJbkcplr@kernel.org>
 <9bb6fe11-c10a-a373-9288-d44a5ba976fa@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9bb6fe11-c10a-a373-9288-d44a5ba976fa@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2021 at 01:57:03PM -0400, Qian Cai wrote:
> On 11/4/21 1:06 PM, Mike Rapoport wrote:
> > I think I'll be better to rename MEMBLOCK_ALLOC_KASAN to, say,
> > MEMBLOCK_ALLOC_NOKMEMLEAK and use that for both KASAN and page table cases.
> 
> Okay, that would look a bit nicer.

Or MEMBLOCK_ALLOC_ACCESSIBLE_NOLEAKTRACE to match SLAB_NOLEAKTRACE and
also hint that it's accessible memory.

> > But more generally, we are going to hit this again and again.
> > Couldn't we add a memblock allocation as a mean to get more memory to
> > kmemleak::mem_pool_alloc()?
> 
> For the last 5 years, this is the second time I am ware of this kind of
> issue just because of the 64KB->4KB switch on those servers, although I
> agree it could happen again in the future due to some new debugging
> features etc. I don't feel a strong need to rewrite it now though. Not
> sure if Catalin saw things differently. Anyway, Mike, do you agree that
> we could rewrite that separately in the future?

I was talking to Mike on IRC last night and I think you still need a
flag, otherwise you could get a recursive memblock -> kmemleak ->
memblock call (that's why we have SLAB_NOLEAKTRACE). So for the time
being, a new MEMBLOCK_* definition would do.

I wonder whether we could actually use the bottom bits in the end/limit
as actual flags so one can do (MEMBLOCK_ALLOC_ACCESSIBLE |
MEMBLOCK_NOLEAKTRACE). But that could be for a separate clean-up.

-- 
Catalin
