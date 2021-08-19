Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B81B3F160D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 11:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234517AbhHSJUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 05:20:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:58856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230202AbhHSJUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 05:20:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4BCD8610FE;
        Thu, 19 Aug 2021 09:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629364768;
        bh=J3jp7ZOkmWaO9tQLpZ1zOGBcgY8a5WTZo9zNRh3HUAY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XvDObTH1MOu+er8ygQ8tnVIPybva2pjBx62TiiFqpRZawleBeoaabGzphlQV2XsW2
         9/xB5KBQg7OmeqW1nAvJ9mGrTkdCSYw7/rl3wdisllQdqKYIs7wsxBuv027Rm/itMr
         /+I27VJYxY0h5GUzb6rZ9WbZsqBCpFxmE8TQvgkjhv+3QmtGo9ukC2YWUfUnwdwcVN
         IapLyOnD8Uvf07weYeBwDtjxMkbUq18oBYNK6TUAKRPz+rezCcU6MzyZDM03WkGdQ6
         /s1/+tK/QTFEq4MapPLC6diOyaVXvmjC0Kd5OlT3QW2OPkXwUrz7YjiVq3A/a2xqvF
         jLZ2XG3l97IzQ==
Date:   Thu, 19 Aug 2021 10:19:23 +0100
From:   Will Deacon <will@kernel.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hillf Danton <hdanton@sina.com>, page-reclaim@google.com
Subject: Re: [PATCH v4 01/11] mm: x86, arm64: add arch_has_hw_pte_young()
Message-ID: <20210819091923.GA15467@willie-the-truck>
References: <20210818063107.2696454-1-yuzhao@google.com>
 <20210818063107.2696454-2-yuzhao@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210818063107.2696454-2-yuzhao@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2021 at 12:30:57AM -0600, Yu Zhao wrote:
> Some architectures set the accessed bit in PTEs automatically, e.g.,
> x86, and arm64 v8.2 and later. On architectures that do not have this
> capability, clearing the accessed bit in a PTE triggers a page fault
> following the TLB miss.
> 
> Being aware of this capability can help make better decisions, i.e.,
> whether to limit the size of each batch of PTEs and the burst of
> batches when clearing the accessed bit.
> 
> Signed-off-by: Yu Zhao <yuzhao@google.com>
> ---
>  arch/arm64/include/asm/cpufeature.h | 19 ++++++-------------
>  arch/arm64/include/asm/pgtable.h    | 10 ++++------
>  arch/arm64/kernel/cpufeature.c      | 19 +++++++++++++++++++
>  arch/arm64/mm/proc.S                | 12 ------------
>  arch/arm64/tools/cpucaps            |  1 +
>  arch/x86/include/asm/pgtable.h      |  6 +++---
>  include/linux/pgtable.h             | 12 ++++++++++++
>  mm/memory.c                         | 14 +-------------
>  8 files changed, 46 insertions(+), 47 deletions(-)

Please cc linux-arm-kernel and the maintainers on arm64 patches.

> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index 9bb9d11750d7..2020b9e818c8 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -776,6 +776,12 @@ static inline bool system_supports_tlb_range(void)
>  		cpus_have_const_cap(ARM64_HAS_TLB_RANGE);
>  }
>  
> +/* Check whether hardware update of the Access flag is supported. */
> +static inline bool system_has_hw_af(void)
> +{
> +	return IS_ENABLED(CONFIG_ARM64_HW_AFDBM) && cpus_have_const_cap(ARM64_HW_AF);
> +}

How accurate does this need to be? Heterogeneous (big/little) systems are
very common on arm64, so the existing code enables hardware access flag
unconditionally on CPUs that support it, meaning we could end up running
on a system where some CPUs have hardware update and others do not.

With your change, we only enable hardware access flag if _all_ CPUs support
it (and furthermore, we prevent late onlining of CPUs without the feature
if was detected at boot). This sacrifices a lot of flexibility, particularly
if we end up tackling CPU errata in this area in future, and it's not clear
that it's really required for what you're trying to do.

Will
