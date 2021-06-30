Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1879B3B7DB9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 08:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbhF3G5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 02:57:31 -0400
Received: from mail-vs1-f49.google.com ([209.85.217.49]:44915 "EHLO
        mail-vs1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbhF3G53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 02:57:29 -0400
Received: by mail-vs1-f49.google.com with SMTP id y21so1067850vsm.11
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 23:55:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q+6q6qdz667Cf0iKSQ/dUdaHbp2LScTUHAPwkTfCDGY=;
        b=CchA3rsLdORWnW/NiyXWGkIwgQ/DBiYCvJp4sxN9JmUtVbdlnsWljxAu8DT3oKqvQH
         SLg3JYcaDWsjcsYX/okzNFVB+IiAWWy+RAXkU0NWwjYlTdfZboJa6Gv2SuxpvZmGZXio
         wkm4ObjGq1qC7JhLfGaDgtXq3TG053wm8hnH654NvDXfBants+FV48sSe05BS7ymAD2X
         hjfOT7svgxuF9L7y9k77BheFWiYQKgW77ZSPE/MaZ0UjPoSvSD1YDOinmFDUwFTp71mp
         TTJdF2JyPk2odp4ge9QO9LUXPutmC9/IKaH/SlqECI5w01kfVRBpfOHGvRyoPSm63hTI
         Mw1g==
X-Gm-Message-State: AOAM5308BsxzFv5kJ6zWtLMIm1Bw01iXvbx8PgBi9K2cxu72y1+nI1lk
        FIjEEugmdjU+gnZHw8xCM6Teqk5KBmDz2g8nXy2cFiRttts=
X-Google-Smtp-Source: ABdhPJxWKHAqwLWfIvAhQ3sgATgRT6fdrhFg7ubK6vw9zZ3/JkR/4I9iKK/R5EPjxfZrm8YhbsnNCvmZdyiW1T3riDQ=
X-Received: by 2002:a67:770d:: with SMTP id s13mr16034470vsc.40.1625036100451;
 Tue, 29 Jun 2021 23:55:00 -0700 (PDT)
MIME-Version: 1.0
References: <1b2fd6f2b2e87a7d483450c20f31366b7f17c997.1624972206.git.geert+renesas@glider.be>
 <CACRpkdavxy4wmsj8XtXmbMDkmScquABynphnmD_GAARfudd1AQ@mail.gmail.com>
In-Reply-To: <CACRpkdavxy4wmsj8XtXmbMDkmScquABynphnmD_GAARfudd1AQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 30 Jun 2021 08:54:49 +0200
Message-ID: <CAMuHMdUm1acjWjrAz+FMnTit+ABL4tKrutQwt-6pHs64-=dyTg@mail.gmail.com>
Subject: Re: [PATCH] arm: Typo s/PCI_IXP4XX_LEGACY/IXP4XX_PCI_LEGACY/
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, Arnd,

On Wed, Jun 30, 2021 at 2:26 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Tue, Jun 29, 2021 at 3:12 PM Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
>
> > Kconfig symbol PCI_IXP4XX_LEGACY does not exist, but IXP4XX_PCI_LEGACY
> > does.
> >
> > Fixes: d5d9f7ac58ea1041 ("ARM/ixp4xx: Make NEED_MACH_IO_H optional")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> Are you sending this to ARM SoC or should I?

Arnd: can you pick this up? Or is it Olof time?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
