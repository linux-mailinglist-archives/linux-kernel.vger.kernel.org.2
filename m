Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55DC036D2C8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 09:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236357AbhD1HJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 03:09:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:58186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230186AbhD1HJS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 03:09:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9653261139;
        Wed, 28 Apr 2021 07:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619593714;
        bh=udDQtmIalh2hlX2z7l9+aH118XrJ003pocPvQQQSRfM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oXB6N1VPShtKlGr+l+j2jULFDaGH6KYrk+b3z2RxMoFd3HSZaqfs+rigM2Y0f/OeI
         U0gdGHiPKIqZw12csKX1Nbc3bIu5O8opZBwlk4i7Yjo2niVu56UXCrCxYdezyG6Ijq
         OfJW7yzJh7B3W+4vUtCl4z8dvENKA2dwj0dLVQC4=
Date:   Wed, 28 Apr 2021 09:08:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>,
        Shannon Nelson <shannon.lee.nelson@gmail.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH 173/190] Revert "niu: fix missing checks of
 niu_pci_eeprom_read"
Message-ID: <YIkJ72Y7KvLdLwYa@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-174-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-174-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 03:00:48PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit 26fd962bde0b15e54234fe762d86bc0349df1de4.
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
> Cc: Shannon Nelson <shannon.lee.nelson@gmail.com>
> Cc: David S. Miller <davem@davemloft.net>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/net/ethernet/sun/niu.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/sun/niu.c b/drivers/net/ethernet/sun/niu.c
> index 707ccdd03b19..d70cdea756d1 100644
> --- a/drivers/net/ethernet/sun/niu.c
> +++ b/drivers/net/ethernet/sun/niu.c
> @@ -8097,8 +8097,6 @@ static int niu_pci_vpd_scan_props(struct niu *np, u32 start, u32 end)
>  		start += 3;
>  
>  		prop_len = niu_pci_eeprom_read(np, start + 4);
> -		if (prop_len < 0)
> -			return prop_len;
>  		err = niu_pci_vpd_get_propname(np, start + 5, namebuf, 64);
>  		if (err < 0)
>  			return err;
> @@ -8143,12 +8141,8 @@ static int niu_pci_vpd_scan_props(struct niu *np, u32 start, u32 end)
>  			netif_printk(np, probe, KERN_DEBUG, np->dev,
>  				     "VPD_SCAN: Reading in property [%s] len[%d]\n",
>  				     namebuf, prop_len);
> -			for (i = 0; i < prop_len; i++) {
> -				err = niu_pci_eeprom_read(np, off + i);
> -				if (err >= 0)
> -					*prop_buf = err;
> -				++prop_buf;
> -			}
> +			for (i = 0; i < prop_len; i++)
> +				*prop_buf++ = niu_pci_eeprom_read(np, off + i);
>  		}
>  
>  		start += len;
> -- 
> 2.31.1
> 

The commit here was incorrect, while it is nice to check if
niu_pci_eeprom_read() succeeded or not when using the data, any error
that might have happened was not propagated upwards properly, causing
the kernel to assume that these reads were successful, which results in
invalid data in the buffer that was to contain the successfully read
data.

I will keep the revert and fix this up properly in a latter submission.

greg k-h
