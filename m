Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C158034FE4F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 12:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235081AbhCaKsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 06:48:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:42238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234862AbhCaKsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 06:48:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 32B0F61987;
        Wed, 31 Mar 2021 10:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617187703;
        bh=O6ieHr8I3yaotirsH6KOgZ5umW1SP2G8KC8Q3s/FBmM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CrkfkOJm9RgIXO1VN6+C1viEXBsDwsNYOdzQMXxXoloFWTwB5PuWL9S4I2YS1nwuS
         bKqSJpAAnL1UJMU4scSudYhmT0aWoeFI1ZXPGdI1TLyG1TqfxTLonipQ6gKTGwxfu4
         VKB9A9yctWy7AW47UbkxU+m1Kg9rPZWExsGUceng=
Date:   Wed, 31 Mar 2021 12:48:20 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/40] staging: rtl8723bs: replace RT_TRACE with public
 printk wrappers in core/rtw_eeprom.c
Message-ID: <YGRTdBWseZw72rae@kroah.com>
References: <cover.1617183374.git.fabioaiuto83@gmail.com>
 <39c2cd878bc914a00e71ea988c3cacb651670822.1617183374.git.fabioaiuto83@gmail.com>
 <YGROiD19tgF8XnK6@kroah.com>
 <20210331103630.GA1450@agape.jhs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331103630.GA1450@agape.jhs>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021 at 12:36:31PM +0200, Fabio Aiuto wrote:
> On Wed, Mar 31, 2021 at 12:27:20PM +0200, Greg KH wrote:
> > On Wed, Mar 31, 2021 at 11:39:31AM +0200, Fabio Aiuto wrote:
> > > replace private macro RT_TRACE for tracing with in-kernel
> > > pr_* printk wrappers
> > > 
> > > Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
> > > ---
> > >  drivers/staging/rtl8723bs/core/rtw_eeprom.c | 26 ++++++++++-----------
> > >  1 file changed, 13 insertions(+), 13 deletions(-)
> > > 
> > > diff --git a/drivers/staging/rtl8723bs/core/rtw_eeprom.c b/drivers/staging/rtl8723bs/core/rtw_eeprom.c
> > > index 3cbd65dee741..6176d741d60e 100644
> > > --- a/drivers/staging/rtl8723bs/core/rtw_eeprom.c
> > > +++ b/drivers/staging/rtl8723bs/core/rtw_eeprom.c
> > > @@ -36,7 +36,7 @@ void shift_out_bits(_adapter *padapter, u16 data, u16 count)
> > >  _func_enter_;
> > >  
> > >  	if (padapter->bSurpriseRemoved == true) {
> > > -		RT_TRACE(_module_rtl871x_eeprom_c_, _drv_err_, ("padapter->bSurpriseRemoved==true"));
> 
> I looked at this ---------------------------------------^
> and so I thought that pr_err was good...

But you missed the fact that RT_TRACE() does not always spit this stuff
out.

And I don't know what _drv_err_ is, but tracing messages should never go
to an error log :)

> my aim was remove private macros replicating component tracing and log levels...

That's a great goal!

> so what's best? Keep a simplyfied RT_TRACE encapsulating a dev_* call?

replace them with dev_dbg() is one way, if they really are even needed
at all.  At this point in time, I would strongly just recommend removing
them all as no one is using them for anything.

thanks,

greg k-h
