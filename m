Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8F535E3DD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 18:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245643AbhDMQ1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 12:27:44 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:13327
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237066AbhDMQ1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 12:27:38 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A+gD8ga8CSWQhZ3Sc4gpuk+AuI+orLtY04lQ7?=
 =?us-ascii?q?vn1ZYxpTb8CeioSSjO0WvCWE6go5dXk8lbm7Sc29aFzG85od2+gsFJODeCWjh2?=
 =?us-ascii?q?eyNoFl6uLZsl7dMgnz7PRU26slU6UWMqyUMXFAgcz34Ba1Hr8bqbHtmpyAvuvG?=
 =?us-ascii?q?ymcocAcCUcFdxj1kAQWWGFAefmV7LKc+faDw2uN34x6peXEada2AaEUtbqz7hu?=
 =?us-ascii?q?SOsonnbx4ADwMm7wfLtzmy6KfmeiL24isj?=
X-IronPort-AV: E=Sophos;i="5.82,219,1613430000"; 
   d="scan'208";a="378563316"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Apr 2021 18:27:17 +0200
Date:   Tue, 13 Apr 2021 18:27:17 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
cc:     Julia Lawall <julia.lawall@inria.fr>,
        outreachy-kernel@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH] :staging: rtl8723bs: Remove useless
 led_blink_hdl()
In-Reply-To: <1843649.8FsqevVC75@linux.local>
Message-ID: <alpine.DEB.2.22.394.2104131826160.8430@hadrien>
References: <20210413155908.8691-1-fmdefrancesco@gmail.com> <alpine.DEB.2.22.394.2104131803270.8430@hadrien> <1843649.8FsqevVC75@linux.local>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 13 Apr 2021, Fabio M. De Francesco wrote:

> On Tuesday, April 13, 2021 6:04:16 PM CEST Julia Lawall wrote:
> > On Tue, 13 Apr 2021, Fabio M. De Francesco wrote:
> > > Removed the led_blink_hdl() function (declaration, definition, and
> > > caller code) because it's useless. It only seems to check whether or
> > > not a given pointer is NULL. There are other (simpler) means for that
> > > purpose.
> > >
> > > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > > ---
> > >
> > >  drivers/staging/rtl8723bs/core/rtw_cmd.c         | 1 -
> > >  drivers/staging/rtl8723bs/core/rtw_mlme_ext.c    | 9 ---------
> > >  drivers/staging/rtl8723bs/include/rtw_mlme_ext.h | 1 -
> > >  3 files changed, 11 deletions(-)
> > >
> > > diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c
> > > b/drivers/staging/rtl8723bs/core/rtw_cmd.c index
> > > 0297fbad7bce..4c44dfd21514 100644
> > > --- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
> > > +++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
> > > @@ -150,7 +150,6 @@ static struct cmd_hdl wlancmds[] = {
> > >
> > >  	GEN_MLME_EXT_HANDLER(0, h2c_msg_hdl) /*58*/
> > >  	GEN_MLME_EXT_HANDLER(sizeof(struct SetChannelPlan_param),
> > >  	set_chplan_hdl) /*59*/>
> > > -	GEN_MLME_EXT_HANDLER(sizeof(struct LedBlink_param),
> led_blink_hdl)
> > > /*60*/
> > This is worrisome.  Doyou fully understand the impact of this?  If not,
> > the change is probably not a good idea.
> >
> This is that macro definition:
>
> #define GEN_MLME_EXT_HANDLER(size, cmd) {size, cmd},
>
> struct C2HEvent_Header {
>
> #ifdef __LITTLE_ENDIAN
>
>         unsigned int len:16;
>         unsigned int ID:8;
>         unsigned int seq:8;
> #else
>         unsigned int seq:8;
>         unsigned int ID:8;
>         unsigned int len:16;
> #endif
>         unsigned int rsvd;
> };
>
> It's a bit convoluted with regard to my experience. Probably I don't
> understand it fully, but it seems to me to not having effects to the code
> where I removed its use within core/rtw_cmd.c.
>
> What am I missing?

It seems that the function is being put into an array.  Probably someone
expects to find it there.  Probably you have shifted all of the functions
that come afterwards back one slot so that they are all in the wrong
places.

julia
