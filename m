Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21EBF36CA5E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 19:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236579AbhD0Rb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 13:31:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:41348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235593AbhD0Rbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 13:31:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 206A0613E5;
        Tue, 27 Apr 2021 17:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619544668;
        bh=/rQqaMen4CdzB60Rxa/kOLj5DJX3AW+xBuggzpn42zs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hFGxdMN0uYeFwxePEQT/CMAzyaqOIxnFp5LCIbIl2bmX+obM6+y0ZB+275hyV43U9
         MgO7g/tTL85HaVZS/2Z/k4izVarIR4YnYzR7PHy54pxESnaRLM50DGNdIKyiAPYPFZ
         q4EXVkmcA+8ahsVLlE7G22+jmPupou7uQxNxsi2A=
Date:   Tue, 27 Apr 2021 19:31:06 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>, "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH 138/190] Revert "net: liquidio: fix a NULL pointer
 dereference"
Message-ID: <YIhKWhNzv9zIMQJ1@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-139-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-139-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 03:00:13PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit fe543b2f174f34a7a751aa08b334fe6b105c4569.
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
>  drivers/net/ethernet/cavium/liquidio/lio_main.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cavium/liquidio/lio_main.c b/drivers/net/ethernet/cavium/liquidio/lio_main.c
> index 7c5af4beedc6..6fa570068648 100644
> --- a/drivers/net/ethernet/cavium/liquidio/lio_main.c
> +++ b/drivers/net/ethernet/cavium/liquidio/lio_main.c
> @@ -1166,11 +1166,6 @@ static void send_rx_ctrl_cmd(struct lio *lio, int start_stop)
>  	sc = (struct octeon_soft_command *)
>  		octeon_alloc_soft_command(oct, OCTNET_CMD_SIZE,
>  					  16, 0);
> -	if (!sc) {
> -		netif_info(lio, rx_err, lio->netdev,
> -			   "Failed to allocate octeon_soft_command\n");
> -		return;
> -	}
>  
>  	ncmd = (union octnet_cmd *)sc->virtdptr;
>  
> -- 
> 2.31.1
> 

While this does keep the immediate "NULL dereference" from happening, it
does not properly propagate the error back to the callers, AND it does
not fix this same identical issue in the
drivers/net/ethernet/cavium/liquidio/lio_vf_main.c for some reason.  I
will revert this and fix up both files properly in a later on patch.

thanks,

greg k-h
