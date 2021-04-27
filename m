Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7833D36C7D7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 16:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238392AbhD0OiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 10:38:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:48192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236144AbhD0OiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 10:38:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 99C9F60720;
        Tue, 27 Apr 2021 14:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619534254;
        bh=uqGg422qK3u2z+FUZJFLlEtpumE+M6VjdfdlU8E6utY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QsbQFQi5H7SBWscWjX/wqo5w1cOsApe0Xi5t+28UhDVXzvq/dblmgZqTVRUgBxUXd
         QiR7lSFXSVt2cQuV0W1UoMDzn0RF8oZ7EDyML3AOSwsNu/aEs+GUKVSHNfsw43AhTL
         6I4/gV//PVVwI3/tiYaaHbAR/WzE71ANUmo+ilKY=
Date:   Tue, 27 Apr 2021 16:37:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>
Subject: Re: [PATCH 108/190] Revert "usb: u132-hcd: fix potential NULL
 pointer dereference"
Message-ID: <YIghqz7ojsUT8NgQ@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-109-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-109-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 02:59:43PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit 3de3dbe7c13210171ba8411e36b409a2c29c7415.
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
> Cc: Kangjie Lu <kjlu@umn.edu>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/usb/host/u132-hcd.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/usb/host/u132-hcd.c b/drivers/usb/host/u132-hcd.c
> index eb96e1e15b71..2b7bcbe2df4b 100644
> --- a/drivers/usb/host/u132-hcd.c
> +++ b/drivers/usb/host/u132-hcd.c
> @@ -3195,8 +3195,6 @@ static int __init u132_hcd_init(void)
>  		return -ENODEV;
>  	printk(KERN_INFO "driver %s\n", hcd_name);
>  	workqueue = create_singlethread_workqueue("u132");
> -	if (!workqueue)
> -		return -ENOMEM;
>  	retval = platform_driver_register(&u132_platform_driver);
>  	if (retval)
>  		destroy_workqueue(workqueue);
> -- 
> 2.31.1
> 

This commit was correct, will drop this.

greg k-h
