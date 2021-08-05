Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57B243E1CB3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 21:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235149AbhHET2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 15:28:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:47386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230342AbhHET2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 15:28:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 258BD60ED6;
        Thu,  5 Aug 2021 19:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628191705;
        bh=JhNL8KuD2szPC+zCm2RHptrrY9pP+yh9GzSS1BHqGXk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YDtmgTRhgVn//s60xzR/jK13i0jZlQMkn6EfeUv57be7mrn/qB6We+tYh+Z0TTmLW
         TFT1vqL9k3QogzFpRrORefk5HXpd4UNEeMCxQHfUoVaQVIMTMUUDeFdrzQIq2Lbw41
         6NS9gbs1SKAHhO083Cdsd/+Y8DmIW5ag7m+UhMXg=
Date:   Thu, 5 Aug 2021 21:28:22 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v1] driver: base: Add driver filter support
Message-ID: <YQw71hBx4/w14Fir@kroah.com>
References: <YQuYCePPZEmVbkfc@kroah.com>
 <YQuZdVuaGG/Cr62y@kroah.com>
 <YQuaJ78y8j1UmBoz@kroah.com>
 <fdf8b6b6-58c3-8392-2fc6-1908a314e991@linux.intel.com>
 <YQwlHrJBw79xhTSI@kroah.com>
 <21db8884-5aa1-3971-79ef-f173a0a95bef@linux.intel.com>
 <YQwpa+LAYt7YZ5dh@kroah.com>
 <7d6751b1-c476-51d3-25c6-b65c0e93d23b@linux.intel.com>
 <YQw4AEwIUGe3RpCx@kroah.com>
 <CAPcyv4gV9GK93rgtoHxhshzDGk0ueJn0d9LXYitJ8=wJWzmWHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4gV9GK93rgtoHxhshzDGk0ueJn0d9LXYitJ8=wJWzmWHg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2021 at 12:18:12PM -0700, Dan Williams wrote:
> On Thu, Aug 5, 2021 at 12:12 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Aug 05, 2021 at 11:53:52AM -0700, Kuppuswamy, Sathyanarayanan wrote:
> > > I am not sure how USB and Thunderbolt "authorzied" model works. But I
> > > don't think it prevents built-in driver probes during kernel boot right?
> >
> > Yes it does.
> >
> > Again Intel created this framework well over a decade ago for busses
> > that it deemed that it did not want to "trust" to instantly probe
> > drivers for and made it part of the Wireless USB specification.
> >
> > Then Intel went and added the same framework to Thunderbolt for the same
> > reason.
> >
> > To ignore this work is quite odd, you might want to talk to your
> > coworkers...
> 
> Sometimes we need upstream to connect us wayward drones back into the
> hive mind. Forgive me for not immediately recognizing that the
> existing 'authorized' mechanisms might be repurposed for this use
> case.

Not your fault, I'm more amazed that Andi doesn't remember this, he's
been around longer :)

But the first instinct should not be "let's go add a new feature", but
rather, "how has this problem been solved by others first" because,
really, this is not a new issue at all.  You should not rely on just me
to point out existing kernel features, we do have documentation you
know...

thanks,

greg k-h
