Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC50236EBA5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 15:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237915AbhD2NzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 09:55:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:44016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233862AbhD2NzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 09:55:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 344F861407;
        Thu, 29 Apr 2021 13:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619704458;
        bh=y/KSgaD2/mqGMlekuhyd5x478LgNEJTau9K+E8yRMlY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SfYs0JlfAyjPspN8DJlYf1seeCx45i8MoX8QD7xYEL9Vi8Fvdz5rnpIBpref/AQSJ
         5jVuVicHwjQIYXHDtQrySVwEDqugFUZ00qIWeJD2Zo2o2B+TLmIkrsgga+2JShOWyO
         1k9nU+ZZa9RS6Y7B5MzYNSm2FgrgsNT4cQS2B3GQ=
Date:   Thu, 29 Apr 2021 15:54:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Aditya Pakki <pakki001@umn.edu>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH 1/7] Revert "rocker: fix incorrect error handling in
 dma_rings_init"
Message-ID: <YIq6iA+C1gdfopYj@kroah.com>
References: <20210429130811.3353369-1-gregkh@linuxfoundation.org>
 <20210429130811.3353369-2-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429130811.3353369-2-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 03:08:05PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit 58d0c864e1a759a15c9df78f50ea5a5c32b3989e.
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
> Cc: Aditya Pakki <pakki001@umn.edu>
> Cc: David S. Miller <davem@davemloft.net>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/net/ethernet/rocker/rocker_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/rocker/rocker_main.c b/drivers/net/ethernet/rocker/rocker_main.c
> index 3473d296b2e2..35ebeeb40639 100644
> --- a/drivers/net/ethernet/rocker/rocker_main.c
> +++ b/drivers/net/ethernet/rocker/rocker_main.c
> @@ -650,10 +650,10 @@ static int rocker_dma_rings_init(struct rocker *rocker)
>  err_dma_event_ring_bufs_alloc:
>  	rocker_dma_ring_destroy(rocker, &rocker->event_ring);
>  err_dma_event_ring_create:
> -	rocker_dma_cmd_ring_waits_free(rocker);
> -err_dma_cmd_ring_waits_alloc:
>  	rocker_dma_ring_bufs_free(rocker, &rocker->cmd_ring,
>  				  DMA_BIDIRECTIONAL);
> +err_dma_cmd_ring_waits_alloc:
> +	rocker_dma_cmd_ring_waits_free(rocker);
>  err_dma_cmd_ring_bufs_alloc:
>  	rocker_dma_ring_destroy(rocker, &rocker->cmd_ring);
>  	return err;
> -- 
> 2.31.1
> 

The original commit here looks correct to me, so unless someone objects,
I'll drop this revert from my tree.

thanks,

greg k-h
