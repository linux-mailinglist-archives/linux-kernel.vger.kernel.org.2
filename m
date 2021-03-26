Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3DB534A7E6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 14:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbhCZNOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 09:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbhCZNOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 09:14:25 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8B6C0613B1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 06:14:24 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id x21so6267623eds.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 06:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KmOPujpceCwNBwq8q46MhKQlq/vNV8oRKdM5lmTSaUY=;
        b=rvFEbOCl8LSLZytnyKzqWkcEr+KE+lxvzCPOYoASrny6KeCKHT3ZjYS7wCyM+1oAwH
         0glED00sVC4ECqCSQqjeFS59sQgLuAU+7a8mKVK1N2X6zGPqP/AwoOXTEaSZnOmZu0Gg
         r2mljKEo66AVk4gQNEv+mgPlXKintjMJBVtIU1F4PkT3EJw6T1bB8RBxpG+/4Rdv4MBh
         sTIuT5yqeftWODVBHKsaIaRPRDat4kKJsuyyJjNyNpKZ0cKoTQj4vomdWLPkq+kb/FZv
         wVMD7DcmhHH3M3CoWOdkCgotl5r7d6BtW9QOgRB4pLFvxvG53nhubG8801D4EIisco0P
         Vtqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KmOPujpceCwNBwq8q46MhKQlq/vNV8oRKdM5lmTSaUY=;
        b=KHd+D1oHbPeoHP0IQi/TaEy1n6T9A5nkz7PJOg//mq54oYFuJbH3eZh4AC9aAvKPBX
         JWNGoFiYc9Fr0vzWdw1aEJjawhKEhMXHKfiDoqf+re0Ww+tFEqqbnyFKU2phVoYq4Wps
         t6lZyxaie4jJRzpzIik0mFJvMfH3UwdLhabxoeLtIdaUxuJQqts2eCfu+t3APEYfxlx7
         hI2CDo+0jxAslkWdf4wtbCd09WpITH9BVNJiVjqWcPLWc7ygNBtgC/U3BBX5yP9MZluC
         OtHAyH/5UE4xfpzAICLFbaTUltj7WWJ2HRq6E+2grCQE4LqScEShe1EL6pZWeIDUSdSX
         XY1Q==
X-Gm-Message-State: AOAM532bsU86qNjg4PnqGEWVl4fKHgYI08Pof+NgcEbPCPvPBVIhKOBO
        zPCjoqmwagfcthQSubjy/oZLupDWJZHNu6NkfrY/Eg==
X-Google-Smtp-Source: ABdhPJzsPw0ybVJ9vSPBV1/CGr4FJVplRv3la+GUn0T+lu9wzMlLtHQYCZ+Q2QoQt4qrsbx1BvUjw/Q44M+P3iS2eTM=
X-Received: by 2002:aa7:d813:: with SMTP id v19mr15022627edq.213.1616764463432;
 Fri, 26 Mar 2021 06:14:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210324081923.20379-1-noltari@gmail.com> <20210324081923.20379-2-noltari@gmail.com>
In-Reply-To: <20210324081923.20379-2-noltari@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Fri, 26 Mar 2021 14:14:12 +0100
Message-ID: <CAMpxmJXVnKHXvvaaObTiHemxfC77u-zikPfEtprQ7qdDn9Z0cg@mail.gmail.com>
Subject: Re: [PATCH v9 01/22] gpio: guard gpiochip_irqchip_add_domain() with GPIOLIB_IRQCHIP
To:     =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Michael Walle <michael@walle.cc>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Jonas Gorski <jonas.gorski@gmail.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        linux-devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 9:19 AM =C3=81lvaro Fern=C3=A1ndez Rojas
<noltari@gmail.com> wrote:
>
> The current code doesn't check if GPIOLIB_IRQCHIP is enabled, which resul=
ts in
> a compilation error when trying to build gpio-regmap if CONFIG_GPIOLIB_IR=
QCHIP
> isn't enabled.
>
> Fixes: 6a45b0e2589f ("gpiolib: Introduce gpiochip_irqchip_add_domain()")
> Suggested-by: Michael Walle <michael@walle.cc>
> Signed-off-by: =C3=81lvaro Fern=C3=A1ndez Rojas <noltari@gmail.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Michael Walle <michael@walle.cc>
> ---

Acked-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

I suppose this will go through the pinctrl tree.

Bartosz
