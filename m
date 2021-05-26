Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B58F63922E3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 00:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234641AbhEZWsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 18:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234099AbhEZWs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 18:48:29 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B36C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 15:46:56 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id a5so4253731lfm.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 15:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gh6D0NmIuyBi9REXwAXFztqizN+UX22Sn24ASBHof08=;
        b=RFpfi51XYUTh4MvV3R5Rf5owzqAC2vrcks9E7IOUfBd9gRw34msYfBl503zc5r/YHg
         9u4wCA+i9E1Lx6FfC/a7m02x0mzD/fvkTN1Z9ZxFsnBZq+kiWoqrjVKOS95NgDJKjAya
         ISaFVPtioEikoHd+xVWcLLpsGJUGmJUoThYY5dlqM24dRpef7Pz2D3naNbhSeC2jOeWw
         VdwSg8PyXurJHDyhzkgVNnXC+sWJIPokokEhAFa9qwsqu+fqK/K8d58fNgMX+a/nn6p3
         RXfzf5aZXdPgH8cKAQJ+dBdlajGQ/EEyIg3phuR/vUAL2+7vfQd8C9INrFjCOjl9dCq0
         Vw8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gh6D0NmIuyBi9REXwAXFztqizN+UX22Sn24ASBHof08=;
        b=kPEiKiEw0bEPKJRuZpJnUrU6JYN7QBowhibE+MXQwu0+9H3g9hrpsC2GX7Rk7B2tTj
         tCscgSHjiST95Ig2KlSSEsmRRCw6wBS7EwZlq0f5WK8ZpHKidq+kOrVjRZv8rGzNlKq7
         j1XWo1cJFbLIfZM4KXJ0L/yoK2N02Wo3H+hV6nlpyXMV/o30wr+GSdtkWxZq4TqYPUIT
         yaAAGrDrtrPbRn9rBRtROZGxjWaUG46Sdq4KLLFvNjKGqFVh93OYJRkysKs2G5Aguas4
         vMbLEIFCGcZn0rm8V3WQvYIyt8AmEUqAJWzalHhOTza0WpkZxsfKKBLs8i2ZFoo+5avj
         d3LA==
X-Gm-Message-State: AOAM531DM4kI0WeWiMqMOS4wVSf/y4mVSVOr6ifwKMJzaX8skr+igEUt
        EppeDXlLItWGfMi5iB4VLnKu7RxDDyxs5e585+wnGQ==
X-Google-Smtp-Source: ABdhPJzhE84v8PWYX99hs+I7PILyvcwxc9Kvwqp7WHkVupAuNHV563yAdHvVtLSjZUdEehwrlOErcf5oG0if7UNv0OY=
X-Received: by 2002:a05:6512:11ea:: with SMTP id p10mr237601lfs.157.1622069214022;
 Wed, 26 May 2021 15:46:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1622008846.git.matti.vaittinen@fi.rohmeurope.com>
In-Reply-To: <cover.1622008846.git.matti.vaittinen@fi.rohmeurope.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 27 May 2021 00:46:42 +0200
Message-ID: <CACRpkdaSr_CV1pKS44Ru15AEJ0-1429+6E7Lei2sPHdaijr9iw@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] gpio: gpio-regmap: Support few custom operations
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Michael Walle <michael@walle.cc>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-power@fi.rohmeurope.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 8:02 AM Matti Vaittinen
<matti.vaittinen@fi.rohmeurope.com> wrote:

> Support providing some IC specific operations at gpio_regmap registration.

I see there is some discussion around the abstractions here.

I can only say how we designed gpio-mmio.c (CONFIG_GPIO_GENERIC).

It was designed for GPIO controllers with 8, 16 or 32 bits of GPIO,
each stuffed in a consecutive bit in a set of registers. We later
amended it to deal with bigendian as well, and 64 bit registers,
and some quirks around the registers (like just readable etc).

But that's it. For anything more complex we have opted for
users to write their own drivers with elaborate code.

As library it can sometimes be combined with an irqchip,
if the interrupts are simple.

But overall: each GPIO needs to be a single bit, not 2 not 3
not in every 7th register etc.

I would not try to turn gpio regmap into a Rube Goldberg Machine
panacea-fit-all for all kinds of register and bit layouts, it's nice to
be able to combine it with an interrupt chip or pin controller if those
functions are also simple, like the set/get registers.

Any too bold ambitions will be hard to maintain, I think.

Yours,
Linus Walleij
