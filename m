Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8E93877EC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 13:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245073AbhERLnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 07:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245054AbhERLne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 07:43:34 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74336C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 04:42:14 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id t4so4931803plc.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 04:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7S6PUZObKkIfh3dODhQCy9E7mIQHbGFC9dWCAcju/jo=;
        b=SwBpWj+/Sbd3xmdoFsEWL4TtWjdKN15Sfgx7w030cR7SVp6Ye1cVLF/GgJrB8PdJ3t
         +bWWuSUBuB1S6wyeQTzPboeQVPgyIKTIfegE/8OIhCCSCynGDynUFDGzQz6mXE7+pvIW
         dM353u8JWAaT6zEiBJ+LSggu4nM//+AIqjqXyRGO6UDLpxPZlkun7Hpvdt41hBAmP/gj
         oVN/+/9BJWbZCzVcLMu7EFQ21iZ8eCc6cB2IWdLhb5dbMmgsFpTcJ9BJysNFQ/6IX3BC
         0pQwP9p4EGhKsuCMF5q6BL4n6VkGpnyTbZPZ0sCvIo/HrvdSb4eM2LIgM1Cr5ViZj5rp
         hvLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7S6PUZObKkIfh3dODhQCy9E7mIQHbGFC9dWCAcju/jo=;
        b=JzQXCxCNfKQKFYxipCy6TR7OEPJ1fVjgJSdQxchbW/68lJl+iRvDfHXZ6TNOBW6bD+
         pip9Z/hklEikQZZMOrLUL2D4o8ms7Khdw3KMdtTh8PJsohrek2P/sw5fRSit+zR8Uebf
         nx2i5PTlbzBG3cB/a8jS/QM8GuTPcpsiaXYrJoKEJczD2zGZHe1Cw2wbjEF7G+hjUg/D
         kDlN9jkh9DPES5fAHkewiwtLiI6RY/POX0x7E52l6W3HCIj48fn5F8a/pVys5ZWRClnB
         SccmmRrGWe5PFwGVhL336Qxjh11IPknF0kjGt5mXMnygQg0F7qWJQlfGVyY3Vg4VzlEP
         +K9g==
X-Gm-Message-State: AOAM532A3euPgZbtaBemoJrp8LPnDPb6j1sTmgvcfdtI+bkgBXOgGhW/
        yFb6iTZebmeP7oeCt+I2jnNCO+YZPIG7XDh84PEy/Q==
X-Google-Smtp-Source: ABdhPJxFfhcir7SromnhgqTH2KqWlndpO3tIOi4AVJmcHUKmPMiLDixKblE4Sk6MK9lPqY7c+ddadZP+ObGtVwvmRCk=
X-Received: by 2002:a17:90a:e391:: with SMTP id b17mr282959pjz.75.1621338133894;
 Tue, 18 May 2021 04:42:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210513175258.5842-1-jonathan@marek.ca> <20210513175258.5842-4-jonathan@marek.ca>
In-Reply-To: <20210513175258.5842-4-jonathan@marek.ca>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 18 May 2021 13:42:02 +0200
Message-ID: <CAG3jFys=aCJOnP11EC_PK-KBJxMksT78McKb6pLTHuBxhU2qdg@mail.gmail.com>
Subject: Re: [PATCH 3/3] clk: qcom: Add camera clock controller driver for SM8250
To:     Jonathan Marek <jonathan@marek.ca>
Cc:     MSM <linux-arm-msm@vger.kernel.org>,
        Andrey Konovalov <andrey.konovalov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Jonathan,


> +static int cam_cc_sm8250_probe(struct platform_device *pdev)
> +{
> +       struct regmap *regmap;
> +
> +       regmap = qcom_cc_map(pdev, &cam_cc_sm8250_desc);
> +       if (IS_ERR(regmap))
> +               return PTR_ERR(regmap);
> +
> +       clk_lucid_pll_configure(&cam_cc_pll0, regmap, &cam_cc_pll0_config);
> +       clk_lucid_pll_configure(&cam_cc_pll1, regmap, &cam_cc_pll1_config);
> +       clk_lucid_pll_configure(&cam_cc_pll3, regmap, &cam_cc_pll3_config);
> +       clk_lucid_pll_configure(&cam_cc_pll4, regmap, &cam_cc_pll4_config);
> +
> +       return qcom_cc_really_probe(pdev, &cam_cc_sm8250_desc, regmap);;

Remove a semicolon.

> +}
> +
> +static struct platform_driver cam_cc_sm8250_driver = {
> +       .probe = cam_cc_sm8250_probe,
> +       .driver = {
> +               .name = "cam_cc-sm8250",

Maybe conforming with the naming scheme of "sdm845-camcc" is the
better way to go.

> +               .of_match_table = cam_cc_sm8250_match_table,
> +       },
> +};
> +
> +static int __init cam_cc_sm8250_init(void)
> +{
> +       return platform_driver_register(&cam_cc_sm8250_driver);
> +}
> +subsys_initcall(cam_cc_sm8250_init);
> +
> +static void __exit cam_cc_sm8250_exit(void)
> +{
> +       platform_driver_unregister(&cam_cc_sm8250_driver);
> +}
> +module_exit(cam_cc_sm8250_exit);
> +
> +MODULE_DESCRIPTION("QTI CAMCC SM8250 Driver");
> +MODULE_LICENSE("GPL v2");
> --
> 2.26.1
>
