Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC0A367402
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 22:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242586AbhDUULZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 16:11:25 -0400
Received: from namei.org ([65.99.196.166]:48288 "EHLO mail.namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235029AbhDUULY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 16:11:24 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.namei.org (Postfix) with ESMTPS id 5266E1474;
        Wed, 21 Apr 2021 20:06:59 +0000 (UTC)
Date:   Thu, 22 Apr 2021 06:06:59 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     linux-kernel@vger.kernel.org, Wenwen Wang <wang6495@umn.edu>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH 190/190] Revert "ethtool: fix a potential missing-check
 bug"
In-Reply-To: <20210421130105.1226686-191-gregkh@linuxfoundation.org>
Message-ID: <bb8f7b4-ac22-b062-4c59-928513cad0f4@namei.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org> <20210421130105.1226686-191-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Apr 2021, Greg Kroah-Hartman wrote:

> This reverts commit d656fe49e33df48ee6bc19e871f5862f49895c9e.
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
> Cc: David S. Miller <davem@davemloft.net>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

The original patch looks valid and fixes a race. 


Reviewed-by: James Morris <jamorris@linux.microsoft.com>


> ---
>  net/ethtool/ioctl.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
> index 807bc9465add..542f2428014c 100644
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
>  	if (info.cmd == ETHTOOL_GRXCLSRLALL) {
> -- 
> 2.31.1
> 

-- 
James Morris
<jmorris@namei.org>

