Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5AA336C991
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 18:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236367AbhD0Qj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 12:39:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:60428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229678AbhD0QjT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:39:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5DB8D613E8;
        Tue, 27 Apr 2021 16:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619541513;
        bh=uj+wDnzRM7np7tJSFSTE6qNPsTMfRLgrqKLuqOorRaY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YAY94hcQR+xsdKIAzUKqvfBMddrwYOqHLGGYRNZQdwCcup2Un+AQ5F3aiyrm1yBLW
         +mbn/RDjx1Oz68HnADOg73UR0W+GlVmLuic5lHAyAsN6lUSv+gcRF7aqlY4BM0JTNL
         OJ+C33bKaLGT8UaE5vwx4RhfKHDo/cVnR9Slk2t0=
Date:   Tue, 27 Apr 2021 18:38:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     linux-kernel@vger.kernel.org, Qiushi Wu <wu000273@umn.edu>
Subject: Re: [PATCH 038/190] Revert "cpuidle: Fix three reference count leaks"
Message-ID: <YIg+B0sSR+7QMXZx@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-39-gregkh@linuxfoundation.org>
 <6fc7a639-f97f-923e-04e7-6402b4e6ef7f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6fc7a639-f97f-923e-04e7-6402b4e6ef7f@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 07:53:46PM +0200, Rafael J. Wysocki wrote:
> On 4/21/2021 2:58 PM, Greg Kroah-Hartman wrote:
> > This reverts commit c343bf1ba5efcbf2266a1fe3baefec9cc82f867f.
> > 
> > Commits from @umn.edu addresses have been found to be submitted in "bad
> > faith" to try to test the kernel community's ability to review "known
> > malicious" changes.  The result of these submissions can be found in a
> > paper published at the 42nd IEEE Symposium on Security and Privacy
> > entitled, "Open Source Insecurity: Stealthily Introducing
> > Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> > of Minnesota) and Kangjie Lu (University of Minnesota).
> > 
> > Because of this, all submissions from this group must be reverted from
> > the kernel tree and will need to be re-reviewed again to determine if
> > they actually are a valid fix.  Until that work is complete, remove this
> > change to ensure that no problems are being introduced into the
> > codebase.
> > 
> > Cc: Qiushi Wu <wu000273@umn.edu>
> > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> 
> > ---
> >   drivers/cpuidle/sysfs.c | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
> > index 53ec9585ccd4..23a219cedbdb 100644
> > --- a/drivers/cpuidle/sysfs.c
> > +++ b/drivers/cpuidle/sysfs.c
> > @@ -487,7 +487,7 @@ static int cpuidle_add_state_sysfs(struct cpuidle_device *device)
> >   		ret = kobject_init_and_add(&kobj->kobj, &ktype_state_cpuidle,
> >   					   &kdev->kobj, "state%d", i);
> >   		if (ret) {
> > -			kobject_put(&kobj->kobj);
> > +			kfree(kobj);
> >   			goto error_state;
> >   		}
> >   		cpuidle_add_s2idle_attr_group(kobj);
> > @@ -618,7 +618,7 @@ static int cpuidle_add_driver_sysfs(struct cpuidle_device *dev)
> >   	ret = kobject_init_and_add(&kdrv->kobj, &ktype_driver_cpuidle,
> >   				   &kdev->kobj, "driver");
> >   	if (ret) {
> > -		kobject_put(&kdrv->kobj);
> > +		kfree(kdrv);
> >   		return ret;
> >   	}
> > @@ -712,7 +712,7 @@ int cpuidle_add_sysfs(struct cpuidle_device *dev)
> >   	error = kobject_init_and_add(&kdev->kobj, &ktype_cpuidle, &cpu_dev->kobj,
> >   				   "cpuidle");
> >   	if (error) {
> > -		kobject_put(&kdev->kobj);
> > +		kfree(kdev);
> >   		return error;
> >   	}
> 
> 

This looks correct so I'll drop the revert.

greg k-h
