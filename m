Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 224B43BFAC7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 14:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbhGHNBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 09:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbhGHNBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 09:01:02 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C7DC061574;
        Thu,  8 Jul 2021 05:58:20 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id v20so9457365eji.10;
        Thu, 08 Jul 2021 05:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6s8n9vrT87My3E6DX+6DGL/DAUdwKgYVA6j/IcbbZfE=;
        b=tO0i0726Ql5fGaRAzhNoGLJXndmFJDrVzeJ4Gs25f7K50DVpyAmO9ivg9gT3qUBewk
         ejApU9PGkHEAigwnwmwm8nxMW1SkMXxr1HTNQQ/9HAnCy6CZGtFqU5kAf6REvCtyMrU6
         q4acdbmsBpOreDu82XGOZ2tbz2EF656wFktGdkUoMGmNcU74YreoDDmtXojRIYr1IGHh
         GqsJpiOXedilvYQaZZO7OAAq4RBbG9pCk4YbvqEpkfXDRtLnGX9tu5jlNFqvLHArZmbm
         GnetzX+6VUbpF2LcK9b7g1j4V9rlhFYnYT+LKz/zRs28nc8WyHOMnEQ31g+2YbavdyaX
         1qPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6s8n9vrT87My3E6DX+6DGL/DAUdwKgYVA6j/IcbbZfE=;
        b=HZsmbTFA6qj0Tgk9X5g7QMPe/ydm/h7TD+2a3fpFPQId4aIW7LERy1DJZZyAal22H8
         c0ZrXphvPx7hIKYdpybAZUMJxhZcShVK5ot+KmHWmd/kJ3h17TZNR+dwUPDSQhdJkHEH
         pIrreoRj/RAdYjBPpQ42nsPBqtAZ+aQAz/A1i7E7MwJiFpWGZX8vBB2i1L9OUAltItWU
         4DFKxZ5SJl6fLakSX/y1pEcsdR9ZiVR50u3LdgLZ8IZ6MdD7lbPCnGpkjNrm+wdfSa8v
         optsEpCCrv5SEL6QHxmPyd74mOt5x+eGHEYp4T+21M3EGopvM51NNAEV1Ekdkt3LZOSU
         06WA==
X-Gm-Message-State: AOAM533sEnpfDgM6CH7ncLCsRdizkXO96SnonSsTG88qRnLOHoPiCul6
        svpWsZ6JGcvtsl4rlCWeaOrFtn+iuyGN0QwA0zw=
X-Google-Smtp-Source: ABdhPJwKktIYeiljgC8utUJP2pYHqZaFRVd2qAyoVyuCOGhLzFmXBPN2e0GbJXvv/Q2ls95yoXc3vbfOu3XWtZ9mQuc=
X-Received: by 2002:a17:907:2d86:: with SMTP id gt6mr30027442ejc.428.1625749098639;
 Thu, 08 Jul 2021 05:58:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210705112358.3554-1-linux.amoon@gmail.com> <20210705112358.3554-2-linux.amoon@gmail.com>
In-Reply-To: <20210705112358.3554-2-linux.amoon@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 8 Jul 2021 14:58:07 +0200
Message-ID: <CAFBinCDaiu-tuo654_UTmxb0yeqQ8YqxCC7oVxq1EU4AmQRQdA@mail.gmail.com>
Subject: Re: [PATCHv2 1/3] ARM: dts: meson8b: odroidc1: Fix the pwm regulator
 supply properties
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

On Mon, Jul 5, 2021 at 1:25 PM Anand Moon <linux.amoon@gmail.com> wrote:
>
> After enabling CONFIG_REGULATOR_DEBUG=y we observer below debug logs.
I think there's a typo here: observer -> observe
maybe Kevin or Neil can fix this up (in this and the following two
patches) while applying the patch so you don't have to re-spin a v3

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
>
> Fixes: 524d96083b66 ("ARM: dts: meson8b: odroidc1: add the CPU voltage regulator")
> Fixes: 8bdf38be712d ("ARM: dts: meson8b: odroidc1: add the VDDEE regulator")
>
> Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
