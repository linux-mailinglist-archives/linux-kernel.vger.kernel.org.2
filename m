Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D176316182
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 09:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbhBJIxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 03:53:38 -0500
Received: from mail-oo1-f54.google.com ([209.85.161.54]:44483 "EHLO
        mail-oo1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhBJIwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 03:52:06 -0500
Received: by mail-oo1-f54.google.com with SMTP id n19so329579ooj.11;
        Wed, 10 Feb 2021 00:51:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7V7OH9fV9+gOCkOnQeMts3uy27IP2+Nw+0gEV97rl1Q=;
        b=fwn++Om8AFmWUfd3tHqSLXTfUQScwxwmNzmKR2HBBdV4J28ETvd0gdqVlbmAVZo3rl
         OBLTeqAVaSyArYZeBOL/JnIAWXTFSKs62b2sVxJ7zzP9YlANVtSx8VfCc7tqrtOqD1U6
         jq9PCrsvu5mFxMoxFg/LY4Gh5STtYvKUODOQXP8Y+2wlktVdEinKNWUrOXXgWB8I7Gjw
         oCc5FfDNL/qLqE9VP39AvpmLo8O//RTR9LF78vTnXVeLDTSP3cpVWcnoUSGqUmiPamii
         zcN9PCbTFVx1Kj6tjCpAmjqrZKHptQ8rRFN03e3xbYkTK1lk7L5IX8YkBwPik+MWqWBU
         zIzQ==
X-Gm-Message-State: AOAM531C00BUlo96VnvciNlTfXeNL6mWg5ll+bGwQ16RX8SOZTbrAW2T
        dkQ58S3t+8CCzZws7iqNTA+FLVktZoL2YhsrB5k=
X-Google-Smtp-Source: ABdhPJwciwPWg5/eWej5/f9CZIlP6FGwhM+MPhM01e7XDw2vR3qAWS5D0ouKp/I5Z4vgwHZvG2MG+4QBgi/PLRk4AfI=
X-Received: by 2002:a4a:ab08:: with SMTP id i8mr1446407oon.40.1612947085221;
 Wed, 10 Feb 2021 00:51:25 -0800 (PST)
MIME-Version: 1.0
References: <20210203154332.470587-1-tudor.ambarus@microchip.com>
 <5bc4f5b7-5370-bdd5-143e-429c83447ce1@microchip.com> <161291845517.418021.17378265940034341908@swboyd.mtv.corp.google.com>
 <CAGETcx9fjRhNmEMF2QoerrzGctC6MMTy+_znVTgPEm1w-+ehqA@mail.gmail.com>
In-Reply-To: <CAGETcx9fjRhNmEMF2QoerrzGctC6MMTy+_znVTgPEm1w-+ehqA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 10 Feb 2021 09:51:14 +0100
Message-ID: <CAMuHMdWBZq8n6-8e-GYEEs0V9ZW--CSDCs=+u_bkr=aRW4y=ZA@mail.gmail.com>
Subject: Re: [PATCH] clk: at91: Fix the declaration of the clocks
To:     Saravana Kannan <saravanak@google.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Ludovic Desroches <Ludovic.Desroches@microchip.com>,
        Nicolas Ferre <Nicolas.Ferre@microchip.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        mirq-linux@rere.qmqm.pl,
        Claudiu Beznea <Claudiu.Beznea@microchip.com>,
        a.fatoum@pengutronix.de, Krzysztof Kozlowski <krzk@kernel.org>,
        Codrin.Ciubotariu@microchip.com,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravana,

On Wed, Feb 10, 2021 at 1:57 AM Saravana Kannan <saravanak@google.com> wrote:
> On Tue, Feb 9, 2021 at 4:54 PM Stephen Boyd <sboyd@kernel.org> wrote:
> > Quoting Tudor.Ambarus@microchip.com (2021-02-08 01:49:45)
> > > Do you plan to take this patch for v5.12?
> > > If fw_devlink will remain set to ON for v5.12, some of our boards will
> > > no longer boot without this patch.
> >
> > Is fw_devlink defaulted to on for v5.12?
>
> Yes.

Have all issues been identified and understood?
Have all issues been fixed, reviewed, and committed?
Have all fixes entered linux-next?
Have all fixes been migrated from submaintainers to maintainers?

We're already at v5.11-rc7.
Yes, we can get fixes into v5.12-rc7. Or v5.12-rc9...

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
