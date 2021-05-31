Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38ABB396625
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 18:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234299AbhEaQ7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 12:59:15 -0400
Received: from mail-ua1-f46.google.com ([209.85.222.46]:33610 "EHLO
        mail-ua1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232720AbhEaPLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 11:11:15 -0400
Received: by mail-ua1-f46.google.com with SMTP id l12so1082647uai.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 08:09:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yDHmcyistBdxzTCj/rQXFMQ+e1348tVECqgbMcOh0lI=;
        b=FtGFqVUCajIOQuVo65fnwQE+HXKK+MVRjOkM6wBjHEW1UhdQkyh0DeRMY5ypbGoI1z
         vwjQF5/ttNTPhtsqyn+clxcJsu/xBLycYm0Wa+wSp8ydFUbD1L+C1QeONd1+q8t6kj7O
         Tp2ka8ETz5ijEsBlYCDbpGG2JwV4yEzGDQs/pdSu2BhJVyKRSyZw9gJAA46Ag0iaWEBR
         ALWT7lqkC1MkbC/S2ILIj6ov9ZHqlxh1gw6uI8ij1NwdLrrevgXZ9dofC4YyIsFBPpfw
         lAupET0+KSU7C7tEb0q93qQ1IvuFNir0oOfVt0cW3ADjRZRZcwB68owebc+HE0Si6mE1
         IAFA==
X-Gm-Message-State: AOAM5301U7u+BkZF2DxE5iZY1WBkJGn2WtmhC2ys08wJ/TaCe7M6PJyi
        iqQwih+apCAx9VAQOTSQBP0Lk2Wp2/KsLoU0bLvxaDz0
X-Google-Smtp-Source: ABdhPJwsiZr034Ntauqo8b7p9u3b5V/1+t1FlO73bHXRWtHbsV3vz9OuH/SI+S7AMAImYR+tnAK58hjNIzhhXf8iL7A=
X-Received: by 2002:ab0:708c:: with SMTP id m12mr1422550ual.4.1622473773562;
 Mon, 31 May 2021 08:09:33 -0700 (PDT)
MIME-Version: 1.0
References: <202105300736.7wVLvXHr-lkp@intel.com> <a0edf640-ec05-524e-9125-44decba27bbb@infradead.org>
 <d4c47108-f4d2-4850-14fd-b4c4bd0e0591@infradead.org> <CAMuHMdW1xZ-vJe2eOehNSKCP3T=-eq7ji4MBo3D6oGJyPNXGDw@mail.gmail.com>
 <0717b3a5-d838-e1ed-a4ac-80cf14f3a6aa@infradead.org> <YLT2vB0GwC1sJesL@lunn.ch>
In-Reply-To: <YLT2vB0GwC1sJesL@lunn.ch>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 31 May 2021 17:09:22 +0200
Message-ID: <CAMuHMdVVGVdtzbnZUNTe1qGCb8nq+6jvNNWw8U3_A=KcXmO3mA@mail.gmail.com>
Subject: Re: ERROR: modpost: "__delay" [drivers/net/mdio/mdio-cavium.ko] undefined!
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rich Felker <dalias@libc.org>,
        David Daney <david.daney@cavium.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Mon, May 31, 2021 at 4:46 PM Andrew Lunn <andrew@lunn.ch> wrote:
> > > No, we should just fix the driver instead.
> > >
> > > +               /* Wait 1000 clocks so we don't saturate the RSL bus
> > > +                * doing reads.
> > > +                */
> > > +               __delay(1000);
> > >
> > > As this is used only on Cavium Octeon and Thunder SoCs, running
> > > at 400-600 MHz resp. 1800-2000 Mhz, what about replacing the __delay()
> > > call by a call to udelay(1) or udelay(2)?
> >
> > Yeah, I was planning to look into that change this week,
> > but it would probably be better for David to do it.
>
> If you look at the bigger picture, using linux/iopoll.h would be a
> better solution.

Sure, but doing that conversion[*] needs even more involvement from
the original author (who has been quiet w.r.t. to this issue ever
since the first time it was reported ca. 18 months ago), or someone
with access to the hardware.

[*] The driver doesn't use plain readq(), but a custom
    oct_mdio_readq().  Hence it cannot be used with readq_*poll*()
   as-is.



Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
