Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7498A357E81
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 10:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbhDHIyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 04:54:22 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:2061 "EHLO
        mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229588AbhDHIyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 04:54:21 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A24su1KCfvk0iGvnlHejQsceALOonbusQ8zAX?=
 =?us-ascii?q?/mh6QxBNb4i8n8ehgPwU2XbP+VMscVsL8OruBICrR3TA+ZlppawYOrm/VAfr0V?=
 =?us-ascii?q?HYSL1Kx43k3jHmBmnC5vdQvJ0QCJRWJdXsATFB/KXHySaiFdJI+rS62YSJocub?=
 =?us-ascii?q?8Ht3VwFtbMhbnn1EIyKWCFd/SgUDJbdRLuv/2uN9qzCteWsaY62AbxFvNdTrnc?=
 =?us-ascii?q?HBl57tfHc9aSIP1QiUgTukrJ78HhSIty1/bxpzwKwv+WWArgrh5q/LiZCG4yLb?=
 =?us-ascii?q?vlW+071m3P/ajvpKHoill9UcIDSEsHfOWK1RH5m5+A0TjM7qwlAwi9XIqwonJK?=
 =?us-ascii?q?1ImhXsV3DwpwDs1Qnm2Csv7HGnyUbwuwqbneXpAC8/T9BHmJgcaB/F8iMbzalB?=
 =?us-ascii?q?7J4=3D?=
X-IronPort-AV: E=Sophos;i="5.82,205,1613430000"; 
   d="scan'208";a="378068035"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Apr 2021 10:54:09 +0200
Date:   Thu, 8 Apr 2021 10:54:09 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
cc:     Greg KH <gregkh@linuxfoundation.org>,
        outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH] staging: rtl8723bs: Remove camelcase
 in several files
In-Reply-To: <2284292.R3b5UFg5HO@localhost.localdomain>
Message-ID: <alpine.DEB.2.22.394.2104081053200.5197@hadrien>
References: <20210408080714.29481-1-fmdefrancesco@gmail.com> <YG7AkJjSThRbb/f5@kroah.com> <2284292.R3b5UFg5HO@localhost.localdomain>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 8 Apr 2021, Fabio M. De Francesco wrote:

> On Thursday, April 8, 2021 10:36:32 AM CEST Greg KH wrote:
> > On Thu, Apr 08, 2021 at 10:07:14AM +0200, Fabio M. De Francesco wrote:
> > > Remove camelcase in a symbol that is used by several files.
> >
> > What symbol?
> >
>
> I'm not sure I understand what you are asking. You mean
> that I have to specify the name of the variable that I changed?
> Or you mean that I shouldn't use the term "symbol" but write
> "variable", "function", "macro", and so on?

He wants the name of the symbol.  Each changed line includes lots of
symbols, so it is a significant effort to scan the patch to see what
symbol is being changed.

julia

>
> >
> > > --- a/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h
> > > +++ b/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h
> > > @@ -203,7 +203,7 @@ struct pwrctrl_priv {
> > >  	u8 LpsIdleCount;
> > >  	u8 power_mgnt;
> > >  	u8 org_power_mgnt;
> > > -	u8 bFwCurrentInPSMode;
> > > +	u8 b_fw_current_in_ps_mode;
> >
> > The "b" here means "byte" so you can drop the "b_" as that means
> > nothing, we do not use this type of notation in the kernel as the
> > compiler can check it for us.
> >
>
> OK, I didn't know what the 'b' meant in this context. I'll drop it.
>
> Thanks,
>
> Fabio
>
> > thanks,
> >
> > greg k-h
> >
>
>
>
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/2284292.R3b5UFg5HO%40localhost.localdomain.
>
