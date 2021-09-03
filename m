Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E83C13FFF5E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 13:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349055AbhICLsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 07:48:32 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:53125 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349000AbhICLsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 07:48:31 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id A045022205;
        Fri,  3 Sep 2021 13:47:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1630669650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TIPw+8GjiPG4C5PCTRG+FeBYw9sL+9OSm0iYayZZSNw=;
        b=WGXdV57HuKudCZWXWNPsTWvTIlZ2D+1pSI12Tv7me1slnKFxJmnrGoiTU2LixULUSIASpG
        kMuhQbrtdgiH1d2fvX5w1aKduhguRAoDjMzQSRr5UeZ0t6Mzj1axe+PrpFUNA0Q9NDatL9
        9Aq4THFiUR0Bw+qg2udRqrWnDIcNGMg=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 03 Sep 2021 13:47:29 +0200
From:   Michael Walle <michael@walle.cc>
To:     Andrea Zanotti <andreazanottifo@gmail.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: spi-nor: micron-st: added support for np8p128ax60
In-Reply-To: <CAGiusB29O+sNn9j2U9-VG0QV=9npUuWV=d5_sLyqD54SRgq9qA@mail.gmail.com>
References: <20210831081329.27420-1-andrea.zanotti@tyvak.eu>
 <3462300528bbe71207ef2164411e34d2@walle.cc>
 <CAGiusB1JvHkX7GSvD2JsqKWwC5xBePX_ruWk9nU9gugoroLnKA@mail.gmail.com>
 <CAGiusB0B5dN_K+bW1xudmT6UNmVOL=voBOuSVJeiYo3v6ywO8w@mail.gmail.com>
 <4bf9396505975e3fee2cc6396a6eeff7@walle.cc>
 <CAGiusB29O+sNn9j2U9-VG0QV=9npUuWV=d5_sLyqD54SRgq9qA@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <0719218e274bdffdf76b8689072530d3@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrea,

Am 2021-09-01 13:20, schrieb Andrea Zanotti:
> I performed the test with drivers/misc/eeprom/at25.c.
> 
> I configured the DTS as such:
> spi_pcm@0 {
> compatible = "atmel,at25";
> reg = <0>;
> spi-max-frequency = <50000000>;
> size = <16777216>;
> pagesize = <64>;
> address-width = <24>;
> label = "micron_pcm";
> };
> and activated the driver itself in the kernel configuration.
> 
> I think the system is recognizing it:
> # ls -l /sys/bus/spi/devices/spi0.0/eeprom
> -rw-------    1 root     root      16777216 Jan  1 00:01
> /sys/bus/spi/devices/spi0.0/eeprom
> 
> However, if I am not wrong (again, please correct me if I am wrong)
> this driver does not
> work with the MTD layer (I am booting with the following cmdline 
> bootargs:
> mtdparts=micron_pcm:128k(bootstrap),128k(fdt),10M(kernel/rootfs),-(spare)
> and I expected to have the same partitions as before, but of course
> they are missing.)

You are correct, there is no mtd layer for an eeprom device. If you
need the partitioning, the at25 won't work.

> I am checking the Company ID on the document "JEP106BC", revisioned on
> June 2020,
> downloaded from here 
> https://www.jedec.org/system/files/docs/JEP106BC.pdf.

Btw theres one from Feb 2021, but it doesn't really matter.

> STMicroelectronics should be 20
> Micron should be 2C

which matches the micron_parts[] and st_parts[].

> Intel is advertised as 89, in Table 1 "Manufacturer's Identification 
> Code".
> 
> How do you suggest to proceed?

I'm not sure, it this flash was originally made by intel or if its a
mistake. If its made by intel it probably should go into intel.c

Tudor is working on a larger patchset which addresses flash id
collisions [1]. If it is a mistake, then it should probably go into
the new collisions table which is introduced in this patchset.

Btw. AFAIK new flash additions are delayed until that patchset
is merged.

[1] 
https://lore.kernel.org/linux-mtd/20210727045222.905056-1-tudor.ambarus@microchip.com/

-michael
