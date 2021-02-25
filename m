Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 916973253F8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 17:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233960AbhBYQtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 11:49:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233797AbhBYQqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 11:46:08 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFE4C061756
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 08:45:25 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id s16so3488728plr.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 08:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/A3h88rm/bzKYDHwXmy10vJWFNAxrqRS/0m9On458gU=;
        b=aHUCEcGrUmuALlrW5N3AgOikup5aJsj9aZOTqbPycD+CdsOEPxmh6Kya2z0mJR5t8/
         lIJa3GIp1QbkwFVHScQtErzxj9Q3OwZz6KcqjdCxfx4FGYDTD5U5YQaj0stiScxx0dNo
         V4sOdMMsmR6jJSrlUg3yLxssONi72uJgDT/2DsQihzM+2zpxCnpanor4Uiuu6+pYrQrR
         WpGICJobY8TfGWmMDR+uWe4EmxNwIYFRrV31pCkDS0dG8DReqJaGPVkzexm4ugMGuC9Y
         sLMcTtx0XCnTVybmPr2KuhMl/sCQKQB7wKYlzwNAQ0eZVq9K28lzNCVSd1/eexHwnXHA
         zo4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/A3h88rm/bzKYDHwXmy10vJWFNAxrqRS/0m9On458gU=;
        b=ozYr1E8OYHtKyMSE6Af8oVUfU0dY5ArMHKdkJVK10OTxKQEhNpGlBnWw+gn9LVgXXP
         TQV73Io2Q2Upd8GSFqDvksHi1NHCjciRks1E8aEgyjxVbYouk29OEiPXyn5t9Ru2+4k7
         woBopH7ma2Bu2wEleDkXiSZvaAAjLYrZ8vM3YLkEErdr7FDPwZfcLkEgTdKfrYauGzWk
         QfyVIy9a2T98czz0s3/kI/IDrIabkZuxofGeTmw1EPr/8SujWLNcwFbVAzHpSztyKKMb
         y2sgsHCDWfDN2tCRU4HnqPs1hfoAh1VvnyvGzc3N0EAhvBhj32IDzuz4kigbiAT2CTE8
         sEqg==
X-Gm-Message-State: AOAM533Wk5s0zN6rutuBwznrahUPKXR1AxN3FR5NUMBBo2NAWCANlzB6
        nTbVTHvTBHQ1gPW9M0+u8wXP2A==
X-Google-Smtp-Source: ABdhPJzRSR4qjMRKOm8I7sIosVeGkGxfVF6vpPPpkiH9mbZ5oQ6Ew5AaJnhilG6ZMClo0nDq3Dmztw==
X-Received: by 2002:a17:902:6949:b029:e3:1ee9:6bfd with SMTP id k9-20020a1709026949b02900e31ee96bfdmr3897370plt.66.1614271524938;
        Thu, 25 Feb 2021 08:45:24 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id s10sm6530952pgl.90.2021.02.25.08.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 08:45:24 -0800 (PST)
Date:   Thu, 25 Feb 2021 09:45:22 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] coresight: etm4x: work around clang-12+ build failure
Message-ID: <20210225164522.GA3554437@xps15>
References: <20210225094324.3542511-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225094324.3542511-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning,

On Thu, Feb 25, 2021 at 10:42:58AM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> clang-12 fails to build the etm4x driver with -fsanitize=array-bounds:
> 
> <instantiation>:1:7: error: expected constant expression in '.inst' directive
> .inst (0xd5200000|((((2) << 19) | ((1) << 16) | (((((((((((0x160 + (i * 4))))) >> 2))) >> 7) & 0x7)) << 12) | ((((((((((0x160 + (i * 4))))) >> 2))) & 0xf)) << 8) | (((((((((((0x160 + (i * 4))))) >> 2))) >> 4) & 0x7)) << 5)))|(.L__reg_num_x8))
>       ^
> drivers/hwtracing/coresight/coresight-etm4x-core.c:702:4: note: while in macro instantiation
>                         etm4x_relaxed_read32(csa, TRCCNTVRn(i));
>                         ^
> drivers/hwtracing/coresight/coresight-etm4x.h:403:4: note: expanded from macro 'etm4x_relaxed_read32'
>                  read_etm4x_sysreg_offset((offset), false)))
>                  ^
> drivers/hwtracing/coresight/coresight-etm4x.h:383:12: note: expanded from macro 'read_etm4x_sysreg_offset'
>                         __val = read_etm4x_sysreg_const_offset((offset));       \
>                                 ^
> drivers/hwtracing/coresight/coresight-etm4x.h:149:2: note: expanded from macro 'read_etm4x_sysreg_const_offset'
>         READ_ETM4x_REG(ETM4x_OFFSET_TO_REG(offset))
>         ^
> drivers/hwtracing/coresight/coresight-etm4x.h:144:2: note: expanded from macro 'READ_ETM4x_REG'
>         read_sysreg_s(ETM4x_REG_NUM_TO_SYSREG((reg)))
>         ^
> arch/arm64/include/asm/sysreg.h:1108:15: note: expanded from macro 'read_sysreg_s'
>         asm volatile(__mrs_s("%0", r) : "=r" (__val));                  \
>                      ^
> arch/arm64/include/asm/sysreg.h:1074:2: note: expanded from macro '__mrs_s'
> "       mrs_s " v ", " __stringify(r) "\n"                      \
>  ^
> 
> It appears that the __builin_constant_p() check in
> read_etm4x_sysreg_offset() falsely returns 'true' here because clang
> decides finds that an out-of-bounds access to config->cntr_val[] cannot
> happen, and then it unrolls the loop with constant register numbers. Then
> when actually emitting the output, it fails to figure out the value again.
> 
> While this is incorrect behavior in clang, it is easy to work around
> by avoiding the out-of-bounds array access. Do this by limiting the
> loop counter to the actual dimension of the array.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/1310
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/hwtracing/coresight/coresight-etm4x-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 15016f757828..4cccf874a602 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -691,13 +691,13 @@ static void etm4_disable_hw(void *info)
>  			"timeout while waiting for PM stable Trace Status\n");
>  
>  	/* read the status of the single shot comparators */
> -	for (i = 0; i < drvdata->nr_ss_cmp; i++) {
> +	for (i = 0; i < min_t(u32, drvdata->nr_ss_cmp, ETM_MAX_SS_CMP); i++) {
>  		config->ss_status[i] =
>  			etm4x_relaxed_read32(csa, TRCSSCSRn(i));
>  	}
>  
>  	/* read back the current counter values */
> -	for (i = 0; i < drvdata->nr_cntr; i++) {
> +	for (i = 0; i < min_t(u32, drvdata->nr_cntr, ETMv4_MAX_CNTR); i++) {

This patch will work and I'd be happy to apply it if this was the only instance,
but there are dozens of places in the coresight drivers where such patterns are
used.  Why are those not flagged as well?  And shouldn't the real fix be with
clang?

Thanks,
Mathieu 

>  		config->cntr_val[i] =
>  			etm4x_relaxed_read32(csa, TRCCNTVRn(i));
>  	}
> -- 
> 2.29.2
> 
