Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 944613E93B0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 16:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbhHKOaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 10:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbhHKOaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 10:30:02 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA46BC061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 07:29:38 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id h2so4932427lji.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 07:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=byRWu4PhUCdZFFH1ZumTdX1T6Ymne+7G/GMqF1AsKeo=;
        b=TQ0+K8Q208fCgyW6b+ydqb4ei0swe653pxt/8T4zbPvt81Ga4ieUhFvLjVoMmO3PeG
         stZUDSJ9OwFw3PViTYGAtIIa3bQ7aMSN8GzbJr5s8GGl4y82H95drSpKNn8bL0+YzSNS
         3L8WI8PbfzJVxsEWLlhwIx9KtZhs1hzZGHO02Q3LWWVXiqqAROaas3FaU67Pb4Q+NO6r
         t/5mGIjByjqIf2rxGMuYnGQ2fXq13F2V3J8iXwSwuPRQ5CZNFBYUXiNvcBP6pBY4O7vw
         Z6Ya2E81bbkVRnDFD+gfrsfGDqVT/Wlmi7Dc/iFQQZ46MXP+VFlJqhyUDYYF5LymDeUG
         9iOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=byRWu4PhUCdZFFH1ZumTdX1T6Ymne+7G/GMqF1AsKeo=;
        b=gg0fiGAG2nBOOK4igo0hNwj6QtaX6AdHQTbJqrLQFjyfdd+o4VHhDsak6nzqgO5gKB
         nDddfmbk+X1x08IXZXVOcnx+gt7StjxLlHq4blFT6+CUJ+W4HPyrLbculPSxFu3RrUeL
         M2TiRzuMGkK+UFRocFa/w+TFr21gyuMrZ9uUJL4/bv3Azx9+76pEc5QbvlAcX9V53Jk4
         q35tY3vOVkVHnUrk94X6BuBAvelYFxoFqr9jw7umVySte+FgYw4IFIDd4MDylyMHhzEY
         US3ya4bYe9zsqy/rmCWS0R7OIlJpl++s3qL/U+lkmZOt4uy2nm8j2Mx1VfLfzNTQmtsz
         6i1A==
X-Gm-Message-State: AOAM530ZAejabkUAXxS5KI3jlaFzd1Ad7gzPRqiATguRU9LYjNrdFK+Z
        9BI0c2oiif2qgI7AyF6DNlbfimLz+mQuT07fkPImiw==
X-Google-Smtp-Source: ABdhPJxBdYcghpunD657bOZ7806ZT+wcnJ7txkGAZ2F/bbA56xhlBP0tdZ7GGVTtpq3wji6h+fPbaw8uQmVTjYxu5ic=
X-Received: by 2002:a2e:a231:: with SMTP id i17mr13033001ljm.467.1628692177306;
 Wed, 11 Aug 2021 07:29:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210728041253.15382-1-sergio.paracuellos@gmail.com>
 <CAMpxmJUnXpOhvaQuNPbFt3TY363vrsEWV1KXxhyBm7cJ-PWvwQ@mail.gmail.com>
 <CACRpkdbHzdCnHB8358Wi6zojMhfi5urhdm2XOiPmhph7q_L1ew@mail.gmail.com> <CAMhs-H-+yiWitOkMCwmqrMAh6sLPViT0VRXz=YV_F4-vRQH6sw@mail.gmail.com>
In-Reply-To: <CAMhs-H-+yiWitOkMCwmqrMAh6sLPViT0VRXz=YV_F4-vRQH6sw@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 11 Aug 2021 16:29:25 +0200
Message-ID: <CACRpkdYsuL7pHxxy5YfRjfmTdKivnHxtSV3Xtops1qad4WGb1A@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] gpiolib: convert 'devprop_gpiochip_set_names' to
 support multiple gpiochip banks per device
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_van_Dorst?= <opensource@vdorst.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        John Thomson <git@johnthomson.fastmail.com.au>,
        NeilBrown <neil@brown.name>,
        Nicholas Mc Guire <hofrat@osadl.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2021 at 12:27 PM Sergio Paracuellos
<sergio.paracuellos@gmail.com> wrote:

> I was searching for clear patterns that were using a similar approach
> to this new stuff inside the gpio folder and I was not able to
> properly be sure which other drivers can get the same change that I
> did for mt7621 and broadcom applied... If you point me out to which
> drivers can also use this, I am ok in sending patches for all of them
> when I come back from a little rest time on August 23th.

I don't know exactly how to identify these but this is one:
pinctrl-microchip-sgpio.c

Yours,
Linus Walleij
