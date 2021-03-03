Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77E0F32C36D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354160AbhCDAGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 19:06:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:43812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1581295AbhCCVON (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 16:14:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D1E2E64EC4;
        Wed,  3 Mar 2021 21:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614806011;
        bh=La069RJVv7lSY65LoO9v4vrFVi06mMCWoGSs5E3bs80=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ChLlPyKWb/dzGDPuABC1x/e5vhIYdLeTFGQHCU75XumX71T2cxBhQEizAyGm5ILbm
         OnH9//VdNR4ieq71aPR0gWq9xb0G3ZBbVggXbZofYmjYpoMNmOI8IJ0ntQr2dYgLBZ
         +lIIDL2g/ErngnPuC2K9axtXikrtjiaf3WOov/Z7CVUxWeX/eWOjS9BbUlqA+akLsq
         ZkaUQGyFfOM7Ci7sFgOLIflfcwAi3BH2ksW5Ll34EfE9d3INdakvVlGPjIisiXUFWJ
         PdoSNU3rotHuwS+YPkG/wSdwQZRsQ1/ETLAau5/hmNkPeKL/DX/8DYdr8o9e3W/ub+
         KsUcvRP1waJdg==
Date:   Wed, 3 Mar 2021 21:13:26 +0000
From:   Will Deacon <will@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Jia He <justin.he@arm.com>, kvmarm@lists.cs.columbia.edu,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Gavin Shan <gshan@redhat.com>,
        Yanan Wang <wangyanan55@huawei.com>,
        Quentin Perret <qperret@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: Fix unaligned addr case in mmu walking
Message-ID: <20210303211325.GA20055@willie-the-truck>
References: <20210303024225.2591-1-justin.he@arm.com>
 <20210303112934.GA18452@willie-the-truck>
 <87mtvkys1y.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mtvkys1y.wl-maz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021 at 07:07:37PM +0000, Marc Zyngier wrote:
> From e0524b41a71e0f17d6dc8f197e421e677d584e72 Mon Sep 17 00:00:00 2001
> From: Jia He <justin.he@arm.com>
> Date: Wed, 3 Mar 2021 10:42:25 +0800
> Subject: [PATCH] KVM: arm64: Fix range alignment when walking page tables
> 
> When walking the page tables at a given level, and if the start
> address for the range isn't aligned for that level, we propagate
> the misalignment on each iteration at that level.
> 
> This results in the walker ignoring a number of entries (depending
> on the original misalignment) on each subsequent iteration.
> 
> Properly aligning the address at the before the next iteration

"at the before the next" ???

> addresses the issue.
> 
> Cc: stable@vger.kernel.org
> Reported-by: Howard Zhang <Howard.Zhang@arm.com>
> Signed-off-by: Jia He <justin.he@arm.com>
> Fixes: b1e57de62cfb ("KVM: arm64: Add stand-alone page-table walker infrastructure")
> [maz: rewrite commit message]
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Link: https://lore.kernel.org/r/20210303024225.2591-1-justin.he@arm.com
> ---
>  arch/arm64/kvm/hyp/pgtable.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
> index 4d177ce1d536..124cd2f93020 100644
> --- a/arch/arm64/kvm/hyp/pgtable.c
> +++ b/arch/arm64/kvm/hyp/pgtable.c
> @@ -223,7 +223,7 @@ static inline int __kvm_pgtable_visit(struct kvm_pgtable_walk_data *data,
>  		goto out;
>  
>  	if (!table) {
> -		data->addr += kvm_granule_size(level);
> +		data->addr = ALIGN(data->addr, kvm_granule_size(level));
>  		goto out;
>  	}

If Jia is happy with it, please feel free to add:

Acked-by: Will Deacon <will@kernel.org>

Will
