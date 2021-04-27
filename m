Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A66A36CACB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 20:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238234AbhD0SD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 14:03:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:33262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230219AbhD0SDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 14:03:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5C7BF613BD;
        Tue, 27 Apr 2021 18:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619546558;
        bh=aMurAj7JN3YRMgPSgw5O66t/kwQi1HMqtywDqU3E44k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wN50moHG7/7B9tKdIrN9g/yL3MholviTusyYZ6z1x9oQiBEWMCYK1/EhU/6YTKqdH
         +/ZQ4e35Qmob6BSs7fBCICVEHNYn5K3WNQCPraCtieIcapCqSnBGiuY1gqJhCayWL/
         rVWQC5e0ohZpw2HIA3Dsfdn8l0PEaqxxxeMdh/Xc=
Date:   Tue, 27 Apr 2021 20:02:36 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>, Ursula Braun <ubraun@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH 090/190] Revert "net/smc: fix a NULL pointer dereference"
Message-ID: <YIhRvIbPszzavEUU@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-91-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-91-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 02:59:25PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit e183d4e414b64711baf7a04e214b61969ca08dfa.
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
> Cc: Ursula Braun <ubraun@linux.ibm.com>
> Cc: David S. Miller <davem@davemloft.net>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  net/smc/smc_ism.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
> index 9c6e95882553..6558cf7643a7 100644
> --- a/net/smc/smc_ism.c
> +++ b/net/smc/smc_ism.c
> @@ -417,11 +417,6 @@ struct smcd_dev *smcd_alloc_dev(struct device *parent, const char *name,
>  	init_waitqueue_head(&smcd->lgrs_deleted);
>  	smcd->event_wq = alloc_ordered_workqueue("ism_evt_wq-%s)",
>  						 WQ_MEM_RECLAIM, name);
> -	if (!smcd->event_wq) {
> -		kfree(smcd->conn);
> -		kfree(smcd);
> -		return NULL;
> -	}
>  	return smcd;
>  }
>  EXPORT_SYMBOL_GPL(smcd_alloc_dev);
> -- 
> 2.31.1
> 

The original is incorrect and causes a memory leak.  I will keep this
revert and fix it up properly with a follow-on patch.

thanks,

greg k-h
