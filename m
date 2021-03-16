Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41A6133DB54
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 18:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239330AbhCPRrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 13:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239205AbhCPRqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 13:46:38 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14170C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 10:46:38 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id a188so9329521pfb.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 10:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dPll0wFeLjqlXczZ31P6G+9fptwKfsKgzaV1xhhnBRY=;
        b=B56yM0IgF0UnhQqaf4wNMeA5sMpba0GQCkZ0SllZPgarPsVVq957A9sZZnRW/svHue
         lyL6jZdinT8ZVQbJx6+gurMzU6xD0Qx+ULo2eemP55vhsdEmT5NftcWLmddbFAtwv0sk
         9XLqHm8oqK9awGpMt2Cf0Crw+0xf/+cVfjTRpRyKWpPXEsL0VoFydclKT/IkC3MGTLjb
         XDswYUHbyRGPwA4hfxQcvXO16BDrmtipqJWdU2g9d6bwZIIm80gyTKiPuCzzW3pKV3+X
         UEwcphaubJ5ML/E/1fxYPy8lfWADkQlmhL2TOq4YNUWltPFOi9uN8USn7oQLDG4oWHr0
         0D/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dPll0wFeLjqlXczZ31P6G+9fptwKfsKgzaV1xhhnBRY=;
        b=Bqdb+aQYO23Ae461LVNOcxHSfnAo2CvvGt7cmL9e40rp9e7b84uSkKX6HIugiE4JUB
         JVWmET9tWlORMJgr0pkl4G1rKOUzy/5H0Jie1Hh+qzMZ2At79VBiwIULt719i+Aq3mUM
         Lry6c5K6wAznv0biXXHb99lXF9mg5uYHU1A4Cxx6XmXhxU4melZDSpRRG48IjOeG3eni
         g8goE/PsqxxuJ/MfswJvDmUDYdIIYoOrjjBh+/VmZO2fje5j3+7sbAwVzpLYNHyuI1QH
         d+OmEIYV+JZMIQAPFFNON6+JIYH6BeD3HZWL65QrguUpkx99ZTl6m7mCowVB9xlAfBgo
         7J1g==
X-Gm-Message-State: AOAM533BY1953YuH/MyPx2a6WYOH+IKScGHOXRZQWTvEZZD5lO8dwF/b
        68PFZpxiqAt+ZetXTOITvpSeNA==
X-Google-Smtp-Source: ABdhPJxx8ABeuG5fMIZs4Co38AliHL5Yh8LOADOFJnU2pLecUuUA1r0pMfq46f+VWWBP7MuJUEP/6A==
X-Received: by 2002:a63:4502:: with SMTP id s2mr780865pga.94.1615916797429;
        Tue, 16 Mar 2021 10:46:37 -0700 (PDT)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id z8sm89153pjd.0.2021.03.16.10.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 10:46:37 -0700 (PDT)
Date:   Tue, 16 Mar 2021 11:46:35 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mike.leach@linaro.org, anshuman.khandual@arm.com,
        leo.yan@linaro.org, Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v4 07/19] arm64: Add TRBE definitions
Message-ID: <20210316174635.GB1387186@xps15>
References: <20210225193543.2920532-1-suzuki.poulose@arm.com>
 <20210225193543.2920532-8-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225193543.2920532-8-suzuki.poulose@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 07:35:31PM +0000, Suzuki K Poulose wrote:
