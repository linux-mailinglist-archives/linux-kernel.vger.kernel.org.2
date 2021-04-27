Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8331836C979
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 18:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237329AbhD0Qaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 12:30:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:56026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236449AbhD0Qae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:30:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D30F661164;
        Tue, 27 Apr 2021 16:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619540991;
        bh=eAWbwyuZVRSrNgRsA7ystpFYMZZBTdD7qW+SbId1/M4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AhJCkWRFdUtl/kfmn5cL5RsC7fOiE7I6oAZYP8S2obw48iHbaEWEjOUfEGEv0SfpQ
         ViaGjD2IkCeZDtnSmv3Fm9iTp9WUxhhvj3OQAJ01WZqoupb2N/hxzadda4Itll6qSu
         FNpQ3pBh7D70vSUoNXKTcyx1UI5Y8iQhxlKaieNA=
Date:   Tue, 27 Apr 2021 18:29:49 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Qiushi Wu <wu000273@umn.edu>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 042/190] Revert "ASoC: fix incomplete error-handling in
 img_i2s_in_probe."
Message-ID: <YIg7/fzC6a1YdLmm@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-43-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-43-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 02:58:37PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit 25bf943e4e7b47282bd86ae7d39e039217ebb007.
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
> Cc: Qiushi Wu <wu000273@umn.edu>
> Cc: https
> Cc: Mark Brown <broonie@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  sound/soc/img/img-i2s-in.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/sound/soc/img/img-i2s-in.c b/sound/soc/img/img-i2s-in.c
> index e30b66b94bf6..a495d1050d49 100644
> --- a/sound/soc/img/img-i2s-in.c
> +++ b/sound/soc/img/img-i2s-in.c
> @@ -482,7 +482,6 @@ static int img_i2s_in_probe(struct platform_device *pdev)
>  	if (IS_ERR(rst)) {
>  		if (PTR_ERR(rst) == -EPROBE_DEFER) {
>  			ret = -EPROBE_DEFER;
> -			pm_runtime_put(&pdev->dev);
>  			goto err_suspend;
>  		}
>  
> -- 
> 2.31.1
> 

Looks correct, dropping.

greg k-h
