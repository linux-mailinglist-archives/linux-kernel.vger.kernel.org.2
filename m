Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA3E4085A4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 09:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237780AbhIMHvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 03:51:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:35708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237706AbhIMHvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 03:51:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A64A760F6F;
        Mon, 13 Sep 2021 07:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631519438;
        bh=cMvOsxQPkcCU0L+gMR/WQdHx7koCqFk64UEN1RNQ10Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BSc6E9qPLljN/NdJaC7wotlLnn7oUna8vhWmx2sXA0NozUXoNxQrXnjvMpjAds5uY
         QRCrzZNrfEPRpxs5RmJTAnc0lTWpBHCTOy8GL8Vrun9cWr/nEeEKolE/QPBnDM4a4h
         dAfhQDckYF8XinNpYbmw8i2eUC/FlsjydiKSKumk=
Date:   Mon, 13 Sep 2021 09:50:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     giovanni.cabiddu@intel.com, stable-commits@vger.kernel.org
Subject: Re: Patch "crypto: qat - do not export adf_iov_putmsg()" has been
 added to the 4.4-stable tree
Message-ID: <YT8Cy2W0UBLrbTyj@kroah.com>
References: <20210913032306.946F4600D4@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210913032306.946F4600D4@mail.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 12, 2021 at 11:23:05PM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     crypto: qat - do not export adf_iov_putmsg()
> 
> to the 4.4-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      crypto-qat-do-not-export-adf_iov_putmsg.patch
> and it can be found in the queue-4.4 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit 5f8033f94420950b5fc4b91dd2154c00fc88d44e
> Author: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> Date:   Thu Aug 12 21:21:28 2021 +0100
> 
>     crypto: qat - do not export adf_iov_putmsg()
>     
>     [ Upstream commit 645ae0af1840199086c33e4f841892ebee73f615 ]
>     
>     The function adf_iov_putmsg() is only used inside the intel_qat module
>     therefore should not be exported.
>     Remove EXPORT_SYMBOL for the function adf_iov_putmsg().
>     
>     Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
>     Reviewed-by: Fiona Trahe <fiona.trahe@intel.com>
>     Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/drivers/crypto/qat/qat_common/adf_pf2vf_msg.c b/drivers/crypto/qat/qat_common/adf_pf2vf_msg.c
> index 711706819b05..f071aba32a28 100644
> --- a/drivers/crypto/qat/qat_common/adf_pf2vf_msg.c
> +++ b/drivers/crypto/qat/qat_common/adf_pf2vf_msg.c
> @@ -254,7 +254,6 @@ int adf_iov_putmsg(struct adf_accel_dev *accel_dev, u32 msg, u8 vf_nr)
>  
>  	return ret;
>  }
> -EXPORT_SYMBOL_GPL(adf_iov_putmsg);
>  
>  void adf_vf2pf_req_hndl(struct adf_accel_vf_info *vf_info)
>  {

This breaks the build on the 4.4.y stable queue, so I am dropping it
from there.

thanks,

greg k-h
