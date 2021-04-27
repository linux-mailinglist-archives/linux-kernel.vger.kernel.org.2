Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCF1836CA3F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 19:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237575AbhD0RVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 13:21:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:34858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235777AbhD0RVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 13:21:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1BA2F61029;
        Tue, 27 Apr 2021 17:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619544057;
        bh=ocI7AJdQZiPwhUJaTOIZn+lAMvM9WqZfZa/g3uY8/N4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FS1ci3LA+t+6DYgmTQo2iGrfpU9EzHRY88ilVYnycI2oFZ+g/Bb2mn6QSbcWni5Hu
         9yHh6efa8owC7m2siWzT9OM8MBGAjGzrd62n/RtFd+kNnfktXoBpsOz+MqNLLsDx39
         Mn0P9STFHmhY9TD3XF2NVqk5Cs4JY29L/qykhZBY=
Date:   Tue, 27 Apr 2021 19:20:55 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Hannes Reinecke <hare@suse.de>, Aditya Pakki <pakki001@umn.edu>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 062/190] Revert "scsi: libfc: remove unnecessary
 assertion on ep variable"
Message-ID: <YIhH9xo5cpv5ha0y@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-63-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-63-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 02:58:57PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit 52b894393cecdc303990e834778d39b85d0553fc.
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
> Cc: https
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Aditya Pakki <pakki001@umn.edu>
> Cc: Martin K. Petersen <martin.petersen@oracle.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/target/tcm_fc/tfc_io.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/target/tcm_fc/tfc_io.c b/drivers/target/tcm_fc/tfc_io.c
> index bbe2e29612fa..15d557a11f63 100644
> --- a/drivers/target/tcm_fc/tfc_io.c
> +++ b/drivers/target/tcm_fc/tfc_io.c
> @@ -220,6 +220,7 @@ void ft_recv_write_data(struct ft_cmd *cmd, struct fc_frame *fp)
>  	ep = fc_seq_exch(seq);
>  	lport = ep->lp;
>  	if (cmd->was_ddp_setup) {
> +		BUG_ON(!ep);
>  		BUG_ON(!lport);
>  		/*
>  		 * Since DDP (Large Rx offload) was setup for this request,
> -- 
> 2.31.1
> 

The original was obviously correct, so I'll drop this revert.

thanks,

greg k-h
