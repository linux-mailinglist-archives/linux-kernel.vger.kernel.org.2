Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5269135C538
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 13:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240463AbhDLLd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 07:33:29 -0400
Received: from mail-ua1-f49.google.com ([209.85.222.49]:34709 "EHLO
        mail-ua1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237792AbhDLLd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 07:33:28 -0400
Received: by mail-ua1-f49.google.com with SMTP id s2so4109413uap.1;
        Mon, 12 Apr 2021 04:33:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/BtLuken7/ATnnaUkY5iHVkSwH8IiGzx/qlI7A0N+vg=;
        b=WUw34Xz6aZWhQ8YYTeVTVjkvo+O8RkO+g5ebYgeOhc4nnQW5PRl3yoXIPo1+oKs3yC
         VrHhNUAf5fZTjusEksj85l62fpKpYrvd0Zdf3b4Wbc1p31fl5166ECJ4OoJYof1yFfPE
         zU1isrPjRDBpxhrdAO8AFXvJgpVas8G8/6BhYySloEGAv89BvlStp1X2Rzc49fB7qkNT
         8c59zrAZPVRtdIyIgszNBxgGuy0EjUKtPR45wiFu3+H96CSN+bp8R/K3uPmrdnljxe8F
         nefFB2iDZW2ViDs5XMA3wylyNAm30/L7THmLUAztbYXUBwaIknozqtdTXhsv337C/nh0
         h1rw==
X-Gm-Message-State: AOAM531jHIJNtnaTHUwX57iHIPVJxy4M6nGR49G/FxZjLP4krqagzhkd
        w9e875PTonNGGmq2Nn0ePnQPg5jqi1tO/S/qFDk=
X-Google-Smtp-Source: ABdhPJwc7H2iNse606hnm01z3wmnOaEjTehppMFD2rGS5SzORSJzulLQ3INeDmOJwFpkG1K0oL1+YL7jRWDlysWfhK4=
X-Received: by 2002:ab0:3157:: with SMTP id e23mr17802147uam.106.1618227189854;
 Mon, 12 Apr 2021 04:33:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a1L8rWpR5b66v6Su8-m7-scA0wZQr_g_4KnV4dnrky6ZA@mail.gmail.com>
In-Reply-To: <CAK8P3a1L8rWpR5b66v6Su8-m7-scA0wZQr_g_4KnV4dnrky6ZA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 12 Apr 2021 13:32:58 +0200
Message-ID: <CAMuHMdWY0aGoAw6QfF5PQRFNFwAzNP9cmFCjbKnsSbHsMz45fQ@mail.gmail.com>
Subject: Re: New 'make dtbs_check W=1' warnings
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     DTML <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linusw@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Tony Lindgren <tony@atomide.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        SoC Team <soc@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Thu, Apr 8, 2021 at 5:08 PM Arnd Bergmann <arnd@kernel.org> wrote:
> I've just gone through the DT merges I've received so far and, with a
> little help from Rob,
> managed to run 'make dtbs_check W=1' before and after, to see what
> warnings we get.
> The good news is that the number of warnings is going down, but
> unfortunately there
> is still an unmanageable amount of remaining warnings, and some new
> ones crept in.
>
> I'm still working on my tooling for this, to catch these better, but
> ideally I think we should
> try to not introduce new warnings. I think some platforms are already
> clean, and I did
> not see any new warnings for mvebu, samsung and broadcom. There were a lot of
> warnings from .dtsi files, and I probably did an incomplete job at
> deduplicating those.

Thanks for running these checks!

> See below for the other platforms, and the new warnings that I found.
> If these are
> valid, please send a fixup before the merge window, and let me know if
> you have ideas
> for how we should handle these in the future.
>
> For this merge window, I don't think any of them are show-stoppers (Rob, let me
> know if you disagree), but in the long run we may want to gradually enforce
> a rule about not merging changes that introduce any new warnings, in order to
> have a chance of cleaning up the existing ones.

This may not be as simple as it sounds, as DT binding updates typically
follow a different path than DTS(i) updates.  DT bindings updates may be
picked up by a subsystem maintainer, by Rob, or by the platform
maintainer.
For trivial updates (e.g. adding a compatible value, and sometimes
extending a limit), a DTS(i) update may be accepted by the platform
maintainer before the corresponding DT binding update.  The latter may
even be merged one or more kernel revisions later, especially when
involving subsystems that are not traditionally rooted into platforms
using DT.

Of course we could mention any expected warning regressions in our pull
requests for soc.

> renesas/r8a774a1-beacon-rzg2m-kit.dt.yaml: csi2@feaa0000: ports:
> 'port@0' is a required property

[...]

I've replied to these as a response to your PR reply, see
https://lore.kernel.org/linux-renesas-soc/CAMuHMdWHLnXgBSjP7VKUdx-YNr9rSKFkE5Ge5q_tarU6HP9Lhw@mail.gmail.com/

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
