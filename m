Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9585836CA6F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 19:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238357AbhD0RgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 13:36:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:43950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236552AbhD0RgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 13:36:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 79946613C0;
        Tue, 27 Apr 2021 17:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619544926;
        bh=St/R/NgBFC3E+s6k8isalj1onhFmupPEuGd6tFnOZCo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2l1nBntZ1ipLUYMSI19gjJusgnAwGqzeSl0OMk4JapHDO5/JQko9CrspcBGBlXjdZ
         YtixNj1I8JedFMjZHcLpLQihG7ir5/M8jm+eADs6yn4KhtZI1uTKP+m5W6OsI6QxoI
         EFLBFrDSvFljGI6gbmWMX5HAi6+VHSRPaeJPTfRM=
Date:   Tue, 27 Apr 2021 19:35:24 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Aditya Pakki <pakki001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 099/190] Revert "omapfb: Fix potential NULL pointer
 dereference in kmalloc"
Message-ID: <YIhLXCVUh+TsmlaT@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-100-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-100-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 02:59:34PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit 31fa6e2ae65feed0de10823c5d1eea21a93086c9.
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
> Cc: Kangjie Lu <kjlu@umn.edu>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/video/fbdev/omap2/omapfb/dss/omapdss-boot-init.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/video/fbdev/omap2/omapfb/dss/omapdss-boot-init.c b/drivers/video/fbdev/omap2/omapfb/dss/omapdss-boot-init.c
> index 0ae0cab252d3..05d87dcbdd8b 100644
> --- a/drivers/video/fbdev/omap2/omapfb/dss/omapdss-boot-init.c
> +++ b/drivers/video/fbdev/omap2/omapfb/dss/omapdss-boot-init.c
> @@ -100,8 +100,6 @@ static void __init omapdss_omapify_node(struct device_node *node)
>  
>  	new_len = prop->length + strlen(prefix) * num_strs;
>  	new_compat = kmalloc(new_len, GFP_KERNEL);
> -	if (!new_compat)
> -		return;
>  
>  	omapdss_prefix_strcpy(new_compat, new_len, prop->value, prop->length);
>  
> -- 
> 2.31.1
> 

Original looks correct, I'll drop this revert.

greg k-h
