Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCE132C505
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376874AbhCDAS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 19:18:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392546AbhCDAO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 19:14:56 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763ADC0613DE
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 16:13:26 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id z11so40082526lfb.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 16:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OKu9rvgBil0k6tR4pYyiR6wjoHr0+cu17RpPhjhwkTc=;
        b=IpjtF+K+hruehTwmwGiSLec3MXobzKIJ30Y6ZmWQJunyXLeup+LmOCVT5Nxumb+LXq
         qIRGRRxLUv+vvqSMVM5R9D6dxubkhFTO6ayZNQiAMtwEzLbswTymeuz7Ozkv4oCczk6L
         CGKaTot0aoO4H5QxO/3lg7K/snPxuWNCpZgTFKt9efgx5VmtbYn+223I0yjuc6ElJuPU
         +NqBvtxU4Fd36vrsMJUY/djET0UEYnRbDdxCcq8eA8dcqpZvIerGhwjHFU6iNyiN/wcM
         Dfz7xc117A/msLNFmaaR9w9LEAC7eSVn0DOmpNIbhZkJuce2a4LijAnAwOJRk8s14UWG
         rKJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OKu9rvgBil0k6tR4pYyiR6wjoHr0+cu17RpPhjhwkTc=;
        b=S8P7PjSHa83jREkLphfHQi086n7jVIxFg1FYv8ItNier/DawejjYGvKMuwkyp6jC64
         +PkwWoJ7i6REG6VZ2ujr7CfqP4B3G0iNLkMI/hroOMHKjD2ls1Nm5ylop/izKy2xttZN
         5jbNQJq9R/AkFMdAS/DK1phbYdu0vXOL7i/DLOEzoGiGtc2lcyImKHQ7evGn/eifW/l6
         6SHQ/TmE0irQwUEjunOIcYU8oRNNH5Khu2LZb7JNWSmlaKfq2EgNhxE375tM7s7VNU01
         lTkp0a0sC/ITYMovOoyzCkSjDttRfbdV7UfFdFVackA0RnmJPaY2Lo5sGMzzj43dczRf
         9PWw==
X-Gm-Message-State: AOAM532KWFlknczNaqwPLTwQQfUf7INQ9qtYlz13jIFJFQWcgH2uWAn6
        I1K46wLTgrRWYFO7gjK+wlC2378/rpaCEhZfhq2WxQ==
X-Google-Smtp-Source: ABdhPJwUF1F8cAZ3I10nUfVKg6JQz8+hWV9fUNGUsjQoMGB56CK2zNgX/OcKAfDexLsxS2Tm4fxqKsRx+PeSf7Mqulg=
X-Received: by 2002:a05:6512:74a:: with SMTP id c10mr709694lfs.586.1614816804951;
 Wed, 03 Mar 2021 16:13:24 -0800 (PST)
MIME-Version: 1.0
References: <20210303142310.6371-1-noltari@gmail.com> <CACRpkdbi77SBsssMOnx43fP9RgqnzkUUw=TXaE2_LDexpE2WEg@mail.gmail.com>
 <D875EBA4-F881-4F1E-A251-78CEF8E6A40B@gmail.com>
In-Reply-To: <D875EBA4-F881-4F1E-A251-78CEF8E6A40B@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 4 Mar 2021 01:13:13 +0100
Message-ID: <CACRpkdYPMT_D=pKau1c9Df7rq9gwVGtA8ZYvPHDYU6zO-y+SgQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] pinctrl: add BCM63XX pincontrol support
To:     =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Michael Walle <michael@walle.cc>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 3, 2021 at 5:23 PM =C3=81lvaro Fern=C3=A1ndez Rojas <noltari@gm=
ail.com> wrote:

> Or maybe we could guard these lines of gpio-regmap.c with #ifdef GPIOLIB_=
IRQCHIP:
> https://github.com/torvalds/linux/blob/f69d02e37a85645aa90d18cacfff36dba3=
70f797/drivers/gpio/gpio-regmap.c#L282-L286

That's the best approach. I wasn't a big fan of this ability to insert
an external
irqdomain in the first place, so it should be as optional as possible.

Yours,
Linus Walleij
