Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8A5353C16
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 08:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbhDEGVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 02:21:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:40064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229454AbhDEGVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 02:21:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 259D961399;
        Mon,  5 Apr 2021 06:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617603691;
        bh=xKdGZ44ZwQ3VybqwUhF7c0iuUupdhhUePbVF00lo1Hc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ma0jUVRBxeTvA5MX/MKMkCXamBJofQ9SmH38mKpEloZsRapwwGGEh64zmQUbU6R4B
         fjCJ4UCRnJo9NY+4kvgpsozrM+4NCX9vgFGuqpOJ02MLap8g7ze+c57EwxmoulzJ+1
         l0iBGaQzjeaUgimkJtbxkw1sZQTo5zluoRkBBH0A=
Date:   Mon, 5 Apr 2021 08:21:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mitali Borkar <mitaliborkar810@gmail.com>
Cc:     manish@marvell.com, GR-Linux-NIC-Dev@marvell.com,
        outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: qlge: remove else after break
Message-ID: <YGqsaKVJM8pn1BYU@kroah.com>
References: <YGpcx9MZuZJFy0Z/@kali>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGpcx9MZuZJFy0Z/@kali>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2021 at 06:11:43AM +0530, Mitali Borkar wrote:
> linux-staging@lists,linux-kernel@vger.kernel.org
> Bcc: 
> Subject: [PATCH] staging: qlge:remove else after break
> Reply-To: 

Very odd, why is this in the body of the email?



> 
> Fixed Warning:- else is not needed after break
> break terminates the loop if encountered. else is unnecessary and
> increases indenatation
> 
> Signed-off-by: Mitali Borkar <mitaliborkar810@gmail.com>
> ---
>  drivers/staging/qlge/qlge_mpi.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/qlge/qlge_mpi.c b/drivers/staging/qlge/qlge_mpi.c
> index 2630ebf50341..3a49f187203b 100644
> --- a/drivers/staging/qlge/qlge_mpi.c
> +++ b/drivers/staging/qlge/qlge_mpi.c
> @@ -935,13 +935,11 @@ static int qlge_idc_wait(struct qlge_adapter *qdev)
>  			netif_err(qdev, drv, qdev->ndev, "IDC Success.\n");
>  			status = 0;
>  			break;
> -		} else {
> -			netif_err(qdev, drv, qdev->ndev,
> +		}	netif_err(qdev, drv, qdev->ndev,
>  				  "IDC: Invalid State 0x%.04x.\n",
>  				  mbcp->mbox_out[0]);
>  			status = -EIO;
>  			break;
> -		}

Indentation is now no longer correct :(

thanks,

greg k-h
