Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9B738280D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 11:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235862AbhEQJU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 05:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235821AbhEQJUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 05:20:24 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7486DC061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:19:08 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id a4so5600566wrr.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=T/5TWOCY6X4gFs8XapHsMmEazRhVsK/TX4tyFRmCWSM=;
        b=ZcVEXDmFZjnhf7DCda0LUdLBXU6JhSUqA1dLn+R6/IqSgZYQMGAElxkV/mxT/5DV7b
         7MS1APXQeVi+tf++O99fLHKv9zwtaV1U+hu6Ik9b01XaFuJwgmTqSOKyjMUBF5ufG+Pb
         521pC+jf96loU2QvwOckZrZyiZQpk2AYDT/ZMRFlI4aZYu6JwLd3bke/Miif0055DYUy
         EsehwIRrAnIlbwhZbGsgeWzSR+ntbtp0ZPbs5F5SUnw5XXU9LvqxFs0MGU+1fyutEslr
         jJricKsFgmvsDIrTFdrjH1pRzE2TqQxcAgZMHy8M/Fizn17wRIxxkDAW8DsIzyrCTfsv
         cMoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T/5TWOCY6X4gFs8XapHsMmEazRhVsK/TX4tyFRmCWSM=;
        b=IB0SwlFyfMBnZP5aLdMaGcNOcvCAvbS1Jcz8S003wYTx67rNNoifPxzChP7yMp6oT4
         C/vQAy0fqf39+a8exojg/g3fVaQuVlIfAWgSiiSzZZaYJpX3UWdf8f9xDfwGIxgsW0Iw
         B04fgHnHl/IoCBZFOnDcmfGKuS5RtzsjgjhrgePSc/VBCzmQnF04JFxd3sIXKVirYgz8
         IgBiVATfHQ8SLyCcx460vLWa6XkVLNnrswvs2c09hEX8zb7ciAe234pKH3L/L7xtGXPL
         0bsEP7+VC2s1Q/ow3R6G+iTrlYAACw0CIV1QO1r7vUVOHsix+8GUM859qNcT4UckzGs0
         iqxw==
X-Gm-Message-State: AOAM5301TUdJb+BRBQKMA/s7pt4X7B4sfxi+vtEoaulfGmUcfS/fS2pP
        UBBUL6eagEz+ltTKNiKgmpQFkQ==
X-Google-Smtp-Source: ABdhPJxtyz2ttUMdRmA1bJsJkv+XW0VojmjIEw6qHNpeGqYpnwuY5ErPGUXtU6MPqjC6fUSdj++Ckw==
X-Received: by 2002:a5d:4a8c:: with SMTP id o12mr27440001wrq.108.1621243147175;
        Mon, 17 May 2021 02:19:07 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id x13sm6592926wro.31.2021.05.17.02.19.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 May 2021 02:19:06 -0700 (PDT)
Subject: Re: [PATCH V2] nvmem: core: add a missing of_node_put
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        bgolaszewski@baylibre.com, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <10f4577d8a72765780006fbaf7751c8df9c26d0a.1620454485.git.christophe.jaillet@wanadoo.fr>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <8c4ef1a6-8f7a-09b9-5952-1692c426dcd0@linaro.org>
Date:   Mon, 17 May 2021 10:19:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <10f4577d8a72765780006fbaf7751c8df9c26d0a.1620454485.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/05/2021 07:16, Christophe JAILLET wrote:
> 'for_each_child_of_node' performs an of_node_get on each iteration, so a
> return from the middle of the loop requires an of_node_put.
> 
> Fixes: e888d445ac33 ("nvmem: resolve cells from DT at registration time")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---


Applied thanks,

--srini

> v2: Reorder code to delay the 'cell->np = of_node_get(child);'
>      Without this change, we needed a double 'of_node_put' in the last
>      hunk which could be confusing to the reader
> ---
>   drivers/nvmem/core.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index bca671ff4e54..f9c9c9859919 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -686,15 +686,17 @@ static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
>   			continue;
>   		if (len < 2 * sizeof(u32)) {
>   			dev_err(dev, "nvmem: invalid reg on %pOF\n", child);
> +			of_node_put(child);
>   			return -EINVAL;
>   		}
>   
>   		cell = kzalloc(sizeof(*cell), GFP_KERNEL);
> -		if (!cell)
> +		if (!cell) {
> +			of_node_put(child);
>   			return -ENOMEM;
> +		}
>   
>   		cell->nvmem = nvmem;
> -		cell->np = of_node_get(child);
>   		cell->offset = be32_to_cpup(addr++);
>   		cell->bytes = be32_to_cpup(addr);
>   		cell->name = kasprintf(GFP_KERNEL, "%pOFn", child);
> @@ -715,11 +717,12 @@ static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
>   				cell->name, nvmem->stride);
>   			/* Cells already added will be freed later. */
>   			kfree_const(cell->name);
> -			of_node_put(cell->np);
>   			kfree(cell);
> +			of_node_put(child);
>   			return -EINVAL;
>   		}
>   
> +		cell->np = of_node_get(child);
>   		nvmem_cell_add(cell);
>   	}
>   
> 
