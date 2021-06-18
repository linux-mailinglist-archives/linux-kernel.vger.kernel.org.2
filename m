Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4696E3ACC08
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 15:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233639AbhFRNXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 09:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233521AbhFRNXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 09:23:00 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD7BC061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 06:20:51 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id i13so8586077edb.9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 06:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aCfQbfrt5qvJnNWovlWCYxzbElz4rKl7GdfgBa31+S0=;
        b=SPQP+UH7dId/IFlM1J6+ZfRgx8exW9U3zL+aaj4MkRT+pL0NkV8A/24dFWYVgssc0J
         zJMk4NWKjGAvvgOQtMcFh7md2xPV0RgXjQ4jIwe7HSY4KUk4nN7D8hwSwY0Fabt17zmP
         k//l7j+Wf1xHnBSxskgG8sUzbdfqo9a+eNAdyILA/ejkkeabsvHdTn2FLxp6hxgBgLs2
         eHao7rU8TTQlM3TtzFVeqQlZP8iTtmeOAOXcvmxuhJt6AO1vJtudPKBitEN28ZyeEgt3
         C0UAwMzYmEX7BlW63NaRdFL0O0oAElcvWTUN//dHwHgGRqq4dX7kLSmb2iyxdVnnwAin
         lErw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aCfQbfrt5qvJnNWovlWCYxzbElz4rKl7GdfgBa31+S0=;
        b=SUHBOsymA5fEOWrRjCmjDhl8eR4Pz5Zqczutu/d6UgBY8U/S8kk3XdvatLYSYjuxYy
         aczvVp5Mk5ucgrwBepw/PqIsKsH0MI9UQmdd0ttWaCoFk244Ff2WNHyZD+rYV0ubmqpj
         ss2QYNTyHa6WXX0SZj5vJU0Ba9EXFxfSklxjyXEC4dYhLMoPWVZrVikZjnlO0EBkgqXR
         tMfOkHTzxwRcdTvcP6PMJhmjndlwAVR4VUlxamGjeE9CqFPb6xi99IoDZENaQQdwgWMZ
         2lCDg2mK9EnvbHjqf9sX8fJwpO6zlCMNaJobLt8Xi4SBJjVjgHxE3S6E/CpovA7q37wy
         kLFw==
X-Gm-Message-State: AOAM533ATTpvmCVOC8LbqwUk5YqGdZmovLDXmgu6O+iXSqd/o4/yzdSZ
        AlfwWHzdB4OhhqQgMjrHyiJO9VngPy5HDMXNbps=
X-Google-Smtp-Source: ABdhPJz6bucKNYlMeaQC6CItsCc6UV9ebDQXJxtGgVJZr2SOOXBkE+7nJoqtVBuCIevPJTlwVz463DwbN0CK5Ec04VI=
X-Received: by 2002:aa7:c40a:: with SMTP id j10mr4863359edq.59.1624022450023;
 Fri, 18 Jun 2021 06:20:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210617194154.2397-1-linux.amoon@gmail.com> <CAFBinCDVnBApYziHazeS8f2FXHQ-tUS55-g6B22c20OtfYD=xw@mail.gmail.com>
In-Reply-To: <CAFBinCDVnBApYziHazeS8f2FXHQ-tUS55-g6B22c20OtfYD=xw@mail.gmail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Fri, 18 Jun 2021 18:50:39 +0530
Message-ID: <CANAwSgQcVDdPMZjuaN4O1dpVDd-KrNCGLDq0h4vfP4YZ2vSV2Q@mail.gmail.com>
Subject: Re: [RFCv1 0/8] Meson-8b and Meson-gxbb USB phy code re-structure
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-phy@lists.infradead.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

Thanks for your review comments.
(some email id got messed up while sending these changes.)

On Fri, 18 Jun 2021 at 03:41, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi Anand,
>
> On Thu, Jun 17, 2021 at 9:42 PM Anand Moon <linux.amoon@gmail.com> wrote:
> >
> > On Odroid C1+ and Odroid C2 USB feature is broken
> with "broken" you mean the hotplug and IRQ issues you describe below?
> I think that these are not PHY related but rather a problem with the
> dwc2 IP/driver
>
> > this code changes are just re-structure the code so that
> > proper callback function execute in proper order.
> >
> > Code changes losely based on phy-meson-gxl-usb2.c
> there's a big difference between the Meson8 and GXL drivers:
> GXL requires changing some of the PHY registers at runtime based on
> the mode (host/peripheral).
> The Meson8 PHY however (as far as I can tell from the 3.10 and 3.14
> kernels) don't require any runtime changes based on the mode.
>
Yes I have gone through 3.10 and 3.14 kernel + u-boot source code
My intent is to simplify the code changes so that they will be
flexible to be used
in the future API.  It does not solve the problem.

> > Initially if we connect USB HDD at initial boot it get detected.
> > but after that usb hotplug of USB HDD is broken.
> > I did not observe and USB debug events messages to trace the root cause.
> >
> > Another issue I observed is increase of USB interrupts event
> > even if there is not much activity on USB ports.
> > I tried some clk changes but it did not workout for me.
> I suggest reporting this to the dwc2 maintainers and asking for advice
> on how to debug these issues.
>
Yes I have enabled the CONFIG_USB_DWC2_DEBUG
to help debug this issue but could not find much clue on
why this is happening.

I will keep debugging the DWC2 code or try to understand the missing features.

>
> Best regards,
> Martin

Thanks



-Anand
