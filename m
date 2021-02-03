Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C692F30DFDC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 17:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234613AbhBCQhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 11:37:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbhBCQhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 11:37:14 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BEFC061573
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 08:36:32 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id z6so25077495wrq.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 08:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zFcqWbEm8Cu56n6+wsv+COvlyDqyqdqbCpQLY+qpOZA=;
        b=UCSgR+eozHPlxrQlLSvv9pNRr7ZtiUKHV/dp5WIwFGewqoG3BGzyOd6Vr0s51iFhSa
         EbMh6k1/sQL3/idrdZ3XZGwDWBkhqpb20CI3fQHxaoAHW11nIdD2CVhsDRaUVUbhhZCv
         /ikpcETybZrOd4AOoOMPZkTmp6SiGGCC0R2olYgR9sSPV0wJyapmva+101y14mDjGDh2
         8nm0vdg3TUFHFwXFgn5TBTBxUh95PJ3ZAeZIqY5KlYoBk2znOlel9sOB8zobyz0xe7qN
         txHUEq6X33WQMdVeywT2NbtWWQdB43Cg7Ng720Nt7OSDZB8U9CH0YcUGelrSbicnSF0j
         f6Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zFcqWbEm8Cu56n6+wsv+COvlyDqyqdqbCpQLY+qpOZA=;
        b=azduWmlDFhnLH39MFpjnUKM62EaOo4e/kmeJ6hApr46oDIhT7B/Vk17Ms3885beFIz
         qpUegagt69jLBXPt/Lnm5kadvDoggVgSBddAUvyq4TGrSy+yeRg1KQwZStoxEx1d9qRJ
         zoz4bDALTJ4qT83Ll7O+AJCj2z9bN2D0rJnafIeod2fxplyqH5QV8cs1d8fxs9nOXYoV
         Y/JxlOzNmWODjFoXwsiaGCNUUHdJbjS1F0OYOfxi/NPITmVZTZwiPXFNKp4njm7Ok4yV
         wllry7hjQLKTI8SfhbY423nOEDw9/4UyyJibYkVyNFcAICpjDsxT5znL8Y9DsHul2Tsi
         Z5ug==
X-Gm-Message-State: AOAM533bkWbxOcxkWDwnn7qCyRIDyenON4VOmpSdWDqevCpvAXeKsecj
        SLBmZUEqZt/C9nGD6xBBF7jZSpQb5+mYjQ==
X-Google-Smtp-Source: ABdhPJzHLze1m320fDsT/msk1w8TvmL9d4VX6UcIDVhxHQGDblRlN71TnyVFWDS6382VCDUzvARTQw==
X-Received: by 2002:a5d:4d8b:: with SMTP id b11mr4521102wru.215.1612370190825;
        Wed, 03 Feb 2021 08:36:30 -0800 (PST)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id o18sm3297841wmh.20.2021.02.03.08.36.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Feb 2021 08:36:30 -0800 (PST)
Subject: Re: [PATCH] nvmem: Kconfig: Correct typo in NVMEM_RMEM
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rob Herring <robh@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
References: <20210203102932.7277-1-nsaenzjulienne@suse.de>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <ac9794b4-1e34-c3a0-ef33-4271bcce3fdc@linaro.org>
Date:   Wed, 3 Feb 2021 16:36:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210203102932.7277-1-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/02/2021 10:29, Nicolas Saenz Julienne wrote:
> s/drivers/driver/ as the configuration selects a single driver.
> 
> Fixes: 2bf4fd065384 ("nvmem: Add driver to expose reserved memory as nvmem")
> Suggested-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>   drivers/nvmem/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied thanks!

--srini


> diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
> index fecc19b884bf..75d2594c16e1 100644
> --- a/drivers/nvmem/Kconfig
> +++ b/drivers/nvmem/Kconfig
> @@ -273,7 +273,7 @@ config SPRD_EFUSE
>   config NVMEM_RMEM
>   	tristate "Reserved Memory Based Driver Support"
>   	help
> -	  This drivers maps reserved memory into an nvmem device. It might be
> +	  This driver maps reserved memory into an nvmem device. It might be
>   	  useful to expose information left by firmware in memory.
>   
>   	  This driver can also be built as a module. If so, the module
> 
