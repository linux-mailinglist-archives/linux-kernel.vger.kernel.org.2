Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F22135C4CF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 13:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240014AbhDLLRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 07:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237720AbhDLLRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 07:17:31 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D43FC061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 04:17:13 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id sd23so10953982ejb.12
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 04:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kFSe5n5U9BPZPO9futXGhFSddhJ07nAQjfoS59gUsgs=;
        b=o+XvYNQ1zTZilPgHcZqivVQKpCxoQJXtdDkVLCmY23jSw9gPhJZEO34PhRHF3Z1SXT
         ffrztOas+Vg5VpIbU4tM8nGRU8ES3l5FIDYKJvkkQvm4sl8AYS64c3hbHt5/HljjXD+/
         EmP982WNfOGVRjp3/EmPmfedPvqfEq2ykmTTRHvUGMJ4pTZ0tBBA/VnquQlPqYBFZIoa
         EMkiByyVa8nasmk6fLWE+K8+Tmj8tMqSBO9X+iv7JambMiYNdhhz7wrZTJfqkLQ8ilJb
         eNG+PWhFhmQIYV3wxToiysiU0MkXDhY+4+1f+oQjvZHK5rprCrgQ1sV34tMdCFn0Ozwy
         gtvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kFSe5n5U9BPZPO9futXGhFSddhJ07nAQjfoS59gUsgs=;
        b=AK88aWc4uQtyN3567XO9L9FwkqEJQyRMC+ZJhkcm974ZH2J/A5B7F9rXeIPRGSgc9a
         um0D25wLTUltmzyc2vzkQB7i8IOCNzf4QQVAunz584W5zb1a4wAKZ1pqsvK3qWIY9/J4
         JgEjmnu+EUqNGs7ShIaxFAzFz+fK+drg7A5UZQ38MkpxDdWdy1SFOTbWoYC5oReV7A9b
         LXF5uoy+uDgxUzxTlovBnPFhqwtfqIuXbrFj2kAEetef/oaZK/ahc883HE/jDqQRz2hJ
         AFZu+TZ9Qop9NGqfVqqvlfQs9jZsxS7jJwZG+5xZQ7vmodDKBaz+kQkMBaV0yq4x+sDQ
         KxVQ==
X-Gm-Message-State: AOAM53100cH5xruFC6NP77I8lWHhTi1R9XmPk2oHtMDTNaMp4CeEnqMR
        55wveYCDWDWvvdYFnVsJVWSDTg==
X-Google-Smtp-Source: ABdhPJwFlOdwJEju3oTC0+kYM3Xg1gSHbdmVF4TlGEHgzvsXZuyvzwYEMT33igKYey3F0ydqPlckDw==
X-Received: by 2002:a17:906:6b91:: with SMTP id l17mr3194984ejr.196.1618226231772;
        Mon, 12 Apr 2021 04:17:11 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id u19sm6456348edy.23.2021.04.12.04.17.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Apr 2021 04:17:11 -0700 (PDT)
Subject: Re: [PATCH -next] nvmem: sprd: Add missing MODULE_DEVICE_TABLE
To:     Bixuan Cui <cuibixuan@huawei.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20210410035033.11274-1-cuibixuan@huawei.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <1afdb2e8-c4d6-ed8f-4260-2475dd26461c@linaro.org>
Date:   Mon, 12 Apr 2021 12:17:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210410035033.11274-1-cuibixuan@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/04/2021 04:50, Bixuan Cui wrote:
> This patch adds missing MODULE_DEVICE_TABLE definition which generates
> correct modalias for automatic loading of this driver when it is built
> as an external module.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>
> ---

Applied thanks,

--srini

>   drivers/nvmem/sprd-efuse.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/nvmem/sprd-efuse.c b/drivers/nvmem/sprd-efuse.c
> index 59523245db8a..5d394559edf2 100644
> --- a/drivers/nvmem/sprd-efuse.c
> +++ b/drivers/nvmem/sprd-efuse.c
> @@ -425,6 +425,7 @@ static const struct of_device_id sprd_efuse_of_match[] = {
>   	{ .compatible = "sprd,ums312-efuse", .data = &ums312_data },
>   	{ }
>   };
> +MODULE_DEVICE_TABLE(of, sprd_efuse_of_match);
>   
>   static struct platform_driver sprd_efuse_driver = {
>   	.probe = sprd_efuse_probe,
> 
