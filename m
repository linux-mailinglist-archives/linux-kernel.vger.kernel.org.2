Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1755936CA7D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 19:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236751AbhD0Rlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 13:41:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:47584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230219AbhD0Rlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 13:41:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9D7D2613BD;
        Tue, 27 Apr 2021 17:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619545252;
        bh=Z3ligqwMjFuZ1rj6LFyFuY1wIbftuLNCLPVyKusPrWY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=liLprFzDXrPO026jZqlm+R+GzQLI4HJOMt9HWN/Yl4VqYJh7YGukQSJlS+1Jd49Iu
         rTWyVPKRIXB1g+vV2a8Fgk5D/cFiudivVRAAxbD1zoyw3UvD/qzCpAmoqUZwvRjMMp
         3smS80KU8WZ3iIgFTgyFrKvKgK4VEUW6mKvuVoyw=
Date:   Tue, 27 Apr 2021 19:40:49 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Aditya Pakki <pakki001@umn.edu>
Subject: Re: [PATCH 160/190] Revert "Staging: rts5208: Fix error handling on
 rtsx_send_cmd"
Message-ID: <YIhMoRY2tFx3nym5@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-161-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-161-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 03:00:35PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit c8c2702409430a6a2fd928e857f15773aaafcc99.
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
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/staging/rts5208/sd.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/rts5208/sd.c b/drivers/staging/rts5208/sd.c
> index 25c31496757e..63f5465a6eeb 100644
> --- a/drivers/staging/rts5208/sd.c
> +++ b/drivers/staging/rts5208/sd.c
> @@ -4424,12 +4424,7 @@ int sd_execute_write_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
>  		rtsx_init_cmd(chip);
>  		rtsx_add_cmd(chip, CHECK_REG_CMD, 0xFD30, 0x02, 0x02);
>  
> -		retval = rtsx_send_cmd(chip, SD_CARD, 250);
> -		if (retval < 0) {
> -			write_err = true;
> -			rtsx_clear_sd_error(chip);
> -			goto sd_execute_write_cmd_failed;
> -		}
> +		rtsx_send_cmd(chip, SD_CARD, 250);
>  
>  		retval = sd_update_lock_status(chip);
>  		if (retval != STATUS_SUCCESS) {
> -- 
> 2.31.1
> 

The original looks correct to me, so I'll drop the revert.

greg k-h
