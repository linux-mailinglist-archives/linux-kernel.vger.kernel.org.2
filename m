Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6280B3DE7A4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 09:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234275AbhHCH54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 03:57:56 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:56428
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234148AbhHCH5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 03:57:55 -0400
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id 0159A3F045
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 07:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627977464;
        bh=XT27LvhXCtWQtHsOtnNCUTHBoi4eZ4v51vF7/L9hL5E=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=PMdQALfaIl9D+he0/s0x2JUA6RXZfro3cN7ShrjzUEhQh7sJx5j2coRu4HTRIMBK0
         QxcxCrzu7LIlJLUWu5LNs02DDuxBZTyL1kHxoI8OShWHJgeq9d/9Q/WOzWlyrWmRU/
         n3qERHDtAY8k9BRzwAj1wq/nTnbXqL3MtuewqnYpmxpZdRiJS6VtRpAi0kOTk0L6MR
         kFUqhjCEGv02lornXtvXxBL82jM8uaL2e6sBGi7Z+43kA6CR1fwDffjqwiPdovrsko
         UN5VHTAslJKWY6oukcfeoTEIqVbPpscIrznftSLVhOP935RmbKzxbT8L4bF+fT7WK9
         lt5cNKiQ8cU0A==
Received: by mail-ej1-f69.google.com with SMTP id k21-20020a1709062a55b0290590e181cc34so4596825eje.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 00:57:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XT27LvhXCtWQtHsOtnNCUTHBoi4eZ4v51vF7/L9hL5E=;
        b=Ke95Ekd/VogDCISfiLocz7RbVuCmGQWg1OkObShP8h4TrG9ULYyXwUA7Vj2gJ9Yw7X
         gwvO2SFFvqlwDGYa+ictWyCUgevf1bBSmROa56Y12jNs/457/YXoIMG9lZ99Ma04TxGE
         Krm1ColU9YjzMI99LgwT5cXyQZfze4IzCl7777Bdag+GdTEuSzhfKCY8uF8hXJjWtU+G
         PmUzNzs/Acq+FQbIJ3L/a4erfH67Whh3NjzGkRUsnQPaBnXcEI+HIbmg2SoSRq/ch1AT
         E+AMN3Mx9i/YnmfDcuq5eLb5/ncS+3/Y91rCI5mOsdyjC6QWj+E510+Vzebet/JtruIP
         UKBg==
X-Gm-Message-State: AOAM533+5zRKEnoGydrPWWfHjPIcNPuFBN7MkqxacPVwAA0uncXxhtp1
        jm5o95Fj0f5CXn1TgNk1z5dM0VjQFV3cRlxPqSq8ItVMQzBuZFKnGSNp4dToHDXxtoz8aNlbJz+
        ToUV/zksC4n8i1dWzU+ArTTc8S3UidNuG90WGMLC/1g==
X-Received: by 2002:a05:6402:35c7:: with SMTP id z7mr23863135edc.85.1627977463363;
        Tue, 03 Aug 2021 00:57:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy0JGqu++FOOsm7/ygatKxidsI66MQcmo0glaMlJa90SqJmBuO36pTl5KpxAqeMlEHo+jYCNQ==
X-Received: by 2002:a05:6402:35c7:: with SMTP id z7mr23863125edc.85.1627977463203;
        Tue, 03 Aug 2021 00:57:43 -0700 (PDT)
Received: from [192.168.8.102] ([86.32.43.172])
        by smtp.gmail.com with ESMTPSA id t10sm6092065edv.34.2021.08.03.00.57.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Aug 2021 00:57:42 -0700 (PDT)
Subject: Re: [PATCH] memory: fsl_ifc: fix leak of irq and nand_irq in
 fsl_ifc_ctrl_probe
To:     Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     linux-kernel@vger.kernel.org
References: <20210803075159.2823913-1-mudongliangabcd@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <81ccbbb5-5499-7a75-88ba-bae5328ffbf9@canonical.com>
Date:   Tue, 3 Aug 2021 09:57:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210803075159.2823913-1-mudongliangabcd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/08/2021 09:51, Dongliang Mu wrote:
> In fsl_ifc_ctrl_probe, if fsl_ifc_ctrl_init fails, we should free the
> resources allocated by irq_of_parse_and_map.

Your code is doing much more. You also touch nand_irq, not only
fsl_ifc_ctrl_init(). This looks incorrect as IRQ is optional, isn't it?

The problem is entirely different than you described here - the error
paths of fsl_ifc_ctrl_init() and request_irq() are wrong. They do not
release resources in proper paths.



Best regards,
Krzysztof

> 
> Fix this by adjusting the error handling code.
> 
> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> ---
>  drivers/memory/fsl_ifc.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/memory/fsl_ifc.c b/drivers/memory/fsl_ifc.c
> index d062c2f8250f..391390dd3dcb 100644
> --- a/drivers/memory/fsl_ifc.c
> +++ b/drivers/memory/fsl_ifc.c
> @@ -258,12 +258,17 @@ static int fsl_ifc_ctrl_probe(struct platform_device *dev)
>  	/* get the nand machine irq */
>  	fsl_ifc_ctrl_dev->nand_irq =
>  			irq_of_parse_and_map(dev->dev.of_node, 1);
> +	if (fsl_ifc_ctrl_dev->nand_irq == 0) {
> +		dev_err(&dev->dev, "failed to get nand_irq resource for IFC\n");
> +		ret = -ENODEV;
> +		goto err_unmap_irq;
> +	}
>  
>  	fsl_ifc_ctrl_dev->dev = &dev->dev;
>  
>  	ret = fsl_ifc_ctrl_init(fsl_ifc_ctrl_dev);
>  	if (ret < 0)
> -		goto err;
> +		goto err_unmap_nandirq;
>  
>  	init_waitqueue_head(&fsl_ifc_ctrl_dev->nand_wait);
>  
> @@ -272,7 +277,7 @@ static int fsl_ifc_ctrl_probe(struct platform_device *dev)
>  	if (ret != 0) {
>  		dev_err(&dev->dev, "failed to install irq (%d)\n",
>  			fsl_ifc_ctrl_dev->irq);
> -		goto err_irq;
> +		goto err_unmap_nandirq;
>  	}
>  
>  	if (fsl_ifc_ctrl_dev->nand_irq) {
> @@ -281,17 +286,17 @@ static int fsl_ifc_ctrl_probe(struct platform_device *dev)
>  		if (ret != 0) {
>  			dev_err(&dev->dev, "failed to install irq (%d)\n",
>  				fsl_ifc_ctrl_dev->nand_irq);
> -			goto err_nandirq;
> +			goto err_free_irq;
>  		}
>  	}
>  
>  	return 0;
>  
> -err_nandirq:
> -	free_irq(fsl_ifc_ctrl_dev->nand_irq, fsl_ifc_ctrl_dev);
> -	irq_dispose_mapping(fsl_ifc_ctrl_dev->nand_irq);
> -err_irq:
> +err_free_irq:
>  	free_irq(fsl_ifc_ctrl_dev->irq, fsl_ifc_ctrl_dev);
> +err_unmap_nandirq:
> +	irq_dispose_mapping(fsl_ifc_ctrl_dev->nand_irq);
> +err_unmap_irq:
>  	irq_dispose_mapping(fsl_ifc_ctrl_dev->irq);
>  err:
>  	iounmap(fsl_ifc_ctrl_dev->gregs);
> 

