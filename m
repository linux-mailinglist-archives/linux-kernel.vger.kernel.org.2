Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD89E318D40
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 15:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbhBKOWY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 11 Feb 2021 09:22:24 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:60685 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbhBKOJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 09:09:00 -0500
Received: from xps13 (aputeaux-654-1-105-167.w90-2.abo.wanadoo.fr [90.2.4.167])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id B9DC810000F;
        Thu, 11 Feb 2021 14:08:00 +0000 (UTC)
Date:   Thu, 11 Feb 2021 15:07:59 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Md Sadre Alam <mdalam@codeaurora.org>,
        boris.brezillon@collabora.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, vigneshr@ti.com,
        sricharan@codeaurora.org
Subject: Re: [PATCH V4] mtd: rawnand: qcom: update last code word register
Message-ID: <20210211150759.506f3463@xps13>
In-Reply-To: <20210210090144.GE19226@work>
References: <1611869959-5109-1-git-send-email-mdalam@codeaurora.org>
        <20210210090144.GE19226@work>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote on Wed,
10 Feb 2021 14:31:44 +0530:

> On Fri, Jan 29, 2021 at 03:09:19AM +0530, Md Sadre Alam wrote:
> > From QPIC version 2.0 onwards new register got added to
> > read last codeword. This change will add the READ_LOCATION_LAST_CW_n
> > register.
> > 
> > For first three code word READ_LOCATION_n register will be
> > use.For last code word READ_LOCATION_LAST_CW_n register will be
> > use.

Sorry for the late notice, I think the patch is fine but if you don't
mind I would like to propose a small change that should simplify your
patch a lot, see below.

> > 
> > Signed-off-by: Md Sadre Alam <mdalam@codeaurora.org>  
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> Thanks,
> Mani
> 
> > ---
> > [V4]
> >  * Modified condition for nandc_set_read_loc_last() in qcom_nandc_read_cw_raw().
> >  * Added one additional argument "last_cw" to the function config_nand_cw_read()
> >    to handle last code word condition.
> >  * Changed total number of last code word register "NAND_READ_LOCATION_LAST_CW_0" to 4
> >    while doing code word configuration.
> >  drivers/mtd/nand/raw/qcom_nandc.c | 110 +++++++++++++++++++++++++++++---------
> >  1 file changed, 84 insertions(+), 26 deletions(-)
> > 
> > diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
> > index 667e4bf..9484be8 100644
> > --- a/drivers/mtd/nand/raw/qcom_nandc.c
> > +++ b/drivers/mtd/nand/raw/qcom_nandc.c
> > @@ -48,6 +48,10 @@
> >  #define	NAND_READ_LOCATION_1		0xf24
> >  #define	NAND_READ_LOCATION_2		0xf28
> >  #define	NAND_READ_LOCATION_3		0xf2c
> > +#define	NAND_READ_LOCATION_LAST_CW_0	0xf40
> > +#define	NAND_READ_LOCATION_LAST_CW_1	0xf44
> > +#define	NAND_READ_LOCATION_LAST_CW_2	0xf48
> > +#define	NAND_READ_LOCATION_LAST_CW_3	0xf4c
> >  
> >  /* dummy register offsets, used by write_reg_dma */
> >  #define	NAND_DEV_CMD1_RESTORE		0xdead
> > @@ -187,6 +191,12 @@ nandc_set_reg(nandc, NAND_READ_LOCATION_##reg,			\
> >  	      ((size) << READ_LOCATION_SIZE) |			\
> >  	      ((is_last) << READ_LOCATION_LAST))
> >  
> > +#define nandc_set_read_loc_last(nandc, reg, offset, size, is_last)	\
> > +nandc_set_reg(nandc, NAND_READ_LOCATION_LAST_CW_##reg,			\
> > +	      ((offset) << READ_LOCATION_OFFSET) |		\
> > +	      ((size) << READ_LOCATION_SIZE) |			\
> > +	      ((is_last) << READ_LOCATION_LAST))
> > +

You could rename the macro nandc_set_read_loc() into
nandc_set_read_loc_first() or anything else that make sense, then have
a helper which does:

nandc_set_read_loc()
{
	if (condition for first)
		return nandc_set_read_loc_first();
	else
		return nandc_set_read_loc_last();
}

And in the rest of your patch you won't have to touch anything else.

Thanks,
Miquèl
