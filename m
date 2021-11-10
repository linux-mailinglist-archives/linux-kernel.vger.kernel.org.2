Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBCA44B9EB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 02:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbhKJBX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 20:23:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29926 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229445AbhKJBXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 20:23:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636507268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aZak0cu4xlWEqrjFV80M6GUtXoJNhv8adOfgZNsENsc=;
        b=Cvcy18NWOwZ8SPy/VZxuutvlJdAd0/xKgFz9YUea2ESJYD13Rqdr3soVPVN2U8HHRCAIqy
        Wn6SOocj0SNJMKaZtD2AKIvwYdLYfpUJ5KqhFFw2T/NxGG6liSpqveMuGSPrvcDJhbX3rT
        5snTGMIJlnQzr+m1UCzkPc/58rapUDw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-OR7UM8CuPYanQCa0aoXXtA-1; Tue, 09 Nov 2021 20:21:05 -0500
X-MC-Unique: OR7UM8CuPYanQCa0aoXXtA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 24FFA10144F0;
        Wed, 10 Nov 2021 01:21:04 +0000 (UTC)
Received: from T590 (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6CD1C5DA61;
        Wed, 10 Nov 2021 01:20:34 +0000 (UTC)
Date:   Wed, 10 Nov 2021 09:20:27 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Joe Lawrence <joe.lawrence@redhat.com>, ming.lei@redhat.com
Subject: Re: [PATCH 2/2] kobject: wait until kobject is cleaned up before
 freeing module
Message-ID: <YYseW96UYRJ/eE5p@T590>
References: <20211105063710.4092936-1-ming.lei@redhat.com>
 <20211105063710.4092936-3-ming.lei@redhat.com>
 <YYldwVcrEqShHyq8@alley>
 <YYnWO1Jug3xu+NB+@T590>
 <YYp0IffopQMiOsHN@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYp0IffopQMiOsHN@alley>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2021 at 02:14:09PM +0100, Petr Mladek wrote:
> On Tue 2021-11-09 10:00:27, Ming Lei wrote:
> > On Mon, Nov 08, 2021 at 06:26:25PM +0100, Petr Mladek wrote:
> > > On Fri 2021-11-05 14:37:10, Ming Lei wrote:
> > > > kobject_put() may become asynchronously because of
> > > > CONFIG_DEBUG_KOBJECT_RELEASE, so once kobject_put() returns, the caller may
> > > > expect the kobject is released after the last refcnt is dropped, however
> > > > CONFIG_DEBUG_KOBJECT_RELEASE just schedules one delayed work function
> > > > for cleaning up the kobject. Inside the cleanup handler, kobj->ktype and
> > > > kobj->ktype->release are required.
> > > > 
> > > > It is supposed that no activity is on kobject itself any more since
> > > > module_exit() is started, so it is reasonable for the kobject user or
> > > > driver to expect that kobject can be really released in the last run of
> > > > kobject_put() in module_exit() code path. Otherwise, it can be thought as
> > > > one driver's bug since the module is going away.
> > > 
> > > Honestly, this looks a bit fragile. What if there is still another
> > > reference from some reason. IMHO, it is easy to do it wrong.
> > > The kobject stuff is super-tricky.
> > > 
> > > Yes, there is the argument that it is a drivers bug when it does not
> > > work.
> > 
> > That is another 'issue'(even not sure if there is really), and it isn't covered
> > in this patchset, which focuses on fixing CONFIG_DEBUG_KOBJECT_RELEASE, so
> > please do not mix the two here.
> 
> Yes, it is another issue but the relation is very important.
> 
> My understanding is that this patch prevents problems caused by
> the delayed work. The kobject is added into kobj_cleanup_list
> only when the delayed work is scheduled. The patch has no effect
> if the delayed work is not used.
> 
> From my POV, this patch kind of removes the effect of the delayed
> work. My point is:
> 
> Does it still make sense to use the delayed work in the first place?
> Will the delayed work still help to catch some problems?

That depends on the user of CONFIG_DEBUG_KOBJECT_RELEASE, if users
thought it is useless, I think it is fine to remove it.

Greg, any idea about if CONFIG_DEBUG_KOBJECT_RELEASE is useful now?

> 
> My point is that if this makes CONFIG_DEBUG_KOBJECT_RELEASE useless

No, that isn't true. CONFIG_DEBUG_KOBJECT_RELEASE still works in its
original way and the delay is still there, what this patch is doing is
to make it safe by completing the delayed cleanup before freeing module,
because ->ktype & related callbacks are often allocated in module static
memory.

> than we should remove CONFIG_DEBUG_KOBJECT_RELEASE instead.
> But then we need something else to prevent bugs that this
> functionality helped to debug.
> 
> 
> > The usual module use model is that module can't be used if someone is
> > use it. After module_exit() is started, no one should & can 'use' the module
> > any more, that is done by module's refcnt.
> 
> This statement is suspicious. IMHO, no one should 'use' the module
> after module_exit() _finishes_.

I said after module_exit() is started, not module_exit() is finished.

> 
> It should be perfectly fine to use the module after module_exit()
> _starts_ as long as module_exit() callback could wait until
> the existing users stop using the module.

No, once module_exit() is started, try_module_get() will return false,
so module isn't supposed to be used any more. See delete_module(),
->exit() is only called in case of module refcnt being zero.

> 
> 
> > So far the driver core subsystem doesn't use module owner info, so no
> > need to grab module refcnt in case that kobject is used. And that
> > actually doesn't work here, given we can't hold the module refcnt
> > during the kobject's lifetime, otherwise the module won't be unloaded
> > at all. Sort of chicken and egg problem given kobject is often released
> > during module_exit().
> >
> > But driver core does provide kobject_del() interface to wait until
> > all show()/store() are done.
> >
> > So once the driver said now no one uses that device and the module
> > can be unloaded, then kobject_del() is done inside module_exit(),
> > who can hold kobject's extra reference? If there is, the caller should
> > have grabbed the module refcnt to prevent module from being unloaded.
> > 
> > We usually think it is driver bug, see one fixed recently:
> > 
> > https://lore.kernel.org/linux-scsi/20211008050118.1440686-1-ming.lei@redhat.com/
> 
> Honestly, I do not understand how the extra module_get()/module_put()
> could prevent the race caused by delayed kobject clean up.

If module_get() is successful, module_exit() can't be called
until the module refcnt is released.

> 
> scsi_device_dev_release() uses try_module_get(). But it always calls
> scsi_device_dev_release_usercontext(). Why is it safe when
> try_module_get() failed?
> 
> I guess that the patch reduced the size of the race window but
> a race might still be there.
> 
> Anyway, it is pity that the commit message does not include the
> backtrace of the page fault. Or that it does not better describe
> the race that is fixed there.
> 
> 
> > > But I wonder if we could create API that might be used by
> > > drivers and report the actuall bug. Something like:
> > >
> > > int kobject_remove_sync(struct kobject *kobj)
> >
> > Not sure if this interface is useful:
> > 
> > 1) who need this interface?
> > - It is basically not possible to audit all drivers for the conversion, and not
> > necessary too.
> 
> It might be useful for people that want to create interface and
> drivers that are safe to unload.

