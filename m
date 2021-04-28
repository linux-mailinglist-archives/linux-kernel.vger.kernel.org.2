Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16BD436D19F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 07:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbhD1F3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 01:29:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:47984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231743AbhD1F33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 01:29:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1950E613D8;
        Wed, 28 Apr 2021 05:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619587724;
        bh=HSXtdSjpVs4+pGgPIxGWjSSxB9Q8bcsZWdSyQFRCkTQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HmZJsAH3SgeC4ATL/poFgEDEEZ9F82nBzoPwIpVZi0TQLvg4BHu5iHvhPRuQ3+K1C
         jNVNDDizeaAe/ysjW7MFamug2nf3JIcKTV2sLaOEHldJMSCeeECdV9A6ZR+L+Mi+Sx
         l4HmSUQTiA06E4NHUHq7XEjUnmuAH/t56XQy8GFE=
Date:   Wed, 28 Apr 2021 07:28:41 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>, Kalle Valo <kvalo@codeaurora.org>
Subject: Re: [PATCH 096/190] Revert "net: mwifiex: fix a NULL pointer
 dereference"
Message-ID: <YIjyiWam0Zqq1XMZ@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-97-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-97-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 02:59:31PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit e5b9b206f3f6376b9a1406b67eafe4e7bb9f123c.
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
> Cc: Kalle Valo <kvalo@codeaurora.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/net/wireless/marvell/mwifiex/cmdevt.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/net/wireless/marvell/mwifiex/cmdevt.c b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
> index 3a11342a6bde..bda8a236e386 100644
> --- a/drivers/net/wireless/marvell/mwifiex/cmdevt.c
> +++ b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
> @@ -339,12 +339,6 @@ static int mwifiex_dnld_sleep_confirm_cmd(struct mwifiex_adapter *adapter)
>  		sleep_cfm_tmp =
>  			dev_alloc_skb(sizeof(struct mwifiex_opt_sleep_confirm)
>  				      + MWIFIEX_TYPE_LEN);
> -		if (!sleep_cfm_tmp) {
> -			mwifiex_dbg(adapter, ERROR,
> -				    "SLEEP_CFM: dev_alloc_skb failed\n");
> -			return -ENOMEM;
> -		}
> -
>  		skb_put(sleep_cfm_tmp, sizeof(struct mwifiex_opt_sleep_confirm)
>  			+ MWIFIEX_TYPE_LEN);
>  		put_unaligned_le32(MWIFIEX_USB_TYPE_CMD, sleep_cfm_tmp->data);
> -- 
> 2.31.1
> 

This looks fine, I'll drop this revert.

greg k-h
