Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4633EF065
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 18:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbhHQQt5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 17 Aug 2021 12:49:57 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:10093 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbhHQQtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 12:49:52 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 5921B240008;
        Tue, 17 Aug 2021 16:49:14 +0000 (UTC)
Date:   Tue, 17 Aug 2021 18:49:13 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     Ezequiel Garcia <ezequiel@collabora.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH 3/3] mtdblock: Warn if the added for a NAND device
Message-ID: <20210817184913.5162b242@xps13>
In-Reply-To: <CAAEAJfDqEu0XtZ_FvVUM31p5PumPmK0x-r8sFWXzENDqf5zj_g@mail.gmail.com>
References: <20210801234509.18774-8-ezequiel@collabora.com>
        <20210806200537.394260-1-miquel.raynal@bootlin.com>
        <CAAEAJfDqEu0XtZ_FvVUM31p5PumPmK0x-r8sFWXzENDqf5zj_g@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ezequiel,

Ezequiel Garcia <ezequiel@vanguardiasur.com.ar> wrote on Tue, 17 Aug
2021 13:27:54 -0300:

> Bonjour Miquel,
> 
> On Fri, 6 Aug 2021 at 17:05, Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> >
> > On Sun, 2021-08-01 at 23:45:09 UTC, Ezequiel Garcia wrote:
> > > There is a surprisingly large number of tutorials
> > > that suggest using mtdblock to mount SquashFS filesystems
> > > on flash devices, including NAND devices.
> > >
> > > This approach is suboptimal than using UBI. If the flash device
> > > is NAND, this is specially true, due to wear leveling, bit-flips and
> > > badblocks. In this case UBI is strongly preferred, so be nice to users
> > > and print a warning suggesting to consider UBI block, if mtdblock
> > > is added for a NAND device.
> > >
> > > Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> >
> > Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.
> >
> 
> Any chance you respin this one?
> 
> It appears somehow this made its way to the patch:
> "Untracked files not listed" sorry about that -- could you remove it?

Yeah no problem about that, it happens ;)

> While there, you can fix the typo in the commit title:
> "mtdblock: Warn if the added for a NAND device" -> "mtdblock: Warn if
> added for a NAND device"

Done as well.

Cheers!
Miquèl