It is one generic issue because most of ->ktype and related callbacks are stored
in module static memory, so all modules should be unloaded safely. If the interface
is created, in theory the last kobject_put() called in _all__ module_exit() should be
converted to this new interface. That is why I said it is basically not possible,
cause it isn't easy to figure one which is the last one in each
driver/module.

Again, any real report which needs such new interface? If there isn't, I
don't think it makes sense to take effort for making one, especially the
new API is very hard to use/convert.

> 
> 
> > 2) this may break some common open()/release model:
> > 
> > - user open() one device, here module refcnt is hold, and device/kobject refcnt
> >   is hold too
> > 
> > - device needs to be deleted by kobject_del() via sysfs or ioctl or
> >   others, if kobject_remove_sync() is used, it will complain, but it
> >   is just false warning. There are lots of such examples.
> 
> It might be solved the same way as sysfs_break_active_protection().
> I mean that the API might be aware of that it is removing itself.
> 
> 
> > 3) this way may break some uses if spin_lock() is held before calling
> > kobject_put().
> 
> This is not specific to the new API. The same problem is also with kobject_del().

No, spin_lock can't be held for kobject_del() which will sleep always.

> 
> 
> > 4) not usable in deleting kobject itself, or break the deleting me interface
> > simply.
> 
> It will be useful when the deleting is offloaded to a workqueue.

How is it useful?

> I still consider is less hacky than using sysfs_break_active_protection().

OK, if you think wq is better, care to post a patch to replace
sysfs_break_active_protection() with justification so that every user
can benefit from it?

> 
> 
> > 5) actually only one implicit rule is here: kobject needs to be released
> > before module exit is done if the kobject is created by this module
> 
> It the kobject is created by a module, it should be also destroyed
> by the module. And this is where some remove_kobject() API might
> be useful.

Yeah, but why new API is required, you have to provide one real report
for supporting the idea of new API.

> 
> 
> > 6) much less flexible than the usual two stage removal
> 
> We still could create a two stage API. The point is that it might be
> useful to have an API that will wait until the kobject is really
> released.

You have to know which one is the final release first, not mention not
every kobject_put() can wait.


Thanks,
Ming

