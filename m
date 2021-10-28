Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A22743E19A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 15:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbhJ1NJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 09:09:10 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:34904
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229603AbhJ1NJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 09:09:08 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AoJA77qFbk/eKvKQepLqE9ceALOsnbusQ8zAX?=
 =?us-ascii?q?PiFKOH9om6Oj5qWTdZgguyMc6wxwZJhfo6HjBEDoexq1nvRICO8qXItKNzOLhI?=
 =?us-ascii?q?LHFuxfBPPZrAHdJw=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="397636735"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Oct 2021 15:06:38 +0200
Date:   Thu, 28 Oct 2021 15:06:38 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
cc:     outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        forest@alittletooquiet.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: Re: [Outreachy kernel] [PATCH 5/7] staging: vt6655: Rewrite conditional
 in AL7320 initialization
In-Reply-To: <1683328.aCfAWUeHFl@localhost.localdomain>
Message-ID: <alpine.DEB.2.22.394.2110281505170.9518@hadrien>
References: <cover.1635415820.git.karolinadrobnik@gmail.com> <948406a3e7d23f1cdf866aa4448d9428bdd32512.1635415820.git.karolinadrobnik@gmail.com> <1683328.aCfAWUeHFl@localhost.localdomain>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 28 Oct 2021, Fabio M. De Francesco wrote:

> On Thursday, October 28, 2021 12:35:35 PM CEST Karolina Drobnik wrote:
> > Use conditional operator to determine which table for AL7320
> > initialization should be used. Use `data` temporary value to
> > store this value.
> >
> > Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
> > ---
> >  drivers/staging/vt6655/rf.c | 11 ++++-------
> >  1 file changed, 4 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/staging/vt6655/rf.c b/drivers/staging/vt6655/rf.c
> > index afd202ea3356..af4eb7eb8e7d 100644
> > --- a/drivers/staging/vt6655/rf.c
> > +++ b/drivers/staging/vt6655/rf.c
> > @@ -716,13 +716,10 @@ bool RFvWriteWakeProgSyn(struct vnt_private *priv,
> unsigned char rf_type,
> >  		if (init_count > (MISCFIFO_SYNDATASIZE - sleep_count))
> >  			return false;
> >
> > -		if (channel <= CB_MAX_CHANNEL_24G) {
> > -			for (i = 0; i < CB_AL7230_INIT_SEQ; i++)
> > -				MACvSetMISCFifo(priv, idx++,
> al7230_init_table[i]);
> > -		} else {
> > -			for (i = 0; i < CB_AL7230_INIT_SEQ; i++)
> > -				MACvSetMISCFifo(priv, idx++,
> al7230_init_table_a_mode[i]);
> > -		}
> > +		data = (channel <= CB_MAX_CHANNEL_24G) ?
> > +			al7230_init_table :
> al7230_init_table_a_mode;
>
> As far as I know by reading some Greg K-H's replies to other developers, this
> "<test> ? <true> : <false>" style is not well accepted here.
>
> I'd prefer to see an explicit "if-else" statement because with that style you
> sacrifice readability and gain nothing here.

Actually, I liked the ?: usage in this case.  We are making an alias, and
it is one thing or another.  One can easily see that the same variable is
assigned in both cases.

Othes could have another opinion, though.

julia


>
> > +		for (i = 0; i < CB_AL7230_INIT_SEQ; i++)
> > +			MACvSetMISCFifo(priv, idx++, *(data++));
>
> Again, as Julia pointed out, "*data++" and "*(data++)" are syntactically
> correct instructions but are not required here. I'm also pretty sure that, by
> not reusing that index, you're adding additional unnecessary instructions to
> the resulting assembly code (unless the compiler is able to optimize it).
>
> "*foo++" and the like are powerful and compact instructions, but you should
> use them in other, more suitable contexts.
>
> Thanks,
>
> Fabio
>
>
> >
> >  		MACvSetMISCFifo(priv, idx++,
> al7230_channel_table0[channel - 1]);
> >  		MACvSetMISCFifo(priv, idx++,
> al7230_channel_table1[channel - 1]);
> > --
> > 2.30.2
> >
> > --
> > You received this message because you are subscribed to the Google Groups
> "outreachy-kernel" group.
> > To unsubscribe from this group and stop receiving emails from it, send an
> email to outreachy-kernel+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/
> outreachy-kernel/
> 948406a3e7d23f1cdf866aa4448d9428bdd32512.1635415820.git.karolinadrobnik%40gmail.com.
> >
>
>
>
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/1683328.aCfAWUeHFl%40localhost.localdomain.
>
