Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B734A45ACCF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 20:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236366AbhKWTvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 14:51:11 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:34760
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232144AbhKWTvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 14:51:09 -0500
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 464573F225
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 19:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1637696880;
        bh=awbGKqFJMvM06q00ru2W6cjtSUOX907qfBZEpTNwf+o=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=tbd6PVVj0ehRwALQ/yYF4ALFQ/uWeCvT1xT0vn/wQQ38womLnGG0PFsWd6kTWjagH
         VN0Ci/HbujoMLwqZvMwKFWwMRxlD7rS2g+Asd8hH4QiRJu+MVQb9SQgUUkJb8qiUW/
         H3eBz9GF3eGkeV8Ew1ZALyCIvtUZky2nJ8tgBGO3iC4qBsB46CmFg+VlKAR/RxQkWl
         aQbi2Nfy53StxQDAeLyJhygKftyy84TfEyyTJGnLFWLoVmkpOnQ7s0FyqCC1pcf+jx
         3kRp0Lu91xQQJzi6yfOkZP98aFQHMNm+fJu6nyRsxbj4gAcnQgNfnolYUAfO5QwjMZ
         k5GPvB/UVb2eg==
Received: by mail-lf1-f71.google.com with SMTP id q26-20020ac2515a000000b0040adfeb8132so144581lfd.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 11:48:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=awbGKqFJMvM06q00ru2W6cjtSUOX907qfBZEpTNwf+o=;
        b=SpHffk5OMGLYykOrAWVNe5M4rkgAKz6s14KzVOREAlzQh3AvCkkFJZojC9xBOW3okU
         aoh0RY5jXLZFYkjzb+IhnaDtZw0BeM/MR3T1felN3SkIjujnf1iCndhvNNquxQ42l0Xb
         ADRt0JxqQiJnMoJO23bjy0z8tpiUHrh5edCS1dQ90yIPlituSwncAtg6tIcWuEd+KElO
         J7FbwapdGylCITk4qexwwjRhn7osTHb1/50PDcj8PeF9NxFtd2daggk41sdnsn22t2Cf
         gmDWrmHOGbaVYlKR47DtzB0dVAboa4y5gaTaG9H2nxtAIQ5lU4d9x4RIZK37M26YNi3K
         1qOg==
X-Gm-Message-State: AOAM531pcFmuY8d5wfF/ZZou7uBciuOQc08d4T7v/7bDH6yLY4v8NCtn
        0EHeyxKh3sD6zY+BwAVRuQtg5emwACWvExFRb9AMTlX+ZdEcl2MeqvreUSNuWf2hCRu5rtfENE5
        HGVmIeJ5TWxGUd9uP8/eQ4NzfGvxb337FRRo1pP2LSQ==
X-Received: by 2002:a2e:9acf:: with SMTP id p15mr8706075ljj.213.1637696879212;
        Tue, 23 Nov 2021 11:47:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw5DSe7GPue3q18G0oImIITmr9qz4TwOJH/oHfODp8pgS8jydQV278sOB6lv9XS+71ur7RsjA==
X-Received: by 2002:a2e:9acf:: with SMTP id p15mr8706051ljj.213.1637696879047;
        Tue, 23 Nov 2021 11:47:59 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id z14sm362478lfg.173.2021.11.23.11.47.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Nov 2021 11:47:58 -0800 (PST)
Message-ID: <a28532b1-bfa0-031b-91cc-070cad557599@canonical.com>
Date:   Tue, 23 Nov 2021 20:47:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH 1/4] dt-bindings: memory-controllers: ti,gpmc: Add
 compatible for AM64
Content-Language: en-US
To:     Roger Quadros <rogerq@kernel.org>, tony@atomide.com
Cc:     kishon@ti.com, nm@ti.com, vigneshr@ti.com,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
References: <20211123102607.13002-1-rogerq@kernel.org>
 <20211123102607.13002-2-rogerq@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211123102607.13002-2-rogerq@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/11/2021 11:26, Roger Quadros wrote:
> AM64 SoC contains the GPMC module. Add compatible for it.
> 
> Newer SoCs don't necessarily map GPMC data region at the same place
> as legacy SoCs. Add reg-names "data", to provide this information to
> the device driver.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
>  .../bindings/memory-controllers/ti,gpmc.yaml         | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/ti,gpmc.yaml b/Documentation/devicetree/bindings/memory-controllers/ti,gpmc.yaml
> index 25b42d68f9b3..1869cc6f949b 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/ti,gpmc.yaml
> +++ b/Documentation/devicetree/bindings/memory-controllers/ti,gpmc.yaml
> @@ -23,13 +23,20 @@ properties:
>      items:
>        - enum:
>            - ti,am3352-gpmc
> +          - ti,am64-gpmc
>            - ti,omap2420-gpmc
>            - ti,omap2430-gpmc
>            - ti,omap3430-gpmc
>            - ti,omap4430-gpmc
>  
>    reg:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 2
> +
> +  reg-names:
> +    items:
> +      - const: cfg
> +      - const: data

I see your driver handles cases with only one reg item, but I have other
question - is it correct to have older (ARMv7) platform with two reg
items? Or can am64-gpmc come with only one reg?
IOW, I am surprised there is no if-else case precising this minItems
requirement for different SocS.

>  
>    interrupts:
>      maxItems: 1
> @@ -44,6 +51,9 @@ properties:
>      items:
>        - const: fck
>  
> +  power-domains:
> +    maxItems: 1

Similar, but looks like a weaker requirement - could an older SoC define
power-domain?

> +
>    dmas:
>      items:
>        - description: DMA channel for GPMC NAND prefetch
> 


Best regards,
Krzysztof
