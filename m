Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21EC943E00F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 13:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbhJ1Lfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 07:35:30 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:52314
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229835AbhJ1Lf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 07:35:27 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AKu29D64TDQWXMYi7ggPXwM/XdLJyesId70hD?=
 =?us-ascii?q?6qkRc20wTiX2rauTdZggvyMczQxxZJhCo6HkBEDjexPhHPdOiOEs1PWZLWrbUQ?=
 =?us-ascii?q?CTQr2Kg7GP/9StIVydysdtkZYlSaR4BdHqZGIWse/x6mCDfOod/A=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="397625768"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Oct 2021 13:32:59 +0200
Date:   Thu, 28 Oct 2021 13:32:58 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
cc:     outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        forest@alittletooquiet.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: Re: [Outreachy kernel] [PATCH 4/7] staging: vt6655: Introduce `data`
 temporary variable
In-Reply-To: <2039159.k92FijXA2m@localhost.localdomain>
Message-ID: <alpine.DEB.2.22.394.2110281332040.9518@hadrien>
References: <cover.1635415820.git.karolinadrobnik@gmail.com> <dc72a4c3539aed70569f66396ed3b51818bc2aea.1635415820.git.karolinadrobnik@gmail.com> <2039159.k92FijXA2m@localhost.localdomain>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 28 Oct 2021, Fabio M. De Francesco wrote:

> On Thursday, October 28, 2021 12:35:34 PM CEST Karolina Drobnik wrote:
> > Add a variable to store initialization tables. Use this variable
> > in AL2230 initialization.
> >
> > Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
> > ---
> >  drivers/staging/vt6655/rf.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/staging/vt6655/rf.c b/drivers/staging/vt6655/rf.c
> > index ea74701917e5..afd202ea3356 100644
> > --- a/drivers/staging/vt6655/rf.c
> > +++ b/drivers/staging/vt6655/rf.c
> > @@ -684,6 +684,7 @@ bool RFvWriteWakeProgSyn(struct vnt_private *priv,
> unsigned char rf_type,
> >  	unsigned short idx = MISCFIFO_SYNDATA_IDX;
> >  	unsigned char init_count = 0;
> >  	unsigned char sleep_count = 0;
> > +	const unsigned long *data;
> >
> >  	VNSvOutPortW(iobase + MAC_REG_MISCFFNDEX, 0);
> >  	switch (rf_type) {
> > @@ -699,8 +700,9 @@ bool RFvWriteWakeProgSyn(struct vnt_private *priv,
> unsigned char rf_type,
> >  		if (init_count > (MISCFIFO_SYNDATASIZE - sleep_count))
> >  			return false;
> >
> > +		data = al2230_init_table;
> >  		for (i = 0; i < CB_AL2230_INIT_SEQ; i++)
> > -			MACvSetMISCFifo(priv, idx++,
> al2230_init_table[i]);
> > +			MACvSetMISCFifo(priv, idx++, *(data++));
>
> Hi Karolina,
>
> I think you are using redundant parentheses in "* (data ++)" but understand
> that those increments and dereferences are equivalent to "* data ++"
> (according to the C precedence rules).
>
> Some time ago I suggested that you use those redundant parentheses because
> Greg Kroah-Hartman had previously explained that he prefers not to see
> "*foo++" because maintainers and reviewers are not required to remember the C
> precedence rules.
>
> I hope my suggestion isn't based on a misunderstanding of what Greg wants
> here and that your patch can be accepted as is.
>
> While we are at it, please notice that Maintainers of different subsystems
> may see this topic from a different point of view and that they might very
> well ask you for removing those redundant parentheses.
>
> I'd suggest to use grep and find out what is preferred in other subsystems,
> when you want to contribute to other parts of Linux.

Would it be better as data[i] ?

Could there be a better name than "data"?  Perhaps "table"?

julia


>
> Thanks,
>
> Fabio
>
> >  		MACvSetMISCFifo(priv, idx++,
> al2230_channel_table0[channel - 1]);
> >  		MACvSetMISCFifo(priv, idx++,
> al2230_channel_table1[channel - 1]);
> > --
> > 2.30.2
> >
> > --
> > You received this message because you are subscribed to the Google Groups
> "outreachy-kernel" group.
> > To unsubscribe from this group and stop receiving emails from it, send an
> email to outreachy-kernel+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/
> outreachy-kernel/dc72a4c3539aed70569f66396ed3b51818bc2aea.
> 1635415820.git.karolinadrobnik%40gmail.com.
> >
>
>
>
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/2039159.k92FijXA2m%40localhost.localdomain.
>
