Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85031332BCE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 17:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbhCIQVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 11:21:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231901AbhCIQU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 11:20:59 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76EA0C061760
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 08:20:58 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id m11so21364939lji.10
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 08:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NdXOG6ljmNbXTOPX+64Dn7agKNrrC7wRclWk4pldd2Y=;
        b=bft3qeAE0HV4abBfBNN7i/Jlucff/PRs0/gz+DAi0q8jM9HDngjw5PTq70PFqJO2cU
         9COJjgpOU+cnTXssQT5aRrCnYcqOWzh4SFsKHgo0tFhj2AfNuro3Rbfe6sZywa6CJ54i
         3ol4XrTE0EXS/Ole3GKZnLAbaroDSmYj93ArmU/QxnW5Ga4KskiA2PX95g61DiRKAUcR
         fcsWvxApQyJhjLeaWVxd38KtRHMPxA9Cku6ZV7BLG19R6fP2TbCPTJHwxKcyQq0JmU5a
         oWj5up5CIec5oV6hKdbmNsC9S/A+RLYwZcCVM+OhIaVuTgYY0etUiqpo68y793Lj2oko
         FBoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NdXOG6ljmNbXTOPX+64Dn7agKNrrC7wRclWk4pldd2Y=;
        b=CggTCtVh+O88tb/+bC0dlDiMMjowt/Ti+w6CIFzqO8aY6dzC6BmAMhcGk77icOGNCU
         Y07IBYCt3CKwTte3//VxBdr13hlUUrRFV4ojRZxW9gGRQ+CaL5M5M8mxBRQ2qBxpqXRi
         g9gldaYDR+XgcTVvlWavw34j6n7xvi5GIw9X94Fi3UY4wNf5XD0K9SiuzhQWEATHTmBM
         Ml9Ix1zq+bt1EcRHKncZBpT+KYBZQIkuAiErVub5lAg0UjrQLQku2TO93B4Vs60CB4E9
         tmjwBkF+g63FavrBFWpjKbFCdrOVcD7iF0q5Dae6sBLJVua0iohoYsTs1JPYlsJ2J3Ey
         lb8w==
X-Gm-Message-State: AOAM5315qQR+GUBqft7dozkKM4/V8h1kJFBIg9tkhtb+F1TcWelGV2E4
        zpXkdMuEXO8pIzNyDYQtfiXEawuQcqKcZiH99ele5Q==
X-Google-Smtp-Source: ABdhPJyLt9jyso+VXasOTjFab8SOjODUUCl5Vd/Ei53FhkTvbc2ysPMRM+bDSgOsBF0fSf5wY0kI0Sj0kqsOhtoXu3w=
X-Received: by 2002:a2e:700a:: with SMTP id l10mr17590963ljc.368.1615306856856;
 Tue, 09 Mar 2021 08:20:56 -0800 (PST)
MIME-Version: 1.0
References: <20210304085710.7128-1-noltari@gmail.com> <20210304085710.7128-2-noltari@gmail.com>
In-Reply-To: <20210304085710.7128-2-noltari@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 9 Mar 2021 17:20:45 +0100
Message-ID: <CACRpkdZEuorg-uVS6JZwTzM0Q-gC=BXiyvkk4bV8P_GCEdgB1A@mail.gmail.com>
Subject: Re: [PATCH v4 01/15] gpio: guard gpiochip_irqchip_add_domain() with GPIOLIB_IRQCHIP
To:     =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Michael Walle <michael@walle.cc>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
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

On Thu, Mar 4, 2021 at 9:57 AM =C3=81lvaro Fern=C3=A1ndez Rojas <noltari@gm=
ail.com> wrote:

> The current code doesn't check if GPIOLIB_IRQCHIP is enabled, which resul=
ts in
> a compilation error when trying to build gpio-regmap if CONFIG_GPIOLIB_IR=
QCHIP
> isn't enabled.
>
> Fixes: 6a45b0e2589f ("gpiolib: Introduce gpiochip_irqchip_add_domain()")
> Signed-off-by: =C3=81lvaro Fern=C3=A1ndez Rojas <noltari@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
