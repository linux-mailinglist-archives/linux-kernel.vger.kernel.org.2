Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E73F036C7C9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 16:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236530AbhD0Occ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 10:32:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:44250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236173AbhD0Oc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 10:32:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C050A60720;
        Tue, 27 Apr 2021 14:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619533906;
        bh=vZ1/911jgQ3lqn2d8fMlTjjDhnzIR8UaVItg8HZlaTw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gF79Zmxz+FgVmLhXuo9ykyNszANupLwD25wr1s3f/MfrWCCLv7yTx8L4lQMsBgvrz
         dWds7zEm1cNUQrw2SayJq64YNounAy5haQtCOaHeF+rRTqQrCZth4kLcYcn67nnJLQ
         fo5Vh9RZmUy5LuK+hW4OPfSPVGumtukc2E+G3zto=
Date:   Tue, 27 Apr 2021 16:31:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>, "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH 139/190] Revert "isdn: mISDNinfineon: fix potential NULL
 pointer dereference"
Message-ID: <YIggUIpgRFUbuQXM@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-140-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-140-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 03:00:14PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit d721fe99f6ada070ae8fc0ec3e01ce5a42def0d9.
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
> Cc: David S. Miller <davem@davemloft.net>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/isdn/hardware/mISDN/mISDNinfineon.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/isdn/hardware/mISDN/mISDNinfineon.c b/drivers/isdn/hardware/mISDN/mISDNinfineon.c
> index a16c7a2a7f3d..fa9c491f9c38 100644
> --- a/drivers/isdn/hardware/mISDN/mISDNinfineon.c
> +++ b/drivers/isdn/hardware/mISDN/mISDNinfineon.c
> @@ -697,11 +697,8 @@ setup_io(struct inf_hw *hw)
>  				(ulong)hw->addr.start, (ulong)hw->addr.size);
>  			return err;
>  		}
> -		if (hw->ci->addr_mode == AM_MEMIO) {
> +		if (hw->ci->addr_mode == AM_MEMIO)
>  			hw->addr.p = ioremap(hw->addr.start, hw->addr.size);
> -			if (unlikely(!hw->addr.p))
> -				return -ENOMEM;
> -		}
>  		hw->addr.mode = hw->ci->addr_mode;
>  		if (debug & DEBUG_HW)
>  			pr_notice("%s: IO addr %lx (%lu bytes) mode%d\n",
> -- 
> 2.31.1
> 

This commit is wrong, so I will keep the revert.  It should never have
used "unlikely()" and if it ever does trigger, resources are left
grabbed.

Given there are no users for this code around, I'll just revert this and
leave it "as is" as the odds that ioremap() will ever fail here is
horrendiously low.

thanks,

greg k-h
