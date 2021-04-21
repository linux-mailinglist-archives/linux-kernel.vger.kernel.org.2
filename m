Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDB73673DC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 21:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245588AbhDUT77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 15:59:59 -0400
Received: from namei.org ([65.99.196.166]:48254 "EHLO mail.namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236274AbhDUT76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 15:59:58 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.namei.org (Postfix) with ESMTPS id 59035C6B;
        Wed, 21 Apr 2021 19:55:33 +0000 (UTC)
Date:   Thu, 22 Apr 2021 05:55:33 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     linux-kernel@vger.kernel.org, Wenwen Wang <wang6495@umn.edu>,
        Adam Radford <aradford@gmail.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 189/190] Revert "scsi: 3w-9xxx: fix a missing-check
 bug"
In-Reply-To: <20210421130105.1226686-190-gregkh@linuxfoundation.org>
Message-ID: <b27a43bb-36bc-4b9-42de-c39a5b68f96f@namei.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org> <20210421130105.1226686-190-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Apr 2021, Greg Kroah-Hartman wrote:

> This reverts commit c9318a3e0218bc9dacc25be46b9eec363259536f.
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
> Cc: Wenwen Wang <wang6495@umn.edu>
> Cc: Adam Radford <aradford@gmail.com>
> Cc: Martin K. Petersen <martin.petersen@oracle.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

The original patch here looks valid and necessary.

Please un-revert.


Reviewed-by: James Morris <jamorris@linux.microsoft.com>


> ---
>  drivers/scsi/3w-9xxx.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/scsi/3w-9xxx.c b/drivers/scsi/3w-9xxx.c
> index b96e82de4237..4c5d4ea8a592 100644
> --- a/drivers/scsi/3w-9xxx.c
> +++ b/drivers/scsi/3w-9xxx.c
> @@ -886,11 +886,6 @@ static int twa_chrdev_open(struct inode *inode, struct file *file)
>  	unsigned int minor_number;
>  	int retval = TW_IOCTL_ERROR_OS_ENODEV;
>  
> -	if (!capable(CAP_SYS_ADMIN)) {
> -		retval = -EACCES;
> -		goto out;
> -	}
> -
>  	minor_number = iminor(inode);
>  	if (minor_number >= twa_device_extension_count)
>  		goto out;
> -- 
> 2.31.1
> 

-- 
James Morris
<jmorris@namei.org>

