Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6853233D7B2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 16:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbhCPPfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 11:35:36 -0400
Received: from mail-vs1-f44.google.com ([209.85.217.44]:46711 "EHLO
        mail-vs1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238125AbhCPPfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 11:35:02 -0400
Received: by mail-vs1-f44.google.com with SMTP id p24so18401674vsj.13;
        Tue, 16 Mar 2021 08:35:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bQXFQUK1Smo7zLwGGBtKvcaQNYzdWt9/qzFR9xYxQFU=;
        b=rj/oSvQfMzDVW6Vrz5CKUkcNd86omR2EAPLRVX9fV+PNZOj9ZFvmZ6xQAZZ3kyBbtX
         G3B26Z7xRUVsc8c6J+i0/2pvu+5A6Ls/VEAI80nG3S3kYAOFffOr8uSmFv1jDEh3E+lz
         ZH+GcmWcuAv0cQtOeRoBU9DA0ugaxKCBwnJqrDKGovpAOCsZxv7vShMYTwhoA7RGocAs
         YqwHo914Tl3yeRj8Aj4rPvO61iIPSKSjtrXE6W4Aaq+uaK2opSMp+XFOAkQuQ4/trEVQ
         f7gngwRvaoa5md5Aal/FlQKfztPwo6CyXrvAwPFyFG0Eu2CXH7RP1cvVGRFy0i83VcVa
         rgcw==
X-Gm-Message-State: AOAM533DlDyFaAst/HZLv7h8zSM/E1+SMhY3cUV+Jy6paCH6UbysuhID
        i3mIrf+Jwo7qQZuOXOFXJnls4CVpYO1+/TJiiZw=
X-Google-Smtp-Source: ABdhPJyiREAov3bNX/VpoD0WiQljCXe/K/wAaktLKqeyeqzULAafFKKBHsJA0VsqBFIKp1TItrvPZJ2crVn4Y+MyLis=
X-Received: by 2002:a67:8883:: with SMTP id k125mr9392973vsd.18.1615908901334;
 Tue, 16 Mar 2021 08:35:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAMuHMdWYrS=YT7F7erM-e6xhDME4judx-T7rdFGi7CpW1_iqkg@mail.gmail.com>
 <20210316150033.15987-1-cnsztl@gmail.com>
In-Reply-To: <20210316150033.15987-1-cnsztl@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 16 Mar 2021 16:34:50 +0100
Message-ID: <CAMuHMdU+agaOdf4hQhn5JQDHCbuWm3dETJu01baxfDAY=nikow@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] rockchip: rk3399: Add support for FriendlyARM
 NanoPi R4S
To:     Tianling Shen <cnsztl@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Chen-Yu Tsai <wens@csie.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>,
        Johan Jonker <jbx6244@gmail.com>,
        David Bauer <mail@david-bauer.net>,
        Jensen Huang <jensenhuang@friendlyarm.com>,
        Marty Jones <mj8263788@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tianling,

CC Jacek, Pavel

On Tue, Mar 16, 2021 at 4:00 PM Tianling Shen <cnsztl@gmail.com> wrote:
> On 2021-03-16 02:23 Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > Personally, I'm not so fond of the <foo>-%u node names, and prefer
> > <foo>-<function>.  With the former, it's way too easy to have a silent
> > override in your .dts(i) stack.
> > Cfr. commit 45f5d5a9e34d3fe4 ("arm64: dts: renesas: r8a77995: draak:
> > Fix backlight regulator name")
>
> How about using `lan-led`, `sys-led` and `wan-led` here?

Documentation/devicetree/bindings/leds/leds-gpio.yaml says "led-%u"
is the preferred form, but that anything containing "led" as a substring
is accepted.  So I'd go for "led-lan" etc.

BTW, you can validate your DTB against the leds-gpio DT bindings
by running:

    make dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/leds/leds-gpio.yaml

Background info for CCed parties:
https://lore.kernel.org/linux-arm-kernel/20210316150033.15987-1-cnsztl@gmail.com/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
