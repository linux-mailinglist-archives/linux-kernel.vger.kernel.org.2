Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE9D3DF992
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 04:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234085AbhHDCMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 22:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbhHDCMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 22:12:47 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0047DC06175F
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 19:12:35 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id z128so1721133ybc.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 19:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sm451czZd0rWklvsSmqNKdExE0Oj2B0x8c+hMELIQJ0=;
        b=LO5hlyuJnToPkkXBhogL5LHyT5V9JfEPAsQnS4Vq36uK6+Kc6QRqhIZIQFQ6kqSfb+
         704Lh8LXVFCYj8eEYADECGLuYS9F/lBJroIYFqRFj5aRqgYdv3tRzP9LW9BS4yOPS1Q6
         7G5YhqLaMNCQd9Sv1xBs5lWGFZ+3oIlCxNijBYqQpx647ZfX2rEYR++jyrSOQYkkEFVS
         bfSt7sP0PMi4ZQK/0YeER2XhOH0yCS8gzTtlQshcm05WqDdzjMCKpVqdjz+RisHq1nlN
         Jqg7F6HLl0aO5XMQdZKgDsBkf8smwo5E/1rVFYQHFQ2Lu+rfmLfPx6u8AJiNNzzbWY+i
         /IcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sm451czZd0rWklvsSmqNKdExE0Oj2B0x8c+hMELIQJ0=;
        b=ov3qKErlcI5/FpnpSUxS3rTrrxBTwhoARjXRomBQXUKPB4atJgIa40Ayp7gBiJv1+R
         B7XGgQm5N2G5FrUhGI+oVTXX4DloI3rQPiJmKmCGTTVxVhZQ62le8c2GREGC6D+X/5mZ
         3t3g8Si8J8py0U96YAPJY0xuJQNac432K9Yk8di5nLFWm0GjoOwfbXC20Fd4Ico6Qpa0
         oh8+DVENXklCXUCtX/9e935rIYn76dqWyDb8R/XnopHn0bTpk+iIl26mgHdcaCwBZGDE
         SYNdAEDbtu1QRoDM7fpC/Tq2/uGXtfdPZYh8jPNZ5Ih+c16o4KQqFn4NqmRYW+hZb+EY
         sqdQ==
X-Gm-Message-State: AOAM532LJ+Ahvw+he3CLb/8k2cLgCL75cDaMC55aAmvmNN9jMPf/CQL0
        3IVOEKj5ASv35Sp9ANaiplvAD06349a696TSer/EVw==
X-Google-Smtp-Source: ABdhPJygfpE1YkHtbzYX/2h95P7IvsLukbbMRLifnuJXjoooqapqG3VNL9zYjmvV8A8r8iWaiCz+j2nxYB/UiYwk0pI=
X-Received: by 2002:a25:8b91:: with SMTP id j17mr30240817ybl.228.1628043154789;
 Tue, 03 Aug 2021 19:12:34 -0700 (PDT)
MIME-Version: 1.0
References: <20201020072532.949137-1-narmstrong@baylibre.com>
 <20201020072532.949137-2-narmstrong@baylibre.com> <7hsga8kb8z.fsf@baylibre.com>
 <CAF2Aj3g6c8FEZb3e1by6sd8LpKLaeN5hsKrrQkZUvh8hosiW9A@mail.gmail.com>
 <87r1hwwier.wl-maz@kernel.org> <7h7diwgjup.fsf@baylibre.com>
 <87im0m277h.wl-maz@kernel.org> <87h7g626wg.wl-maz@kernel.org>
In-Reply-To: <87h7g626wg.wl-maz@kernel.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 3 Aug 2021 19:11:58 -0700
Message-ID: <CAGETcx-XEJ25SvUO92wVyqjna+=CU6UTSQKqDimy008z0afA1g@mail.gmail.com>
Subject: Re: [PATCH 1/2] irqchip: irq-meson-gpio: make it possible to build as
 a module
To:     Marc Zyngier <maz@kernel.org>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Lee Jones <lee.jones@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 3, 2021 at 2:51 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On Tue, 03 Aug 2021 10:44:34 +0100,
> Marc Zyngier <maz@kernel.org> wrote:
>
> [...]
>
> > This thing keeps failing on my end. It only works if I force the
> > irqchip module to be present before the MDIO module is loaded. Here's
> > an example:
> >
> > root@tiger-roach:~# modprobe mdio_mux_meson_g12a
> > [  125.871544] libphy: mdio_mux: probed
> > [  125.882575] g12a-mdio_mux ff64c000.mdio-multiplexer: Error: Failed to register MDIO bus for child /soc/bus@ff600000/mdio-multiplexer@4c000/mdio@0
> > [  125.892630] libphy: mdio_mux: probed
> >
> > Trying to bring up the Ethernet interface will fail. Note that there
> > was no attempt to load the irqchip driver.
> >
> > root@tiger-roach:~# modprobe -r mdio_mux_meson_g12a
> > root@tiger-roach:~# modprobe irq-meson-gpio
> > [  144.983344] meson-gpio-intc ffd0f080.interrupt-controller: 100 to 8 gpio interrupt mux initialized
> > root@tiger-roach:~# modprobe mdio_mux_meson_g12a
> > [  150.376464] libphy: mdio_mux: probed
> > [  150.391039] libphy: mdio_mux: probed
> >
> > And it now works.
>
> An additional source of amusement is that this patch allows the
> irqchip to be removed from the kernel. It becomes really fun when you
> have live interrupts...

Which is why I wrote IRQCHIP_PLATFORM_DRIVER_BEGIN/END macros. Maybe
those should be used instead?

-Saravana

[1] - https://lore.kernel.org/lkml/20200718000637.3632841-2-saravanak@google.com/
