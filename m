Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 098053FC468
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 11:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240387AbhHaIk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 04:40:27 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:35915 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240383AbhHaIkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 04:40:24 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 62C0722178;
        Tue, 31 Aug 2021 10:39:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1630399167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Al9hxpy89OFqGr1jtl5s3SCyXzCKTUzg1d1GPfZ1mFA=;
        b=EVPMi+6swXoY0LQIiBrX70aI80A1jgGU7o4YAJZEZVW00UfVnMoSPIpDNVAnPNkUhO0Y/A
        IdSViWYiF9u4z6A4AsTkgGSHzmBN1WGjPcqwzX4m6pb2v/Ae6T6qBybJYofRRPvvZvxaq2
        H83VD51+I/uTvyyalS9Q/erh/O8qQuk=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 31 Aug 2021 10:39:27 +0200
From:   Michael Walle <michael@walle.cc>
To:     Andrea Zanotti <andreazanottifo@gmail.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: spi-nor: micron-st: added support for np8p128ax60
In-Reply-To: <20210831081329.27420-1-andrea.zanotti@tyvak.eu>
References: <20210831081329.27420-1-andrea.zanotti@tyvak.eu>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <3462300528bbe71207ef2164411e34d2@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrea,

Am 2021-08-31 10:13, schrieb Andrea Zanotti:
> From: Andrea Zanotti <andreazanottifo@gmail.com>
> 
> Added support for P8P Parallel Phase Change Memory.

Please use present tense, eg "add support..."

Is there a public datasheet? If so, please include it above
your SoB like so:
Datasheet: https://...

> Added memory information (page size and sector size) as per data-
> sheet information, after typos corrections.

After typos corrections?

> At page 37, paragraph 'SPI Memory Organization', it is written
> down that the memory is organized as:
>  * 16.772.216 bytes (typo here, there 16.777.216 bytes)
>  * 128 sectors of 128 Kbytes each (correct)
>  * 131.072 pages of 64 bytes each (typo here, as the total would be
>    64Mbit, but the total memory is actually 128Mbit, correct value
>    is 262.144 pages)
> 
> Patch tested against the aforementioned PCM memory.

What SPI host controller was used?

> No known regressions inserted, as the patch only adds the possibility
> to recognize said PCM memory inside the common spi-nor driver.

Please drop this. If there were any regressions, the patch wouldn't
be picked up anyway.

> 
> Signed-off-by: Andrea Zanotti <andreazanottifo@gmail.com>
> ---
>  drivers/mtd/spi-nor/micron-st.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mtd/spi-nor/micron-st.c 
> b/drivers/mtd/spi-nor/micron-st.c
> index c224e59820a1..c78331451082 100644
> --- a/drivers/mtd/spi-nor/micron-st.c
> +++ b/drivers/mtd/spi-nor/micron-st.c
> @@ -128,6 +128,7 @@ static const struct flash_info micron_parts[] = {
>  	{ "mt35xu02g", INFO(0x2c5b1c, 0, 128 * 1024, 2048,
>  			    SECT_4K | USE_FSR | SPI_NOR_OCTAL_READ |
>  			    SPI_NOR_4B_OPCODES) },
> +	{ "np8p128ax60", {0x89, 0xda, 0x18}, 3, 128 * 1024, 128, 64, 0, 0 },

Eh? Please use INFO(). And why isn't this 0x20 for micron.

I found this datasheet:
https://media.digikey.com/pdf/Data%20Sheets/Micron%20Technology%20Inc%20PDFs/NP8P128Ax60E_Rev_K.pdf

According to that datasheet, the manuf id is 0x20. And the device id
should be either 0x88e1 or 0x8821.

>  };
> 
>  static const struct flash_info st_parts[] = {

-- 
-michael
