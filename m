Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAD2031C175
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 19:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbhBOSY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 13:24:27 -0500
Received: from muru.com ([72.249.23.125]:33832 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229954AbhBOSYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 13:24:25 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 63CEA80CE;
        Mon, 15 Feb 2021 18:24:04 +0000 (UTC)
Date:   Mon, 15 Feb 2021 20:23:38 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Alexander Graf <graf@amazon.com>,
        Will Deacon <will@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/25] arm64: arch_timer: implement support for
 interrupt-names
Message-ID: <YCq8Kl8KYQzpBEy0@atomide.com>
References: <20210215121713.57687-1-marcan@marcan.st>
 <20210215121713.57687-7-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210215121713.57687-7-marcan@marcan.st>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Hector Martin <marcan@marcan.st> [210215 12:18]:
> This allows the devicetree to correctly represent the available set of
> timers, which varies from device to device, without the need for fake
> dummy interrupts for unavailable slots.

I like the idea of using interrupt-names property for mapping timers :)

Similar approach might help other SoCs too. And clocksources never really
had similar issues.

With Marc's comments addressed, please feel free to add:

Reviewed-by: Tony Lindgren <tony@atomide.com>
