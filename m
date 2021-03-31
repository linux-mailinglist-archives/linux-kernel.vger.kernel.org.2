Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33F0734F7A5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 05:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbhCaD4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 23:56:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:55276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230160AbhCaD4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 23:56:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B7A08619C9;
        Wed, 31 Mar 2021 03:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617162962;
        bh=ljMJHCKTY/brMzUHBRt0hpZFr+FZzYQXin8Vwl3K2iY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i7PzESZpx3fS3ILnhJ40jkn2akou/X7RkZr0IggufQYbXDcCU6ubDll+Gs1phFsxp
         A1uKDIWJKkYkhQTFe2AcSLfvCXEM+AvPIQn16wCyrX5a9WkW/Lhc1n4zUh8gTcwN2B
         ayc+fDYW/B63QWdf8Zar0ZcYUFVmQxBg4c0zZ8d8vBmDBp8NScc/O76nzgS6mFt4o1
         cZ7T1SXbFRgfCL3gMveK4L0CDw18wPFl/nePZMvuvBFdstjF2Px6NGcyGqmDHosjk3
         fK1UUtsTFA0IhvX9McHaLSQfhUsXAB2JYCg4m9Ykq4q07uYM1QGhCuI2QihLvKF9lo
         k52w20eJUVKMw==
Date:   Wed, 31 Mar 2021 06:55:58 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Hyunsoon Kim <h10.kim@samsung.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, dseok.yi@samsung.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: add ___GFP_NOINIT flag which disables zeroing on
 alloc
Message-ID: <YGPyzmM+5gnQQnlR@unreal>
References: <CGME20210329054156epcas2p31650fa755e6cbcc55c4f33a79878256f@epcas2p3.samsung.com>
 <1616995751-83180-1-git-send-email-h10.kim@samsung.com>
 <YGF09yYtxeNj4Bcc@unreal>
 <20210329101255.GA144155@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210329101255.GA144155@ubuntu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 07:12:55PM +0900, Hyunsoon Kim wrote:
> On Mon, Mar 29, 2021 at 09:34:31AM +0300, Leon Romanovsky wrote:
> > On Mon, Mar 29, 2021 at 02:29:10PM +0900, Hyunsoon Kim wrote:
> > > This patch allows programmer to avoid zero initialization on page
> > > allocation even when the kernel config "CONFIG_INIT_ON_ALLOC_DEFAULT"
> > > is enabled. The configuration is made to prevent uninitialized
> > > heap memory flaws, and Android has applied this for security and
> > > deterministic execution times. Please refer to below.
> > > 
> > > https://android-review.googlesource.com/c/kernel/common/+/1235132
> > > 
> > > However, there is a case that the zeroing page memory is unnecessary
> > > when the page is used on specific purpose and will be zeroed
> > > automatically by hardware that accesses the memory through DMA.
> > > For instance, page allocation used for IP packet reception from Exynos
> > > modem is solely used for packet reception. Although the page will be
> > > freed eventually and reused for some other purpose, initialization at
> > > that moment of reuse will be sufficient to avoid uninitialized heap
> > > memory flaws. To support this kind of control, this patch creates new
> > > gfp type called ___GFP_NOINIT, that allows no zeroing at the moment
> > > of page allocation, called by many related APIs such as page_frag_alloc,
> > > alloc_pages, etc.
> > > 
> > > Signed-off-by: Hyunsoon Kim <h10.kim@samsung.com>
> > > ---
> > >  include/linux/gfp.h | 2 ++
> > >  include/linux/mm.h  | 4 +++-
> > >  2 files changed, 5 insertions(+), 1 deletion(-)
> > 
> > Let's assume that we will use this new flag, and users are smart enough
> > to figure when it needs to be used, what will be the performance gain?
> > 
> > Thanks
> 
> For instance, there are four memory access (either read or write) done
> by the system; memory write due to page allocation for reserving memory
> for modem hardware, memory write on the page by modem hardware,
> read and write incurred by copy_to_user operation by iperf reading
> the incoming network data. Theoretically, we can expect 1/4 of power
> saving on DRAM bandwidth. By performing simple iperf test with download
> UDP 800Mbps, we saw 5-6mA power gain by disabling
> CONFIG_INIT_ON_ALLOC_DEFAULT.

I'm more interested to see real results.

Thanks

> 
> Thanks


