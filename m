Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCDE36C9EB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 19:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238011AbhD0RBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 13:01:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:46282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236647AbhD0RAs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 13:00:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 514AA61165;
        Tue, 27 Apr 2021 17:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619542803;
        bh=uW/820nOgA6vr/HbEDoEb84/ezgMtg3O0P9vdlhKkXk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=srib0Xb1p++VfBaEj1wsBcW69R8klwQXc3wpZtTIfgtnNqPUKoBYKxZ/U9KlgZXL5
         Bbn4jaAmbz5fZuelqjjfEmZYxREe3UOpNS7cWHWJkpSmUWLOTay+QMpzEL9jGO5WG+
         r+rJ61ueo4KNbijKFxnBHZRerMU6QCviZ1GILtSM=
Date:   Tue, 27 Apr 2021 19:00:01 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Aditya Pakki <pakki001@umn.edu>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH 175/190] Revert "ipv6/route: Add a missing check on
 proc_dointvec"
Message-ID: <YIhDEacGUekcE1Dx@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-176-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-176-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 03:00:50PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit f0fb9b288d0a7e9cc324ae362e2dfd2cc2217ded.
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
> Cc: Aditya Pakki <pakki001@umn.edu>
> Cc: David S. Miller <davem@davemloft.net>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  net/ipv6/route.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index 373d48073106..0e85741423d7 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -6169,16 +6169,12 @@ static int ipv6_sysctl_rtcache_flush(struct ctl_table *ctl, int write,
>  {
>  	struct net *net;
>  	int delay;
> -	int ret;
>  	if (!write)
>  		return -EINVAL;
>  
>  	net = (struct net *)ctl->extra1;
>  	delay = net->ipv6.sysctl.flush_delay;
> -	ret = proc_dointvec(ctl, write, buffer, lenp, ppos);
> -	if (ret)
> -		return ret;
> -
> +	proc_dointvec(ctl, write, buffer, lenp, ppos);
>  	fib6_run_gc(delay <= 0 ? 0 : (unsigned long)delay, net, delay > 0);
>  	return 0;
>  }
> -- 
> 2.31.1
> 

Original looks correct, dropping this revert.

greg k-h
