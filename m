Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 054E540AC50
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 13:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbhINLYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 07:24:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:34734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231886AbhINLYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 07:24:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EFFB3610A6;
        Tue, 14 Sep 2021 11:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631618582;
        bh=kfu6a4jCu8cJQ3JpMG8aaqnD0Ribc0g9KJ5RU/IqPFE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hy5wsBNfXqNKcuVem1/JL+jroOGXHnW9pkdNUxd+0vklXiTM0/4SRqFViRX4rQHxo
         Ox2xvgitBU3Lat7uuJwaLDiDoYCkCAuLFtPXNJCcue261O8xkUl2wcukEWnMtDI2wY
         cI+MvJ4N78S2njX0hPs+EPbZWx9zo/ENZF7S48aM=
Date:   Tue, 14 Sep 2021 13:23:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] usb: typec: tipd: Add an additional overflow check
Message-ID: <YUCGFJGiC/ekvmfZ@kroah.com>
References: <20210914104253.61365-1-sven@svenpeter.dev>
 <20210914104253.61365-2-sven@svenpeter.dev>
 <YUCAsmRLu1hBlfRI@kroah.com>
 <05fe66fe-e1a3-46ba-bbd6-8b0a41109b81@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05fe66fe-e1a3-46ba-bbd6-8b0a41109b81@www.fastmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 01:18:16PM +0200, Sven Peter wrote:
> 
> 
> On Tue, Sep 14, 2021, at 13:00, Greg Kroah-Hartman wrote:
> > On Tue, Sep 14, 2021 at 12:42:53PM +0200, Sven Peter wrote:
> > > tps6598x_block_read already checks for the maximum length of the read
> > > but tps6598x_block_write does not. Add the symmetric check there as
> > > well.
> > > 
> > > Signed-off-by: Sven Peter <sven@svenpeter.dev>
> > > ---
> > >  drivers/usb/typec/tipd/core.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> > > index c18ec3785592..70e2d0d410c9 100644
> > > --- a/drivers/usb/typec/tipd/core.c
> > > +++ b/drivers/usb/typec/tipd/core.c
> > > @@ -139,6 +139,9 @@ static int tps6598x_block_write(struct tps6598x *tps, u8 reg,
> > >  {
> > >  	u8 data[TPS_MAX_LEN + 1];
> > >  
> > > +	if (WARN_ON(len + 1 > sizeof(data)))
> > > +		return -EINVAL;
> > 
> > No need to crash anything.  If this is a valid thing for us to check,
> > let's check it and handle the error, but we should not reboot systems
> > that are running with panic-on-warn enabled, right?
> 
> Sure, that makes sense. I guess the same point applies to the WARN_ON in
> the same check in tps6598x_block_read. I can add a patch to remove that one
> to v2 as well.

That would be great, thanks.

greg k-h
