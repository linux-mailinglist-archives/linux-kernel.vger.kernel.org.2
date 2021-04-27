Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6339036CA7A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 19:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238604AbhD0Rjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 13:39:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:46548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236172AbhD0Rju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 13:39:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D95B5611C1;
        Tue, 27 Apr 2021 17:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619545147;
        bh=PDbravuOdO9syip5pU1yrhdo/z/qPNqCTz4Vb4pPvv8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jlrT+fWUY5/aKi8qT8x0IWB1sW/opIuudCiuM6WPRcRMRWRssh5u9vClEPIo9Wjs6
         dW60wUiVqtOIbSt0xlH5wwtSVcaAnSr0zrVYWIsSmA8gYfXiekwyi9d0YK4mx2DyRP
         8GBxOlV5T/6vZV7Hiwhn1S0R4Us8lVpdtUEOrdtQ=
Date:   Tue, 27 Apr 2021 19:39:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>, Alexandre Bounine <alex.bou9@gmail.com>,
        Matt Porter <mporter@kernel.crashing.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 077/190] Revert "rapidio: fix a NULL pointer dereference
 when create_workqueue() fails"
Message-ID: <YIhMOAn3XxlB5m2m@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-78-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-78-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 02:59:12PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit 23015b22e47c5409620b1726a677d69e5cd032ba.
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
> Cc: Alexandre Bounine <alex.bou9@gmail.com>
> Cc: Matt Porter <mporter@kernel.crashing.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/rapidio/rio_cm.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/rapidio/rio_cm.c b/drivers/rapidio/rio_cm.c
> index 50ec53d67a4c..e6c16f04f2b4 100644
> --- a/drivers/rapidio/rio_cm.c
> +++ b/drivers/rapidio/rio_cm.c
> @@ -2138,14 +2138,6 @@ static int riocm_add_mport(struct device *dev,
>  	mutex_init(&cm->rx_lock);
>  	riocm_rx_fill(cm, RIOCM_RX_RING_SIZE);
>  	cm->rx_wq = create_workqueue(DRV_NAME "/rxq");
> -	if (!cm->rx_wq) {
> -		riocm_error("failed to allocate IBMBOX_%d on %s",
> -			    cmbox, mport->name);
> -		rio_release_outb_mbox(mport, cmbox);
> -		kfree(cm);
> -		return -ENOMEM;
> -	}
> -
>  	INIT_WORK(&cm->rx_work, rio_ibmsg_handler);
>  
>  	cm->tx_slot = 0;
> -- 
> 2.31.1
> 

This patch has a memory leak on the error path here, it does not clean
up everything properly.  So I'll keep the revert and fix it up properly
in a follow-on patch.

thanks,

greg k-h
