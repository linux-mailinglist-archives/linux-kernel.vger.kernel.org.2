Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAA0A36CB0A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 20:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236854AbhD0SVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 14:21:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:42820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230219AbhD0SVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 14:21:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 04D656023B;
        Tue, 27 Apr 2021 18:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619547618;
        bh=AxUanLW4jzPwM3/Z7KtMr5gt0zYahv7afgq0nwvZEsM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZCktBRrRFKlSstUHgMmDnSA9nITEly+EuLrEEo7bzotDU6WBVMHJrvagQSMydJG9s
         wpgnxf1ffm0nGy4WG8UMMB5CqtpwbUhbiTPLV1rQqj8UfAi4JNoRt2gKEoH+m3xrhX
         8H4yv55H/5nAQW+x3G2cIq0+iOekZay0Vt57f6rk=
Date:   Tue, 27 Apr 2021 20:20:15 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>, "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH 135/190] Revert "net: rocker: fix a potential NULL
 pointer dereference"
Message-ID: <YIhV37ufgcw8bpEj@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-136-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-136-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 03:00:10PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit 5c149314d91876f743ee43efd75b6287ec55480e.
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
>  drivers/net/ethernet/rocker/rocker_main.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/rocker/rocker_main.c b/drivers/net/ethernet/rocker/rocker_main.c
> index 3473d296b2e2..a9c654b885de 100644
> --- a/drivers/net/ethernet/rocker/rocker_main.c
> +++ b/drivers/net/ethernet/rocker/rocker_main.c
> @@ -2791,11 +2791,6 @@ static int rocker_switchdev_event(struct notifier_block *unused,
>  		memcpy(&switchdev_work->fdb_info, ptr,
>  		       sizeof(switchdev_work->fdb_info));
>  		switchdev_work->fdb_info.addr = kzalloc(ETH_ALEN, GFP_ATOMIC);
> -		if (unlikely(!switchdev_work->fdb_info.addr)) {
> -			kfree(switchdev_work);
> -			return NOTIFY_BAD;
> -		}
> -
>  		ether_addr_copy((u8 *)switchdev_work->fdb_info.addr,
>  				fdb_info->addr);
>  		/* Take a reference on the rocker device */
> -- 
> 2.31.1
> 

The unlikely() here is not needed at all, but the logic in the cleanup
looks correct so I'll drop this revert.

greg k-h
