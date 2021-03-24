Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04812347E2D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 17:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236294AbhCXQto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 12:49:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:43392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236432AbhCXQt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 12:49:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 635A2619F3;
        Wed, 24 Mar 2021 16:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616604566;
        bh=z7u23l1L1urULCfNXhb+ljpef7GftgjOaulfS2dx3Y4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DqMYMYsQj8+grxt4l7MHbDguytm2ZtqupYhBMki6TcrNfeYmJDNIMRiiLPZMWna74
         0PsCww+Yw1aYWXtAIBD44Gf8PlWORyRxkDdzIIn9xmkkpywc0y9xMh+DYUpqX/oenp
         6aHU+a7zWf/+pa0QmJuJw13pLuquLhc0uH20UMu4XSX9+XEb802TGJRhdb8TzRTDVg
         OC4v3WftAnnPA/Jq5fQJ/ZAqCPV5AHNx31Rju7YStypjJP9RQ59fbpJYgR6p6id9Mj
         PzxejVzI8s1HvmILjomIK2xURR9BGmkBLtxdoLCPsGgXIiqiuoJTj57Dg0gN++qzDI
         QhgPYgqjZ5fOA==
Date:   Wed, 24 Mar 2021 16:49:22 +0000
From:   Will Deacon <will@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, james.morse@arm.com, marcan@marcan.st,
        maz@kernel.org, tglx@linutronix.de
Subject: Re: [PATCHv3 3/6] arm64: irq: rework root IRQ handler registration
Message-ID: <20210324164921.GB13030@willie-the-truck>
References: <20210315115629.57191-1-mark.rutland@arm.com>
 <20210315115629.57191-4-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315115629.57191-4-mark.rutland@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 11:56:26AM +0000, Mark Rutland wrote:
> If we accidentally unmask IRQs before we've registered a root IRQ
> handler, handle_arch_irq will be NULL, and the IRQ exception handler
> will branch to a bogus address.
> 
> To make this easier to debug, this patch initialises handle_arch_irq to
> a default handler which will panic(), making such problems easier to
> debug. When we add support for FIQ handlers, we can follow the same
> approach.
> 
> When we add support for a root FIQ handler, it's possible to have root
> IRQ handler without an root FIQ handler, and in theory the inverse is
> also possible. To permit this, and to keep the IRQ/FIQ registration
> logic similar, this patch removes the panic in the absence of a root IRQ
> controller. Instead, set_handle_irq() logs when a handler is registered,
> which is sufficient for debug purposes.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Tested-by: Hector Martin <marcan@marcan.st>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Will Deacon <will@kernel.org>
> ---
>  arch/arm64/kernel/irq.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
