Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD3093F3A7A
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 13:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234301AbhHULx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 07:53:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:36108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229968AbhHULx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 07:53:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5D12B611CB;
        Sat, 21 Aug 2021 11:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629546768;
        bh=jsUl4UV8kS+4boj7P+zaDX49gtU2KNCCoiB4K+ar/fw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cmvdkdrHTUx6YLz3oIcwxuKlsJwwzblS7S/pf5MaL4fQRjTQ74RYQRiE+2fpfFXes
         RrfMNlJjzrGrgTpJL1aRoyz8lSe20VYCklNOes3VVsvDCHq3riuwlB0GrYTrCj1fKs
         gB2G7bf/8ut3AoLS1mSi9lI+JSSB0B+L8G8W6Yks=
Date:   Sat, 21 Aug 2021 13:52:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Daniel Steger <daniel.steger@xilinx.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: sysfs: do not remove files if group is null
Message-ID: <YSDpDLYuiFDyshwj@kroah.com>
References: <20210819191019.3380999-1-daniel.steger@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210819191019.3380999-1-daniel.steger@xilinx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2021 at 12:10:20PM -0700, Daniel Steger wrote:
> The current implementation allows the remove_files() API to be
> called without checking if the grp->name is null. Ensure that
> the group name is valid prior to removing files.
> 
> This patch fixes a race condition where device_del() will cleanup
> sysfs entries prior to device managed sysfs entries. This results
> in a NULL group->name and a system error during device cleanup.
> 
> To reproduce the issue, simply create a new child device in a
> platform driver of your choice. Add a sysfs file group using
> devm API.

What driver is doing this today?

> On driver exist ensure to unregister your child device.

What child device?  Why is a platform driver creating a child device at
all?

> Do not call devm_device_remove_group() and leave it up to the
> implementation to automatically clean up the files. Here is where
> you will see a kernel error complaining that the files have already
> been removed.
> 
> Signed-off-by: Daniel Steger <daniel.steger@xilinx.com>
> ---
>  fs/sysfs/group.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
> index 64e6a6698935..023b40840f36 100644
> --- a/fs/sysfs/group.c
> +++ b/fs/sysfs/group.c
> @@ -286,9 +286,10 @@ void sysfs_remove_group(struct kobject *kobj,
>  		kernfs_get(kn);
>  	}
>  
> -	remove_files(kn, grp);
> -	if (grp->name)
> +	if (grp->name) {
> +		remove_files(kn, grp);

What about groups without names?  Will then now not be removed properly?
Why does the name matter here?

thanks,

greg k-h
