Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3559F3EF13B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 20:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbhHQSDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 14:03:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:36876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229918AbhHQSDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 14:03:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D5B3260F11;
        Tue, 17 Aug 2021 18:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629223356;
        bh=p/KrINRe2L2s1MrUVSOIU9Et1ymMM6absnQq9OHDTfo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nQwVGDh5zdlAUDqmzesTek/bF/OjT6rcNfG6weuPOned8usXETgsBB2ro0R8i3afP
         w+KcQpiZKj0mFdXGX3JV7RASfx5TtbQOzqpXBMaLhQ6WuN5KjxNMKxdfsjjYsAVFXi
         LsjN1Yt0pgYAlSb8iZDmhinrsxQ90KGT2gdkDrz8=
Date:   Tue, 17 Aug 2021 20:02:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     Phillip Potter <phil@philpotter.co.uk>, Larry.Finger@lwfinger.net,
        martin@kaiser.cx, fmdefrancesco@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] staging: r8188eu: perform cleanup in
 rtl8188e_Add_RateATid
Message-ID: <YRv5uk84xcu78WKl@kroah.com>
References: <20210816234459.132239-1-phil@philpotter.co.uk>
 <20210816234459.132239-4-phil@philpotter.co.uk>
 <d9a12b30-07bf-0c73-4a32-b2f4703998f3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9a12b30-07bf-0c73-4a32-b2f4703998f3@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 09:05:43AM +0200, Michael Straube wrote:
> On 8/17/21 1:44 AM, Phillip Potter wrote:
> > Perform some cleanup items in the rtl8188e_Add_RateATid function:
> > (1) Rename variable shortGIrate to short_gi_rate to comply with kernel
> >      camel case rules.
> > (2) Introduce additional whitespace around certain operators in the
> >      function, to make it clearer what is happening.
> > 
> > Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> > ---
> >   drivers/staging/r8188eu/hal/rtl8188e_cmd.c | 14 +++++++-------
> >   1 file changed, 7 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
> > index 77c057e276a5..8d03b24dc5af 100644
> > --- a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
> > +++ b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
> > @@ -155,25 +155,25 @@ void rtl8188e_Add_RateATid(struct adapter *pAdapter, u32 bitmap, u8 arg, u8 rssi
> >   {
> >   	struct hal_data_8188e *haldata = GET_HAL_DATA(pAdapter);
> > -	u8 macid, raid, shortGIrate = false;
> > +	u8 macid, raid, short_gi_rate = false;
> > -	macid = arg&0x1f;
> > +	macid = arg & 0x1f;
> > -	raid = (bitmap>>28) & 0x0f;
> > +	raid = (bitmap >> 28) & 0x0f;
> >   	bitmap &= 0x0fffffff;
> >   	if (rssi_level != DM_RATR_STA_INIT)
> >   		bitmap = ODM_Get_Rate_Bitmap(&haldata->odmpriv, macid, bitmap, rssi_level);
> > -	bitmap |= ((raid<<28)&0xf0000000);
> > +	bitmap |= ((raid << 28) & 0xf0000000);
> > -	shortGIrate = (arg&BIT(5)) ? true : false;
> > +	short_gi_rate = (arg & BIT(5)) ? true : false;
> > -	raid = (bitmap>>28) & 0x0f;
> > +	raid = (bitmap >> 28) & 0x0f;
> >   	bitmap &= 0x0fffffff;
> > -	ODM_RA_UpdateRateInfo_8188E(&haldata->odmpriv, macid, raid, bitmap, shortGIrate);
> > +	ODM_RA_UpdateRateInfo_8188E(&haldata->odmpriv, macid, raid, bitmap, short_gi_rate);
> >   }
> >   void rtl8188e_set_FwPwrMode_cmd(struct adapter *adapt, u8 Mode)
> > 
> 
> Perhaps the added spaces around operators could conflict with
> pending patch sets that address spacing style issues, otherwise...

Yeah, it conflicted too much, so I couldn't apply this one.

Phillip, can you rebase and resend this one patch, your first 2 worked
just fine and are now in my tree.

thanks,

greg k-h
