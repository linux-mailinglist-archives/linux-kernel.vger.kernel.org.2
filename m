Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3F643235D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 17:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233394AbhJRP4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 11:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233353AbhJRP4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 11:56:53 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B341C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 08:54:42 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d5so2204746pfu.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 08:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=unERHW1HoExK7cE3TmrUrU9w+tueba1bnwjKQP/MrmM=;
        b=yYzXe/d8BJcusWfEuCzb/wTzoe8bRMuBmHCc/hEvoxuRS5W7IBsGzXbrIyntfL7P3G
         Y/7v/rmNZd3TvUTpFL7rn8Motk2PMWpoIDHSepO8js3As+c7twHLn0xvY6S8XryB1eed
         HRY1LjIcfqqeNgMNT2Ovm1Z72/P3s1MnrsgreVMaWF5W0X0Lf1oaT7sGBpkkSqX1OSEj
         5nHftpXMmALgJ7/NfqBRR6Xd6GfNcbWo89xeYqO6/iJPQ7kvIZ+ldEK+tCKJyPYND2Kg
         uCbhC6YPrhp8cX0nuNKjx/fAPoCv6Zqtv9x+9HnEIsmgKt8/SDufFLFdiQtEc5MPVAtd
         6n4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=unERHW1HoExK7cE3TmrUrU9w+tueba1bnwjKQP/MrmM=;
        b=b1p4gDzJUQzRIPaf0qoJEYaJ7bEsFiwEByNjNjioTme4MRR/AnlEGvx+gksxCzoBo8
         qmvArTmPc8SSI1nAESFCqqMLoJIKDR3v/sPRfQEBhtv8t+avGVpSfcRSVKnlR/t4jEYK
         e5ZLcm16PUjbypZSnm0CM5SWRFHUFczkFJkdXC4uSSLyu8/RVGsurekFsXEPcNg/N86/
         rjLNk2frqeDwrFIWgXLbaD0KgPhxGPSsNKpkvLW2NoqXRBMc6LU6GejrZX8mgGUT3sk5
         LHvDFp674k7JW+p/Ykxqk3+KbLToK6V8edPCkwcEmbp/+qSJ3RYnqFO+Vp29kkbTdbs/
         6iYA==
X-Gm-Message-State: AOAM533VoHoR9efXopNG8JRKB3UlkrQdhIFsNQYt3NyVN2jZi8aQzGMY
        WjTBxLIcvm5FwD61N+Ht8g8gVg==
X-Google-Smtp-Source: ABdhPJxD4G/6O1KRynFLKtR0kgEUSz0ry1ph8Sv3oApHvAD6j6GuWA0IV41013uYQpXE9KnwGJf5hg==
X-Received: by 2002:a05:6a00:16d2:b029:300:200b:6572 with SMTP id l18-20020a056a0016d2b0290300200b6572mr29338710pfc.62.1634572481766;
        Mon, 18 Oct 2021 08:54:41 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id e15sm13119820pfc.134.2021.10.18.08.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 08:54:40 -0700 (PDT)
Date:   Mon, 18 Oct 2021 09:54:38 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     will@kernel.org, catalin.marinas@arm.com,
        anshuman.khandual@arm.com, mike.leach@linaro.org,
        leo.yan@linaro.org, maz@kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 15/15] arm64: errata: Enable TRBE workaround for write
 to out-of-range address
Message-ID: <20211018155438.GD3163131@p14s>
References: <20211014223125.2605031-1-suzuki.poulose@arm.com>
 <20211014223125.2605031-16-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014223125.2605031-16-suzuki.poulose@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 11:31:25PM +0100, Suzuki K Poulose wrote:
> With the TRBE driver workaround available, enable the config symbols
> to be built without COMPILE_TEST
> 
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  arch/arm64/Kconfig | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index f72fa44d6182..d6383ef05871 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -743,7 +743,6 @@ config ARM64_WORKAROUND_TRBE_WRITE_OUT_OF_RANGE
>  
>  config ARM64_ERRATUM_2253138
>  	bool "Neoverse-N2: 2253138: workaround TRBE writing to address out-of-range"
> -	depends on COMPILE_TEST # Until the CoreSight TRBE driver changes are in
>  	depends on CORESIGHT_TRBE
>  	default y
>  	select ARM64_WORKAROUND_TRBE_WRITE_OUT_OF_RANGE
> @@ -762,7 +761,6 @@ config ARM64_ERRATUM_2253138
>  
>  config ARM64_ERRATUM_2224489
>  	bool "Cortex-A710: 2224489: workaround TRBE writing to address out-of-range"
> -	depends on COMPILE_TEST # Until the CoreSight TRBE driver changes are in
>  	depends on CORESIGHT_TRBE

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>  	default y
>  	select ARM64_WORKAROUND_TRBE_WRITE_OUT_OF_RANGE
> -- 
> 2.25.4
> 
