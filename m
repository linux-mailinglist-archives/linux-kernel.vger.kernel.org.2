Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6065306145
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 17:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbhA0Quy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 11:50:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbhA0Quv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 11:50:51 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28F8C061574
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 08:50:09 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id c20so2426555ilj.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 08:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kWHv7FaKINU76u2rqSfJiVNORj1RftZIrTGMEcXLR9Q=;
        b=mrmfFQk+FLUnwmqvCjWEh9bORaqPx79pw0wT6U90Q8mK5Lo2c5X8k9OJEaq2X0AyUj
         kE4GV7GdG329ffQf14hiOTcu+y3ArGunB/KQmfItrRcjIKQD0CWd522tqiiI6z3v9FUc
         hfPpBoe+nq3vnz8hjesfk86hRG6MMmM5EjCgGP3gg3TgW+t9/2OZlpKLtqit7FSuhbm+
         XhHgLGbUGI+M/vJX7cDXt1ZW7qO8UVEPfMFVl9IklW3realhp+OPnYP3muNvXhpe9fds
         SnRC+dFAKLJlcrB+Gp8BZYvBW4scF9ifSUjcwt4CSOfxg2YijRuovQ6idPA1cJUzCHnf
         rZ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kWHv7FaKINU76u2rqSfJiVNORj1RftZIrTGMEcXLR9Q=;
        b=Y47gASbCzziWIvXczR885KJ49LjjupiisJFeqvtLhHD/e3opSqNOdliburtEkpLBDQ
         hpOmLZPuRbHclFQ4PEF77oJe4tfladauhfVvWXDzEw7PhRAzQDMrEmf0H7q8YdZJIH4M
         aaORVhWPDTYCmdz9nBMJadPADyWrwOqm/WxAWiwRHHpZHWseyvID7FmMVHUk0L45hRJW
         pTk8KLqe9vnUaYECyDHlL3LSJD9yVI6UNDksIAyz8kbgJzN9FxZfiJoFhocHPBPwtsDT
         QYaPXPt/UYS9bOhvYAzTM/fZjDJfrxY8f+eQ3RxOOvMYBA5EYWtJoQUt1CVWki8pNZBi
         uuHA==
X-Gm-Message-State: AOAM530vC8w10sNUia9eiD6wNdGhBY6Q4YHOdKgZltuCiTrQ9RAX6OiT
        3E0Pw96XeXrjp8RzxmEtdEbkJO34KRsojthKmYbvCA==
X-Google-Smtp-Source: ABdhPJyE0BzpKT7nVwusAFmo/LGwm6lWz/URbVmjb8gMBeNY5v/2Cw1GZRSQDZ4vCVeCKOT6i9Cw7ADKvd2fkew+vVc=
X-Received: by 2002:a92:c567:: with SMTP id b7mr9709064ilj.25.1611766208970;
 Wed, 27 Jan 2021 08:50:08 -0800 (PST)
MIME-Version: 1.0
References: <20210127033603.1519127-1-davidgow@google.com> <20210127122712.GU2002709@lianli.shorne-pla.net>
In-Reply-To: <20210127122712.GU2002709@lianli.shorne-pla.net>
From:   David Gow <davidgow@google.com>
Date:   Thu, 28 Jan 2021 00:49:56 +0800
Message-ID: <CABVgOSkkRt5eZRrb8ia-0++0W8A4radZBWWry1P16=ZcAKLAuQ@mail.gmail.com>
Subject: Re: [PATCH] soc: litex: Properly depend on HAS_IOMEM
To:     Stafford Horne <shorne@gmail.com>
Cc:     Pawel Czarnecki <pczarnecki@internships.antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 8:27 PM Stafford Horne <shorne@gmail.com> wrote:
>
> On Tue, Jan 26, 2021 at 07:36:04PM -0800, David Gow wrote:
> > The LiteX SOC controller driver makes use of IOMEM functions like
> > devm_platform_ioremap_resource(), which are only available if
> > CONFIG_HAS_IOMEM is defined.
> >
> > This causes the driver not to be enable under make ARCH=um allyesconfig,
> > even though it won't build.
>
> Is this wording correct?  I suspect it causes to driver TO BE enabled.
>

Whoops! Yes: that should be "causes the driver to be enabled" -- sorry
about that.

Let me know if you want me to re-send it with the fixed wording, or if
you just want to fix that yourself.

> >
> > By adding a dependency on HAS_IOMEM, the driver will not be enabled on
> > architectures which don't support it.
> >
> > Fixes: 22447a99c97e ("drivers/soc/litex: add LiteX SoC Controller driver")
> > Signed-off-by: David Gow <davidgow@google.com>a
>
> This looks ok to me.  I can queue it for 5.11 fixes, if you can help with the
> wording above.

Thanks: that'd be great!

Cheers,
-- David

>
> -Stafford
>
> > ---
> >  drivers/soc/litex/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/soc/litex/Kconfig b/drivers/soc/litex/Kconfig
> > index 7c6b009b6f6c..7a7c38282e11 100644
> > --- a/drivers/soc/litex/Kconfig
> > +++ b/drivers/soc/litex/Kconfig
> > @@ -8,6 +8,7 @@ config LITEX
> >  config LITEX_SOC_CONTROLLER
> >       tristate "Enable LiteX SoC Controller driver"
> >       depends on OF || COMPILE_TEST
> > +     depends on HAS_IOMEM
> >       select LITEX
> >       help
> >         This option enables the SoC Controller Driver which verifies
> > --
> > 2.30.0.280.ga3ce27912f-goog
> >
