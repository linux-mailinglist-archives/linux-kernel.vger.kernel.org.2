Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B01C4434D49
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 16:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbhJTOTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 10:19:03 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:52090 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229639AbhJTOTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 10:19:02 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AHVsaF630E9OvsxVBhXdDqwqjBLUkLtp133Aq?=
 =?us-ascii?q?2lEZdPU1SL3/qynKpp536faaslcssR0b+exoQZPvfZq+z+8T3WByB8bGYOCOgg?=
 =?us-ascii?q?LBR72Ki7GSoAEIcxeTygc379YFT0ERMqyTMbCk5fyU3OHee+xQueW6zA=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="535002300"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Oct 2021 16:16:43 +0200
Date:   Wed, 20 Oct 2021 16:16:42 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Joe Perches <joe@perches.com>
cc:     Karolina Drobnik <karolinadrobnik@gmail.com>,
        outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        forest@alittletooquiet.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] Re: [PATCH] staging: vt6655: Rename
 `dwAL2230InitTable` array
In-Reply-To: <157ee66fd0e3304c238e7ad8123277892e0d1132.camel@perches.com>
Message-ID: <alpine.DEB.2.22.394.2110201615590.2930@hadrien>
References: <20211020132811.417341-1-karolinadrobnik@gmail.com>  <16db455b46f130300b5c346160aa434616e4f6b4.camel@perches.com> <157ee66fd0e3304c238e7ad8123277892e0d1132.camel@perches.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 20 Oct 2021, Joe Perches wrote:

> On Wed, 2021-10-20 at 06:44 -0700, Joe Perches wrote:
> > trivial suggestion:
> >
> > > diff --git a/drivers/staging/vt6655/rf.c b/drivers/staging/vt6655/rf.c
> > []
> > > @@ -33,7 +33,7 @@
> > >  #define SWITCH_CHANNEL_DELAY_AL7230 200 /* us */
> > >  #define AL7230_PWR_IDX_LEN    64
> > >
> > > -static const unsigned long dwAL2230InitTable[CB_AL2230_INIT_SEQ] = {
> > > +static const unsigned long al2230_init_table[CB_AL2230_INIT_SEQ] = {
> > >  	0x03F79000 + (BY_AL2230_REG_LEN << 3) + IFREGCTL_REGW,
> > >  	0x03333100 + (BY_AL2230_REG_LEN << 3) + IFREGCTL_REGW,
> > >  	0x01A00200 + (BY_AL2230_REG_LEN << 3) + IFREGCTL_REGW,
> >
> > In this file there are more than 100 uses of
> >
> > 	(BY_AL2230_REG_LEN << 3) + IFREGCTL_REGW
> >
> > Maybe add a define for it and substitute the uses for the define.
>
> Look at the code too.
>
> It looks as if every use of IFRFbWriteEmbedded() has this added to
> the 2nd argument and that the 2nd argument isn't used anywhere else.
>
> Maybe remove it altogether and add it to IFRFbWriteEmbedded().
>
> And it looks as if the + uses for these should logically be |
>
> Something like:
>
> diff --git a/drivers/staging/vt6655/rf.c b/drivers/staging/vt6655/rf.c
> index 0dae593c6944f..26803f6f9a27b 100644
> --- a/drivers/staging/vt6655/rf.c
> +++ b/drivers/staging/vt6655/rf.c
> @@ -498,7 +498,8 @@ bool IFRFbWriteEmbedded(struct vnt_private *priv, unsigned long dwData)
>         unsigned short ww;
>         unsigned long dwValue;
>
> -       VNSvOutPortD(iobase + MAC_REG_IFREGCTL, dwData);
> +       VNSvOutPortD(iobase + MAC_REG_IFREGCTL,
> +                    dwData | (BY_AL2230_REG_LEN << 3) | IFREGCTL_REGW);
>
>         /* W_MAX_TIMEOUT is the timeout period */
>         for (ww = 0; ww < W_MAX_TIMEOUT; ww++) {

Karolina,

If more than a hundred such changes are necessary, you may find Coccinelle
useful:  https://coccinelle.gitlabpages.inria.fr/website/

julia


>
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/157ee66fd0e3304c238e7ad8123277892e0d1132.camel%40perches.com.
>
