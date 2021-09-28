Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE78341BA51
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 00:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243274AbhI1W00 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 28 Sep 2021 18:26:26 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:54809 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243224AbhI1W0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 18:26:19 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 56193FF802;
        Tue, 28 Sep 2021 22:24:36 +0000 (UTC)
Date:   Wed, 29 Sep 2021 00:24:35 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mtd <linux-mtd@lists.infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] mtd: Changes for v5.13-rc4
Message-ID: <20210929002435.4d0b437c@xps13>
In-Reply-To: <20210526184612.751e7e5c@xps13>
References: <20210526175924.4f9ab124@xps13>
        <CAHk-=wh_ZHF685Fni8V9is17mj=pFisUaZ_0=gq6nbK+ZcyQmg@mail.gmail.com>
        <20210526184612.751e7e5c@xps13>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

miquel.raynal@bootlin.com wrote on Wed, 26 May 2021 18:46:12 +0200:

> Hi Linus,
> 
> Linus Torvalds <torvalds@linux-foundation.org> wrote on Wed, 26 May
> 2021 06:20:35 -1000:
> 
> > On Wed, May 26, 2021 at 5:59 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:  
> > >
> > > Raw NAND:
> > > * txx9ndfmc, tmio, sharpsl, ndfc, lpc32xx_slc, fsmc, cs553x:
> > >   - Fix external use of SW Hamming ECC helper    
> > 
> > Why are these guys all pointlessly duplicating the ecc wrapper
> > functions for their ecc 'correct' functions?
> > 
> > The whole "the Hamming software ECC engine has been updated to become
> > a proper and independent ECC engine" excuse makes no sense. If
> > multiple chips just want a basic sw hamming helper, then they should
> > have one. Not have to be forced to each write their own pointless
> > wrapper like this.
> > 
> > These chip drivers just want 'ecc_sw_hamming_correct()' with the
> > proper arguments, and it seems entirely wrong to duplicate the helper
> > five times or whatever. There should just be a generic helper - the
> > way there used to be.
> > 
> > In fact, I would generally strongly recommend that if there used to be
> > a generic helper that different chip drivers used (ie the old
> > rawnand_sw_hamming_correct()), then such a helper should be left alone
> > and not change the semantics of it.  
> 
> I am not happy neither with the fix (which I wrote myself) as my first
> goal was to uniformize the way the Hamming helpers are being called (as
> part of a much bigger work). I assumed that all drivers either used the
> Hamming software engine or simply didn't, without thinking about the
> "intermediate" situations where a particular driver would just want to
> call a particular Hamming helper to workaround its "missing" hardware
> capabilities.
> 
> Unfortunately when I spotted that many drivers were broken by my rework
> I decided to provide per-driver fixes, while, as you suggest, I should
> probably have declared a generic 'hamming correct' core helper and use
> that directly instead of duplicating the logic in each broken driver.
> 
> > The new "proper independent ECC engine" that had new semantics should
> > have been the one that got a new name, rather than breaking an old and
> > existing helper function and then making the chip drivers pointlessly
> > write their own new helper functions.
> > 
> > I've pulled this, but under protest. The patch honestly just looks
> > like mindless duplication.  

Just to let you know that I proposed there [1] a series to clean this
up.

[1] https://lore.kernel.org/linux-mtd/20210928221507.199198-1-miquel.raynal@bootlin.com/T/#t

Thanks,
Miquèl
