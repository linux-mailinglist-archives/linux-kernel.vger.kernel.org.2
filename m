Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 526F7319F90
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 14:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbhBLNMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 08:12:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbhBLMyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 07:54:37 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED34C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 04:53:57 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id b16so11364993lji.13
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 04:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TX1H3m3VFNgBv1mAohCEhi5B6yH8CGQhBabKsIXXRuY=;
        b=H2BbUT4nDLAXlZkqeMybxmPTGGicSfUIgpUG/4UgLsZ1McUNC8osmJhxYRPoFmeZ+H
         DI0UqPfV5dwCN/aeTXK6jShgviiFHZ5PqpeH3nFkykDGPaf6r4momoN/7VnWdUP28Iwe
         uPVEPcGzsDJ1TVoxJOtTCCeyUg3ybck/rV4eNgXJPamhcjdyKUOihnW/iLw/c2w6jAxM
         cjte0Wa/Wba5Q6eKGcfx7jR6I4joYdDlhO+eAwEWxAo1S5C+Vw+v5DV5QA1ZijnRndk1
         YCscDK7X2Qn3Mj135iLL00fNFzdLRcFOKDQcqw2b7BBkwc9CUC6AJUrBNXgH1dy2Zzyc
         vf7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TX1H3m3VFNgBv1mAohCEhi5B6yH8CGQhBabKsIXXRuY=;
        b=O7G3BElFP//qzakyD6wQYUgZIDNoV5J0/Ad11pbb0YXTBKo+3aZBpNK7MhVsjy24+/
         QIBsYaflFtpqbTx4hsYDF+jZPfcg3ZQuGntIFNhjGHGXrdjaFxxzs3YlWTwwWj1avnbW
         +fSWZVm+a0Zu3aqbEYFwrzCvdqzqzZne5G/0Px2PdpDcenw0sPKFOGLMX8LRHJxoz224
         cIH+QS2yzysSia0z5GbJErt6uXZA91pU1nqhUqhgtCmBlYxOjOkch7SmovBtqSyxiuA2
         qq0HQO4bg8hiLWmwyIUCIlSpGR2VStEIOSm3os6HRd8wHoJxUurTY2Mq7N+efzMJGn06
         uXfw==
X-Gm-Message-State: AOAM533nUhbM3OtXyikrNDe0zLpUeqzTVe+IPeRMZ9bnqFKdhnPQmoc+
        Ui4BZ/54gy4RAWNkN64+gftByDt0yPBHOHwGn1yrsQ==
X-Google-Smtp-Source: ABdhPJx/L9A5DKjTlbb1y8iXidpvnM+ICUJih9eD6NbL/SDA7gU2VqlGkDajtMduqBcQ4wM+Q5GGzUjpqKoHrzS3fXg=
X-Received: by 2002:a2e:9ec3:: with SMTP id h3mr1584119ljk.200.1613134435693;
 Fri, 12 Feb 2021 04:53:55 -0800 (PST)
MIME-Version: 1.0
References: <20210208145153.422093-1-geert+renesas@glider.be>
In-Reply-To: <20210208145153.422093-1-geert+renesas@glider.be>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 12 Feb 2021 13:53:44 +0100
Message-ID: <CACRpkda898-yNgwkzA-rwgPtHRLtbaa-u9CdSnygGkye1zVd8Q@mail.gmail.com>
Subject: Re: [PATCH] gpio: GPIO_MXS should not default to y, unconditionally
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Anson Huang <Anson.Huang@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 8, 2021 at 3:51 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> Merely enabling CONFIG_COMPILE_TEST should not enable additional code.
> To fix this, restrict the automatic enabling of GPIO_MXS to ARCH_MXS,
> and ask the user in case of compile-testing.
>
> Fixes: 6876ca311bfca5d7 ("gpio: mxs: add COMPILE_TEST support for GPIO_MXS")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
