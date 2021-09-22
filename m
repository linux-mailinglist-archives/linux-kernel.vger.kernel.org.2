Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 666F5414503
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 11:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234240AbhIVJYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 05:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233969AbhIVJYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 05:24:07 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1B3C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 02:22:37 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id t4so7179157qkb.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 02:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UPEYIPraZWFoPIQr727Ikg0kM4AavXg3AzBEv7db2eg=;
        b=YU29OBBdOuzdjfqiIbJ5gDgbs+UqJ0WpKdUZeygq4yI0a656jlukavNosRIUrIA3U7
         Sez0+XdPIKPyISUA+X6M/xOHrjJXQ7OF8fiiLis61GnYfCplrDEmS6Vk63tOLjYa2CCZ
         +QnzdasIy0bqQxg3R63DKO688gtzR3ROB6r+zmqX2mr9oR8viluhCH4gJ1MmEIXeW3uP
         AP1/bH8WlhzVLPcsrdWgNJ3h+v7kKOOhvki9Zbxgit6+T+4lRF6JGQf3pypljo6Pbe8D
         J86ZuJ6Kg302mlZuyU5/W1as4IYyX4WDQmyWGeHkwSoEJe3VGCXHrJ2hWl3UYS8TQY3G
         j5OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UPEYIPraZWFoPIQr727Ikg0kM4AavXg3AzBEv7db2eg=;
        b=RQDBT6qCQwwVwAq/rx6/x0WAUuyf2xD3LMwp5VhNfJ06y/egqLqQzZ1uf2xmns34LO
         A9nwP5c7XaJQ9zsDelGsXpuQgcbhVssDJ9l5+nEtFHY3dhhWSHVqiOhpxVYOwgyJX2gg
         u+r+lv9Ea+H6uqGm4cdtXlZNVMkUyivHMmVuYxw2KpjINStsbdI/q5aJPf1AR5fD7oJz
         3UmfqgRmbFinaXhymnGps9fxq+Rs9ns1+YRLyzbvQjS0c8CsFJpM95x3s2SmdrNTOThj
         FtMCCfL7LsvsQ5hHmHW59qmFFD1YMDe6wekc2x78OAqffrTxBPQ2mKDU10RbVHVasx3+
         rmDg==
X-Gm-Message-State: AOAM532FOb+r3zSyM0/3CsSakC9dRPHqfyCEeLRXiyOt+mhBHZP+9Grr
        SSdL/feolioUMm8Xcg6h6TkWCPAK0xLsAUvn0P9www==
X-Google-Smtp-Source: ABdhPJzJc+xR26CWASPeBTE2lyk9uRF7h8fSa0EqTXh37F/q4/w8e9DMqA4K0pQhxs00hUewDedjrjRorXA+OhOR2Yo=
X-Received: by 2002:a25:32c4:: with SMTP id y187mr36194925yby.157.1632302557010;
 Wed, 22 Sep 2021 02:22:37 -0700 (PDT)
MIME-Version: 1.0
References: <1631791177-27229-1-git-send-email-hayashi.kunihiko@socionext.com>
In-Reply-To: <1631791177-27229-1-git-send-email-hayashi.kunihiko@socionext.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 22 Sep 2021 11:22:26 +0200
Message-ID: <CAMpxmJXQGbB2Lg6hfFUOqRj=Q__tAvhNXDNX-a8ewviTpjVNoA@mail.gmail.com>
Subject: Re: [PATCH 0/3] gpio: uniphier: Misc fixes
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021 at 1:19 PM Kunihiko Hayashi
<hayashi.kunihiko@socionext.com> wrote:
>
> This patch series includes fixes and changes for UniPhier GPIO driver.
>
> Patch 1 is to remove the return value of each function according to
> the return type of irq_chip callback functions.
>
> Patch 2 is to replace direct access to IRQ hardware number with
> helper functions.
>
> Patch 3 is to replace direct access to private data from IRQ data
> with helper functions.
>
> Kunihiko Hayashi (3):
>   gpio: uniphier: Fix void functions to remove return value
>   gpio: uniphier: Use helper function to get IRQ hardware number
>   gpio: uniphier: Use helper functions to get private data from IRQ data
>
>  drivers/gpio/gpio-uniphier.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
>
> --
> 2.7.4
>

All three applied. Thanks!

Bartosz
