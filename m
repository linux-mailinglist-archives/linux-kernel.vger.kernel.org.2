Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5A1F40AA3F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 11:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbhINJJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 05:09:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:42888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229656AbhINJJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 05:09:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 60FA660E97;
        Tue, 14 Sep 2021 09:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631610496;
        bh=3NSSJD/hUlD51TGtARk9UEMG5P8iV1pAjCtLdqOmFqE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gDIWrQO8/RKpruPUxvwf/Sj9HEmQ7iwkPPA6M9FqXUGB+8QJ3m/jVdYkjUiWlL1cv
         /ucrJIbWnYYZFyexK97osyzDFyf+r7FVOtpGYN6+CpxxFU1ibIc8IIDwlYKdgtxlMU
         kMCEu2P/DItYWd9idJzG9NBbp+PHXZ/8Mju1OvLE=
Date:   Tue, 14 Sep 2021 11:08:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bixuan Cui <cuibixuan@huawei.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        will@kernel.org, rafael@kernel.org, robin.murphy@arm.com,
        joro@8bytes.org, jean-philippe@linaro.org,
        Jonathan.Cameron@huawei.com, thunder.leizhen@huawei.com,
        maz@kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH -next v3 1/2] platform-msi: Save the msg context to desc
 in platform_msi_write_msg()
Message-ID: <YUBmfXx5rVCrFVI/@kroah.com>
References: <20210828063916.39633-1-cuibixuan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210828063916.39633-1-cuibixuan@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2021 at 02:39:14PM +0800, Bixuan Cui wrote:
> Save the msg context to desc when the msi interrupt is requested.
> The drivers can use it in special scenarios(such as resume).
> 
> Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>
> ---
>  drivers/base/platform-msi.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
> index 3d6c8f9caf43..60962a224fcc 100644
> --- a/drivers/base/platform-msi.c
> +++ b/drivers/base/platform-msi.c
> @@ -90,6 +90,9 @@ static void platform_msi_write_msg(struct irq_data *data, struct msi_msg *msg)
>  
>  	priv_data = desc->platform.msi_priv_data;
>  
> +	desc->msg.address_lo = msg->address_lo;
> +	desc->msg.address_hi = msg->address_hi;
> +	desc->msg.data = msg->data;
>  	priv_data->write_msg(desc, msg);
>  }
>  
> -- 
> 2.17.1
> 

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
