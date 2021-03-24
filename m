Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2293475B0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 11:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbhCXKRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 06:17:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:47954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230094AbhCXKRS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 06:17:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 077FF619E4;
        Wed, 24 Mar 2021 10:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616581038;
        bh=zAAeSte69smRd/slyakmd3Rly6tBuGT/bfL6t7Gpa1U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yZJD4jnoC/lxa9dI1Z9RAkxcPkVvcdm9pMdhJ/diQhPsKGisqvn0veal1IxHDiaDa
         +bmpoVOlE/b4ec4pmkH4omyXrxsZA6kc12LfDhaXwEnEvMUXzqUNyoCIBEScKupQrM
         Xdw2aRRqQ56TsQtdQksLi02zGaSaT+44w11k5okY=
Date:   Wed, 24 Mar 2021 11:17:16 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc: rtsx: check the value returned from a function for
 errors before being used
Message-ID: <YFsRrM8asMLeYzQq@kroah.com>
References: <1616580358-93156-1-git-send-email-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1616580358-93156-1-git-send-email-yang.lee@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 06:05:58PM +0800, Yang Li wrote:
> Add missing return value check in pm_runtime_get disabling the
> sensor. The issue is reported by coverity with the following error:
> 
> Medium:Unchecked return value(CHECKED_RETURN)
> CWE252: Value returned from a function is not checked for errors before
> being used.
> Calling "pm_runtime_get" without checking return value.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/misc/cardreader/rtsx_pcr.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/cardreader/rtsx_pcr.c b/drivers/misc/cardreader/rtsx_pcr.c
> index 2733111..2cc37fd 100644
> --- a/drivers/misc/cardreader/rtsx_pcr.c
> +++ b/drivers/misc/cardreader/rtsx_pcr.c
> @@ -142,13 +142,16 @@ static void rtsx_pm_full_on(struct rtsx_pcr *pcr)
>  
>  void rtsx_pci_start_run(struct rtsx_pcr *pcr)
>  {
> +	int status;
>  	/* If pci device removed, don't queue idle work any more */
>  	if (pcr->remove_pci)
>  		return;
>  
>  	if (pcr->rtd3_en)
>  		if (pcr->is_runtime_suspended) {
> -			pm_runtime_get(&(pcr->pci->dev));
> +			status = pm_runtime_get(&(pcr->pci->dev));
> +			if (status < 0 && status != -EINPROGRESS)
> +				pm_runtime_put_noidle(&(pcr->pci->dev));
>  			pcr->is_runtime_suspended = false;
>  		}
>  
> -- 
> 1.8.3.1
> 

Please always run scripts/checkpatch.pl on your patch before submitting
it.

thanks,

greg k-h
