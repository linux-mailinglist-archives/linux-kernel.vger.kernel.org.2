Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF21F3CF8B3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 13:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237008AbhGTKgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 06:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236458AbhGTKfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 06:35:46 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6DB7C061574
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 04:16:22 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id f9so25558399wrq.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 04:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lpz51H3kvzr0DXJiE5RSxJNphxVtTP/JsLlCDtT69nE=;
        b=qIC8S+W4YEqX+/j1F2FfOOKMPB60fsBSS7jpd0cT0fUpSNivYVwV9Lc7AMV3WoXmMw
         v9CgSh/vI2qWbAPurBZw5TN+KhWhe340MqIv4ApDr2YkuHg+Csl3bWm9i8QeClaaikDF
         uMaiwpDXgtAjXyOpfnmR2iYIblGFLYIY3j+yTDSwccOVQiIL8S3kXlqDClfWK41H+kgw
         kmra3575DBZwkejSgK4e4RWzFoz1f0sOdv7uO07ytjh1dww1naA5hdZhhZFRFHVDi3Yj
         hQdxBPLQFqiPS5CCQ0OE+yh0ewTntdOyy+voxTzTeMDdMan7IlXYk0lQLYB1dMXeHg6A
         /60Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lpz51H3kvzr0DXJiE5RSxJNphxVtTP/JsLlCDtT69nE=;
        b=oZqb2sxSvuR8FrqE14NfF/DkeZS+HZl0MC8+3iIki8csJGgPLWIx4+qOhH1s2eQIBj
         rhQcbYrC/VOVDXFjXuHAIQ8jLMDQP0eLEbNLgW/MGPT18Tr7Kx+NESd3/p0I6/kHIpLP
         FvGGQcarEZ7vdIsNPqzjwBhoFjq03HrDmmwK/pMYpEx84k3nMZmW3KKzy0MdbNDjc77F
         c3AfpbEkmO+2XZMFJwcEZwdCPFNqNT3+5Z1PzE1L7OVjz78p/I1ncJ5RimVH/h8mvpl7
         T5u6rRRnkyoFWNLL8UTia+nioPsHn4eR90/Ls1uKif41j4FfBtLBXfJ1X29lSIeyyz3e
         llLQ==
X-Gm-Message-State: AOAM530uUir++jcgsH1ZM11nRlPMZY0j+7AqBWH8e3jvo8L8poBAHj4+
        QmOEBnWSWY0l2mzVBn8r92Bpig==
X-Google-Smtp-Source: ABdhPJzyDbPtX+5Q7MPnRmTCUDtOQw0hbyz28e4E5BQ9dsfjysvHdxUpebOfYRKz9mVC05s+yeb7VQ==
X-Received: by 2002:a05:6000:102:: with SMTP id o2mr35120793wrx.299.1626779781184;
        Tue, 20 Jul 2021 04:16:21 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:83e0:11ac:c870:2b97])
        by smtp.gmail.com with ESMTPSA id a8sm23462978wrt.61.2021.07.20.04.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 04:16:20 -0700 (PDT)
Date:   Tue, 20 Jul 2021 12:16:17 +0100
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
Subject: Re: [PATCH 15/16] arm64: Add a helper to retrieve the PTE of a fixmap
Message-ID: <YPawgYJYfD+EfXBW@google.com>
References: <20210715163159.1480168-1-maz@kernel.org>
 <20210715163159.1480168-16-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715163159.1480168-16-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 15 Jul 2021 at 17:31:58 (+0100), Marc Zyngier wrote:
> In order to transfer the early mapping state into KVM's MMIO
> guard infrastucture, provide a small helper that will retrieve
> the associated PTE.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/include/asm/fixmap.h |  2 ++
>  arch/arm64/mm/mmu.c             | 15 +++++++++++++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/fixmap.h b/arch/arm64/include/asm/fixmap.h
> index 4335800201c9..1aae625b944f 100644
> --- a/arch/arm64/include/asm/fixmap.h
> +++ b/arch/arm64/include/asm/fixmap.h
> @@ -105,6 +105,8 @@ void __init early_fixmap_init(void);
>  
>  extern void __set_fixmap(enum fixed_addresses idx, phys_addr_t phys, pgprot_t prot);
>  
> +extern pte_t *__get_fixmap_pte(enum fixed_addresses idx);
> +
>  #include <asm-generic/fixmap.h>
>  
>  #endif /* !__ASSEMBLY__ */
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index d74586508448..f1b7abd04025 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -1286,6 +1286,21 @@ void __set_fixmap(enum fixed_addresses idx,
>  	}
>  }
>  
> +pte_t *__get_fixmap_pte(enum fixed_addresses idx)
> +{
> +	unsigned long 	addr = __fix_to_virt(idx);

Nit: odd spacing here.

> +	pte_t *ptep;
> +
> +	BUG_ON(idx <= FIX_HOLE || idx >= __end_of_fixed_addresses);
> +
> +	ptep = fixmap_pte(addr);
> +
> +	if (!pte_valid(*ptep))
> +		return NULL;
> +
> +	return ptep;
> +}
> +
>  void *__init fixmap_remap_fdt(phys_addr_t dt_phys, int *size, pgprot_t prot)
>  {
>  	const u64 dt_virt_base = __fix_to_virt(FIX_FDT);
> -- 
> 2.30.2
> 
