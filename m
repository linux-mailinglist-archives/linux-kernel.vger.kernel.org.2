Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFDE44A469
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 03:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240787AbhKICDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 21:03:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21333 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239565AbhKICDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 21:03:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636423258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MHaPnbt4qbTbcUjN71+uaJDyE2jVkRnEBiT+fz9SlxE=;
        b=LfZMpDv24b7RmPuD/aT5M3FaY3+/utDXji0VOpdoOAxeGxgSerOSfBaoRCwBVsbHBD9dB4
        OD5iNwBnz7DJMbumqPrvo/273xEPAsfFTCy3veLC8kROahudQKD3yL2pkUse9yBf0aUO/m
        bcSp3Nt3qwQKGsU03WvdZ+88DhU4FQ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-zaviYWFVPg2ItqKkIcN8Sg-1; Mon, 08 Nov 2021 21:00:55 -0500
X-MC-Unique: zaviYWFVPg2ItqKkIcN8Sg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 452AA19057A2;
        Tue,  9 Nov 2021 02:00:54 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0855B60C81;
        Tue,  9 Nov 2021 02:00:32 +0000 (UTC)
Date:   Tue, 9 Nov 2021 10:00:27 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Joe Lawrence <joe.lawrence@redhat.com>, ming.lei@redhat.com
Subject: Re: [PATCH 2/2] kobject: wait until kobject is cleaned up before
 freeing module
Message-ID: <YYnWO1Jug3xu+NB+@T590>
References: <20211105063710.4092936-1-ming.lei@redhat.com>
 <20211105063710.4092936-3-ming.lei@redhat.com>
 <YYldwVcrEqShHyq8@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYldwVcrEqShHyq8@alley>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2021 at 06:26:25PM +0100, Petr Mladek wrote:
> On Fri 2021-11-05 14:37:10, Ming Lei wrote:
> > kobject_put() may become asynchronously because of
> > CONFIG_DEBUG_KOBJECT_RELEASE, so once kobject_put() returns, the caller may
> > expect the kobject is released after the last refcnt is dropped, however
> > CONFIG_DEBUG_KOBJECT_RELEASE just schedules one delayed work function
> > for cleaning up the kobject. Inside the cleanup handler, kobj->ktype and
> > kobj->ktype->release are required.
> > 
> > It is supposed that no activity is on kobject itself any more since
> > module_exit() is started, so it is reasonable for the kobject user or
> > driver to expect that kobject can be really released in the last run of
> > kobject_put() in module_exit() code path. Otherwise, it can be thought as
> > one driver's bug since the module is going away.
> 
> Honestly, this looks a bit fragile. What if there is still another
> reference from some reason. IMHO, it is easy to do it wrong.
> The kobject stuff is super-tricky.
> 
> Yes, there is the argument that it is a drivers bug when it does not
> work.

That is another 'issue'(even not sure if there is really), and it isn't covered
in this patchset, which focuses on fixing CONFIG_DEBUG_KOBJECT_RELEASE, so
please do not mix the two here.

The usual module use model is that module can't be used if someone is
use it. After module_exit() is started, no one should & can 'use' the module
any more, that is done by module's refcnt.

So far the driver core subsystem doesn't use module owner info, so no
need to grab module refcnt in case that kobject is used. And that
actually doesn't work here, given we can't hold the module refcnt
during the kobject's lifetime, otherwise the module won't be unloaded
at all. Sort of chicken and egg problem given kobject is often released
during module_exit().

But driver core does provide kobject_del() interface to wait until
all show()/store() are done.

So once the driver said now no one uses that device and the module
can be unloaded, then kobject_del() is done inside module_exit(),
who can hold kobject's extra reference? If there is, the caller should
have grabbed the module refcnt to prevent module from being unloaded.

We usually think it is driver bug, see one fixed recently:

https://lore.kernel.org/linux-scsi/20211008050118.1440686-1-ming.lei@redhat.com/

Do you have real report?

> But I wonder if we could create API that might be used by
> drivers and report the actuall bug. Something like:
> 
> 
> First, update kobject_put() so that it returns 1 when the release
> method was called:
> 
> /**
>  * __kobject_put - decrement kobject refcount
>  * @kobject: pointer to kobject
>  *
>  * Decrement the refcount, and if 0, call release().
>  * Return 1 if the object was removed, otherwise return 0.  Beware, if this
>  * function returns 0, you still can not count on the kref from remaining in
>  * memory.  Only use the return value if you want to see if the kref is now
>  * gone, not present.
>  */
> int __kobject_put(struct kobject *kobj)
> {
> 	if (!kobj)
> 		return 0;
> 
> 	if (!kobj->state_initialized) {
> 		WARN(1, KERN_WARNING
> 		     "kobject: '%s' (%p): is not initialized, yet kobject_put() is being called.\n",
> 		     kobject_name(kobj), kobj);
> 	}
> 
> 	return kref_put(&kobj->kref, kobject_release);
> }
> 
> /**
>  * kobject_remove_sync - remove the kobject in two stages and wait
>  *      until it is removed.
>  * @kobject: pointer to kobject
>  *
>  * Return 0 on success, -EBUSY when someone else still owns a
>  *     reference on the kobject.
>  *
>  * IMPORTANT: The caller is reponsible that nobody else has explicit
>  *	reference on the kobject. The only expection are callbacks
>  *	used by the related sysfs interface. The two stage removal
>  *	makes sure that there is no pending operation when
>  *	the final put is called.
>  */
> int kobject_remove_sync(struct kobject *kobj)
> {
> #ifdef CONFIG_DEBUG_KOBJECT_RELEASE
> 	DECLARE_COMPLETION(released);
> 
> 	if (kobj)
> 		kobj->released = released;
> #endif
> 
> 	/* Remove sysfs */
> 	kobject_del(kobj);
> 
> 	/* This should be the final put */
> 	if (WARN(!__kobject_put(kobj), "Synchronous  kobject release failed. Someone still had a reference.\n")) 
> 		return -EBUSY;

Not sure if this interface is useful:

1) who need this interface?
- It is basically not possible to audit all drivers for the conversion, and not
necessary too.

