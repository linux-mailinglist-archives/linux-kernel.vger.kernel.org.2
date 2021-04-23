Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D35A5369042
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 12:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236059AbhDWKXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 06:23:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:37194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230502AbhDWKXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 06:23:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C62266113D;
        Fri, 23 Apr 2021 10:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619173393;
        bh=OKMLZ0XzBhikQv9Z9LBmKZnHBJKASo+q0XlHg8JMt8w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JdvR+Xy3JcmvhydC9/SnvA9X/GkicgThwJL9u1sHW0NFmls9VOOJEJ4mdwtzw1VOg
         zy5kkGHagwhoFOjoJWzD5pcgfw9GMZ81PjIvPOyaScTPiWy91Xt23Dc79cfZ3D28Us
         EfQ2t6RaQD0zY/l69iDkdmPwfbEUIwcXc/gi/BFRt6hfOsfzpzip8HoSWbdY/EtDmb
         p9wI4bgNWjFmOSdHCEYFTCvvTfxdCCLj1PuqPC3mKJukpDSCGYmkER9eKWKKfNFBkZ
         3114Kus/UbMfXSAeg6o9pONtPT/mQf5HNcu/W00KBqB3lrMfXvhKUv/GZqQ4CTjJZ1
         hR7pdNUIxdCMA==
Date:   Fri, 23 Apr 2021 12:23:08 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 009/190] Revert "media: s5p-mfc: Fix a reference count
 leak"
Message-ID: <20210423122308.3883b9e7@coco.lan>
In-Reply-To: <20210423114241.29cf1ab3@coco.lan>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
        <20210421130105.1226686-10-gregkh@linuxfoundation.org>
        <b43fc2b0-b3cf-15ab-7d3c-25c1f2a3e658@canonical.com>
        <YIJy6AnG6QBlkV/5@kroah.com>
        <20210423100727.5a999c2e@coco.lan>
        <02966f20-342d-cf21-8216-d364b67753b7@xs4all.nl>
        <ed2859a3-0051-5ef4-483c-9abd4fa81b22@canonical.com>
        <alpine.DEB.2.22.394.2104231037400.4538@hadrien>
        <20210423114241.29cf1ab3@coco.lan>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 23 Apr 2021 11:42:55 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

