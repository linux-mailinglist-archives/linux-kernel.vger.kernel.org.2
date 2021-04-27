Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3B6F36CA12
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 19:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236611AbhD0RJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 13:09:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:52772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236030AbhD0RJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 13:09:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5A894613D0;
        Tue, 27 Apr 2021 17:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619543307;
        bh=z5l0Ap7tYFWvNSbJC70dTHA0dhNT8U2X3UyK31gw0Xs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JHRvrp9/IL+WgsTnaD0Dgv/aO6r2V67IdeGJpVAnsVQ1mdYVbALVGMtCYrQFUuHHM
         sOEtS5cFsSPELWGd476LF10CR0PIWVLvEWC2MNjUm0qhpKFJVEe17u1dHYbNsUsI9M
         6KNUhGtndfr3pX/8CVzj3pDxfn4g6/Lvga+rFrgM=
Date:   Tue, 27 Apr 2021 19:08:25 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Aditya Pakki <pakki001@umn.edu>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH 129/190] Revert "qlcnic: Avoid potential NULL pointer
 dereference"
Message-ID: <YIhFCfs0jIRMRgdr@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-130-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-130-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 03:00:04PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit 5bf7295fe34a5251b1d241b9736af4697b590670.
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
> Cc: David S. Miller <davem@davemloft.net>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/net/ethernet/qlogic/qlcnic/qlcnic_ethtool.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_ethtool.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_ethtool.c
> index d8a3ecaed3fc..985cf8cb2ec0 100644
> --- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_ethtool.c
> +++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_ethtool.c
> @@ -1047,8 +1047,6 @@ int qlcnic_do_lb_test(struct qlcnic_adapter *adapter, u8 mode)
>  
>  	for (i = 0; i < QLCNIC_NUM_ILB_PKT; i++) {
>  		skb = netdev_alloc_skb(adapter->netdev, QLCNIC_ILB_PKT_SIZE);
> -		if (!skb)
> -			break;
>  		qlcnic_create_loopback_buff(skb->data, adapter->mac_addr);
>  		skb_put(skb, QLCNIC_ILB_PKT_SIZE);
>  		adapter->ahw->diag_cnt = 0;
> -- 
> 2.31.1
> 

This commit does not properly detect if an error happens because the
logic after this loop will not detect that there was a failed
allocation.  I will keep this revert and fix it up properly later.

thanks,

greg k-h
