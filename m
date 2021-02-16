Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1A931C839
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 10:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbhBPJmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 04:42:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:52836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229713AbhBPJmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 04:42:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7462C64E09;
        Tue, 16 Feb 2021 09:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613468488;
        bh=ymFlalVSZE6VvUvNX82uucfKhpqKL/xJZkolfuRFQfQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hrQ/XJ/UOFNn31C0IOXrJGDZckwsx3OL2WsDqb+T1bTQydlo8pzsTIbTTjoBQ7ib4
         olZ7U43phHxWbKexly6xYaIC1xIKidezSkFY6LLLDynYO1Goc/QLNtK4leGgNoNNbA
         N8/Ch9RXkQ5Ft2h5szM5LXeR6neqbzpsT+970sjg7BF007syqLH+J2wWmIlnBGRKUX
         31+15m2RqN5uSKnYd+IuxVzaTFACpjCutYERYsESukRW0gv8E8xhOV/Rz0j2fLqvon
         z8nQBENypfgPKEa/uNVunaWg38ce3mG+Y37AWFjOreyZ7onBoIRjaG+IZ0zSHu94bM
         S1vpeCrz0fPLQ==
Received: by mail-ot1-f50.google.com with SMTP id q4so8463433otm.9;
        Tue, 16 Feb 2021 01:41:28 -0800 (PST)
X-Gm-Message-State: AOAM531tjXGVgHRyEzrTs9uW0wjped0nf217lmbNpr/wwEOCd1fTuzr8
        OFoJ/Ctm/TEX5+f8xV2kL3GFQ7IJe0rBDve4+w4=
X-Google-Smtp-Source: ABdhPJxiaMAcH5KZayQiwUcYPr4wMM3nIbzsy3wljGGJAybFgS6PcvoGnnAHy1bNygzh3LOoHKqncABSes1Q8IbFeJs=
X-Received: by 2002:a9d:6c11:: with SMTP id f17mr14126556otq.210.1613468487646;
 Tue, 16 Feb 2021 01:41:27 -0800 (PST)
MIME-Version: 1.0
References: <20210215121713.57687-1-marcan@marcan.st> <20210215121713.57687-15-marcan@marcan.st>
In-Reply-To: <20210215121713.57687-15-marcan@marcan.st>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 16 Feb 2021 10:41:11 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3rGurSQBubZ8i4+OHpDgM8mOfXiC6UhDYmL0MSQK4BRA@mail.gmail.com>
Message-ID: <CAK8P3a3rGurSQBubZ8i4+OHpDgM8mOfXiC6UhDYmL0MSQK4BRA@mail.gmail.com>
Subject: Re: [PATCH v2 14/25] dt-bindings: interrupt-controller: Add DT
 bindings for apple-aic
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 15, 2021 at 1:17 PM Hector Martin <marcan@marcan.st> wrote:
> +
> +      The 2nd cell contains the interrupt number.
> +        - HW IRQs: interrupt number
> +        - FIQs:
> +          - 0: physical HV timer
> +          - 1: virtual HV timer
> +          - 2: physical guest timer
> +          - 3: virtual guest timer

I wonder if you could just model the FIQ as a single shared level interrupt
(which is essentially what it is), and have every driver that uses it do a
request_irq() on the same IRQ number.

This would avoid having to come up with a fake binding for it, and simplify
the implementation that then no longer has to peek into each interrupt
source.

     Arnd
