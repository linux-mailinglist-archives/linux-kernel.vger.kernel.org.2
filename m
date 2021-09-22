Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC2564145EE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 12:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234606AbhIVKPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 06:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234879AbhIVKPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 06:15:18 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF24C0613E2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 03:13:18 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id 72so7742308qkk.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 03:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/8yX95pvcRtgj3+l1Dvc2BnLTTvMZgpjXa7orH/cvhg=;
        b=etHqq3yE5G1MARQ1NlzqfwXJlqqEhqQoEABGLp+av+czxO4aLVAZMw8yaWnCbCvUxU
         8LqlB7xjt3zf+LpRUwpIpyxAyB7N+KCXHUr4j+9+YP5qSON4qpZD2EqEoShlIYXM+cdI
         DkmR+pibfCSMPKZ+9pYdTLT9f9qtE3bsDpZYg1CFGDuUly2EVYv1ZYB7B2KWPE4OGx16
         epZBiX4Dqr8NCDcGym4MGZPOYk07tfphc4fTNEvZ6w0d0voC8yAW7IbNFrfGcckEO4Gz
         fDdIzdOUptQp/9jIFSb/qGngTTGaMhKCoQkMP2afUVT11A2qmV37sjQyT3OGMIGjkku6
         TkgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/8yX95pvcRtgj3+l1Dvc2BnLTTvMZgpjXa7orH/cvhg=;
        b=RmGk9Nfny9uH2uvNsNg+QbI8wEmQo8sHqSYPCQfLIUHpD3G2fOOTMi7/skYLqnW2J4
         tH76O1ufpJ6hnkxnNz7+dzt7VIvJf6DvbdM0+NLAJxlz0iGHxtOCAZrVbFfcetop33Yo
         PlVzyGoM0D8/VJG3Girxp9Fj4IqVX9CIZS/PrOXw56yr9LN2X6sqFT7rhA1TaeBgSGfO
         F6XSQcMhqOpzM+873FXK/DymlbrIZDfmjcQ1OMECrK43Mcs+WUUb5ahoeXz9m7uc25WQ
         so9nFoxoKJHQoOKsK8CZxS3K3wqDN6H8KgyoK6KSdyozO567ZZF0x1VCotFb7V3wmFrr
         4hDw==
X-Gm-Message-State: AOAM531MfzHXyNj1PLXbBNhxLjldhG/yLjomOByo3mVGh8xvA4+FlPQA
        phgrgpp3nqb8yamqNzbOd43De9r+HTeBsUH4MdM/Fg==
X-Google-Smtp-Source: ABdhPJyeXorOUs+PriO6Ij8JtFcEvm0woYrm0FGYBDFtCr3yp19a55RbDGTKLsev+CLR25fXYJd2n2dDEfcHqDZJLDc=
X-Received: by 2002:a25:cbc3:: with SMTP id b186mr42825883ybg.199.1632305598057;
 Wed, 22 Sep 2021 03:13:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210916164641.135008-1-krzysztof.kozlowski@canonical.com> <20210916164641.135008-2-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20210916164641.135008-2-krzysztof.kozlowski@canonical.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 22 Sep 2021 12:13:07 +0200
Message-ID: <CAMpxmJVv0N_NkbNV2NmajMEydfYw3R4MuW0XkK-THnGyOQrZvQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio: tps65218: drop unneeded MODULE_ALIAS
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021 at 6:46 PM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> The MODULE_DEVICE_TABLE already creates proper alias for platform
> driver.  Having another MODULE_ALIAS causes the alias to be duplicated.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  drivers/gpio/gpio-tps65218.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-tps65218.c b/drivers/gpio/gpio-tps65218.c
> index 3517debe2b0b..912382be48e1 100644
> --- a/drivers/gpio/gpio-tps65218.c
> +++ b/drivers/gpio/gpio-tps65218.c
> @@ -230,4 +230,3 @@ module_platform_driver(tps65218_gpio_driver);
>  MODULE_AUTHOR("Nicolas Saenz Julienne <nicolassaenzj@gmail.com>");
>  MODULE_DESCRIPTION("GPO interface for TPS65218 PMICs");
>  MODULE_LICENSE("GPL v2");
> -MODULE_ALIAS("platform:tps65218-gpio");
> --
> 2.30.2
>

Applied, thanks!

Bart
