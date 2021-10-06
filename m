Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3954423F58
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 15:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238905AbhJFNdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 09:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239006AbhJFNdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 09:33:07 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22B9C061753
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 06:31:14 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id 64so1754464uab.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 06:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IVKf8Genafin95Q2Di2z6fbGCVMHXhleTRmZr5HVl28=;
        b=H0kQmGBsGcwDkt5hQt5X8QgbEs7mcB/HT7Ds17Xv8F/K0xyixce4X/dm0T7SHIfdYM
         3mAvpLtrnNhP6GivySCKypOSdGeDl1PTc4EHBTjlrYP8lOWZ8k+OjDncfwM+D1hePrXD
         //GrbK03hPtCTL7AHUdNhPOb73MAlJoUHAlxkPrdeGM9wz0wWcvJg0j/x4bxBbZt30IN
         WTsPSCsPARs9DTDmjObNjJuMvitiUsnUGR6YvAhcje2/eQS9+imw7UefTHBRxgdAKdQ9
         4Np9SxfjyrZk7AIH6Er7+LNn6wawojcklD4JogoG3HraPQeoSg399LoNWAp3vsk/XrUp
         ciUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IVKf8Genafin95Q2Di2z6fbGCVMHXhleTRmZr5HVl28=;
        b=q28zy065nWrqCI/vqwoyGCR0Er+HIiXEq4kGYcYTHMz+pgG/UE1TNm3pqw9XbWb/Rb
         vlbwv9uEXUPGRmD3D+hGJ7eGc/8MDaWCJIlGH7CtNsZH+0lJGc6nVpP5PNCQtRIzO8Ey
         3ZDN3M+tXatSOJRhHbFwUeHIoX+eMHYMr0vg6s4I5EZ13WTCM9Oi9PJPOIttxd7WHdc0
         9vVIFcW1JQ6EFUOEQXzCYRyELz4zgvb3ItWmW6uXv166Vz8FrjYKvIl5SbNkeuqUP4MM
         m3yJQ5oM4WU22jV6eOGGGgLrduUVkBwSpvOt+jYjckVFiL5/B1k4JZtDvJ9mKlQQvHIp
         Zz1A==
X-Gm-Message-State: AOAM532pjjKIouM8PqLYRKM7O8M7ju/GxBl/DbjbL356VuHOmaej3COc
        x83EreNooMFGL9OV6QjL3iBcmWIZSKZpj+GlZ9goqQ==
X-Google-Smtp-Source: ABdhPJzZOAo9G31czsBxb4fU+8I6tAGDuMwhRn5OzKvHiUr5u8U+cXOG8wNIya5MSF1bKpSXTROUHhpYctvd/VR1i/k=
X-Received: by 2002:ab0:3b12:: with SMTP id n18mr5625901uaw.9.1633527073899;
 Wed, 06 Oct 2021 06:31:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210914155607.14122-1-semen.protsenko@linaro.org>
 <20210914155607.14122-5-semen.protsenko@linaro.org> <96e5587e-aca7-248e-6448-8edfc70784b7@gmail.com>
 <CAPLW+4mEeh8Fo8kGHx+rB7nX7bDfaQRPGDotgPLTp4pm4rC0Cg@mail.gmail.com> <77d976c3-a0b4-294f-d49a-8fd46b112a28@canonical.com>
In-Reply-To: <77d976c3-a0b4-294f-d49a-8fd46b112a28@canonical.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Wed, 6 Oct 2021 16:31:02 +0300
Message-ID: <CAPLW+4m0yyk+E5GqYxfzXHxq1vKBoX3Mfc+6F6J_UXAfZ5s2Bg@mail.gmail.com>
Subject: Re: [PATCH 4/6] dt-bindings: clock: Add bindings definitions for
 Exynos850 CMU
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Chanwoo Choi <cwchoi00@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Ryu Euiyoul <ryu.real@samsung.com>,
        Tom Gall <tom.gall@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Oct 2021 at 13:49, Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> On 05/10/2021 12:28, Sam Protsenko wrote:
> > On Wed, 15 Sept 2021 at 19:37, Chanwoo Choi <cwchoi00@gmail.com> wrote:
> >>
> >> Hi,
> >>
> >> You don't add clock ids for the all defined clocks in clk-exynos850.c.
> >> I recommend that add all clock ids for the defined clocks if possible.
> >>
> >> If you want to change the parent clock of mux or change the clock rate
> >> of div rate for some clocks, you have to touch the files as following:
> >> - include/dt-bindings/clock/exynos850.h
> >> - drivers/clk/samsung/clk-exynos850.c
> >> - exynos850 dt files
> >>
> >> If you define the clock ids for all clocks added to this patchset,
> >> you can change the parent or rate by just editing the dt files.
> >>
> >
> > Hi Chanwoo,
> >
> > I see your point. But I have intentionally omitted some clock ids,
> > which can't be / shouldn't be used by consumers in device tree.
> > Actually I took that idea from clk-exynos7.c.
> >
> > Krzysztof, Sylwester: can you please advice if all clock ids should be
> > defined, or only those that are going to be used in dts clk consumers?
> > I don't mind reworking the patch, just want to be sure which design
> > approach we want to follow.
> >
>
> I would advise to define all clock IDs, unless the clock really, really
> should not be used. Why do you think several clocks should not be used?
> Have in mind it is not only about consumers but also clock reparenting
> and assigning rates.
>

Thanks! Will be done in v2.

>
> Best regards,
> Krzysztof
