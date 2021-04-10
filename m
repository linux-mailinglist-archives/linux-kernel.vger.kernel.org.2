Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1471735ABC6
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 10:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbhDJIFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 04:05:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:55306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229472AbhDJIFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 04:05:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D3DE661182;
        Sat, 10 Apr 2021 08:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618041894;
        bh=0c+0FmkCkm37cdzRy9sQ6yCvVZSa+EvziuKpc7wHoGA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0Kas3gYdyGTIRPOYa6UvdjA66DkpoPFNEZ4P7VvLQedwV+PewdSU5jGVOB1b89R5F
         Ncn0MhSlDhR/+lokN8+2xX8jMtATtic4G3NZ9Ttjoq6Q0STQO/kRA2NJCt/PrUIAc4
         +A/JqWGwQ8LFt/IIG7zfUgjI72z8UtxSQk6Jwz14=
Date:   Sat, 10 Apr 2021 10:04:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [Patch 0/3]
Message-ID: <YHFcI104K+ih3UDG@kroah.com>
References: <6552860.D8CPca6BT0@localhost.localdomain>
 <YHFT2S31kFy72DMv@kroah.com>
 <2101069.1PIH1tPmJ7@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2101069.1PIH1tPmJ7@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 10, 2021 at 09:57:00AM +0200, Fabio M. De Francesco wrote:
> On Saturday, April 10, 2021 9:29:29 AM CEST Greg KH wrote:
> > On Fri, Apr 09, 2021 at 06:29:59PM +0200, Fabio M. De Francesco wrote:
> > > This patch series removes camelcases, changes the type and use of a
> > > variable, and correct misspelled words.
> > > 
> > > Patch 1/3: staging: rtl8723bs: Remove camelcase in several files
> > > 
> > > drivers/staging/rtl8723bs/core/rtw_cmd.c       |  2 +-
> > > drivers/staging/rtl8723bs/core/rtw_mlme.c      |  2 +-
> > > drivers/staging/rtl8723bs/core/rtw_pwrctrl.c   | 18 +++++++++---------
> > > drivers/staging/rtl8723bs/hal/hal_intf.c       |  2 +-
> > > drivers/staging/rtl8723bs/hal/rtl8723b_dm.c    |  6 +++---
> > > .../staging/rtl8723bs/hal/rtl8723b_hal_init.c  |  2 +-
> > > drivers/staging/rtl8723bs/hal/sdio_ops.c       | 14 +++++++-------
> > > .../staging/rtl8723bs/include/rtw_pwrctrl.h    |  2 +-
> > > 8 files changed, 24 insertions(+), 24 deletions(-)
> > > 
> > > Patch 2/3: staging: rtl8723bs: Change the type and use of a variable
> > > 
> > > drivers/staging/rtl8723bs/hal/hal_intf.c        | 2 +-
> > > 
> > >  drivers/staging/rtl8723bs/include/rtw_pwrctrl.h | 2 +-
> > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > Patch 3/3: staging: rtl8723bs: include: Fix misspelled words in
> > > comments
> > > 
> > > .../rtl8723bs/include/Hal8192CPhyReg.h        |  8 ++---
> > > 
> > >  .../staging/rtl8723bs/include/basic_types.h   |  2 +-
> > >  drivers/staging/rtl8723bs/include/drv_types.h |  2 +-
> > >  drivers/staging/rtl8723bs/include/hal_com.h   |  2 +-
> > >  .../staging/rtl8723bs/include/hal_com_reg.h   | 34 +++++++++----------
> > >  drivers/staging/rtl8723bs/include/hal_data.h  |  2 +-
> > >  .../staging/rtl8723bs/include/hal_pwr_seq.h   |  2 +-
> > >  drivers/staging/rtl8723bs/include/rtw_cmd.h   |  6 ++--
> > >  drivers/staging/rtl8723bs/include/rtw_mlme.h  | 18 +++++-----
> > >  .../staging/rtl8723bs/include/rtw_mlme_ext.h  |  2 +-
> > >  drivers/staging/rtl8723bs/include/rtw_mp.h    |  2 +-
> > >  .../staging/rtl8723bs/include/rtw_pwrctrl.h   |  2 +-
> > >  drivers/staging/rtl8723bs/include/rtw_recv.h  |  4 +--
> > >  drivers/staging/rtl8723bs/include/rtw_xmit.h  |  2 +-
> > >  drivers/staging/rtl8723bs/include/sta_info.h  |  2 +-
> > >  drivers/staging/rtl8723bs/include/wifi.h      |  2 +-
> > >  16 files changed, 46 insertions(+), 46 deletions(-)
> > > 
> > > Fabio M. De Francesco
> > 
> > I have no idea how you created this patch series, but I do not think it
> > worked well :(
> > 
> > Please use our standard tools, that do this all for you automatically,
> >
> Apart from the fact that I forgot to save the subject, I didn't know that 
> there are standard tools for doing Patch 0/N. Therefore I thought to make  
> an email message that contained the information about the patch series.
> 
> I was wrong, sorry. I have to research this topic in the git manual or 
> somewhere else.

'git format-patch --cover-letter main..HEAD' will to the trick, if you
are on a different branch from 'main'.  Then edit the 0000-* file and
then send them all off with 'git send-email'.

thanks,

greg k-h
