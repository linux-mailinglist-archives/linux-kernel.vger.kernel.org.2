Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2840B44578A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 17:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbhKDQxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 12:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbhKDQxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 12:53:14 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45B2C061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 09:50:36 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id p17so5942789pgj.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 09:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=M0azN/cEKtvFWgkC6HeTc7byICS4Dm3BxYG0AeNA3pM=;
        b=kjcteU6hV/hrbM/SLYf2gUKdOASzr7J2f+CRd9keT5B71ArwF4j1jNLZ1qO9/vsPIR
         77Xv/kef+n3UPxLUnANSF6VGZTnK/NvHEzovVksRcLKhkbqcbvbeyMj/FZbyS1fly/NX
         bha5Ablsj06NrWnX68HTswkBY578SEMThy1jlVOhPQ22KhqZxFmy0/GFAEP6fERn7MwP
         Z/dH9NJTq8hVdaLg5XOZfIv+C+x5RsJog1k1yhrGm1wCzjlHCh7S+V7Chod7QHFfVJkq
         PgPx35Uio+TiI2MzeN8fwvwrDs7k/PpyNh/OaZ4LQ0eIs09Kh2+urK66ZNUUr2ub+j4r
         UCDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M0azN/cEKtvFWgkC6HeTc7byICS4Dm3BxYG0AeNA3pM=;
        b=2UsvbHIV14huyCFCkFmVFmk52BdxcLWTSxDvDbp83BdAKD2AkeZ+W9Df7cJL9C3oBg
         chtnVzEuq9kr/0ABKSjZB72tOfm9O/V1uXO8agN311963+QXUVZzfVrl5S987Psrs/i8
         qcVqyW8CP+h3y0uy98wRqx73hgShRhK92lo1RDi+3RbHWM9GrSRoibJlIjaiDxGLh1WP
         T1PIgXSNeP6A3j3SC0LzwYJ4KMTIABAx3mFrOgJNRB/qKbe2rcAWSFQI6FryE6x/IJ/D
         s2jUJpUHcogFiN8TGEwPvwl/TuOOqF2GLTQs1zzgqGZHGddpa0tgBoUTyOm+Z542z5Dy
         ESXA==
X-Gm-Message-State: AOAM530DXkF3Ula6R+vWqbl31hab4dddErQUAnk2aeA0/pRHz/4Ehm8I
        ITThJh6vrywJ3zN9c87dh5OOng==
X-Google-Smtp-Source: ABdhPJzpRds01jTpuFR7X2mKXs7ZVtj/lek8KdktJBQD5lTyaNrfYVENb1WYa86f+Djm6fji0P9cYA==
X-Received: by 2002:a63:a319:: with SMTP id s25mr40084622pge.305.1636044636197;
        Thu, 04 Nov 2021 09:50:36 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id j62sm4208606pgc.62.2021.11.04.09.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 09:50:34 -0700 (PDT)
Date:   Thu, 4 Nov 2021 10:50:32 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     will@kernel.org, arnd@kernel.org, catalin.marinas@arm.com,
        gregkh@linuxfoundation.org, anshuman.khandual@arm.com,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] arm64: cpufeature: Export this_cpu_has_cap helper
Message-ID: <20211104165032.GA491267@p14s>
References: <20211103221256.725080-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211103221256.725080-1-suzuki.poulose@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2021 at 10:12:56PM +0000, Suzuki K Poulose wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Export the this_cpu_has_cap() for use by modules. This is
> used by TRBE driver. Without this patch, TRBE will fail
> to build as a module :
> 
> ERROR: modpost: "this_cpu_has_cap" [drivers/hwtracing/coresight/coresight-trbe.ko] undefined!
> 
> Fixes: 8a1065127d95 ("coresight: trbe: Add infrastructure for Errata handling")
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> [ change to EXPORT_SYMBOL_GPL ]
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  arch/arm64/kernel/cpufeature.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index f8a3067d10c6..82e68c69bb99 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -2839,6 +2839,7 @@ bool this_cpu_has_cap(unsigned int n)
>  
>  	return false;
>  }
> +EXPORT_SYMBOL_GPL(this_cpu_has_cap);
>

I have applied this patch.

Thanks
Mathieu

>  /*
>   * This helper function is used in a narrow window when,
> -- 
> 2.25.4
> 
