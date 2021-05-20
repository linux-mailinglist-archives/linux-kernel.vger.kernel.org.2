Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E97E38B407
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 18:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233429AbhETQJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 12:09:12 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:37511 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbhETQJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 12:09:11 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 49F5C6000F;
        Thu, 20 May 2021 16:07:48 +0000 (UTC)
Date:   Thu, 20 May 2021 18:07:47 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Corentin Labbe <clabbe@baylibre.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh R <vigneshr@ti.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH 2/2] mtd: partitions: redboot: fix style issues
Message-ID: <20210520180747.03fd60b8@xps13>
In-Reply-To: <CACRpkdZhhNQupN_4Oh759bKL7sEM9M=yOW1y-mT69ugEkjRMZw@mail.gmail.com>
References: <20210520114851.1274609-1-clabbe@baylibre.com>
        <20210520114851.1274609-2-clabbe@baylibre.com>
        <CACRpkda6ou1SJZzBwHXN_kWofnFw8w7XAkr7VcFO2NrqbQug_Q@mail.gmail.com>
        <20210520173619.26870bc8@xps13>
        <CACRpkdZhhNQupN_4Oh759bKL7sEM9M=yOW1y-mT69ugEkjRMZw@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus Walleij <linus.walleij@linaro.org> wrote on Thu, 20 May 2021
18:00:04 +0200:

> On Thu, May 20, 2021 at 5:36 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > Linus Walleij <linus.walleij@linaro.org> wrote on Thu, 20 May 2021
> > 17:24:26 +0200:  
> > > On Thu, May 20, 2021 at 1:49 PM Corentin Labbe <clabbe@baylibre.com> wrote:
> > >  
> > > > This patch fixes easy checkpatch issues.
> > > >
> > > > Signed-off-by: Corentin Labbe <clabbe@baylibre.com>  
> > > (...)  
> > > > -    uint32_t     flash_base;    // Address within FLASH of image  
> > > (...)  
> > > > +       u32       flash_base;    // Address within FLASH of image  
> > >
> > > Does checkpatch complain about this? At one point the MTD maintainer
> > > disliked the u32/u16/u8 types and explicitly wanted to use the C
> > > standard library types, and it's the kind of eccentric maintainer
> > > deviations we accommodate for.  
> >
> > I suppose this happened quite some time ago? :)
> >
> > I've never heard Richard nor Boris complaining about it, nor will I.  
> 
> Yes that was a specific David Woodhouse preference.
> I'm too old!

Don't be sad, the new trend is to be sleek. In the dark I worship
variables declaration in a reverse Christmas tree order ;-)
