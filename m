Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C039735FA21
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 19:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351272AbhDNR53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 13:57:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:35038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234303AbhDNR51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 13:57:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9150960FF0;
        Wed, 14 Apr 2021 17:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618423026;
        bh=cQ9f4u2xR3uFXq5S5htMvUykddDB8bI00VAaR7ZaQ1Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qy9wu/cxBjQjTqY7RD0xDdNPYZkaERYrUM11TFHPJn3SWjjBTn0YRN8xC5Jlqv6tI
         bMKCsazVI4rEk3y8sybmRIWDXWfITeLg4OTZmksiWoIiOG0bILBf7G9GtKHDVtLxHa
         s/xUunAuWw0DzlfEkpgkke88wBG6T/ztOs4eIVFI=
Date:   Wed, 14 Apr 2021 19:57:03 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Julia Lawall <julia.lawall@inria.fr>
Subject: Re: [Outreachy kernel] [PATCH v2] staging: rtl8723bs: Remove useless
 led_blink_hdl()
Message-ID: <YHcs70RdhaBBZv0i@kroah.com>
References: <20210414162614.14867-1-fmdefrancesco@gmail.com>
 <YHcfud6Fpsi9Weac@kroah.com>
 <20210414174809.GX6021@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414174809.GX6021@kadam>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 08:48:09PM +0300, Dan Carpenter wrote:
> On Wed, Apr 14, 2021 at 07:00:41PM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Apr 14, 2021 at 06:26:14PM +0200, Fabio M. De Francesco wrote:
> > > Removed useless led_blink_hdl() prototype and definition. In wlancmds[]
> > > the slot #60 is now set to NULL using the macro GEN_MLME_EXT_HANDLER. This
> > > change has not unwanted side effects because the code in rtw_cmd.c checks
> > > if the function pointer is valid before using it.
> > > 
> > > Reported-by: Julia Lawall <julia.lawall@inria.fr>
> > > Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > > ---
> > > 
> > > Changes since v1: Corrected a bad solution to this issue that made use of
> > > an unnecessary dummy function.
> > > 
> > >  drivers/staging/rtl8723bs/core/rtw_cmd.c         | 2 +-
> > >  drivers/staging/rtl8723bs/core/rtw_mlme_ext.c    | 9 ---------
> > >  drivers/staging/rtl8723bs/include/rtw_mlme_ext.h | 1 -
> > >  3 files changed, 1 insertion(+), 11 deletions(-)
> > > 
> > > diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
> > > index 0297fbad7bce..f82dbd4f4c3d 100644
> > > --- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
> > > +++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
> > > @@ -150,7 +150,7 @@ static struct cmd_hdl wlancmds[] = {
> > >  
> > >  	GEN_MLME_EXT_HANDLER(0, h2c_msg_hdl) /*58*/
> > >  	GEN_MLME_EXT_HANDLER(sizeof(struct SetChannelPlan_param), set_chplan_hdl) /*59*/
> > > -	GEN_MLME_EXT_HANDLER(sizeof(struct LedBlink_param), led_blink_hdl) /*60*/
> > > +	GEN_MLME_EXT_HANDLER(0, NULL) /*60*/
> > 
> > Better, but you really do not need to keep this here, right?  Remove the
> > "led blink command" entirely, you didn't do that here.
> 
> No, this is right.  We have to put a NULL function pointer in the array
> or the indexing will be off.  But Fabio is correct that the struct
> type should be removed.

The indexing can be off, just remove the other place where the "command"
is in the index and all is good as rebuilding will fix it.  These are
not external "values" we have to keep stable.

This has been done for other drivers exactly like this, there are loads
of "odd" commands in there that should not be.

thanks,

greg k-h
