Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C11EC3A2DE3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 16:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbhFJOTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 10:19:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:43198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230387AbhFJOTY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 10:19:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EB7F2613D9;
        Thu, 10 Jun 2021 14:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623334648;
        bh=RsxEWAIXQZfs+po6RGl38wHzZWi2MVveikiBWMNibGA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H6FObbXCb9egJCrCRk6BZlkp8VdSKvXFpU1mIWh4XaMIAokIiMql2pZt7pp9B8Ipj
         DnxFKjsbC63dDVQ52j0itePU2TbtLszEwqpWcEWMpcyqQUmCdGu+26y+VAqqmtf5lr
         aFiN2kmxRXk2MeLsGBFGVhoEsF8vD6eahiD7Fy7Q27H2PL9xht4rKwWVRSmHud5ali
         OHB3T2fwpHL5wpwCp9fC68aNb0Xsh8kplyKiwS4FAMTc7VnZP29BiuTo8CbuGDxA4l
         xtud/0UMz4utFQHmTy7Am0kVJv0/uclE4EIeLoxKmUDFkVkT2kMFKmkqrNmEd2smpo
         greg0Ehg8vgkQ==
Date:   Thu, 10 Jun 2021 22:17:12 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-kernel@vger.kernel.org, Pawel Laszczak <pawell@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        weiyongjun1@huawei.com, yuehaibing@huawei.com,
        yangjihong1@huawei.com, yukuai3@huawei.com,
        linux-usb@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next v2] usb: cdns3: cdns3-gadget: Use list_move_tail
 instead of list_del/list_add_tail
Message-ID: <20210610141712.GB7839@Peter>
References: <20210609072720.1358527-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609072720.1358527-1-libaokun1@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-06-09 15:27:20, Baokun Li wrote:
> Using list_move_tail() instead of list_del() + list_add_tail().
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
> V1->V2:
> 	CC mailist
> 
>  drivers/usb/cdns3/cdns3-gadget.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
> index 57adcdbfab5f..5d8c982019af 100644
> --- a/drivers/usb/cdns3/cdns3-gadget.c
> +++ b/drivers/usb/cdns3/cdns3-gadget.c
> @@ -430,9 +430,7 @@ static int cdns3_start_all_request(struct cdns3_device *priv_dev,
>  		if (ret)
>  			return ret;
>  
> -		list_del(&request->list);
> -		list_add_tail(&request->list,
> -			      &priv_ep->pending_req_list);
> +		list_move_tail(&request->list, &priv_ep->pending_req_list);
>  		if (request->stream_id != 0 || (priv_ep->flags & EP_TDLCHK_EN))
>  			break;
>  	}
> 

Applied, thanks.

-- 

Thanks,
Peter Chen

