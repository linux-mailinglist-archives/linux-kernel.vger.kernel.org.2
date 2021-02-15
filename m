Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A467931B9E2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 13:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbhBOM6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 07:58:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:34076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229666AbhBOM6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 07:58:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4BA5B64E32;
        Mon, 15 Feb 2021 12:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613393876;
        bh=JmCk3wwhPukg3kOobGn/50JTpRaSFtNqZz/tas7ch0Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fcNNq09xgLPbl466yc8rl0ZZh3SAs/MZ7x6tKJgIVDNxPxUOCD0/G4P/8jXEcrYLN
         Zv/u/sKU3vfHG5JTURLn0GYT4+Ku0tnL0ndshz0UyhqvAH2GUpin4TdLiS4LqSyy+D
         ULmHtoJJFOKs0eHRWp0rR+PsHbW1oiT44iQPdXYIa/3uIem6PWsTA3wIWAqB5r4hPP
         X3auNq9EBW2ZZT1QINNhnRuml/oa11NOMaY3Eu4sNVGIxkLS0Ow5kugGQZr40tfpDl
         GmaH4OYJs7LuvAOxfqgTJDXtmYRdTxy4mpA08pi8bNnNTgh6vavHdjS6lBSql12myd
         5tMu0zH5WO3hA==
Received: by mail-ot1-f43.google.com with SMTP id s107so5943915otb.8;
        Mon, 15 Feb 2021 04:57:56 -0800 (PST)
X-Gm-Message-State: AOAM530Eeod68VghzJLIvckAgy/46djT2WvXf5SUwCUpCR+d/M8P4QUz
        dIFuGMBa8IrqMP0gJRztFgT/w2H5j/nFDjc+TNU=
X-Google-Smtp-Source: ABdhPJwwXI1NUf7nwPgf6KkxASuVYd+/6NE+oIbTXzx+4RVFEeJVXTbYiqMpUvAoV3ETUwfEcq//vDUfbp3xZcsCazg=
X-Received: by 2002:a9d:3403:: with SMTP id v3mr11259199otb.305.1613393875550;
 Mon, 15 Feb 2021 04:57:55 -0800 (PST)
MIME-Version: 1.0
References: <20210215121713.57687-1-marcan@marcan.st>
In-Reply-To: <20210215121713.57687-1-marcan@marcan.st>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 15 Feb 2021 13:57:39 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1bXiWcieqTSZARN+to=J5RjC2cwbn_8ZOCYw2hhyyBYw@mail.gmail.com>
Message-ID: <CAK8P3a1bXiWcieqTSZARN+to=J5RjC2cwbn_8ZOCYw2hhyyBYw@mail.gmail.com>
Subject: Re: [PATCH v2 00/25] Apple M1 SoC platform bring-up
To:     Hector Martin <marcan@marcan.st>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Tony Lindgren <tony@atomide.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Alexander Graf <graf@amazon.com>,
        Will Deacon <will@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 15, 2021 at 1:16 PM Hector Martin <marcan@marcan.st> wrote:
>
> This series brings up initial support for the Apple M1 SoC, used in the
> 2020 Mac Mini, MacBook Pro, and MacBook Air models.
>
> The following features are supported in this initial port:
>
> - UART (samsung-style) with earlycon support
> - Interrupts, including affinity and IPIs (Apple Interrupt Controller)
> - SMP (through standard spin-table support)
> - simplefb-based framebuffer
> - Devicetree for the Mac Mini (should work for the others too at this
>   stage)

I am essentially happy with the state of this series, the comments I had
in v1 by email and IRC are all addressed, but of course with the timing
during the merge window, it is not going to be in v5.12.

(adding maintainers for the serial/irqchip/clocksource drivers and
arch/arm64 to cc)

I would suggest merging it together as a series through the soc tree for
v5.13, once each patch has been reviewed by the respective subsystem
maintainers, with possible add-on patches on the same branch for
additional drivers that may become ready during the 5.12-rc cycle.
After the initial merge, driver patches will of course go through subsystem
trees as normal.

Let me know if that works for everyone.

     Arnd