> From: Anshuman Khandual <anshuman.khandual@arm.com>
> 
> This adds TRBE related registers and corresponding feature macros.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Reviewed-by: Mike Leach <mike.leach@linaro.org>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  arch/arm64/include/asm/sysreg.h | 50 +++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> 
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index dfd4edbfe360..6470d783ea59 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -333,6 +333,55 @@
>  
>  /*** End of Statistical Profiling Extension ***/
>  
> +/*
> + * TRBE Registers
> + */
> +#define SYS_TRBLIMITR_EL1		sys_reg(3, 0, 9, 11, 0)
> +#define SYS_TRBPTR_EL1			sys_reg(3, 0, 9, 11, 1)
> +#define SYS_TRBBASER_EL1		sys_reg(3, 0, 9, 11, 2)
> +#define SYS_TRBSR_EL1			sys_reg(3, 0, 9, 11, 3)
> +#define SYS_TRBMAR_EL1			sys_reg(3, 0, 9, 11, 4)
> +#define SYS_TRBTRG_EL1			sys_reg(3, 0, 9, 11, 6)
> +#define SYS_TRBIDR_EL1			sys_reg(3, 0, 9, 11, 7)
> +
> +#define TRBLIMITR_LIMIT_MASK		GENMASK_ULL(51, 0)
> +#define TRBLIMITR_LIMIT_SHIFT		12
> +#define TRBLIMITR_NVM			BIT(5)
> +#define TRBLIMITR_TRIG_MODE_MASK	GENMASK(1, 0)
> +#define TRBLIMITR_TRIG_MODE_SHIFT	3
> +#define TRBLIMITR_FILL_MODE_MASK	GENMASK(1, 0)
> +#define TRBLIMITR_FILL_MODE_SHIFT	1
> +#define TRBLIMITR_ENABLE		BIT(0)
> +#define TRBPTR_PTR_MASK			GENMASK_ULL(63, 0)
> +#define TRBPTR_PTR_SHIFT		0
> +#define TRBBASER_BASE_MASK		GENMASK_ULL(51, 0)
> +#define TRBBASER_BASE_SHIFT		12
> +#define TRBSR_EC_MASK			GENMASK(5, 0)
> +#define TRBSR_EC_SHIFT			26
> +#define TRBSR_IRQ			BIT(22)
> +#define TRBSR_TRG			BIT(21)
> +#define TRBSR_WRAP			BIT(20)
> +#define TRBSR_ABORT			BIT(18)
> +#define TRBSR_STOP			BIT(17)
> +#define TRBSR_MSS_MASK			GENMASK(15, 0)
> +#define TRBSR_MSS_SHIFT			0
> +#define TRBSR_BSC_MASK			GENMASK(5, 0)
> +#define TRBSR_BSC_SHIFT			0
> +#define TRBSR_FSC_MASK			GENMASK(5, 0)
> +#define TRBSR_FSC_SHIFT			0
> +#define TRBMAR_SHARE_MASK		GENMASK(1, 0)
> +#define TRBMAR_SHARE_SHIFT		8
> +#define TRBMAR_OUTER_MASK		GENMASK(3, 0)
> +#define TRBMAR_OUTER_SHIFT		4
> +#define TRBMAR_INNER_MASK		GENMASK(3, 0)
> +#define TRBMAR_INNER_SHIFT		0
> +#define TRBTRG_TRG_MASK			GENMASK(31, 0)
> +#define TRBTRG_TRG_SHIFT		0
> +#define TRBIDR_FLAG			BIT(5)
> +#define TRBIDR_PROG			BIT(4)
> +#define TRBIDR_ALIGN_MASK		GENMASK(3, 0)
> +#define TRBIDR_ALIGN_SHIFT		0
> +
>  #define SYS_PMINTENSET_EL1		sys_reg(3, 0, 9, 14, 1)
>  #define SYS_PMINTENCLR_EL1		sys_reg(3, 0, 9, 14, 2)
>  
> @@ -835,6 +884,7 @@
>  #define ID_AA64MMFR2_CNP_SHIFT		0
>  
>  /* id_aa64dfr0 */
> +#define ID_AA64DFR0_TRBE_SHIFT		44
>  #define ID_AA64DFR0_TRACE_FILT_SHIFT	40
>  #define ID_AA64DFR0_DOUBLELOCK_SHIFT	36
>  #define ID_AA64DFR0_PMSVER_SHIFT	32
> -- 
> 2.24.1
> 
