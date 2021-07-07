Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78C0C3BE831
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 14:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbhGGMto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 08:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbhGGMtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 08:49:42 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FDCC061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 05:47:01 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 88DFE22239;
        Wed,  7 Jul 2021 14:46:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1625662020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qo7IrCTVE14UKRC2CdDWYJ11m1JINF0MvvrqxzPwY3E=;
        b=lVB/mAdpyGVqTGaBJKxuwnkrbejg7HMYL5m42dvn0PM708h38NRq+Y5cAj8uCtWVAvSNSE
        ZNCGlm3kVF0pEiZKzOgR8jIPUON85s/Lb+v6vP+DKXUn6IA/Hp1XNYIs33qe3kviv2984L
        B/ZggPZUe6XscBGFd4PN8ZjsED2Y1RM=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 07 Jul 2021 14:46:59 +0200
From:   Michael Walle <michael@walle.cc>
To:     MODEL WORK LST <lstfazz@gmail.com>
Cc:     tudor.ambarus@microchip.com, p.yadav@ti.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd:spi-nor:Update Winbond SPI NOR Flash device ID
In-Reply-To: <CALEtjnoT1BP5OHmf3xGBGV4o-Xc-vfGR8eLzdM5-Udc_ujxokA@mail.gmail.com>
References: <20210707101628.GA27472@pn10-Veriton-X4610>
 <35c2e5faa770e228bd16a2186c8caf78@walle.cc>
 <CALEtjnoT1BP5OHmf3xGBGV4o-Xc-vfGR8eLzdM5-Udc_ujxokA@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <59959af0f756109b02fb7c19f88c35d1@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 2021-07-07 13:58, schrieb MODEL WORK LST:
> Shame on me, I don't use the plain text to reply.
> Please allow me send again.

Please also avoid top-posting ;)

> It is my first time update patch for Linux, please advise me if I do 
> wrong.

No worries!

> We are testing these device by the NXP evaluation board.

Ok, this should then go into the commit message, too. Usually the SoC 
and
the SPI controller which was used for testing go in there.

> But the running Linux revision for that board is still 4.x. To update
> the latest ID,
> should we prepare the system that can work with latest Linux revision?

Yes that would be preferable, either use spi-nor/next or just linux-next
[1]. There, my patches for dumping/reading the SFDP are already 
integrated.

> For the test process, I was wondering to ask mount the device to UBIFS
> is a good way for test?

It depends what flags or features are you plan to support. Ususually,
reading/writing the raw mtd device will be enough. If you also add 
locking
support, for example, you should also test the locking by using the
mtd-utils.

I'd say testing whole UBIFS is overkill. Bascially you will just make
sure reading and writing is possible. And if the results make sense, eg.
does it actually use Quad I/O or Dual I/O.

Also look at dmesg and see if it is probed correctly.

> For the ID, this time we add new ID that is not include in the 
> flash_info[].
> And we would keep our device who share the same ID have compatible
> with each other.
> Make sure the FW or SW only need to maintain an unique for each 
> density.
> If the same density device have different behavior, Winbond would apply 
> new ID.

Oh I wasn't clear here. FW is not firmware but your 'FW' model. Eg.
the W25Q32FW. In my experience it shared the same id with W25Q32JW,
if I remember correctly.

We do have many problems with vendors sharing the same flash id between
different flash models which then have different features; we have
a hard time distinguish them at runtime because they appear to be
the same by looking at the JEDEC id.

So if you are aware of any other winbond flashes which reuse the
IDs which you are adding below, that would be good to know.

And to make you/Winbond aware that this is not really good and
if possible should be avoided for future chips.

> Or have application note for customer to aware the difference.

The problem is not the difference, but the fact that we cannot
detect it on runtime.

> For the SFDP, I would check how to work and fill the information.

Great. Thanks!

-michael
