Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5DEB3E0FC9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 09:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239144AbhHEIAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 04:00:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:34266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231377AbhHEIAC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 04:00:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6CDD76044F;
        Thu,  5 Aug 2021 07:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628150389;
        bh=VQPRznZKq+7/Y3xFggDbn6ktS/w4o5Cb+eH7BbGxrd8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O9H/9+JgombTsydBEcmzdDXyDw/rn6nu5MBVtZ/uJNpBT/JYFnBisZoTHptUkOgFh
         zMcyxW6TGCf4JIXbpooxPBou4SQ6MN+o+1pjvwyrBJbtxy7584rJv+wxGfs+j621JR
         Rt6QUUtudd0bFHig25Rt+x2T925xgAvx6rZAtwJA=
Date:   Thu, 5 Aug 2021 09:59:45 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v1] driver: base: Add driver filter support
Message-ID: <YQuaceNDNdBqidyQ@kroah.com>
References: <20210804174322.2898409-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YQrqhYEL64CSLRTy@kroah.com>
 <CAPcyv4iEEDCz5719d0vNi=zi=6oN5vctcVfY5P=WQ9j_Zpz6eA@mail.gmail.com>
 <YQsBfAVPomaC97Rm@casper.infradead.org>
 <CAPcyv4gSsL5hk=CSk=9duqCN3VDS_T2LaYRL+_zK9VOkO8NB+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4gSsL5hk=CSk=9duqCN3VDS_T2LaYRL+_zK9VOkO8NB+A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2021 at 02:28:32PM -0700, Dan Williams wrote:
> On Wed, Aug 4, 2021 at 2:07 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Wed, Aug 04, 2021 at 01:11:27PM -0700, Dan Williams wrote:
> > > On Wed, Aug 4, 2021 at 12:29 PM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > > Why not just make distros that want to support this type of platform,
> > > > also provide these tiny kernel images?  Why are you pushing this work on
> > > > the kernel community instead?
> > >
> > > In fact, these questions are where I started when first encountering
> > > this proposal. Andi has addressed the single kernel image constraint,
> > > but I want to pick up on this "pushing work to the kernel community"
> > > contention. The small list of vetted drivers that a TDX guest needs
> > > will be built-in and maintained in the kernel by the protected guest
> > > developer community, so no "pushing work" there. However, given that
> > > any driver disable mechanism needs to touch the driver core I
> > > advocated to go ahead and make this a general purpose capability to
> > > pick up where this [1] conversation left off. I.e. a general facility
> > > for the corner cases that modprobe and kernel config policy can not
> > > reach. Corner cases like VMM attacking the VM, or broken hardware with
> > > a built-in driver that can't be unbound after the fact.
> >
> > I don't understand how this defends against a hypervisor attacking a
> > guest.  If the hardware exists, the hypervisor can access it, regardless
> > of whether the driver is default-disabled by configuration.
> 
> The "hardware" in this case is virtual devices presented by the VMM to
> the VM. So if a driver misbehaves in a useful way for an attacker to
> exploit, they can stimulate that behavior with a custom crafted
> virtual device, and that driver will autoload unaware of the threat
> without this filter for vetted drivers.

As I just said elsewhere in this thread, we have support for this today
for thunderbolt and USB, please just expand that to all bus types and
that should be fine.

thanks,

greg k-h
