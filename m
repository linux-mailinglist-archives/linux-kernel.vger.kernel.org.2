Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E30273B7622
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 18:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234028AbhF2QGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 12:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234044AbhF2QE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 12:04:57 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3EF2C061766;
        Tue, 29 Jun 2021 09:01:25 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id b2so5908281ejg.8;
        Tue, 29 Jun 2021 09:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CIUGtD1bEi8eoUbDB+wA/CgJYYMPlq0BzUAT42Y9V0k=;
        b=KY1ebxS45Not5cYkWjeUO9g0K+pOkWHpuYWwvigvSekrUgQf8B9aMyjZyvOvSIPohe
         MRDIhzcLMFUwkry7MIo+mXyWpmBOqz8524RarDKeljUscfem6vSbkYrkQn8eLVaVHTEe
         l+hyuHhMg7NikvRQBAIMmiFrVlrkFOcg57pksunjR65ClaCLLE2Ywk7dx1ATmCmTHbtw
         Dzf7yJ5mblmvsPF7e8O1tPk/wf0vpx2ItEzuLiNngc0IszwpxIAEjQVit7tT8sehjuXW
         J9Wyw+/YruoHjUJ4+/CdA7BZQE/A5nCizXlwLNMjIN1OjkX5vy1Q1cVrkYKtI50kM85e
         TM1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CIUGtD1bEi8eoUbDB+wA/CgJYYMPlq0BzUAT42Y9V0k=;
        b=IRzCS66JFsTGzljjf9KMry2cYoyF5rNYtLd0Hbm+CWlkmV/3jpPeTqvP/VEXfydy3w
         mSKXBza4cuoFMQCtwUckMM/QkQCWrGeKaknxWBP8kDXOqAQu0cJUT4wgBq8889lH5eaZ
         pwXu2qNiKv6ldsX+Nm53fbhExMc/zreSUg2nu8SpiGsTWTb2XysVSlEd4+QCJAwXRuD7
         p70sypcGUdYVfufmejjJtSUjTg4hu51Y1LV3kWusyVe22lFng18yXSX1IzRgxg2C0ztj
         IjzIjWpQ1SCXrkS3iYKmWWQDX6aHxo+Q8GKw6MEQ3JKrt0KAP6aP+IdMpY8xurF1PvEs
         kYCw==
X-Gm-Message-State: AOAM531PtoLW7hAUK4oJ6/rMLG5imN/rAHP4cQ3O9okBR1aMZ6ISASjZ
        yDdSWnQSKNkOE/A1ukbtbJpSAbutkxgvagFdyOw=
X-Google-Smtp-Source: ABdhPJwL0a8Z0qyHuDQ5nOn433fUQTT/9Adpa/RgGpa+Uk5hfcT9+hMbCvwns9mpypZMUeAd/h3HXLvSZLd9XFGOANo=
X-Received: by 2002:a17:907:2d86:: with SMTP id gt6mr611612ejc.428.1624982484212;
 Tue, 29 Jun 2021 09:01:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210629121459.6341-1-linux.amoon@gmail.com>
In-Reply-To: <20210629121459.6341-1-linux.amoon@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 29 Jun 2021 18:01:13 +0200
Message-ID: <CAFBinCA=COnsN4Cp-z0HAPgs4kqPdiKtkZkr_LDkGz68s7B7hA@mail.gmail.com>
Subject: Re: [PATCHv1] arm: dts: meson: Fix the pwm regulator supply property
 in node
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anand,

On Tue, Jun 29, 2021 at 2:15 PM Anand Moon <linux.amoon@gmail.com> wrote:
>
> On enable CONFIG_REGULATOR_DEBUG=y we observer below debug logs.
I (as non-native english speaker) suggest rewording this to:
After enabling CONFIG_REGULATOR_DEBUG=y we observe below debug logs.

> Changes help link VCCK and VDDEE pwm regulator to 5V regulator supply
> instead of dummy regulator.
>
> [    7.117140] pwm-regulator regulator-vcck: Looking up pwm-supply from device tree
> [    7.117153] pwm-regulator regulator-vcck: Looking up pwm-supply property in node /regulator-vcck failed
> [    7.117184] VCCK: supplied by regulator-dummy
> [    7.117194] regulator-dummy: could not add device link regulator.8: -ENOENT
> [    7.117266] VCCK: 860 <--> 1140 mV at 986 mV, enabled
> [    7.118498] VDDEE: will resolve supply early: pwm
> [    7.118515] pwm-regulator regulator-vddee: Looking up pwm-supply from device tree
> [    7.118526] pwm-regulator regulator-vddee: Looking up pwm-supply property in node /regulator-vddee failed
> [    7.118553] VDDEE: supplied by regulator-dummy
> [    7.118563] regulator-dummy: could not add device link regulator.9: -ENOENT
excellent catch, thanks for sending a patch!

> Fixes: 524d96083b66 ("ARM: dts: meson8b: odroidc1: add the CPU voltage regulator")
> Fixes: 8bdf38be712d ("ARM: dts: meson8b: odroidc1: add the VDDEE regulator")
>
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

For the subject:
- patches for 32-bit ARM should start with upper-case ARM
- personally I also include the board name so the git history is easier to read

My suggestion for the subject line is:
ARM: dts: meson8b: odroidc1: Fix the pwm regulator supply properties

Are you also planning to send patches for the following 32-bit SoC boards?
- arch/arm/boot/dts/meson8b-mxq.dts
- arch/arm/boot/dts/meson8b-ec100.dts


Best regards,
Martin
