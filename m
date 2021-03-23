Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 168B3345A66
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 10:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbhCWJIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 05:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbhCWJIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 05:08:14 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CCFC061763
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 02:08:13 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id f16so24667409ljm.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 02:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GU8+KGx7zWyRaueXU2MKMvxj0PmLdKNF03uRpvzX5IM=;
        b=ykIoGA5o+ESPVHYneiLpbYO1VKyj9FzlBgd1tWwMY8nGitgvbjNADm+6Sxb8uGcLrA
         X/IRJoCgQoxMQeibf0C6rlhtUhSPvXtIOkvGLbrHZ4WfhmjPTc/Ea/Aqt26SJEMHIlGJ
         A2N9YXKhGqxKxrV/t7Gzy/gJXTH5o5mM4yCPWImzOXdEF9JuF4YidQ+ldhnzMONndTGa
         KvijCTWwZ7QmSMvCWmMt448XhuV3vSXfh480RkJtIgWabKc8vqVYtPVdI4BZktXvhlSC
         sQJIwxgZOPMshTw/eNd6LWMc3eonmtWRuVPxIdvM9dDkswnZgqNkwnMiE/NK8Q8Td63C
         kibA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GU8+KGx7zWyRaueXU2MKMvxj0PmLdKNF03uRpvzX5IM=;
        b=aWmcUDp3bNQMZwI/A1IHKUbvMYGmsGMYFXigXGN7JcQKN4VyUGm5LzHnUe1L1xyQ3W
         tIZyyZ+E1R1PLKsgqXBR/NN+VwhxyB+2zlNpTQ9d67NmRkd5R9t5pGeKvdk08bXvrHOk
         p0Q4/a/Ypmcvov1lw8pShSKAFBvEdbfr8FPIpkqYY8pygHsrCrdA5yGZTWuK8p+ej85P
         /s+z1X4PIrendxrNE4IBzJIQ/ehzkIzTYLJLeEiK7S5UHNerwkGM3clAfji6L7Z6dyGt
         6lIxj+cjopMoMKM2ig9XmL3CJEEAUTkqdSw+gmkhsHe8S5DCGycpNxlA1W0/DneOsHPa
         gcig==
X-Gm-Message-State: AOAM532dOuFxzLpEQ/3fzeiFGwtguXk216u26jtmF/Mb8IHGJSSgGE/G
        9pfukHy0gme6gCbVN64X4TTSJqJKWdXgjXUyc7IX/A==
X-Google-Smtp-Source: ABdhPJweyePrKoSgpVunhp5/2Fb9EHr6FazdiSlQ2mVqyflF8O5bVu/9/byx7auFHJl/beHF5YqRbfS6TlP72yvvaZ8=
X-Received: by 2002:a2e:700a:: with SMTP id l10mr2520383ljc.368.1616490491953;
 Tue, 23 Mar 2021 02:08:11 -0700 (PDT)
MIME-Version: 1.0
References: <4c46726d-fa35-1a95-4295-bca37c8b6fe3@nvidia.com>
 <CACRpkdbmqww6UQ8CFYo=+bCtVYBJwjMxVixc4vS6D3B+dUHScw@mail.gmail.com>
 <20210322060047.GA226745@sol> <d48fa7b5-8c17-c3d7-10a9-a9811c410a39@nvidia.com>
In-Reply-To: <d48fa7b5-8c17-c3d7-10a9-a9811c410a39@nvidia.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 23 Mar 2021 10:08:00 +0100
Message-ID: <CACRpkdbkmwuAJzD-CpWKqmL3_n1xkvv_2M_DsNs+ZquiaRkKgA@mail.gmail.com>
Subject: Re: GTE - The hardware timestamping engine
To:     Dipen Patel <dipenp@nvidia.com>
Cc:     Kent Gibson <warthog618@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Richard Cochran <richardcochran@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 9:17 PM Dipen Patel <dipenp@nvidia.com> wrote:

> My follow-up concerns on both Linus's and Kent's feedback:
>
> 1.  Please correct me if I am wrong, lineevent in the gpiolib* is only
>     serves the userspace clients.
> 1.a What about kernel drivers wanting to use this feature for monitoring its
>     GPIO lines, see gyroscope example somewhere below. In that regards,
>     lineevent implementation is not sufficient.
> 1.b Are you also implying to extend lineevent implementation to kernel
>     drivers?

I was talking about lineevent because you mentioned things like
motors and robotics, and those things are traditionally not run in
kernelspace because they are not generic hardware that fit in the
kernel subsystems.

Normally industrial automatic control tasks are run in a userspace
thread with some realtime priority.

As Kent says, in-kernel events are exclusively using IRQ as
mechanism, and should be modeled as IRQs. Then the question
is how you join the timestamp with the IRQ. GPIO chips are
just some kind of irqchip in this regard, we reuse the irqchip
infrastructure in the kernel for all GPIO drivers that generate
"events" in response to state transitions on digital lines.

> >> And certainly you will also want to use this timestamp for
> >> IIO devices? If it is just GPIOs and IRQs today, it will be
> >> gyroscopes and accelerometers tomorrow, am I right?
> >>
>
> Gyroscope, accelerometers or any IIO are built on top of i2c/spi and/or GPIOs.
> So they are covered as long as they serve as client to GTE framework, For
> example, if gyroscope uses GPIO as an interrupt to indicate frame
> ready, GTE could timestamp that GPIO as well any IRQs like i2c transaction
> complete IRQ. To this to happen, gycroscope then register itself with
> GTE framework and enable required signals that it interfaces/interested with.

I think there are IIO devices that provide their own
hardware timestamp and as such they might want to use that,
so the mechanism need to be generic enough that a certain
hardware timestamp can be selected sooner or later.
But let's not overcomplicate things for now.

Yours,
Linus Walleij
