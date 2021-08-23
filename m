Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E55A3F4E62
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 18:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbhHWQbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 12:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbhHWQbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 12:31:43 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B622C061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 09:31:00 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id r19so27038074eds.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 09:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3UJqarI9sJh/SEzyJatryVnyGRWftRgbiqbTe8APv5I=;
        b=FsrV/vjP9FwD6+gGUwE7brUSey8SYKVwpEPyJQ0ZE91a3dyKjLFv4giwo7QDacAyFw
         egWdkhxhj9NUwi0HHZgK6yGJwJqJ9HDb4qRQTaVMnHGO8gG3ZeKZZnYYlrfNm693Fy0Y
         oQ7hh6DOM1oB/BYhyFoBA7veyoZ+c37euu8VuV+OZ6P//3RXOx3M7EEGpEYyTjgd2uYE
         MuUNLxBrhnc9SLBdXN+ef9CFeC33EpLfc4dt8uuN0PDzFbh3LbEJ8k/+9p+0HmJfgQdQ
         CnTT/UROf8/CFKl03Gou5JKZcVBU8MPgFGcCZmh4qpB9Vjhu1UYXY1utX6FUrmozWZgV
         tXbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3UJqarI9sJh/SEzyJatryVnyGRWftRgbiqbTe8APv5I=;
        b=amv0TU0iQqFxEaRHjnGCuDcLl2VUjyt1Nd9cc9XsWmSvlGCgNAmn8u5YdjG0Zb/BGk
         lQoi/bpyWW44y2qbCIeeVdmiB8SixDZPCdVpUZzuyNlfooEn96h81BYewtxMVBdbzria
         LEQuZ1L6KqX4/BntK+n51MJ5RyfjyIBWX19LrH1XXsgkgmlKwuSQJ5PA88fSn5YpZ3sD
         VUNgOLqVuHmdDZcdxxy5n3/PhzpwyEL78sxfIkqLcRi6hqOhABOccj/Ds6Oe43JyEFc+
         g2vVNUauLAs1kzTO8hgeBacnnszcTSjg9mymvYMfGznFn3r4sq5uVJOr7Kf8Z8bXWntg
         v3jw==
X-Gm-Message-State: AOAM532SlgZijmtEzDxeX06FO7AM6HP5R/Ivx/Zr5lfADldxXgE8e3GI
        JEaaBJcDFzDCw6X/cezFmitwxp16l0HUfTNA+GuoZw==
X-Google-Smtp-Source: ABdhPJwCkyepKnYLjaro8KpvCFMhXySyvI2odnfjv7k323shjYJULMJoXC1kqfT5uu34xj4dmG7LvzhRZ/0V8efQvKs=
X-Received: by 2002:a05:6402:5208:: with SMTP id s8mr38656411edd.222.1629736258724;
 Mon, 23 Aug 2021 09:30:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210304034141.7062-1-brad@pensando.io> <20210304034141.7062-2-brad@pensando.io>
 <CAHp75VcG9KajNpDbewDq7QzotB6t7MfwiGk15FaobX+cmMVSzg@mail.gmail.com>
 <CAK9rFnwrA=W2Vk5yFwG4N_WS=eBXXnhtexA+tqgAYb6xOAO4oQ@mail.gmail.com>
 <CAHp75VdfrJ3JV_gL3xCLHOiw6Tj-5Ep7z5JKWUFKFbUt8gobcw@mail.gmail.com>
 <CAK9rFnx--z_pr_yR6CqGsH04ddwUtx4rxc7MxNNmy7ZSF86+Mg@mail.gmail.com> <CAMuHMdUz4vUQzXBHA9AiT3w6L20yBpgd0emVZJb=v_qw70qiJQ@mail.gmail.com>
In-Reply-To: <CAMuHMdUz4vUQzXBHA9AiT3w6L20yBpgd0emVZJb=v_qw70qiJQ@mail.gmail.com>
From:   Brad Larson <brad@pensando.io>
Date:   Mon, 23 Aug 2021 09:30:47 -0700
Message-ID: <CAK9rFnw-j8whcsK-NQ4w4+sCdrumCk7Bb=J+KfsF9ZO2Tf5r5g@mail.gmail.com>
Subject: Re: [PATCH 1/8] gpio: Add Elba SoC gpio driver for spi cs control
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Mon, Aug 23, 2021 at 12:50 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Brad,
>
> On Mon, Aug 23, 2021 at 3:14 AM Brad Larson <brad@pensando.io> wrote:
> > On Mon, Mar 29, 2021 at 3:40 AM Andy Shevchenko
[...]
> > Regarding the above module question and Kconfig definition, since I
> > first looked at this and reviewed the comments I realized I should be
> > using builtin.  The file gpio/Kconfig is currently this
> >
> > config GPIO_ELBA_SPICS
> >         def_bool y
> >         depends on ARCH_PENSANDO_ELBA_SOC || COMPILE_TEST
>
> That means the driver will default to yes by merely enabling
> COMPILE_TEST, which is a no-go.
>
>     config GPIO_ELBA_SPICS
>             bool "one-line summary"
>             depends on ARCH_PENSANDO_ELBA_SOC || COMPILE_TEST
>             default y if ARCH_PENSANDO_ELBA_SOC

Thanks Geert, changed to this

--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -241,8 +241,9 @@ config GPIO_EIC_SPRD
          Say yes here to support Spreadtrum EIC device.

 config GPIO_ELBA_SPICS
+       bool "Pensando Elba SoC SPI Chip Select as GPIO support"
+       depends on ARCH_PENSANDO_ELBA_SOC
        def_bool y
-       depends on ARCH_PENSANDO_ELBA_SOC || COMPILE_TEST

Regards,
Brad
