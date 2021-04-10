Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1788A35ACF8
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 13:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234464AbhDJLdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 07:33:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:49246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231279AbhDJLdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 07:33:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2CF54610CD;
        Sat, 10 Apr 2021 11:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618054415;
        bh=PuEewjDW4FzdjB+FsG31MbGgERKfTa+r9b7m7c8iqdk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XY7udFxQg9sjt67lRQ2/4DzUrWDqPKvXe8LMDjm+IOK5zDmB/8M5ivy4fCJcwU57h
         wY/Ny3Ntqf1Itl2XFzTSEisQUY0fb0uFWZIJjH5XCFb/x+ob76cU49HZtFwB8UHBwD
         lnViyoNIsh9zELL5uxTBO1643MR4f99PsJfBbhnI=
Date:   Sat, 10 Apr 2021 13:33:33 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, julia.lawall@inria.fr
Subject: Re: [Outreachy kernel] [PATCH 4/4] staging: rtl8723bs: Change the
 type and use of a variable
Message-ID: <YHGNDejY/TfzeLzh@kroah.com>
References: <20210410092232.15155-1-fmdefrancesco@gmail.com>
 <4547533.LBOHeWh67L@localhost.localdomain>
 <YHGGBpSLj+W8ikXz@kroah.com>
 <10115279.QsZogQpAqX@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10115279.QsZogQpAqX@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 10, 2021 at 01:23:21PM +0200, Fabio M. De Francesco wrote:
> On Saturday, April 10, 2021 1:03:34 PM CEST Greg KH wrote:
> > On Sat, Apr 10, 2021 at 12:58:06PM +0200, Fabio M. De Francesco wrote:
> > > On Saturday, April 10, 2021 12:31:27 PM CEST Greg KH wrote:
> > > > On Sat, Apr 10, 2021 at 11:56:48AM +0200, Fabio M. De Francesco 
> wrote:
> > > > > On Saturday, April 10, 2021 11:31:16 AM CEST Greg KH wrote:
> > > > > > On Sat, Apr 10, 2021 at 11:22:32AM +0200, Fabio M. De Francesco
> > > 
> > > wrote:
> > > > > > > Change the type of fw_current_in_ps_mode from u8 to bool,
> > > > > > > because
> > > > > > > it is used everywhere as a bool and, accordingly, it should be
> > > > > > > declared as a bool. Shorten the controlling
> > > > > > > expression of an 'if' statement.
> > > > > > > 
> > > > > > > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > > > > > > ---
> > > > > > > 
> > > > > > >  drivers/staging/rtl8723bs/hal/hal_intf.c        | 2 +-
> > > > > > >  drivers/staging/rtl8723bs/include/rtw_pwrctrl.h | 2 +-
> > > > > > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/drivers/staging/rtl8723bs/hal/hal_intf.c
> > > > > > > b/drivers/staging/rtl8723bs/hal/hal_intf.c index
> > > > > > > 96fe172ced8d..8dc4dd8c6d4c 100644
> > > > > > > --- a/drivers/staging/rtl8723bs/hal/hal_intf.c
> > > > > > > +++ b/drivers/staging/rtl8723bs/hal/hal_intf.c
> > > > > > > @@ -348,7 +348,7 @@ void rtw_hal_dm_watchdog(struct adapter
> > > > > > > *padapter)
> > > > > > > 
> > > > > > >  void rtw_hal_dm_watchdog_in_lps(struct adapter *padapter)
> > > > > > >  {
> > > > > > > 
> > > > > > > -	if (adapter_to_pwrctl(padapter)->fw_current_in_ps_mode ==
> > > 
> > > true)
> > > 
> > > > > {
> > > > > 
> > > > > > > +	if (adapter_to_pwrctl(padapter)->fw_current_in_ps_mode) {
> > > > > > > 
> > > > > > >  		if (padapter->HalFunc.hal_dm_watchdog_in_lps)
> > > > > > >  		
> > > > > > >  			padapter-
> > > > > >
> > > > > >HalFunc.hal_dm_watchdog_in_lps(padapter); /* this
> > > > > >
> > > > > > >  			function caller is in interrupt 
> context
> > > > > 
> > > > > */>
> > > > > 
> > > > > > >  	}
> > > > > > > 
> > > > > > > diff --git a/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h
> > > > > > > b/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h index
> > > > > > > 0a48f1653be5..0767dbb84199 100644
> > > > > > > --- a/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h
> > > > > > > +++ b/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h
> > > > > > > @@ -203,7 +203,7 @@ struct pwrctrl_priv {
> > > > > > > 
> > > > > > >  	u8 LpsIdleCount;
> > > > > > >  	u8 power_mgnt;
> > > > > > >  	u8 org_power_mgnt;
> > > > > > > 
> > > > > > > -	u8 fw_current_in_ps_mode;
> > > > > > > +	bool fw_current_in_ps_mode;
> > > > > > > 
> > > > > > >  	unsigned long	DelayLPSLastTimeStamp;
> > > > > > >  	s32		pnp_current_pwr_state;
> > > > > > >  	u8 pnp_bstop_trx;
> > > > > > 
> > > > > > If this is only checked, how can it ever be true?  Who ever sets
> > > > > > this
> > > > > > value?
> > > > > 
> > > > > You're right. It is not set, therefore the "if" control expression
> > > > > cannot ever be "true".
> > > > > 
> > > > > Can I delete this statement in a new patch? Or you prefer I send
> > > > > the
> > > > > whole series again with this change in patch 4/4?
> > > > 
> > > > Just delete the variable from the structure entirely and when it is
> > > > used.
> > > 
> > > I've read the code of the function whom that 'if' statement belongs to.
> > > This function takes a pointer whose name is 'padapter' and this is has
> > > global scope. I think that since fw_current_in_ps_mode is dereferenced
> > > by the function adapter_to_pwrctl(padapter) it can and is indeed
> > > initialized and modified in some other files of the driver.
> > 
> > Where does that happen, and why did the build not break when you changed
> > the variable name?  
> >
> The build didn't break because I changed the name of that variable 
> everywhere it is used in the driver. This patch is against all the affected 
> files of each subdirectory of staging/rtl8723bs.

Right, and as you only had to change it in one place, that tested if
that variable was set to a specific value, and there is no code that
actually sets the variable, it seems like that variable is not ever used
and can be removed.

> > Is the whole variable assigned to a specific
> > location in memory in the device?  Where is it initialized?
> >
> That variable has global scope and is assigned at least in:
> 
> drivers/staging/rtl8723bs/core/rtw_pwrctrl.c:368:                       
> pwrpriv->fw_current_in_ps_mode = false;
> 
> drivers/staging/rtl8723bs/core/rtw_pwrctrl.c:380:                       
> pwrpriv->fw_current_in_ps_mode = true;
> 
> drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c:433:  
> adapter_to_pwrctl(padapter)->fw_current_in_ps_mode = false;
> 
> drivers/staging/rtl8723bs/core/rtw_pwrctrl.c:981:       
> pwrctrlpriv->fw_current_in_ps_mode = false;

But you are only changing 2 files in this patch:

> > > > > > >  drivers/staging/rtl8723bs/hal/hal_intf.c        | 2 +-
> > > > > > >  drivers/staging/rtl8723bs/include/rtw_pwrctrl.h | 2 +-

Ah, you are only changing the type, not the name.  That's the confusion
on my part.

Was the code setting a u8 to "true/false"?  Ugh, what a mess...

thanks,

greg k-h
