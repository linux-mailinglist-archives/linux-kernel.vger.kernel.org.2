Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C39A533696F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 02:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbhCKBJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 20:09:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhCKBJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 20:09:33 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE58C061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 17:09:32 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id p21so36832658lfu.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 17:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XuZRJd14e7XnEoXw2FvIl72vWJHeOPCk4LBUHOIGczA=;
        b=w+Gf8sHgPrzzhqz1HDYJflI7xmJglobU58eZtpd7AIWhyj2gyDoKLtH94j+T6xthFx
         +O73aHhgamMWP/v0AO1NrOSTxnNUqQERm1NzjmCJIzimyWqg9sM5SshUlFbI4DZ91aaP
         9+jzRtcDTEu50u57NBjz0aFYrHW2pHUVcHv7wgW2c4Snn/fcauvNXHhb+hdM9q7nL6hO
         gHmJgSB+62knF6gFYGvc2kgrxN1dWXl3PPpshRvmqr+Bkj0BWAnvY/psiEfRo9iCYsFW
         M5TJRWj/zFJAifR8lInrO3eWQgxWehiWEvBqGi0Eh9ZsbEwqbd/Jx3FRKjlWsy6HCCmy
         3b3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XuZRJd14e7XnEoXw2FvIl72vWJHeOPCk4LBUHOIGczA=;
        b=XZgCkKWqv2oQehDh/A8Lt+KVDqpKgSqhcqK6QeW73UesSLTqR1EHG1qadBc6xRRJ2w
         H1pUq4GxDL2AbzebSdYKZPl2+3b00fb60eftlM/tUhMz02yh5qPjLLHdrGN95WYP/Zpg
         gued9x9PbMcxSBBEcN56QXtgjGlxExZZYJGGaPgoDuDaPgG91mtZavcnUGLmgdk1v2qO
         ZP2Nsb0MJhjbnTa00gfMJ1P+8IYeHQJkaX3D7jZoYCbKedw6RfgSx9MxnbzZbOu3l8jp
         1twUCPju6rqQJjeRg6MOIejs88OYHnu5gRmNbDv+GIXu7x8uDWiWLWjAnsuMKTQfK5MO
         uxJw==
X-Gm-Message-State: AOAM53152LmR5CYEifE5AIMUyB086p69wQ7sqr6/HzfTvfBP0q6nfeFe
        c2x8jwlN/5LvqqjlBRReKjPHdaQXERFfOIH26ByfnA==
X-Google-Smtp-Source: ABdhPJw+RZShrvljbVrt0dyiUUfDf24RT7ZzofmR3YJEiJ8U1WGH/BJf9C0pZcsXzUYriou3jqDHevyOELEC3IpUH2M=
X-Received: by 2002:a19:548:: with SMTP id 69mr717784lff.465.1615424970951;
 Wed, 10 Mar 2021 17:09:30 -0800 (PST)
MIME-Version: 1.0
References: <20210310125504.31886-1-noltari@gmail.com> <20210310125504.31886-4-noltari@gmail.com>
 <CAL_JsqKZA-j2iXvVTXWtiuyKPOWeOUP0r+x-bV6QP6=_moy2VA@mail.gmail.com>
In-Reply-To: <CAL_JsqKZA-j2iXvVTXWtiuyKPOWeOUP0r+x-bV6QP6=_moy2VA@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 11 Mar 2021 02:09:20 +0100
Message-ID: <CACRpkda=isBSW8BwYJ2pCaPcByRoo2GFNVoZCxhaCbEKk9iNsg@mail.gmail.com>
Subject: Re: [PATCH v6 03/15] pinctrl: bcm: add bcm63xx base code
To:     Rob Herring <robh+dt@kernel.org>
Cc:     =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>,
        Michael Walle <michael@walle.cc>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 6:51 PM Rob Herring <robh+dt@kernel.org> wrote:

> > +static const struct of_device_id bcm63xx_gpio_of_match[] = {
> > +       { .compatible = "brcm,bcm6318-gpio", },
> > +       { .compatible = "brcm,bcm6328-gpio", },
> > +       { .compatible = "brcm,bcm6358-gpio", },
> > +       { .compatible = "brcm,bcm6362-gpio", },
> > +       { .compatible = "brcm,bcm6368-gpio", },
> > +       { .compatible = "brcm,bcm63268-gpio", },
>
> All these would be moved to gpio-mmio.c (or maybe that can have a
> fallback compatible?).

This is gpio-regmap.c and it can only be used as a library
by a certain driver. gpio-mmio.c can be used stand-alone
for certain really simple hardware (though most use that
as a library as well).

Yours,
Linus Walleij
