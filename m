Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8973CED0B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 22:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382780AbhGSRmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 13:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357699AbhGSQwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 12:52:15 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B58C061787
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 09:58:34 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id m2so23004690wrq.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 10:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/Xmu5FPqUyjX/AwFlDabtmrvnaqYTVi+iQ6O/Qt9w3U=;
        b=GcCvN0tvN5Qo1sPuEvd5e8Kiu9SppusmgEE+8feDajKDgBnTsTuQobZHqBMkPe4+XY
         yDuvGw8+USSyAwlYdV40GobxMRoS7Pazgu1thJ3JvazliW/fsy13HMsBFQPYjLdIdFfy
         yFL2gx3s6YHADMMGEc+dX1e6tegPCpIYQXsCEPbjVpdY0UTwHVXQhxr19NtHh4hPTAZ1
         UWcn7ZRvOVjzdiESzn8l/UhXaBilVgTKvPTIbHN1YVHSYdgQK0MJXV2KjODEbabseXLi
         4exz6XdzSK+5EwLOoofh8rWI2oDPAHZjmXO5UHi3Ckw+K10jfY0Qpm8zbUq2xNHwZzt7
         WgxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/Xmu5FPqUyjX/AwFlDabtmrvnaqYTVi+iQ6O/Qt9w3U=;
        b=UgWXmTxAaOw8aYcEcVHRQaoDOiCo0yqE6URTz1hQwbK0CtAbWQqRrJuydYwuZNQy9R
         gMQwCtpksWULyhJv2ak1ma8p1laLNCZpBBgJ7erXwOkfB6VlfM8RB6Kry0gPqdDYmIm/
         N59itUZsH9VvEeVeGSmyE+uac752ISbBD1VGbfswoXgwC62FrrSTssAlMKZOO7QCfsyq
         iVapcZ6PAQS/nU//AcG+k6mhg/Fbo+y0oqBYCxdGwFF4Sj3PLfnw/RhWOoBqJNoVxCWP
         D+YlTN4L473PpfizspER4nMGVPmhsRrXis6myMXfF526hFu7ag/czLO9sFo8Q1DLcSYd
         8JRQ==
X-Gm-Message-State: AOAM532kAxC2ITrGLFBiHwlP+3hlaTqk0ajsEfMn4xOBzKVYpqey+OnU
        YSmReKXgesRIaue/sByD4pZN3Q==
X-Google-Smtp-Source: ABdhPJxB1LiYaftghh0ifR2L76/445eAkiioG51gjnaxWSKBrKU6oQPzKqFBlbAnW5eZ1f2hyOGEvA==
X-Received: by 2002:adf:9084:: with SMTP id i4mr31273012wri.23.1626715086799;
        Mon, 19 Jul 2021 10:18:06 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:83e0:11ac:c870:2b97])
        by smtp.gmail.com with ESMTPSA id r18sm21209280wrt.96.2021.07.19.10.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 10:18:06 -0700 (PDT)
Date:   Mon, 19 Jul 2021 18:18:02 +0100
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org, will@kernel.org,
        dbrazdil@google.com, Srivatsa Vaddagiri <vatsa@codeaurora.org>,
        Shanker R Donthineni <sdonthineni@nvidia.com>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        kernel-team@android.com
Subject: Re: [PATCH 02/16] KVM: arm64: Don't issue CMOs when the physical
 address is invalid
Message-ID: <YPWzykpDMOhT2yh8@google.com>
References: <20210715163159.1480168-1-maz@kernel.org>
 <20210715163159.1480168-3-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715163159.1480168-3-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 15 Jul 2021 at 17:31:45 (+0100), Marc Zyngier wrote:
> Make sure we don't issue CMOs when mapping something that
> is not a memory address in the S2 page tables.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/kvm/hyp/pgtable.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
> index 05321f4165e3..a5874ebd0354 100644
> --- a/arch/arm64/kvm/hyp/pgtable.c
> +++ b/arch/arm64/kvm/hyp/pgtable.c
> @@ -619,12 +619,16 @@ static int stage2_map_walker_try_leaf(u64 addr, u64 end, u32 level,
>  	}
>  
>  	/* Perform CMOs before installation of the guest stage-2 PTE */
> -	if (mm_ops->dcache_clean_inval_poc && stage2_pte_cacheable(pgt, new))
> -		mm_ops->dcache_clean_inval_poc(kvm_pte_follow(new, mm_ops),
> -						granule);
> -
> -	if (mm_ops->icache_inval_pou && stage2_pte_executable(new))
> -		mm_ops->icache_inval_pou(kvm_pte_follow(new, mm_ops), granule);
> +	if (kvm_phys_is_valid(phys)) {
> +		if (mm_ops->dcache_clean_inval_poc &&
> +		    stage2_pte_cacheable(pgt, new))
> +			mm_ops->dcache_clean_inval_poc(kvm_pte_follow(new,
> +								      mm_ops),
> +						       granule);
> +		if (mm_ops->icache_inval_pou && stage2_pte_executable(new))
> +			mm_ops->icache_inval_pou(kvm_pte_follow(new, mm_ops),
> +						 granule);
> +	}

Hrmpf so this makes me realize we have a problem here, not really caused
by your patch though.

Specifically, calling kvm_pgtable_stage2_set_owner() can lead to
overriding valid mappings with invalid mappings, which is effectively an
unmap operation. In this case we should issue CMOs when unmapping a
cacheable page to ensure it is clean to the PoC, like the
kvm_pgtable_stage2_unmap() does.

Note that you patch is already an improvement over the current state of
things, because calling stage2_pte_cacheable(pgt, new),
kvm_pte_follow(new, mm_ops) and friends is bogus when 'new' is invalid
...

Thanks,
Quentin
