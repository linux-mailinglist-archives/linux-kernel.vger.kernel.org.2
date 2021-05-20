Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD07338B35B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 17:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243790AbhETPhz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 20 May 2021 11:37:55 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:47701 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238746AbhETPho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 11:37:44 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id CD25460011;
        Thu, 20 May 2021 15:36:20 +0000 (UTC)
Date:   Thu, 20 May 2021 17:36:19 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Corentin Labbe <clabbe@baylibre.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh R <vigneshr@ti.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH 2/2] mtd: partitions: redboot: fix style issues
Message-ID: <20210520173619.26870bc8@xps13>
In-Reply-To: <CACRpkda6ou1SJZzBwHXN_kWofnFw8w7XAkr7VcFO2NrqbQug_Q@mail.gmail.com>
References: <20210520114851.1274609-1-clabbe@baylibre.com>
        <20210520114851.1274609-2-clabbe@baylibre.com>
        <CACRpkda6ou1SJZzBwHXN_kWofnFw8w7XAkr7VcFO2NrqbQug_Q@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Linus Walleij <linus.walleij@linaro.org> wrote on Thu, 20 May 2021
17:24:26 +0200:

> On Thu, May 20, 2021 at 1:49 PM Corentin Labbe <clabbe@baylibre.com> wrote:
> 
> > This patch fixes easy checkpatch issues.
> >
> > Signed-off-by: Corentin Labbe <clabbe@baylibre.com>  
> (...)
> > -    uint32_t     flash_base;    // Address within FLASH of image  
> (...)
> > +       u32       flash_base;    // Address within FLASH of image  
> 
> Does checkpatch complain about this? At one point the MTD maintainer
> disliked the u32/u16/u8 types and explicitly wanted to use the C
> standard library types, and it's the kind of eccentric maintainer
> deviations we accommodate for.

I suppose this happened quite some time ago? :)

I've never heard Richard nor Boris complaining about it, nor will I.

Cheers,
Miquèl
