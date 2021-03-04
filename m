Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D158E32DA96
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 20:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234905AbhCDTup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 14:50:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:47124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233074AbhCDTuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 14:50:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D1A1864EAE;
        Thu,  4 Mar 2021 19:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614887399;
        bh=rbJBnbip++59oMvemPv0UgOnN48fZ3mavVDtdREo3QA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZWQ7DETmHFsQA6lwmTnfoOa+Q9Irkf5q2C4UmWvL/JHQ1qcalcbNorvEw35hz+pFK
         8xBYECCDmudPwtzgrAmwgJM01RAx6E/LJrB2j63eeVfozezpMjmEejrdIhwI+mz06e
         qsFZL2Nj05tgwwnuoSr4OPQ5L/9dAWEu0qqofN63+Cm+yortNfPgFTx8VFc22FRZ7m
         KCHjHuhj3rMY3nnoJHdPABwMUgycCUR8/7oHbr9fLK7JwX5Ha5qPzrWEtyNZvLnj03
         tBTrUyvzjKvOqBWZzxTVyBfXPVc9km+IZFr70JkBQs5FvYSeXGeKq5Cwf/5Ar3MXBa
         fZNKsLB56KILg==
Date:   Thu, 4 Mar 2021 19:49:53 +0000
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     catalin.marinas@arm.com, maz@kernel.org, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, robh+dt@kernel.org
Subject: Re: [PATCH v3 24/32] KVM: arm64: Reserve memory for host stage 2
Message-ID: <20210304194953.GD21950@willie-the-truck>
References: <20210302150002.3685113-1-qperret@google.com>
 <20210302150002.3685113-25-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302150002.3685113-25-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2021 at 02:59:54PM +0000, Quentin Perret wrote:
> Extend the memory pool allocated for the hypervisor to include enough
> pages to map all of memory at page granularity for the host stage 2.
> While at it, also reserve some memory for device mappings.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/kvm/hyp/include/nvhe/mm.h | 23 ++++++++++++++++++++++-
>  arch/arm64/kvm/hyp/nvhe/setup.c      | 12 ++++++++++++
>  arch/arm64/kvm/hyp/reserved_mem.c    |  2 ++
>  3 files changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kvm/hyp/include/nvhe/mm.h b/arch/arm64/kvm/hyp/include/nvhe/mm.h
> index ac0f7fcffd08..411a35db949c 100644
> --- a/arch/arm64/kvm/hyp/include/nvhe/mm.h
> +++ b/arch/arm64/kvm/hyp/include/nvhe/mm.h
> @@ -53,7 +53,7 @@ static inline unsigned long __hyp_pgtable_max_pages(unsigned long nr_pages)
>  	return total;
>  }
>  
> -static inline unsigned long hyp_s1_pgtable_pages(void)
> +static inline unsigned long __hyp_pgtable_total_pages(void)
>  {
>  	unsigned long res = 0, i;
>  
> @@ -63,9 +63,30 @@ static inline unsigned long hyp_s1_pgtable_pages(void)
>  		res += __hyp_pgtable_max_pages(reg->size >> PAGE_SHIFT);
>  	}
>  
> +	return res;
> +}
> +
> +static inline unsigned long hyp_s1_pgtable_pages(void)
> +{
> +	unsigned long res;
> +
> +	res = __hyp_pgtable_total_pages();
> +
>  	/* Allow 1 GiB for private mappings */
>  	res += __hyp_pgtable_max_pages(SZ_1G >> PAGE_SHIFT);
>  
>  	return res;
>  }
> +
> +static inline unsigned long host_s2_mem_pgtable_pages(void)
> +{
> +	return __hyp_pgtable_total_pages() + 16;

Is this 16 due to the possibility of a concatenated pgd? If so, please add
a comment to that effect.

With that:

Acked-by: Will Deacon <will@kernel.org>

Will
