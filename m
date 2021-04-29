Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21E6A36EB9F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 15:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237832AbhD2NxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 09:53:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:43444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234147AbhD2NxC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 09:53:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0D70F61107;
        Thu, 29 Apr 2021 13:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619704334;
        bh=BLkm7FxPcrs2A5cvv+VrvrXuUBdRYNu8fzHF0nnt8PY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F6ioZ8bjRoL8CEdayr/h5QWpwEqIPFoCAuBPbGcy1ryb/zKc8YPZMuZRC6ihO3a/k
         iG/Ryug8Z0oR4REj1RVCRuJ7RizI61JE6QHBZ82qZnfA2v6uQTzGb4GgeVxOoUsndR
         oIUKdjcqa00InAPqnBUHvbefr8yv97GmgMjM5/bQ=
Date:   Thu, 29 Apr 2021 15:52:12 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Qiushi Wu <wu000273@umn.edu>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH 2/7] Revert "rtc: mc13xxx: fix a double-unlock issue"
Message-ID: <YIq6DAb3drmrseJD@kroah.com>
References: <20210429130811.3353369-1-gregkh@linuxfoundation.org>
 <20210429130811.3353369-3-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429130811.3353369-3-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 03:08:06PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit 8816cd726a4fee197af2d851cbe25991ae19ea14.
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
> Cc: Qiushi Wu <wu000273@umn.edu>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/rtc/rtc-mc13xxx.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-mc13xxx.c b/drivers/rtc/rtc-mc13xxx.c
> index d4234e78497e..0921ca792847 100644
> --- a/drivers/rtc/rtc-mc13xxx.c
> +++ b/drivers/rtc/rtc-mc13xxx.c
> @@ -308,10 +308,8 @@ static int __init mc13xxx_rtc_probe(struct platform_device *pdev)
>  	mc13xxx_unlock(mc13xxx);
>  
>  	ret = devm_rtc_register_device(priv->rtc);
> -	if (ret) {
> -		mc13xxx_lock(mc13xxx);
> +	if (ret)
>  		goto err_irq_request;
> -	}
>  
>  	return 0;
>  
> -- 
> 2.31.1
> 

The original change here looks correct to me, I'll drop this revert from
my tree.

thanks,

greg k-h
