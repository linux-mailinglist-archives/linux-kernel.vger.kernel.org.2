Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDA836C9D1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 18:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236649AbhD0Q5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 12:57:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:42984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236571AbhD0Q5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:57:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 65740613D9;
        Tue, 27 Apr 2021 16:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619542576;
        bh=ummjkB5d/d3zm8RJTKB6WoF/gLMhcQXrNHhoCoKvZC8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g/zmGWOyY+apYCu2GaVa8EXZkmC1iQsG4dHn5VKw1nz931k0o/Tyjwbhw5JBN1GIh
         icGSfzcFMIWkPHVImJfoG+0YOdFI8m2GBP3tDXht6zj50eDoc+T+mvC6MU97GhCmmj
         VyyxSRzfPlTJS37/1YUcJ8Mm21JRsWqEQ2cNlHNA=
Date:   Tue, 27 Apr 2021 18:56:14 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Wenwen Wang <wang6495@umn.edu>, Adam Radford <aradford@gmail.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 188/190] Revert "scsi: 3w-xxxx: fix a missing-check bug"
Message-ID: <YIhCLuJi3WyuMS0T@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-189-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-189-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 03:01:03PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit 9899e4d3523faaef17c67141aa80ff2088f17871.
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
> ---
>  drivers/scsi/3w-xxxx.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/scsi/3w-xxxx.c b/drivers/scsi/3w-xxxx.c
> index d90b9fca4aea..8f52f35e40f1 100644
> --- a/drivers/scsi/3w-xxxx.c
> +++ b/drivers/scsi/3w-xxxx.c
> @@ -1035,9 +1035,6 @@ static int tw_chrdev_open(struct inode *inode, struct file *file)
>  
>  	dprintk(KERN_WARNING "3w-xxxx: tw_ioctl_open()\n");
>  
> -	if (!capable(CAP_SYS_ADMIN))
> -		return -EACCES;
> -
>  	minor_number = iminor(inode);
>  	if (minor_number >= tw_device_extension_count)
>  		return -ENODEV;
> -- 
> 2.31.1
> 

The original commit was correct, dropping this revert.

greg k-h
