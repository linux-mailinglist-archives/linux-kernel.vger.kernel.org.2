Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE634342BD7
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 12:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbhCTLNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 07:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbhCTLMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 07:12:14 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB4FC05BD10
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 04:10:45 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 15so15106858ljj.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 04:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iQbiRQfCZ1e9PcOV7oUExVLYqSL2jaWl8+kxnb9P4QE=;
        b=ZmHUXXFnSJBw/zBD2YFCu4GZgYJ7V4O7gYsMma9qnKkxvY0cAGtQj6DxfnNkYG+O6c
         s+nYJ+bhg1A6R5Op5ZAM6FGRaGwzv4Xm4B+qz7dLUsheLxZdm8h70QBfC7wxa8RWi+CZ
         ZiXH9iTYI6AO4mdSk8IaiNA5VlcYbX21rxvDbpQFInGATBTPthVprzq0PdMi3A9QLC+L
         cFBwsxYl+orDrMv3yFhD9EfaDYY7dhqX4ycE+A5AlGzT3++f1HnR5ilMMiIq34lyq862
         NtrfX8XLLM1q2HrQzKRioG0kZg1UjCExhBEmS4pd+IWSZ+6PwFdtx93NTNJGFMDWaGux
         nGCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iQbiRQfCZ1e9PcOV7oUExVLYqSL2jaWl8+kxnb9P4QE=;
        b=AzDdOyoJ5TOG+9OqiYh7L0XVq6lwOfeUSTIqWE/xinZIc/ELO1mShUXLuYDwIDuGMu
         Huj1yo4DDAk4OSqez6W2wCPywLD9Z5EKtTIp87edaTaRwyPUI+ibC30FP8Gue9GLb+03
         3Ty2vcpk/IMsJJpaw0+dlIPbvkWA3wFmIWGVTfKtuLdlKQPQMbqLdnn5UlRd2L9a7s8u
         pVgAX3Nd8mZVJph7FHdZe4sm4Gvd+B5H/cwsvPlfDUzHlhI+xGeFF9J2W6UF3oLMDDb4
         NNhOOTjSJT1hnfzawnrJ1eF9a+ELHv9TW+tUAqFsGrJr7P2ATc18lQO5oU99f8vqsUR+
         5m1Q==
X-Gm-Message-State: AOAM5311POByjVE+eKajEFSRMRRDd+1DA+IMKTSv+No8W2g5cFU6dP/P
        900R2cn8BcoB/+BMlZ0CMTS6ObsX4K43j5bA+dBPT0aQ3alWgNSghT8=
X-Google-Smtp-Source: ABdhPJxwA/ZKmpkxJ5nFyoGV7macCEDUfHXcXbVnXpyA1p7LTB8mGbQfpyedDa52MGMt2J15oKLJbjqZgIoc1ipQkuM=
X-Received: by 2002:a2e:864a:: with SMTP id i10mr3347149ljj.467.1616238644276;
 Sat, 20 Mar 2021 04:10:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210319131205.62775-1-alexander.sverdlin@nokia.com>
 <CAHp75Vc=HnafsnnJYceBB66k+r9NcZqn7mxjdsc7dsQd_tK=LA@mail.gmail.com> <028a836c-9343-f08a-3f1b-22e45f291d1a@nokia.com>
In-Reply-To: <028a836c-9343-f08a-3f1b-22e45f291d1a@nokia.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 20 Mar 2021 12:10:33 +0100
Message-ID: <CACRpkdbqKmKh0+g92LHJYKO2vt=-TkdTFuSrNwChCbQ-siG53g@mail.gmail.com>
Subject: Re: [PATCH v3] gpio: pl061: Support implementations without GPIOINTR line
To:     Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Marc Zyngier <maz@kernel.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 4:32 PM Alexander Sverdlin
<alexander.sverdlin@nokia.com> wrote:
> [Andy]

> > I'm wondering if the GPIO library support for IRQ hierarchy is what
> > you are looking for.

It is indeed what should be used.

> do you have a better suggestion? That's why I reference the below discussion from 2017, where
> Linus Walleij suggested to use it. Well, the initial patch was just 11-liner and PL061 is
> rather counterexample and doesn't fit well into the existing hierarchical infrastructure.
>
> >> Link: https://lore.kernel.org/linux-gpio/CACRpkdZpYzpMDWqJobSYH=JHgB74HbCQihOtexs+sVyo6SRJdA@mail.gmail.com/

Don't trust that guy. He's inexperienced with the new API and talks a lot
of crap. ;)

We now have a proper API for hierarchical IRQs on GPIO controllers,
so we need to somehow detect that this is the case and act accordingly.

1. In Kconfig
    select IRQ_DOMAIN_HIERARCHY if ARCH_NOKIA_FOO

2. Look at other hierarchical GPIO IRQ drivers such as
    drivers/gpio/gpio-ixp4xx.c

3. Detect that we have a hierarchical situation. The hierarchical
  IRQ is determined by the chip integration so I would go and
  check the SoC compatible in the top-level DT, e.g.:
  if (of_machine_is_compatible("nokia,rock-n-roll-soc")) {
     /* Initialize the interrupt as hiearchical */
     girq->fwnode =...
     girq->parent_domain = ...
     girq->child_to_parent_hwirq = pl061_child_to_parent_nokia_rock_n_roll;
  } else {
     girq->parent_handler = pl061_irq_handler;
     girq->num_parents = 1;
     girq->parents = devm_kcalloc(dev, 1, sizeof(*girq->parents),
                                     GFP_KERNEL);
     if (!girq->parents)
            return -ENOMEM;
      girq->parents[0] = irq;
  }

  This might need some #ifdef or IS_ENABLED() for systems without
  hierarchical IRQs.

4. Implement pl061_child_to_parent_nokia_rock_n_roll()
   Just use hardcoded hardware IRQ offsets like other drivers such as
   the ixp4xx does. Do not attempt to read any parent IRQs from
   the device tree, and assign no IRQ in the device tree.

This is a side effect of the essentially per-soc pecularities around
interrupts. The interrupt is not cascaded so it need special
handling.

I think it can be done with quite little code.

Yours,
Linus Walleij
