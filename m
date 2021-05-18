Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDAF2387C6B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 17:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350195AbhERP1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 11:27:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:55374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350165AbhERP1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 11:27:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A45A6611EE;
        Tue, 18 May 2021 15:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621351588;
        bh=jUSHFrFQ8qTg0H2mRwHZmLGGLMuz5XhnCFS3Tl63K3M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BpIFnt01TSD44meO0X6H/qr0AtsMimPg6GGBmIHtTcIgonJp3WUS3fI7nSA7wIiv2
         4NouBDwvu4rnEy5t5e5FG2kvy7jZw4IyHXl1KuDZvIrX5dYxy70A6XPU/cuorZmLjh
         hfmsHQA9EP14MU4LxWlV8zD/GhVQC3qQIyGzJ/30=
Date:   Tue, 18 May 2021 17:26:26 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] driver core: platform: Remove
 platform_device_add_properties()
Message-ID: <YKPcol2IUVDHMGTE@kroah.com>
References: <20210518083046.23302-1-heikki.krogerus@linux.intel.com>
 <YKOB6lRqc5DKo2GS@smile.fi.intel.com>
 <YKOjRyGlx6bHtgZc@kuha.fi.intel.com>
 <YKOlcQqLarSIxE37@kuha.fi.intel.com>
 <YKOplS4Z4lleYWht@smile.fi.intel.com>
 <YKO1wiwCzSx62OIK@kroah.com>
 <CAJZ5v0hyXOQuLCKB9D_-j64VK-syo5AZmSgEGRHSyuMyvVciOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hyXOQuLCKB9D_-j64VK-syo5AZmSgEGRHSyuMyvVciOg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 02:53:09PM +0200, Rafael J. Wysocki wrote:
> On Tue, May 18, 2021 at 2:40 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, May 18, 2021 at 02:48:37PM +0300, Andy Shevchenko wrote:
> > > On Tue, May 18, 2021 at 02:30:57PM +0300, Heikki Krogerus wrote:
> > > > On Tue, May 18, 2021 at 02:21:46PM +0300, Heikki Krogerus wrote:
> > > > > On Tue, May 18, 2021 at 11:59:22AM +0300, Andy Shevchenko wrote:
> > > > > > On Tue, May 18, 2021 at 11:30:44AM +0300, Heikki Krogerus wrote:
> > > > > > > Hi,
> > > > > > >
> > > > > > > It looks like there is only one place left that still uses the
> > > > > > > function. Converting that last user and removing the thing.
> > > > > > >
> > > > > > > Note, I'm actually resending the patch for board-paz00.c. I'm assuming
> > > > > > > the original patch slipped through the cracks because it did not end
> > > > > > > up anywhere.
> > > > > >
> > > > > > Cool!
> > > > > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > > >
> > > > > > Btw, which base have you used for this series?
> > > > >
> > > > > intel-next for this one.
> > > >
> > > > I mean linux-next :-)
> > >
> > > Let's wait for CIs to respond. I have a feeling that the first patch is good
> > > for v5.14, while the second one is probably for the next cycle.
> >
> > Why?  I can take both now, no problem...
> 
> Not really, there are dependencies, one in my tree ATM.
> 
> It's better if I take them IMHO.

Sure, feel free to:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
