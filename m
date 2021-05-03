Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C81ED37158B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 14:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbhECM6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 08:58:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:57956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231180AbhECM6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 08:58:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 548D660D07;
        Mon,  3 May 2021 12:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620046633;
        bh=ogYrfqt3UbmvWma8Wl4DlNQu366hL6XxzCzX3CYiQ9s=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Cr5fbTDiScNHZzvQu1oI+UtnjAVYpyKY6AmDWOqj/KQtn2gBbvyancZ2NXigQxGVF
         Dex7Tu0pGvKbCcH3p+CNGL0X4RRPuX1JmeDZwXkOhtl1i8MaYd4Bo1M7f5f0Ri93MF
         mN359FsM1/YAIICiFQsBnR1Vwtw4oYsQBPFQntqPUrrm2Za4sMl/pYDHC2o7cXGzrS
         wq1RzbC0bdr1NNRbZhxTxUBUecH/3htaYb+XEUK9pfd00j71Y0nDVZuEXKSBZmjYjR
         HNgVK0/rOWwE+jgQMuMn/6ncaHpkZWCNXvqpcyetfl/irtlRPwmmwzBDTlmrXq8a8k
         MGP3X0Rh4UJww==
Subject: Re: [PATCH 50/69] Revert "dmaengine: qcom_hidma: Check for driver
 register failure"
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Aditya Pakki <pakki001@umn.edu>, Vinod Koul <vkoul@kernel.org>
References: <20210503115736.2104747-1-gregkh@linuxfoundation.org>
 <20210503115736.2104747-51-gregkh@linuxfoundation.org>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <ca573c7c-2f60-0b53-33b0-625542158a02@kernel.org>
Date:   Mon, 3 May 2021 08:57:11 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210503115736.2104747-51-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/3/2021 7:57 AM, Greg Kroah-Hartman wrote:
> This reverts commit a474b3f0428d6b02a538aa10b3c3b722751cb382.
> 
> Because of recent interactions with developers from @umn.edu, all
> commits from them have been recently re-reviewed to ensure if they were
> correct or not.
> 
> Upon review, this commit was found to be incorrect for the reasons
> below, so it must be reverted.  It will be fixed up "correctly" in a
> later kernel change.
> 
> The original change is NOT correct, as it does not correctly unwind from
> the resources that was allocated before the call to
> platform_driver_register().
> 
> Cc: Aditya Pakki <pakki001@umn.edu>
> Cc: Sinan Kaya <okaya@kernel.org>
> Cc: Vinod Koul <vkoul@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/dma/qcom/hidma_mgmt.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/qcom/hidma_mgmt.c b/drivers/dma/qcom/hidma_mgmt.c
> index 806ca02c52d7..fe87b01f7a4e 100644
> --- a/drivers/dma/qcom/hidma_mgmt.c
> +++ b/drivers/dma/qcom/hidma_mgmt.c
> @@ -418,8 +418,9 @@ static int __init hidma_mgmt_init(void)
>  		hidma_mgmt_of_populate_channels(child);
>  	}
>  #endif
> -	return platform_driver_register(&hidma_mgmt_driver);
> +	platform_driver_register(&hidma_mgmt_driver);
>  
> +	return 0;
>  }
>  module_init(hidma_mgmt_init);
>  MODULE_LICENSE("GPL v2");
> 

Acked-By: Sinan Kaya <okaya@kernel.org>

