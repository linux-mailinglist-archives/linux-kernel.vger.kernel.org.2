Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8433E414355
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 10:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233559AbhIVIOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 04:14:40 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:50522
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233435AbhIVIOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 04:14:40 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id BC1383F337
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 08:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632298389;
        bh=80bGBU12rUlNRidP/sWAT3qbzYE1T9TKkUcvmDq0zq0=;
        h=Subject:To:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=iLs4Vgrm/Md5Y095KkRx03Vup+6F/imfjEmcGooi8RJJgoXUHBsoieQWK9XFvlHs2
         xjnnTVZ3BRoX/eV8lVbBnnx6+w7GV/NqiL+1Npp3mBNgDSbIWnH7mFSD6WIWx56YXt
         NVEI4tJ4OX3M+yFwKIHBQjd5wyegAa+BYhOeQ197JFDvLPyaRvZE2L3Wpxka9TB60F
         ZV5koE9Jpu1A5W6UdxBtJFDL5Y2c8V7rggeiwXBoxwKeoMOk7vHf9NPJCZoVXPfkhZ
         knsKHD/mhvq7mLZqU3tHSuUJ9qSFk/98rN/ollp/Cm+9ZzkbWyA+AHdzSdl+M5++pt
         9CGyqJ75/Rb3w==
Received: by mail-wr1-f71.google.com with SMTP id s13-20020a5d69cd000000b00159d49442cbso1380813wrw.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 01:13:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=80bGBU12rUlNRidP/sWAT3qbzYE1T9TKkUcvmDq0zq0=;
        b=aIbwcSr/aac3Ike7nkk+tBWfaR82YF0QO8+xo6PTIN8MCgmLw/6tqRcP+aAxRBF4Ph
         dL4GJ1hSaA/p4SXBrAkUEMCeXBbO+1JMfAt54xAhZtHbWgs/P7f5gsyFn/Y2QFbHiRk6
         HX9ISMccnb+qJH9H10HY5T1vL7dTjmhR2NDRZPQPyGe59MUGcBgq1Y+ry+kS2mrbjpiy
         SLkOyXrtKH6i0Lwb3QiS+NKDx+9Zy/rgNiQuJTng/WGEhgo5ttTa+RxkfjwvIKIJuYiY
         jqBRMlrFBFHD2w/aQ6CVN5+4wnFEPGRl7yr2iH1pBj1FZyyH8YFu8fEk4Hxw5YqiSfZb
         HBvg==
X-Gm-Message-State: AOAM530QLT9jQ2LQ45dk1Hf4zT7QXi1V1KqYDxbhW+C/pw2gyf9E4p29
        RkZMsxpwm1zswRkdI976VDWvBQcWpuTld30CaZJYp/h7RNyZiMcyDRuHdFCVOgxlmC4qf4Na0Oq
        uNZDgXkothGcmuJTJIoqmGKD7OnLuIQdtvO+5rEYzUw==
X-Received: by 2002:a05:600c:ac5:: with SMTP id c5mr9214674wmr.191.1632298389098;
        Wed, 22 Sep 2021 01:13:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz9vYG0YfFn+hqjyyuQXUSogmFSjWHJfx5+BT9Gqqh8HT9sF2aboq6ZdX0NT3b4aKk0CYVzsw==
X-Received: by 2002:a05:600c:ac5:: with SMTP id c5mr9214651wmr.191.1632298388872;
        Wed, 22 Sep 2021 01:13:08 -0700 (PDT)
Received: from [192.168.0.134] (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id 14sm5696458wmb.29.2021.09.22.01.13.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Sep 2021 01:13:08 -0700 (PDT)
Subject: Re: [RESEND PATCH] mfd: Add missing of_node_put for loop iteration
To:     Lee Jones <lee.jones@linaro.org>,
        Samuel Ortiz <sameo@linux.intel.com>,
        linux-kernel@vger.kernel.org
References: <20210528115126.18370-1-krzysztof.kozlowski@canonical.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <57a78707-e01c-29a3-b899-8715aab6c6c4@canonical.com>
Date:   Wed, 22 Sep 2021 10:13:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210528115126.18370-1-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/05/2021 13:51, Krzysztof Kozlowski wrote:
> Early exits from for_each_child_of_node() should decrement the
> node reference counter.  Reported by Coccinelle:
> 
>   drivers/mfd/mfd-core.c:197:2-24: WARNING:
>     Function "for_each_child_of_node" should have of_node_put() before goto around lines 209.
> 
> Fixes: c94bb233a9fe ("mfd: Make MFD core code Device Tree and IRQ domain aware")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  drivers/mfd/mfd-core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
> index 79f5c6a18815..684a011a6396 100644
> --- a/drivers/mfd/mfd-core.c
> +++ b/drivers/mfd/mfd-core.c
> @@ -198,6 +198,7 @@ static int mfd_add_device(struct device *parent, int id,
>  			if (of_device_is_compatible(np, cell->of_compatible)) {
>  				/* Ignore 'disabled' devices error free */
>  				if (!of_device_is_available(np)) {
> +					of_node_put(np);
>  					ret = 0;
>  					goto fail_alias;
>  				}
> @@ -205,6 +206,7 @@ static int mfd_add_device(struct device *parent, int id,
>  				ret = mfd_match_of_node_to_dev(pdev, np, cell);
>  				if (ret == -EAGAIN)
>  					continue;
> +				of_node_put(np);
>  				if (ret)
>  					goto fail_alias;
>  
> 

Dear Lee,

This was already a resend. Any comments from your side?

Best regards,
Krzysztof
