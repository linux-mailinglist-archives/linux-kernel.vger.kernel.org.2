Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F38963DBAA1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 16:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239119AbhG3Ob4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 10:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239299AbhG3Oby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 10:31:54 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B576C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 07:31:49 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id h11so12590461ljo.12
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 07:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g9e2gORjPncqut/lk+rir6sVzd/s93Oq97n1N2vAdLQ=;
        b=XGWUnR+AMlm5KbE7ohB//psgoZYeUKtPBYVg8mLRqZnYZ/LTos3O9DeFjsU1SjGYEM
         1K7YRWmmPBWy5skTMvkp7mn9GriKGGrNZ/ATdpxXlPbwYONAmwx4psjv0tmN44DLHSsS
         I6uvHTBzZKrwzWMgxf4DHmJeV11FTLFjupXkR7jRiL/G19Wh+r64t1HJrR9VI1kM0xa3
         Adeb3/+ZZJI1eKbHh12FRkORlTei2CWkMx1Zj51QhyPjPQyHwuaVWBBg87IpuAOrhw50
         ECZk00KdeT/AQvz7Oq9xJBtIc8KnKQmKQ6RAGNFEAAul7sLXmjgzx4B9mu2a8+jblkOr
         MtOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g9e2gORjPncqut/lk+rir6sVzd/s93Oq97n1N2vAdLQ=;
        b=mvrqR/UzFroBBVL1cljzhCNkRzT4BFPBBryxn7Idhd8fJ0YC3zp3pKtFgOGW20jCuT
         xdAeFf5m0ZfVN7ax6/Fwvk6B+MGgGi+3DaaCXBcYCyuXksjiKbEBvomdNWZrGKvnocf1
         pjQsjgtGzOU0maPUNDhl1GFrmq0tHTz8sl1g+v3yPi0fPRb26aDHFdhY6tb/kls/ISnk
         S95O2kyrGH2DseecYCFs9R//03hApUv95uISLyXDq0oVsP+XW9yds6N9zEOoASDOxQsU
         PmBsgR9QzIHbKBM83NgDBi1ihz7uGr+VWNMWElm+s5ge3wW804YqpXbhaNY4H5SfAFvB
         xLyg==
X-Gm-Message-State: AOAM531FOxCoP1DYh+Q2KcTBVnUiwcXvthqLtlCYL33i5Suy+dCblHfi
        OeVkpp0l8ZSsxCv3tjwL7VQlUb0p20XjyACzAEQG+g==
X-Google-Smtp-Source: ABdhPJwUi6ruX2JvFdTxX3N//7AGHOcJenoElF/S1ILL5z+OMowHXbAfQoJ32ZPpcT2tJBoucpswDQEtQOdQPOsCKaU=
X-Received: by 2002:a2e:bc14:: with SMTP id b20mr1876294ljf.200.1627655507652;
 Fri, 30 Jul 2021 07:31:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210730134552.853350-1-bert@biot.com> <20210730134552.853350-4-bert@biot.com>
In-Reply-To: <20210730134552.853350-4-bert@biot.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 30 Jul 2021 16:31:36 +0200
Message-ID: <CACRpkdYvMtE8b-Xiy6=Aiz20jvY0M0Bz9XmcEQDHhqeS+LErEA@mail.gmail.com>
Subject: Re: [PATCH 3/5] ARM: dts: Add basic support for EcoNet EN7523
To:     Bert Vermeulen <bert@biot.com>, Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        SoC Team <soc@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        John Crispin <john@phrozen.org>, Felix Fietkau <nbd@nbd.name>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paging Marc Z and Catalin just so they can see this:

On Fri, Jul 30, 2021 at 3:49 PM Bert Vermeulen <bert@biot.com> wrote:

> From: John Crispin <john@phrozen.org>
>
> Add basic support for EcoNet EN7523, enough for booting to console.
>
> The UART is basically 8250-compatible, except for the clock selection.
> A clock-frequency value is synthesized to get this to run at 115200 bps.
>
> Signed-off-by: John Crispin <john@phrozen.org>
> Signed-off-by: Bert Vermeulen <bert@biot.com>
(...)
> +       gic: interrupt-controller@09000000 {
> +               compatible = "arm,gic-v3";
> +               interrupt-controller;
> +               #interrupt-cells = <3>;
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               reg = <0x09000000 0x20000>,
> +                         <0x09080000 0x80000>;
> +               interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_LOW>;
> +
> +               its: gic-its@09020000 {
> +                       compatible = "arm,gic-v3-its";
> +                       msi-controller;
> +                       #msi-cell = <1>;
> +                       reg = <0x090200000 0x20000>;
> +               };
> +       };

Yup GICv3 on ARM32-only silicon.

> +       timer {
> +               compatible = "arm,armv8-timer";
> +               interrupt-parent = <&gic>;
> +               interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +                            <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +                            <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +                            <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
> +               clock-frequency = <25000000>;
> +       };

Also arm,armv8-timer on ARM32-only silicon.

This is kind of a first.

Yours,
Linus Walleij
