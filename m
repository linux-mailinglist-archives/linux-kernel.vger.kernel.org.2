Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1A2531E756
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 09:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbhBRIOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 03:14:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:36808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230448AbhBRHSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 02:18:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 711F564E68;
        Thu, 18 Feb 2021 07:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613632605;
        bh=GL3AuP2wwBtnPHjwSoApthNRuK2aF2Vjh4jocfq7VWg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LlJMZaQ7RPig9+njqG/VNdH4to9gbC2S6pGhIzbR0Thpp9JVXiEKNyqEnk4fczFP8
         TLF0MiWFCxHCZylnmY29dGOet1i37BFhi602fGw+XwdyuuUh2pwKC7nUXCoJfOdx8U
         KJCR1CLR9/0tMmDLzyT8bhnhMf+zZkHkvkDgC57o=
Date:   Thu, 18 Feb 2021 08:16:41 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Michael Walle <michael@walle.cc>
Cc:     Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
Subject: Re: [PATCH] irqdomain: remove debugfs_file from struct irq_domain
Message-ID: <YC4UWdsDA00SOoY/@kroah.com>
References: <YCvYV53ZdzQSWY6w@kroah.com>
 <20210217195717.13727-1-michael@walle.cc>
 <4e4d0479b935e60a53f75ef534086476@kernel.org>
 <5c527bfb6f3dfe31b5c25f29418306c6@walle.cc>
 <87czwys6s1.wl-maz@kernel.org>
 <9da32aa719280d2056a84b784d43976e@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9da32aa719280d2056a84b784d43976e@walle.cc>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 17, 2021 at 11:21:22PM +0100, Michael Walle wrote:
> Am 2021-02-17 22:50, schrieb Marc Zyngier:
> > On Wed, 17 Feb 2021 20:10:50 +0000,
> > Michael Walle <michael@walle.cc> wrote:
> > > 
> > > Am 2021-02-17 21:02, schrieb Marc Zyngier:
> > > > On 2021-02-17 19:57, Michael Walle wrote:
> > > >> Hi Greg,
> > > >>
> > > >>> There's no need to keep around a dentry pointer to a simple file that
> > > >>> debugfs itself can look up when we need to remove it from the system.
> > > >>> So simplify the code by deleting the variable and cleaning up the
> > > >>> logic
> > > >>> around the debugfs file.
> > > >>
> > > >> This will generate the following oops on my board (arm64,
> > > >> freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts). In debugfs_lookup()
> > > >> debugfs_mount is NULL.
> > > >
> > > > That's odd. I gave it a go yesterday, and nothing blew up.
> > > > Which makes me wonder whether I had the debug stuff enabled
> > > > the first place...
> > > >
> > > > I've dropped the patch from -next for now until I figure it out
> > > > (probably tomorrow).
> > > 
> > > Mh, maybe its my .config, I've attached it. I also noticed that
> > > the board boots just fine in our kernel-ci [1].
> > 
> > I reproduced here. I had disabled GENERIC_IRQ_DEBUGFS for obscure
> > reasons, and it caught fire as I re-enabled it.
> > 
> > Adding this fixes it for me:
> > 
> > diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
> > index 367ff1c35f75..d8a14cf1a7b6 100644
> > --- a/kernel/irq/irqdomain.c
> > +++ b/kernel/irq/irqdomain.c
> > @@ -1904,7 +1904,8 @@ static void debugfs_add_domain_dir(struct
> > irq_domain *d)
> > 
> >  static void debugfs_remove_domain_dir(struct irq_domain *d)
> >  {
> > -	debugfs_remove(debugfs_lookup(d->name, domain_dir));
> > +	if (domain_dir)
> > +		debugfs_remove(debugfs_lookup(d->name, domain_dir));
> >  }
> > 
> >  void __init irq_domain_debugfs_init(struct dentry *root)
> > 
> > 
> > Could you please check whether it works for you?
> 
> Works for me, too. Thanks.

Hm, odd, that shouldn't matter, the debugfs core should be able to
easily handle stuff like this, let me look into that before you apply
this...

thnaks,

greg k-h
