Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBA535432F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 17:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237764AbhDEPKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 11:10:04 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:48400
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230391AbhDEPKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 11:10:03 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AxNhREK6xgeoKKlONSAPXwCnXdLJzesId70hD?=
 =?us-ascii?q?6mlaTxtJfsuE0/2/hfhz726RtB89UGwt8OrqBICuWnXZnKQe3aAwOvOYUBDiqC?=
 =?us-ascii?q?+UKuhZjLfK5x3FN2nA+vVG1aFmGpIObeHYKVRhl8717E2ZPr8boOWvy6yjiefA?=
 =?us-ascii?q?w3oFd2gDV4ha4wh0EQqdGEFtLTM2ZqYRLoaW5cZMulObF0g/U8LTPBU4dtTYq8?=
 =?us-ascii?q?aOvJzrZgNuPW9E1CC+yQLt0rL8HhSCty1ybxpEy94ZnlT4rw=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.81,306,1610406000"; 
   d="scan'208";a="377777468"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Apr 2021 17:09:56 +0200
Date:   Mon, 5 Apr 2021 17:09:55 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: Re: [Outreachy kernel] [PATCH] staging: emxx_udc: Ending line with
 argument
In-Reply-To: <82580331-13dc-ed79-72e7-3984fd2f75f9@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2104051708370.2981@hadrien>
References: <20210401195457.24512-1-martinsdecarvalhobeatriz@gmail.com> <alpine.DEB.2.22.394.2104012314480.2908@hadrien> <82580331-13dc-ed79-72e7-3984fd2f75f9@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 5 Apr 2021, Beatriz Martins de Carvalho wrote:

>
> Em 01/04/21 22:16, Julia Lawall escreveu:
> >
> > On Thu, 1 Apr 2021, Beatriz Martins de Carvalho wrote:
> >
> > > Cleans up check of "Lines should not end with a '('"
> > > with argument present in next line in file emxx_udc.c
> > The coding style documentation encourages remaining within 80 characters.
> > I'm not sure that the ( warning is worth increading the excess beyond 80
> > characters (or introducing it in the last case).
> >
> > julia
> Thanks, prof Julia, how the checkpath now warning only if line length of 100
> characters, I used it for reference.

I think it was changed so that people would leave as is code that was
really more readable at 85 or 90 characters.  But the documentation still
encourages 80 characters.

julia

>
> I will take the suggestions of checkpatch with more attention.
>
> Beatriz
>
> > > Signed-off-by: Beatriz Martins de Carvalho
> > > <martinsdecarvalhobeatriz@gmail.com>
> > > ---
> > >   drivers/staging/emxx_udc/emxx_udc.c | 11 ++++-------
> > >   1 file changed, 4 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/staging/emxx_udc/emxx_udc.c
> > > b/drivers/staging/emxx_udc/emxx_udc.c
> > > index 741147a4f0fe..20f53cf6e20f 100644
> > > --- a/drivers/staging/emxx_udc/emxx_udc.c
> > > +++ b/drivers/staging/emxx_udc/emxx_udc.c
> > > @@ -1073,9 +1073,8 @@ static int _nbu2ss_epn_in_pio(struct nbu2ss_udc
> > > *udc, struct nbu2ss_ep *ep,
> > >   		i_word_length = length / sizeof(u32);
> > >   		if (i_word_length > 0) {
> > >   			for (i = 0; i < i_word_length; i++) {
> > > -				_nbu2ss_writel(
> > > -					&preg->EP_REGS[ep->epnum -
> > > 1].EP_WRITE,
> > > -					p_buf_32->dw);
> > > +				_nbu2ss_writel(&preg->EP_REGS[ep->epnum -
> > > 1].EP_WRITE,
> > > +					       p_buf_32->dw);
> > >
> > >   				p_buf_32++;
> > >   			}
> > > @@ -1225,8 +1224,7 @@ static void _nbu2ss_restert_transfer(struct
> > > nbu2ss_ep *ep)
> > >   		return;
> > >
> > >   	if (ep->epnum > 0) {
> > > -		length = _nbu2ss_readl(
> > > -			&ep->udc->p_regs->EP_REGS[ep->epnum - 1].EP_LEN_DCNT);
> > > +		length = _nbu2ss_readl(&ep->udc->p_regs->EP_REGS[ep->epnum -
> > > 1].EP_LEN_DCNT);
> > >
> > >   		length &= EPN_LDATA;
> > >   		if (length < ep->ep.maxpacket)
> > > @@ -1462,8 +1460,7 @@ static void _nbu2ss_epn_set_stall(struct nbu2ss_udc
> > > *udc,
> > >   		for (limit_cnt = 0
> > >   			; limit_cnt < IN_DATA_EMPTY_COUNT
> > >   			; limit_cnt++) {
> > > -			regdata = _nbu2ss_readl(
> > > -				&preg->EP_REGS[ep->epnum - 1].EP_STATUS);
> > > +			regdata = _nbu2ss_readl(&preg->EP_REGS[ep->epnum -
> > > 1].EP_STATUS);
> > >
> > >   			if ((regdata & EPN_IN_DATA) == 0)
> > >   				break;
> > > --
> > > 2.25.1
> > >
> > > --
> > > You received this message because you are subscribed to the Google Groups
> > > "outreachy-kernel" group.
> > > To unsubscribe from this group and stop receiving emails from it, send an
> > > email to outreachy-kernel+unsubscribe@googlegroups.com.
> > > To view this discussion on the web visit
> > > https://groups.google.com/d/msgid/outreachy-kernel/20210401195457.24512-1-martinsdecarvalhobeatriz%40gmail.com.
> > >
>
> --
> You received this message because you are subscribed to the Google Groups
> "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to outreachy-kernel+unsubscribe@googlegroups.com.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/outreachy-kernel/82580331-13dc-ed79-72e7-3984fd2f75f9%40gmail.com.
>
