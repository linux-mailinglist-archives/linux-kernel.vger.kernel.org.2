Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 220493BBB64
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 12:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbhGEKnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 06:43:35 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:13369 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbhGEKne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 06:43:34 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1625481657; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=o6PFjirgrRMyXUNh6/U9Q/e78VxeGNUK1b7hg3+Evy4=; b=OV9bqjhGeG6BVSaiANoMOefVKJM4JvOjKh7fhnbrh4G2A7+46+gkbrU6caufJ009AdzNg0ff
 BI7RfmCjOY7kVyqNdxZkdbxaUlVYlYJn/ipiZLvT5ewjfxLAQ9hOsfePCugaqNYGPnjBpGxv
 xunoni4XCTv3M1QD2FVEU3Vkor0=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 60e2e1b92a2a9a9761508df9 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 05 Jul 2021 10:40:57
 GMT
Sender: mojha=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 36688C4360C; Mon,  5 Jul 2021 10:40:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [192.168.29.2] (unknown [49.37.53.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 26DA2C433F1;
        Mon,  5 Jul 2021 10:40:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 26DA2C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] pstore/ram: Rework logic for detecting ramoops reserved
 memory region
To:     keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com, linux-kernel@vger.kernel.org
Cc:     "Isaac J. Manjarres" <isaacm@codeaurora.org>
References: <1624619838-2578-1-git-send-email-mojha@codeaurora.org>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <26681678-ac97-9fae-44bb-957f1edd5dd8@codeaurora.org>
Date:   Mon, 5 Jul 2021 16:09:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1624619838-2578-1-git-send-email-mojha@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

Could  you please review this ?

-Mukesh

On 6/25/2021 4:47 PM, Mukesh Ojha wrote:
> From: "Isaac J. Manjarres" <isaacm@codeaurora.org>
>
> The reserved memory region for ramoops is assumed to be at a fixed
> and known location when read from the devicetree. This is not desirable
> in environments where it is preferred for the region to be dynamically
> allocated at runtime, as opposed to it being fixed at compile time.
>
> Change the logic for detecting the start and size of the ramoops
> memory region by looking up the reserved memory region instead of
> using platform_get_resource(), which assumes that the location
> of the memory is known ahead of time.
>
> Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
> Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
> ---
>   fs/pstore/ram.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> index fefe3d3..5f90455 100644
> --- a/fs/pstore/ram.c
> +++ b/fs/pstore/ram.c
> @@ -21,6 +21,7 @@
>   #include <linux/pstore_ram.h>
>   #include <linux/of.h>
>   #include <linux/of_address.h>
> +#include <linux/of_reserved_mem.h>
>   #include "internal.h"
>   
>   #define RAMOOPS_KERNMSG_HDR "===="
> @@ -633,21 +634,21 @@ static int ramoops_parse_dt(struct platform_device *pdev,
>   {
>   	struct device_node *of_node = pdev->dev.of_node;
>   	struct device_node *parent_node;
> -	struct resource *res;
> +	struct reserved_mem *rmem;
>   	u32 value;
>   	int ret;
>   
>   	dev_dbg(&pdev->dev, "using Device Tree\n");
>   
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!res) {
> +	rmem = of_reserved_mem_lookup(of_node);
> +	if (!rmem) {
>   		dev_err(&pdev->dev,
>   			"failed to locate DT /reserved-memory resource\n");
>   		return -EINVAL;
>   	}
>   
> -	pdata->mem_size = resource_size(res);
> -	pdata->mem_address = res->start;
> +	pdata->mem_size = rmem->size;
> +	pdata->mem_address = rmem->base;
>   	/*
>   	 * Setting "unbuffered" is deprecated and will be ignored if
>   	 * "mem_type" is also specified.
