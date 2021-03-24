Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30AD1347E76
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 18:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236630AbhCXRDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 13:03:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:45882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236672AbhCXRD2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 13:03:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AA96E61A0F;
        Wed, 24 Mar 2021 17:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616605408;
        bh=SfTG1Fnwf+9jTJzJLstp+/FdSqRD7VVDKqeIumMB8NU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LZtwson02LCx+HQ0D44CArLEAC2s2VIm6bZS2szlk6VKkT0ack9ZjVWAEUYwVO1UV
         PHnee5CdFoQe0LE6xIoxfh1xER6SCoyMXKxEnXrRoa0VhDHtELOdtgQqCMKuPm5rU/
         UmyEkxYSOIAYCZb+f5N5bh1n/ZAPAcLl3CdNpL9xEotR8sDVnUKOKwgxEIbwfRjmL7
         4sedWzEOMl4IeIKKjYpJhgpC/uT9Y28fADcYiknSDSCEpoeUDdLUXgZo8t0UByHRXD
         IaLKy8E6jssTz5zz/6EJTux/uaOmQFy6W4zBpWBc/NyFYlE8CZNRXNiB5Gptlr6ao6
         wo+1Hcz/b3APQ==
Date:   Wed, 24 Mar 2021 17:03:23 +0000
From:   Will Deacon <will@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, james.morse@arm.com, marcan@marcan.st,
        maz@kernel.org, tglx@linutronix.de
Subject: Re: [PATCHv3 6/6] arm64: irq: allow FIQs to be handled
Message-ID: <20210324170323.GE13030@willie-the-truck>
References: <20210315115629.57191-1-mark.rutland@arm.com>
 <20210315115629.57191-7-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315115629.57191-7-mark.rutland@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 11:56:29AM +0000, Mark Rutland wrote:
> On contemporary platforms we don't use FIQ, and treat any stray FIQ as a
> fatal event. However, some platforms have an interrupt controller wired
> to FIQ, and need to handle FIQ as part of regular operation.
> 
> So that we can support both cases dynamically, this patch updates the
> FIQ exception handling code to operate the same way as the IRQ handling
> code, with its own handle_arch_fiq handler. Where a root FIQ handler is
> not registered, an unexpected FIQ exception will trigger the default FIQ
> handler, which will panic() as today. Where a root FIQ handler is
> registered, handling of the FIQ is deferred to that handler.
> 
> As el0_fiq_invalid_compat is supplanted by el0_fiq, the former is
> removed. For !CONFIG_COMPAT builds we never expect to take an exception
> from AArch32 EL0, so we keep the common el0_fiq_invalid handler.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Tested-by: Hector Martin <marcan@marcan.st>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Will Deacon <will@kernel.org>
> ---
>  arch/arm64/include/asm/irq.h |  1 +
>  arch/arm64/kernel/entry.S    | 30 +++++++++++++++++++++---------
>  arch/arm64/kernel/irq.c      | 16 ++++++++++++++++
>  3 files changed, 38 insertions(+), 9 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
