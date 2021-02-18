Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F40F31ED23
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 18:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234122AbhBRRSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 12:18:17 -0500
Received: from foss.arm.com ([217.140.110.172]:51814 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231486AbhBROhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 09:37:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6652DED1;
        Thu, 18 Feb 2021 06:36:50 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.48.237])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 823063F73B;
        Thu, 18 Feb 2021 06:36:47 -0800 (PST)
Date:   Thu, 18 Feb 2021 14:36:44 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Tony Lindgren <tony@atomide.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Alexander Graf <graf@amazon.com>,
        Will Deacon <will@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/25] Apple M1 SoC platform bring-up
Message-ID: <20210218143644.GC89209@C02TD0UTHF1T.local>
References: <20210215121713.57687-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210215121713.57687-1-marcan@marcan.st>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 15, 2021 at 09:16:48PM +0900, Hector Martin wrote:
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

IIUC, the CPUs in these parts have some IMP-DEF instructions that can be
used at EL0 which might have some IMP-DEF state. Our general expectation
is that FW should configure such things to trap, but I don't know
whether the M1 FW does that, and I fear that this will end up being a
problem for us -- even if that doesn't affect EL1/EL2, IMP-DEF state is
an interesting covert channel between EL0 tasks, and not generally safe
to use thanks to context-switch and idle, so I'd like to make sure we
can catch usage and make it SIGILL.

Do you happen to know whether all of that is configured to trap, and if
not, is it possible to adjust the bootloader to ensure it is?

Thanks,
Mark.
