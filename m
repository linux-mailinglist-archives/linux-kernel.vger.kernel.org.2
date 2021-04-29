Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6F9636EB9B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 15:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237228AbhD2Nvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 09:51:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:43132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233602AbhD2Nvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 09:51:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E94D26144B;
        Thu, 29 Apr 2021 13:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619704251;
        bh=1pwUJEUEEr4r0+qzy+Jmi6HRPUEqKSnEkhxKAyFFqcQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NFRGvH1gSyB/kHWlCBr7aAxHTpmTrlFgzCpg+Nhpkv7A7RqDvoxzDsFbcCLCXkSOo
         uxGGZVqhZm39ejQBICHAzySZ9jHLa9KnD3ExXP9W+eInk4JV0AmIU/54hL1+ao1sEO
         vzlh6vLur9euh81m+hyyBr9/+0oF2IqZt/3CqC+g=
Date:   Thu, 29 Apr 2021 15:48:45 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Wenwen Wang <wang6495@umn.edu>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH 4/7] Revert "ethtool: fix a potential missing-check bug"
Message-ID: <YIq5PZ9vOKdgcD2R@kroah.com>
References: <20210429130811.3353369-1-gregkh@linuxfoundation.org>
 <20210429130811.3353369-5-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429130811.3353369-5-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 03:08:08PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit d656fe49e33df48ee6bc19e871f5862f49895c9e.
> 
> Commits from @umn.edu addresses have been found to be submitted in "bad
> faith" to try to test the kernel community's ability to review "known
> malicious" changes.  The result of these submissions can be found in a
> paper submitted to the 42nd IEEE Symposium on Security and Privacy
> entitled, "Open Source Insecurity: Stealthily Introducing
> Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> of Minnesota) and Kangjie Lu (University of Minnesota) but later
> withdrawn.
> 
> Because of this, all submissions from this group must be reverted from
> the kernel tree and will need to be re-reviewed again to determine if
> they actually are a valid fix.  Until that work is complete, remove this
> change to ensure that no problems are being introduced into the
> codebase.
> 
> Cc: Wenwen Wang <wang6495@umn.edu>
> Cc: David S. Miller <davem@davemloft.net>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  net/ethtool/ioctl.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
> index 771688e1b0da..34688ebfd74e 100644
> --- a/net/ethtool/ioctl.c
> +++ b/net/ethtool/ioctl.c
> @@ -869,11 +869,6 @@ static noinline_for_stack int ethtool_get_rxnfc(struct net_device *dev,
>  		info_size = sizeof(info);
>  		if (copy_from_user(&info, useraddr, info_size))
>  			return -EFAULT;
> -		/* Since malicious users may modify the original data,
> -		 * we need to check whether FLOW_RSS is still requested.
> -		 */
> -		if (!(info.flow_type & FLOW_RSS))
> -			return -EINVAL;
>  	}
>  
>  	if (info.cmd != cmd)
> -- 
> 2.31.1
> 

This change looks correct, I'll drop the revert from my tree.

thanks,

greg k-h
