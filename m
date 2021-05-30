Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE8963950A5
	for <lists+linux-kernel@lfdr.de>; Sun, 30 May 2021 13:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbhE3LTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 07:19:23 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:49181 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229500AbhE3LTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 07:19:21 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id A8A6A5C011C;
        Sun, 30 May 2021 07:17:43 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute3.internal (MEProxy); Sun, 30 May 2021 07:17:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm1; bh=R8+AejtaKpmskYAJ9j9jx3ntGN+1
        fRarmXNGE36e9s0=; b=McgHRYtSoGaCebrDcTgADWbVWoQLHu4AOiRnNYMltVdr
        /56mYHgP7QWA+h1W8QvcE1VXmMSRkA5UOeo7+NMR7TzIf4cNFkZoHpVYTWwAw/JB
        wy0jmVQJzyUcJNbR47clhgRmqLqz2JVfRHr1xiFwCEq/vgCOFmR9bzxSgY+WScll
        0inhJ0IK8TF8gvc9Vj+KmEsaz6adgSmQKvzusYuOgW94kyUH5ttWADEPc9otC9Jy
        sUjD/+vhpGXno1nU0yI0FQ0ySAJll9KED9quG77pZG3bz8HcL75TQY1YwKv1uyBG
        KUvOiTiAWMlBBC0TcwKyGxSwLwXEr13dUDKNb7XvSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=R8+Aej
        taKpmskYAJ9j9jx3ntGN+1fRarmXNGE36e9s0=; b=kLD+rNDGTVzkzNxrYIvrFg
        sjH7a063YAEzl1s4fKtmbGmZy/d7bSeeZTQ3StNngsu6dFFaoRm10Neinx1bSS03
        RUC6L3gOf5mlPVTR2WHz141K4Hk9WY4Ou8CCk8i+n5MosgexLsgEHXBiZNwgETP4
        gtJL9nlVH1RJP8sYe+H9TXpe0XH9KZbkXBJIO5046WPArGdsIW8ICDtIf4NWYQZI
        xv/6KezP0925TOJIBqIxOm+BtTOxq94CubFNm8+R55XQheaRvBF15dYp6eyw12ba
        erwkjXw+u2VV+z599QIdt/wkzUoCtNG6+q3yc1182WpiAYgY5FcY+Xj2N3P6uenw
        ==
X-ME-Sender: <xms:VnSzYDTY64WbY_3nmlv48Zbdu9RLhUjyZSfqQU_m5fSD65BCLz2rxQ>
    <xme:VnSzYEzij5nt_tQonjTgG9xRI6U0r2FYiw7vCZ9MCS6hEVtXheiQISsI_2ejk5hVK
    ITjL96Y1GMr27iYkxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdeluddgfeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpefgieegieffuefhtedtjefgteejteefleefgfefgfdvvddtgffhffduhedv
    feekffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:VnSzYI36AyVunZSBIx3XV7u94aL0cYdDKXh-dlRx2i7mQvQyS8Y5qA>
    <xmx:VnSzYDDIq9qV1g064Y-T5QxbwwXIGARw7-5xQmU3-JdbDQpBgpL11A>
    <xmx:VnSzYMggg9mZ08xQwyckHRnRgnq6jhT69DTHUMuKJtBfCG1yIRS2Ew>
    <xmx:V3SzYIiXJhovnq6-s_afkTESmRxxpe9x8hNPtpe1Ua890v4wOtn5Tw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 86DF151C0060; Sun, 30 May 2021 07:17:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-468-gdb53729b73-fm-20210517.001-gdb53729b
Mime-Version: 1.0
Message-Id: <dc4d500e-87f2-47c7-a23d-f0862dc17873@www.fastmail.com>
In-Reply-To: <162199855335.4130789.17766958356597249549@swboyd.mtv.corp.google.com>
References: <20210524182745.22923-1-sven@svenpeter.dev>
 <20210524182745.22923-3-sven@svenpeter.dev>
 <162199855335.4130789.17766958356597249549@swboyd.mtv.corp.google.com>
Date:   Sun, 30 May 2021 13:17:22 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Stephen Boyd" <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-clk <linux-clk@vger.kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Hector Martin" <marcan@marcan.st>,
        "Michael Turquette" <mturquette@baylibre.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Mark Kettenis" <mark.kettenis@xs4all.nl>,
        "Arnd Bergmann" <arnd@kernel.org>
