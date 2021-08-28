Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C43C93FA4CF
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 11:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbhH1Jo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 05:44:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:60726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230444AbhH1Jo4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 05:44:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1E41B6054E;
        Sat, 28 Aug 2021 09:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630143845;
        bh=x/lg3zgHWReyf3vjQgN74OPkwZEO+XBJFQK5Qu0Hq4g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f2oQMK+BkraDZynJndwwmgcHoSOU5lPVpgcxbE3z4LUejm73dAd37kBkTYZpq6KSd
         eqWZ6KhEHrOgaCRItYDrZ2ttsoYYPdUznfYlKalOamIhJaCMng7/gONZ+fIIVN2FVj
         pOVub71Wy6//n5Ueb0PTg/VtQZOE+FgywcHDT9EQ=
Date:   Sat, 28 Aug 2021 11:44:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
Cc:     hello@bryanbrattlof.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: pi433: fix docs typos and references to
 previous struct names
Message-ID: <YSoFYT+8v979+Y1/@kroah.com>
References: <20210828000836.GA10188@localhost.localdomain>
 <YSnT5rXxQNE2sPvw@kroah.com>
 <20210828092757.GA3773@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210828092757.GA3773@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2021 at 09:27:57PM +1200, Paulo Miguel Almeida wrote:
> On Sat, Aug 28, 2021 at 08:12:54AM +0200, Greg KH wrote:
> > On Sat, Aug 28, 2021 at 12:08:36PM +1200, Paulo Miguel Almeida wrote:
> > > In the comments there where some grammar mistakes and references to
> > > struct names that have gotten renamed over time but not reflected
> > > in the comments.
> > > 
> > > Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
> > > ---
> > >  drivers/staging/pi433/pi433_if.h | 25 ++++++++++++-------------
> > >  1 file changed, 12 insertions(+), 13 deletions(-)
> > > 
> > > diff --git a/drivers/staging/pi433/pi433_if.h b/drivers/staging/pi433/pi433_if.h
> > > index d5c1521192c1..1fae62c40661 100644
> > > --- a/drivers/staging/pi433/pi433_if.h
> > > +++ b/drivers/staging/pi433/pi433_if.h
> > > @@ -5,16 +5,15 @@
> > >   * userspace interface for pi433 radio module
> > >   *
> > >   * Pi433 is a 433MHz radio module for the Raspberry Pi.
> > > - * It is based on the HopeRf Module RFM69CW. Therefore inside of this
> > > - * driver, you'll find an abstraction of the rf69 chip.
> > > + * It is based on the HopeRf Module RFM69CW. Therefore, inside of this
> > > + * driver you'll find an abstraction of the rf69 chip.
> > >   *
> > > - * If needed, this driver could be extended, to also support other
> > > - * devices, basing on HopeRfs rf69.
> > > + * If needed this driver could also be extended to support other
> > > + * devices based on HopeRf rf69 as well as HopeRf modules with a similar
> > > + * interface such as RFM69HCW, RFM12, RFM95 and so on.
> > >   *
> > > - * The driver can also be extended, to support other modules of
> > > - * HopeRf with a similar interace - e. g. RFM69HCW, RFM12, RFM95, ...
> > >   * Copyright (C) 2016 Wolf-Entwicklungen
> > > - *	Marcus Wolf <linux@wolf-entwicklungen.de>
> > > + * Marcus Wolf <linux@wolf-entwicklungen.de>
> > 
> > Indentation of the name should remain here, right?
> > 
> > thanks,
> > 
> > greg k-h
> 
> you are right, I shouldn't have changed that line. Do you need me to
> send another patch without that line or can you ignore just that line 
> before merging it to your branch? I'm flexible with any approach.

It is impossible to just "ignore a single line" in a diff, sorry.

Please fix up and resend a new version, remember the work needs to be
done by the developer, not the maintainer.  Your job is to make it
trivial for me to accept your change.  Manually having to edit diffs is
not scalable at all.

thanks,

greg k-h
