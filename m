Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10BB131E85A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 11:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbhBRJ6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 04:58:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:46932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230423AbhBRIzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 03:55:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0B04364E79;
        Thu, 18 Feb 2021 08:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613638443;
        bh=kxs2KMLR9HvojpvWo9ncMWe2dfU56ncBrp1ZW46YT64=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RbZgxnEBqXHfHusy2mO3E1d9ev2iMj5GeM7XZ+7tUFykRYUWnU9e2X52u8hlxbK8n
         HLLUQaIx7MdZavxbkqebASVRDL6VyBNhV9L3XpWcuVSYrqyez9e11GN86RM6nL1oip
         e8p1vBJIbaIY8jHdEK7J1YJoOfcnXiTWbn+PR5fo=
Date:   Thu, 18 Feb 2021 09:54:00 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Michael Walle <michael@walle.cc>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
Subject: Re: [PATCH] irqdomain: remove debugfs_file from struct irq_domain
Message-ID: <YC4rKOBRuzqfvdHI@kroah.com>
References: <YCvYV53ZdzQSWY6w@kroah.com>
 <20210217195717.13727-1-michael@walle.cc>
 <4e4d0479b935e60a53f75ef534086476@kernel.org>
 <5c527bfb6f3dfe31b5c25f29418306c6@walle.cc>
 <87czwys6s1.wl-maz@kernel.org>
 <YC4X4iLMCK3tNVsF@kroah.com>
 <8b4de9eae773a43b38f42c8ab6d9d23c@walle.cc>
 <YC4nhoc9F59/1drh@kroah.com>
 <b5739c15db3d009556abcf9704984dab@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5739c15db3d009556abcf9704984dab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 08:47:15AM +0000, Marc Zyngier wrote:
> On 2021-02-18 08:38, Greg KH wrote:
> > On Thu, Feb 18, 2021 at 09:27:09AM +0100, Michael Walle wrote:
> > > Am 2021-02-18 08:31, schrieb Greg KH:
> > > > On Wed, Feb 17, 2021 at 09:50:38PM +0000, Marc Zyngier wrote:
> > > > > On Wed, 17 Feb 2021 20:10:50 +0000,
> > > > > Michael Walle <michael@walle.cc> wrote:
> > > > > >
> > > > > > Am 2021-02-17 21:02, schrieb Marc Zyngier:
> > > > > > > On 2021-02-17 19:57, Michael Walle wrote:
> > > > > > >> Hi Greg,
> > > > > > >>
> > > > > > >>> There's no need to keep around a dentry pointer to a simple file that
> > > > > > >>> debugfs itself can look up when we need to remove it from the system.
> > > > > > >>> So simplify the code by deleting the variable and cleaning up the
> > > > > > >>> logic
> > > > > > >>> around the debugfs file.
> > > > > > >>
> > > > > > >> This will generate the following oops on my board (arm64,
> > > > > > >> freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts). In debugfs_lookup()
> > > > > > >> debugfs_mount is NULL.
> > > > > > >
> > > > > > > That's odd. I gave it a go yesterday, and nothing blew up.
> > > > > > > Which makes me wonder whether I had the debug stuff enabled
> > > > > > > the first place...
> > > > > > >
> > > > > > > I've dropped the patch from -next for now until I figure it out
> > > > > > > (probably tomorrow).
> > > > > >
> > > > > > Mh, maybe its my .config, I've attached it. I also noticed that
> > > > > > the board boots just fine in our kernel-ci [1].
> > > > >
> > > > > I reproduced here. I had disabled GENERIC_IRQ_DEBUGFS for obscure
> > > > > reasons, and it caught fire as I re-enabled it.
> > > > >
> > > > > Adding this fixes it for me:
> > > > >
> > > > > diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
> > > > > index 367ff1c35f75..d8a14cf1a7b6 100644
> > > > > --- a/kernel/irq/irqdomain.c
> > > > > +++ b/kernel/irq/irqdomain.c
> > > > > @@ -1904,7 +1904,8 @@ static void debugfs_add_domain_dir(struct
> > > > > irq_domain *d)
> > > > >
> > > > >  static void debugfs_remove_domain_dir(struct irq_domain *d)
> > > > >  {
> > > > > -	debugfs_remove(debugfs_lookup(d->name, domain_dir));
> > > > > +	if (domain_dir)
> > > > > +		debugfs_remove(debugfs_lookup(d->name, domain_dir));
> > > > >  }
> > > > >
> > > > >  void __init irq_domain_debugfs_init(struct dentry *root)
> > > > >
> > > > >
> > > > > Could you please check whether it works for you?
> > > >
> > > > Can you try this debugfs core change instead?  Callers to debugfs should
> > > > not have to do the above type of checking as debugfs should be much more
> > > > robust than that.
> > > >
> > > > thanks,
> > > >
> > > > greg k-h
> > > >
> > > >
> > > > diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
> > > > index 2fcf66473436..5aa798f52b6e 100644
> > > > --- a/fs/debugfs/inode.c
> > > > +++ b/fs/debugfs/inode.c
> > > > @@ -297,7 +297,7 @@ struct dentry *debugfs_lookup(const char *name,
> > > > struct dentry *parent)
> > > >  {
> > > >  	struct dentry *dentry;
> > > >
> > > > -	if (IS_ERR(parent))
> > > > +	if (IS_ERR_OR_NULL(name) || IS_ERR(parent))
> > > >  		return NULL;
> > > >
> > > >  	if (!parent)
> > > 
> > > This doesn't work. name is not NULL when it is called.
> > 
> > Ok, but it is a good check we need to make anyway, I'll add it to a
> > patch series :)
> > 
> > > What has to happen before debugfs_lookup() can be called? Looks like
> > > someone has to initialize the static debugfs_mount, first.
> > 
> > Wow, wait, you are removing a debugfs file _before_ debugfs is even
> > initialized?  Didn't expect that, ok, let me go try this again...
> 
> Yeah, that's a poor man's rename (file being deleted and re-created).

True, but that's not happening here, right?  Some driver is being
initialized and creates a debugfs file, and then decides to unload so it
removes the debugfs file?

Why was it trying to create the file in the first place if it didn't
properly bind to the hardware?

odd...

greg k-h
