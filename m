Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 260BD37158C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 14:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233545AbhECM6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 08:58:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:58144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233372AbhECM6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 08:58:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 40DAB611C0;
        Mon,  3 May 2021 12:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620046648;
        bh=kBk7Zo6+NDEgM5HfLqkU6WXN+fEI6VrFo/57ce2FUGY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QTKaiUY+v8C918VY0IH+nTMQxDYRYt6oL4kHbcOhNbpHlXoZvuRq7j++C8scLEChI
         rZHCGiSRBZ1IeoHNCC0R0lxCTcl7LaxlQlMlEXWQm5Ir5SQOwpZjI4ZnJR3v80M1lo
         ewf6esuaMuzWOYu8Y+S+FEZJyvrihwvyn+tzMB8caPiS4EIKSRbbxM8ZmuqENvjzHc
         kXXMUPob10OQ1WC5BCOZjMcyDM8uO6byATH8GLQL+ejxEoX+ONcARJeTUcBw0Nyvz7
         SEqbOG8tVIr/WYwAFRyKOJ9/+7ZMK+zUisLNm3Mk2XUPaJeGUa8YgEJ0zOsvvYBteu
         OQJxuUYe67DHg==
Subject: Re: [PATCH 51/69] dmaengine: qcom_hidma: comment
 platform_driver_register call
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Phillip Potter <phil@philpotter.co.uk>,
        Vinod Koul <vkoul@kernel.org>
References: <20210503115736.2104747-1-gregkh@linuxfoundation.org>
 <20210503115736.2104747-52-gregkh@linuxfoundation.org>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <10b38be6-39e3-bfb8-743c-10227714e641@kernel.org>
Date:   Mon, 3 May 2021 08:57:27 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210503115736.2104747-52-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/3/2021 7:57 AM, Greg Kroah-Hartman wrote:
> From: Phillip Potter <phil@philpotter.co.uk>
> 
> Place a comment in hidma_mgmt_init explaining why success must
> currently be assumed, due to the cleanup issue that would need to
> be considered were this module ever to be unloadable or were this
> platform_driver_register call ever to fail.
> 
> Cc: Sinan Kaya <okaya@kernel.org>
> Cc: Vinod Koul <vkoul@kernel.org>
> Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/dma/qcom/hidma_mgmt.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/dma/qcom/hidma_mgmt.c b/drivers/dma/qcom/hidma_mgmt.c
> index fe87b01f7a4e..62026607f3f8 100644
> --- a/drivers/dma/qcom/hidma_mgmt.c
> +++ b/drivers/dma/qcom/hidma_mgmt.c
> @@ -418,6 +418,20 @@ static int __init hidma_mgmt_init(void)
>  		hidma_mgmt_of_populate_channels(child);
>  	}
>  #endif
> +	/*
> +	 * We do not check for return value here, as it is assumed that
> +	 * platform_driver_register must not fail. The reason for this is that
> +	 * the (potential) hidma_mgmt_of_populate_channels calls above are not
> +	 * cleaned up if it does fail, and to do this work is quite
> +	 * complicated. In particular, various calls of of_address_to_resource,
> +	 * of_irq_to_resource, platform_device_register_full, of_dma_configure,
> +	 * and of_msi_configure which then call other functions and so on, must
> +	 * be cleaned up - this is not a trivial exercise.
> +	 *
> +	 * Currently, this module is not intended to be unloaded, and there is
> +	 * no module_exit function defined which does the needed cleanup. For
> +	 * this reason, we have to assume success here.
> +	 */
>  	platform_driver_register(&hidma_mgmt_driver);
>  
>  	return 0;
> 

Acked-By: Sinan Kaya <okaya@kernel.org>
