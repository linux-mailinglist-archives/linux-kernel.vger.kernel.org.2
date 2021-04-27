Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E26836C5A5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 13:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236044AbhD0L4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 07:56:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:59352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235391AbhD0L4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 07:56:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 90610613A9;
        Tue, 27 Apr 2021 11:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619524555;
        bh=P+rOWYIXa4dBegWeafcgg7ZD8svF+Lxp51tn05LUsIc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zzBXUjAlV4VaujpQXgGAjeA2jozGYjLhImZ3jpLphPSgODQi7hM0pqYPlcOYCMMVw
         xq0RH5tqwu8i7UtHNJxvmmz5PLoxr00fi/fhaoiT0Td+b9KuE77bQFl/VsA0vPys+G
         0pqDYx2PUiRhs8xzuZnkx/azhNxCl+ylOZ3U4mig=
Date:   Tue, 27 Apr 2021 13:55:52 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Aditya Pakki <pakki001@umn.edu>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 161/190] Revert "staging: rts5208: Add a check for
 ms_read_extra_data"
Message-ID: <YIf7yB/Lfi7HCAVX@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-162-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-162-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 03:00:36PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit 73b69c01cc925d9c48e5b4f78e3d8b88c4e5b924.
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
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/staging/rts5208/ms.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/rts5208/ms.c b/drivers/staging/rts5208/ms.c
> index 9001570a8c94..37b60ba1bdfe 100644
> --- a/drivers/staging/rts5208/ms.c
> +++ b/drivers/staging/rts5208/ms.c
> @@ -1665,10 +1665,7 @@ static int ms_copy_page(struct rtsx_chip *chip, u16 old_blk, u16 new_blk,
>  			return STATUS_FAIL;
>  		}
>  
> -		retval = ms_read_extra_data(chip, old_blk, i, extra,
> -					    MS_EXTRA_SIZE);
> -		if (retval != STATUS_SUCCESS)
> -			return STATUS_FAIL;
> +		ms_read_extra_data(chip, old_blk, i, extra, MS_EXTRA_SIZE);
>  
>  		retval = ms_set_rw_reg_addr(chip, OVERWRITE_FLAG,
>  					    MS_EXTRA_SIZE, SYSTEM_PARAM, 6);
> -- 
> 2.31.1
> 

This one looks fine, I'm dropping it.

greg k-h
