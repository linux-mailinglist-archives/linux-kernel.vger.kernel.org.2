Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A55613899EA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 01:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbhESXeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 19:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbhESXeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 19:34:18 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B635EC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 16:32:56 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id z13so21638554lft.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 16:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lYA1H9yr7s1Wr5c16h/hdrAgkZtt+5bqTRMIye4dM1g=;
        b=Rodkj5cnwnEFsXy3OyNTU3ErfGxXNfGmTtzEFWuMu+B+HSkllD1EwBFreljmHj2yLe
         yJlh/zdoO8rpztTpRkLyA/9iBz6w9mQ0vdEQPU5OYIqJqdfc4cDJKJI86D39Y0K60YOF
         l7fAtyohfiD4hDQ9Xwf3LHYEy3waUoacCnyIdVgwrNa77i+dUOUNagM/E8RMEyQujF4e
         x01Ydwq664N3bhHS8ZvJ2KFFAq8v2UXL70ED/p0jCkk6iuWBZsEkxmhlnNcm8+NCrwgH
         a4/gZ7M3xbyNi0PyaocUlY/mOh8I/w9C0VA7xDJnp41+6fvTc68+68o4K5FytDmVwOZy
         pxRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lYA1H9yr7s1Wr5c16h/hdrAgkZtt+5bqTRMIye4dM1g=;
        b=tUHV9zvewyEBsDVdXvmEzXX3zo1quk/FLNKqvghpoHZPu7DSHHxMQshiWAzXkHklSx
         zXQyMYsr83OAY1YKoc6/8p2Nb1zOAXNMCcby+BH0NERQ9YFWFKn8ZoUolcZYMNOHLd/T
         eLweSWmwoFGw/6EfdKLbbSK0x+78380aY3Aes5hPP06M5bHSa/sZgRIxNTF5paCODu8W
         pNX1ShRyGwMMbA/YxX6MPVbyruHqp9WIDG+AT96YgfoNztYjwOAy/lB98lrDnh8d/ZZF
         VHdKWFr0jtBygtkpgkxJg3znYEe0jJrdwdFbUIqxJKr58ZJ23vOptNYUafSnDuYELeTj
         ngOQ==
X-Gm-Message-State: AOAM5318LiqrvbcLm7oTlVuZoJQzQG3MS6RJtNxEYdX8HbouuryxS/vf
        9dhTDw+tN45eAfS89Ut/jkjHO1OgmLA7uEww4T2k8A==
X-Google-Smtp-Source: ABdhPJzxqvOkDbyd4/b9MJuVrBisnL4C/8J72qCT/6CYcQTw+i+DNDdhZeo30goEyw0JR78B0HhV6b2tSnfdj2eASms=
X-Received: by 2002:a05:6512:49b:: with SMTP id v27mr1367660lfq.29.1621467175115;
 Wed, 19 May 2021 16:32:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210510195221.12350-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210510195221.12350-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 20 May 2021 01:32:44 +0200
Message-ID: <CACRpkdba0WdkMPdQe9VpUR9SQZdYM47TvgyO+4HA66EdV2==mg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpiolib: Drop duplicate offset check in gpiochip_is_requested()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Kent Gibson <warthog618@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 9:52 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> gpiochip_get_desc() already does the check, drop a duplicate in
> gpiochip_is_requested().
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
