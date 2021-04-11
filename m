Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC8135B2E7
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 11:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235354AbhDKJvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 05:51:51 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:55472 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229804AbhDKJvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 05:51:49 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ANv2ZMqnKuUABvLgY7TB0L8LDHmTpDfLT3DAb?=
 =?us-ascii?q?vn1ZSRFFG/GwvcrGppQm/DXzjyscX2xlpMCYNMC7LE/02JZp7eAqU4uKcxLhvA?=
 =?us-ascii?q?KTR71KzYyn+DH4Hj27y+g178ZdWoxzEsf5A1Q/rcuS2mOFOvIhxNXCz6yyn+fZ?=
 =?us-ascii?q?yB5WIT1CUK1r4wdnBgvzKCQfeCB8CZU0D5aa7MZczgDQG0g/VNixBXUOQoH4yO?=
 =?us-ascii?q?HjqZSOW29kOzcXrC2HjTal89fBYn2l4is=3D?=
X-IronPort-AV: E=Sophos;i="5.82,214,1613430000"; 
   d="scan'208";a="502613962"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Apr 2021 11:51:32 +0200
Date:   Sun, 11 Apr 2021 11:51:32 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
cc:     Julia Lawall <julia.lawall@inria.fr>,
        Greg KH <gregkh@linuxfoundation.org>,
        outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH v3 4/4] staging: rtl8723bs: core:
 Change a controlling expression
In-Reply-To: <2796632.fryDJISotm@localhost.localdomain>
Message-ID: <alpine.DEB.2.22.394.2104111150010.2854@hadrien>
References: <20210411082908.31876-1-fmdefrancesco@gmail.com> <20210411082908.31876-5-fmdefrancesco@gmail.com> <alpine.DEB.2.22.394.2104111125310.2854@hadrien> <2796632.fryDJISotm@localhost.localdomain>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 11 Apr 2021, Fabio M. De Francesco wrote:

> On Sunday, April 11, 2021 11:26:41 AM CEST Julia Lawall wrote:
> > On Sun, 11 Apr 2021, Fabio M. De Francesco wrote:
> > > Change a controlling expression within an 'if' statement: don't compare
> > > with 'true'.
> > >
> > > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > > ---
> > >
> > > Changes from v2: Rewrite subject in patch 0/4; remove a patch from the
> > > series because it had already been applied (rtl8723bs: core: Remove an
> > > unused variable). Changes from v1: Fix a typo in subject of patch 1/5,
> > > add patch 5/5.>
> > >  drivers/staging/rtl8723bs/core/rtw_cmd.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c
> > > b/drivers/staging/rtl8723bs/core/rtw_cmd.c index
> > > 32079e0f71d5..600366cb1aeb 100644
> > > --- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
> > > +++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
> > > @@ -1507,7 +1507,7 @@ static void rtw_lps_change_dtim_hdl(struct
> > > adapter *padapter, u8 dtim)>
> > >  	if (pwrpriv->dtim != dtim)
> > >
> > >  		pwrpriv->dtim = dtim;
> > >
> > > -	if ((pwrpriv->fw_current_in_ps_mode == true) && (pwrpriv-
> >pwr_mode >
> > > PS_MODE_ACTIVE)) { +	if ((pwrpriv->fw_current_in_ps_mode) &&
> > > (pwrpriv->pwr_mode > PS_MODE_ACTIVE)) {
> > The parentheses in the left argument of && can be dropped as well.
> >
> What about the parentheses of the right argument? I'm not sure: does '>'
> have precedence over '&&'? Doesn't it?

On the right they are not actually needed either:

https://en.cppreference.com/w/c/language/operator_precedence

But you could look around in the code and see what people typically do.
Perhaps one might find the parentheses more clear when there is a binary
operator.  But when there is no binary operator, they could be more
confusing than useful.

julia

>
> Thanks,
>
> Fabio
> >
> > julia
> >
> > >  		u8 ps_mode = pwrpriv->pwr_mode;
> > >
> > >  		rtw_hal_set_hwreg(padapter, HW_VAR_H2C_FW_PWRMODE,
> (u8
> > >  		*)(&ps_mode));
> > >
> > > --
> > > 2.31.1
> > >
> > > --
> > > You received this message because you are subscribed to the Google
> > > Groups "outreachy-kernel" group. To unsubscribe from this group and
> > > stop receiving emails from it, send an email to
> > > outreachy-kernel+unsubscribe@googlegroups.com. To view this discussion
> > > on the web visit
> > > https://groups.google.com/d/msgid/outreachy-kernel/20210411082908.3187
> > > 6-5-fmdefrancesco%40gmail.com.
>
>
>
>
>
