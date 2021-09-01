Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFB53FD612
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 10:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242790AbhIAI7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 04:59:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:45798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239509AbhIAI7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 04:59:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2674A61075
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 08:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630486693;
        bh=ZcSl8QL3Am4u64j0N4jzg6z8iqyPZvH/GTxd9dmID44=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DzJxNfbO4d1POC9HiOg6GTVB2nb79d7u6Gk9zibLhwQ7FsfDg2hcRjjf2axLvu+a1
         NKuHrWlmWwDsqfERS1v58hEYgNvotYdqf3IXmxNEVsMjWwZHv/a4kaWZJnwkuE0e/I
         ErWiNd4Xv3XgeatW0ppkBrfsp8SLJyeUnval/M4Zy+wwoJtkmPZ3Joy8g7lok9YHN0
         HbkFCEpW8J3aDEpMun+eZduhFcy+VgQ0ZhaNYMEQauTEtAo/yQdoJ4wcR4h2GoeUYs
         0FXuZ2SPswV8DnogdWOjcirnKrnxcAiLgeSnvwAhhenUdfFGFyz2dJdB2+tDwI9Ht9
         gWY/BqCtfdsPA==
Received: by mail-pf1-f178.google.com with SMTP id m26so1521592pff.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 01:58:13 -0700 (PDT)
X-Gm-Message-State: AOAM531rO5qCySD7mXcr6BtjKrtujvx7xS4kjjwo3PJmkptkjctcTwjS
        aAMrPnCo2zjag9z5m0fYqtAN4NXaHZkUu77KfzI=
X-Google-Smtp-Source: ABdhPJwpTPUpQdq5T0AR48YEzddc/vy9Z3Y2xoBz+84Jmlem+SOZYT8hVVX2SsREOlHS2AB4t3z71ndScuxOOBNtZSk=
X-Received: by 2002:aa7:8116:0:b029:346:8678:ce26 with SMTP id
 b22-20020aa781160000b02903468678ce26mr32911123pfi.15.1630486692769; Wed, 01
 Sep 2021 01:58:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210831125159.29282-1-zhaoxiao@uniontech.com>
In-Reply-To: <20210831125159.29282-1-zhaoxiao@uniontech.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 1 Sep 2021 10:58:01 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfJFgg4ZkfW85mSg8+YaNFJ2G5OyRqJ=Hz-iZTpyNTndA@mail.gmail.com>
Message-ID: <CAJKOXPfJFgg4ZkfW85mSg8+YaNFJ2G5OyRqJ=Hz-iZTpyNTndA@mail.gmail.com>
Subject: Re: [PATCH] pwm: rockchip: Simplify using devm_pwmchip_add()
To:     zhaoxiao <zhaoxiao@uniontech.com>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org, heiko@sntech.de,
        u.kleine-koenig@pengutronix.de,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Aug 2021 at 14:52, zhaoxiao <zhaoxiao@uniontech.com> wrote:
>
> With devm_pwmchip_add() we can drop pwmchip_remove() from the device
> remove callback. The latter can then go away, too and as this is the
> only user of platform_get_drvdata(), the respective call to
> platform_set_drvdata() can go, too.
>
> Signed-off-by: zhaoxiao <zhaoxiao@uniontech.com>
> ---
>  drivers/pwm/pwm-rockchip.c | 29 +----------------------------
>  1 file changed, 1 insertion(+), 28 deletions(-)
>
> diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
> index cbe900877724..c22856916e63 100644
> --- a/drivers/pwm/pwm-rockchip.c
> +++ b/drivers/pwm/pwm-rockchip.c
> @@ -347,8 +347,6 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
>                 goto err_clk;
>         }
>
> -       platform_set_drvdata(pdev, pc);
> -
>         pc->data = id->data;
>         pc->chip.dev = &pdev->dev;
>         pc->chip.ops = &rockchip_pwm_ops;
> @@ -358,7 +356,7 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
>         ctrl = readl_relaxed(pc->base + pc->data->regs.ctrl);
>         enabled = (ctrl & enable_conf) == enable_conf;
>
> -       ret = pwmchip_add(&pc->chip);
> +       ret = devm_pwmchip_add(&pdev->dev, &pc->chip);
>         if (ret < 0) {
>                 dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
>                 goto err_pclk;
> @@ -380,37 +378,12 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
>         return ret;
>  }
>
> -static int rockchip_pwm_remove(struct platform_device *pdev)
> -{
> -       struct rockchip_pwm_chip *pc = platform_get_drvdata(pdev);
> -
> -       /*
> -        * Disable the PWM clk before unpreparing it if the PWM device is still
> -        * running. This should only happen when the last PWM user left it
> -        * enabled, or when nobody requested a PWM that was previously enabled
> -        * by the bootloader.
> -        *
> -        * FIXME: Maybe the core should disable all PWM devices in
> -        * pwmchip_remove(). In this case we'd only have to call
> -        * clk_unprepare() after pwmchip_remove().
> -        *
> -        */
> -       if (pwm_is_enabled(pc->chip.pwms))
> -               clk_disable(pc->clk);
> -
> -       clk_unprepare(pc->pclk);
> -       clk_unprepare(pc->clk);

NAK, for the same reason as pwm_samsung.

Please test your patches.

Best regards,
Krzysztof
