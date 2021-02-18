Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7052531E8E0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 12:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbhBRKzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 05:55:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:50126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232193AbhBRJis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 04:38:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CB0FA64E15;
        Thu, 18 Feb 2021 09:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613641084;
        bh=n9k7hg+19cLfjrZwHG3nCnKQnBVS0A9C53st/mPIP0Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZvfqqPHXF4Kii3xoSRztyxs4GCnKVOqH7zb2TjZqA4T1E35eXlY4xIiLi9ld6yTe6
         U3W77V5nKpARBeww2mTPB3EeUBm8Dzq9hj4Ygm+Hrd3IZJer3cwnq4Cr+k8Pg5V6h/
         abVcG3FGtUtu/hsTLHCA3Ya5FeuPEH0znHAMrSEM=
Date:   Thu, 18 Feb 2021 10:38:01 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Michael Walle <michael@walle.cc>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
Subject: Re: [PATCH] irqdomain: remove debugfs_file from struct irq_domain
Message-ID: <YC41eWXKjE77zIBo@kroah.com>
References: <20210217195717.13727-1-michael@walle.cc>
 <4e4d0479b935e60a53f75ef534086476@kernel.org>
 <5c527bfb6f3dfe31b5c25f29418306c6@walle.cc>
 <87czwys6s1.wl-maz@kernel.org>
 <YC4X4iLMCK3tNVsF@kroah.com>
 <8b4de9eae773a43b38f42c8ab6d9d23c@walle.cc>
 <YC4nhoc9F59/1drh@kroah.com>
 <b5739c15db3d009556abcf9704984dab@kernel.org>
 <YC4rKOBRuzqfvdHI@kroah.com>
 <87eehdpx05.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87eehdpx05.wl-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 09:04:42AM +0000, Marc Zyngier wrote:
> On Thu, 18 Feb 2021 08:54:00 +0000,
> Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> [...]
> 
> > > > Wow, wait, you are removing a debugfs file _before_ debugfs is even
> > > > initialized?  Didn't expect that, ok, let me go try this again...
> > > 
> > > Yeah, that's a poor man's rename (file being deleted and re-created).
> > 
> > True, but that's not happening here, right?  Some driver is being
> > initialized and creates a debugfs file, and then decides to unload so it
> > removes the debugfs file?
> 
> No, that's not what is happening.
> 
> The irqchip driver starts, creates an irqdomain. File gets created, at
> least in theory (it fails because debugfs isn't ready, but that's not
> the issue).
> 
> It then changes an attribute to the domain (the so-called bus_token),
> which gets reflected in the domain name to avoid aliasing.
> Delete/create follows.
> 
> > Why was it trying to create the file in the first place if it didn't
> > properly bind to the hardware?
> 
> See above. We encode properties of the domain in the filename, and
> reflect the change of these properties as they happen.

Ah, ok, you really are doing delete/re-create.  Crazy.  And amazing it
was working previously without the checks I just added...

Funny that you all never were even noticing that the debugfs files are
not present in the system because they are tryign to be created before
debugfs is present?  Is that an issue or has no one complained?

Anyway, I'll go turn this into a real patch and get it into 5.12-rc1 so
that the irqdomain patch I sent you will not blow anything up.  Feel
free to also queue it up in your tree if you want to as well.

thanks,

greg k-h
