Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B05C39F77B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 15:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbhFHNSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 09:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232728AbhFHNSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 09:18:52 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E86C061574
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 06:16:44 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id x8so10830660vso.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 06:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hpplA6Fv6gqlJrx9MVYvEyu2+9CFUA8ToNoqtQ6jasU=;
        b=BqADVqx8y2DVKVgA/xCjrxtyM1Gs9RV94SNPy6k6Z6UIptajWLKsGkado94kCpoNY6
         tGI9iwXsES8zIi3UE3g3cqAVjINyeGe8po7XYpDacIuW8klOrLTkm6yZEIlHXZ9Ab/gE
         +nX6twnvnOmYijaacsQr8Gh0HSpXSg1VchjFqaGZRBcNyM49iTryDJYueVRp3TRLRqnP
         OMjyfWB140rqHQ0uboFJenTp94AMWRnkJGVOqSoAWHLMSBVKBfMu1QCUCrqW+mkNZKpS
         BG6fp3ddbfcDMtRlHJDxZQIcdNCN9ezf2ioff3lGaHUHzJE5mNlu3rv2tMZWjbTN9wg0
         wvsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hpplA6Fv6gqlJrx9MVYvEyu2+9CFUA8ToNoqtQ6jasU=;
        b=PHt0nxCph6q9SUJ6RY5t5usQZebcsulwtaF5mQ+b+bfqt7LqNnfUy643x7W2/L1OUO
         w6MsGOQQ9ii9vCdItB82N0gf387qGfCy1ZbbhIw5C0TL4x0rPq/pq4rMLOa40YFhe01s
         JlA4f9MsYNm2FeZLWKLwGdh6i5vIrzqrdwYH5Naf1LUpNiI4ptJGd6QV/DHRe14q8EcG
         Lgbzkb1+vXoX2Oo/HI51iIMJtP+cslgyCvIGp5tAW4r1ASlvgGBz1uPWpK9d7J6ikS94
         rXMAb4Fu2FmoXxwFOokS/pl1Zi5CN00JqIypECc4Iy7ScggxBB6JRB81Q+AfOSKMMkd1
         Eo9Q==
X-Gm-Message-State: AOAM53323/QTWGiaEqXwYHAqhlY8sH9cLX2SCuKr0xrAU3PIlWoEfA1D
        qk3QyqETgVDgE+N++nAWL1WRsLUYCm1fHb+xA37uqQ==
X-Google-Smtp-Source: ABdhPJzHJ705v7RhZgZU+bX7G/bAuqLvXnhZQ2HnR0DYK1oZvzl21Z9kN28AdoaRPIfsaOaTl0R4C+T1JV/PYZl0W58=
X-Received: by 2002:a05:6102:d1:: with SMTP id u17mr11664363vsp.48.1623158203612;
 Tue, 08 Jun 2021 06:16:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210601095403.236007-1-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20210601095403.236007-1-krzysztof.kozlowski@canonical.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 8 Jun 2021 15:16:05 +0200
Message-ID: <CAPDyKFq6Aaw9kqr3NAdM1oZvXyNkcoUAQT03EUdKv56LRxHNhw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: sdhci-esdhc-imx: remove unused is_imx6q_usdhc
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Jun 2021 at 11:54, Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> The is_imx6q_usdhc() function is unused:
>
>   drivers/mmc/host/sdhci-esdhc-imx.c:343:19: warning: unused function 'is_imx6q_usdhc'
>
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: f47c4bbfa283 ("mmc: sdhci-esdhc-imx: create struct esdhc_soc_data")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index fba4a963d12e..7336ae749137 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -324,11 +324,6 @@ static inline int is_imx53_esdhc(struct pltfm_imx_data *data)
>         return data->socdata == &esdhc_imx53_data;
>  }
>
> -static inline int is_imx6q_usdhc(struct pltfm_imx_data *data)
> -{
> -       return data->socdata == &usdhc_imx6q_data;
> -}
> -
>  static inline int esdhc_is_usdhc(struct pltfm_imx_data *data)
>  {
>         return !!(data->socdata->flags & ESDHC_FLAG_USDHC);
> --
> 2.27.0
>
