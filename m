Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCCF2315FAD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 07:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbhBJGqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 01:46:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:54376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232119AbhBJGpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 01:45:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8081864E5A;
        Wed, 10 Feb 2021 06:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612939485;
        bh=WiJgk07TjCR04Om+mu1V8PUBj7bUlsePiOX3zbKELQQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rQ8pl7VdsfhFHG2MDQgVn9vPy7eSUdqFR+mEXDRJprkn+CDzEMZdCo1xkQEbetz1w
         M2ZopFZldg8qxyrUHnaiQKeptuzlDz6sStBEkUll45VP3UYF+oGheptFi/RvyyQ4Me
         wEwuTZVO+WIj3WGH7H7qrEqQx8R9YMJo9SLrtbMQ=
Date:   Wed, 10 Feb 2021 07:44:41 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Dave Jiang <dave.jiang@intel.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        Dave Ertman <david.m.ertman@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] driver core: auxiliary bus: Fix calling stage for
 auxiliary bus init
Message-ID: <YCOA2fr1CBSmepO7@kroah.com>
References: <161289750572.1086235.9903492973331406876.stgit@djiang5-desk3.ch.intel.com>
 <YCLfETxDjOUPISpw@kroah.com>
 <CAPcyv4inpcwh5rH2bJSSqXuWCNxFAzLrbWLy-_yDAuzDenYURg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4inpcwh5rH2bJSSqXuWCNxFAzLrbWLy-_yDAuzDenYURg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 12:01:06PM -0800, Dan Williams wrote:
> On Tue, Feb 9, 2021 at 11:16 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> [..]
> > > diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
> > > index 8336535f1e11..53f93a506626 100644
> > > --- a/drivers/base/auxiliary.c
> > > +++ b/drivers/base/auxiliary.c
> > > @@ -270,7 +270,7 @@ static void __exit auxiliary_bus_exit(void)
> > >       bus_unregister(&auxiliary_bus_type);
> > >  }
> > >
> > > -module_init(auxiliary_bus_init);
> > > +subsys_initcall(auxiliary_bus_init);
> >
> > Ah, the linker priority dance.  Are you _SURE_ this will solve this?
> 
> All users are module_init() today so it will work.... today. The
> moment someone wants to use it in a built-in driver that uses
> subsystem_init() it will ultimately be chased into driver_init().
> 
> > Why not just call this explicitly in driver_init() so that you know it
> > will be ok?  Just like we do for the platform bus?
> 
> Cross that bridge when / if it happens?

Let's fix it properly now please.

thanks,

greg k-h
