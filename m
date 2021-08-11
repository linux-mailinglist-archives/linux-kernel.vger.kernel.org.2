Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 276223E91A2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 14:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbhHKMiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 08:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbhHKMiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 08:38:18 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEA3C0613D5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 05:37:54 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id x8so5413429lfe.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 05:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9S5hNWF7Ym56keRWy48m1LDZ9cViBH7sfuOyRaprzEc=;
        b=OhLxJMmJn6LGQeeXfeGiPmO+AVDUGQYNXJzRzfNxRqi3efHSiZcwI019V8OUjhaXSb
         qyVz6X+DF4E6khqP1VjSveuZVdirnVTgWJoVcttI+pE7f0PfqZ8Tk2xevufW2vVMJwOb
         lp96fWowdQ+F2t7vIf4f9ksWjDCxUFHW/TUacoBkvZ0Nn8Cz98X4fC4sMgBr9ey/zE8c
         8XJP222RFXrP8FAF1Pja2BQfYUXPdTzUmaNfvpu+9hEcE3EnTZdvRUFjQ7Jwp6kfW9Cp
         zd+teOJ8jhY81xicFaR5mL6JRc+jpi4SCQhEv37rPqsZRNuUb600s4Qr6iwlnxyQOGB1
         u8ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9S5hNWF7Ym56keRWy48m1LDZ9cViBH7sfuOyRaprzEc=;
        b=Br5Qc3LOQybnmririYah+hgOsAnwk73kR+cbv2hlcIesRhAq7YGTFLnF6KNCjN4Rpu
         OLliRitBTjDbwFFovNgYTdp1XeMMJhVmxehJuYyi+9W9CHrjxbIOssKxeKTKKSCTUwVT
         dibdQC3BnWJT1cJgZVVTORRdaYGNvY1s43pnkKf3Mh1DyHMN1Yz4fsj5U2YA+7/EeUbB
         QzXepzsX2hpYz+iHXqd8boXXrr2AOcMiFWA7Af8h4Lji7d/By19QeWy/hkCU9Yk3k+6I
         aiGz25R+qltYEpd18ru2G2vq1Z1gU4twVe802AlM4pzAq1hO5tAwwYvW/awulcZc/sCf
         5UQw==
X-Gm-Message-State: AOAM5307izMT3a0I+bu1fcR7I+yF7L+5MYPD93D6UkzlQTlBgzmMp9Bk
        Tj2eUwhcpaReAe8KR4e2RxjF6L9rJlMTBQxbxaVGlg==
X-Google-Smtp-Source: ABdhPJzcII1prgIZeP3ejqboxiWA7I+FA2kPmqQ4S+j1vFjaVQJyk+h5CSOe2+KVFhyLYUO1sAb/UlIcR+aFDzlq8nk=
X-Received: by 2002:a19:ac04:: with SMTP id g4mr9218546lfc.29.1628685473062;
 Wed, 11 Aug 2021 05:37:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210726125436.58685-1-andriy.shevchenko@linux.intel.com> <20210726125436.58685-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210726125436.58685-2-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 11 Aug 2021 14:37:42 +0200
Message-ID: <CACRpkdarpuFwzj-xRPRe0Y4iWwMtsMeTKwZRp8E0hSyDZZcHwg@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] gpio: dwapb: Read GPIO base from gpio-base property
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Lee Jones <lee.jones@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Hoan Tran <hoan@os.amperecomputing.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2021 at 2:54 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> For backward compatibility with some legacy devices introduce
> a new (*) property gpio-base to read GPIO base. This will allow
> further cleanup of the driver.
>
> *) Note, it's not new for GPIO library since mockup driver is
>    using it already.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
(...)
> -               pp->gpio_base   = -1;
> +               if (fwnode_property_read_u32(fwnode, "gpio-base", &pp->gpio_base))
> +                       pp->gpio_base = -1;

This is problematic because we have repeatedly NACKed this property
to be added to device trees.

I don't know about fwnode policies, but in the device tree this would have
to be "linux,gpio-base" and then it would be NACKed because of adding
an operating-system specific thing to a OS-independent hardware
description.

I don't know what to do with this really, but I understand the need of it
as a kernel-internal thing, however I am afraid that adding this will make
it possible to add linux,gpio-base = <n> to any device tree gpio_chip
as well and that encourages bad behaviour even if we don't allow a
DT binding (YAML) like that.

Is there a way to make a fwnode property only come from software
nodes and not allowed to be used in ACPI or DT? (I guess not...)

Yours,
Linus Walleij
