Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2CB834E58B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 12:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbhC3Kfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 06:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbhC3KfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 06:35:13 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E0DC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 03:35:13 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id e7so17559935edu.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 03:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6Y9LMyDk4b0iimwt+wvW5tEwZ7sVo50tBsIS9q6O8BE=;
        b=mZZGYOlELnuyff8io3XcjGwmLOyC17x2BAEPKr7y0IH98IQ+7PnkjC3tLHSYxSNBmb
         SHfyzcEYurFach/EVbZOaP1doU2i0smxrXCJf/HxgvwasQViz5cvsXRkZBNvGu25zEc4
         iZMz4JbXHv7CMhieBG5whgaQ9PdaS7OrISzXThreOaLB/0uoZmmEfMKGcpN++pfUukjW
         nqGAFYNlJPpgXvRsMgRURIZMV2qBv1tTGihVbnU/LBiupbnRUOR/cv3gQB6Syqoh7JlL
         1NxWhxPmM88JeAniqmre6Lhzr+2dZ/ibQP51m9qUiRrkFc724BlwLFrQfNKwXvjMzZFL
         hc9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6Y9LMyDk4b0iimwt+wvW5tEwZ7sVo50tBsIS9q6O8BE=;
        b=q6A/AEY0eN/TDXV9nfJax7d8g4PwU/wdYMHLEX8CxVY8ch6/8vOjqUocQ8GK2HEauX
         OQ/Pag3Y3ElJIrNTQKItwzitXned1w98F/oWOn7aAvDfQDT3njJERNT5F2SO9EoOrLi0
         1A370y8jGWo4fgogVGELFsV4T7Kn3j2VfLE6/NKH2fJgHzUq0BzK+zmIKcHdJ7T6wSd5
         EKJG9jQRX8moiJCHOD2qZmMMprZ1KBhfB0LB3k2EN4t4AJ/ovSyq5erNMiU8sjGV13VK
         aXZh1u9uMbqLmIv38HoCGEK5s+Y+w0uasFYnnYgXbcCE0JlDYeJ+KY+Bxm8zfbmC4SIN
         WvrQ==
X-Gm-Message-State: AOAM5317Gmg4lhblfDLCtVT/8k7GFdHidk3ql9BMOedNMw+7dB4Hp3h+
        nQBmviyYbgovesEV8+28sPFURQ==
X-Google-Smtp-Source: ABdhPJzXribJX90G+5FtWdp57MiNA+X1KsdT7xNJEXdMj5f+GQHExjbyYMmfMNWYg4Y19YzzhQvKyA==
X-Received: by 2002:a05:6402:13ca:: with SMTP id a10mr32840223edx.320.1617100512170;
        Tue, 30 Mar 2021 03:35:12 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id u24sm10775642edt.85.2021.03.30.03.35.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Mar 2021 03:35:11 -0700 (PDT)
Subject: Re: [RFC PATCH 1/4] nvmem: core: allow specifying of_node
To:     Michael Walle <michael@walle.cc>, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20210322181949.2805-1-michael@walle.cc>
 <20210322181949.2805-2-michael@walle.cc>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <835a8124-0a22-e885-0bd4-c7493520558e@linaro.org>
Date:   Tue, 30 Mar 2021 11:35:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210322181949.2805-2-michael@walle.cc>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/03/2021 18:19, Michael Walle wrote:
> Until now, the of_node of the parent device is used. Some devices
> provide more than just the nvmem provider. To avoid name space clashes,
> add a way to allow specifying the nvmem cells in subnodes. Consider the
> following example:
> 
>      flash@0 {
>          compatible = "jedec,spi-nor";
> 
>          partitions {
>              compatible = "fixed-partitions";
>              #address-cells = <1>;
>              #size-cells = <1>;
> 
>              partition@0 {
>                  reg = <0x000000 0x010000>;
>              };
>          };
> 
>          otp {
>              compatible = "mtd-user-otp";

I would have expected this to come up as a proper device, but am not 
100% sure how MTD handles flashes and its partitions.

>              #address-cells = <1>;
>              #size-cells = <1>;
> 
>              serial-number@0 {
>                  reg = <0x0 0x8>;
>              };
>          };
>      };
> 
> There the nvmem provider might be the MTD partition or the OTP region of
> the flash.
> 
> Add a new config->of_node parameter, which if set, will be used instead
> of the parent's of_node.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---

Patch is fine as it its.
If you plan to take this via mtd tree here is my Ack

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


--srini

>   drivers/nvmem/core.c           | 4 +++-
>   include/linux/nvmem-provider.h | 2 ++
>   2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index bca671ff4e54..62d363a399d3 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -789,7 +789,9 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>   	nvmem->reg_write = config->reg_write;
>   	nvmem->keepout = config->keepout;
>   	nvmem->nkeepout = config->nkeepout;
> -	if (!config->no_of_node)
> +	if (config->of_node)
> +		nvmem->dev.of_node = config->of_node;
> +	else if (!config->no_of_node)
>   		nvmem->dev.of_node = config->dev->of_node;
>   
>   	switch (config->id) {
> diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
> index e162b757b6d5..471cb7b9e896 100644
> --- a/include/linux/nvmem-provider.h
> +++ b/include/linux/nvmem-provider.h
> @@ -57,6 +57,7 @@ struct nvmem_keepout {
>    * @type:	Type of the nvmem storage
>    * @read_only:	Device is read-only.
>    * @root_only:	Device is accessibly to root only.
> + * @of_node:	If given, this will be used instead of the parent's of_node.
>    * @no_of_node:	Device should not use the parent's of_node even if it's !NULL.
>    * @reg_read:	Callback to read data.
>    * @reg_write:	Callback to write data.
> @@ -86,6 +87,7 @@ struct nvmem_config {
>   	enum nvmem_type		type;
>   	bool			read_only;
>   	bool			root_only;
> +	struct device_node	*of_node;
>   	bool			no_of_node;
>   	nvmem_reg_read_t	reg_read;
>   	nvmem_reg_write_t	reg_write;
> 
