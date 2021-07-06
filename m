Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1183BDB68
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 18:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhGFQbw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 6 Jul 2021 12:31:52 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:56745 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbhGFQbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 12:31:51 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id D93D7100004;
        Tue,  6 Jul 2021 16:29:09 +0000 (UTC)
Date:   Tue, 6 Jul 2021 18:29:08 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Tudor.Ambarus@microchip.com, michael@walle.cc,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        richard@nod.at, vigneshr@ti.com
Subject: Re: [PATCH] mtd: core: handle flashes without OTP gracefully
Message-ID: <20210706182908.3cf82669@xps13>
In-Reply-To: <2716acf0-fcf1-d2ef-83be-152d0300d687@roeck-us.net>
References: <20210702093841.32307-1-michael@walle.cc>
        <9bb2acac-aeb8-d2b2-8df0-9acfd972ec5d@microchip.com>
        <9F46D75C-D00D-4577-A337-7411049EC7D9@walle.cc>
        <8da3d84e-dfbf-2030-98b4-148362d22f52@microchip.com>
        <2716acf0-fcf1-d2ef-83be-152d0300d687@roeck-us.net>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

Guenter Roeck <linux@roeck-us.net> wrote on Sat, 3 Jul 2021 10:26:06
-0700:

> On 7/3/21 9:42 AM, Tudor.Ambarus@microchip.com wrote:
> > On 7/3/21 7:08 PM, Michael Walle wrote:  
> >> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >>
> >> Am 3. Juli 2021 11:56:14 MESZ schrieb Tudor.Ambarus@microchip.com:  
> >>> On 7/2/21 12:38 PM, Michael Walle wrote:  
> >>>> EXTERNAL EMAIL: Do not click links or open attachments unless you  
> >>> know the content is safe  
> >>>>
> >>>> There are flash drivers which registers the OTP callbacks although  
> >>> the  
> >>>> flash doesn't support OTP regions and return -ENODATA for these
> >>>> callbacks if there is no OTP. If this happens, the probe of the whole  
> >>>
> >>> why do they register the OTP callback if they don't support OTP?  
> >>
> >> I don't know. But I certainly won't touch that code :p  
> > 
> > why? :D
> >   
> >>
> >>  
> >>>> flash will fail. Fix it by handling the ENODATA return code and skip
> >>>> the OTP region nvmem setup.
> >>>>
> >>>> Fixes: 4b361cfa8624 ("mtd: core: add OTP nvmem provider support")
> >>>> Reported-by: Guenter Roeck <linux@roeck-us.net>
> >>>> Signed-off-by: Michael Walle <michael@walle.cc>
> >>>> ---
> >>>>   drivers/mtd/mtdcore.c | 10 ++++++++--
> >>>>   1 file changed, 8 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
> >>>> index b5ccd3037788..6881d1423dd6 100644
> >>>> --- a/drivers/mtd/mtdcore.c
> >>>> +++ b/drivers/mtd/mtdcore.c
> >>>> @@ -880,7 +880,10 @@ static int mtd_otp_nvmem_add(struct mtd_info  
> >>> *mtd)  
> >>>>
> >>>>          if (mtd->_get_user_prot_info && mtd->_read_user_prot_reg) {
> >>>>                  size = mtd_otp_size(mtd, true);
> >>>> -               if (size < 0)
> >>>> +               /* ENODATA means there is no OTP region */
> >>>> +               if (size == -ENODATA)  
> >>>
> >>> If no OTP data, maybe it's more appropriate for the clients to just
> >>> return a retlen of 0.  
> >>
> >> you mean already checking ENODATA in mtd_otp_size() and return 0. That would also make the hunk below unnecessary. I'll change it.  
> > 
> > I've thought about:
> > 
> > diff --git a/drivers/mtd/chips/cfi_cmdset_0001.c b/drivers/mtd/chips/cfi_cmdset_0001.c
> > index 54f92d09d9cf..9419b33d7238 100644
> > --- a/drivers/mtd/chips/cfi_cmdset_0001.c
> > +++ b/drivers/mtd/chips/cfi_cmdset_0001.c
> > @@ -2314,7 +2314,7 @@ static int cfi_intelext_otp_walk(struct mtd_info *mtd, loff_t from, size_t len,  
> >   >          /* Check that we actually have some OTP registers */  
> >          if (!extp || !(extp->FeatureSupport & 64) || !extp->NumProtectionFields)
> > -               return -ENODATA;
> > +               return 0;
> >   
> 
> There are various places where this is called, including code returning information
> to userspace. That means you'd be changing the ABI to userspace which would now suddenly
> return 0 instead of -ENODATA.

Yeah let's avoid this if possible, even though I liked Tudor's approach.

Would Michael proposal of checking it in mtd_otp_size() still affect
userspace? If not, having a single check over the -ENODATA return code
seems attractive.

Thanks,
Miquèl
