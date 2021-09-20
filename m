Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2894112F4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 12:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235952AbhITKhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 06:37:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:56946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230510AbhITKhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 06:37:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C572460F38;
        Mon, 20 Sep 2021 10:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632134168;
        bh=FyEfOZsrlmxm+TybRrNr+Ydd4VRnpaZgTRwd5a8QJQo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p/91R2PwOq8kFNVLBbjvhmdK/D/UA5yPPYmR0nurN8XlrvJ3E/PiygTHLkW+nGfo2
         dBY4wO0aM2kDbasnozpw6F5MYMLeJi26GHkCgMHnP9CD4fRFFhSWlTX67Xj23Pp2m0
         UT4h/2zI19mlD1q3jcLVgBHKNlT1Wgoyb+w+JnL0=
Date:   Mon, 20 Sep 2021 12:36:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Saurav Girepunje <saurav.girepunje@gmail.com>
Cc:     saurav.girepunje@hotmail.com, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, straube.linux@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: core: remove the function
 power_saving_wk_hdl
Message-ID: <YUhkFvz4BpLv0eoN@kroah.com>
References: <YTub30ZRG3oLbxQW@user>
 <YT951VyaUEX8uFpz@kroah.com>
 <45c4de06-f618-4352-91ea-885edecdf8bb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45c4de06-f618-4352-91ea-885edecdf8bb@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 18, 2021 at 10:52:50PM +0530, Saurav Girepunje wrote:
> 
> 
> On 13/09/21 9:48 pm, Greg KH wrote:
> > On Fri, Sep 10, 2021 at 11:24:39PM +0530, Saurav Girepunje wrote:
> > > Remove the function power_saving_wk_hdl() as it just calling
> > > the rtw_ps_processor().Instead of power_saving_wk_hdl() call directly
> > > rtw_ps_processor().
> > > 
> > > Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
> > > ---
> > >   drivers/staging/r8188eu/core/rtw_cmd.c | 7 +------
> > >   1 file changed, 1 insertion(+), 6 deletions(-)
> > > 
> > > diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
> > > index ce73ac7cf973..35e6a943c556 100644
> > > --- a/drivers/staging/r8188eu/core/rtw_cmd.c
> > > +++ b/drivers/staging/r8188eu/core/rtw_cmd.c
> > > @@ -1669,11 +1669,6 @@ u8 rtw_antenna_select_cmd(struct adapter *padapter, u8 antenna, u8 enqueue)
> > >   	return res;
> > >   }
> > > 
> > > -static void power_saving_wk_hdl(struct adapter *padapter, u8 *pbuf, int sz)
> > > -{
> > > -	 rtw_ps_processor(padapter);
> > > -}
> > > -
> > >   #ifdef CONFIG_88EU_P2P
> > >   u8 p2p_protocol_wk_cmd(struct adapter *padapter, int intCmdType)
> > >   {
> > > @@ -1941,7 +1936,7 @@ u8 rtw_drvextra_cmd_hdl(struct adapter *padapter, unsigned char *pbuf)
> > >   		dynamic_chk_wk_hdl(padapter, pdrvextra_cmd->pbuf, pdrvextra_cmd->type_size);
> > >   		break;
> > >   	case POWER_SAVING_CTRL_WK_CID:
> > > -		power_saving_wk_hdl(padapter, pdrvextra_cmd->pbuf, pdrvextra_cmd->type_size);
> > > +		rtw_ps_processor(padapter);
> > >   		break;
> > >   	case LPS_CTRL_WK_CID:
> > >   		lps_ctrl_wk_hdl(padapter, (u8)pdrvextra_cmd->type_size);
> > > --
> > > 2.32.0
> > > 
> > > 
> > 
> > Also does not apply to my tree.  Please rebase against my staging-next
> > branch and resend.
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> Hi Greg,
> 
> I always do rebase against your staging-testing branch. Can you help me to
> understand.When we need to rebase on staging-next. Do we always need to
> rebase against staging-next..!

Yes, you should.  When you are working on code that lots of other people
are working on, there will be conflicts like this, and you just need to
stay on top of it.

thanks,

greg k-h
