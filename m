Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF186392C09
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 12:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236220AbhE0Knh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 06:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236103AbhE0Kng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 06:43:36 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1BEC061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 03:42:03 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id q7so7314551lfr.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 03:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J6tixj2haWZA8YgvzvNuK+R1Svh++ThjPtVzzpW8JkQ=;
        b=Al9KteHBTnIdbKGNyaxaNUxt21VFyIjbI2V6DBXkyoPffOwPmW87GXtXhJVf+FfQeY
         tL2DWNYkcKD7jrxoeRJmzxgMIk8bruiyFdBUfxD6lpKIm2ubMftlgU1xqvUyAC3LyiGK
         cLt2mxxzMGa7yHYU5z+jDRlFnz2uSx8Z4NuwhVQLt/C/lbaJqwDqZNQzDRT9Xn7y9m32
         3ANpa8K+mZdZUunziGhBZo9MHhTdkIGdWNyzsRAS+CcShA3bUYXiR1z+eBHotYvfw0q4
         G1Ha30jnT7Lv0fNrQVmbmkrLW1XkRY/Yw9lvGB5sZBCPozd4QP+TkWWBr+AthZ3+Re60
         t1dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J6tixj2haWZA8YgvzvNuK+R1Svh++ThjPtVzzpW8JkQ=;
        b=bjsiGJp+xrXrXBNBzcLkMIyIq210T6SJE6Y4bYAA6V5Bn2sPmm3m0dKechLKLhitFh
         C8meNT7JW2qsUDqw9wefWRrVeCdCbn7MA8Zf+lgsPuAqXFff3LQdhlfj3BVJoYn9piSc
         eXBT8/CPmNC5kwVD2ZZYqWe7nlyqbM0MRJ5uM0zQi8B7RQY6yUM/XpUPdst6FDMXMMg8
         stC4qqpnH/NoNvru38zk/MsVhIWEZRhz6DAyPopi5QQB+eYrXQTxXOguBMfAz8Jzb8QZ
         dqj7uwEXj3pEajKq35Su45NsmE7YJ/GNBC80OqwUspnLkraXyKqO0ZGHj8zSqMa7HOAn
         NlFQ==
X-Gm-Message-State: AOAM533088AlXKjsVIoox4bONKX6xL0/J8sZkiouhc1wUicJUBX0avyE
        y8QsDq4kGOo/PyIBWBM/tn7XJM8ky5Icu91Lqc+Lcw==
X-Google-Smtp-Source: ABdhPJxV09g9PPjsrK5NP4c0f/kJebqF6beE1H6f7fzA1PK2cKWAzbE+S9UW+3Fb30OfPUif97cIbA0CTFsW24T+3s0=
X-Received: by 2002:a05:6512:11ea:: with SMTP id p10mr1832688lfs.157.1622112121599;
 Thu, 27 May 2021 03:42:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210524092605.734-1-lakshmi.sowjanya.d@intel.com> <20210524092605.734-2-lakshmi.sowjanya.d@intel.com>
In-Reply-To: <20210524092605.734-2-lakshmi.sowjanya.d@intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 27 May 2021 12:41:49 +0200
Message-ID: <CACRpkdYK8sy26_HbQE0K0snFzKs=q5zqd5e2u4HWo939FKMW6g@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: Add bindings for Intel Keembay
 pinctrl driver
To:     lakshmi.sowjanya.d@intel.com
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>, tamal.saha@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lakshmi,

some more review of the bindings!

On Mon, May 24, 2021 at 11:26 AM <lakshmi.sowjanya.d@intel.com> wrote:

> +properties:
> +  compatible:
> +    const: intel,keembay-pinctrl
> +
> +  reg:
> +    maxItems: 2
> +
> +  gpio-controller: true
> +
> +  '#gpio-cells':
> +    const: 2

The code uses "num-gpios" but should be using "ngpios" which is the
standard.

> +  interrupts:
> +    description:
> +      Specifies the interrupt lines to be used by the controller.
> +    maxItems: 8

We need to figure out how these interrupt assign to GPIOs, and it is
relevant to write that already here, om the description. It is fine if the
same info is duplicated in the driver.

> +patternProperties:
> +  '^.$':
> +    type: object

Certainly these nodes can have a strict name?

Use includes for checking standard attributes:
$ref: pinmux-node.yaml#
$ref: pincfg-node.yaml#

> +    description:
> +      Child nodes can be specified to contain pin configuration information,
> +      which can then be utilized by pinctrl client devices.
> +      The following properties are supported.
> +
> +    properties:
> +      pins:
> +        description: |
> +          The name(s) of the pins to be configured in the child node.
> +          Supported pin names are "GPIO0" up to "GPIO79".
(...)
> +      bias-disable:
> +        type: boolean

Using $ref: pincfg-node.yaml# this becomes
bias-disable: true
etc.

> +      drive-strength:
> +        enum: [2, 4, 8, 12]

This needs to be specified though.

> +      slew-rate:
> +        description: |
> +         0: Fast
> +         1: Slow
> +        enum: [0, 1]

And this.

Yours,
Linus Walleij
