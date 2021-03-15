Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41B1E33C1F1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 17:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbhCOQcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 12:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233600AbhCOQcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 12:32:21 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8EFC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 09:32:21 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id bx7so18071767edb.12
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 09:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ixT7lt5BrAuCBjFWttRkcgqX2EIsHZfZNO+ujvqZKGU=;
        b=MoQuS05o89pXE+Um/K+hgAEvgQ2pqhfdrIIb5zeWlehO+jfzshSzn1Q3dJ7R0wkJGk
         tEQnArZOHyPOfNb6M3u9dWBOJ2XUO89R9VGAim0UzjIGNUczMByY5iUzhPXCeaKa3b3d
         TgX7SNBHiwe6+Ia9dSxRYV3vGKBdTbCj8bZSLo66XqzJeGib9gRjYoyYmkHf9zKIGFYc
         Am4fe+kHone6zAbNtG2jShxZtpBX/i+1NFNv24g41T/bVQO2+oQDZ3EamcrNPaiRNEEc
         jZowbWo+v41uowU1WOFf6hYvlw119QNs+OOQ5Wo/EP1u3LHRZy8K975Pwp/739mgRzkX
         e1tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ixT7lt5BrAuCBjFWttRkcgqX2EIsHZfZNO+ujvqZKGU=;
        b=NJjjLOf6RIyGoWOgoy501QZHomKlNgglcISnPvRsII1AfVHqaw3kWPE8PV8pC99gOx
         bpWHgNHSAxU9rzkd7br1XdNqDZ6JHkxl/vr8Bhy2jKPSjhxkYU6T40uehpC+SSZOslIO
         kTFuIVGq0ZBqXGHxAjslVg2dUfCsiSWA5333lSogP2HecfRgRiNBh4uBgSqZv2mgVtY7
         YU5LQif28TzIqmR9/ZsSi+F62MBMX7W1NTwvcIosAiCcAFR1aRRUE14FcmBVp6brxTvd
         5vdk/8aVzBPtLctS5r/cdfMU5IdBdZheIDms1KD8tZ0Bg/zqyECDzRNbyHow4iGLsN3O
         saEQ==
X-Gm-Message-State: AOAM531ArztrKEB/LqstuD1Hvw1VFRbm3LP3eKT6VjnmlkbvBCKNsw1u
        AHtnCX9fdhQ8BYrAo3n5QYQDs4y5Ti0FTOhm2lSPoXLojhk=
X-Google-Smtp-Source: ABdhPJzHR/hUKU/y5ARhl1rfnFYkKP154YUZ3oGCF5PcRMZ9JehRIUt1NI1XZfQJhFL6uUDeHFE5zP4aEF2LkEO6p38=
X-Received: by 2002:aa7:cf02:: with SMTP id a2mr30582714edy.59.1615825940033;
 Mon, 15 Mar 2021 09:32:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210315135541.921894249@linuxfoundation.org> <20210315135544.659848571@linuxfoundation.org>
 <6abd9dd3-e14b-f690-f967-15fb58dffae8@denx.de>
In-Reply-To: <6abd9dd3-e14b-f690-f967-15fb58dffae8@denx.de>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 15 Mar 2021 17:32:09 +0100
Message-ID: <CAMpxmJV1kbam7mhb7mM111Or8fnpTEo14EczCJ5Efw+45xBUcQ@mail.gmail.com>
Subject: Re: [PATCH 5.10 081/290] gpiolib: Read "gpio-line-names" from a
 firmware node
To:     Marek Vasut <marex@denx.de>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Stable # 4 . 20+" <stable@vger.kernel.org>,
        Roman Guskov <rguskov@dh-electronics.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 4:01 PM Marek Vasut <marex@denx.de> wrote:
>
> On 3/15/21 2:52 PM, gregkh@linuxfoundation.org wrote:
> > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >
> > commit b41ba2ec54a70908067034f139aa23d0dd2985ce upstream.
> >
> > On STM32MP1, the GPIO banks are subnodes of pin-controller@50002000,
> > see arch/arm/boot/dts/stm32mp151.dtsi. The driver for
> > pin-controller@50002000 is in drivers/pinctrl/stm32/pinctrl-stm32.c
> > and iterates over all of its DT subnodes when registering each GPIO
> > bank gpiochip. Each gpiochip has:
> >
> >    - gpio_chip.parent = dev,
> >      where dev is the device node of the pin controller
> >    - gpio_chip.of_node = np,
> >      which is the OF node of the GPIO bank
> >
> > Therefore, dev_fwnode(chip->parent) != of_fwnode_handle(chip.of_node),
> > i.e. pin-controller@50002000 != pin-controller@50002000/gpio@5000*000.
> >
> > The original code behaved correctly, as it extracted the "gpio-line-names"
> > from of_fwnode_handle(chip.of_node) = pin-controller@50002000/gpio@5000*000.
> >
> > To achieve the same behaviour, read property from the firmware node.
>
> There seem to be some discussion going on around this patch, so please
> postpone backporting until that is settled. Same for v5.11 backport. I
> hope Andy/Bartosz agrees ?

Yes, this patch broke at least the testing module and we're working to
determine if it breaks DT drivers too.

Bart
