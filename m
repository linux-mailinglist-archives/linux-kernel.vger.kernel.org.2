Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B61A44BD92
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 10:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbhKJJII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 04:08:08 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:56474 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbhKJJID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 04:08:03 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 41178218A4;
        Wed, 10 Nov 2021 09:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1636535113; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y5Ckp7bAlAHqmEvV5Hz921lWUV1q9resWcR3XrOvBvA=;
        b=e+v4KhqIqJ2V3we/ihsoQCar99AqQxiatlmuKoLYfqUhMO0+ayna1RegeLG6uJgVb6vuy/
        oQNJsitOH0e1EM4y9oaUXJsBSxGG2GrWF5VBIotShKV/HJB4QKkFqIlr43kYPC/F3+sWRj
        0+u6Bt9h1YCdWHUgo3priy+9tt2LZC0=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 236F9A3B83;
        Wed, 10 Nov 2021 09:05:13 +0000 (UTC)
Date:   Wed, 10 Nov 2021 10:05:12 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Joe Lawrence <joe.lawrence@redhat.com>
Subject: Re: [PATCH 2/2] kobject: wait until kobject is cleaned up before
 freeing module
Message-ID: <YYuLSGBfgBJpaBbH@alley>
References: <20211105063710.4092936-1-ming.lei@redhat.com>
 <20211105063710.4092936-3-ming.lei@redhat.com>
 <YYldwVcrEqShHyq8@alley>
 <YYnWO1Jug3xu+NB+@T590>
 <YYp0IffopQMiOsHN@alley>
 <YYseW96UYRJ/eE5p@T590>
 <YYtuqF2Pj/D9iEBa@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYtuqF2Pj/D9iEBa@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2021-11-10 08:03:04, Greg Kroah-Hartman wrote:
> On Wed, Nov 10, 2021 at 09:20:27AM +0800, Ming Lei wrote:
> > On Tue, Nov 09, 2021 at 02:14:09PM +0100, Petr Mladek wrote:
> > > On Tue 2021-11-09 10:00:27, Ming Lei wrote:
> > > > On Mon, Nov 08, 2021 at 06:26:25PM +0100, Petr Mladek wrote:
> > > > > On Fri 2021-11-05 14:37:10, Ming Lei wrote:
> > > > > > kobject_put() may become asynchronously because of
> > > > > > CONFIG_DEBUG_KOBJECT_RELEASE, so once kobject_put() returns, the caller may
> > > > > > expect the kobject is released after the last refcnt is dropped, however
> > > > > > CONFIG_DEBUG_KOBJECT_RELEASE just schedules one delayed work function
> > > > > > for cleaning up the kobject. Inside the cleanup handler, kobj->ktype and
> > > > > > kobj->ktype->release are required.
> > > > > > 
> > > > > > It is supposed that no activity is on kobject itself any more since
> > > > > > module_exit() is started, so it is reasonable for the kobject user or
> > > > > > driver to expect that kobject can be really released in the last run of
> > > > > > kobject_put() in module_exit() code path. Otherwise, it can be thought as
> > > > > > one driver's bug since the module is going away.
> > > > > 
> > > > > Honestly, this looks a bit fragile. What if there is still another
> > > > > reference from some reason. IMHO, it is easy to do it wrong.
> > > > > The kobject stuff is super-tricky.
> > > > > 
> > > > > Yes, there is the argument that it is a drivers bug when it does not
> > > > > work.
> > > > 
> > > > That is another 'issue'(even not sure if there is really), and it isn't covered
> > > > in this patchset, which focuses on fixing CONFIG_DEBUG_KOBJECT_RELEASE, so
> > > > please do not mix the two here.
> > > 
> > > Yes, it is another issue but the relation is very important.
> > > 
> > > My understanding is that this patch prevents problems caused by
> > > the delayed work. The kobject is added into kobj_cleanup_list
> > > only when the delayed work is scheduled. The patch has no effect
> > > if the delayed work is not used.
> > > 
> > > From my POV, this patch kind of removes the effect of the delayed
> > > work. My point is:
> > > 
> > > Does it still make sense to use the delayed work in the first place?
> > > Will the delayed work still help to catch some problems?
> > 
> > That depends on the user of CONFIG_DEBUG_KOBJECT_RELEASE, if users
> > thought it is useless, I think it is fine to remove it.
> > 
> > Greg, any idea about if CONFIG_DEBUG_KOBJECT_RELEASE is useful now?
> 
> Yes it is, it finds driver bugs where they do things wrong.

Please, do you have any idea what particular wrong things might happen?

IMHO, one bug might be that the driver module might be removed when
there are still users, some reference still exists. This patch
causes that CONFIG_DEBUG_KOBJECT_RELEASE will not longer help
to catch this kind of problems.

Is there any other common bug type that might be discovered by
the delayed release?

I just want to be sure that this patch does not make
CONFIG_DEBUG_KOBJECT_RELEASE useless.

Best Regards,
Petr
