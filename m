Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC1FA3AD374
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 22:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbhFRUTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 16:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbhFRUTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 16:19:13 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAE7C061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 13:17:03 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id dm5so5257510ejc.9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 13:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YErG3nsC1wpUdGOxN53HPKj5RJIEYjjh/nGCBmnSwyU=;
        b=Pa0lJFQeRj540tKKzMKLN5/JSaecM7l/kTaoSNkJ6lmb7Ts1euLl+WIhPYDV6PrbXK
         SREIB1OAGs/OXCGL8WnzC4MrnJxVgyvEgMPr3HFWwx1BzWbGhAWUnnsl/Fz5lKiXhaok
         r8F4X7Nod0tFySZYgNg9IxZEUwSG/RpEmzXdoLrKpDi8LOaoQnbCBMPBdeig+nc9ej+g
         E5Wfgj7PHJEGuwSNS2WOFlR2lOlxAn7uN7eFEK0fR1w/K53OyYWjoUYgWeaa8HjZVacN
         ScMNVn/nEnzi3m0Wky9Aszc0sSYfxiHkOY9tMkZ0YXFKsz7HyYYfA5R6Nag7vzDaky8N
         PWdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YErG3nsC1wpUdGOxN53HPKj5RJIEYjjh/nGCBmnSwyU=;
        b=saFpLnQa85Cv/PX4rYKvdl4HSALdbrEMWcCMQQQDUHDrr5E8eLL7lO37zNiKDjOa2P
         T79BoNlHoTwhlMvWUoeYUYUk9nYgRioGKtvECJybqFu9e+B1CX8gnNVGcBEr0v/rp6Ly
         bNhbFBI9HVgGFr/N7xC8gIvkSL0uQ9zxxAe2BcFtfHi1XuRuI8rCews+3Zgnxxz/8BOA
         kvp1flFpHShhE+7NoPN91yC17vl6xHtot/mn03XnNfSpD4ekXyGAsLzw95eE87CVe+1N
         5zRpyzD8iODFgn2AKqo1Hxtn533NqUD7tvptk1zh+LBMTUswXCpvIv+udPyASGh5SBiQ
         vaiQ==
X-Gm-Message-State: AOAM531Zk/X5WJLJyvRRF7Yg42tdBGnF4bGo/FK0hDihsly/ir4EmN4C
        GqufCplFNeElRnS9kXf74wF5NrV6gZzNcEcJ9P4=
X-Google-Smtp-Source: ABdhPJzuvG3rFfUe4S6n0416xLdb1JkOOjogjvkHUHWHawCwHS3pxkZTCYzpCZZfCwAy34dWxUzSPVsCQ3nFJ1U8DXw=
X-Received: by 2002:a17:907:1de6:: with SMTP id og38mr12866537ejc.471.1624047421761;
 Fri, 18 Jun 2021 13:17:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210617194154.2397-1-linux.amoon@gmail.com> <CAFBinCDVnBApYziHazeS8f2FXHQ-tUS55-g6B22c20OtfYD=xw@mail.gmail.com>
 <CANAwSgQcVDdPMZjuaN4O1dpVDd-KrNCGLDq0h4vfP4YZ2vSV2Q@mail.gmail.com>
In-Reply-To: <CANAwSgQcVDdPMZjuaN4O1dpVDd-KrNCGLDq0h4vfP4YZ2vSV2Q@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 18 Jun 2021 22:16:51 +0200
Message-ID: <CAFBinCA0-M-P5bWMKmMTq+Kgx+iEBpxirjWGxpaQqR3pfn84Fw@mail.gmail.com>
Subject: Re: [RFCv1 0/8] Meson-8b and Meson-gxbb USB phy code re-structure
To:     Anand Moon <linux.amoon@gmail.com>
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

Hi Anand,

On Fri, Jun 18, 2021 at 3:20 PM Anand Moon <linux.amoon@gmail.com> wrote:
[...]
> (some email id got messed up while sending these changes.)
it happened to me before: don't worry, it's something that can be fixed

[...]
> > > Initially if we connect USB HDD at initial boot it get detected.
> > > but after that usb hotplug of USB HDD is broken.
> > > I did not observe and USB debug events messages to trace the root cause.
> > >
> > > Another issue I observed is increase of USB interrupts event
> > > even if there is not much activity on USB ports.
> > > I tried some clk changes but it did not workout for me.
> > I suggest reporting this to the dwc2 maintainers and asking for advice
> > on how to debug these issues.
> >
> Yes I have enabled the CONFIG_USB_DWC2_DEBUG
> to help debug this issue but could not find much clue on
> why this is happening.
I think CONFIG_USB_DWC2_DEBUG is a good starting point.
For myself I came to the conclusion that the dwc2 IP is too complex to
understand without additional information
Some additional information can be found in public datasheets of other
SoCs which are also using a dwc2 core, see for example RK3128 [0] or
RT3050 [1]
That's why my suggestion is to additionally ask the dwc2 maintainers
(which are not Cc'ed on this mail) for debugging suggestions.


Best regards,
Martin


[0] https://rockchip.fr/RK312X%20TRM/chapter-26-usb-otg-2-0.pdf
[1] http://static6.arrow.com/aropdfconversion/aa9a14376a75e7c5d6daa9f6aaed8411909d2021/rt3050_5x_v2.0_081408_0902.pdf
