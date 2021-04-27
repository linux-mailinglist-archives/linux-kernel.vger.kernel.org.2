Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CADF36C9D7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 18:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237702AbhD0Q5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 12:57:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:43550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237928AbhD0Q5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:57:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4CA2D61026;
        Tue, 27 Apr 2021 16:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619542617;
        bh=CtQkbacxtNcZEAEFulRLv7kO9okSffwvgKae5i4McZI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KWTyXLo8ZPShbNJh1KEOpwzrj/b0pLO477G+6qQxka0YCjzdfIkR0thZ/+ymLSFql
         qXCg/JiMaCicZnymt+2RX4sYy9Hj4H6N82K+bfe5GzRwmfsV4IX9xx/91iWCgkyZ7B
         HEvWbFOcEjZZii4EaIGmBn6+QjYElEgX/w8BilpQ=
Date:   Tue, 27 Apr 2021 18:56:55 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Wenwen Wang <wang6495@umn.edu>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH 185/190] Revert "net: cxgb3_main: fix a missing-check bug"
Message-ID: <YIhCV9zg2OgW0kN3@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-186-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-186-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 03:01:00PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit 2c05d88818ab6571816b93edce4d53703870d7ae.
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
> Cc: David S. Miller <davem@davemloft.net>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c | 17 -----------------
>  1 file changed, 17 deletions(-)
> 
> diff --git a/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c b/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
> index 84ad7261e243..cc6314aa0154 100644
> --- a/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
> +++ b/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
> @@ -2157,8 +2157,6 @@ static int cxgb_extension_ioctl(struct net_device *dev, void __user *useraddr)
>  			return -EPERM;
>  		if (copy_from_user(&t, useraddr, sizeof(t)))
>  			return -EFAULT;
> -		if (t.cmd != CHELSIO_SET_QSET_PARAMS)
> -			return -EINVAL;
>  		if (t.qset_idx >= SGE_QSETS)
>  			return -EINVAL;
>  		if (!in_range(t.intr_lat, 0, M_NEWTIMER) ||
> @@ -2258,9 +2256,6 @@ static int cxgb_extension_ioctl(struct net_device *dev, void __user *useraddr)
>  		if (copy_from_user(&t, useraddr, sizeof(t)))
>  			return -EFAULT;
>  
> -		if (t.cmd != CHELSIO_GET_QSET_PARAMS)
> -			return -EINVAL;
> -
>  		/* Display qsets for all ports when offload enabled */
>  		if (test_bit(OFFLOAD_DEVMAP_BIT, &adapter->open_device_map)) {
>  			q1 = 0;
> @@ -2306,8 +2301,6 @@ static int cxgb_extension_ioctl(struct net_device *dev, void __user *useraddr)
>  			return -EBUSY;
>  		if (copy_from_user(&edata, useraddr, sizeof(edata)))
>  			return -EFAULT;
> -		if (edata.cmd != CHELSIO_SET_QSET_NUM)
> -			return -EINVAL;
>  		if (edata.val < 1 ||
>  			(edata.val > 1 && !(adapter->flags & USING_MSIX)))
>  			return -EINVAL;
> @@ -2348,8 +2341,6 @@ static int cxgb_extension_ioctl(struct net_device *dev, void __user *useraddr)
>  			return -EPERM;
>  		if (copy_from_user(&t, useraddr, sizeof(t)))
>  			return -EFAULT;
> -		if (t.cmd != CHELSIO_LOAD_FW)
> -			return -EINVAL;
>  		/* Check t.len sanity ? */
>  		fw_data = memdup_user(useraddr + sizeof(t), t.len);
>  		if (IS_ERR(fw_data))
> @@ -2373,8 +2364,6 @@ static int cxgb_extension_ioctl(struct net_device *dev, void __user *useraddr)
>  			return -EBUSY;
>  		if (copy_from_user(&m, useraddr, sizeof(m)))
>  			return -EFAULT;
> -		if (m.cmd != CHELSIO_SETMTUTAB)
> -			return -EINVAL;
>  		if (m.nmtus != NMTUS)
>  			return -EINVAL;
>  		if (m.mtus[0] < 81)	/* accommodate SACK */
> @@ -2416,8 +2405,6 @@ static int cxgb_extension_ioctl(struct net_device *dev, void __user *useraddr)
>  			return -EBUSY;
>  		if (copy_from_user(&m, useraddr, sizeof(m)))
>  			return -EFAULT;
> -		if (m.cmd != CHELSIO_SET_PM)
> -			return -EINVAL;
>  		if (!is_power_of_2(m.rx_pg_sz) ||
>  			!is_power_of_2(m.tx_pg_sz))
>  			return -EINVAL;	/* not power of 2 */
> @@ -2453,8 +2440,6 @@ static int cxgb_extension_ioctl(struct net_device *dev, void __user *useraddr)
>  			return -EIO;	/* need the memory controllers */
>  		if (copy_from_user(&t, useraddr, sizeof(t)))
>  			return -EFAULT;
> -		if (t.cmd != CHELSIO_GET_MEM)
> -			return -EINVAL;
>  		if ((t.addr & 7) || (t.len & 7))
>  			return -EINVAL;
>  		if (t.mem_id == MEM_CM)
> @@ -2507,8 +2492,6 @@ static int cxgb_extension_ioctl(struct net_device *dev, void __user *useraddr)
>  			return -EAGAIN;
>  		if (copy_from_user(&t, useraddr, sizeof(t)))
>  			return -EFAULT;
> -		if (t.cmd != CHELSIO_SET_TRACE_FILTER)
> -			return -EINVAL;
>  
>  		tp = (const struct trace_params *)&t.sip;
>  		if (t.config_tx)
> -- 
> 2.31.1
> 

The original commit looks correct, dropping this revert.

greg k-h
