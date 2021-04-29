Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB36436E84D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 12:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240039AbhD2KCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 06:02:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:37918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239984AbhD2KCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 06:02:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 21E13613F4;
        Thu, 29 Apr 2021 10:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619690507;
        bh=yECCPdkMDgFIEVtIZKdwvM/UmBI0oF+VjDCJpwvABZ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=w1s6+npsiKC+O26PGzmkcmfsYAY66VFdvOtTwCbBQEckDkW5YpS1b3PbIAEu/LHCx
         Rxl6BvUlprqm4BCNilRROh/H4yYjfqr8HuKR3izpBthYCzm8IAshkw27xp8OiiGqz3
         EBHGsuN3m+aQPoIZHtmhIkI8kYhUzmHqBlq2sWq0=
Date:   Thu, 29 Apr 2021 12:01:45 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH 1/2] staging: rtl8723bs: hal: Remove
 set but unused variables
Message-ID: <YIqECQk/1Zb4JRjb@kroah.com>
References: <20210428113346.28305-1-fmdefrancesco@gmail.com>
 <20210428113346.28305-2-fmdefrancesco@gmail.com>
 <20210429072619.GB1409@agape.jhs>
 <8266064.IJzC9MfcRG@linux.local>
 <20210429082552.GC1409@agape.jhs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429082552.GC1409@agape.jhs>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 10:25:53AM +0200, Fabio Aiuto wrote:
> On Thu, Apr 29, 2021 at 09:44:47AM +0200, Fabio M. De Francesco wrote:
> > On Thursday, April 29, 2021 9:26:20 AM CEST Fabio Aiuto wrote:
> > > Hi Fabio,
> > > 
> > > On Wed, Apr 28, 2021 at 01:33:45PM +0200, Fabio M. De Francesco wrote:
> > > > Removed four set but unused variables. Issue detected by gcc.
> > > > 
> > > > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > > > ---
> > > > 
> > > >  drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 5 -----
> > > >  1 file changed, 5 deletions(-)
> > > > 
> > > > diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
> > > > b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c index 
> > 082448557b53..96cb4426a0f4
> > > > 100644
> > > > --- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
> > > > +++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
> > > > @@ -3900,14 +3900,11 @@ u8 GetHalDefVar8723B(struct adapter *padapter, 
> > enum
> > > > hal_def_variable variable, v> 
> > > >  			u32 cmd;
> > > >  			u32 ra_info1, ra_info2;
> > > >  			u32 rate_mask1, rate_mask2;
> > > > 
> > > > -			u8 curr_tx_rate, curr_tx_sgi, hight_rate, 
> > lowest_rate;
> > > > 
> > > >  			cmd = 0x40000100 | mac_id;
> > > >  			rtw_write32(padapter, 
> > REG_HMEBOX_DBG_2_8723B, cmd);
> > > >  			msleep(10);
> > > >  			ra_info1 = rtw_read32(padapter, 0x2F0);
> > > > 
> > > > -			curr_tx_rate = ra_info1&0x7F;
> > > > -			curr_tx_sgi = (ra_info1>>7)&0x01;
> > > > 
> > > >  			cmd = 0x40000400 | mac_id;
> > > >  			rtw_write32(padapter, 
> > REG_HMEBOX_DBG_2_8723B, cmd);
> > > > 
> > > > @@ -3916,8 +3913,6 @@ u8 GetHalDefVar8723B(struct adapter *padapter, enum
> > > > hal_def_variable variable, v> 
> > > >  			ra_info2 = rtw_read32(padapter, 0x2F4);
> > > >  			rate_mask1 = rtw_read32(padapter, 0x2F8);
> > > >  			rate_mask2 = rtw_read32(padapter, 0x2FC);
> > > > 
> > > > -			hight_rate = ra_info2&0xFF;
> > > > -			lowest_rate = (ra_info2>>8)  & 0xFF;
> > > > 
> > > >  		}
> > > >  		break;
> > > 
> > > rate_mask{1,2} and ra_info{1,2} seems to be unused as well.
> > > 
> > > thank you,
> > > 
> > > fabio
> > >
> > Hello Fabio,
> > 
> > I'm not sure about it: rtw_read32 calls a pointer to a function. I'm don't 
> > know drivers programming, however that function looks like an implementation 
> > of a read() system call. So I wouldn't be so sure to remove those calls. 
> > 
> > Could calling a (*read) method have side effects on subsequent read()? I mean: 
> > could it update some internal data structure? If not I can remove the 
> > variables you mentioned above and the calls to read32.
> > 
> > I'm looking forward to read your reply.
> > 
> > Thanks,
> > 
> > Fabio
> > 
> > 
> > 
> 
> hi Fabio,
> 
> rtw_read32 is a macro wrapping _rtw_read32() defined as follows (in core/rtw_io.c):
> 
> u32 _rtw_read32(struct adapter *adapter, u32 addr)
> {
>         u32 r_val;
>         /* struct       io_queue        *pio_queue = (struct io_queue *)adapter->pio_queue; */
>         struct io_priv *pio_priv = &adapter->iopriv;
>         struct  intf_hdl                *pintfhdl = &(pio_priv->intf);
>         u32 (*_read32)(struct intf_hdl *pintfhdl, u32 addr);
> 
>         _read32 = pintfhdl->io_ops._read32;
> 
>         r_val = _read32(pintfhdl, addr);
>         return rtw_le32_to_cpu(r_val);
> 
> }
> 
> the actual read seems to be performed by the handler contained in
> 
> 	pintfhdl->io_ops._read32;
> 
> so:
> 
> $ grep -r '\b_read32' drivers/staging/rtl8723bs/
> 
> drivers/staging/rtl8723bs/hal/sdio_ops.c:	ops->_read32 = &sdio_read32;
> 
> this is the place where _read32 is stored with sdio_read32 reference... 
> 
> drivers/staging/rtl8723bs/core/rtw_io.c:	u32 (*_read32)(struct intf_hdl *pintfhdl, u32 addr);
> drivers/staging/rtl8723bs/core/rtw_io.c:	_read32 = pintfhdl->io_ops._read32;
> ...
> 
> if you check it in hal/sdio_ops.c, nothing is written, just reads are
> performed (and it's not odd, for a read function isn't supposed to write
> something under the hood ;)).

Yes, but many types of hardware _REQUIRE_ reads to do something.  So
"read that does nothing" is a requirement for some operations.

As an example, a write is only guaranteed to have been finished if you
do a read of the same location back from it on some hardware busses.
The bus can reorder things, but a write/read of the same location can
not be reordered.

Sometimes you have to do reads multiple times to get things to "stick".

Other times reading from a location changes a state in the hardware
(horrid but HW designers aren't the brightest at times...)

So you can NOT just remove reads without knowing that the hardware does
not require this.  This is an issue where GCC "warnings" mean nothing as
gcc does not actually know what hardware does, or does not, do for many
things.

thanks,

greg k-h
