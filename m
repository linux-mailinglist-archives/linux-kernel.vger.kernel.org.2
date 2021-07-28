Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5093D8B4F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 12:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235910AbhG1KAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 06:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235847AbhG1KAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 06:00:12 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4C4C061757
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 03:00:10 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 2F77822172;
        Wed, 28 Jul 2021 12:00:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1627466408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u1GoZExlDzTQpKZA+eG2D88Yx9YFdj8G9GDiUD8vIq0=;
        b=CPaVtWOQXWhptSMQBNQn6zwEqgjJ4u+oO/QSpZ0VsTQz85C+YCdPWXRe7Eg/Sg8SPosAZX
        YS0pfTSLIK2/7A+EkwHGLSjzIZLKbvZ5wTZLSYRNXF6T23BLTGmEAFMUNSLBaYCUt4nEse
        fQzIkaYV7oS7DuKGWP2MDx6EGtFE3iI=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 28 Jul 2021 12:00:07 +0200
From:   Michael Walle <michael@walle.cc>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mtd: spi-nor: micron-st: sync flags of mt25ql02g and
 mt25qu02g with other mt25q
In-Reply-To: <42380415413178b18e940ae80298c22c51275b95.camel@ew.tq-group.com>
References: <c7b6c666aef9a8a2195acabe9954a417f04b6582.1627039534.git.matthias.schiffer@ew.tq-group.com>
 <f3dbab898e9f1946129e5733095bdf3c@walle.cc>
 <42380415413178b18e940ae80298c22c51275b95.camel@ew.tq-group.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <cebfb4138908d085791c5c2fddca939d@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-07-27 12:45, schrieb Matthias Schiffer:
> On Tue, 2021-07-27 at 09:09 +0200, Michael Walle wrote:
[..]
>> > --- a/drivers/mtd/spi-nor/micron-st.c
>> > +++ b/drivers/mtd/spi-nor/micron-st.c
>> > @@ -181,11 +181,11 @@ static const struct flash_info st_parts[] = {
>> >  			      SECT_4K | USE_FSR | SPI_NOR_QUAD_READ |
>> >  			      NO_CHIP_ERASE) },
>> >  	{ "mt25ql02g",   INFO(0x20ba22, 0, 64 * 1024, 4096,
>> > -			      SECT_4K | USE_FSR | SPI_NOR_QUAD_READ |
>> > -			      NO_CHIP_ERASE) },
>> 
>> This bothers me. I'm not sure how this will work. I see that
>> chip erase is command 0xc7, but both the new and the old flash
>> just supports 0xc3 (DIE ERASE). Did you test these changes?
> 
> Thanks for catching this. I overlooked that the 1G and 2G variants
> don't support the same erase commands as the smaller versions after
> all... It is possible that I only tested this with partitioned MTD, so
> I didn't hit the whole-chip erase case.
> 
> Which command should I use to test the chip erase? Will a `flash_erase
> /dev/mtdX 0 0` trigger the correct operation?

I guess so. Looking at
http://git.infradead.org/mtd-utils.git/blob/HEAD:/misc-utils/flash_erase.c#l226

It seems you should see a different output for either erasing individual
sectors or the whole chip (as long as the kernel doesn't the invidual
block erase itself).

-michael
