Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7B7C3598EB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 11:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbhDIJMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 05:12:06 -0400
Received: from foss.arm.com ([217.140.110.172]:45532 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232772AbhDIJME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 05:12:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E332B1FB;
        Fri,  9 Apr 2021 02:11:51 -0700 (PDT)
Received: from [192.168.0.130] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 132213F73D;
        Fri,  9 Apr 2021 02:11:48 -0700 (PDT)
Subject: Re: [PATCH -next] coresight: trbe: Fix return value check in
 arm_trbe_register_coresight_cpu()
To:     Wei Yongjun <weiyongjun1@huawei.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Hulk Robot <hulkci@huawei.com>
References: <20210409012213.3664473-1-weiyongjun1@huawei.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <51e3225a-1abb-1c52-93cc-c6935f0c4b52@arm.com>
Date:   Fri, 9 Apr 2021 14:42:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210409012213.3664473-1-weiyongjun1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/9/21 6:52 AM, Wei Yongjun wrote:
> In case of error, the function devm_kasprintf() returns NULL
> pointer not ERR_PTR(). The IS_ERR() test in the return value
> check should be replaced with NULL test.

Right.

> 
> Fixes: 3fbf7f011f24 ("coresight: sink: Add TRBE driver")

Again, dont think this warrants "Fixes:" tag as there were no
functional problem to be fixed here.

> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/hwtracing/coresight/coresight-trbe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
> index 5ce239875c98..176868496879 100644
> --- a/drivers/hwtracing/coresight/coresight-trbe.c
> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
> @@ -871,7 +871,7 @@ static void arm_trbe_register_coresight_cpu(struct trbe_drvdata *drvdata, int cp
>  
>  	dev = &cpudata->drvdata->pdev->dev;
>  	desc.name = devm_kasprintf(dev, GFP_KERNEL, "trbe%d", cpu);
> -	if (IS_ERR(desc.name))
> +	if (!desc.name)
>  		goto cpu_clear;
>  
>  	desc.type = CORESIGHT_DEV_TYPE_SINK;
>

LGTM.
