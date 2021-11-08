Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE46449ABB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 18:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240125AbhKHR3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 12:29:15 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:37350 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbhKHR3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 12:29:14 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A05FA21B04;
        Mon,  8 Nov 2021 17:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1636392388; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3j4gSHC2KJtJjO4SCGPj3H1Unir8LsmQG4005nQwem8=;
        b=f+Hr36Y+WmEUe4h6EWIRtnokvJKhGyOiYJaNGk27vlmoGymbfCO27w1taQIDGbuCWL2fy/
        Kv5mEAgMs/8+VSHpO3LswcfIBcm8wJ626DiJfW9zRcDHL3RGtkLTvo3nniGVtteBZ5YF2T
        kv3E7CavRQPjlcBK8sraR8u2LPIN8ro=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7C48FA3B87;
        Mon,  8 Nov 2021 17:26:28 +0000 (UTC)
Date:   Mon, 8 Nov 2021 18:26:25 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Joe Lawrence <joe.lawrence@redhat.com>
Subject: Re: [PATCH 2/2] kobject: wait until kobject is cleaned up before
 freeing module
Message-ID: <YYldwVcrEqShHyq8@alley>
References: <20211105063710.4092936-1-ming.lei@redhat.com>
 <20211105063710.4092936-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211105063710.4092936-3-ming.lei@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2021-11-05 14:37:10, Ming Lei wrote:
> kobject_put() may become asynchronously because of
> CONFIG_DEBUG_KOBJECT_RELEASE, so once kobject_put() returns, the caller may
> expect the kobject is released after the last refcnt is dropped, however
> CONFIG_DEBUG_KOBJECT_RELEASE just schedules one delayed work function
> for cleaning up the kobject. Inside the cleanup handler, kobj->ktype and
> kobj->ktype->release are required.
> 
> It is supposed that no activity is on kobject itself any more since
> module_exit() is started, so it is reasonable for the kobject user or
> driver to expect that kobject can be really released in the last run of
> kobject_put() in module_exit() code path. Otherwise, it can be thought as
> one driver's bug since the module is going away.

Honestly, this looks a bit fragile. What if there is still another
reference from some reason. IMHO, it is easy to do it wrong.
The kobject stuff is super-tricky.

Yes, there is the argument that it is a drivers bug when it does not
work. But I wonder if we could create API that might be used by
drivers and report the actuall bug. Something like:


First, update kobject_put() so that it returns 1 when the release
method was called:

/**
 * __kobject_put - decrement kobject refcount
 * @kobject: pointer to kobject
 *
 * Decrement the refcount, and if 0, call release().
 * Return 1 if the object was removed, otherwise return 0.  Beware, if this
 * function returns 0, you still can not count on the kref from remaining in
 * memory.  Only use the return value if you want to see if the kref is now
 * gone, not present.
 */
int __kobject_put(struct kobject *kobj)
{
	if (!kobj)
		return 0;

	if (!kobj->state_initialized) {
		WARN(1, KERN_WARNING
		     "kobject: '%s' (%p): is not initialized, yet kobject_put() is being called.\n",
		     kobject_name(kobj), kobj);
	}

	return kref_put(&kobj->kref, kobject_release);
}

/**
 * kobject_remove_sync - remove the kobject in two stages and wait
 *      until it is removed.
 * @kobject: pointer to kobject
 *
 * Return 0 on success, -EBUSY when someone else still owns a
 *     reference on the kobject.
 *
 * IMPORTANT: The caller is reponsible that nobody else has explicit
 *	reference on the kobject. The only expection are callbacks
 *	used by the related sysfs interface. The two stage removal
 *	makes sure that there is no pending operation when
 *	the final put is called.
 */
int kobject_remove_sync(struct kobject *kobj)
{
#ifdef CONFIG_DEBUG_KOBJECT_RELEASE
	DECLARE_COMPLETION(released);

	if (kobj)
		kobj->released = released;
#endif

	/* Remove sysfs */
	kobject_del(kobj);

	/* This should be the final put */
	if (WARN(!__kobject_put(kobj), "Synchronous  kobject release failed. Someone still had a reference.\n")) 
		return -EBUSY;

#ifdef CONFIG_DEBUG_KOBJECT_RELEASE
	wait_for_completion(&released);
#endif
	return 0;
}

, where the pointer struct completion *released will be added
into struct kobject. And kobject_cleanup() will call complete()
after the object is released.

The completion must be defined in kobject_remove_sync() and passed
via pointer. It is because struct kobject itself might be freed
by release() callback.


> When the ->ktype and ->ktype->release are allocated as module static
> variable, it can cause trouble because the delayed cleanup handler may
> be run after the module is unloaded.
> 
> Fixes the issue by flushing scheduled kobject cleanup work before
> freeing module.
> 
> --- a/lib/kobject.c
> +++ b/lib/kobject.c
> @@ -716,11 +729,49 @@ static void kobject_cleanup(struct kobject *kobj)
>  }
>  
>  #ifdef CONFIG_DEBUG_KOBJECT_RELEASE
> +/*
> + * Module notifier call back, flushing scheduled kobject cleanup work
> + * before freeing module
> + */
> +static int kobj_module_callback(struct notifier_block *nb,
> +				   unsigned long val, void *data)
> +{
> +	LIST_HEAD(pending);
> +
> +	if (val != MODULE_STATE_GOING)
> +		return NOTIFY_DONE;
> +
> +	spin_lock_irq(&kobj_cleanup_lock);
> +	list_splice_init(&kobj_cleanup_list, &pending);
> +	spin_unlock_irq(&kobj_cleanup_lock);
> +
> +	while (!list_empty_careful(&pending))
> +		msleep(jiffies_to_msecs(HZ / 10));

I was curious why this is needed. I guess that it is because
flush_sched_work() will not wait for delayed work items that
are still waiting for the timer. Am I right, please?

> +
> +	flush_scheduled_work();

I guess that this is needed because the kobj is removed from the list
before it is released. Am I right, please?

It would be worth to document it. IMHO, it is not obvious why
it is that complicated.


More thoughts:

The advantage of the module going callback is that it is transparent.
It should fix the problem for most existing users in most situations.

But it will solve the problem only when someone puts the final
reference before the module going callback is called. It does
not guarantee that it really works.

Note that CONFIG_DEBUG_KOBJECT_RELEASE and the workqueue is there
only to make exactly this problem more visible. I mean that
the final kobject_put() need not be final.

It would be great to have somehing for users that want to know
that they do the right thing. For example, it is a must-to-have
for the livepatch code. IMHO, kobject_remove_sync() or something
similar would make the kobject API more safe to use.

> +	return NOTIFY_DONE;
> +}
> +

Best Regards,
Petr
