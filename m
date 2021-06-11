Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBD93A3936
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 03:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbhFKBTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 21:19:05 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:48825 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230232AbhFKBTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 21:19:03 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id DDE8D1DF6;
        Thu, 10 Jun 2021 21:17:05 -0400 (EDT)
Received: from imap4 ([10.202.2.54])
  by compute4.internal (MEProxy); Thu, 10 Jun 2021 21:17:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com.au;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm3; bh=4sxdG4q+15yHQGW5lRuvgFSziTf+
        hurlcQZJNxGSOEQ=; b=Jq9FWY4M1upTIJVLDh/s1xWjGgFyjmLU4seS8WY7qxiz
        FfAgm02+WnN/rGcHACnas4Tdb3e4rBVwZiECoFd1+fNNGgo1uuNLU4AAfVcHwPSa
        Y+l6Rz+zBSuXfWJ3KEcDmq8haQUpYdu7Yci4Jr4Ljg7BeBByMNCSF+xK6zMhg7uk
        tZKvwtansddJ5yoxpDC33wkPm9oP4qCSyeY1kPn8kX1UcC7ADy1GEI+++fwwpR/C
        xNpFVZPoNPDZKMCAOhBgPuyxPPQJYJ/ro5AQGE+u0F7J0BUoXpMrdruSjaOXJBZ9
        nsPi5pb4I3yf4RsFTrp0OkhA2QpDxd2WXqH4Q5GXRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=4sxdG4
        q+15yHQGW5lRuvgFSziTf+hurlcQZJNxGSOEQ=; b=jltkaWtXugPkCc4ZCtw/I3
        PygpJ4nHPCt07sKPUc8nOXZqPbCoqqlL9ld/Tldk+qbVjrXwoT+Aqa20VpyeVEfm
        ioTTRlDvbS0KMu0U8XmURcnCl0m7VXsMwP8TMpCy9rqKOJPhIYLFhy2dlEvTuW9Y
        h80pYvsyGdE6TNhLCS+MC9vitkITdCNZHHjtnpZMB6/kLxixdLdWo6K6mE3NUOQS
        GXF/1XekotziUHo4I7UhtgtEJWoi8lAVFGnHPvv+uSIvmhSEdZEeDdalnHOJs7vf
        jNi9YI3PD5Whi/dAcDrilWYLfwvQQgmEixoTvcJeqyCvbXKcJ168F2a8ixSEaekQ
        ==
X-ME-Sender: <xms:j7nCYGld4ZhBGsnjBMMPs2oMiw0WhM9DDJyA-VfKlB440VgHLCB3cA>
    <xme:j7nCYN03owRzIJroWUsLilaS1Wfwfeff9W1HaOpV5S2raqT0P0wayzY2_IB8wpWgS
    BIyz7wiTuoMIgd0EA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeduiedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdflohhh
    nhcuvfhhohhmshhonhdfuceoghhithesjhhohhhnthhhohhmshhonhdrfhgrshhtmhgrih
    hlrdgtohhmrdgruheqnecuggftrfgrthhtvghrnhepffduudeffeegfffghfdvleevudei
    leelfeegffefgeeileekieeftddvueehffdtnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepghhithesjhhohhhnthhhohhmshhonhdrfhgrshht
    mhgrihhlrdgtohhmrdgruh
X-ME-Proxy: <xmx:j7nCYEqvy7pxgnAHuPLeaQkRsRWurvAUlt1ImN-0NvEpF7iwMViOEQ>
    <xmx:j7nCYKmKUZHzv1XcJlXcxuTmyAZUm8RUkP5ozGd8QON8b1Mk2jfQgA>
    <xmx:j7nCYE2kW8DLjL5WwkkNwKA2sjQdBhG1iojmwk7k5c54ZNVCnT-k7w>
    <xmx:kbnCYFlzbpZ9FKjCFM3ZHpspgzBNDPyyYJcZ6Ol7wF6rGT8xm_KRVA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id BBEA816013E; Thu, 10 Jun 2021 21:17:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-519-g27a961944e-fm-20210531.001-g27a96194
Mime-Version: 1.0
Message-Id: <55d28fea-c20e-4e60-8b5b-b5a03ccea0cf@www.fastmail.com>
In-Reply-To: <20210610100759.v57c5wa46ky33waj@ti.com>
References: <20210608040719.14431-1-git@johnthomson.fastmail.com.au>
 <20210610100759.v57c5wa46ky33waj@ti.com>
Date:   Fri, 11 Jun 2021 01:15:24 +0000
From:   "John Thomson" <git@johnthomson.fastmail.com.au>
To:     "Pratyush Yadav" <p.yadav@ti.com>
Cc:     "Miquel Raynal" <miquel.raynal@bootlin.com>,
        "Richard Weinberger" <richard@nod.at>,
        "Vignesh Raghavendra" <vigneshr@ti.com>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>,
        "Michael Walle" <michael@walle.cc>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, "kernel test robot" <lkp@intel.com>,
        "Dan Carpenter" <dan.carpenter@oracle.com>
Subject: Re: [PATCH] mtd: spi-nor: write support for minor aligned partitions
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jun 2021, at 10:08, Pratyush Yadav wrote:
> On 08/06/21 02:07PM, John Thomson wrote:
> > Do not prevent writing to mtd partitions where a partition boundary sits
> > on a minor erasesize boundary.
> > This addresses a FIXME that has been present since the start of the
> > linux git history:
> > /* Doesn't start on a boundary of major erase size */
> > /* FIXME: Let it be writable if it is on a boundary of
> >  * _minor_ erase size though */
> > 
> > Allow a uniform erase region spi-nor device to be configured
> > to use the non-uniform erase regions code path for an erase with:
> > CONFIG_MTD_SPI_NOR_USE_VARIABLE_ERASE=y
> > 
> > On supporting hardware (SECT_4K: majority of current SPI-NOR device)
> > provide the facility for an erase to use the least number
> > of SPI-NOR operations, as well as access to 4K erase without
> > requiring CONFIG_MTD_SPI_NOR_USE_4K_SECTORS
> > 
> > Introduce erasesize_minor to the mtd struct,
> > the smallest erasesize supported by the device
> 
> Instead of having just a major and minor erase size, wouldn't it make 
> more sense to have a list of all supported erases on a sector? That is, 
> instead of hard coding two erase size instead of one, how about 
> generalizing the erase machinery to allow any number of erase sizes on a 
> sector and then choosing the most efficient one on run time?
> 
> For example, imagine a device can support 4K, 64K, and 256K erases on 
> each sector. Then you should be able to use 2 x 4K erases if you want to 
> erase 8K, 2 x 64K + 1 x 4K erases for 132K and so on.

Thank for you the feedback Pratyush,

Yes, this is what I am attempting to do.
mtdpart only sets if the partition can be writeable, it does not do the erasing.
Due to this, I thought that only the smallest erasesize should matter to mtdpart.
The erase is carried out by the mtd device, so for an SPI-NOR device,
spi_nor_erase_multi_sectors can be used to select and action the best combination of erases.
This is done by this patch when CONFIG_MTD_SPI_NOR_USE_VARIABLE_ERASE=y

Cheers,
-- 
  John Thomson
