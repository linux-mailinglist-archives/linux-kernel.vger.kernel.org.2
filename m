Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B25F4119A4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 18:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243527AbhITQUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 12:20:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:53240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243148AbhITQU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 12:20:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AF53360F58;
        Mon, 20 Sep 2021 16:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632154741;
        bh=6FXC88wf88wJ4eN94yjBPS1MhEcuAcGvbrDrhF4661Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VPEt4qHe5Df4DBjv69PbMTy38I7DHRiJVY9NoJxisCWih4NZ0/YzgfwsmQMqTGJ3C
         kqCiZvkbdlCeVkZbApXNgWMlH5sXlmY4mKI001CxbU0fM30CZjwACXcqO6q3dVoSRt
         gKsQCTEDbYqCAwjDCmmFoSff4LBzslBO25x2NfrQ=
Date:   Mon, 20 Sep 2021 18:18:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zachary Mayhew <zacklukem.kernel@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@lists.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: add docs for fbtft_write_spi()
Message-ID: <YUi0coGlTkQ0C5Rm@kroah.com>
References: <20210920152601.170453-1-zacklukem.kernel@gmail.com>
 <YUiq9iDGLN6+5+rd@kroah.com>
 <YUixsZQ/J0dPfJqj@Zachary-Arch.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUixsZQ/J0dPfJqj@Zachary-Arch.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 09:07:13AM -0700, Zachary Mayhew wrote:
> On Mon, Sep 20, 2021 at 05:38:30PM +0200, Greg KH wrote:
> > On Mon, Sep 20, 2021 at 08:26:03AM -0700, Zachary Mayhew wrote:
> > > Subject: [PATCH] staging: fbtft: add docs for fbtft_write_spi()
> > 
> > Odd, this shouldn't be in the body of the email :(
> > 
> > > 
> > > This patch adds documentation for fbtft_write_spi() to make its
> > > calling context clear and explain what it does.
> > > 
> > > Signed-off-by: Zachary Mayhew <zacklukem.kernel@gmail.com>
> > > ---
> > >  drivers/staging/fbtft/fbtft-io.c | 13 +++++++++++++
> > >  1 file changed, 13 insertions(+)
> > > 
> > > diff --git a/drivers/staging/fbtft/fbtft-io.c b/drivers/staging/fbtft/fbtft-io.c
> > > index de1904a443c2..985d7cf8c774 100644
> > > --- a/drivers/staging/fbtft/fbtft-io.c
> > > +++ b/drivers/staging/fbtft/fbtft-io.c
> > > @@ -5,6 +5,19 @@
> > >  #include <linux/spi/spi.h>
> > >  #include "fbtft.h"
> > >  
> > > +/**
> > > + * fbtft_write_spi() - write data to current spi
> > > + * @par: Driver data including driver &struct spi_device
> > > + * @buf: Buffer to write to spi
> > > + * @len: Length of the buffer
> > > + * Context: can sleep
> > > + *
> > > + * Builds an &struct spi_transfer and &struct spi_message object based on the
> > > + * given @buf and @len.  These are then used in a call to spi_sync() which will
> > > + * write to the spi.
> > > + *
> > > + * Return: zero on success or else a negative error code
> > > + */
> > >  int fbtft_write_spi(struct fbtft_par *par, void *buf, size_t len)
> > >  {
> > >  	struct spi_transfer t = {
> > > -- 
> > > 2.33.0
> > > 
> > > 
> > 
> > Is this file being imported into the kernel doc tools?  If so, great, if
> > not, this isn't going to help out all that much, right?
> 
> It doesn't appear to be imported at this time, as such it may not be
> necessary.

So is this change needed?

thanks,

greg k-h
