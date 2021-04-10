Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 775D235ACB9
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 12:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234453AbhDJKbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 06:31:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:46450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234091AbhDJKbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 06:31:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 26738610CC;
        Sat, 10 Apr 2021 10:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618050689;
        bh=XESUERAc0hZuhgJgKDt7VFq6TSKF+sm2dkhBnDr/gLw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y1HUHEHEBqSXtQwqiEWSW+gpb7dyX+XMCwoWFjA6IFnarTYGmx7d/7+Va4HD9yQqw
         +iTcpMgORyJJN9W+u33nTvc2AOsYg2WkM+tIe7fTX14oqQE9J6/XzJKIVaYs8bGTMU
         hwtNpZ7jU7gweudRfDswBPdXfTRhzq2P20zoAz/U=
Date:   Sat, 10 Apr 2021 12:31:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH 4/4] staging: rtl8723bs: Change the
 type and use of a variable
Message-ID: <YHF+f48MM6xEEv9R@kroah.com>
References: <20210410092232.15155-1-fmdefrancesco@gmail.com>
 <20210410092232.15155-5-fmdefrancesco@gmail.com>
 <YHFwZCh+s7ymrsQN@kroah.com>
 <24152421.bNubvhIgUM@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24152421.bNubvhIgUM@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 10, 2021 at 11:56:48AM +0200, Fabio M. De Francesco wrote:
> On Saturday, April 10, 2021 11:31:16 AM CEST Greg KH wrote:
> > On Sat, Apr 10, 2021 at 11:22:32AM +0200, Fabio M. De Francesco wrote:
> > > Change the type of fw_current_in_ps_mode from u8 to bool, because
> > > it is used everywhere as a bool and, accordingly, it should be
> > > declared as a bool. Shorten the controlling
> > > expression of an 'if' statement.
> > > 
> > > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > > ---
> > > 
> > >  drivers/staging/rtl8723bs/hal/hal_intf.c        | 2 +-
> > >  drivers/staging/rtl8723bs/include/rtw_pwrctrl.h | 2 +-
> > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/staging/rtl8723bs/hal/hal_intf.c
> > > b/drivers/staging/rtl8723bs/hal/hal_intf.c index
> > > 96fe172ced8d..8dc4dd8c6d4c 100644
> > > --- a/drivers/staging/rtl8723bs/hal/hal_intf.c
> > > +++ b/drivers/staging/rtl8723bs/hal/hal_intf.c
> > > @@ -348,7 +348,7 @@ void rtw_hal_dm_watchdog(struct adapter *padapter)
> > > 
> > >  void rtw_hal_dm_watchdog_in_lps(struct adapter *padapter)
> > >  {
> > > 
> > > -	if (adapter_to_pwrctl(padapter)->fw_current_in_ps_mode == true) 
> {
> > > +	if (adapter_to_pwrctl(padapter)->fw_current_in_ps_mode) {
> > > 
> > >  		if (padapter->HalFunc.hal_dm_watchdog_in_lps)
> > >  		
> > >  			padapter-
> >HalFunc.hal_dm_watchdog_in_lps(padapter); /* this
> > >  			function caller is in interrupt context 
> */>  	
> > >  	}
> > > 
> > > diff --git a/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h
> > > b/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h index
> > > 0a48f1653be5..0767dbb84199 100644
> > > --- a/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h
> > > +++ b/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h
> > > @@ -203,7 +203,7 @@ struct pwrctrl_priv {
> > > 
> > >  	u8 LpsIdleCount;
> > >  	u8 power_mgnt;
> > >  	u8 org_power_mgnt;
> > > 
> > > -	u8 fw_current_in_ps_mode;
> > > +	bool fw_current_in_ps_mode;
> > > 
> > >  	unsigned long	DelayLPSLastTimeStamp;
> > >  	s32		pnp_current_pwr_state;
> > >  	u8 pnp_bstop_trx;
> > 
> > If this is only checked, how can it ever be true?  Who ever sets this
> > value?
> >
> You're right. It is not set, therefore the "if" control expression cannot 
> ever be "true".
> 
> Can I delete this statement in a new patch? Or you prefer I send the whole 
> series again with this change in patch 4/4?

Just delete the variable from the structure entirely and when it is
used.

thanks,

greg k-h
