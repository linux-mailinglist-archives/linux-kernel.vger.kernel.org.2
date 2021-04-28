Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9294936D1A0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 07:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234377AbhD1Fah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 01:30:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:48618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229643AbhD1Faf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 01:30:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6FE8561422;
        Wed, 28 Apr 2021 05:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619587791;
        bh=MJh2gUzOq6Nhe7eUp+1l2NVKUt9LSn356RNBVf6pmn4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ARC3aGBdIM3EQpbc5z4X+909sIVfEZzPZRsRHTcpqNvBv+e7zFdMgPK4F74OV6RLL
         XpkvF16ceHaxNU5/3ddKxZ1SpZ/pI+sEIvzwvGJOutUUDqlptiB6mZJxsPR1Ex1aia
         75iR5/hqYYYD5kENA0P2ec7Jw5KkZWZzM/Y+ELyw=
Date:   Wed, 28 Apr 2021 07:29:48 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Aditya Pakki <pakki001@umn.edu>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH 072/190] Revert "net: atm: Reduce the severity of logging
 in unlink_clip_vcc"
Message-ID: <YIjyzCHeBEwQjPYj@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-73-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-73-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 02:59:07PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit 60f5c4aaae452ae9252128ef7f9ae222aa70c569.
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
>  net/atm/clip.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/net/atm/clip.c b/net/atm/clip.c
> index 294cb9efe3d3..a7972da7235d 100644
> --- a/net/atm/clip.c
> +++ b/net/atm/clip.c
> @@ -89,7 +89,7 @@ static void unlink_clip_vcc(struct clip_vcc *clip_vcc)
>  	struct clip_vcc **walk;
>  
>  	if (!entry) {
> -		pr_err("!clip_vcc->entry (clip_vcc %p)\n", clip_vcc);
> +		pr_crit("!clip_vcc->entry (clip_vcc %p)\n", clip_vcc);
>  		return;
>  	}
>  	netif_tx_lock_bh(entry->neigh->dev);	/* block clip_start_xmit() */
> @@ -109,10 +109,10 @@ static void unlink_clip_vcc(struct clip_vcc *clip_vcc)
>  			error = neigh_update(entry->neigh, NULL, NUD_NONE,
>  					     NEIGH_UPDATE_F_ADMIN, 0);
>  			if (error)
> -				pr_err("neigh_update failed with %d\n", error);
> +				pr_crit("neigh_update failed with %d\n", error);
>  			goto out;
>  		}
> -	pr_err("ATMARP: failed (entry %p, vcc 0x%p)\n", entry, clip_vcc);
> +	pr_crit("ATMARP: failed (entry %p, vcc 0x%p)\n", entry, clip_vcc);
>  out:
>  	netif_tx_unlock_bh(entry->neigh->dev);
>  }
> -- 
> 2.31.1
> 

The original here was pointless, but did not cause a problem, so I'll
drop this revert.

greg k-h
