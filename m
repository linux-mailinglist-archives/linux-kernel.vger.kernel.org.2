Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC41136D1C9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 07:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235802AbhD1Flh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 01:41:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:55898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229639AbhD1Flg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 01:41:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D32646141E;
        Wed, 28 Apr 2021 05:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619588452;
        bh=9Vk5/6QGEU8rtJvRU5BRCyQxbYiFxvD8RijiXEUaGSU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tRA9panG7KUnGQ4s3E4Uwyg6guCiBX0sLPRAHV8p7/qa4UgwILStELTjy3yJj5+bs
         1xkCVCwhcw5HO8azSFWMuFJ6dXym4QfIB3PhuZRI2fjd+4XHhyCGVe8uFK16VHmRyc
         6wLBD396Lsgtzzy3Z0Evke0D4KNdngntZpsJ9T3Q=
Date:   Wed, 28 Apr 2021 07:40:49 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>, "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH 132/190] Revert "net: fujitsu: fix a potential NULL
 pointer dereference"
Message-ID: <YIj1YXJ4S2ux+NNJ@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-133-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-133-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 03:00:07PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit 9f4d6358e11bbc7b839f9419636188e4151fb6e4.
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
>  drivers/net/ethernet/fujitsu/fmvj18x_cs.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/fujitsu/fmvj18x_cs.c b/drivers/net/ethernet/fujitsu/fmvj18x_cs.c
> index a7b7a4aace79..dc90c61fc827 100644
> --- a/drivers/net/ethernet/fujitsu/fmvj18x_cs.c
> +++ b/drivers/net/ethernet/fujitsu/fmvj18x_cs.c
> @@ -547,11 +547,6 @@ static int fmvj18x_get_hwinfo(struct pcmcia_device *link, u_char *node_id)
>  	return -1;
>  
>      base = ioremap(link->resource[2]->start, resource_size(link->resource[2]));
> -    if (!base) {
> -	    pcmcia_release_window(link, link->resource[2]);
> -	    return -ENOMEM;
> -    }
> -
>      pcmcia_map_mem_page(link, link->resource[2], 0);
>  
>      /*
> -- 
> 2.31.1
> 

Original commit looks correct here, I'll drop the revert.

greg k-h
