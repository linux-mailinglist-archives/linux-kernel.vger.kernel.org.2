Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E77436C804
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 16:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238542AbhD0OxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 10:53:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:57354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237361AbhD0OxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 10:53:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8254161151;
        Tue, 27 Apr 2021 14:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619535137;
        bh=cpt767z6+qTL3qo5n16/WDAiY9yxFJs4A0PdP0zz79U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dIq/1DcC1ajhGOgyH5iyqW7rT4DgCywnQc2nzn19FOJGcwHU2wSAvylO2JFzoWliT
         w4azHg6rcrdaPL5TcTpLrUZ3xiV4xQWRcGdd/ph7SQFQ2Zhv6d7zVatpOiCIW/Jt84
         OQrucKrAynp5cGsfb48LkkZRD/7AEQ7e/fT9/xzQ=
Date:   Tue, 27 Apr 2021 16:52:14 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>, "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH 168/190] Revert "net: marvell: fix a missing check of
 acpi_match_device"
Message-ID: <YIglHlva+jlFmItZ@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-169-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-169-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 03:00:43PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit 92ee77d148bf06d8c52664be4d1b862583fd5c0e.
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
>  drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> index 1767c60056c5..f1a70b37227f 100644
> --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> @@ -7328,8 +7328,6 @@ static int mvpp2_probe(struct platform_device *pdev)
>  	if (has_acpi_companion(&pdev->dev)) {
>  		acpi_id = acpi_match_device(pdev->dev.driver->acpi_match_table,
>  					    &pdev->dev);
> -		if (!acpi_id)
> -			return -EINVAL;
>  		priv->hw_version = (unsigned long)acpi_id->driver_data;
>  	} else {
>  		priv->hw_version =
> -- 
> 2.31.1
> 

The original commit here looks correct, so I'll drop this revert.

greg k-h
