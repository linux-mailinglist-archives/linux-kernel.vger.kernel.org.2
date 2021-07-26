Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCA233D54AF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 09:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbhGZHPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 03:15:04 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:59606
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231848AbhGZHPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 03:15:03 -0400
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id 4E2053F34A
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 07:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627286131;
        bh=FvaN4SdC0zxcpggC8bSxsPEztnFEL+6bxNge1diRFzQ=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=PZcRFcihiy2U7YbiB7bJ7YLh3MxqoWQxoGj8dmRLBIEd3X71wrpwHaaUXhs5BXCwc
         jzXrYvWp5r0elxE8aapXiIzSsCWt+hTQJyur5i7Cfrcw4m7vdwiFQY01quT3QTSuax
         TgZZ+Pa3LxGsPWWjSlBKPBbAC3gvBRkv2BZbtXh+DOE9/KIbhbkn7ZDAGCf7EmR7hY
         Zv9e8J+9+SIYnoIDHyjcZs1EWbPrkpgsKDb6YHVQaXdNqdHurL6vRI8CE11yf0Tnte
         t9nqkxag+ItEOM3nYBPmJ59ksZkn+PO6Bz/wl7OiH+xcV8OBXuxyC2W/E4BmBzkFTc
         UUUuRDQoLS2Zw==
Received: by mail-ej1-f72.google.com with SMTP id e8-20020a1709060808b02904f7606bd58fso317999ejd.11
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 00:55:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FvaN4SdC0zxcpggC8bSxsPEztnFEL+6bxNge1diRFzQ=;
        b=fN9yKQPVBQ8Dhhp1pp0joXsxBvARFk/VVdQmmW2zrXLys7+NQ6yJe5Tr9N++X97vdN
         66uY+lFuYjXPNSE9vDZao3iaDJvEkBCUOdi7b1jQoSoRu/tJ92J+d3XvBmQpohhRyiXw
         3I+yEN86vMxaUYWOhIp2kue2fefRejFPQABALfGEWw26fxtYCt57FErKdt9SXV9W7KaD
         GaAQfe6WFcZeXqgybdnWURqAK3kEZw6ElDC/bQiwPjgh7Yfox33oyrpTkR0U1g7kwuUy
         6okQuVvs/U+AmLNpW8t4GQ8RtxV65UaybSUDSFFKQJhYnM49UT4tfqQe7e8tM7OY/2tr
         +lZA==
X-Gm-Message-State: AOAM532Uqv2XeRos/4Q8CG3wEbx6H/B7X2MWyXZe4SXaXkW4xcnXwpry
        rcJGP3mfV8Egzjmg8IxJ44p/tQPdEU/487hm6Or8SufOKdgVM3P+4JtIlfs5r0bdLfnzGlE2oof
        dSyfMUX+PsPRdcozIo0hsAxK2sIsNEECl7TVTDXXMQw==
X-Received: by 2002:a05:6402:b8a:: with SMTP id cf10mr19704687edb.61.1627286129510;
        Mon, 26 Jul 2021 00:55:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzs0UmEkOvoygFFaLmTFWp2A8ytDvkEF8K93BiDtS5olNm+AVEIwQfY3opR+oXzikcn12XV+A==
X-Received: by 2002:a05:6402:b8a:: with SMTP id cf10mr19704680edb.61.1627286129380;
        Mon, 26 Jul 2021 00:55:29 -0700 (PDT)
Received: from [192.168.8.102] ([86.32.47.9])
        by smtp.gmail.com with ESMTPSA id w13sm4023959ede.24.2021.07.26.00.55.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jul 2021 00:55:29 -0700 (PDT)
Subject: Re: [PATCH] nfc: s3fwrn5: remove unnecessary label
To:     samirweng1979 <samirweng1979@163.com>, k.opasiak@samsung.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        wengjianfeng <wengjianfeng@yulong.com>
References: <20210726032917.30076-1-samirweng1979@163.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <94177278-c8fe-89f3-97f0-7010078b9ba2@canonical.com>
Date:   Mon, 26 Jul 2021 09:55:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210726032917.30076-1-samirweng1979@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/07/2021 05:29, samirweng1979 wrote:
> From: wengjianfeng <wengjianfeng@yulong.com>
> 
> Simplify the code by removing unnecessary label and returning directly.
> 
> Signed-off-by: wengjianfeng <wengjianfeng@yulong.com>
> ---
>  drivers/nfc/s3fwrn5/firmware.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Best regards,
Krzysztof

> diff --git a/drivers/nfc/s3fwrn5/firmware.c b/drivers/nfc/s3fwrn5/firmware.c
> index eb5d7a5b..1421ffd 100644
> --- a/drivers/nfc/s3fwrn5/firmware.c
> +++ b/drivers/nfc/s3fwrn5/firmware.c
> @@ -421,10 +421,9 @@ int s3fwrn5_fw_download(struct s3fwrn5_fw_info *fw_info)
>  
>  	tfm = crypto_alloc_shash("sha1", 0, 0);
>  	if (IS_ERR(tfm)) {
> -		ret = PTR_ERR(tfm);
>  		dev_err(&fw_info->ndev->nfc_dev->dev,
>  			"Cannot allocate shash (code=%d)\n", ret);
> -		goto out;
> +		return PTR_ERR(tfm);
>  	}
>  
>  	ret = crypto_shash_tfm_digest(tfm, fw->image, image_size, hash_data);
> @@ -433,7 +432,7 @@ int s3fwrn5_fw_download(struct s3fwrn5_fw_info *fw_info)
>  	if (ret) {
>  		dev_err(&fw_info->ndev->nfc_dev->dev,
>  			"Cannot compute hash (code=%d)\n", ret);
> -		goto out;
> +		return ret;
>  	}
>  
>  	/* Firmware update process */
> @@ -446,7 +445,7 @@ int s3fwrn5_fw_download(struct s3fwrn5_fw_info *fw_info)
>  	if (ret < 0) {
>  		dev_err(&fw_info->ndev->nfc_dev->dev,
>  			"Unable to enter update mode\n");
> -		goto out;
> +		return ret;
>  	}
>  
>  	for (off = 0; off < image_size; off += fw_info->sector_size) {
> @@ -455,7 +454,7 @@ int s3fwrn5_fw_download(struct s3fwrn5_fw_info *fw_info)
>  		if (ret < 0) {
>  			dev_err(&fw_info->ndev->nfc_dev->dev,
>  				"Firmware update error (code=%d)\n", ret);
> -			goto out;
> +			return ret;
>  		}
>  	}
>  
> @@ -463,13 +462,12 @@ int s3fwrn5_fw_download(struct s3fwrn5_fw_info *fw_info)
>  	if (ret < 0) {
>  		dev_err(&fw_info->ndev->nfc_dev->dev,
>  			"Unable to complete update mode\n");
> -		goto out;
> +		return ret;
>  	}
>  
>  	dev_info(&fw_info->ndev->nfc_dev->dev,
>  		"Firmware update: success\n");
>  
> -out:
>  	return ret;
>  }
>  
> 
