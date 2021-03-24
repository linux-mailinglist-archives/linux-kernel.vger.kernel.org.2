Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D45CE347E62
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 18:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236702AbhCXRAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 13:00:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:45212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236579AbhCXRAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 13:00:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8C50E61A0F;
        Wed, 24 Mar 2021 17:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616605205;
        bh=fExnnbT38v4VF5Hn3lh1Hsn+2r/ya3emRHTyqYl8JyU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gvRdEGhDomS+t5R9+mYpi/MBdByu/B49bm0C/W20Nq5GlUNk+S1coALoyNBgSa62r
         91y2XEghPxc/hD3D0hiDOyh/9eirhXUPrWeJhiVYwr8KtDPo5MymrBC2rkzi7XyD8K
         jciBgXv5GayefHN/h2uRuiCuI34TOV46JojLeR+MPterdSJVF5CzxM/6WfsMCIzMQ6
         Gto88i5TiGWBdBySmmmCXuS9s2fCS8mJ2cY5LPgygqHUfIXGhiwwdfGJ/HGrN3USYr
         /UYmHCIU/8DjZxxjYW4N0MB5X+IFUoHTEQMu/SAHUwSZXQ394q84C7JYddu42yuITs
         BLwYCK9ctp8Uw==
Date:   Wed, 24 Mar 2021 17:00:00 +0000
From:   Will Deacon <will@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, james.morse@arm.com, marcan@marcan.st,
        maz@kernel.org, tglx@linutronix.de
Subject: Re: [PATCHv3 5/6] arm64: Always keep DAIF.[IF] in sync
Message-ID: <20210324165956.GD13030@willie-the-truck>
References: <20210315115629.57191-1-mark.rutland@arm.com>
 <20210315115629.57191-6-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315115629.57191-6-mark.rutland@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 11:56:28AM +0000, Mark Rutland wrote:
> From: Hector Martin <marcan@marcan.st>
> 
> Apple SoCs (A11 and newer) have some interrupt sources hardwired to the
> FIQ line. We implement support for this by simply treating IRQs and FIQs
> the same way in the interrupt vectors.
> 
> To support these systems, the FIQ mask bit needs to be kept in sync with
> the IRQ mask bit, so both kinds of exceptions are masked together. No
> other platforms should be delivering FIQ exceptions right now, and we
> already unmask FIQ in normal process context, so this should not have an
> effect on other systems - if spurious FIQs were arriving, they would
> already panic the kernel.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Tested-by: Hector Martin <marcan@marcan.st>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Will Deacon <will@kernel.org>
> ---
>  arch/arm64/include/asm/arch_gicv3.h |  2 +-
>  arch/arm64/include/asm/assembler.h  |  8 ++++----
>  arch/arm64/include/asm/daifflags.h  | 10 +++++-----
>  arch/arm64/include/asm/irqflags.h   | 16 +++++++---------
>  arch/arm64/kernel/entry.S           | 12 +++++++-----
>  arch/arm64/kernel/process.c         |  2 +-
>  arch/arm64/kernel/smp.c             |  1 +
>  7 files changed, 26 insertions(+), 25 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
