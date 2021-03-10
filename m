Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00843334C99
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 00:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbhCJXcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 18:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233991AbhCJXcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 18:32:36 -0500
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D6FC061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 15:32:36 -0800 (PST)
Received: by mail-oo1-xc2b.google.com with SMTP id h3-20020a4ae8c30000b02901b68b39e2d3so232121ooe.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 15:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Lki+LVhGY+TJZZ9vEzSlPJrcvDWEcfN6Jpmqx+Vkc24=;
        b=WHmSoVbHh0YkRmMo2QkKPvnLh2xh+r/kgYySk2lnq2vG4xor5o+igOn03hUpYvpVBx
         Cj6aaQgizEcqr8CXULTsoaxHSpIKkRRaLd0Rv9vRvU8A23vLDpve1vRbo007jQ+e6TTd
         HzprnhA9Rryqjr3VV/OUNm5CtVEiqAUMPU7o936XEtYMWboozJSfELXfmflB2O9ct5Up
         ZRvc24kZqej2HDIH2QvABB+dFqoCRFRe1SjZQJxOYqp489zTUoN+0O2TtyJ2CbtFn2Nl
         SMxDWL5g3SLl31M1Ft3ZcRcXo0DRjEne9qv3WBi1GDCO8LIAEMnKsU6RaN8eFQ7oRsWz
         naRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Lki+LVhGY+TJZZ9vEzSlPJrcvDWEcfN6Jpmqx+Vkc24=;
        b=Y3+YMCv2uxlAS0QA8wcERfos+yX8OxvXgAqkWdyA0xKnz+sDv1xpJyMMzVAoFYdquB
         bNTNlotGv7r1VtIH2pOo/VokCyeEBOTD3ac/nnuvqTbkGOCAwulyH2jBxkQNCVFO/LaS
         I/abP74UzDzykZ/0VmWwmcZJqLaAvgP1wk7kpld69PQfOImGqZWbKl0J69cnfzcJ1YK5
         OjTczi52g+3UgQDHImJ6mHzXVp6bRlf+i1WTvtVZtcSz9zE0wujDA9TS9Z/4rMTMevMF
         1sI1LweOBTgR8I7cO1CdPrVNqB7FLplLTeHncViiqG91myg8ghGOq+TbzsKQtDuDGU4M
         p6/g==
X-Gm-Message-State: AOAM531m0x72WQDA+y12gHwSnxr2eWl4y96nBuz5BbOGAjEauzf1be+7
        t78g2+sjvvimpnBPB/tK4trtBA==
X-Google-Smtp-Source: ABdhPJyHwvVzHT4WfwD/MTxFLXkw2JPAOy7xnkyabLGfWPvokC5X5Ar5OGn9ENIkzukawxDBvIfySQ==
X-Received: by 2002:a4a:d48b:: with SMTP id o11mr4262670oos.2.1615419155407;
        Wed, 10 Mar 2021 15:32:35 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id z3sm202269oix.2.2021.03.10.15.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 15:32:35 -0800 (PST)
Date:   Wed, 10 Mar 2021 17:32:33 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        amit.pundir@linaro.org, Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2] gpio: wcd934x: Fix shift-out-of-bounds error
Message-ID: <YElXEVBFkoLd2FSy@builder.lan>
References: <20210310174304.22176-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310174304.22176-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 10 Mar 11:43 CST 2021, Srinivas Kandagatla wrote:

> bit-mask for pins 0 to 4 is BIT(0) to BIT(4) however we ended up with BIT(n - 1)
> which is not right, and this was caught by below usban check
> 
> UBSAN: shift-out-of-bounds in drivers/gpio/gpio-wcd934x.c:34:14
> 
> Fixes: 59c324683400 ("gpio: wcd934x: Add support to wcd934x gpio controller")
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
> changes since v1:
> 	- removed unnecessary dump stack from log
> 
>  drivers/gpio/gpio-wcd934x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/gpio-wcd934x.c b/drivers/gpio/gpio-wcd934x.c
> index 1cbce5990855..97e6caedf1f3 100644
> --- a/drivers/gpio/gpio-wcd934x.c
> +++ b/drivers/gpio/gpio-wcd934x.c
> @@ -7,7 +7,7 @@
>  #include <linux/slab.h>
>  #include <linux/of_device.h>
>  
> -#define WCD_PIN_MASK(p) BIT(p - 1)
> +#define WCD_PIN_MASK(p) BIT(p)
>  #define WCD_REG_DIR_CTL_OFFSET 0x42
>  #define WCD_REG_VAL_CTL_OFFSET 0x43
>  #define WCD934X_NPINS		5
> -- 
> 2.21.0
> 
