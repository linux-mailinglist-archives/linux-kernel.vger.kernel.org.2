Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7C33672F3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 20:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245337AbhDUS4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 14:56:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:53374 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245341AbhDUS42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 14:56:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 63FACAEF8;
        Wed, 21 Apr 2021 18:55:53 +0000 (UTC)
Date:   Wed, 21 Apr 2021 20:55:55 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Qiushi Wu <wu000273@umn.edu>
Subject: Re: [PATCH 029/190] Revert "EDAC: Fix reference count leaks"
Message-ID: <20210421185555.GA24470@zn.tnic>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-30-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210421130105.1226686-30-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 02:58:24PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit 17ed808ad243192fb923e4e653c1338d3ba06207.
> 
> Commits from @umn.edu addresses have been found to be submitted in "bad
> faith" to try to test the kernel community's ability to review "known
> malicious" changes.  The result of these submissions can be found in a
> paper published at the 42nd IEEE Symposium on Security and Privacy
> entitled, "Open Source Insecurity: Stealthily Introducing
> Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> of Minnesota) and Kangjie Lu (University of Minnesota).
> 
> Because of this, all submissions from this group must be reverted from
> the kernel tree and will need to be re-reviewed again to determine if
> they actually are a valid fix.  Until that work is complete, remove this
> change to ensure that no problems are being introduced into the
> codebase.
> 
> Cc: Qiushi Wu <wu000273@umn.edu>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: https
> Cc: https
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/edac/edac_device_sysfs.c | 1 -
>  drivers/edac/edac_pci_sysfs.c    | 2 +-
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/edac/edac_device_sysfs.c b/drivers/edac/edac_device_sysfs.c
> index 5e7593753799..0e7ea3591b78 100644
> --- a/drivers/edac/edac_device_sysfs.c
> +++ b/drivers/edac/edac_device_sysfs.c
> @@ -275,7 +275,6 @@ int edac_device_register_sysfs_main_kobj(struct edac_device_ctl_info *edac_dev)
>  
>  	/* Error exit stack */
>  err_kobj_reg:
> -	kobject_put(&edac_dev->kobj);
>  	module_put(edac_dev->owner);
>  
>  err_out:
> diff --git a/drivers/edac/edac_pci_sysfs.c b/drivers/edac/edac_pci_sysfs.c
> index 53042af7262e..72c9eb9fdffb 100644
> --- a/drivers/edac/edac_pci_sysfs.c
> +++ b/drivers/edac/edac_pci_sysfs.c
> @@ -386,7 +386,7 @@ static int edac_pci_main_kobj_setup(void)
>  
>  	/* Error unwind statck */
>  kobject_init_and_add_fail:
> -	kobject_put(edac_pci_top_main_kobj);
> +	kfree(edac_pci_top_main_kobj);
>  
>  kzalloc_fail:
>  	module_put(THIS_MODULE);
> -- 

That one is actually correct. 

AFAIR, that was a reaction to kobject_init_and_add()'s comment saying
users should do kobject_put() when that function fails.

So the added kobject_put() would make sure the ->release method is
called which will kfree the kobject and drop the module reference. And
both ->release methods don't do anything else so there are no side
effects from it like with other cases earlier today.

So yeah, that one could stay in.

Can't say I didn't spend some time staring at this today again, thanks
to this "experiment". :-\

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
