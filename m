Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22BE036D1C7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 07:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbhD1Fjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 01:39:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:54638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229639AbhD1Fjp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 01:39:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B9DFA6141E;
        Wed, 28 Apr 2021 05:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619588337;
        bh=dE3JHheqpzu0M4uVBE2XWAmvbHnX6vL8crhqJ1/UoXg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G7wW/YsI9pOEdMNa5EmGtdNRks9EgQbFQSbKnhKv4pyozfjiMpeSFDbWHq7rsEvxr
         vgSDb4BbyQWrs+AnhN/DmJkgLNZAfMmD3+2nFVV8RLDUIfLOzNLk3W6avCEhA3rZWn
         c/iUH1jEVTUePbvHKJeE990X3tbHM9r61hcNTsYw=
Date:   Wed, 28 Apr 2021 07:38:54 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>, "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH 125/190] Revert "net: tipc: fix a missing check of
 nla_nest_start"
Message-ID: <YIj07o8cprfikoHR@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-126-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-126-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 03:00:00PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit 4589e28db46ee4961edfd794c5bb43887d38c8e5.
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
>  net/tipc/group.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/net/tipc/group.c b/net/tipc/group.c
> index 3e137d8c9d2f..d18d497af4de 100644
> --- a/net/tipc/group.c
> +++ b/net/tipc/group.c
> @@ -927,9 +927,6 @@ int tipc_group_fill_sock_diag(struct tipc_group *grp, struct sk_buff *skb)
>  {
>  	struct nlattr *group = nla_nest_start_noflag(skb, TIPC_NLA_SOCK_GROUP);
>  
> -	if (!group)
> -		return -EMSGSIZE;
> -
>  	if (nla_put_u32(skb, TIPC_NLA_SOCK_GROUP_ID,
>  			grp->type) ||
>  	    nla_put_u32(skb, TIPC_NLA_SOCK_GROUP_INSTANCE,
> -- 
> 2.31.1
> 

The original commit here was fine, I'll drop this revert.

greg k-h
