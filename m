Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 408AF36D1C6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 07:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235901AbhD1Fhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 01:37:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:53220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229624AbhD1Fhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 01:37:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 43EAC610F7;
        Wed, 28 Apr 2021 05:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619588209;
        bh=KLHnbqvrleAFRjOYtz5uhyR8in1guRzkYvwMfNQtME0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zdImTRXy6bryeYaBmd2RL67d+vPH/pgKBNnHMuKFmbjeu1NUZCCs/u010psSSnB/K
         D7iKH4uzUyM8X4UR+bZvXsvpyJkbxhPpdjzPavgIYowXDyVcf/H39JTS2dN36GycJ+
         yoAB2uqrdYfsp3olXigXVlISW8ht8zjTXC55i2CU=
Date:   Wed, 28 Apr 2021 07:36:47 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Aditya Pakki <pakki001@umn.edu>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH 067/190] Revert "net: caif: replace BUG_ON with recovery
 code"
Message-ID: <YIj0b9AFaDY8prNO@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-68-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-68-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 02:59:02PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit c5dea815834c7d2e9fc633785455bc428b7a1956.
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
>  drivers/net/caif/caif_serial.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/net/caif/caif_serial.c b/drivers/net/caif/caif_serial.c
> index 8215cd77301f..4720a7bac4fb 100644
> --- a/drivers/net/caif/caif_serial.c
> +++ b/drivers/net/caif/caif_serial.c
> @@ -269,9 +269,7 @@ static netdev_tx_t caif_xmit(struct sk_buff *skb, struct net_device *dev)
>  {
>  	struct ser_device *ser;
>  
> -	if (WARN_ON(!dev))
> -		return -EINVAL;
> -
> +	BUG_ON(dev == NULL);
>  	ser = netdev_priv(dev);
>  
>  	/* Send flow off once, on high water mark */
> -- 
> 2.31.1
> 

This commit was pointless, the check should just be removed entirely as
it is impossible to hit.  I'll keep the revert and fix it up properly in
a follow-on patch.

thanks,

greg k-h
