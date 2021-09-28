Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0509041B21F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 16:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241306AbhI1OcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 10:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241280AbhI1OcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 10:32:11 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE5FC061745
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 07:30:32 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id m3so93539114lfu.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 07:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uh1B6XTocg/PuNZlNsHJ5qn3ywJ0pfLGKGnm5l1sB1s=;
        b=bt1vQ9mFtLWbSomTDSPbF5QE3RLYCRSGiCjPdnKP0BYNmZ22nN/5dQreFOHtJlZP9A
         w1Ju27SQF3MMrUPKopIdjsdV0fU69078TLg3O6fDK6EtaBVBFxWWwokt6QgWln5o8xT/
         0FE64IiWO7MHsJ9hCkLWJ0A73tKdDUIHDA2H6cYZe3v+aaEsZvFVbmFcynWdoX4JFqyW
         VHhtrRCMq587NZq3jdj7pcF+xc6daSurloZBhgz178YbCvxjCtZ9KIVs5/G/eVu3cZz0
         O2DoTHqZJqv61DW3iDhIzQkvY9RLrrmCkYy5YJEATVCpeoiBUANGdDnTN7VJiWwB9a31
         i2FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uh1B6XTocg/PuNZlNsHJ5qn3ywJ0pfLGKGnm5l1sB1s=;
        b=J1YbQ+Ml0lxmg9G75C1z5YMlTnwce/r/cTWPxSVT6doAHRRKCbc/ETWdY1hqpVyhhe
         Rwr0Jlo4vhteCeKVWQJNXUvK/Agno1p5mhzScTMW6RqLosF4RZK7ZaQorxDjZx4WdgxJ
         E3N0VhILfvSpYlP/DXjLmlXBPq5b06ERLkIoONGGsus7TOgSgQbohKq8A+FVZtid45Hq
         1y/BbYssCRrLWRj8LWzjOdb4+frV4FVIkBqsGuSXIHzz9FYiXtKPUULFWunTQGGCn6l3
         DxHNEq/ZP7vjPanFYjS03QFsWq2KYIsiRR/aevjD89eHBRODdw7XQKWps8HmrutjKZ3X
         pnjg==
X-Gm-Message-State: AOAM53130LWOksq5w+gHGV7h/q3dqeR7V7yExZ0tfNE/tg8gdEo8BV6P
        vkSGrq5vkby5LLCvoDTj4fNafaRl3O8GUEoqyrAM8g==
X-Google-Smtp-Source: ABdhPJxrQ91FcoG1j8MqOj19A8jz0Mbb51yvmE4ezgOpcY+fkN/eVADQarawxS3wzP2LfC8q5vYwAWJL1ZqFFqpb/1o=
X-Received: by 2002:a05:651c:1124:: with SMTP id e4mr253677ljo.261.1632839421344;
 Tue, 28 Sep 2021 07:30:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210928141956.2148-1-caihuoqing@baidu.com> <20210928141956.2148-7-caihuoqing@baidu.com>
In-Reply-To: <20210928141956.2148-7-caihuoqing@baidu.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 28 Sep 2021 16:30:09 +0200
Message-ID: <CACRpkdYSKnk0v2FEPg5h4p_ODtepXoH9=a=8hiTa7BP3goaPKA@mail.gmail.com>
Subject: Re: [PATCH v3 7/9] iio: adc: qcom-pm8xxx-xoadc: Make use of the
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

On Tue, Sep 28, 2021 at 4:20 PM Cai Huoqing <caihuoqing@baidu.com> wrote:

> When possible use dev_err_probe help to properly deal with the
> PROBE_DEFER error, the benefit is that DEFER issue will be logged
> in the devices_deferred debugfs file.
> Using dev_err_probe() can reduce code size, and the error value
> gets printed.
>
> BTW, change the return value from 'ENXIO' to 'ENODEV',
> perfer ENODEV which means no such device.
>
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
> v2->v3: Update the changelog.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
