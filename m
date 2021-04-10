Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD21135ABE2
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 10:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234076AbhDJIXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 04:23:19 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:36774 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229494AbhDJIXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 04:23:16 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AZK5RiaEzgjE4cwejpLqECceALOonbusQ8zAX?=
 =?us-ascii?q?/mp2TgFYddHdqtC2kJ0gpHvJoRsYRX1Io7u9EYaaR3e0z/RIyKkXeYyvRQz3/F?=
 =?us-ascii?q?avRbsC0aLH4xnNXxLz7fRc06AISdkaNPTVAUJhhcj3pCmUeuxB/PC9/KqlhfjT?=
 =?us-ascii?q?wh5WJGlXQppt4AtjBgGQHlcefngkObMCCJGe6sBbzgDPRV0raK2AakUtY/LOvJ?=
 =?us-ascii?q?nimp7gfHc9dnwawTjLvHeT5Ln2HwPw5HojejlEqI1MzVT4?=
X-IronPort-AV: E=Sophos;i="5.82,210,1613430000"; 
   d="scan'208";a="502532788"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Apr 2021 10:22:45 +0200
Date:   Sat, 10 Apr 2021 10:22:45 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Greg KH <gregkh@linuxfoundation.org>
cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [Patch 0/3]
In-Reply-To: <YHFcI104K+ih3UDG@kroah.com>
Message-ID: <alpine.DEB.2.22.394.2104101021190.2975@hadrien>
References: <6552860.D8CPca6BT0@localhost.localdomain> <YHFT2S31kFy72DMv@kroah.com> <2101069.1PIH1tPmJ7@localhost.localdomain> <YHFcI104K+ih3UDG@kroah.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 10 Apr 2021, Greg KH wrote:

> On Sat, Apr 10, 2021 at 09:57:00AM +0200, Fabio M. De Francesco wrote:
> > On Saturday, April 10, 2021 9:29:29 AM CEST Greg KH wrote:
> > > On Fri, Apr 09, 2021 at 06:29:59PM +0200, Fabio M. De Francesco wrote:
> > > > This patch series removes camelcases, changes the type and use of a
> > > > variable, and correct misspelled words.
> > > >
> > > > Patch 1/3: staging: rtl8723bs: Remove camelcase in several files
> > > >
> > > > drivers/staging/rtl8723bs/core/rtw_cmd.c       |  2 +-
> > > > drivers/staging/rtl8723bs/core/rtw_mlme.c      |  2 +-
> > > > drivers/staging/rtl8723bs/core/rtw_pwrctrl.c   | 18 +++++++++---------
> > > > drivers/staging/rtl8723bs/hal/hal_intf.c       |  2 +-
> > > > drivers/staging/rtl8723bs/hal/rtl8723b_dm.c    |  6 +++---
> > > > .../staging/rtl8723bs/hal/rtl8723b_hal_init.c  |  2 +-
> > > > drivers/staging/rtl8723bs/hal/sdio_ops.c       | 14 +++++++-------
> > > > .../staging/rtl8723bs/include/rtw_pwrctrl.h    |  2 +-
> > > > 8 files changed, 24 insertions(+), 24 deletions(-)
> > > >
> > > > Patch 2/3: staging: rtl8723bs: Change the type and use of a variable
> > > >
> > > > drivers/staging/rtl8723bs/hal/hal_intf.c        | 2 +-
> > > >
> > > >  drivers/staging/rtl8723bs/include/rtw_pwrctrl.h | 2 +-
> > > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > Patch 3/3: staging: rtl8723bs: include: Fix misspelled words in
> > > > comments
> > > >
> > > > .../rtl8723bs/include/Hal8192CPhyReg.h        |  8 ++---
> > > >
> > > >  .../staging/rtl8723bs/include/basic_types.h   |  2 +-
> > > >  drivers/staging/rtl8723bs/include/drv_types.h |  2 +-
> > > >  drivers/staging/rtl8723bs/include/hal_com.h   |  2 +-
> > > >  .../staging/rtl8723bs/include/hal_com_reg.h   | 34 +++++++++----------
> > > >  drivers/staging/rtl8723bs/include/hal_data.h  |  2 +-
> > > >  .../staging/rtl8723bs/include/hal_pwr_seq.h   |  2 +-
> > > >  drivers/staging/rtl8723bs/include/rtw_cmd.h   |  6 ++--
> > > >  drivers/staging/rtl8723bs/include/rtw_mlme.h  | 18 +++++-----
> > > >  .../staging/rtl8723bs/include/rtw_mlme_ext.h  |  2 +-
> > > >  drivers/staging/rtl8723bs/include/rtw_mp.h    |  2 +-
> > > >  .../staging/rtl8723bs/include/rtw_pwrctrl.h   |  2 +-
> > > >  drivers/staging/rtl8723bs/include/rtw_recv.h  |  4 +--
> > > >  drivers/staging/rtl8723bs/include/rtw_xmit.h  |  2 +-
> > > >  drivers/staging/rtl8723bs/include/sta_info.h  |  2 +-
> > > >  drivers/staging/rtl8723bs/include/wifi.h      |  2 +-
> > > >  16 files changed, 46 insertions(+), 46 deletions(-)
> > > >
> > > > Fabio M. De Francesco
> > >
> > > I have no idea how you created this patch series, but I do not think it
> > > worked well :(
> > >
> > > Please use our standard tools, that do this all for you automatically,
> > >
> > Apart from the fact that I forgot to save the subject, I didn't know that
> > there are standard tools for doing Patch 0/N. Therefore I thought to make
> > an email message that contained the information about the patch series.
> >
> > I was wrong, sorry. I have to research this topic in the git manual or
> > somewhere else.
>
> 'git format-patch --cover-letter main..HEAD' will to the trick, if you
> are on a different branch from 'main'.  Then edit the 0000-* file and
> then send them all off with 'git send-email'.

Fabio,

The --cover-letter option is discussed in the "Versioning patchsets"
section of the tutorial.  Perhaps that is not the best place for it, since
the need for a cover letter is not specific to versioning...

julia

>
> thanks,
>
> greg k-h
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/YHFcI104K%2Bih3UDG%40kroah.com.
>
