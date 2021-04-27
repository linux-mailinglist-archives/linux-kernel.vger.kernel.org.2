Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77BA236C6DF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 15:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236210AbhD0NRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 09:17:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:51654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235489AbhD0NRk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 09:17:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 36E1D60C3D;
        Tue, 27 Apr 2021 13:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619529416;
        bh=peNgo+yuiIkO1SN5wDs3JOHrcrGy/ZYty01XP1BJVdY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HuYN+NG+xhETIpwjRaPV5tpXfgRXNfGHKIDEAoAgv9PTgEsJ2sdnaCA828LDBl6X/
         BYtkxlv206bgtxpZuDXfsY4lPXcoxCIJaqLL1At2K5oIrPKtzmiGdnC9bf+XFSLftx
         9QV9hLyPMjDkbNuB+dm3Mm9PXRVHB++PoNJI/Qi0=
Date:   Tue, 27 Apr 2021 15:16:54 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Wenwen Wang <wang6495@umn.edu>, Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH 183/190] Revert "media: isif: fix a NULL pointer
 dereference bug"
Message-ID: <YIgOxtlRDsJD/ZwR@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-184-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-184-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 03:00:58PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit a26ac6c1bed951b2066cc4b2257facd919e35c0b.
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
> Cc: Hans Verkuil <hverkuil@xs4all.nl>
> Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/media/platform/davinci/isif.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/davinci/isif.c b/drivers/media/platform/davinci/isif.c
> index c53cecd072b1..5355a14c090b 100644
> --- a/drivers/media/platform/davinci/isif.c
> +++ b/drivers/media/platform/davinci/isif.c
> @@ -1086,8 +1086,7 @@ static int isif_probe(struct platform_device *pdev)
>  
>  	while (i >= 0) {
>  		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
> -		if (res)
> -			release_mem_region(res->start, resource_size(res));
> +		release_mem_region(res->start, resource_size(res));
>  		i--;
>  	}
>  	vpfe_unregister_ccdc_device(&isif_hw_dev);
> -- 
> 2.31.1
> 

This looks correct, dropping it.

greg k-h
