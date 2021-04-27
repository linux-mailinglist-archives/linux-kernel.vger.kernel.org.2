Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E78D36C9E0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 18:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238147AbhD0Q7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 12:59:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:44368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236682AbhD0Q6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:58:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6FDB361026;
        Tue, 27 Apr 2021 16:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619542679;
        bh=XXTIRzTyh3ChGseuPedmLI1W2XpKE8yN+5870OP+DHg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nI8iQq8AF/vubwGnqKtGrCUx2gyco2xm6YwMeFaCib/04ryqXgW215+pBpcN78+Y4
         K6mD5vyk6dya2vnvUVKchZQ6yjOP2cTOEW3mPY8yeSElJrkCd3AN+BSp5X6lzNtrd6
         f3xd3so51VeE0eRA7gE0O4Q2JONWPD+GAT19Bqpw=
Date:   Tue, 27 Apr 2021 18:57:57 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Wenwen Wang <wang6495@umn.edu>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH 180/190] Revert "net: socket: fix a missing-check bug"
Message-ID: <YIhClSyv/BKCw619@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-181-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-181-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 03:00:55PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit b6168562c8ce2bd5a30e213021650422e08764dc.
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
> ---
>  net/socket.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/net/socket.c b/net/socket.c
> index 84a8049c2b09..d4176362a27b 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -3182,14 +3182,9 @@ static int ethtool_ioctl(struct net *net, struct compat_ifreq __user *ifr32)
>  		    copy_in_user(&rxnfc->fs.ring_cookie,
>  				 &compat_rxnfc->fs.ring_cookie,
>  				 (void __user *)(&rxnfc->fs.location + 1) -
> -				 (void __user *)&rxnfc->fs.ring_cookie))
> -			return -EFAULT;
> -		if (ethcmd == ETHTOOL_GRXCLSRLALL) {
> -			if (put_user(rule_cnt, &rxnfc->rule_cnt))
> -				return -EFAULT;
> -		} else if (copy_in_user(&rxnfc->rule_cnt,
> -					&compat_rxnfc->rule_cnt,
> -					sizeof(rxnfc->rule_cnt)))
> +				 (void __user *)&rxnfc->fs.ring_cookie) ||
> +		    copy_in_user(&rxnfc->rule_cnt, &compat_rxnfc->rule_cnt,
> +				 sizeof(rxnfc->rule_cnt)))
>  			return -EFAULT;
>  	}
>  
> -- 
> 2.31.1
> 

Original looks correct, dropping this revert.

greg k-h
