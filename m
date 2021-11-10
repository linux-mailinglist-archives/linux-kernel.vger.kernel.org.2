Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 954F144BBEB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 08:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbhKJHF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 02:05:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:55092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229558AbhKJHF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 02:05:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 541806117A;
        Wed, 10 Nov 2021 07:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636527789;
        bh=mHhCBH/u9iDuf3oprEAHP5N9DJ2RYOny0X9ESwacX0U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gDlV2/paJcwTtxeLnkacv4mhy1r/qhW38rl36ihcXJ8+JHNc9eIyIVIMpv+5gSAGp
         qX0nYDprgHUUjhpKoGE7qu/ED3jyLdSB/wsfmQyU0BzLFSycxstl3eO5tqR/i+DZMk
         mW4VXRl6W265otA2tGfXotLXb7g5mTEiWZDuItM4=
Date:   Wed, 10 Nov 2021 08:03:04 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Joe Lawrence <joe.lawrence@redhat.com>
Subject: Re: [PATCH 2/2] kobject: wait until kobject is cleaned up before
 freeing module
Message-ID: <YYtuqF2Pj/D9iEBa@kroah.com>
References: <20211105063710.4092936-1-ming.lei@redhat.com>
 <20211105063710.4092936-3-ming.lei@redhat.com>
 <YYldwVcrEqShHyq8@alley>
 <YYnWO1Jug3xu+NB+@T590>
 <YYp0IffopQMiOsHN@alley>
 <YYseW96UYRJ/eE5p@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYseW96UYRJ/eE5p@T590>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 09:20:27AM +0800, Ming Lei wrote:
> On Tue, Nov 09, 2021 at 02:14:09PM +0100, Petr Mladek wrote:
> > On Tue 2021-11-09 10:00:27, Ming Lei wrote:
> > > On Mon, Nov 08, 2021 at 06:26:25PM +0100, Petr Mladek wrote:
> > > > On Fri 2021-11-05 14:37:10, Ming Lei wrote:
> > > > > kobject_put() may become asynchronously because of
> > > > > CONFIG_DEBUG_KOBJECT_RELEASE, so once kobject_put() returns, the caller may
> > > > > expect the kobject is released after the last refcnt is dropped, however
> > > > > CONFIG_DEBUG_KOBJECT_RELEASE just schedules one delayed work function
> > > > > for cleaning up the kobject. Inside the cleanup handler, kobj->ktype and
> > > > > kobj->ktype->release are required.
> > > > > 
> > > > > It is supposed that no activity is on kobject itself any more since
> > > > > module_exit() is started, so it is reasonable for the kobject user or
> > > > > driver to expect that kobject can be really released in the last run of
> > > > > kobject_put() in module_exit() code path. Otherwise, it can be thought as
> > > > > one driver's bug since the module is going away.
> > > > 
> > > > Honestly, this looks a bit fragile. What if there is still another
> > > > reference from some reason. IMHO, it is easy to do it wrong.
> > > > The kobject stuff is super-tricky.
> > > > 
> > > > Yes, there is the argument that it is a drivers bug when it does not
> > > > work.
> > > 
> > > That is another 'issue'(even not sure if there is really), and it isn't covered
> > > in this patchset, which focuses on fixing CONFIG_DEBUG_KOBJECT_RELEASE, so
> > > please do not mix the two here.
> > 
> > Yes, it is another issue but the relation is very important.
> > 
> > My understanding is that this patch prevents problems caused by
> > the delayed work. The kobject is added into kobj_cleanup_list
> > only when the delayed work is scheduled. The patch has no effect
> > if the delayed work is not used.
> > 
> > From my POV, this patch kind of removes the effect of the delayed
> > work. My point is:
> > 
> > Does it still make sense to use the delayed work in the first place?
> > Will the delayed work still help to catch some problems?
> 
> That depends on the user of CONFIG_DEBUG_KOBJECT_RELEASE, if users
> thought it is useless, I think it is fine to remove it.
> 
> Greg, any idea about if CONFIG_DEBUG_KOBJECT_RELEASE is useful now?

Yes it is, it finds driver bugs where they do things wrong.

I've been ignoring this thread until after 5.16-rc1 is out, sorry.

greg k-h
