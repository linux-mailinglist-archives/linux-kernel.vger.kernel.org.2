Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3503161E5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 10:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbhBJJQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 04:16:10 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:42408 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbhBJJLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 04:11:52 -0500
Received: by mail-ot1-f42.google.com with SMTP id q4so1151150otm.9;
        Wed, 10 Feb 2021 01:11:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mmzIbd1mxdek5jVaaYsRmGPyjt4W0UF1QUXfwQ+z8rM=;
        b=Ic6W0aIBS6hoHXDytn1NF7imN8WkLLgjHpKsVZsZNxfQdVLkuRHjj01azaLEtv728G
         ZSVV22avOD3rYNLsf+EOw1NmcXvzRzfdxbqepS5lnaPJITCfqRYUrHRKCPwtIAu/HDAH
         XjA9QdXxlPLalJZi2xsUZk4lHsXCeLYO6oE7YUPYhepV3Q8RwPPJFqIC02O6fCDXrK1M
         fsbqrvrXw4ygN7PThBpTWQDpqZ9piaZT4TXqfHNwPDkS4/bYuhgWHWLy54WJXOWNxIf3
         /Z44ps2RIJlWG26IbxQLZhl9KsobFqqj9ECTcLn14zbHkl+LX3eZRAxRaO8SY9R+1cOP
         H9kA==
X-Gm-Message-State: AOAM532WnVvd/eNZ3P8Qgm/NZIt3vU1p5BRmU+/OCj32iH0wcjGdLWCX
        Me+jhMN2H5+yKLuyVUafb9zSjE92ZrlaZ8JCSe4=
X-Google-Smtp-Source: ABdhPJy+Gdm1B8ik7usQwOUT9ldpWoSu/0BM3S8qm6zAUg1uG7eXzJf1x2sEHt/B8LntFzM7S1B/h/I7LpA/Ns42/Aw=
X-Received: by 2002:a9d:77d6:: with SMTP id w22mr1426563otl.145.1612948252567;
 Wed, 10 Feb 2021 01:10:52 -0800 (PST)
MIME-Version: 1.0
References: <20210203154332.470587-1-tudor.ambarus@microchip.com>
 <5bc4f5b7-5370-bdd5-143e-429c83447ce1@microchip.com> <161291845517.418021.17378265940034341908@swboyd.mtv.corp.google.com>
 <CAGETcx9fjRhNmEMF2QoerrzGctC6MMTy+_znVTgPEm1w-+ehqA@mail.gmail.com>
 <CAMuHMdWBZq8n6-8e-GYEEs0V9ZW--CSDCs=+u_bkr=aRW4y=ZA@mail.gmail.com> <CAGETcx--6Pm=KfgFi50Dzin0+760nd-t9w9VxZxcn2Che-G1nQ@mail.gmail.com>
In-Reply-To: <CAGETcx--6Pm=KfgFi50Dzin0+760nd-t9w9VxZxcn2Che-G1nQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 10 Feb 2021 10:10:41 +0100
Message-ID: <CAMuHMdWs-GqN-7tEPFfOeTQbvOH58T6WbBtVLsMNLT5qOHxsHA@mail.gmail.com>
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

On Wed, Feb 10, 2021 at 9:57 AM Saravana Kannan <saravanak@google.com> wrote:
> On Wed, Feb 10, 2021 at 12:51 AM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > On Wed, Feb 10, 2021 at 1:57 AM Saravana Kannan <saravanak@google.com> wrote:
> > > On Tue, Feb 9, 2021 at 4:54 PM Stephen Boyd <sboyd@kernel.org> wrote:
> > > > Quoting Tudor.Ambarus@microchip.com (2021-02-08 01:49:45)
> > > > > Do you plan to take this patch for v5.12?
> > > > > If fw_devlink will remain set to ON for v5.12, some of our boards will
> > > > > no longer boot without this patch.
> > > >
> > > > Is fw_devlink defaulted to on for v5.12?
> > >
> > > Yes.
> >
> > Have all issues been identified and understood?
> > Have all issues been fixed, reviewed, and committed?
> > Have all fixes entered linux-next?
> > Have all fixes been migrated from submaintainers to maintainers?
>
> I'm hoping Tudor has reported and the fixes that have gone in so far
> addressed all his issues. Otherwise, they need to be reported so we
> can fix them.
>
> As of now, there's no pending fix that hasn't landed in maintainer
> trees. So that's good.

You're talking about driver core fixes.
What about driver fixes? E.g. pull request for (arm-)soc should be
srnt before -rc6.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
