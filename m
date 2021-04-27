Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78A8636C7F0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 16:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238393AbhD0OsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 10:48:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:54272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236144AbhD0OsQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 10:48:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BD1526113D;
        Tue, 27 Apr 2021 14:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619534853;
        bh=cKkLQ95Je/QorK/a/rFq7G7ggV1k4FkpERCQAR3fLbQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m/CgspFo7EeAJ/fv9C9XaqwjtBm6RNaiLXtmTKVnfHTSj6rBsSk3pxdV6/T/731fh
         SO4l19yaGtUhknZC68ZIB34lIwVe91KsjiFRWxXm5sgXAY7BaKveLuaarttQcoAK1j
         j53hv1PqKS4oQnCvGWqPoP3qjPFeFhvdAJ/mIfv4=
Date:   Tue, 27 Apr 2021 16:47:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Aditya Pakki <pakki001@umn.edu>, Sinan Kaya <okaya@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH 162/190] Revert "dmaengine: qcom_hidma: Check for driver
 register failure"
Message-ID: <YIgkAw8UVh4F6tQB@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-163-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-163-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 03:00:37PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit a474b3f0428d6b02a538aa10b3c3b722751cb382.
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
> Cc: Sinan Kaya <okaya@kernel.org>
> Cc: Vinod Koul <vkoul@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/dma/qcom/hidma_mgmt.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/qcom/hidma_mgmt.c b/drivers/dma/qcom/hidma_mgmt.c
> index 806ca02c52d7..fe87b01f7a4e 100644
> --- a/drivers/dma/qcom/hidma_mgmt.c
> +++ b/drivers/dma/qcom/hidma_mgmt.c
> @@ -418,8 +418,9 @@ static int __init hidma_mgmt_init(void)
>  		hidma_mgmt_of_populate_channels(child);
>  	}
>  #endif
> -	return platform_driver_register(&hidma_mgmt_driver);
> +	platform_driver_register(&hidma_mgmt_driver);
>  
> +	return 0;
>  }
>  module_init(hidma_mgmt_init);
>  MODULE_LICENSE("GPL v2");
> -- 
> 2.31.1
> 

The original change is NOT correct, as it does not correctly unwind from
the resources that was allocated before the call to
platform_driver_register().

As platform_driver_register() should never really fail here, I'll just
revert this patch and maybe someone, if they care about this driver, can
unwind the mess here.  Given that this driver doesn't look to ever be
able to be unloaded from the system, failing the init call does not look
to be a wise idea.

thanks,

greg k-h
