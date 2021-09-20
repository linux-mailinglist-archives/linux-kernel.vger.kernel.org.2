Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 934614110EA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 10:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235742AbhITI2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 04:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235727AbhITI2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 04:28:00 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40805C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 01:26:33 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id w17so19208629wrv.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 01:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Sd2zasa8jsIrDfE+uKpeLHxh1coC9+sVR27g2clwkhM=;
        b=ckRxkYg0UKty5XJskZHyKC1uz5SKwEvg6hMxqc/s62FhCOm6PxEQHRhWcKB9WAoSJp
         GO4n/go5FJ+TTQdsm5+lFhx3+c9s44JCpKFqB96Py8X5+8mSfZxLDql4uVACODWS03lw
         osn3vXU5pyd4zEsoet9nqiW6CJ7lQqYzMd2AClGhOZqoA/1hYjPwwafSU9EWemy0XmgD
         fNHCxgzxURbgJYyH1nHQvqUL/NwJg6HbHMpaEri8rjH3AZSIUVr7F7CLvLO3CIzFZpL/
         AePngvOzTZNvxjRvw4wn+8WMUODP+GsiasazeQaiTRMy6wrFCNLZzlBKQI3u2jXhTYAN
         EpwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Sd2zasa8jsIrDfE+uKpeLHxh1coC9+sVR27g2clwkhM=;
        b=0bw34owZINsqZihH1Byb1a9Z+VYytKywbMFrxLGj8YIO9a3t8lA/1b6jviMDQEnzL/
         NkEVLJt2Qmt5Qe66+1Q4bZsDvTXryHAABJwpvgsGHQu2edhy8Ci/O1fEHSwDQiUSHyDD
         deHg1imuejk7b7dSGIROVLNM1Lf3S/0LAIFq+RpMadqUvskZayYxo7IMnmr5vRNeUaou
         eejSYwbbOEYHLQx5AmevBEqiQmXFN+OPTM5W4kt1yEfYkgi7EVX5HWRI31VdZPLXqB9C
         p6vWnOVHXmLqCm4X7dTdMMjcrWHoeD+xlQMO6KkZWca/2RiFQxDHNqo1YqJ3z/eaYZME
         EeBg==
X-Gm-Message-State: AOAM531Pn3x3+gySUHFBS24OBQvYLX5Ku7pPjek5vMLzoUqQ/nCj8nY8
        CCoFmgFlMNzgkURsaphU6DYSbQ==
X-Google-Smtp-Source: ABdhPJw/mT3WUCPVZ29jbrBrgnE8L+20CP0Qbr5FtszQo+bi6bIe+hZ7C0epV27RPl5aeN5zYF9n9g==
X-Received: by 2002:a5d:6d8e:: with SMTP id l14mr27071868wrs.196.1632126391761;
        Mon, 20 Sep 2021 01:26:31 -0700 (PDT)
Received: from [172.20.10.7] ([37.169.24.17])
        by smtp.gmail.com with ESMTPSA id c132sm6707022wma.22.2021.09.20.01.26.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 01:26:31 -0700 (PDT)
Subject: Re: [PATCH] regulator: pwm-regulator: Make use of the helper function
 dev_err_probe()
To:     Anand Moon <linux.amoon@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>
References: <20210919211129.4364-1-linux.amoon@gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <7dcee097-9119-1987-9bb5-777d541cc9f7@baylibre.com>
Date:   Mon, 20 Sep 2021 10:26:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210919211129.4364-1-linux.amoon@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/09/2021 23:11, Anand Moon wrote:
> devm_regulator_register can return -EPROBE_DEFER if the
> regulator is not ready yet. Use dev_err_probe() for
> pwm regulator resources to indicate the deferral reason
> when waiting for the resource to come up.
> 
> Fixes: 0cd71b9a43ad ("regulator: pwm: Don't warn on probe deferral")
> 
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  drivers/regulator/pwm-regulator.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-regulator.c
> index 7629476d94ae..451e57a739f8 100644
> --- a/drivers/regulator/pwm-regulator.c
> +++ b/drivers/regulator/pwm-regulator.c
> @@ -382,9 +382,9 @@ static int pwm_regulator_probe(struct platform_device *pdev)
>  					    &drvdata->desc, &config);
>  	if (IS_ERR(regulator)) {
>  		ret = PTR_ERR(regulator);
> -		dev_err(&pdev->dev, "Failed to register regulator %s: %d\n",
> -			drvdata->desc.name, ret);
> -		return ret;
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "Failed to register regulator %s: %d\n",
> +				     drvdata->desc.name, ret);

No need to keep ret and print it since it will be printed by dev_err_probe, pass directly PTR_ERR(regulator) and drop the ": %d" from the error string.

Neil


>  	}
>  
>  	return 0;
> 

