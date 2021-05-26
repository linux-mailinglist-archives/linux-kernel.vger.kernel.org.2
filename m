Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2610E391ABF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 16:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235112AbhEZOvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 10:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235104AbhEZOva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 10:51:30 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21EE1C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 07:49:58 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id z137-20020a1c7e8f0000b02901774f2a7dc4so3499670wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 07:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=gcMCAthuFh62A6JYOWw0YWI1O6qLr+rKFrqkC6c0AMk=;
        b=Qa43uI7LnoStSZI9viG4grGPSEhQcUN8zgCbxNB6zg4rPnNXk2lAvXGX7ve6qpK/0H
         zUp9BrNY+86JRj+VZlZXZ2+Iy4UjUc84trCxQhoJhIjXBsU8XoIwKC+nhXrTXVBq4acN
         IxJmG/n3CLG0drs5dpprf54k05NaNDMcvu0YuPCTh1m11Htjf05zhNDVA1slesPOU/2f
         EzXp6JQ4lZhrUj70tTI3ErEZJ2L9h89c5fZkUGWSJ/QCjQMRHjmmSlboQHjkUG+vkSXy
         uj1RJt6REp0XsyOn5LV6GcBhqtsQYExuABsGHx3Z1kINe2R1yd2f362Pywhjk1HaKLw2
         Skpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=gcMCAthuFh62A6JYOWw0YWI1O6qLr+rKFrqkC6c0AMk=;
        b=mtpGLLqSekxdRrLsID4qNboMVuD2wwVoSvWfgkGPB5x6ni9ZBsOv6dHYxyK99e8SC1
         y9weoIn7Eh4d/qKSir/8fTRA02ES/qZ4SfuTf1H5ZnVujz7ny327UBbDqLkzHyDXiVTr
         lBWfUYegD6OSvqZP2w4EKGhP1D++iAM+UV/yi032JkgBYrIM2M4F1RYGMAUaRKjifwy8
         lx3v/A8BwexVI6QxUG9Za5+9MukiEjWwudVv34/Fp1Hl+JagXB5eRMHNI+MIcNugxjRv
         LmudPOGyKTct2xTsjAts2bwISYZLpV/NrfGQFuhgCrK07cEH18CE1fqMCAcJd681PZ8f
         EuzA==
X-Gm-Message-State: AOAM533rmfI5TMfYwMN5DJfL+QypEXrtsDWcLSpYzuoa7VObdLzuVZbX
        zBCsTORenL9j3YjlOfHnof7oXc6O/ZinDg==
X-Google-Smtp-Source: ABdhPJzReZ4i69M5bjQdNoUNLgaUJfw2dEG4GS9p4HgjlKexmYMimNG44GaES+uW6pV/9Di4wo3aiw==
X-Received: by 2002:a05:600c:4f8b:: with SMTP id n11mr29441004wmq.180.1622040596660;
        Wed, 26 May 2021 07:49:56 -0700 (PDT)
Received: from dell ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id q27sm20658094wrz.79.2021.05.26.07.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 07:49:56 -0700 (PDT)
Date:   Wed, 26 May 2021 15:49:54 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [RESEND PATCH v2 07/13] mfd: twl: Correct kerneldoc
Message-ID: <20210526144954.GD543307@dell>
References: <20210526124711.33223-1-krzysztof.kozlowski@canonical.com>
 <20210526124711.33223-8-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210526124711.33223-8-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 May 2021, Krzysztof Kozlowski wrote:

> Correct kerneldoc function name to fix W=1 warning:
> 
>   drivers/mfd/twl-core.c:496: warning:
>     expecting prototype for twl_regcache_bypass(). Prototype was for twl_set_regcache_bypass() instead
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  drivers/mfd/twl-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

And this:

https://lore.kernel.org/lkml/20210520120820.3465562-3-lee.jones@linaro.org/

> diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
> index 20cf8cfe4f3b..24b77b18b725 100644
> --- a/drivers/mfd/twl-core.c
> +++ b/drivers/mfd/twl-core.c
> @@ -485,8 +485,8 @@ int twl_i2c_read(u8 mod_no, u8 *value, u8 reg, unsigned num_bytes)
>  EXPORT_SYMBOL(twl_i2c_read);
>  
>  /**
> - * twl_regcache_bypass - Configure the regcache bypass for the regmap associated
> - *			 with the module
> + * twl_set_regcache_bypass - Configure the regcache bypass for the regmap
> + *			     associated with the module
>   * @mod_no: module number
>   * @enable: Regcache bypass state
>   *

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