Subject: Re: [PATCH 2/3] clk: add support for gate clocks on Apple SoCs
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for the review!

On Wed, May 26, 2021, at 05:09, Stephen Boyd wrote:
> Quoting Sven Peter (2021-05-24 11:27:44)
> > Add a simple driver for gate clocks found on Apple SoCs. These don't
> > have any frequency associated with them and are only used to enable
> > access to MMIO regions of various peripherals.
> 
> Can we figure out what frequency they are clocking at?
> 

I don't think so. I've written some more details about how Apple
uses the clocks in a reply to Rob, but the short version is that
these clock gates are only used as on/off switches. There are
separate clocks that actually have a frequency associated with
them.


> > 
> > Signed-off-by: Sven Peter <sven@svenpeter.dev>
> > diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> > index e80918be8e9c..ac987a8cf318 100644
> > --- a/drivers/clk/Kconfig
> > +++ b/drivers/clk/Kconfig
> > @@ -245,6 +245,18 @@ config CLK_TWL6040
> >           McPDM. McPDM module is using the external bit clock on the McPDM bus
> >           as functional clock.
> >  
> > +config COMMON_CLK_APPLE
> > +       tristate "Clock driver for Apple platforms"
> > +       depends on ARCH_APPLE && COMMON_CLK
> 
> The COMMON_CLK depend is redundant. Please remove.

Removed for v2.

> 
> > +       default ARCH_APPLE
> > +       help
> > +         Support for clock gates on Apple SoCs such as the M1.
> > +
> > +         These clock gates do not have a frequency associated with them and
> > +         are only used to power on/off various peripherals. Generally, a clock
> > +         gate needs to be enabled before the respective MMIO region can be
> > +         accessed.
> > +
> >  config COMMON_CLK_AXI_CLKGEN
> >         tristate "AXI clkgen driver"
> >         depends on HAS_IOMEM || COMPILE_TEST
> > diff --git a/drivers/clk/clk-apple-gate.c b/drivers/clk/clk-apple-gate.c
> > new file mode 100644
> > index 000000000000..799e9269758f
> > --- /dev/null
> > +++ b/drivers/clk/clk-apple-gate.c
> > @@ -0,0 +1,152 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Apple SoC clock/power gating driver
> > + *
> > + * Copyright The Asahi Linux Contributors
> > + */
> > +
> > +#include <linux/clk.h>
> 
> Hopefully this can be droped.
> 
> > +#include <linux/clkdev.h>
> 
> And this one too. clkdev is not modern.

Okay, will remove both headers (and also fix any code that uses them).

> 
> > +#include <linux/err.h>
> > +#include <linux/io.h>
> > +#include <linux/iopoll.h>
> > +#include <linux/clk-provider.h>
> > +#include <linux/of.h>
> > +#include <linux/of_address.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/module.h>
> > +
> > +#define CLOCK_TARGET_MODE_MASK 0x0f
> 
> APPLE_ prefix on all these?

Fixed for v2.

