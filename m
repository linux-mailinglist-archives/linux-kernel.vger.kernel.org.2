Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9313E36C992
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 18:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236625AbhD0QkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 12:40:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:60746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229678AbhD0Qj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:39:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 91863613D9;
        Tue, 27 Apr 2021 16:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619541553;
        bh=RdWzo/rnuhgvFv1hije9FrIUD/I7FH646Ivf5/ewXX8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Re0mbNdK2neYcvy6Nd9VRZQrFs+/ApwUFFLF458c4FZL2ETKva50Fnr45Ll0TIEZx
         75ZnQ4fYsIk9NYrsrntBOn5EzVR51A7pOrMsLcl7N3uaEvOZAePzQiNC2y5aPd+aOZ
         T+abremHwZzggcm9bXwjDVhAouPsjxiCQw4OmHlo=
Date:   Tue, 27 Apr 2021 18:39:10 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Lee Duncan <lduncan@suse.com>, Qiushi Wu <wu000273@umn.edu>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 035/190] Revert "scsi: iscsi: Fix reference count leak in
 iscsi_boot_create_kobj"
Message-ID: <YIg+LkC9In2J6aYv@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-36-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-36-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 02:58:30PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit 0267ffce562c8bbf9b57ebe0e38445ad04972890.
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
> Cc: https
> Cc: Lee Duncan <lduncan@suse.com>
> Cc: Qiushi Wu <wu000273@umn.edu>
> Cc: Martin K. Petersen <martin.petersen@oracle.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/scsi/iscsi_boot_sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/iscsi_boot_sysfs.c b/drivers/scsi/iscsi_boot_sysfs.c
> index a64abe38db2d..e4857b728033 100644
> --- a/drivers/scsi/iscsi_boot_sysfs.c
> +++ b/drivers/scsi/iscsi_boot_sysfs.c
> @@ -352,7 +352,7 @@ iscsi_boot_create_kobj(struct iscsi_boot_kset *boot_kset,
>  	boot_kobj->kobj.kset = boot_kset->kset;
>  	if (kobject_init_and_add(&boot_kobj->kobj, &iscsi_boot_ktype,
>  				 NULL, name, index)) {
> -		kobject_put(&boot_kobj->kobj);
> +		kfree(boot_kobj);
>  		return NULL;
>  	}
>  	boot_kobj->data = data;
> -- 
> 2.31.1
> 

Looks correct so I'll drop this revert.

thanks,

greg k-h
