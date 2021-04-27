Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADBA36C9F4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 19:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238739AbhD0RB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 13:01:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:47170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236627AbhD0RBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 13:01:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CC90C611BE;
        Tue, 27 Apr 2021 17:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619542866;
        bh=S3gUgdJcABjJDvT2NBvgDp0veoEblOH4MylJRtAx4f8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mw+7aw0IDmiwxZQ+1M6EVos1qcvBxrz7Yt7Pog3HewGXCsiUoxpJZpdEeJVl28CUp
         QlwIOsXoQSsxEEeVFHehW3wK1Rwbz9ap9vVl9tl00aMJ7vPkYU9JYsp5i3E/Zg/MC3
         hGxb33a4vGQ8nfE5st/mTYg/ml3f1jCPAPPinXos=
Date:   Tue, 27 Apr 2021 19:01:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Aditya Pakki <pakki001@umn.edu>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH 174/190] Revert "net: chelsio: Add a missing check on
 cudg_get_buffer"
Message-ID: <YIhDUCiM52t1OdY8@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-175-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-175-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 03:00:49PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit ca19fcb6285bfce1601c073bf4b9d2942e2df8d9.
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
>  drivers/net/ethernet/chelsio/cxgb4/cudbg_lib.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/chelsio/cxgb4/cudbg_lib.c b/drivers/net/ethernet/chelsio/cxgb4/cudbg_lib.c
> index 23a2ebdfd503..c7378da78a83 100644
> --- a/drivers/net/ethernet/chelsio/cxgb4/cudbg_lib.c
> +++ b/drivers/net/ethernet/chelsio/cxgb4/cudbg_lib.c
> @@ -1638,10 +1638,6 @@ int cudbg_collect_hw_sched(struct cudbg_init *pdbg_init,
>  
>  	rc = cudbg_get_buff(pdbg_init, dbg_buff, sizeof(struct cudbg_hw_sched),
>  			    &temp_buff);
> -
> -	if (rc)
> -		return rc;
> -
>  	hw_sched_buff = (struct cudbg_hw_sched *)temp_buff.data;
>  	hw_sched_buff->map = t4_read_reg(padap, TP_TX_MOD_QUEUE_REQ_MAP_A);
>  	hw_sched_buff->mode = TIMERMODE_G(t4_read_reg(padap, TP_MOD_CONFIG_A));
> -- 
> 2.31.1
> 

Original looks correct, dropping this revert.

greg k-h
