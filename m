Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82E2935190D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 19:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236643AbhDARt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 13:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234740AbhDARje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:39:34 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274A4C05BD35
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 06:08:07 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id g8so2699612lfv.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 06:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kgXD3U/DrQ9vSxCEaPsInQj0EAhn8kdogWYjyNQBOE4=;
        b=KE3cKfhcFR48eqKLC026k68pj4XXeu75rKpuzgjr/cCOeB3a2ZoW36SGUE4+5fJ2Kg
         anl1T6Ry7ODVw+cyx2r1T6RHnx5kkzvXPZPGKI/WinOkm3cxHCJYDKa47N7RMBmg7W4o
         bT5zsLP/Ud06DHmEe7NDDOvxnTDhyg1EfC+zGD+QJKaaFK6GMJr9QI5VTH7yhehh0ZRB
         8jsBc2SewYPaNHJ6kej06LXk7XfXSAiPhQfS9i2LVStwmZfSGw69eirzZd0H+DeFfmaV
         +Tj7OUgjmT6L8z/J7Ndvo0Fs7o0gWpUXH8ddz91BF+gO0bZ66D+xNFhJTvSJKD8cniuS
         5M8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kgXD3U/DrQ9vSxCEaPsInQj0EAhn8kdogWYjyNQBOE4=;
        b=umNcC+zdeTYmXNUezbGYuYMnPzTA37i1G0ytZn87A6jIkSWMr8r7XC9G0Acy3U3nUN
         /F/sd15ChugbNrjKSJy5fp45QVyXjTWcBrSMH+mjeDkIEGchZEJJNZbByihEsjdvaZW6
         UhVyhhGLChGkfgy5XcIcg2kA67+tJAqMMWEg1YDBlpIhuXHEti5R0IvZ0L6L/7t8nanr
         9OvyGfIrcUp+Q7fPq25UcblSWitTuGr+jCmcmpHLKCB8zi408ZuntyAz09fQVoDmucvZ
         xvYjpx0Ca86gMC6neIJ03EaJMrkoY73nICnv+nlxTgLdBi3Dq306XDEaXJvM/4WilKJb
         U/JA==
X-Gm-Message-State: AOAM530hCEMuG7jP3/D2CNFqvTIp4J4IUuSelRSA1D5RsOH/Tf7KkSiE
        N4a/MxVTcxn4Wez5qveuJ9dt27r5OswFvYAueyO/iVAVn/F2Cx6g
X-Google-Smtp-Source: ABdhPJzQC9jNQb6dsL7WniFLh6CGPL6/0Y6vVpiVvZ6eUfNUk61mYIzybCiFhSxh0pYAScadm4UZ9/cr5T+ZjZHLenU=
X-Received: by 2002:a05:6512:243:: with SMTP id b3mr5550624lfo.529.1617282485530;
 Thu, 01 Apr 2021 06:08:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210330085655.12615-1-wsa+renesas@sang-engineering.com> <20210330085655.12615-2-wsa+renesas@sang-engineering.com>
In-Reply-To: <20210330085655.12615-2-wsa+renesas@sang-engineering.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 1 Apr 2021 15:07:54 +0200
Message-ID: <CACRpkdbABbvxRLGhzmiQ8kTmwHsRqevvmDpfLKv-dUhEHVpF6g@mail.gmail.com>
Subject: Re: [PATCH RFC/RFT 1/1] misc: add simple logic analyzer using polling
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 10:58 AM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:

> This is a simple logic analyzer using GPIO polling. It comes with a
> script to isolate a CPU for polling. While this is definately not a
> production level analyzer, it can be a helpful first view when remote
> debugging. Read the documentation for details.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

I am a great supporter of this idea.

When we created gpiod_get_array_value() and friends, the idea
was exactly to be able to do things like this. It's a good way to
utilize the fact that several GPIO lines can often be read from a single
register read.

> +    i2c-analyzer {
> +            compatible = "gpio-logic-analyzer";
> +            probe-gpios = <&gpio6 21 GPIO_OPEN_DRAIN>, <&gpio6 4 GPIO_OPEN_DRAIN>;
> +            probe-names = "SCL", "SDA";
> +    };
> +
> +The binding documentation is in the ``misc`` folder of the Kernel binding
> +documentation.
(...)
> +++ b/Documentation/devicetree/bindings/misc/gpio-logic-analyzer.yaml

When other debugging tools for GPIO got DT bindings it was concluded that
it is possible to create bindings like this for debugging without even
specifying
any formal bindings. They are just for debugging after all.

Personally I like the bindings anyway.

> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig

I would consider housing this tool under drivers/gpio actually.
We have other funky things like gpio-sim and gpio-aggregator
so why not.

I would create a Kconfig menu with "GPIO hardware hacking tools".

But Bartosz would need to agree on that idea.

> +config GPIO_LOGIC_ANALYZER
> +       tristate "Simple GPIO logic analyzer"
> +       depends on GPIOLIB || COMPILE_TEST
> +       help

depends on EXPERT

I would say. Definitely not something for the average user.

Yours,
Linus Walleij
