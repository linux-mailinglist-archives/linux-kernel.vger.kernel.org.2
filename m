Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A75863E8D8F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 11:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236741AbhHKJwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 05:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236573AbhHKJwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 05:52:45 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5A1C0613D3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 02:52:21 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id c9so2177624wri.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 02:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7Sa735VBDk/11axEt+ahFeW6tHjYIapyTeUGnE9a9Kc=;
        b=EdDZtng4b3ClBH3m5cgskqpFPpNoW0Owbzb7jMBlthFvHMNXkJ6w4hYC0w0nb5KOpA
         5H0IPy4VgYfI4fqwprpwJpPdwOfdgokMbZysfIfDcRxLC4fNW6YlpQlUbCZ+xBcVPhDR
         aVd30InM2UDjtpGfqzf9a150PyTWQfNj+DKo9t8V4Lad1bWEliJYgOxunJd70dyL7MS9
         0Gfpmm2CcRkwH4Yfz3l2ZlG3/0brZks80+WbTUiw08yDkOjuz3dau2yz3GAswVMbKKwS
         Ywl10IfsVtuF1sPKPVpOQ3UM7TMgtsKXBbI3/lYSW5rskkD6EINLJuvnd3jZtPohnxe6
         brLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7Sa735VBDk/11axEt+ahFeW6tHjYIapyTeUGnE9a9Kc=;
        b=aGXpt7+Pc6NEBMaVlMb+eWoPJS+Cum1FdmdjGpQ5tOZU8UQPdSfsA9FdOvbPER2EXK
         48yi9YmwHwHuvwp/mQsywcMitAKWEkPezd1rUGousBbIOy2zsEM/qT75u3TOCkr8RyqB
         fSnru2ogNHsbVUK6DHguBdAy96F8xQFv6yURFE/WE6VY44XBO5ZpN+K1EejCcZQlaBnj
         Nna2F28OYRnNf8Kc/rlGV3+1v5Jw10c6fN28hQduLJqsJwGK5GSdxV7LUex1pGteG30v
         ACkEmlzhh288+V7fSYQwcUwigyTdpU92hHw+a0UyUCVVF82VszFz8/mWS/D6RFHQRopz
         8WyA==
X-Gm-Message-State: AOAM533JlVbaheb1ZthcmfPgA3G54b8RdRj86uac9G/QK/W7rGqkHdhD
        e+PTJs5kESk3r3iWh4HKlulDwmT/gQeD2A==
X-Google-Smtp-Source: ABdhPJwCF2Ck4qsqGQidKYLvFHhCmO51q61CXZA/BY3QacvhmLLPvCN8U73Otn7f5gWXt4j454FKiQ==
X-Received: by 2002:adf:cd10:: with SMTP id w16mr36343368wrm.404.1628675540030;
        Wed, 11 Aug 2021 02:52:20 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id h11sm6181339wmc.23.2021.08.11.02.52.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Aug 2021 02:52:19 -0700 (PDT)
Subject: Re: [PATCH V1 2/4] nvmem: core: introduce "reverse-data" property to
 reverse buffer
To:     Joakim Zhang <qiangqing.zhang@nxp.com>, robh+dt@kernel.org,
        shawnguo@kernel.org
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210810073510.18218-1-qiangqing.zhang@nxp.com>
 <20210810073510.18218-3-qiangqing.zhang@nxp.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <2a69b82c-0ecb-51cf-ea60-1827c60bfe85@linaro.org>
Date:   Wed, 11 Aug 2021 10:52:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210810073510.18218-3-qiangqing.zhang@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/08/2021 08:35, Joakim Zhang wrote:
> This patch intends to introduce "reverse-data" property at nvmem
> provider side to reverse buffer.
> 
> For a case used from Ethernet driver, of_get_mac_address() may call
> of_get_mac_addr_nvmem() to get MAC address from nvmem device. MAC address
> programed in imx-ocopt is MSB first in lowest address, so need reverse

Is all the data stored in imx-ocopt reverse byte order?

or someone decided to change the order for only mac-address?


> data then feedback to nvmem consumer. E.g. MAC address read from
> imx-ocopt is 98:e2:06:9f:04:00, after reversed the data is
> 00:04:9f:06:e2:98.
> 
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> ---
>   drivers/nvmem/core.c           | 30 ++++++++++++++++++++++++++++++
>   include/linux/nvmem-provider.h |  2 ++
>   2 files changed, 32 insertions(+)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index b3bc30a04ed7..ccc2c5801c8e 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -55,6 +55,7 @@ struct nvmem_cell {
>   	struct device_node	*np;
>   	struct nvmem_device	*nvmem;
>   	struct list_head	node;
> +	u32			flags;

This flag also needs to go in struct nvmem_cell_info too.

>   };
>   
>   static DEFINE_MUTEX(nvmem_mutex);
> @@ -92,6 +93,26 @@ static int __nvmem_reg_write(struct nvmem_device *nvmem, unsigned int offset,
>   	return -EINVAL;
>   }
>   
> +static int nvmem_buffer_reverse(void *bufaddr, int len)
> +{
> +	u8 *buf = (u8 *)bufaddr;
> +	u8 *temp;
> +	int i;
> +
> +	temp = kzalloc(len, GFP_KERNEL);
> +	if (!temp)
> +		return -ENOMEM;
> +
> +	memcpy(temp, buf, len);
> +
> +	for (i = 0; i < len; i++)
> +		buf[i] = temp[len - i - 1];
> +

You could possibly simplify this.

static void nvmem_buffer_reverse(u8 *buf, int len)
{
	int i;

	for (i = 0; i < len/2; i++)
		swap(buf[i], buf[len - i - 1]);
}

> +	kfree(temp);
> +
> +	return 0;
> +}
> +
>   static int nvmem_access_with_keepouts(struct nvmem_device *nvmem,
>   				      unsigned int offset, void *val,
>   				      size_t bytes, int write)
> @@ -705,6 +726,9 @@ static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
>   		cell->bytes = be32_to_cpup(addr);
>   		cell->name = kasprintf(GFP_KERNEL, "%pOFn", child);
>   
> +		if (of_property_read_bool(child, "reverse-data"))
> +			cell->flags |= NVMEM_FLAGS_REVERSE_DATA;
> +
>   		addr = of_get_property(child, "bits", &len);
>   		if (addr && len == (2 * sizeof(u32))) {
>   			cell->bit_offset = be32_to_cpup(addr++);
> @@ -1398,6 +1422,12 @@ static int __nvmem_cell_read(struct nvmem_device *nvmem,
>   	if (cell->bit_offset || cell->nbits)
>   		nvmem_shift_read_buffer_in_place(cell, buf);
>   
> +	if (cell->flags & NVMEM_FLAGS_REVERSE_DATA) {
> +		rc = nvmem_buffer_reverse(buf, cell->bytes);
> +		if (rc < 0)
> +			return rc;
> +	}
> +
>   	if (len)
>   		*len = cell->bytes;
>   
> diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
> index 104505e9028f..364ac2a61b11 100644
> --- a/include/linux/nvmem-provider.h
> +++ b/include/linux/nvmem-provider.h
> @@ -31,6 +31,8 @@ enum nvmem_type {
>   #define NVMEM_DEVID_NONE	(-1)
>   #define NVMEM_DEVID_AUTO	(-2)
>   
> +#define NVMEM_FLAGS_REVERSE_DATA	BIT(0)

Maybe NVMEM_FLAGS_REVERSE_BYTE_ORDER and some kerneldoc would help new 
users.

--srini
> +
>   /**
>    * struct nvmem_keepout - NVMEM register keepout range.
>    *
> 
