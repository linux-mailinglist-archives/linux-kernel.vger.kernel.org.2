Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B50F635E6B7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 20:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232947AbhDMS5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 14:57:42 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:32393 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232517AbhDMS5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 14:57:41 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ALLiDiKgOMGhUFS2AKwnY+EjHlnBQXw113DAb?=
 =?us-ascii?q?vn1ZSRFFG/GwvcrGppUm/DXzjyscX2xlpMuJP7OOTWiZ2Zl+54QQOrnKZniDhE?=
 =?us-ascii?q?KDKoZ+4Yz+hwDxAiGWzJ856Y5MUYhbTOfxA19zkNrg7GCDeeoI7dGb/MmT6Nv2?=
 =?us-ascii?q?4GxqSWhRB51IygdiF0KyCUd2RBZLbKBJbqa0w8pcun6BVB0sH7+GL1wERfWGnt?=
 =?us-ascii?q?vQifvdEGM7Ljsm8hTLsTSz9LXhGQOZ1Rt2aUIy/Z4H/XLemwL0ooWP2sva9jb5?=
 =?us-ascii?q?12veq6tbg8HgzNwrPr3vtuEtMTnnhgulY45sMofy2wwdm+2k5FY0nNSkmX5JVP?=
 =?us-ascii?q?hb0H/Je3HwnB2F4Wbd+Qwz4Hzvw0LwuwqBneXFQlsBZfZptMZwbgber3Etpsh7?=
 =?us-ascii?q?17hGm1iEroNNAQnb9R6NmOTgZlVFlleUvXFnquIalXpZOLFuEIN5nMgw/F51DJ?=
 =?us-ascii?q?xFJy7x6JkmHO5yZfusncp+QBe1b235omIq+9CnXm0yEhCaBmAOt9eYySI+pgEG?=
 =?us-ascii?q?82IogOIeg1Yd/9YGR55I6/+sCNUPqI1z?=
X-IronPort-AV: E=Sophos;i="5.82,220,1613430000"; 
   d="scan'208";a="503068718"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Apr 2021 20:57:20 +0200
Date:   Tue, 13 Apr 2021 20:57:20 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        outreachy-kernel@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH] :staging: rtl8723bs: Remove useless
 led_blink_hdl()
In-Reply-To: <4666345.5ezhEZ0rgB@linux.local>
Message-ID: <alpine.DEB.2.22.394.2104132056470.14108@hadrien>
References: <20210413155908.8691-1-fmdefrancesco@gmail.com> <3381109.TaO10cqo9c@linux.local> <20210413182050.GJ6021@kadam> <4666345.5ezhEZ0rgB@linux.local>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 13 Apr 2021, Fabio M. De Francesco wrote:

> On Tuesday, April 13, 2021 8:20:50 PM CEST Dan Carpenter wrote:
> > On Tue, Apr 13, 2021 at 06:47:06PM +0200, Fabio M. De Francesco wrote:
> > > On Tuesday, April 13, 2021 6:27:17 PM CEST Julia Lawall wrote:
> > > > On Tue, 13 Apr 2021, Fabio M. De Francesco wrote:
> > > > > On Tuesday, April 13, 2021 6:04:16 PM CEST Julia Lawall wrote:
> > > > > > On Tue, 13 Apr 2021, Fabio M. De Francesco wrote:
> > > > > > > Removed the led_blink_hdl() function (declaration, definition,
> > > > > > > and
> > > > > > > caller code) because it's useless. It only seems to check
> > > > > > > whether
> > > > > > > or
> > > > > > > not a given pointer is NULL. There are other (simpler) means
> > > > > > > for
> > > > > > > that
> > > > > > > purpose.
> > > > > > >
> > > > > > > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > > > > > > ---
> > > > > > >
> > > > > > >  drivers/staging/rtl8723bs/core/rtw_cmd.c         | 1 -
> > > > > > >  drivers/staging/rtl8723bs/core/rtw_mlme_ext.c    | 9 ---------
> > > > > > >  drivers/staging/rtl8723bs/include/rtw_mlme_ext.h | 1 -
> > > > > > >  3 files changed, 11 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c
> > > > > > > b/drivers/staging/rtl8723bs/core/rtw_cmd.c index
> > > > > > > 0297fbad7bce..4c44dfd21514 100644
> > > > > > > --- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
> > > > > > > +++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
> > > > > > > @@ -150,7 +150,6 @@ static struct cmd_hdl wlancmds[] = {
> > > > > > >
> > > > > > >  	GEN_MLME_EXT_HANDLER(0, h2c_msg_hdl) /*58*/
> > > > > > >  	GEN_MLME_EXT_HANDLER(sizeof(struct SetChannelPlan_param),
> > > > > > >  	set_chplan_hdl) /*59*/>
> > > > > > >
> > > > > > > -	GEN_MLME_EXT_HANDLER(sizeof(struct LedBlink_param),
> > > > >
> > > > > led_blink_hdl)
> > > > >
> > > > > > > /*60*/
> > > > > >
> > > > > > This is worrisome.  Doyou fully understand the impact of this?
> > > > > > If
> > > > > > not,
> > > > > > the change is probably not a good idea.
> > > > >
> > > > > This is that macro definition:
> > > > >
> > > > > #define GEN_MLME_EXT_HANDLER(size, cmd) {size, cmd},
> > > > >
> > > > > struct C2HEvent_Header {
> > > > >
> > > > > #ifdef __LITTLE_ENDIAN
> > > > >
> > > > >         unsigned int len:16;
> > > > >         unsigned int ID:8;
> > > > >         unsigned int seq:8;
> > > > >
> > > > > #else
> > > > >
> > > > >         unsigned int seq:8;
> > > > >         unsigned int ID:8;
> > > > >         unsigned int len:16;
> > > > >
> > > > > #endif
> > > > >
> > > > >         unsigned int rsvd;
> > > > >
> > > > > };
> > > > >
> > > > > It's a bit convoluted with regard to my experience. Probably I
> > > > > don't
> > > > > understand it fully, but it seems to me to not having effects to
> > > > > the
> > > > > code where I removed its use within core/rtw_cmd.c.
> > > > >
> > > > > What am I missing?
> > > >
> > > > It seems that the function is being put into an array.  Probably
> > > > someone
> > > > expects to find it there.  Probably you have shifted all of the
> > > > functions that come afterwards back one slot so that they are all in
> > > > the wrong places.
> > > >
> > > > julia
> > >
> > > Thanks for your explanation. Obviously this implies that the function
> > > cannot be removed, unless one fill the slot that is deleted by to not
> > > calling this macro at the right moment.
> > >
> > > I also suppose that providing a function pointer with a NULL value
> > > wouldn't work either.
> >
> > It would work.  That array is full of NULL function pointers.
> >
> Interesting, thanks.
>
> I'm going to remove that function and replace its name in the macro with a
> NULL function pointer.
>
> I couldn't believe it would work when I wrote about that.

Have you checked that a value of NULL in that place is going to have the
same effect as the function?

julia
