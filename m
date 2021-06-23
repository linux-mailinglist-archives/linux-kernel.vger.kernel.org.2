Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A08FE3B168B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 11:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbhFWJPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 05:15:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:42494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230002AbhFWJPb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 05:15:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E1C18611CE;
        Wed, 23 Jun 2021 09:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624439594;
        bh=F5ijxwzEeYJ7i/hzV572Z7SGyiz9hiABgV3WNxdV1VU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ga6cUW3jb83gQZXGHcVDMM7sPeKPkkR6s/4qVYWJd6TzTTzXM7hvIxJf5+it7a72l
         z1t1FrDbJXVaDRJ3wqprigTLlzLl1e3aSwF5abNrHAK83iM63HHkNym9ZRt6sEGriq
         MizKpHf3Dc6OlkIPlZSo7T1Ig6nN+GG03Q0krDZGFhdNAx/JG7gfQtlD9fzc2Ymvly
         l7kXNeq4UJ8YFn0LZ+H/Q5mUwy3rs9STL4XAt+NnPN/EhLiyRTyrH/ywGD07DD1gji
         0zpYzlVGVH4pDORiZV6vbQUd1gww9Hs6fZtKGKqzCd9smNr0+tYg5PSd3JmrNx8kzZ
         WhNLHziIixwNQ==
Date:   Wed, 23 Jun 2021 11:13:09 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v5 (RESEND) 4/7] mfd: hi6421-spmi-pmic: move driver from
 staging
Message-ID: <20210623111309.215c5040@coco.lan>
In-Reply-To: <20210326211723.GB3867921@robh.at.kernel.org>
References: <cover.1616695231.git.mchehab+huawei@kernel.org>
        <de3603a366c172923771d3f01aa83b70cbba2199.1616695231.git.mchehab+huawei@kernel.org>
        <20210326211723.GB3867921@robh.at.kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Em Fri, 26 Mar 2021 15:17:23 -0600
Rob Herring <robh@kernel.org> escreveu:

> On Thu, Mar 25, 2021 at 07:05:36PM +0100, Mauro Carvalho Chehab wrote:
> > This driver is ready for mainstream. So, move it out of staging.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  .../mfd/hisilicon,hi6421-spmi-pmic.yaml       | 135 ++++++++
> >  MAINTAINERS                                   |   7 +
> >  drivers/mfd/Kconfig                           |  16 +
> >  drivers/mfd/Makefile                          |   1 +
> >  drivers/mfd/hi6421-spmi-pmic.c                | 297 ++++++++++++++++++
> >  drivers/staging/hikey9xx/Kconfig              |  18 --
> >  drivers/staging/hikey9xx/Makefile             |   1 -
> >  drivers/staging/hikey9xx/hi6421-spmi-pmic.c   | 297 ------------------
> >  .../hikey9xx/hisilicon,hi6421-spmi-pmic.yaml  | 135 --------
> >  9 files changed, 456 insertions(+), 451 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml
> >  create mode 100644 drivers/mfd/hi6421-spmi-pmic.c
> >  delete mode 100644 drivers/staging/hikey9xx/hi6421-spmi-pmic.c
> >  delete mode 100644 drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml
> > new file mode 100644
> > index 000000000000..3b23ad56b31a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml
> > @@ -0,0 +1,135 @@

...


> 
> > +
> > +  gpios:  
> 
> A named gpio is preferred (foo-gpios).
> 
> What is this gpio for?

This is IRQ GPIOs.

Right now, the drive calls:

	ddata->gpio = of_get_gpio(np, 0);

which is an alias for of_get_named_gpio_flags() that hardcode the
name "gpios":

	static inline int of_get_gpio_flags(struct device_node *np, int index,
			      enum of_gpio_flags *flags)
	{
		return of_get_named_gpio_flags(np, "gpios", index, flags);
	}

It shouldn't be hard to replace it by:

	ddata->gpio = of_get_named_gpio_flags(np, "irq-gpio", 0, NULL);

but it sounds that most drivers just use of_get_gpio(). The only one
doing it differently seems to be this one:

	$ git grep -A1 of_get_named_gpio_flags|grep irq
	drivers/mfd/stmpe.c:	pdata->irq_gpio = of_get_named_gpio_flags(np, "irq-gpio", 0,
	drivers/mfd/stmpe.c-				&pdata->irq_trigger);

While the usage of "gpios" (without a prefix) seems to be more usual:

	$ git grep -l of_get_gpio|grep -vE '(of_gpio.h|gpiolib.c)'
	arch/mips/lantiq/xway/vmmc.c
	arch/powerpc/platforms/44x/warp.c
	arch/powerpc/platforms/85xx/sgy_cts1000.c
	drivers/input/touchscreen/auo-pixcir-ts.c
	drivers/media/i2c/s5k6a3.c
	drivers/mfd/hi6421-spmi-pmic.c
	drivers/pcmcia/at91_cf.c
	drivers/regulator/gpio-regulator.c
	drivers/soc/fsl/qe/gpio.c
	drivers/spi/spi-mpc52xx.c
	drivers/usb/host/fhci-hcd.c
	sound/soc/codecs/ssm2518.c

Yet, as this is a new driver, if you prefer, I can use the named
variant and use either "irq-gpio" or "irq-gpios". Just let me know
the preference.

Thanks,
Mauro