> 
> > +#define CLOCK_TARGET_MODE(m) (((m)&0xf))
> > +#define CLOCK_ACTUAL_MODE_MASK 0xf0
> > +#define CLOCK_ACTUAL_MODE(m) (((m)&0xf) << 4)
> > +
> > +#define CLOCK_MODE_ENABLE 0xf
> > +#define CLOCK_MODE_DISABLE 0
> > +
> > +#define CLOCK_ENDISABLE_TIMEOUT 100
> > +
> > +struct apple_clk_gate {
> > +       struct clk_hw hw;
> > +       void __iomem *reg;
> > +};
> > +
> > +#define to_apple_clk_gate(_hw) container_of(_hw, struct apple_clk_gate, hw)
> > +
> > +static int apple_clk_gate_endisable(struct clk_hw *hw, int enable)
> > +{
> > +       struct apple_clk_gate *gate = to_apple_clk_gate(hw);
> > +       u32 reg;
> > +       u32 mode;
> > +
> > +       if (enable)
> > +               mode = CLOCK_MODE_ENABLE;
> > +       else
> > +               mode = CLOCK_MODE_DISABLE;
> > +
> > +       reg = readl(gate->reg);
> > +       reg &= ~CLOCK_TARGET_MODE_MASK;
> > +       reg |= CLOCK_TARGET_MODE(mode);
> > +       writel(reg, gate->reg);
> > +
> > +       return readl_poll_timeout_atomic(gate->reg, reg,
> > +                                        (reg & CLOCK_ACTUAL_MODE_MASK) ==
> > +                                                CLOCK_ACTUAL_MODE(mode),
> > +                                        1, CLOCK_ENDISABLE_TIMEOUT);
> 
> Maybe this
> 
>           return readl_poll_timeout_atomic(gate->reg, reg,
> 		   (reg & CLOCK_ACTUAL_MODE_MASK) == CLOCK_ACTUAL_MODE(mode),
> 		   1, CLOCK_ENDISABLE_TIMEOUT);
> 
> at the least please don't break the == across two lines.

Ah, sorry. I ran clang-format at the end and didn't catch that line when
I did my final review.
I'll use your suggestion for v2.

> 
> > +}
> > +
> > +static int apple_clk_gate_enable(struct clk_hw *hw)
> > +{
> > +       return apple_clk_gate_endisable(hw, 1);
> > +}
> > +
> > +static void apple_clk_gate_disable(struct clk_hw *hw)
> > +{
> > +       apple_clk_gate_endisable(hw, 0);
> > +}
> > +
> > +static int apple_clk_gate_is_enabled(struct clk_hw *hw)
> > +{
> > +       struct apple_clk_gate *gate = to_apple_clk_gate(hw);
> > +       u32 reg;
> > +
> > +       reg = readl(gate->reg);
> > +
> > +       if ((reg & CLOCK_ACTUAL_MODE_MASK) == CLOCK_ACTUAL_MODE(CLOCK_MODE_ENABLE))
> 
> Any chance we can use FIELD_GET() and friends? Please don't do bit
> shifting stuff inside conditionals as it just makes life more
> complicated than it needs to be.

Absolutely, thanks for the hint. I didn't know about FIELD_GET and will
use it for v2.

> 
> > +               return 1;
> > +       return 0;
> 
> How about just return <logic>?

Good point, fixed for v2.

> 
> > +}
> > +
> > +static const struct clk_ops apple_clk_gate_ops = {
> > +       .enable = apple_clk_gate_enable,
> > +       .disable = apple_clk_gate_disable,
> > +       .is_enabled = apple_clk_gate_is_enabled,
> > +};
> > +
> > +static int apple_gate_clk_probe(struct platform_device *pdev)
> > +{
> > +       struct device *dev = &pdev->dev;
> > +       struct device_node *node = dev->of_node;
> > +       const struct clk_parent_data parent_data[] = {
> > +               { .index = 0 },
> > +       };
> 
> Yay thanks for not doing it the old way!

:)

> 
> > +       struct apple_clk_gate *data;
> > +       struct clk_hw *hw;
> > +       struct clk_init_data init;
> > +       struct resource *res;
> > +       int num_parents;
> > +       int ret;
> > +
> > +       data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> > +       if (!data)
> > +               return -ENOMEM;
> > +
> > +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +       data->reg = devm_ioremap_resource(dev, res);
> > +       if (IS_ERR(data->reg))
> > +               return PTR_ERR(data->reg);
> > +
> > +       num_parents = of_clk_get_parent_count(node);
> 
> Oh no I spoke too soon.

:(

Sorry, will fix it for v2 to use the new way.

> 
> > +       if (num_parents > 1) {
> > +               dev_err(dev, "clock supports at most one parent\n");
> > +               return -EINVAL;
> > +       }
> > +
> > +       init.name = dev->of_node->name;
> > +       init.ops = &apple_clk_gate_ops;
> > +       init.flags = 0;
> > +       init.parent_names = NULL;
> > +       init.parent_data = parent_data;
> > +       init.num_parents = num_parents;
> > +
> > +       data->hw.init = &init;
> > +       hw = &data->hw;
> > +
> > +       ret = devm_clk_hw_register(dev, hw);
> > +       if (ret)
> > +               return ret;
> > +
> > +       return devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, hw);
> 
> It looks like a one clk per DT node binding which is not how we do it. I
> see Rob has started that discussion on the binding so we can keep that
> there.
> 
> > +}
> > +
> 

Thanks,


Sven
