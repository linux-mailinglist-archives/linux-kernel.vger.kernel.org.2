Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6865C43235A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 17:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbhJRP4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 11:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbhJRP4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 11:56:17 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F83C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 08:54:06 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id pf6-20020a17090b1d8600b0019fa884ab85so14779359pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 08:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+nHk6dtMZ7Z99/OVtb5OCwo/k8Axaa40o3XlHC4jvr0=;
        b=wXwNi4SUKccx7lISXORNZHJNo41cR+YQZBac9v/v2TZ/BZaHIEfaQNsfLgwQV8VyYn
         YlsBi1L0wIGJpIiQ4j+yOdSgMal5f9t9JJUXTZRVRHIz0pMhdi3DJyJCf5PT5iVQqzQb
         Gf3p9eAtTFKJ/0occ733+8x0st7ibNyZzuORJxtfxSuM3Q0JuAzI/rQOBe8XGTmBngGW
         OI44iPMj3AbRR7lK3Ng3NSGcGcEy6pGvIDwqnv+G4e4cjAP4Tg2qlTW+Vkl9kzzdokeR
         hb78FrG6quu4p9tFuC9HHlvhALzQgavS82GZPcUKeL2zxHhDlsMcqY1Nrkaq3qLeOckO
         Mqfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+nHk6dtMZ7Z99/OVtb5OCwo/k8Axaa40o3XlHC4jvr0=;
        b=TX82bXCHqGeQsrYAChXEeq8knxC6QUc4SbEjeY5KhnZa4QvsRTTMQSq8RNlI9l0Dyk
         pl6GkQgkBkZHmSQ4oLtw2PSM7hlPVnHTL6tWOOwqdUlepHg4IBqzWBR3W5rCpZiHC04a
         fT+q4HqRcdcp0KYy1ZncJ8mpPhny95eEk60EGZ3+xt+88lxgIvVChzMz3OCJiCmd8+mM
         nFEnyri3i72iqwtPvuFvmuuy0zjRh4iCiw5oZBeP2wiWNQvIctmLT7Bk916z+Ul/EhHY
         ixGnk5ot26mqEekhIzgZaDZThVZBx75q7f8aPaOMHAdg6fNVt99nktUdKEY7FW98tDYE
         cYDg==
X-Gm-Message-State: AOAM531EzzyhlPYrjHzoCjW4+k98ld7vE10lHdnuGRCQRqVZHfmO6PHr
        CaFE23CZEkGHHRunYGK3QNXgTA==
X-Google-Smtp-Source: ABdhPJwcnGc8E8+FGyPLm76h/723QgEj4EI1PIKWn3yzOioCie+9/q9LdgGHEwXwGNuvHg5p0lPmJg==
X-Received: by 2002:a17:90a:191a:: with SMTP id 26mr48743951pjg.118.1634572445325;
        Mon, 18 Oct 2021 08:54:05 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id a10sm12819690pgw.25.2021.10.18.08.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 08:54:03 -0700 (PDT)
Date:   Mon, 18 Oct 2021 09:54:01 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     will@kernel.org, catalin.marinas@arm.com,
        anshuman.khandual@arm.com, mike.leach@linaro.org,
        leo.yan@linaro.org, maz@kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 14/15] arm64: errata: Enable workaround for TRBE
 overwrite in FILL mode
Message-ID: <20211018155401.GC3163131@p14s>
References: <20211014223125.2605031-1-suzuki.poulose@arm.com>
 <20211014223125.2605031-15-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014223125.2605031-15-suzuki.poulose@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 11:31:24PM +0100, Suzuki K Poulose wrote:
> With the workaround enabled in TRBE, enable the config entries
> to be built without COMPILE_TEST
> 
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  arch/arm64/Kconfig | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index f30029f4a9f9..f72fa44d6182 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -672,7 +672,6 @@ config ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE
>  config ARM64_ERRATUM_2119858
>  	bool "Cortex-A710: 2119858: workaround TRBE overwriting trace data in FILL mode"
>  	default y
> -	depends on COMPILE_TEST # Until the CoreSight TRBE driver changes are in
>  	depends on CORESIGHT_TRBE
>  	select ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE
>  	help
> @@ -691,7 +690,6 @@ config ARM64_ERRATUM_2119858
>  config ARM64_ERRATUM_2139208
>  	bool "Neoverse-N2: 2139208: workaround TRBE overwriting trace data in FILL mode"
>  	default y
> -	depends on COMPILE_TEST # Until the CoreSight TRBE driver changes are in
>  	depends on CORESIGHT_TRBE

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>  	select ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE
>  	help
> -- 
> 2.25.4
> 
