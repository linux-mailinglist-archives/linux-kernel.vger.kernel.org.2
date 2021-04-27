Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F30936C71A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 15:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236593AbhD0NiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 09:38:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:35658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235875AbhD0NiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 09:38:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BDB6C61006;
        Tue, 27 Apr 2021 13:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619530647;
        bh=Sa0gOSKi+dtbrz1q6obqA2IbpiRme89y1wUFUSEiyZ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=doHs7u/ooXFNW6W3RIpiJzN88uj4wD8GyyMTP4RGXXxY7zqcXp/r4wEYUUn6yU+yV
         8GSxKXUx3CXeAaqdAARVYwmnC5ZiXUJSINf3F0n5G1Hy6ZM5mXtJbo3JysE4b5CS4V
         bia3S1as9VpywRp93FsQQDwssZynECu9/6ldRZxg=
Date:   Tue, 27 Apr 2021 15:37:24 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>, "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH 178/190] Revert "net: netxen: fix a missing check and an
 uninitialized use"
Message-ID: <YIgTlJmdw8MnhTlo@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-179-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-179-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 03:00:53PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit d134e486e831defd26130770181f01dfc6195f7d.
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
>  drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c b/drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c
> index 08f9477d2ee8..32b9e28dda16 100644
> --- a/drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c
> +++ b/drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c
> @@ -1107,8 +1107,7 @@ netxen_validate_firmware(struct netxen_adapter *adapter)
>  		return -EINVAL;
>  	}
>  	val = nx_get_bios_version(adapter);
> -	if (netxen_rom_fast_read(adapter, NX_BIOS_VERSION_OFFSET, (int *)&bios))
> -		return -EIO;
> +	netxen_rom_fast_read(adapter, NX_BIOS_VERSION_OFFSET, (int *)&bios);
>  	if ((__force u32)val != bios) {
>  		dev_err(&pdev->dev, "%s: firmware bios is incompatible\n",
>  				fw_name[fw_type]);
> -- 
> 2.31.1
> 

This change, while messy and could be better, is semi-sane so I'll drop
it from my series.

thanks,

greg k-h
