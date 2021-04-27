Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16D7236CB0F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 20:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238665AbhD0SWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 14:22:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:43806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235647AbhD0SWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 14:22:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0C7E6610A5;
        Tue, 27 Apr 2021 18:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619547711;
        bh=W/lR0B3B/jG31hu8CSs1S2F5UKwfxbYKEgGBGRZCgH0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CQtTtNzSBNbGTcAG+wzKWNkFEEJ+bDwqDIxlhxkNul6Cdge21LkceU1QTa17ufT8H
         cXXNHowXH85yDMqrVfqgO4ijCTh8zbLaehcebsnMq+hAoBnBzcgeNBG8BiLskM7W06
         pF/pVVHuQE4mgV3KrJGlG672SzxUxa8DlKOnVsm8=
Date:   Tue, 27 Apr 2021 20:21:49 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>, "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH 133/190] Revert "net: qlogic: fix a potential NULL
 pointer dereference"
Message-ID: <YIhWPUJgRoh7ENjU@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-134-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-134-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 03:00:08PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit eb32cfcdef2305dc0e44a65d42801315669bb27e.
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
>  drivers/net/ethernet/qlogic/qla3xxx.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/qlogic/qla3xxx.c b/drivers/net/ethernet/qlogic/qla3xxx.c
> index 214e347097a7..50dbb8205e6c 100644
> --- a/drivers/net/ethernet/qlogic/qla3xxx.c
> +++ b/drivers/net/ethernet/qlogic/qla3xxx.c
> @@ -3863,12 +3863,6 @@ static int ql3xxx_probe(struct pci_dev *pdev,
>  	netif_stop_queue(ndev);
>  
>  	qdev->workqueue = create_singlethread_workqueue(ndev->name);
> -	if (!qdev->workqueue) {
> -		unregister_netdev(ndev);
> -		err = -ENOMEM;
> -		goto err_out_iounmap;
> -	}
> -
>  	INIT_DELAYED_WORK(&qdev->reset_work, ql_reset_work);
>  	INIT_DELAYED_WORK(&qdev->tx_timeout_work, ql_tx_timeout_work);
>  	INIT_DELAYED_WORK(&qdev->link_state_work, ql_link_state_machine_work);
> -- 
> 2.31.1
> 

Ideally you would have added a new goto tag and put the
unregister_netdev() call in that, but the logic here still seems to be
correct, so I'll drop this revert.

greg k-h
