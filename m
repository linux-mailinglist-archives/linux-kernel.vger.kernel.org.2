Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE8D3B0371
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 13:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbhFVL7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 07:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbhFVL7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 07:59:22 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6422AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 04:57:06 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 4E2422224B;
        Tue, 22 Jun 2021 13:57:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1624363022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cW9h5DpBp2GZE/dsC+UBUW7ysGWDsL3QGU2yDtMlmus=;
        b=SLcnPRPI/Opz8E0XbrxIDkbvtIafbj1EBQPzY8au0k8lMxdichOhxwNUB5PRA8h9DQ70/P
        3iHryxJZioyWa7Fwx3srHBjbFezv0en/11Ee04M8QHJ/624mLet6VnvhygnofN3PRUwZ64
        KpHWCxYf5cKQOndY1yeanQWEzXKyWBE=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 22 Jun 2021 13:57:00 +0200
From:   Michael Walle <michael@walle.cc>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     linux-mtd@lists.infradead.org,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>, linux-kernel@vger.kernel.org,
        Esben Haabendal <esben@geanix.com>,
        Zhengxun Li <zhengxunli@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>, masonccyang@mxic.com.tw,
        ycllin@mxic.com.tw
Subject: Re: [RFC 2/3] mtd: spi-nor: core: compare JEDEC bytes to already
 found flash_info
In-Reply-To: <20210621152320.3811194-3-linux@rasmusvillemoes.dk>
References: <20210621152320.3811194-1-linux@rasmusvillemoes.dk>
 <20210621152320.3811194-3-linux@rasmusvillemoes.dk>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <223232ecd0865e819477f17cd464ab08@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+ some people from MXIC as they are ones who posted to the ML
lately. Feel free to forward this mail to the corresponding people.]

Am 2021-06-21 17:23, schrieb Rasmus Villemoes:
> Macronix engineers, in their infinite wisdom, have a habit of reusing
> JEDEC ids for different chips. There's already one
> workaround (MX25L25635F v MX25L25635E), but the same problem exists
> for MX25L3205D v MX25L3233F, the latter of which is not currently
> supported by linux.
> 
> AFAICT, that case cannot really be handled with any of the ->fixup
> machinery: The correct entry for the MX25L3233F would read
> 
>         { "mx25l3233f",  INFO(0xc22016, 0, 64 * 1024,  64, SECT_4K |
> SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ ) },
> 
> while the existing one is
> 
> 	{ "mx25l3205d",  INFO(0xc22016, 0, 64 * 1024,  64, SECT_4K) },
> 
> So in spi_nor_init_params(), we won't even try reading the sfdp
> info (i.e. call spi_nor_sfdp_init_params), and hence
> spi_nor_post_sfdp_fixups() has no way of distinguishing the
> chips.
> 
> Replacing the existing entry with the mx25l3233f one to coerce the
> core into issuing the SPINOR_OP_RDSFDP is also not really an option,
> because the data sheet for the mx25l3205d explicitly says not to issue
> any commands not listed ("It is not recommended to adopt any other
> code not in the command definition table, which will potentially enter
> the hidden mode.", whatever that means).

Maybe we should ask Macronix if it is safe to send the RDSFDP command.
Can anyone from MXIC comment this?
This is also interesting because we are discussing reading the SFDP
without reading the ID first.

Of course this will not save us from two different devices sharing
the same ID and both having no RDSFDP support.

> In order to support such cases, extend the logic in spi_nor_read_id()
> a little so that if we already have a struct flash_info* from the name
> in device tree, check the JEDEC bytes against that, and if it is a
> match, accept that (device tree compatible + matching JEDEC bytes) is
> stronger than merely matching JEDEC bytes.

This won't help much without a proper dt schema. No in-tree devicetree
could use is because the DT validation would complain. So if this will
go in (and the maintainers are rather hesitant to add it, I tried
it myself [1]), you'd also need to add it to jedec,spi-nor.yaml and
get an ack from Rob.

> This also makes initialization slightly faster in the common case
> where the flash_info was found from the name and the JEDEC bytes do
> match - it avoids a second linear search over all known chips.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

-michael

[1] 
https://lore.kernel.org/linux-mtd/20200103223423.14025-1-michael@walle.cc/
