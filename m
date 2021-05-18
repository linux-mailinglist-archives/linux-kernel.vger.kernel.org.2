Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50F6D38825E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 23:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352615AbhERVra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 17:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352596AbhERVrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 17:47:17 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE79BC061760
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 14:45:58 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id r5so16008603lfr.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 14:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B97xKjhQ53Gl8Z8TApI8lRn046/G6g2A8NA0fZn8t+w=;
        b=gRb0hTzgC0OL1MiHCnOt1xOtZYUZ3QLk9y9JbAoVDb7uC1KybmqWPzdhZFIHx8mjr1
         ipNrmV8sPw9nouZGe4tcS0dcN/KMmdoCA/wKo+XAJDmp6pzNG8cDDIdUQO8RSHwDY8e4
         +hPIB8MK5cQUFHVFwDqWCNhz6RBaVkdAO/64LW8wulrlVYbaSryD+7I5Yf+61xmAQkv8
         xEb5EDgug1Fe3RjfwC9Y9DctJUf2qApYvFmUH4XC81w+YwPxxtB9WPss9oVbgbs7olwK
         yMOMfC7P0v+sBrnDrVAdl9a9sC/nVidjzAekZC6Ih+kkYEK0BDhPgvuOtFuzXA2Z7Ekb
         DroA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B97xKjhQ53Gl8Z8TApI8lRn046/G6g2A8NA0fZn8t+w=;
        b=FQDG0fpY+ETjsW+al9HM0zRXZm02Lk9C32/DOnk6ImpwMPrQSYDOIdBifY7kdG3Lw1
         J0nFBKWqE9CJlfVggtfm5iO7HcT+fyFfuU/UuyIoaEVuo3c2kstLi4SLyhx8RgniyEYq
         hR9arp/fCzSk0jcCDVCq73cjVbaJLx1mZJPj4ShTret9h0kSJlgF1JHIUZ2U+IVVBohe
         gTX6x/LcOOkTvrERMlX4pVeBZN5eatS6K/uYaBeex0yWp94AnslVZ/gJvzLTxrgzRXsw
         SJ9MDiEL957uH20lwi5JuSsMkP9oEg2GWCQwpAKf46QEGgX2mfI21ZM+ZDLYAMVRCBhY
         mngQ==
X-Gm-Message-State: AOAM531Q7uzdTkucmotcxgw3EccNe3GfeDzrvtiSl327UYG+diVXSW8z
        Vye/0Nrg3EfaY1mwIxytAxRnHzl9Rmk2eTNcj8NQWA==
X-Google-Smtp-Source: ABdhPJwawJZRAVzoDj+tZLYIiqlDskIlRSmtkXGxkxxxuliOaAVIz0FBDFMTgicKnWF2n/XKgfKoRIgALFP8qVIn/b8=
X-Received: by 2002:a19:b0b:: with SMTP id 11mr5489148lfl.291.1621374357316;
 Tue, 18 May 2021 14:45:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210518151655.125153-1-clabbe@baylibre.com> <20210518151655.125153-6-clabbe@baylibre.com>
In-Reply-To: <20210518151655.125153-6-clabbe@baylibre.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 18 May 2021 23:45:46 +0200
Message-ID: <CACRpkdZNLD9qf2xQrN2zi1ju4L9oexCgjVLsrtv8yZqFtZT_YQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] MAINTAINERS: add gemini crypto sl3516-ce
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Russell King <linux@armlinux.org.uk>,
        Rob Herring <robh+dt@kernel.org>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 5:17 PM Corentin Labbe <clabbe@baylibre.com> wrote:

> Add myself as maintainer of gemini sl3516-ce crypto driver.
> Add also the driver to the list of files for gemini SoC.
>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I expect this to be applied to the crypto tree with the
bindings and the driver.

Yours,
Linus Walleij
