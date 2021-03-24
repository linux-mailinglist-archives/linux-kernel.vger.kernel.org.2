Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D79BF347E51
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 17:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236669AbhCXQ4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 12:56:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:44608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236954AbhCXQ4f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 12:56:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5FB98619D5;
        Wed, 24 Mar 2021 16:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616604994;
        bh=IjT8ks42t54B0PsxkI6Yx9Mt8/2cYsxEH6Mf39wNzuQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=psAd6bkZ609VOTv9dfgf5ceanQAZR12Lf2SizqoLgRO8CKQ3Hn+8Od0UxXLvDmVlb
         g3Z+lOwsxu21osfem/fZkaZ85xgMnrxZtegMcsIyWJ0ywTiiw9ZCLNtVNR7EpBKtP2
         GngEfaClfOSa6H0ilQJ5POAvGhdxNV66vIWywPC1gOq5ObJTD8zWf9uTjH1KVVidKH
         KBBmMp8BM4wvOBZVkwA4qJk6BrgWsCegNT0QS55NmgDBSENPEvWTqaQpvMjfNAqoe7
         RpW3A0F1XG6nt5GoBZoKTwVsIjQ4LhiJqLv5wQpfEk0Hn7zfXVAa600sXuZMGL2HVb
         1DzF+YS6awdjw==
Date:   Wed, 24 Mar 2021 16:56:30 +0000
From:   Will Deacon <will@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, james.morse@arm.com, marcan@marcan.st,
        maz@kernel.org, tglx@linutronix.de
Subject: Re: [PATCHv3 4/6] arm64: entry: factor irq triage logic into macros
Message-ID: <20210324165629.GC13030@willie-the-truck>
References: <20210315115629.57191-1-mark.rutland@arm.com>
 <20210315115629.57191-5-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315115629.57191-5-mark.rutland@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 11:56:27AM +0000, Mark Rutland wrote:
> From: Marc Zyngier <maz@kernel.org>
> 
> In subsequent patches we'll allow an FIQ handler to be registered, and
> FIQ exceptions will need to be triaged very similarly to IRQ exceptions.
> So that we can reuse the existing logic, this patch factors the IRQ
> triage logic out into macros that can be reused for FIQ.
> 
> The macros are named to follow the elX_foo_handler scheme used by the C
> exception handlers. For consistency with other top-level exception
> handlers, the kernel_entry/kernel_exit logic is not moved into the
> macros. As FIQ will use a different C handler, this handler name is
> provided as an argument to the macros.
> 
> There should be no functional change as a result of this patch.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> [Mark: rework macros, commit message, rebase before DAIF rework]
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Tested-by: Hector Martin <marcan@marcan.st>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Will Deacon <will@kernel.org>
> ---
>  arch/arm64/kernel/entry.S | 80 +++++++++++++++++++++++++----------------------
>  1 file changed, 43 insertions(+), 37 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