2) this may break some common open()/release model:

- user open() one device, here module refcnt is hold, and device/kobject refcnt
  is hold too

- device needs to be deleted by kobject_del() via sysfs or ioctl or
  others, if kobject_remove_sync() is used, it will complain, but it
  is just false warning. There are lots of such examples.

3) this way may break some uses if spin_lock() is held before calling
kobject_put().

4) not usable in deleting kobject itself, or break the deleting me interface
simply.

5) actually only one implicit rule is here: kobject needs to be released
before module exit is done if the kobject is created by this module

6) much less flexible than the usual two stage removal

So IMO, it is wrong direction for fixing the 'issue'.

More importantly I'd see one real such report first before figuring out solution,
then we can see if it is driver issue or generic kobject API problem, doesn't it
make sense?

> 
> #ifdef CONFIG_DEBUG_KOBJECT_RELEASE
> 	wait_for_completion(&released);
> #endif
> 	return 0;
> }
> 
> , where the pointer struct completion *released will be added
> into struct kobject. And kobject_cleanup() will call complete()
> after the object is released.
> 
> The completion must be defined in kobject_remove_sync() and passed
> via pointer. It is because struct kobject itself might be freed
> by release() callback.
> 
> 
> > When the ->ktype and ->ktype->release are allocated as module static
> > variable, it can cause trouble because the delayed cleanup handler may
> > be run after the module is unloaded.
> > 
> > Fixes the issue by flushing scheduled kobject cleanup work before
> > freeing module.
> > 
> > --- a/lib/kobject.c
> > +++ b/lib/kobject.c
> > @@ -716,11 +729,49 @@ static void kobject_cleanup(struct kobject *kobj)
> >  }
> >  
> >  #ifdef CONFIG_DEBUG_KOBJECT_RELEASE
> > +/*
> > + * Module notifier call back, flushing scheduled kobject cleanup work
> > + * before freeing module
> > + */
> > +static int kobj_module_callback(struct notifier_block *nb,
> > +				   unsigned long val, void *data)
> > +{
> > +	LIST_HEAD(pending);
> > +
> > +	if (val != MODULE_STATE_GOING)
> > +		return NOTIFY_DONE;
> > +
> > +	spin_lock_irq(&kobj_cleanup_lock);
> > +	list_splice_init(&kobj_cleanup_list, &pending);
> > +	spin_unlock_irq(&kobj_cleanup_lock);
> > +
> > +	while (!list_empty_careful(&pending))
> > +		msleep(jiffies_to_msecs(HZ / 10));
> 
> I was curious why this is needed. I guess that it is because
> flush_sched_work() will not wait for delayed work items that
> are still waiting for the timer. Am I right, please?

Right.

Actually flush_workqueue() can't cover delayed work item too,
also asynchronous function doesn't support delayed function.

> 
> > +
> > +	flush_scheduled_work();
> 
> I guess that this is needed because the kobj is removed from the list
> before it is released. Am I right, please?

Right.

> 
> It would be worth to document it. IMHO, it is not obvious why
> it is that complicated.

Fine. As I mentioned, I tried to do it via single kernel API(flush_work
queue or asynchronous function), but there isn't anyone who is capable
of the requirement.

> 
> 
> More thoughts:
> 
> The advantage of the module going callback is that it is transparent.
> It should fix the problem for most existing users in most situations.
> 
> But it will solve the problem only when someone puts the final
> reference before the module going callback is called. It does
> not guarantee that it really works.

I think that is one implicit rule. The simple question is that
after module is unloaded, who will/can use that kobject? Isn't it
a driver bug?

> 
> Note that CONFIG_DEBUG_KOBJECT_RELEASE and the workqueue is there
> only to make exactly this problem more visible. I mean that
> the final kobject_put() need not be final.

No, I don't understand 'the final kobject_put() need not be final',
isn't the kobject_remove_sync() done for the final release?

> 
> It would be great to have somehing for users that want to know
> that they do the right thing. For example, it is a must-to-have
> for the livepatch code. IMHO, kobject_remove_sync() or something
> similar would make the kobject API more safe to use.

kobject_remove_sync() isn't good, see my above comment. Even it can't
fix livepatch after the wq hack is removed.


Thanks,
Ming

