Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B84835E3C8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 18:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344687AbhDMQYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 12:24:22 -0400
Received: from mail-pl1-f175.google.com ([209.85.214.175]:44921 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343579AbhDMQYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 12:24:12 -0400
Received: by mail-pl1-f175.google.com with SMTP id d8so8495810plh.11
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 09:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nIl7E1TX/AmjEPOYNmcXuzmbZMqP3dlvzU0KBMbKOp8=;
        b=nSzO0TfsAWG7iNgIdwtsAmUq/KQC/DsxJOS3lEsyXoGzuDRa+1Twzq2OGvh0ORC4Pf
         lThDb65mpeKuUxaBA4rV0iOYbKPc02HnnHV0wpbswaeTQ0pnXGo+uqvE8PnfjFCxVqK5
         zLhT5B7Zf9WHyhiCFme93bh0kILdQQqsJb8x5itcawnECE89Kd7mviwZzJc22hLAkR1V
         i/AKIiAQDqUObtsRVLLVmYDdyG1F3M3wNmfkJzRfmzwsPwUUSYnDRwDbWn9fRYrTg45x
         toR2J7tbEiH8McjqjvAYoBVy+yeD8iF71ZVjjXxRklO/Us5B1FiceybdOYAAo6ql26yC
         Ma0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nIl7E1TX/AmjEPOYNmcXuzmbZMqP3dlvzU0KBMbKOp8=;
        b=ENIFwHadjpKtbx9kzLlwuOz0BxPhsodZGEKECNnhgTGUQbDLBPiXwTGTKHueWK3WPt
         GF1BNBFpuRs8imeGupHKieERKusI8PqHLeLvBRA/3Can9c27i5kVdLoCZc4+katUOjYd
         spwHSZMkquK20vxla2KmtoK3Sb86nyZqh/WQY+7yewDOs/Ut5rW/ltYpPrA0nGBQJ1Jw
         PmnWW9zfOWaJE8p4mYRZ/GBBBfqFpFM2NwS6V29Vj0Wc/JHb+jPkInkQJMQiUsL5PTgY
         9zAp/5wPReZYvt1kjglowB5VqWFYhfgS46KUJlVjD76MlAMT2iq39kkMYxty/ByC5C6Y
         MqxA==
X-Gm-Message-State: AOAM532c9AxunhII8UJGpQ4kQ6wp3vHdJQIY8SxcuntHjyWt8ttHzL6w
        O3q2Nbgi/oLuZkBSHyYJXNrjYA==
X-Google-Smtp-Source: ABdhPJxlb6v8B6i2jVK3dUKFBjpwHKXt/PKepGp1gb73a7/jwKnFGhz6KNw7qGNer2xolloWLTPHJw==
X-Received: by 2002:a17:90a:d3c6:: with SMTP id d6mr838920pjw.25.1618330972307;
        Tue, 13 Apr 2021 09:22:52 -0700 (PDT)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id k1sm12329200pff.160.2021.04.13.09.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 09:22:51 -0700 (PDT)
Date:   Tue, 13 Apr 2021 10:22:49 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next v2] coresight: trbe: Fix return value check in
 arm_trbe_register_coresight_cpu()
Message-ID: <20210413162249.GA690529@xps15>
References: <20210409094901.1903622-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210409094901.1903622-1-weiyongjun1@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2021 at 09:49:01AM +0000, Wei Yongjun wrote:
> In case of error, the function devm_kasprintf() returns NULL
> pointer not ERR_PTR(). The IS_ERR() test in the return value
> check should be replaced with NULL test.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
> v1 -> v2: remove fixes tag.
> ---
>  drivers/hwtracing/coresight/coresight-trbe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

I have picked up both patches.

Thanks,
Mathieu
 
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
