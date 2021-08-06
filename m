Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF78C3E22C5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 07:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242978AbhHFFIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 01:08:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:46180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229576AbhHFFIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 01:08:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C816F60249;
        Fri,  6 Aug 2021 05:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628226477;
        bh=+KwAA8WRcGQb5hPZBRI66maPX62SaoRv3MQjPWzRMVc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pNG8f3QGBkU1vjg2AjVVj63VqWnglmER/mnhUtQAZ8Iqqq6aZ+mux3K2+bQXi6XER
         oUMmicZPGD7FnCrTuo4OjYcfhEIetHHjFMJfvDjgUqOjN2tujjlUsFO2sm+aRf+qvP
         +TrHWTqeVk9Eg46o8kj/nsXCJjjgOgmwq+rxcjN4=
Date:   Fri, 6 Aug 2021 07:07:54 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v1] driver: base: Add driver filter support
Message-ID: <YQzDqm6FOezM6Rnu@kroah.com>
References: <YQrqhYEL64CSLRTy@kroah.com>
 <f2b1d564-8174-f8e9-9fee-12e938c6d846@linux.intel.com>
 <YQuYCePPZEmVbkfc@kroah.com>
 <YQuZdVuaGG/Cr62y@kroah.com>
 <YQuaJ78y8j1UmBoz@kroah.com>
 <fdf8b6b6-58c3-8392-2fc6-1908a314e991@linux.intel.com>
 <YQwlHrJBw79xhTSI@kroah.com>
 <21db8884-5aa1-3971-79ef-f173a0a95bef@linux.intel.com>
 <YQwpa+LAYt7YZ5dh@kroah.com>
 <1e0967ee-c41e-fd5d-f553-e4d7ab88838c@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e0967ee-c41e-fd5d-f553-e4d7ab88838c@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2021 at 11:44:47AM -0700, Andi Kleen wrote:
> 
> On 8/5/2021 11:09 AM, Greg Kroah-Hartman wrote:
> > On Thu, Aug 05, 2021 at 10:58:46AM -0700, Andi Kleen wrote:
> > > On 8/5/2021 10:51 AM, Greg Kroah-Hartman wrote:
> > > > It's controlled by whatever you want to use in userspace.  usbguard has
> > > > been handling this logic in userspace for over a decade now just fine.
> > > 
> > > So how does that work with builtin USB drivers? Do you delay the USB binding
> > > until usbguard starts up?
> > Yes.
> 
> That won't work for confidential guests, e.g. we need a virtio driver for
> the console and some other things.
> 
> 
> > 
> > > > > This doesn't help us handle builtin drivers that initialize before user
> > > > > space is up.
> > > > Then have the default setting for your bus be "unauthorized" like we
> > > > allow for some busses today.
> > > We need some early boot drivers, just not all of them. For example in your
> > > scheme we would need to reject all early platform drivers, which would break
> > > booting. Or allow all early platform drivers, but then we exactly get into
> > > the problem that there are far too many of them to properly harden.
> > Define "harden" please.  Why not just allow all platform drivers, they
> > should all be trusted.  If not, well, you have bigger problems...
> 
> Trusted here means someone audited them and also fuzzed them. That's all a
> lot of work and also needs to be maintained forever so we're trying to do
> only a minimum set. There are actually quite a few platform drivers, it's
> difficult to audit them all.

Note, this model is wrong and backwards and will not work out at all in
the end.

But given that this is coming from a hardware company, it makes sense.
You are coming from the model of "the hardware is trusted, but the code
is untrusted".  That is the exact opposite of what we have been working
with for the past 5+ years now.

Look at all of the work that has happened in just USB drivers over the
recent years thanks to fuzzing efforts.  None of this was done because
we did not trust the kernel code, it was because we had to now not trust
the hardware to actually do the right thing.  So we have had to "harden"
the kernel side to deal with untrusted hardware.

People are now looking at doing the same for PCI devices, but that's a
huge effort that no one has started to take seriously.

Same thing for any other hardware "bug", that is software having to fix
hardware errors as it is the thing that is incorrect, not the software.
Spectre/meltdown is a huge example of that, but there are many more.

The model the kernel has right now for "authorized" devices is that it
is up to some entity to determine if the _device_ is trusted, not if the
_driver_ is trusted.

By virtue of you all saying that you want to use a generic kernel image
from a vendor, you are implying that you have to trust that software as
you have no control over that kernel image.  What you need to validate
is "can I trust this device to be controlled by the kernel".

So work on providing "trusted" hardware/device signals to the kernel
please.  That is the only way this is going to work.

And yes, auditing drivers is wonderful and grand please do that and set
up automated testing for it along with good static analysis and all of
that.  But that is NOT going to provide you with what you want here, as
the most "perfictly audited" body of code will fall apart when
confronted with "hardware" that does not work as documented/planned.

That's the fatal flaw in the formal methods camp, they have to trust the
model of the running system in order to be able to then validate the
software.  But when the model turns out to be wrong (again, spectre is
an example of this), it turns out that the software ends up not working
"correctly".

So go work on providing some sort of authentication of hardware to
attest that it really is what it says it is, in order to allow a kernel
to be able to determine if it should start talking to it or not.

good luck!

greg k-h
