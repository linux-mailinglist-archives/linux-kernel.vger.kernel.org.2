Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD3013B2E05
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 13:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbhFXLo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 07:44:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:44302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229445AbhFXLoW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 07:44:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 81A15613B9;
        Thu, 24 Jun 2021 11:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624534923;
        bh=qJmXgN7CIXV0tAhUIHPht8LddBB9hfJphL9CMTVxFb8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VlEpJ2aKToVGA22EHZeTVKlQFXxm7cxvLCefs+NKe/FGOi15cc0+MGRNK1Euf2Oi5
         9MTzqZNJSeeCF5lbTPZmQpImOvopB8MPsbFOg1MfGGy38d6bd3gRIjgM7wN4YRt9t5
         vNzYIzadfI+zb2rnb+Nni0mnqO9bN32nKDskPkEw=
Date:   Thu, 24 Jun 2021 13:42:00 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Hans-Gert Dahmen <hans-gert.dahmen@immu.ne>
Cc:     David Laight <David.Laight@aculab.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "philipp.deppenwiese@immu.ne" <philipp.deppenwiese@immu.ne>
Subject: Re: [PATCH] firmware: export x86_64 platform flash bios region via
 sysfs
Message-ID: <YNRviIrdvrjAMCXG@kroah.com>
References: <20210622142334.14883-1-hans-gert.dahmen@immu.ne>
 <5ee9e467bfbf49d29cb54679d2dce1c3@AcuMS.aculab.com>
 <d61176a0-67cf-268f-8c31-8de8739753c3@immu.ne>
 <YNMrpzZgH4KECykk@kroah.com>
 <7f076743-3dd6-d397-d3cc-8c31e080695c@immu.ne>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f076743-3dd6-d397-d3cc-8c31e080695c@immu.ne>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 01:20:28PM +0200, Hans-Gert Dahmen wrote:
> 
> On 23.06.21 14:40, gregkh@linuxfoundation.org wrote:
> > > On Wed, Jun 23, 2021 at 02:17:54PM +0200, Hans-Gert Dahmen wrote:
> > > Hi,
> > > Yes. The window is part of the DMI interface and the south bridge or PCH
> > > converts the bus cycles to SPI reads. It is because this region contains the
> > > reset vector address of your CPU and the very first instruction it executes
> > > after a reset when the internal setup is done will actually be loaded from
> > > the serial SPI bus. It is AFAIK part of AMD's original 64-bit specification.
> > The point is that you will never be able to do this for all devices.
> > You should ONLY be allowed to have this module bind to the hardware that
> > you KNOW it will work with.
> > 
> > So please work off of a DMI table, or some such hardware description,
> > instead of just blindly enabling it for all systems.
> 
> I was referring to the DMI/QPI/PCI interface that connects the ICH/PCH/south
> bridge to the CPU. I have gone through all datasheets of intel ICH and PCH
> and they state that the address range from 0xff000000 through 0xffffffff is
> a fixed mapping that cannot be changed (no BAR) except for the original ICH
> (dating back to 1999) where the window is only 8MB. The original ICH is for
> 32-bit systems only so all 64-bit Intel systems that exist have this
> feature. I have talked to somebody who works with future Intel hardware and
> the person indicated that it is not likely to change.
> 
> This is why I made the module depend on X86_64. I still have to do the same
> complete research for AMD systems which is a little harder to do, so I am
> proposing to check if the root complex has Intel's vendor ID and only load
> the module on 64-bit Intel systems until I can confirm the same behavior for
> all 64-bit AMD systems. Then I could check if the root complex is Intel or
> AMD. Would that suffice as "some such hardware description"?

That would help, yes.  Especially given the other types of Intel-like
cpus we are seeing in the wild these days (not all the world is Intel
and AMD...)

But what is this really going to be used for?  What userspace tools need
this type of direct access to do something useful?

thanks,

greg k-h
