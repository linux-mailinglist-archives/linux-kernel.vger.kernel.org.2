Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0F83D7395
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 12:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236406AbhG0Kpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 06:45:41 -0400
Received: from mx1.tq-group.com ([93.104.207.81]:26933 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236320AbhG0Kpi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 06:45:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1627382738; x=1658918738;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IBaHE26ecbFT2WR+ipD7OHCSKKDIkgeOggpQrOqRaGE=;
  b=PGawoS700keFUrQyMIBFKPVRg7dYOU+UHccdYNfq8PjKH5w6kmAmU7iy
   0/2VMX7g+ZJ91kKeW+VUUYMJnLNIOxU/+yV1XcrMMmRd37BO+FIJqGzj7
   R/NHG9if5g7dz6IQqU964GDjhnDJ4IOqek0DZpUfaE0flfEJOnRvRTBq/
   S2hcldwB+XcWIfCIIYu6d4BhG7dPBxwD8CLSzbWdrAwiP40CkfSK8V75s
   ZJn17b4FvyaJlwqx//kI/+lFIDFTapiXVdM0LQN3WNOnfPvtFgh2xpjg9
   Hs5Mf09xtHOXo/mc0f5OHlVvQenW85tl0xsuBgjVLkcjgsXqmgsXXOtiv
   Q==;
X-IronPort-AV: E=Sophos;i="5.84,273,1620684000"; 
   d="scan'208";a="18662240"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 27 Jul 2021 12:45:37 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Tue, 27 Jul 2021 12:45:37 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Tue, 27 Jul 2021 12:45:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1627382737; x=1658918737;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IBaHE26ecbFT2WR+ipD7OHCSKKDIkgeOggpQrOqRaGE=;
  b=Ksng7V4lnewvS/L51Pywe8mO2/qneJgNf60gcDmpqUHokSyLIXHJVNpV
   RosnSnzwYPl2F2T4e27qgpa/wAf9aH51fstFvv2wk7IF0I5YvI8xQShhK
   yFggNOm0vDXwrxvcY8vYgDIDkaDRDPEtfTlxG3eKUM9Rrx+q2ztCOmTGG
   wMk/Zp10RlHyWQfELUxxzQxYxX1miHUug7dQI5OgHKBb+WLcAa4VrjOQc
   391diUQP0Z3rS95neFxh9MyIyjxDgEkvfE3YP8rtlUdl5/XlFp0DmJiMi
   wSPyS8Jb7vYN9GFbwxDIu/jsyOSZ0Qsg5orao7qjc4QEDxWzjunTN1N1C
   g==;
X-IronPort-AV: E=Sophos;i="5.84,273,1620684000"; 
   d="scan'208";a="18662239"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 27 Jul 2021 12:45:37 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.121.48.12])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 16580280070;
        Tue, 27 Jul 2021 12:45:37 +0200 (CEST)
Message-ID: <42380415413178b18e940ae80298c22c51275b95.camel@ew.tq-group.com>
Subject: Re: [PATCH 1/2] mtd: spi-nor: micron-st: sync flags of mt25ql02g
 and mt25qu02g with other mt25q
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Michael Walle <michael@walle.cc>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Tue, 27 Jul 2021 12:45:34 +0200
In-Reply-To: <f3dbab898e9f1946129e5733095bdf3c@walle.cc>
References: <c7b6c666aef9a8a2195acabe9954a417f04b6582.1627039534.git.matthias.schiffer@ew.tq-group.com>
         <f3dbab898e9f1946129e5733095bdf3c@walle.cc>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-07-27 at 09:09 +0200, Michael Walle wrote:
> Am 2021-07-23 13:27, schrieb Matthias Schiffer:
> > All mt25q variants have the same features.
> > 
> > Unlike the smaller variants, no n25q with 2G exists, so we don't need 
> > to
> > match on the extended ID to distinguish n25q and mt25q series for these
> > models.
> 
> But why shouldn't we? What if there will be another flash with
> the same first three id bytes?

That makes sense, I'll update my patch accordingly.

It looked to me like the current ID list only checks the extended ID
when necessary to distinguish two known flash models.


> 
> > Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> > ---
> >  drivers/mtd/spi-nor/micron-st.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/mtd/spi-nor/micron-st.c 
> > b/drivers/mtd/spi-nor/micron-st.c
> > index c224e59820a1..d5baa8762c8d 100644
> > --- a/drivers/mtd/spi-nor/micron-st.c
> > +++ b/drivers/mtd/spi-nor/micron-st.c
> > @@ -181,11 +181,11 @@ static const struct flash_info st_parts[] = {
> >  			      SECT_4K | USE_FSR | SPI_NOR_QUAD_READ |
> >  			      NO_CHIP_ERASE) },
> >  	{ "mt25ql02g",   INFO(0x20ba22, 0, 64 * 1024, 4096,
> > -			      SECT_4K | USE_FSR | SPI_NOR_QUAD_READ |
> > -			      NO_CHIP_ERASE) },
> 
> This bothers me. I'm not sure how this will work. I see that
> chip erase is command 0xc7, but both the new and the old flash
> just supports 0xc3 (DIE ERASE). Did you test these changes?

Thanks for catching this. I overlooked that the 1G and 2G variants
don't support the same erase commands as the smaller versions after
all... It is possible that I only tested this with partitioned MTD, so
I didn't hit the whole-chip erase case.

Which command should I use to test the chip erase? Will a `flash_erase
/dev/mtdX 0 0` trigger the correct operation?




> 
> > +			      SECT_4K | USE_FSR | SPI_NOR_DUAL_READ |
> > +			      SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
> >  	{ "mt25qu02g",   INFO(0x20bb22, 0, 64 * 1024, 4096,
> >  			      SECT_4K | USE_FSR | SPI_NOR_DUAL_READ |
> > -			      SPI_NOR_QUAD_READ | NO_CHIP_ERASE) },
> > +			      SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
> > 
> >  	{ "m25p05",  INFO(0x202010,  0,  32 * 1024,   2, 0) },
> >  	{ "m25p10",  INFO(0x202011,  0,  32 * 1024,   4, 0) },
> 
> -michael

