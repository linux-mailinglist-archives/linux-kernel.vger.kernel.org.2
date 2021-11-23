Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCDA745A991
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 18:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237806AbhKWRGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 12:06:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235873AbhKWRGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 12:06:04 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293E6C06173E
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 09:02:56 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id j6-20020a17090a588600b001a78a5ce46aso2630250pji.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 09:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6owNqcDoaPPSgoDjdbesWq57uvbLFPnsWIEPdW/px0Y=;
        b=c9d8xUe/qOtuuioWpxS12A7KI9r3l4VMIXBgcGzpznWs0Z7OcN0I4loL/PTCu/UxS5
         ddHAgBFAiLNy4HVFTUJfJgFawfhKcZMV4IqUQlX8hHmx8imjpHkXB/05UCzUTd9hZ+cM
         H5R+4ROxvg+Y9eIXumRe0zLb1crOVseNnB+eGU5IwaVnf3HSCX4I+/rRHUNp7JXgRpON
         gke3LRwzPRPRZzNa9aTuyIjo7iWhATMnE8BViCFYEdFkVI5rHv83SfK7c93u3qx80tPJ
         j4N+tjk8bGBvDSGc2JaSzL/6Nwe6p8Bysk9bmwZbNnahGEYiZe4GPCESO79yevFbhZRY
         qZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6owNqcDoaPPSgoDjdbesWq57uvbLFPnsWIEPdW/px0Y=;
        b=ZNeJgF2NPFk/odwAtgVXijG1J+hYUIeJvlrwbaWwflreXoVcMycXgkTS2lhE5E6kNN
         cO+S0/bny44p+KLLgYJSKoQng42iye0t+2DrtnGqJSdMH/371sUZyKsiGZskAS6GPtmz
         oyZ+bPA43gY8J3motbevP64JSmb8RDbrWyVdxOQoUj06SzuuczqMgPXWHba3+4rn7GUt
         iC8CZcLuWCO3uvp3jCqkugTAKC27YqM0gTuZSgF54e9wAtT8z497CvXy+pCyD99PdnyK
         nzBy98syU15oVQv8K75TWsImqB82+6NqMEa9iY2KIieoBQc20kWHTn2u7ry5Bd9EpnDI
         jkkA==
X-Gm-Message-State: AOAM532NfktBuOcRtSdWXGDllU6mG24lC1mtbR7xx1OceV5C4f6NH5Oo
        P0la1+f0Al7Z4vK+BKiiuKDt2HYPtjyTVHqYJBxBLQ==
X-Google-Smtp-Source: ABdhPJwtC9yJlhnYSPMNvmxu7MqpYmoigPcHG8h5MiPYBe/ro3thUy9VrOdP/Yt2YsoF0GVD49p0yUtPiYGvL0ZSwMA=
X-Received: by 2002:a17:90b:3e8c:: with SMTP id rj12mr4745975pjb.152.1637686975331;
 Tue, 23 Nov 2021 09:02:55 -0800 (PST)
MIME-Version: 1.0
References: <20211123161630.123222-1-bjorn.andersson@linaro.org> <20211123162508.153711-1-bjorn.andersson@linaro.org>
In-Reply-To: <20211123162508.153711-1-bjorn.andersson@linaro.org>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 23 Nov 2021 18:02:44 +0100
Message-ID: <CAG3jFyv4uhEN9zO0Kt9QU+0i93YoT7ccpSN-amncQM=zM9r6JQ@mail.gmail.com>
Subject: Re: [PATCH v2] clk: qcom: clk-alpha-pll: Don't reconfigure running Trion
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Bjorn,

On Tue, 23 Nov 2021 at 17:23, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> In the event that the bootloader has configured the Trion PLL as source
> for the display clocks, e.g. for the continuous splashscreen, then there
> will also be RCGs that are clocked by this instance.
>
> Reconfiguring, and in particular disabling the output of, the PLL will
> cause issues for these downstream RCGs and has been shown to prevent
> them from being re-parented.
>
> Follow downstream and skip configuration if it's determined that the PLL
> is already running.
>
> Fixes: 59128c20a6a9 ("clk: qcom: clk-alpha-pll: Add support for controlling Lucid PLLs")
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>
> Changes since v1:
> - Forgot to commit the last minute s/pr_dbg/pr_debug/
>
>  drivers/clk/qcom/clk-alpha-pll.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
> index eaedcceb766f..8f65b9bdafce 100644
> --- a/drivers/clk/qcom/clk-alpha-pll.c
> +++ b/drivers/clk/qcom/clk-alpha-pll.c
> @@ -1429,6 +1429,15 @@ EXPORT_SYMBOL_GPL(clk_alpha_pll_postdiv_fabia_ops);
>  void clk_trion_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
>                              const struct alpha_pll_config *config)
>  {
> +       /*
> +        * If the bootloader left the PLL enabled it's likely that there are
> +        * RCGs that will lock up if we disable the PLL below.
> +        */
> +       if (trion_pll_is_enabled(pll, regmap)) {
> +               pr_debug("Trion PLL is already enabled, skipping configuration\n");
> +               return;
> +       }
> +
>         clk_alpha_pll_write_config(regmap, PLL_L_VAL(pll), config->l);
>         regmap_write(regmap, PLL_CAL_L_VAL(pll), TRION_PLL_CAL_VAL);
>         clk_alpha_pll_write_config(regmap, PLL_ALPHA_VAL(pll), config->alpha);
> --
> 2.33.1

This resolves an issue I was seeing related to clocks not being able
to get updated.

Reviewed-by: Robert Foss <robert.foss@linaro.org>
