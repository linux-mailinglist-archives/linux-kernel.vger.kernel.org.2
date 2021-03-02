Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D529132A379
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378913AbhCBJGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 04:06:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382061AbhCBIsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 03:48:42 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1ECC061793
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 00:48:01 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id lr13so33670836ejb.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 00:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rZpA0b0nZ0oV8tIgjk1GgOPTpGQGWjc3SqFNlF/nAjg=;
        b=bhpW9YjLtH6WxpffPKs4ftIdB6kEzlPYvMRE4w6u4+Ms/Ybfo4fznsNNQ6IGwkIX1e
         TeTPAKgZVJ+R1PSMOdd+ehfeP8jW5rRKpVNDlDTv0Pra8HyXgVXz1CJY3EhymmTx2SHX
         AYo3glejXTHqfpzbBFtBQBh6DTEO8RWbzf9CwJq0V8NMNPuRn2zTnHOlHNlLNGXseX6x
         chYYJQgKqjiF5uHvxgJcAYb19ErSGKx86BIT5vzycz2u1wJM09USsRRIoKF5bDjM8vAQ
         kHW8FHKI6s/X2Ftl/o/NqbRaEllxGM6y708QGzRkXjN+kcUuQDhPXLCelc18klyeuZ9h
         QvuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rZpA0b0nZ0oV8tIgjk1GgOPTpGQGWjc3SqFNlF/nAjg=;
        b=MsavESn4e62HiAIIQo/GUP1NZaEgMQa/pNP0arfkn5wKVDwSTgvtd5UC/X06LSt6t+
         JOtjjl+OQy/uFBx/AWs3/e1kIq+3siE+4DHVpSw+UmvYXwr0MaFzyPcTvgHekC9+HZ0S
         EaHA/c0wUBu9tkK9ghIlzxHUNInESyApkEIo2B+wN532AjbCDoO5IYD71NQuItlR5mEN
         GP7adJlTBuaaFHSykG1T0sU0DUpVfQN7PWd7pknE7VlZB5nJD9pH7eMMD/wtUHdz0p2v
         Y7PunEaQ6s2MSsOh3T4OQq9imRoHJYq4Wl4xRaJdMDBRoJbkhvGF1ir9GEYgOSh5KR4G
         WxEg==
X-Gm-Message-State: AOAM530z1OxSPM1qZ51QE2nuYtwyVTHFTV8OmP8kxafNVWFQdoMiv9Ba
        c9Ig8BSS/gEwyKTdv19+MFzkguEm1yXG1C6XET+hlpx6oEovgQ==
X-Google-Smtp-Source: ABdhPJxaIR8R0M2MhfB9/bK+Jw1y7uV2v5sZWjHNnGAWiYXUfoQDjviHdtbcOIZjTVeYqavg7ifapNqB3HMH9XgY9Gg=
X-Received: by 2002:a17:906:2314:: with SMTP id l20mr20436562eja.178.1614674880504;
 Tue, 02 Mar 2021 00:48:00 -0800 (PST)
MIME-Version: 1.0
References: <20210215121713.57687-1-marcan@marcan.st> <20210215121713.57687-15-marcan@marcan.st>
In-Reply-To: <20210215121713.57687-15-marcan@marcan.st>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 2 Mar 2021 09:47:49 +0100
Message-ID: <CACRpkda_BdcvTamh-=O2ej+OHYVfNmRokCNJ_mJbF1Fr5Gr5wA@mail.gmail.com>
Subject: Re: [PATCH v2 14/25] dt-bindings: interrupt-controller: Add DT
 bindings for apple-aic
To:     Hector Martin <marcan@marcan.st>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Tony Lindgren <tony@atomide.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Alexander Graf <graf@amazon.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 15, 2021 at 1:18 PM Hector Martin <marcan@marcan.st> wrote:

> AIC is the Apple Interrupt Controller found on Apple ARM SoCs, such as
> the M1.
>
> Signed-off-by: Hector Martin <marcan@marcan.st>

I think this looks good and makes for readable device trees
and similar to how the GIC IRQs look so there is a
consensus.

I would maybe add an example interrupt consumer but
no big deal.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
