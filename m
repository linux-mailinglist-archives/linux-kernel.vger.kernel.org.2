Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D46E39B424
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 09:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhFDHlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 03:41:02 -0400
Received: from mail-lj1-f180.google.com ([209.85.208.180]:41732 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbhFDHlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 03:41:02 -0400
Received: by mail-lj1-f180.google.com with SMTP id p20so10361139ljj.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 00:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yOwepKabhCPmKTPr0etztsIVO+a68VfMgdxaEubWJlE=;
        b=rwB7ox9tYomxWvX8pOfPH2vYKaZ4BWEM2T9a6uudPWtrOMTNqFZDsdL2981Y056vxm
         HRQLogEbfa/4mVpEhWpRC56BLtBUGXZcDNUA6arITkh1ql1/EkX9i3/G/0WWzqMm0QbM
         kN67G7QyB8pGEdd1ImDTzHKF5WXDpgzAPrBla8dbgMBaM1Kuc18Ps3qy61TdQ7725Hng
         xU+MEkKCFa0kYrg6PDT1KE6cEdVfVHvsWgf7eWdqHWR7FV/w/tdiCG7hYT62flgmu27/
         8F/XSBfH5LhLnD2ey80QH2BJ1BL5SIY00mH5qlo5CqzJU4cW5nGUiXd/Yc5Xh09npXvd
         nJmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yOwepKabhCPmKTPr0etztsIVO+a68VfMgdxaEubWJlE=;
        b=ornXvutpYpgmVEa7c45Sv5TXk9/u3Yhzc2TpK1Qjl2J2tog1hxPxLl9JpPoJsPmg44
         JraXIQV0IXLAC7DdEqTaXRbLRgU5wjgeirFfbO8aPf9ZO2Flc1yiNlWF4aByvD1CjQ/m
         pp+vH0zWzZtZ3KKGIrBUWioyGweM8T/JGLfTez1MkECRjjxJN35UV4N2DWj0txECYJ6I
         yAjWHefA7oup8iuusmKqIihRWXSID5t6lBleaagUg1FgnkrfvKJv0c22wC9raLdI2WoY
         MLyX6KRCpIy6CvpLTlRYCFVpfw2bvHM7sIhqvAxQ5f0hpTDaQjbpExYdcaqVkUYOdI8s
         887w==
X-Gm-Message-State: AOAM533ZKJb3y2RWuchydP171Z28qn5msL4ZaXxo5esRxGW5LJwMZQNM
        L5iPAEMIVyMbySUykDO4XqNjhhKHealTcvmt6vSFEg==
X-Google-Smtp-Source: ABdhPJzIdQWpOrgRv6RLNJ0NrzNffeoHpg0DZsixNT0uYWD8v+BKejrVg5yCVhJ+QA3/sha9tPbGYfCHi5I0O691tBY=
X-Received: by 2002:a2e:1319:: with SMTP id 25mr2511427ljt.200.1622792295347;
 Fri, 04 Jun 2021 00:38:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210603043726.3793876-1-dmitry.torokhov@gmail.com> <20210603043726.3793876-7-dmitry.torokhov@gmail.com>
In-Reply-To: <20210603043726.3793876-7-dmitry.torokhov@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 4 Jun 2021 09:38:04 +0200
Message-ID: <CACRpkdYsw6T_CMoV0XwLZ3YKmrKL5QsWsm4Ap4D47FrKpOCMcw@mail.gmail.com>
Subject: Re: [PATCH 7/7] Input: cy8ctmg110_ts - switch to using gpiod API
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linux Input <linux-input@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 3, 2021 at 6:37 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> Instead of legacy gpio API let's use newer gpiod API. This also allows us
> to get rid of platform data.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

>  static void cy8ctmg110_power(struct cy8ctmg110 *ts, bool poweron)
>  {
> -       if (ts->reset_pin)
> -               gpio_direction_output(ts->reset_pin, 1 - poweron);
> +       if (ts->reset_gpio)
> +               gpiod_set_value_cansleep(ts->reset_gpio, !poweron);

I would perhaps drop in a comment that this de-asserts the RESET
line when we power on and asserts it when we power off.

> +       ts->reset_gpio = devm_gpiod_get_optional(&client->dev, NULL,
> +                                                GPIOD_OUT_HIGH);

And here that this will assert RESET.

But that is just nitpicks, the code is fine.

Yours,
Linus Walleij
