Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B97F3393970
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 01:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235398AbhE0XxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 19:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233938AbhE0XxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 19:53:23 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91323C061760
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 16:51:48 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id w33so2622312lfu.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 16:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=igQk9HIuYQm9nCu5NIGuLrsyKhw3Yali5yjk1GzMK1g=;
        b=x8HVgNcTHMj5JVGKRHW/wCa3LzV4elPUTOyr+cwzxoYv/27GB6Vr5op7LDnUCrQFQo
         WClXOUO77mmSoBaztmYxV8lugmBtCRQACzf+KqoyxqoGDbVxEomeRxcBR4MgVdbD/m5i
         j25ZjBBY4pv64I9XaA0eR9FuybSYgX7dryXNdk8y8qVTsxyR9yV6Djus+gGeRVCxDvPO
         EZyjheDf/tD+dxsik7cLUNYci9rcPmcLz5hzC9h6Uo7Im8AZyZKnkKN+0XCYy4ajfYbZ
         hHJIqjRu9BdZbwuVeDWwXXKiwVex14BZgs29gHFPMxbvAMLfiO7aPGM550kGaBBHNQ4Z
         f8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=igQk9HIuYQm9nCu5NIGuLrsyKhw3Yali5yjk1GzMK1g=;
        b=H5j0iyD4tvRbwaCHUdFdyHfwtPt470BoMuPfBz109oVdlBP4ujBZWI5gecGYCz+j3r
         87u9/Knq7rrWNMOhrEkzL0LwuUeLGrMFjJuEccoGjEV9zEuIE4IRZnvh6zUiLO9ugXeF
         GUCB2CjA+PQ61XojjibOw8XLxJpaWdNgGNAVov4i9s4sn+cml/f4mMp5ofQEJg4LuW01
         wkx/o929kwfiO+vi/qjbYhoJcjbfh4dwTl6e3eW8QGNUDPUxllexcSYzQF28a1Ukj3IZ
         h6mwnk7ufwRwgBrEeC2kLZBBOdA9hByJw+nKXGFdMIjaYolV1RGKsBcMkXQ5yf+H+B/k
         /QUA==
X-Gm-Message-State: AOAM531N0qRUuzeMsMeDwoQ8iNcaBaDJEYjX9tXmay+Kv4wKyMpCzYPl
        fO8FnvFuTqyJ+5De6XEKSDiyAJS4NnWaI5/MMfAp8A==
X-Google-Smtp-Source: ABdhPJybPcEZ/Uc2pjQ/Pot5Bu/AWSlrkkKli5p3yYDQa2Q+8qdoEZ6ydt1owgyaEmIRgkW/fdP9HLTgWRAV6Jx6RxU=
X-Received: by 2002:ac2:47e6:: with SMTP id b6mr3824704lfp.649.1622159506776;
 Thu, 27 May 2021 16:51:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210527005455.25758-1-steven_lee@aspeedtech.com> <20210527005455.25758-2-steven_lee@aspeedtech.com>
In-Reply-To: <20210527005455.25758-2-steven_lee@aspeedtech.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 28 May 2021 01:51:35 +0200
Message-ID: <CACRpkdZFcFuT9rdrc8BfEBmhy0--9uLMSJWfr=A+nU117_BT8A@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: aspeed-sgpio: Convert txt bindings to yaml.
To:     Steven Lee <steven_lee@aspeedtech.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-aspeed@lists.ozlabs.org>,
        open list <linux-kernel@vger.kernel.org>,
        Hongwei Zhang <Hongweiz@ami.com>,
        Ryan Chen <ryan_chen@aspeedtech.com>,
        Billy Tsai <billy_tsai@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 2:55 AM Steven Lee <steven_lee@aspeedtech.com> wrote:

> SGPIO bindings should be converted as yaml format.
> In addition to the file conversion, a new property max-ngpios is
> added in the yaml file as well.
> The new property is required by the enhanced sgpio driver for
> making the configuration of the max number of gpio pins more flexible.
>
> Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
(...)
> +  max-ngpios:
> +    description:
> +      represents the number of actual hardware-supported GPIOs (ie,
> +      slots within the clocked serial GPIO data). Since each HW GPIO is both an
> +      input and an output, we provide max_ngpios * 2 lines on our gpiochip
> +      device. We also use it to define the split between the inputs and
> +      outputs; the inputs start at line 0, the outputs start at max_ngpios.
> +    minimum: 0
> +    maximum: 128

Why can this not be derived from the compatible value?

Normally there should be one compatible per hardware variant
of the block. And this should be aligned with that, should it not?

If this is not the case, maybe more detailed compatible strings
are needed, maybe double compatibles with compatible per
family and SoC?

Yours,
Linus Walleij
