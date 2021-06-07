Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 237D739E140
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 17:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbhFGPxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 11:53:24 -0400
Received: from ale.deltatee.com ([204.191.154.188]:34814 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbhFGPxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 11:53:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=4claKpMmrc3WERETeGcJn3zlM3eZGEqhAb7GXJGJFUo=; b=KZWC9QwJwXpfgtO5Pbi3C9D6hb
        w11CbVtyoLTNY4knF7tXLjbD/o7MNV+jWLeuskQttepQzBMACKANLRFixONav89MRxs1Aj7B0hB0i
        UbZ84dUhdqdru1DM4RH0WiFkMpiG0CoMyU8AuzmQ+tqo3wW6T3MqYCBf6yu5mNOcetgcr6LYkGQSE
        0Mj6fXWcTHtUrOihiZY2CvwSsLWH87mSM+12tsJWiEhLDxsj/IF/0Wntne326JZheqbRgDQKV2EzM
        impwF2yhSiymE+ol95TbQI1wJ15n6l3TeGpDsRDTAK5m72EFVAzAg+bauotvry21XSO2N4vfaVMi8
        CYooDmUg==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1lqHXG-0007rq-Up; Mon, 07 Jun 2021 09:51:31 -0600
To:     Yang Li <yang.lee@linux.alibaba.com>, jdmason@kudzu.us
Cc:     dave.jiang@intel.com, allenbh@gmail.com,
        linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
References: <1623045380-125394-1-git-send-email-yang.lee@linux.alibaba.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <9182a6e0-541b-e350-d760-06623cb06855@deltatee.com>
Date:   Mon, 7 Jun 2021 09:51:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <1623045380-125394-1-git-send-email-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, allenbh@gmail.com, dave.jiang@intel.com, jdmason@kudzu.us, yang.lee@linux.alibaba.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: Re: [PATCH v2] NTB: Fix an error code in ntb_msit_probe()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021-06-06 11:56 p.m., Yang Li wrote:
> When the value of nm->isr_ctx is false, the value of ret is 0.
> So, we set ret to -ENOMEM to indicate this error.
> 
> Clean up smatch warning:
> drivers/ntb/test/ntb_msi_test.c:373 ntb_msit_probe() warn: missing
> error code 'ret'.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Thanks!

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

> ---
> 
> Change in v2:
> --revise typo
> 
>  drivers/ntb/test/ntb_msi_test.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ntb/test/ntb_msi_test.c b/drivers/ntb/test/ntb_msi_test.c
> index 7095ecd..4e18e08 100644
> --- a/drivers/ntb/test/ntb_msi_test.c
> +++ b/drivers/ntb/test/ntb_msi_test.c
> @@ -369,8 +369,10 @@ static int ntb_msit_probe(struct ntb_client *client, struct ntb_dev *ntb)
>  	if (ret)
>  		goto remove_dbgfs;
>  
> -	if (!nm->isr_ctx)
> +	if (!nm->isr_ctx) {
> +		ret = -ENOMEM;
>  		goto remove_dbgfs;
> +	}
>  
>  	ntb_link_enable(ntb, NTB_SPEED_AUTO, NTB_WIDTH_AUTO);
>  
> 
