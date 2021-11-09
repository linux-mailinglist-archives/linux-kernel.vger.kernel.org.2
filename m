Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B96344AE8F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 14:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235104AbhKINRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 08:17:01 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:58056 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233080AbhKINQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 08:16:59 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C7DF01FD58;
        Tue,  9 Nov 2021 13:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1636463652; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ujGFlbPpbHzmCHNXTHBgWm35p4y8oCfqjB1ijoyffoA=;
        b=Xenti10FFsSFs6zqBFOCew0/m/2DcXuuyHtzq/scU9JzF5yveJfZqpOwijSI4AcZXQNLxw
        qmXo1jKA/Uni80TVLBdZroavENKodZJuVAEuSqJtbb1E4iGAEq8MsxdK28Opjy0tyzMfNj
        +NHtzmIPqfSMGHepTZf/N14Ew4QYfAw=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id ACD90A3B83;
        Tue,  9 Nov 2021 13:14:12 +0000 (UTC)
Date:   Tue, 9 Nov 2021 14:14:09 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Joe Lawrence <joe.lawrence@redhat.com>
Subject: Re: [PATCH 2/2] kobject: wait until kobject is cleaned up before
 freeing module
Message-ID: <YYp0IffopQMiOsHN@alley>
References: <20211105063710.4092936-1-ming.lei@redhat.com>
 <20211105063710.4092936-3-ming.lei@redhat.com>
 <YYldwVcrEqShHyq8@alley>
 <YYnWO1Jug3xu+NB+@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYnWO1Jug3xu+NB+@T590>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-11-09 10:00:27, Ming Lei wrote:
> On Mon, Nov 08, 2021 at 06:26:25PM +0100, Petr Mladek wrote:
> > On Fri 2021-11-05 14:37:10, Ming Lei wrote:
> > > kobject_put() may become asynchronously because of
> > > CONFIG_DEBUG_KOBJECT_RELEASE, so once kobject_put() returns, the caller may
> > > expect the kobject is released after the last refcnt is dropped, however
> > > CONFIG_DEBUG_KOBJECT_RELEASE just schedules one delayed work function
> > > for cleaning up the kobject. Inside the cleanup handler, kobj->ktype and
> > > kobj->ktype->release are required.
> > > 
> > > It is supposed that no activity is on kobject itself any more since
> > > module_exit() is started, so it is reasonable for the kobject user or
> > > driver to expect that kobject can be really released in the last run of
> > > kobject_put() in module_exit() code path. Otherwise, it can be thought as
> > > one driver's bug since the module is going away.
> > 
> > Honestly, this looks a bit fragile. What if there is still another
> > reference from some reason. IMHO, it is easy to do it wrong.
> > The kobject stuff is super-tricky.
> > 
> > Yes, there is the argument that it is a drivers bug when it does not
> > work.
> 
> That is another 'issue'(even not sure if there is really), and it isn't covered
> in this patchset, which focuses on fixing CONFIG_DEBUG_KOBJECT_RELEASE, so
> please do not mix the two here.

Yes, it is another issue but the relation is very important.

My understanding is that this patch prevents problems caused by
the delayed work. The kobject is added into kobj_cleanup_list
only when the delayed work is scheduled. The patch has no effect
if the delayed work is not used.

From my POV, this patch kind of removes the effect of the delayed
work. My point is:

Does it still make sense to use the delayed work in the first place?
Will the delayed work still help to catch some problems?

My point is that if this makes CONFIG_DEBUG_KOBJECT_RELEASE useless
than we should remove CONFIG_DEBUG_KOBJECT_RELEASE instead.
But then we need something else to prevent bugs that this
functionality helped to debug.


> The usual module use model is that module can't be used if someone is
> use it. After module_exit() is started, no one should & can 'use' the module
> any more, that is done by module's refcnt.

This statement is suspicious. IMHO, no one should 'use' the module
after module_exit() _finishes_.

It should be perfectly fine to use the module after module_exit()
_starts_ as long as module_exit() callback could wait until
the existing users stop using the module.


> So far the driver core subsystem doesn't use module owner info, so no
> need to grab module refcnt in case that kobject is used. And that
> actually doesn't work here, given we can't hold the module refcnt
> during the kobject's lifetime, otherwise the module won't be unloaded
> at all. Sort of chicken and egg problem given kobject is often released
> during module_exit().
>
> But driver core does provide kobject_del() interface to wait until
> all show()/store() are done.
>
> So once the driver said now no one uses that device and the module
> can be unloaded, then kobject_del() is done inside module_exit(),
> who can hold kobject's extra reference? If there is, the caller should
> have grabbed the module refcnt to prevent module from being unloaded.
> 
> We usually think it is driver bug, see one fixed recently:
> 
> https://lore.kernel.org/linux-scsi/20211008050118.1440686-1-ming.lei@redhat.com/

Honestly, I do not understand how the extra module_get()/module_put()
could prevent the race caused by delayed kobject clean up.

scsi_device_dev_release() uses try_module_get(). But it always calls
scsi_device_dev_release_usercontext(). Why is it safe when
try_module_get() failed?

I guess that the patch reduced the size of the race window but
a race might still be there.

Anyway, it is pity that the commit message does not include the
backtrace of the page fault. Or that it does not better describe
the race that is fixed there.


> > But I wonder if we could create API that might be used by
> > drivers and report the actuall bug. Something like:
> >
> > int kobject_remove_sync(struct kobject *kobj)
>
> Not sure if this interface is useful:
> 
> 1) who need this interface?
> - It is basically not possible to audit all drivers for the conversion, and not
> necessary too.

It might be useful for people that want to create interface and
drivers that are safe to unload.


> 2) this may break some common open()/release model:
> 
> - user open() one device, here module refcnt is hold, and device/kobject refcnt
>   is hold too
> 
> - device needs to be deleted by kobject_del() via sysfs or ioctl or
>   others, if kobject_remove_sync() is used, it will complain, but it
>   is just false warning. There are lots of such examples.

It might be solved the same way as sysfs_break_active_protection().
I mean that the API might be aware of that it is removing itself.


> 3) this way may break some uses if spin_lock() is held before calling
> kobject_put().

This is not specific to the new API. The same problem is also with kobject_del().


> 4) not usable in deleting kobject itself, or break the deleting me interface
> simply.

It will be useful when the deleting is offloaded to a workqueue.
I still consider is less hacky than using sysfs_break_active_protection().


> 5) actually only one implicit rule is here: kobject needs to be released
> before module exit is done if the kobject is created by this module

It the kobject is created by a module, it should be also destroyed
by the module. And this is where some remove_kobject() API might
be useful.


> 6) much less flexible than the usual two stage removal

We still could create a two stage API. The point is that it might be
useful to have an API that will wait until the kobject is really
released.

Best Regards,
Petr
