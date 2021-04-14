Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9337835EF94
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 10:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbhDNI0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 04:26:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:43664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229467AbhDNI0G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 04:26:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EF256613B1;
        Wed, 14 Apr 2021 08:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618388742;
        bh=0gCby2KW5PmeDy4G/e/A5rV0irl5mDAIJanXOzBp1NE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q2bdX1gftwlU3QQyRQO2IgsuEkyFKQbh/fWiaUq591BUm1so9MDjLVz5x8bS/9PiU
         ybyfS6D5YEEuTM7wUN2nZjpvS2gfOr1Dej9yGMJ7fgzEQUm4kFOLw56f0RHsx7agBA
         0zkHcPUz6MKl8XA0LfuEuW/B3yTnCPacTAsg9ghU=
Date:   Wed, 14 Apr 2021 10:25:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     julia.lawall@inria.fr, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] staging: rtl8723bs: put a new line after ';'
Message-ID: <YHanBPRxVVfoOb5p@kroah.com>
References: <cover.1618325614.git.fabioaiuto83@gmail.com>
 <7e796fe7a5a370d055be201204dcac14f09c974a.1618325614.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e796fe7a5a370d055be201204dcac14f09c974a.1618325614.git.fabioaiuto83@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 04:56:33PM +0200, Fabio Aiuto wrote:
> fix the following post commit hook checkpatch issue:
> 
> ERROR: space required after that ';' (ctx:VxV)
> 232: FILE: drivers/staging/rtl8723bs/core/rtw_odm.c:160:
> +		   "AdapEn_RSSI", "IGI_LowerBound");netdev_dbg
> 			(adapter->pnetdev,
> 
> This was coccinelle script output coding style issue.
> 
> Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_odm.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_odm.c b/drivers/staging/rtl8723bs/core/rtw_odm.c
> index 084f6ae040ee..f4a0ef428564 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_odm.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_odm.c
> @@ -157,14 +157,15 @@ void rtw_odm_adaptivity_parm_msg(void *sel, struct adapter *adapter)
>  
>  	netdev_dbg(adapter->pnetdev, "%10s %16s %8s %10s %11s %14s\n",
>  		   "TH_L2H_ini", "TH_EDCCA_HL_diff", "IGI_Base", "ForceEDCCA",
> -		   "AdapEn_RSSI", "IGI_LowerBound");netdev_dbg(adapter->pnetdev,
> -							       "0x%-8x %-16d 0x%-6x %-10d %-11u %-14u\n",
> -							       (u8)odm->TH_L2H_ini,
> -							       odm->TH_EDCCA_HL_diff,
> -							       odm->IGI_Base,
> -							       odm->ForceEDCCA,
> -							       odm->AdapEn_RSSI,
> -							       odm->IGI_LowerBound);
> +		   "AdapEn_RSSI", "IGI_LowerBound");
> +	netdev_dbg(adapter->pnetdev,
> +		   "0x%-8x %-16d 0x%-6x %-10d %-11u %-14u\n",
> +		   (u8)odm->TH_L2H_ini,
> +		   odm->TH_EDCCA_HL_diff,
> +		   odm->IGI_Base,
> +		   odm->ForceEDCCA,
> +		   odm->AdapEn_RSSI,
> +		   odm->IGI_LowerBound);
>  }
>  
>  void rtw_odm_adaptivity_parm_set(struct adapter *adapter, s8 TH_L2H_ini,
> -- 
> 2.20.1

This patch should not be needed, your commit that caused this error
should not have done so.  Please fix that instead.

thanks,

greg k-h
