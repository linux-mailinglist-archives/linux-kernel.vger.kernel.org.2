Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7FB31D8BF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 12:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbhBQLrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 06:47:21 -0500
Received: from mail-oo1-f44.google.com ([209.85.161.44]:33545 "EHLO
        mail-oo1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbhBQLnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 06:43:33 -0500
Received: by mail-oo1-f44.google.com with SMTP id f1so2995193oou.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 03:43:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LGt6tY92iGlpuapxusyXpw9WikTRifEkQywYToz+mkk=;
        b=AuUIMOlpLCnCfvyKIlDrYRYKdpiwR8IoM+44Vi1B7MKNhCFiH0wKhOvQie+aM+fyoY
         hPHXBS58wJlb8MDfuczM3OxykbJkC2krjBRBH1KNGGfwBRF/Q1duqnNHXWjhb+LZsPr+
         7/7Uy1a2Q7HsuLnLNHnvWEOrSBLjZC2z6i32tr+3Qde2DJtIBu9uO6wup5vAa5TiMuyU
         wHr8x8fV5iHLIb4GX0GkgHMblxOP4WlQvHQoz4EZLIcysOmBlmIe+sSwkknZVVlGZ1+Y
         jhIt3ZAeLYVoaxrM5Fpaiq4Lx5C+LZD4EXYGvmSmBLK6O5lBr1dIIRxiCcWyzDhDzENB
         /SiA==
X-Gm-Message-State: AOAM530yYBSMvOGTYnnelRBDlGX4FuTlVE1douDdAjtUEpOqDJ/WL+IP
        Z43+L8mMcJ6hdKpRJLQn+DXYZAubSnulhs1zp38=
X-Google-Smtp-Source: ABdhPJz8eldTYxdcBHf4sKtCptTjgQElM6L04/GB38e0nte65i/sdrXpjHm4CYFJoqVw+pkSF173+sJdRL9+GnBgRvA=
X-Received: by 2002:a4a:3bcb:: with SMTP id s194mr17178025oos.1.1613562172348;
 Wed, 17 Feb 2021 03:42:52 -0800 (PST)
MIME-Version: 1.0
References: <202102121331.d4C0ShlS-lkp@intel.com> <CAK8P3a3uM7rCbnJP9r2SFEjm0D7oy2YsXw7VcGzkg5tq7mQbag@mail.gmail.com>
 <2903dec9-b21d-9d91-0ad9-045bd9b2afd4@linux-m68k.org>
In-Reply-To: <2903dec9-b21d-9d91-0ad9-045bd9b2afd4@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 17 Feb 2021 12:42:41 +0100
Message-ID: <CAMuHMdVeErFJcngx6Jpznqd0Cm+Rb5OvgGdKjRi7Q8fNmgBA7g@mail.gmail.com>
Subject: Re: [SPAM?]Re: arch/m68k/68000/dragen2.c:73:16: error: 'screen_bits' undeclared
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     Arnd Bergmann <arnd@kernel.org>, kernel test robot <lkp@intel.com>,
        Arnd Bergmann <arnd@arndb.de>, kbuild-all@lists.01.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Wed, Feb 17, 2021 at 5:59 AM Greg Ungerer <gerg@linux-m68k.org> wrote:
> On 12/2/21 8:05 pm, Arnd Bergmann wrote:
> > On Fri, Feb 12, 2021 at 6:48 AM kernel test robot <lkp@intel.com> wrote:
> >> FYI, the error/warning still remains.
> >
> >>           |             ^~~~~~~~~~~~
> >>     arch/m68k/68000/dragen2.c: In function 'init_dragen2':
> >>>> arch/m68k/68000/dragen2.c:73:16: error: 'screen_bits' undeclared (first use in this function)
> >>        73 |  LSSA = (long) screen_bits;
> >>           |                ^~~~~~~~~~~
> >>     arch/m68k/68000/dragen2.c:73:16: note: each undeclared identifier is reported only once for each function it appears in
> >
> > This problem existed before my patch, I just moved the line to another file.
> > To fix it, one needs to test on real hardware and figure out what is supposed
> > to go in there.
> >
> > The bug was apparently introduced in linux-2.5.70 in this commit:
>  >
> > commit 2b1a7e97c8c2d6330a432cbcaf83a0ef5fab848e
> > Author: gerg <gerg>
> > Date:   Mon May 26 16:45:57 2003 +0000
> >
> >      [PATCH] fix m68knommu DragonEngine2 target setup code
> >
> >      Numerous fixes for the m68knommu DragonEngine2 setup code.
> >
> >      It was out of date relative to more recent kernels.  Original patches
> >      from Georges Menie.
> >
> >      BKrev: 3ed244c5dPVeFKP63b4kkeS_rEshag
>
> Digging around a bit I think the screen_bits data structure was
> originally in a screen.h file that was generated from a screen.xbm file.
> That was removed in commit 0c0e6db80683 ("m68k: drop unused parts of
> 68VZ328 Makefile").
>
> Obviously no one seems to be using this, that has been broken for a long
> time now.
>
> I could restore the generated screen.h here, so this could compile at
> least. I don't have any of the hardware supported in the arch/m68k/68000
> directory, so I can't test anything we fix in there.

Do you have the generated screen.h?
Looks like both the tool (xbm2lcd.pl) and the source (screen.xbm)
never made it upstream?

> The other option is to remove the dragen code altogether.

Just remove the part protected by checks for CONFIG_INIT_LCD?

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
