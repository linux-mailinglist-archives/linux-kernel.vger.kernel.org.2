Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6384B45753A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 18:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236589AbhKSRVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 12:21:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236573AbhKSRVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 12:21:39 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0738C061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 09:18:37 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id d5so19381215wrc.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 09:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HMba7SAsUGH242uSK3/7WP5AS9Iw2TY41OiyipBfcUg=;
        b=rrZM4BffqfpVGWzJbsm3CnzC/M4DKrHytojXrXGboR2q1AMTdCzqbRpiaf2ey5xE41
         Km9W7Lkh48V7hAUhmpkdS1rD9wOFTSIPdTKzJwgb38RKSHBcqqqZlW3/82bGhz65gZ64
         xxdKmlLHoBUxKul8mSJ1vOkoDr0/oXMunSgKuJWuxvrwc7fpnsExrWc3gvb+2Lpv56kr
         bVw44NVK6JrFoZBOyq/Bv0fSBy1PnWsAnDKmFn7P8b4lwrxhXXHHv/aMzY+6Akh2hBka
         JaTXFPsYd4u7+8D+it/39z8VvQt/29oNb8oss9AQujqXUvEFaj/4kqD95Rv7nAD7hIjR
         vBeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HMba7SAsUGH242uSK3/7WP5AS9Iw2TY41OiyipBfcUg=;
        b=a2hF0hWyWqijyIe9xhAltAxrF0n3KOlg9B9mR+cjapMT9MyG1koR6G5ETjwvJJufxI
         lI9vkudfKez367AlNGgu0nVYoTmK5wS5rP4oouqxeEMMQD1fjgJQbv1wxhfDuuOjIETn
         fcTN9q9oag71Lrp5bAMyFDbHBHIF5U3PVMTHVMVzoq8SI0JVMykovK223ab40Tt9wMoC
         UqKpaHwGc46N3yqnG5AdyWFBV31amrlSfPc18Htj4reqMpx+IlKjHhkf0EzHhyIzw3cg
         TF01T2imGgZu52eHLhooZogEbuFf55GRm6LpM/L/3svJ9WTdQ9vctJMn/yD9abKR8K6b
         ur+A==
X-Gm-Message-State: AOAM533hOXMXWqwOOXjdOASkpFFqWv04igLm2D5OCjy+pKxZKpoiBl5j
        rzkoLlfMhmktOf/njjgleQFHRA==
X-Google-Smtp-Source: ABdhPJyqYg0ItuAFmaZy7wd0/6w1bO0CFWmFrGNkYO6UjS5N5ahOt4R4EqnmqUkG9sOYmRybrUjNyQ==
X-Received: by 2002:a05:6000:188c:: with SMTP id a12mr9445364wri.92.1637342316277;
        Fri, 19 Nov 2021 09:18:36 -0800 (PST)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id g198sm258695wme.23.2021.11.19.09.18.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 09:18:35 -0800 (PST)
Subject: Re: [PATCH 4/6] dt-bindings: phy: mediatek: tphy: support software
 efuse load
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org,
        Eddie Hung <eddie.hung@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Yz Wu <yz.wu@mediatek.com>
References: <20211107075646.4366-1-chunfeng.yun@mediatek.com>
 <20211107075646.4366-4-chunfeng.yun@mediatek.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <71f83770-b12f-2452-d24b-ae1be9b5b075@linaro.org>
Date:   Fri, 19 Nov 2021 17:18:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211107075646.4366-4-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/11/2021 07:56, Chunfeng Yun wrote:
> Add optional property nvmem-cells and nvmem-cell-names to support
> software efuse load, this helps to fix the efuse bit shift issue
> on mt8195 etc.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Applied thanks,

--srini

> ---
>   .../devicetree/bindings/phy/mediatek,tphy.yaml | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml b/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
> index 9e6c0f43f1c6..05ee274b4b71 100644
> --- a/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
> +++ b/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
> @@ -160,6 +160,24 @@ patternProperties:
>                   - PHY_TYPE_PCIE
>                   - PHY_TYPE_SATA
>   
> +      nvmem-cells:
> +        items:
> +          - description: internal R efuse for U2 PHY or U3/PCIe PHY
> +          - description: rx_imp_sel efuse for U3/PCIe PHY
> +          - description: tx_imp_sel efuse for U3/PCIe PHY
> +        description: |
> +          Phandles to nvmem cell that contains the efuse data;
> +          Available only for U2 PHY or U3/PCIe PHY of version 2/3, these
> +          three items should be provided at the same time for U3/PCIe PHY,
> +          when use software to load efuse;
> +          If unspecified, will use hardware auto-load efuse.
> +
> +      nvmem-cell-names:
> +        items:
> +          - const: intr
> +          - const: rx_imp
> +          - const: tx_imp
> +
>         # The following optional vendor properties are only for debug or HQA test
>         mediatek,eye-src:
>           description:
> 
