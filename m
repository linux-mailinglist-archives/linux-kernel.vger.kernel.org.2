Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B86E41B129
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 15:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241105AbhI1Nwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 09:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240979AbhI1Nwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 09:52:32 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B941C061575
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 06:50:53 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id y26so53622975lfa.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 06:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hqwz9jzyEQV5H4SW8S/gf8kyYKDVCl9EoNAa0kvGs9E=;
        b=lK1N+HWcCfWtNCrGgY4s6GgX9CsGhnRcYX4lqPYKVXVMLm9dFqGOmTWH6W7yDgrYlP
         r5EfG2iKtNsCiPEpu2jIIZUO/prlSrOSngipvA1TaZXN//4VkeA+JwIztwUCHInTjF+X
         dIEeqXK9vl1zabQddSGCMK/1z7p7VHD0/EGwo/HlhXJ3zAduBt5JgEYfTeOMBww2Fp7C
         uuEQ+v8uMPilV3Gj8rG9xjCBY2Z3AgQB7zHz7LAOKEGK+E4GoP5y67eAshWxmcfY0b/C
         tbJ5BllnohxxoWYH9FNEsSkrxF7kZTx9LML4VnlI/nkZyyXKBdokKSpCUGceySjEP260
         j7fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hqwz9jzyEQV5H4SW8S/gf8kyYKDVCl9EoNAa0kvGs9E=;
        b=L09M2dUzrk5ZwkdBAW4PYssrqBviUApigE/9gzDsPSaXQ8tdlZzDOdmht/tPkCPsT0
         4ktFjrNMdAw464f7y/huwsr0OTPr0foZuFbTc2Miy+CImGgYkYQtk++eF4b8Xxm35t+m
         ERrFSpAtbkFg839bqCh6xQ2r0UFwkl8l21MYEezWz/WgUyH1deTIn3IOKvmhPrk/Rjvy
         hZ7KPcYAGGNMaUQ765u1ArRfQBvaKfOEupjazUPOHMH09LLOXz7f0SEGaSUh77fR74LJ
         8giXGaJDJnhWKNweof9/8O24UtqcvK4XikWTpSLhwKzMbUstU8SJwcuqO6Z9cZteiqcB
         6UJw==
X-Gm-Message-State: AOAM532XmgqttqXn82CD5yMTEYFymxhHz+G5H9VoQgP4y015F1qT0zkg
        Rk//Jw3H+tc0qaRERATQGV4l1+Z+LYZNAkUt++S11g==
X-Google-Smtp-Source: ABdhPJzKB7hvIUZRQ/aoIoW5cqtS9HhlPZ5bpsUvwPy/3OPtxA+hpK098gljBYdBI6LlYdW5gw8hagp89uPCk1TRlmw=
X-Received: by 2002:a05:651c:4ca:: with SMTP id e10mr43638lji.259.1632837047280;
 Tue, 28 Sep 2021 06:50:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210928013621.1245-1-caihuoqing@baidu.com> <20210928013621.1245-7-caihuoqing@baidu.com>
In-Reply-To: <20210928013621.1245-7-caihuoqing@baidu.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 28 Sep 2021 15:50:36 +0200
Message-ID: <CACRpkdYJjDCvzX7LL1Qv7zYM_E1+1fqCSNxz-KVK6t35xMi6LA@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] iio: adc: qcom-pm8xxx-xoadc: Make use of the
 helper function dev_err_probe()
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 3:37 AM Cai Huoqing <caihuoqing@baidu.com> wrote:

> When possible use dev_err_probe help to properly deal with the
> PROBE_DEFER error, the benefit is that DEFER issue will be logged
> in the devices_deferred debugfs file.
> Using dev_err_probe() can reduce code size, and the error value
> gets printed.
>
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
(...)
> -               return -ENXIO;
> +               return -ENODEV;

Why?

I think it's the right change, but should be in the changelog.

Yours,
Linus Walleij
