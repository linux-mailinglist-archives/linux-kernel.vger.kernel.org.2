Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1443F0E8F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 01:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234642AbhHRXSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 19:18:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:35192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229478AbhHRXSb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 19:18:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B0C156109F;
        Wed, 18 Aug 2021 23:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629328675;
        bh=XKBZINRyW/UrTDUSlaarFzlfun8zrJZ24Pltkjo4uN4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=IhJFKk/9ugg3wqGXkhmjxxhShefQv6x4KyDDJrmm2+5Kzx5IX8RJDHqf+BanSIA20
         Qy5EZtk3cHSTl77fcdKG+xEoJgAm+CHTJ44Ie0VDDbMp2UEI5GVmKK6iR9asqpdQnu
         EK6eIa+VwwFEiVx2N0xjPRavM5QPyFfK+LhvP+ViAGUDHpeN3FHnSq/5FHV5o70Aee
         y5zKdLFZVgC6GdCCGgkoRxPRVqYb3MJ0Cj3saxdz5OXCLIUgI1AyVTRcoiZMK2Z19K
         Abjo1DRnkdGULlmvDu1w3BNCA6I/GDwLYUuUXwKwwQhDs3s9jdh8jFrL/u3sr0fgq0
         4arVYXYtJYTQA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 73EBE5C04B1; Wed, 18 Aug 2021 16:17:55 -0700 (PDT)
Date:   Wed, 18 Aug 2021 16:17:55 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Marco Elver <elver@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: LKMM: Read dependencies of writes ordered by dma_wmb()?
Message-ID: <20210818231755.GZ4126399@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <YRo58c+JGOvec7tc@elver.google.com>
 <20210816145945.GB121345@rowland.harvard.edu>
 <YRqfJz/lpUaZpxq7@elver.google.com>
 <20210816192109.GC121345@rowland.harvard.edu>
 <20210816205057.GN4126399@paulmck-ThinkPad-P17-Gen-1>
 <20210817122816.GA12746@willie-the-truck>
 <20210817135308.GO4126399@paulmck-ThinkPad-P17-Gen-1>
 <20210818113935.GA14107@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210818113935.GA14107@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2021 at 12:39:36PM +0100, Will Deacon wrote:
> Hi Paul.

Hello, Will,

> On Tue, Aug 17, 2021 at 06:53:08AM -0700, Paul E. McKenney wrote:
> > On Tue, Aug 17, 2021 at 01:28:16PM +0100, Will Deacon wrote:

[ . . . ]

> > > Ignore the bits about mmiowb() as we got rid of that.
> > 
> > Should the leftovers in current mainline be replaced by wmb()?  Or are
> > patches to that effect on their way in somewhere?
> 
> I already got rid of the non-arch usage of mmiowb(), but I wasn't bravei
> enough to change the arch code as it may well be that they're relying on
> some specific instruction semantics.
> 
> Despite my earlier comment, mmiowb() still exists, but only as a part of
> ARCH_HAS_MMIOWB where it is used to add additional spinlock ordering so
> that the rest of the kernel doesn't need to use mmiowb() at all.
> 
> So I suppose for these:
> 
> > arch/mips/kernel/gpio_txx9.c:	mmiowb();
> > arch/mips/kernel/gpio_txx9.c:	mmiowb();
> > arch/mips/kernel/gpio_txx9.c:	mmiowb();
> > arch/mips/kernel/irq_txx9.c:	mmiowb();
> > arch/mips/loongson2ef/common/bonito-irq.c:	mmiowb();
> > arch/mips/loongson2ef/common/bonito-irq.c:	mmiowb();
> > arch/mips/loongson2ef/common/mem.c:		mmiowb();
> > arch/mips/loongson2ef/common/pm.c:	mmiowb();
> > arch/mips/loongson2ef/lemote-2f/reset.c:	mmiowb();
> > arch/mips/loongson2ef/lemote-2f/reset.c:	mmiowb();
> > arch/mips/loongson2ef/lemote-2f/reset.c:	mmiowb();
> > arch/mips/loongson2ef/lemote-2f/reset.c:	mmiowb();
> > arch/mips/loongson2ef/lemote-2f/reset.c:	mmiowb();
> > arch/mips/pci/ops-bonito64.c:	mmiowb();
> > arch/mips/pci/ops-loongson2.c:	mmiowb();
> > arch/mips/txx9/generic/irq_tx4939.c:	mmiowb();
> > arch/mips/txx9/generic/setup.c:	mmiowb();
> > arch/mips/txx9/rbtx4927/irq.c:	mmiowb();
> > arch/mips/txx9/rbtx4938/irq.c:	mmiowb();
> > arch/mips/txx9/rbtx4938/irq.c:	mmiowb();
> > arch/mips/txx9/rbtx4938/setup.c:	mmiowb();
> > arch/mips/txx9/rbtx4939/irq.c:	mmiowb();
> 
> we could replace mmiowb() with iobarrier_w().

Not having MIPS hardware at my disposal, I will leave these to those
who do.  I would suggest adding iobarrier_*() to memory-barriers.txt,
but they appear to be specific to MIPS and PowerPC.

							Thanx, Paul
