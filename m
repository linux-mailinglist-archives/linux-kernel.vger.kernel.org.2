Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5601044D3AC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 10:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbhKKJCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 04:02:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:38192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232203AbhKKJCB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 04:02:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8787B61208;
        Thu, 11 Nov 2021 08:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636621153;
        bh=V/voYJdoZA1WY8AEKTOUrS/Vy3/qzbpOQsGhfSmMFw8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RDS3QmtEOrEJN86RtpjiUC0g3VTKJEznJ7GYHgWifBXd/43aiFvHghj+ZWzGVzR2k
         TIuFyfA+BOFkSbQcz6vfsnYkBtyDP/wEbl5ODtcAib3g/WqHphiMYGNqBFcy98j3jh
         upKkRms3N7wwml5TencLSL0R/0AiQeDPz9/hPNQPp3L2eRmnl2CinLtG2lUzV39WuY
         TkkcKZYza+f7g+sDZyEcbgqIGc+tUMLZ2KZaq5j4FKlT59z+paZLRdOgI1xl6tqN4h
         +95phXRgsnqqOegHYylKgiublk3jCaXmTmm9b+bo2G4V75SiDf4uKyqPtd1vWXkhVc
         E1eGCsxbbz4yA==
Date:   Thu, 11 Nov 2021 08:59:08 +0000
From:   Will Deacon <will@kernel.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        page-reclaim@google.com, holger@applied-asynchrony.com,
        iam@valdikss.org.ru, Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        catalin.marinas@arm.com
Subject: Re: [PATCH v5 01/10] mm: x86, arm64: add arch_has_hw_pte_young()
Message-ID: <20211111085907.GA5407@willie-the-truck>
References: <20211111041510.402534-1-yuzhao@google.com>
 <20211111041510.402534-2-yuzhao@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211111041510.402534-2-yuzhao@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 09:15:01PM -0700, Yu Zhao wrote:
> Some architectures automatically set the accessed bit in PTEs, e.g.,
> x86 and arm64 v8.2. On architectures that do not have this capability,
> clearing the accessed bit in a PTE triggers a page fault following the
> TLB miss of this PTE.
> 
> Being aware of this capability can help make better decisions, i.e.,
> whether to limit the size of each batch of PTEs and the burst of
> batches when clearing the accessed bit.
> 
> Signed-off-by: Yu Zhao <yuzhao@google.com>
> Tested-by: Konstantin Kharlamov <Hi-Angel@yandex.ru>
> ---
>  arch/arm64/include/asm/cpufeature.h |  5 +++++
>  arch/arm64/include/asm/pgtable.h    | 13 ++++++++-----
>  arch/arm64/kernel/cpufeature.c      | 10 ++++++++++
>  arch/arm64/tools/cpucaps            |  1 +
>  arch/x86/include/asm/pgtable.h      |  6 +++---
>  include/linux/pgtable.h             | 13 +++++++++++++
>  mm/memory.c                         | 14 +-------------
>  7 files changed, 41 insertions(+), 21 deletions(-)

*Please* cc the maintainers on arch patches. I asked you that last time,
too:

https://lore.kernel.org/r/20210819091923.GA15467@willie-the-truck

> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 6ec7036ef7e1..940615d33845 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -2157,6 +2157,16 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>  		.matches = has_hw_dbm,
>  		.cpu_enable = cpu_enable_hw_dbm,
>  	},
> +	{
> +		.desc = "Hardware update of the Access flag",
> +		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
> +		.capability = ARM64_HW_AF,
> +		.sys_reg = SYS_ID_AA64MMFR1_EL1,
> +		.sign = FTR_UNSIGNED,
> +		.field_pos = ID_AA64MMFR1_HADBS_SHIFT,
> +		.min_field_value = 1,
> +		.matches = has_cpuid_feature,
> +	},

As before, please don't make this a system feature as it will prohibit
onlining of late CPUs with mismatched access flag support and I really
don't see that being necessary.

You should just be able to use arch_faults_on_old_pte() as-is.

Will
