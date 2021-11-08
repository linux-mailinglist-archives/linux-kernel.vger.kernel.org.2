Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04733447BB1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 09:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237896AbhKHIYy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 8 Nov 2021 03:24:54 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:54303 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237880AbhKHIYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 03:24:53 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id A9D1624000A;
        Mon,  8 Nov 2021 08:22:06 +0000 (UTC)
Date:   Mon, 8 Nov 2021 09:22:05 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mtd <linux-mtd@lists.infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] mtd: Changes for 5.16
Message-ID: <20211108092205.70b5775b@xps13>
In-Reply-To: <CAHk-=wiFoXSsfQwa8x_Ne0HYJtnLcpku67QiRn+q5tXrqiyBiA@mail.gmail.com>
References: <20211107174555.2d1a5eec@xps13>
        <CAHk-=wiFoXSsfQwa8x_Ne0HYJtnLcpku67QiRn+q5tXrqiyBiA@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

torvalds@linux-foundation.org wrote on Sun, 7 Nov 2021 11:05:02 -0800:

> On Sun, Nov 7, 2021 at 8:46 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> >
> > This is the MTD PR for 5.16.  
> 
> I want _explanations_ for what I'm pulling.
> 
> Yes, I can see it by looking at the diffs and shortlog, but I shouldn't need to.
> 
> I want a short blurb about what the pull is getting me, and why I
> should pull it, not just a "here's a random pull".

Sorry for the error, as you can see in the original e-mail, I generated
the pull request aginst 'mtd/next' (the branch name), instead of
'mtd/for-5.16', the signed tag with the below description written for
the occasion. I am going to resend the pull-request with these missing
bits.

----------------------------------------------------------------
Core:
* Remove obsolete macros only used by the old nand_ecclayout struct
* Don't remove debugfs directory if device is in use
* MAINTAINERS:
  - Add entry for Qualcomm NAND controller driver
  - Update the devicetree documentation path of hyperbus

MTD devices:
* block2mtd:
  - Add support for an optional custom MTD label
  - Minor refactor to avoid hard coded constant
* mtdswap: Remove redundant assignment of pointer eb

CFI:
* Fixup CFI on ixp4xx

Raw NAND controller drivers:
* Arasan:
  - Prevent an unsupported configuration
* Xway, Socrates: plat_nand, Pasemi, Orion, mpc5121, GPIO, Au1550nd, AMS-Delta:
  - Keep the driver compatible with on-die ECC engines
* cs553x, lpc32xx_slc, ndfc, sharpsl, tmio, txx9ndfmc:
  - Revert the commits: "Fix external use of SW Hamming ECC helper"
  - And let callers use the bare Hamming helpers
* Fsmc: Fix use of SM ORDER
* Intel:
  - Fix potential buffer overflow in probe
* xway, vf610, txx9ndfm, tegra, stm32, plat_nand, oxnas, omap, mtk, hisi504,
  gpmi, gpio, denali, bcm6368, atmel:
  - Make use of the helper function devm_platform_ioremap_resource{,byname}()

Onenand drivers:
* Samsung: Drop Exynos4 and describe driver in KConfig

Raw NAND chip drivers:
* Hynix: Add support for H27UCG8T2ETR-BC MLC NAND

SPI NOR core:
* Add spi-nor device tree binding under SPI NOR maintainers

SPI NOR manufacturer drivers:
* Enable locking for n25q128a13

SPI NOR controller drivers:
* Use devm_platform_ioremap_resource_byname()

----------------------------------------------------------------

> 
> I wrote my own explanation, and then decided that no, I'm not going to
> pull at all because the pull request was so bad and deficient.

I hope you will reconsider this position when I will re-send the
actual pull request with the above text which was missing.

Thanks,
Miquèl
