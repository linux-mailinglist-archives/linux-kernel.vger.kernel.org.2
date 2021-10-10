Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14F73428171
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 15:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbhJJNKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 09:10:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:59528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232641AbhJJNKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 09:10:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8F96160F92;
        Sun, 10 Oct 2021 13:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633871314;
        bh=iqvvjlOk5xsKYHmDmLGoG4VyTjNn6VrtiD/EWCBT6lE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lh7lNX076Vt3B1BCUVjE8z9bsOLLeoY3RWGlMhv9RIZ4u+y43YluhdXr2xT6ng+4B
         gAfw2/df4vF3A+E3/ZUWiKVkaENZFun54dj5kwcXhgcThgdowckjUXVLZVqYnwAe6C
         F4Pkpu6VFnvfZrg6dR8Af6vmUtbcUoOqrdfP7CJI=
Date:   Sun, 10 Oct 2021 15:08:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Petr Nechaev <petr.nechaev@cogentembedded.com>
Subject: Re: [PATCH v3] usb: gadget: storage: add support for media larger
 than 2T
Message-ID: <YWLlzyJvcI20Pkki@kroah.com>
References: <YUnsSxUERYj/oXTO@kroah.com>
 <20210921145901.11952-1-nikita.yoush@cogentembedded.com>
 <YVwyDsuIT9lZWi2v@kroah.com>
 <20211005141958.GA621017@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211005141958.GA621017@rowland.harvard.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2021 at 10:19:58AM -0400, Alan Stern wrote:
> On Tue, Oct 05, 2021 at 01:07:58PM +0200, Greg Kroah-Hartman wrote:
> > On Tue, Sep 21, 2021 at 05:59:02PM +0300, Nikita Yushchenko wrote:
> > > This adds support for READ_CAPACITY(16), READ(16) and WRITE(16)
> > > commands, and fixes READ_CAPACITY command to return 0xffffffff if
> > > media size does not fit in 32 bits.
> > > 
> > > This makes f_mass_storage to export a 16T disk array correctly.
> > > 
> > > Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> > > ---
> > > v3:
> > > - added this changelog
> > > 
> > > v2:
> > > - fixed call to check_command() for READ_CAPACITY(16)
> > > - fixed alphabetical order of commands in switch statement
> > > - renamed variable, added comments, and fixed formatting, per advices by
> > >   Alan Stern <stern@rowland.harvard.edu>
> > 
> > Felipe and Alan, any objections to this change?
> 
> No objections.  In fact, I already sent my Acked-by for v2 of the 
> patch (which is the same as v3):
> 
> https://marc.info/?l=linux-usb&m=163165151506682&w=2

Thanks, I had missed that.

And ick, marc.info, you might want to look at using lore.kernel.org in
the future :)

greg k-h
