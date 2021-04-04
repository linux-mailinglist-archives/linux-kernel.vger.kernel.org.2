Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDE1B3537AA
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Apr 2021 11:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbhDDJuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 05:50:23 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:19258 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229578AbhDDJuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 05:50:22 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Adcou7qj++GYHqnciWfCshfVeGHBQXjsji2hD?=
 =?us-ascii?q?6mlwRA09T+WzkceykPMHkSLlkTp5YgBFpfmsMLSNKEm2ybdb+o8UVI3JYCDHvy?=
 =?us-ascii?q?+SIJhm/c/exVTbehHW0s54+eNef7NlCNv2ZGIK6PrSxAWjCd4vzJ2m3cmT5dv2?=
 =?us-ascii?q?9HtmQQF0Z6wI1W4QNi+hHkJ7XwVAD5YifaDshfZvnSaqengcc62AaEUtYu6rnb?=
 =?us-ascii?q?H2va79bQVDLxAq7xTmt0LL1JfKVynd5BsYXj9VqI1OzUHOmWXCiZmejw=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.81,304,1610406000"; 
   d="scan'208";a="501509830"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Apr 2021 11:50:17 +0200
Date:   Sun, 4 Apr 2021 11:50:17 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Deborah Brouwer <deborahbrouwer3563@gmail.com>
cc:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        insafonov@gmail.com, martin@kaiser.cx, simon.fodin@gmail.com,
        straube.linux@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: Re: [Outreachy kernel] [PATCH] staging: rtl8188eu: core: add comma
 within a comment
In-Reply-To: <20210403213724.GA18745@djbComp>
Message-ID: <alpine.DEB.2.22.394.2104041149510.2958@hadrien>
References: <20210403210930.17781-1-deborahbrouwer3563@gmail.com> <alpine.DEB.2.22.394.2104032315200.7875@hadrien> <20210403213724.GA18745@djbComp>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 3 Apr 2021, Deborah Brouwer wrote:

> On Sat, Apr 03, 2021 at 11:16:16PM +0200, Julia Lawall wrote:
> >
> >
> > On Sat, 3 Apr 2021, Deborah Brouwer wrote:
> >
> > > Add a comma to separate repeated words in a comment. The comma preserves
> > > the meaning of the comment while also stopping the checkpatch warning:
> > > WARNING: Possible repeated word: 'very'.
> >
> > Thanks.  That is more understandable.  Isn't this a v2?  If so, there
> > should be v2 after PATCH and an explanation of the change under the ---
> >
> > julia
> Hi Julia, no this is not a v2.  I found the same comment, generating the same
> error, in a different file.  Since I changed it in
> rtl8723bs/core/rtw_xmit.c [1], I thought I should be consistent and change
> it here as well.

OK, thanks for the explanation :)

julia

>
> [1] https://lore.kernel.org/r/2944d1a0e8769edb489bb336423625a61d314d05.1617229359.git.deborahbrouwer3563@gmail.com
>
> >
> >
> > >
> > > Signed-off-by: Deborah Brouwer <deborahbrouwer3563@gmail.com>
> > > ---
> > >  drivers/staging/rtl8188eu/core/rtw_xmit.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/staging/rtl8188eu/core/rtw_xmit.c b/drivers/staging/rtl8188eu/core/rtw_xmit.c
> > > index ed81cbc5e191..99e44b2c6f36 100644
> > > --- a/drivers/staging/rtl8188eu/core/rtw_xmit.c
> > > +++ b/drivers/staging/rtl8188eu/core/rtw_xmit.c
> > > @@ -1243,7 +1243,7 @@ s32 rtw_free_xmitbuf(struct xmit_priv *pxmitpriv, struct xmit_buf *pxmitbuf)
> > >   * If we turn on USE_RXTHREAD, then, no need for critical section.
> > >   * Otherwise, we must use _enter/_exit critical to protect free_xmit_queue...
> > >   *
> > > - * Must be very very cautious...
> > > + * Must be very, very cautious...
> > >   *
> > >   */
> > >
> > > --
> > > 2.17.1
> > >
> > > --
> > > You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> > > To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> > > To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20210403210930.17781-1-deborahbrouwer3563%40gmail.com.
> > >
>
