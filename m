Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0FB839C316
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 00:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbhFDWCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 18:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbhFDWCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 18:02:33 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52600C061766
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 15:00:46 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id c11so13404209ljd.6
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 15:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J3cUQxofReVfzXAKx9OJNj8MTjPpRu0z60JXwKyp/4U=;
        b=P4xVpSmnFgkUukbaUkp1IvyEIsFhcnEdT15u+jPLp31nt3RNzK8OXdffCc1qj3xsAZ
         2qPRTCZluy2EPg/C690Yq92VxbuGhEt3kcAvXtaqeC6Vz1G3eV2Zv8Eff+zL8VFTAXJt
         Fgy2Z/1CFxs6Y9ZjtAHsyqHNl21O+93bZySEqCeSSFndsiN9bjsnL2yZMMqFBu8Px86F
         ii2+qcN074Fdxo6lV4FbNTsFS8oZopCN79yxu+oRoecq87DFmaGTdfnUlRB6zVNAWQ0N
         ruLObxLsXtgTbFojy3tcmhpZtSJMdGreTqLgmn65i2jm86kXPhiAq/9uQfutbyV3OkYB
         Wp/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J3cUQxofReVfzXAKx9OJNj8MTjPpRu0z60JXwKyp/4U=;
        b=p0FiyKITUQb9+62PeQGQDbpdM1h8rIL3UuOaFE8P+2QjEVQ4ax6KYEaF1Ykyoj1hKL
         ln6lZoBBgEGPYclaztd5+Fy1KzqD/1t7PQQuSESteenIo7fcVIMIYkeiwwyf4vGf08cO
         mwIKcBU/H7Z5fjB/OxrqxyV29wB52k0p2lRh7e9UhPIHRTvlEt7ApbRbB8zqskO9qr/g
         wBUpG3//fScTA+iIwB3KQElDSrHW7BJKvkpYXnIkhBXvZvknB7bHHZEu1P5XwzCR653q
         TX954Q+mT8rJPEef1D+ko2UJsduwsluCarD/+IEMwmJIwiPN1Atn6N4v6AN82Xo8mIpE
         hYMg==
X-Gm-Message-State: AOAM5308EVL/GpXIg8wGYp8VXgBOexaqBHJEY3n+cdv23slM6doGYo/X
        EP+LNJGPs6F3tlZjSPrjm2cyWbsVc9lIfQXzJ4f080Lgkfg=
X-Google-Smtp-Source: ABdhPJzA+eEseEIOeM7ox8//dtfVJ/jk/IvXotEGWlUh8YepldC1Hn82qb7pfwZITeiMigq7HnI6XHobL6dPCo2i+Y4=
X-Received: by 2002:a2e:90c7:: with SMTP id o7mr5008239ljg.368.1622844044656;
 Fri, 04 Jun 2021 15:00:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210604110406.11006-1-michael@walle.cc>
In-Reply-To: <20210604110406.11006-1-michael@walle.cc>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 5 Jun 2021 00:00:33 +0200
Message-ID: <CACRpkdZEytf1WJa4JNJy6o3CBqOJAZLb-D=_rGQb+naH=TKmZA@mail.gmail.com>
Subject: Re: [PATCH] gpio: regmap: move drvdata to config data
To:     Michael Walle <michael@walle.cc>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 4, 2021 at 1:04 PM Michael Walle <michael@walle.cc> wrote:

> Drop gpio_regmap_set_drvdata() and instead add it to the configuration
> data passed to gpio_regmap_register().
>
> gpio_regmap_set_drvdata() can't really be used in a race free way. This
> is because the gpio_regmap object which is needed by _set_drvdata() is
> returned by gpio_regmap_register(). On the other hand, the callbacks
> which use the drvdata might already be called right after the
> gpiochip_add() call in gpio_regmap_register(). Therefore, we have to
> provide the drvdata early before we call gpiochip_add().
>
> Reported-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> Signed-off-by: Michael Walle <michael@walle.cc>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

> Btw, I'm not sure how to handle this "was part of another patch by another
> author" thing. Should I leave the Sob and just add mine?

Ideally just stack Sign-offs it is called the "delivery path".

Yours,
Linus Walleij
