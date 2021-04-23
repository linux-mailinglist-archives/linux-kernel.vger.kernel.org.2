Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE1C3368F65
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 11:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241799AbhDWJbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 05:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbhDWJbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 05:31:07 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5945EC061574
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 02:30:31 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id v6so71612175ejo.6
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 02:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oMjiyMiBGJc+0Yh9uCgxQ9jHi5K1btCkWBwEdFw4f1g=;
        b=YkD+B9KZnDRgs9vlUZ7dzrcUSi899GK1f/nEMD2SCHEkDAWVePAj/u7fNMcAx3GcAy
         hWau99URfYonvON5t9PNa5PnPAMBgWf/qz/4LbCodbM7sLg8C5v1qDQCTuZYaIXqeAlT
         r7sB2wpJB1pZAxWbnoVve6+bV8M7otlhxFVDkSseJpcoLTiGsbYidbRTDdgVUkACsgBN
         5gzryhdLSUc35W02vPY4/xWID/Z3XgDro1RukdKqNm6uuDuTHzx9qE1usg5hX8Og0lmM
         YsWWk4rq2BVQX7B5+Kx4z9czaWbxFELj+5QD8fEiaYYE65Jiny1eI4M3pM3n4NKG8Sj8
         dfYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oMjiyMiBGJc+0Yh9uCgxQ9jHi5K1btCkWBwEdFw4f1g=;
        b=TenhM3fbKWVY/fyBlDnp4yCvxJix62fPw0PAeKcp2Z/SvZ4ufHUAjogCX/6yjRiibz
         fnnHAeEJpbhXepSd68iemb+sDGB3XsfI5VEeDldHATwZwdfUsGb7VeEEOtHMsFvvDRTS
         pEgJ5OeUOE3yW+WBr7s5NY6zROJPehpNVFu/uY+Hy7arWUEJrYXkYP8hqlZnIp1FSDHt
         rQCZMBCueb7y+Ni1AgNtaQy3QiunReEPJU+1UzpNiIa5BQiC7RiyLr/mn9LSPxMUS/sS
         p4vNUfDNGDypUOc379r/FeuJn2lIsFKc5bRq6K5+KPUtvUInHSbkL3Da7gdth5PiEHCR
         FUQg==
X-Gm-Message-State: AOAM5319oA616oG++tlOkykZnPVs1FZcnkjgYKTdy5rKmTP87U0gDPFD
        X24kU9s+ZIGgrdIXMoL1BgSMdQ==
X-Google-Smtp-Source: ABdhPJwdepM1uqbgLJTgk6NWV1jHk5422Xe4Gg57pb7hFN0aaJfr+8r5WhbWOuyrzuxI0sAQvJaX2w==
X-Received: by 2002:a17:906:eb09:: with SMTP id mb9mr3148206ejb.452.1619170230021;
        Fri, 23 Apr 2021 02:30:30 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id o20sm4248614eds.65.2021.04.23.02.30.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Apr 2021 02:30:29 -0700 (PDT)
Subject: Re: [PATCH] nvmem: core: add a missing of_node_put
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        bgolaszewski@baylibre.com, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <2ebc18d9da622afe8681c18349b501a516253041.1618949512.git.christophe.jaillet@wanadoo.fr>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <93e8b92c-8f4e-9990-ac4d-9688bbaaa6f6@linaro.org>
Date:   Fri, 23 Apr 2021 10:30:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <2ebc18d9da622afe8681c18349b501a516253041.1618949512.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/04/2021 21:12, Christophe JAILLET wrote:
> 'for_each_child_of_node' performs an of_node_get on each iteration, so a
> return from the middle of the loop requires an of_node_put.
> 
> Fixes: e888d445ac33 ("nvmem: resolve cells from DT at registration time")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>   drivers/nvmem/core.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index bca671ff4e54..4375e52ba6c2 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -686,12 +686,15 @@ static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
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
>   		cell->np = of_node_get(child);
> @@ -717,6 +720,7 @@ static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
>   			kfree_const(cell->name);
>   			of_node_put(cell->np);
>   			kfree(cell);
> +			of_node_put(child);

two of_node_put looks bit confusing to the reader, can you move the

cell->np = of_node_get(child); just before nvmem_cell_add(cell);
so that we can remove extra put.

Was this reported by some kind of static analysis tool?

--srini



>   			return -EINVAL;
>   		}
>   
> 