> (adding c/c to Rafael)
> 
> Em Fri, 23 Apr 2021 10:41:32 +0200 (CEST)
> Julia Lawall <julia.lawall@inria.fr> escreveu:
> 
> > On Fri, 23 Apr 2021, Krzysztof Kozlowski wrote:
> >   
> > > On 23/04/2021 10:10, Hans Verkuil wrote:    
> > > > On 23/04/2021 10:07, Mauro Carvalho Chehab wrote:    
> > > >> Em Fri, 23 Apr 2021 09:10:32 +0200
> > > >> Greg Kroah-Hartman <gregkh@linuxfoundation.org> escreveu:
> > > >>    
> > > >>> On Fri, Apr 23, 2021 at 09:04:27AM +0200, Krzysztof Kozlowski wrote:    
> > > >>>> On 21/04/2021 14:58, Greg Kroah-Hartman wrote:    
> > > >>>>> This reverts commit 78741ce98c2e36188e2343434406b0e0bc50b0e7.
> > > >>>>>
> > > >>>>> Commits from @umn.edu addresses have been found to be submitted in "bad
> > > >>>>> faith" to try to test the kernel community's ability to review "known
> > > >>>>> malicious" changes.  The result of these submissions can be found in a
> > > >>>>> paper published at the 42nd IEEE Symposium on Security and Privacy
> > > >>>>> entitled, "Open Source Insecurity: Stealthily Introducing
> > > >>>>> Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> > > >>>>> of Minnesota) and Kangjie Lu (University of Minnesota).
> > > >>>>>
> > > >>>>> Because of this, all submissions from this group must be reverted from
> > > >>>>> the kernel tree and will need to be re-reviewed again to determine if
> > > >>>>> they actually are a valid fix.  Until that work is complete, remove this
> > > >>>>> change to ensure that no problems are being introduced into the
> > > >>>>> codebase.
> > > >>>>>
> > > >>>>> Cc: Qiushi Wu <wu000273@umn.edu>
> > > >>>>> Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> > > >>>>> Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > >>>>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > >>>>> ---
> > > >>>>>  drivers/media/platform/s5p-mfc/s5p_mfc_pm.c | 4 +---
> > > >>>>>  1 file changed, 1 insertion(+), 3 deletions(-)
> > > >>>>>    
> > > >>>>
> > > >>>> This looks like a good commit but should be done now in a different way
> > > >>>> - using pm_runtime_resume_and_get().  Therefore I am fine with revert
> > > >>>> and I can submit later better fix.    
> > > >>>
> > > >>> Great, thanks for letting me know, I can have someone work on the
> > > >>> "better fix" at the same time.    
> > > >>
> > > >> IMO, it is better to keep the fix. I mean, there's no reason to
> > > >> revert a fix that it is known to be good.
> > > >>
> > > >> The "better fix" patch can be produced anytime. A simple coccinelle
> > > >> ruleset can replace patterns like:
> > > >>
> > > >> 	ret = pm_runtime_get_sync(pm->device);
> > > >> 	if (ret < 0) {
> > > >> 		pm_runtime_put_noidle(pm->device);
> > > >> 		return ret;
> > > >> 	}
> > > >>
> > > >> and the broken pattern:
> > > >>
> > > >> 	ret = pm_runtime_get_sync(pm->device);
> > > >> 	if (ret < 0)
> > > >> 		return ret;
> > > >>
> > > >> to:
> > > >>
> > > >> 	ret = pm_runtime_resume_and_get(pm->device);
> > > >> 	if (ret < 0)
> > > >> 		return ret;    
> > > >
> > > > That's my preference as well.    
> > >
> > > It won't be that easy because sometimes the error handling is via goto
> > > (like in other patches here) but anyway I don't mind keeping the
> > > original commits.    
> > 
> > I tried the following semantic patch:
> > 
> > @@
> > expression ret,e;
> > @@
> > 
> > -     ret = pm_runtime_get_sync(e);
> > +     ret = pm_resume_and_get(e);
> >       if (ret < 0) {
> >               ...
> > ?-            pm_runtime_put_noidle(e);
> >               ...
> >               return ret;
> >       }
> > 
> > It has the following features:
> > 
> > * The ? means that if pm_runtime_put_noidle is absent, the transformation
> > will happen anyway.
> > 
> > * The ... before the return means that the matching will jump over a goto.
> > 
> > It makes a lot of changes (in a kernel I had handy from March).   
> 
> I would expect lots of changes, as the pm_runtime_resume_and_get() was only
> recently introduced on this changeset:
> 
> commit dd8088d5a8969dc2b42f71d7bc01c25c61a78066
> Author: Zhang Qilong <zhangqilong3@huawei.com>
> Date:   Tue Nov 10 17:29:32 2020 +0800
> 
>     PM: runtime: Add pm_runtime_resume_and_get to deal with usage counter
>     
>     In many case, we need to check return value of pm_runtime_get_sync, but
>     it brings a trouble to the usage counter processing. Many callers forget
>     to decrease the usage counter when it failed, which could resulted in
>     reference leak. It has been discussed a lot[0][1]. So we add a function
>     to deal with the usage counter for better coding.
>     
>     [0]https://lkml.org/lkml/2020/6/14/88
>     [1]https://patchwork.ozlabs.org/project/linux-tegra/list/?series=178139
>     Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
>     Acked-by: Rafael J. Wysocki  <rafael.j.wysocki@intel.com>
>     Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> > This is a
> > complicated API, however, and I don't know if there are any other issues
> > to take into account, especially in the case where the call to
> > pm_runtime_put_noidle is not present.  
> 
> I double-checked the code, despite its name, pm_runtime_put_noidle() just
> changes the refcount. See, the relevant code is here:
> 
> 	static inline void pm_runtime_put_noidle(struct device *dev)
> 	{
> 		atomic_add_unless(&dev->power.usage_count, -1, 0);
> 	}
> 
> 	static inline int pm_runtime_get_sync(struct device *dev)
> 	{
> 		return __pm_runtime_resume(dev, RPM_GET_PUT);
> 	}
> 
> 	int __pm_runtime_resume(struct device *dev, int rpmflags)
> 	{
> 	        unsigned long flags;
> 	        int retval;
> 
> 	        might_sleep_if(!(rpmflags & RPM_ASYNC) && !dev->power.irq_safe &&
> 	                        dev->power.runtime_status != RPM_ACTIVE);
> 
> 	        if (rpmflags & RPM_GET_PUT)
> 	                atomic_inc(&dev->power.usage_count);
> 
> 	        spin_lock_irqsave(&dev->power.lock, flags);
> 	        retval = rpm_resume(dev, rpmflags);
> 	        spin_unlock_irqrestore(&dev->power.lock, flags);
> 
> 	        return retval;
> 	}
> 
> Not being an expert at the PM runtime API, at least on my eyes,
> replacing pm_runtime_get_sync() by pm_runtime_resume_and_get()
> seems to be the right thing to do, but Rafael should know more.

The cocci recipe made some wrong error check logic on some drivers,
like, for instance: drivers/media/i2c/mt9m001.c. 

On such drivers, the logic is like:

		ret = pm_runtime_resume_get_sync(&client->dev);
 		if (ret < 0)
	 		goto put_unlock;
		ret = mt9m001_apply_selection(sd);
 		if (ret)
 			goto put_unlock;


		...
	put_unlock:
		pm_runtime_put(&client->dev);
	 	mutex_unlock(&mt9m001->mutex);

On those cases where there are gotos to a logic with either
pm_runtime_put() or pm_runtime_put_no_idle(), the coccinelle
receipt should probably ignore it.

Thanks,
Mauro
