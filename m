Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3763E36CA89
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 19:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238701AbhD0RoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 13:44:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:49288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238405AbhD0RoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 13:44:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B75E2613DC;
        Tue, 27 Apr 2021 17:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619545410;
        bh=YmtUdF/PDrd72Ow41Ca153ZqTiQqG2GJdZ4ihac78dQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KCF7I+xspnEFGPWWhDoYF92WV4+fobxEjVTZUIexxVfIP3YTJyF8uXn6RseOX3tlg
         JkyAqF9WtmyzKI+CVATwFgVmrVTOyVn3GQ1uG2co2+lKaNsf3ayHibqA5tyIDWp/KW
         zKicFerNpiSSjNjllBdBjM8fhV1sAjdhoz84NQns=
Date:   Tue, 27 Apr 2021 19:43:27 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>, Kalle Valo <kvalo@codeaurora.org>
Subject: Re: [PATCH 141/190] Revert "libertas: add checks for the return
 value of sysfs_create_group"
Message-ID: <YIhNP1RvJzjnLa6e@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-142-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-142-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 03:00:16PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit 434256833d8eb988cb7f3b8a41699e2fe48d9332.
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
> Cc: Kalle Valo <kvalo@codeaurora.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/net/wireless/marvell/libertas/mesh.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/net/wireless/marvell/libertas/mesh.c b/drivers/net/wireless/marvell/libertas/mesh.c
> index f5b78257d551..c611e6668b21 100644
> --- a/drivers/net/wireless/marvell/libertas/mesh.c
> +++ b/drivers/net/wireless/marvell/libertas/mesh.c
> @@ -805,12 +805,7 @@ static void lbs_persist_config_init(struct net_device *dev)
>  {
>  	int ret;
>  	ret = sysfs_create_group(&(dev->dev.kobj), &boot_opts_group);
> -	if (ret)
> -		pr_err("failed to create boot_opts_group.\n");
> -
>  	ret = sysfs_create_group(&(dev->dev.kobj), &mesh_ie_group);
> -	if (ret)
> -		pr_err("failed to create mesh_ie_group.\n");
>  }
>  
>  static void lbs_persist_config_remove(struct net_device *dev)
> -- 
> 2.31.1
> 

The original change here is incorrect, the error needs to be propagated
back to the caller AND if the second group call fails, the first needs
to be removed.  There are much better ways to solve this, the driver
should NOT be calling sysfs_create_group() on its own as it is racing
userspace and loosing.  I will keep this revert and fix it up properly
in a follow-on patch.

thanks,

greg k-h
