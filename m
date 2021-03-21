Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85B39343193
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 08:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbhCUHEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 03:04:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:44062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229962AbhCUHDf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 03:03:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B10DA61925;
        Sun, 21 Mar 2021 07:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616310214;
        bh=eWR1vjTOqhNaQFvUZ36N91C5MwTCvpaR7JxD2y3UuFM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CAh2x/cmWUZJGqrbvg2Vt0GH5ZwcTiAb/jbhNUSJmeAUpMHyu5+HBDs6eyzo/NWjB
         BsIXQr+7NfqC5wgEa56afqpbSR+KPB44P/vUN62c7xaPaJRAQO4YYsrP0YuxYEHdue
         Tf8x5x7FiavyArQis6OxxNpXufjFG4xBhf3ljS7A=
Date:   Sun, 21 Mar 2021 08:03:29 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     joe@perches.com, apw@canonical.com, linux-kernel@vger.kernel.org
Subject: Re: CHECKPATCH: missing a warning soon after include files decl -c
Message-ID: <YFbvwZjwMa4mPsn8@kroah.com>
References: <20210320105424.GA3698@agape.jhs>
 <YFXVoHvk/VesFn14@kroah.com>
 <20210320144911.GA2999@agape.jhs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210320144911.GA2999@agape.jhs>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20, 2021 at 03:49:12PM +0100, Fabio Aiuto wrote:
> On Sat, Mar 20, 2021 at 11:59:44AM +0100, Greg KH wrote:
> > On Sat, Mar 20, 2021 at 11:54:24AM +0100, Fabio Aiuto wrote:
> > > Hi,
> > > 
> > > here's an issue in checkpatch.pl
> > > 
> > > $ perl script/checkpatch.pl -f drivers/staging/rtl8723bs/core/rtw_ap.c
> > > 
> > > I get three warning related to an extern declaration
> > > 
> > > WARNING: externs should be avoided in .c files
> > > #14: FILE: drivers/staging/rtl8723bs/core/rtw_ap.c:14:
> > > +extern unsigned char WMM_OUI[];
> > > --
> > > WARNING: externs should be avoided in .c files
> > > #15: FILE: drivers/staging/rtl8723bs/core/rtw_ap.c:15:
> > > +extern unsigned char WPS_OUI[];
> > > --
> > > WARNING: externs should be avoided in .c files
> > > #16: FILE: drivers/staging/rtl8723bs/core/rtw_ap.c:16:
> > > +extern unsigned char P2P_OUI[];
> > > ----------------------
> > > 
> > > but the file checked has 4 extern declaration:
> > > -----------------------------
> > > #define _RTW_AP_C_
> > > 
> > > #include <drv_types.h>
> > > #include <rtw_debug.h>
> > > #include <asm/unaligned.h>
> > > 
> > > extern unsigned char RTW_WPA_OUI[];
> > > extern unsigned char WMM_OUI[];
> > > extern unsigned char WPS_OUI[];
> > > extern unsigned char P2P_OUI[];
> > > 
> > > void init_mlme_ap_info(struct adapter *padapter)
> > > -------------------------------
> > > 
> > > If I add a ';' this way:
> > > ----------------------------
> > > #define _RTW_AP_C_
> > > 
> > > #include <drv_types.h>
> > > #include <rtw_debug.h>
> > > #include <asm/unaligned.h>
> > > ;
> > > extern unsigned char RTW_WPA_OUI[];
> > > extern unsigned char WMM_OUI[];
> > > extern unsigned char WPS_OUI[];
> > > extern unsigned char P2P_OUI[];
> > > 
> > > void init_mlme_ap_info(struct adapter *padapter)
> > > --------------------------------
> > 
> > Wait, why would you do the above?
> > 
> > Don't try to trick a perl script that has a hard time parsing C files,
> > try to resolve the original issue here.
> > 
> > And that is that the above definitions should be in a .h file somewhere.
> > If you make that move then all should be fine.
> > 
> > thanks,
> > 
> > greg k-h
> 
> that's another issue
> 
> WARNING: externs should be avoided in .c files
> #35: FILE: drivers/staging/rtl8723bs/core/rtw_efuse.c:35:
> +bool
> 
> CHECK: Lines should not end with a '('
> #36: FILE: drivers/staging/rtl8723bs/core/rtw_efuse.c:36:
> ---
> 
> but that's what I see in line 35
> 
> 
> #define REG_EFUSE_CTRL		0x0030
> #define EFUSE_CTRL			REG_EFUSE_CTRL		/*  E-Fuse Control. */
> 
> bool<--------------------------------- line 35
> Efuse_Read1ByteFromFakeContent(
> 	struct adapter *padapter,
> 	u16 	Offset,
> 	u8 *Value);
> bool
> Efuse_Read1ByteFromFakeContent(
> 	struct adapter *padapter,


That's some horrid code formatting, just clean it up to look normal and
all will be fine.

> another one...
> 
> WARNING: externs should be avoided in .c files
> #40: FILE: drivers/staging/rtl8723bs/core/rtw_ioctl_set.c:40:
> +u8 rtw_do_join(struct adapter *padapter); <-------- do I miss 
> 						something about extern keyword?

Having a global function prototype in a .c file is not a good idea.
Again, fix it up and all will be fine.

thanks,

greg k-h
