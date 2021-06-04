Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB6C39BFF4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 20:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbhFDS5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 14:57:38 -0400
Received: from mail-yb1-f174.google.com ([209.85.219.174]:38405 "EHLO
        mail-yb1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbhFDS5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 14:57:36 -0400
Received: by mail-yb1-f174.google.com with SMTP id m9so8596244ybo.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 11:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EKyhuzHwzLRrsOJLNCzAwhtq44OpkP3F8fch2+BlTSA=;
        b=TQp4ocbjX84LdSjsQl5AnJhU2UlRhFc06S/cXRpXXxU7AK65AfTqzM3DdMZH78EFsF
         VXJ3D1tMkSoRIVCm1AuAxAt9F6GUPNgduGuf+L4yQ5MBxMKxDop+BdeBFuvQWmn/mb8P
         IcAGrrE4D7HX/BFesh9FlY35m/nTrPWT3H8pwM3xx9vnjb2XqyLeZwwu4KYNcHFF/QBn
         Mxeio1luTMv5eBBK2lOqoyBWhI1cSBSDA0cuvT34JfK66RhHDC53XQ+9hKMR+O7uIsOZ
         DMKoZp+kzNIxH2aR0SFGBXaYKDZ6/v7Q82WHtdN/kX7b5NGDcPrOo+cH9NyNH/nP3QgJ
         NkTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EKyhuzHwzLRrsOJLNCzAwhtq44OpkP3F8fch2+BlTSA=;
        b=JO7BK/cV1T9JjAXs2r0EAp8CX/pqcOijgJ6LJ6lXqPbw22xTWPLLMmuhugDUvqLOWs
         s9DQ7gUPfg3BPuYWN2x61QiipYLDxyFVaQ3X1tkMp7AgPMLmWYfYvmPjFoDkE7DZZdSX
         w/YDYygYZGWRItD85H9ewDHf1thYZFTk4PFYJYzO1Y8pktQ4I7Lb2DDD3wozPIvFzhud
         xU2TWE12iab7uejDhJ0yl1ZJ3wo7HAa0vCVvbWhJC780wF4WqI9liEGojdVoJgh2rhIY
         UYeTfJwQWPyyo78HA8zD6QXrQsJ7YpvtrRigZKl2H2I4pNxlXWwx+8Lc8YPClkh9vzY4
         rfJw==
X-Gm-Message-State: AOAM532eDfCoJlZ1D28LZKMySBbkPRDmSLs/wc6jB45RZq0tylaLELgW
        xWJctW+q9fhPkndC2ULDnjuOKztvO8H9Wrykq4ieog==
X-Google-Smtp-Source: ABdhPJznQHoiBwcSy902kPnq6wK4bVbknjCmxX3xB3mYjEePUTnONNbF2234aKtQEMeFDNSwC1bDs/oZO0E4pMSfsAc=
X-Received: by 2002:a25:1ec2:: with SMTP id e185mr7273076ybe.23.1622832889743;
 Fri, 04 Jun 2021 11:54:49 -0700 (PDT)
MIME-Version: 1.0
References: <b0a7e849dbf7e92d2e32d8c751d87382b06f6547.1622714114.git.matti.vaittinen@fi.rohmeurope.com>
In-Reply-To: <b0a7e849dbf7e92d2e32d8c751d87382b06f6547.1622714114.git.matti.vaittinen@fi.rohmeurope.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Fri, 4 Jun 2021 20:54:39 +0200
Message-ID: <CAMpxmJVX-PWBvubfKdcVYgCxoN8Xp8QjB33fSDA0Wg-xecp95Q@mail.gmail.com>
Subject: Re: [PATCH] gpio: gpio-regmap: Use devm_add_action_or_reset()
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Michael Walle <michael@walle.cc>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 3, 2021 at 12:00 PM Matti Vaittinen
<matti.vaittinen@fi.rohmeurope.com> wrote:
>
> Slightly simplify the devm_gpio_regmap_register() by using the
> devm_add_action_or_reset().
>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Reviewed-by: Michael Walle <michael@walle.cc>
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---

Applied, thanks!

Bartosz
