Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41F783CB907
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 16:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240507AbhGPOsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 10:48:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:38958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240570AbhGPOs2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 10:48:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 549A9613F5;
        Fri, 16 Jul 2021 14:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626446733;
        bh=jGkYHdtpJmNgP+jjovYyYp81WnjQGMvqSzExy4p9tVs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lOxxzf4dgoHd9JbTyP/hxCGUEKF0362tMEeGeCAhT9kKt/fcXRO7RfkE/yH6LlfBC
         9APLTw5KZKOjqbkix1omWESvsqBCaikoqT4/PjU6qri4AbjCDwn9W76mOTjKSOdNy8
         9ctNt2Kp/Z+cfpXvJPlk8fmGVjTHWJmeEWS+ZT5dpAV5n4VUivm2jQjZtnrjXPZMnH
         Z5qAHnpNCzQ/uyf5gFbd+fNv/pY+es3X9+eZO7Ju0IpIaoPNig+B4Rf3FJkSnJoo9l
         hFyVtqS6UvETJbUIBDqc+1+DjoyXijM6iT93iwagc1HpjmEh7ofYDx8U27+LSPnHlt
         hGA+WLR1oBxhg==
Date:   Fri, 16 Jul 2021 16:45:29 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linuxarm <linuxarm@huawei.com>, mauro.chehab@huawei.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH v13 1/9] staging: hi6421-spmi-pmic: rename GPIO IRQ OF
 node
Message-ID: <20210716164529.35d3cb0c@coco.lan>
In-Reply-To: <CAL_JsqJKkLZH7GnhFh=oznFnK+j2b7VVjsfWAWZq47TkqDayOw@mail.gmail.com>
References: <cover.1626253775.git.mchehab+huawei@kernel.org>
        <1e7ec01a61916a03e7165e684d8d5b7dc58970f0.1626253775.git.mchehab+huawei@kernel.org>
        <CAL_JsqJKkLZH7GnhFh=oznFnK+j2b7VVjsfWAWZq47TkqDayOw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 14 Jul 2021 07:36:43 -0600
Rob Herring <robh@kernel.org> escreveu:

> On Wed, Jul 14, 2021 at 3:13 AM Mauro Carvalho Chehab
> <mchehab+huawei@kernel.org> wrote:
> >
> > Instead of using the standard name ("gpios"), use "interrupts".
> >
> > Suggested-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  drivers/staging/hikey9xx/hi6421-spmi-pmic.c              | 2 +-
> >  drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml | 4 ++--
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
> > index 35ef3d4c760b..9a7e095246f7 100644
> > --- a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
> > +++ b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
> > @@ -233,7 +233,7 @@ static int hi6421_spmi_pmic_probe(struct spmi_device *pdev)
> >
> >         ddata->dev = dev;
> >
> > -       ddata->gpio = of_get_gpio(np, 0);
> > +       ddata->gpio = of_get_named_gpio_flags(np, "interrupts", 0, NULL);  
> 
> It's an interrupt, you should be using platform_get_irq() and
> devm_request_irq().
> 
> In general, you should not be using of_get_* for any resources, but
> use the firmware agnostic flavors.

I've no idea how to convert to use platform_get_irq().

I tried to replace the logic:

	priv->gpio = of_get_gpio(np, 0);
	if (priv->gpio < 0)
		return priv->gpio;

	if (!gpio_is_valid(priv->gpio))
		return -EINVAL;

	ret = devm_gpio_request_one(dev, priv->gpio, GPIOF_IN, "pmic");
	if (ret < 0) {
		dev_err(dev, "Failed to request gpio%d\n", priv->gpio);
		return ret;
	}

Into:

	priv->irq = platform_get_irq(pdev, 0);

But it didn't work (I also tried the platform_get_irq_byname):

	[    1.109586] hi6421v600-irq hi6421v600-irq: hi6421v600_irq_probe:
	[    1.115676] hi6421v600-irq hi6421v600-irq: IRQ index 0 not found
	[    1.121751] hi6421v600-irq hi6421v600-irq: Error -6 when getting IRQs

The original DT schema as:

	gpios = <&gpio28 0 0>;

Based on your past review, this was replaced by:

	interrupts = <&gpio28 0 0>;


What am I missing?

Thanks,
Mauro
