Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD62735ABE0
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 10:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbhDJIUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 04:20:35 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:36657 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229494AbhDJIUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 04:20:30 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AclY1+6r9oDSMCBuxoPG6VwkaV5rKeYIsi2QD?=
 =?us-ascii?q?101hICF9WMqeisyogbAnxQb54QxhPE0ItNicNMC7Kk/02oVy5eAqV4uKfA6jg2?=
 =?us-ascii?q?ewKZEn0I2K+VzdMgnf0sIY6qt6aah5D7TLfD1HpOL3+hOxHdpl4PTvysCVrNzT?=
 =?us-ascii?q?xXtsUg1mApsIhztRMQqVHlZ7QwNLH/MCZfmhz/BarDmtc2l/VKqGL0QCNtKum/?=
 =?us-ascii?q?T2jp78JTYJCxk7gTP+7w+A2frKVyKV2RoTSFp0rIsK+2KtqWPE2pk=3D?=
X-IronPort-AV: E=Sophos;i="5.82,210,1613430000"; 
   d="scan'208";a="502532650"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Apr 2021 10:20:15 +0200
Date:   Sat, 10 Apr 2021 10:20:15 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
cc:     Greg KH <gregkh@linuxfoundation.org>,
        outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [Patch 0/3]
In-Reply-To: <2101069.1PIH1tPmJ7@localhost.localdomain>
Message-ID: <alpine.DEB.2.22.394.2104101019210.2975@hadrien>
References: <6552860.D8CPca6BT0@localhost.localdomain> <YHFT2S31kFy72DMv@kroah.com> <2101069.1PIH1tPmJ7@localhost.localdomain>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 10 Apr 2021, Fabio M. De Francesco wrote:

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

Everything should be clear in the Kernelnewbies outreachy tutorial.  If
there is something about this issue that is not clear, please comment on
it or propose a fix.

julia


>
> Thanks,
>
> Fabio
> >
> > and send them out in a series of emails that have a proper subject line
> > (look at what you used here...) and are properly "threaded".
> >
> > thanks,
> >
> > greg k-h
>
>
>
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/2101069.1PIH1tPmJ7%40localhost.localdomain.
>
