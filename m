Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D68A73595F4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 09:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbhDIHBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 03:01:02 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:38726 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233333AbhDIHBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 03:01:01 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AaZky869hf89ZhSeqzB1uk+A3I+orLtY04lQ7?=
 =?us-ascii?q?vn1ZYxpTb8CeioSKlPMUyRf7hF8qKRQdsPqHP7SNRm6ZyI5t7eAqTNWfdSTvpW?=
 =?us-ascii?q?fAFu9fxKT4xTmIIUHD385bkZxtaq1vTOD3ZGIK7vrSxCmdP5IezMKc8Kau7N2/?=
 =?us-ascii?q?815IQRtxY69tqydVYzz1LmRMSANLBYU0GfOnj6J6jgGtdngNYsOwCmNtZYX+ju?=
 =?us-ascii?q?fWn5HrawNuPXUawTSJ5AnD1JfHCRSCmj8RXzRTqI1CzVT4?=
X-IronPort-AV: E=Sophos;i="5.82,208,1613430000"; 
   d="scan'208";a="502341671"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Apr 2021 09:00:48 +0200
Date:   Fri, 9 Apr 2021 09:00:48 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Mitali Borkar <mitaliborkar810@gmail.com>
cc:     clabbe@baylibre.com, mchehab@kernel.org,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com,
        mitali_s@me.iitr.ac.in
Subject: Re: [Outreachy kernel] [PATCH 2/2] media: zoran: replace bit shifts
 by BIT() macro
In-Reply-To: <YG+OibRNRmILe8nQ@kali>
Message-ID: <alpine.DEB.2.22.394.2104090900350.2852@hadrien>
References: <cover.1617912177.git.mitaliborkar810@gmail.com> <ac8ec2b70ac2cc7c541c05a1d9a8db1fe79df793.1617912177.git.mitaliborkar810@gmail.com> <alpine.DEB.2.22.394.2104082314090.21785@hadrien> <YG95l9b++d+RFrDa@kali> <alpine.DEB.2.22.394.2104090009220.21785@hadrien>
 <YG+OibRNRmILe8nQ@kali>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 9 Apr 2021, Mitali Borkar wrote:

> On Fri, Apr 09, 2021 at 12:10:06AM +0200, Julia Lawall wrote:
> >
> >
> > On Fri, 9 Apr 2021, Mitali Borkar wrote:
> >
> > > On Thu, Apr 08, 2021 at 11:15:07PM +0200, Julia Lawall wrote:
> > > >
> > > >
> > > > On Fri, 9 Apr 2021, Mitali Borkar wrote:
> > > >
> > > > > Added #include <linux/bitops.h> and replaced bit shifts by BIT() macro.
> > > > > This BIT() macro from linux/bitops.h is used to define ZR36057_VFESPFR_* bitmasks.
> > > > > Use of macro is better and neater. It maintains consistency.
> > > > > Reported by checkpatch.
> > > > >
> > > > > Signed-off-by: Mitali Borkar <mitaliborkar810@gmail.com>
> > > > > ---
> > > > >  drivers/staging/media/zoran/zr36057.h | 10 ++++++----
> > > > >  1 file changed, 6 insertions(+), 4 deletions(-)
> > > > >
> > > > > diff --git a/drivers/staging/media/zoran/zr36057.h b/drivers/staging/media/zoran/zr36057.h
> > > > > index a2a75fd9f535..93075459f910 100644
> > > > > --- a/drivers/staging/media/zoran/zr36057.h
> > > > > +++ b/drivers/staging/media/zoran/zr36057.h
> > > > > @@ -8,6 +8,8 @@
> > > > >  #ifndef _ZR36057_H_
> > > > >  #define _ZR36057_H_
> > > > >
> > > > > +#include <linux/bitops.h>
> > > > > +
> > > > >  /* Zoran ZR36057 registers */
> > > > >
> > > > >  #define ZR36057_VFEHCR          0x000	/* Video Front End, Horizontal Configuration Register */
> > > > > @@ -31,12 +33,12 @@
> > > > >  #define ZR36057_VFESPFR_VER_DCM          8
> > > > >  #define ZR36057_VFESPFR_DISP_MODE        6
> > > > >  #define ZR36057_VFESPFR_YUV422          (0 << 3)
> > > > > -#define ZR36057_VFESPFR_RGB888          (1 << 3)
> > > > > +#define ZR36057_VFESPFR_RGB888          BIT(3)
> > > >
> > > > Uniformity is generally considered to be more important than using BIT.
> > > > Having only a few constants defined using BIT is a bit strange.
> > > >
> > > Okay Ma'am. Can you please tell me on how to proceed now? I am not sure
> > > how to proceed.
> >
> > I think that this code should just be left as is.
> >
> > Checkpatch makes suggestions.  Its suggestions are not always appropriate
> > for the context.
> >
> Okay Ma'am. This means I should not do any changes now. Do I need to do
> something in this patch now? Or move onto next one?

You can move on.

julia

>
> > julia
> >
> > >
> > > > julia
> > > >
> > > > >  #define ZR36057_VFESPFR_RGB565          (2 << 3)
> > > > >  #define ZR36057_VFESPFR_RGB555          (3 << 3)
> > > > > -#define ZR36057_VFESPFR_ERR_DIF          (1 << 2)
> > > > > -#define ZR36057_VFESPFR_PACK24          (1 << 1)
> > > > > -#define ZR36057_VFESPFR_LITTLE_ENDIAN    (1 << 0)
> > > > > +#define ZR36057_VFESPFR_ERR_DIF          BIT(2)
> > > > > +#define ZR36057_VFESPFR_PACK24          BIT(1)
> > > > > +#define ZR36057_VFESPFR_LITTLE_ENDIAN    BIT(0)
> > > > >
> > > > >  #define ZR36057_VDTR            0x00c	/* Video Display "Top" Register */
> > > > >
> > > > > --
> > > > > 2.30.2
> > > > >
> > > > > --
> > > > > You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> > > > > To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> > > > > To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/ac8ec2b70ac2cc7c541c05a1d9a8db1fe79df793.1617912177.git.mitaliborkar810%40gmail.com.
> > > > >
> > >
>
