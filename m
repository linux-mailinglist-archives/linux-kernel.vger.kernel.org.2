Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 030E345754C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 18:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236600AbhKSRWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 12:22:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236543AbhKSRWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 12:22:05 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2404EC06173E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 09:19:03 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id d27so19342421wrb.6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 09:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HpL2qzn8s1pMxSKPVy6BFQOEtm3mwh6KOgnbIGnoQRw=;
        b=BS2Q7zU4V9BqYkMwfKbF71WrJNfRD8dSX+M2CI/qIDQLw0WG6qygNhan4A78uDhxKb
         O9rs1MSC5I5ObTyZP8bg5NCKRxLkqUrP9S2Lvq+X6Tigs57Jp/bpqxyKBc+TGO6+YvYa
         6OwtGO3N8Z7btb7qzw7Adufr88pK+TgR4+xHzhMTkQ6Q+1uVQFDUTftWDUGV14SUi4nN
         dPiHqYk/qU4PFnBgHs6LV80OsEq41pzqAqtX1jq2IYksvNZaGpSHKMrzsIZwuORx9pV3
         WXe3Crem2qEoj3au8XRFyi29FKBmruaAHbPuFhUiFM60PW+0xVXmAzoi4x4vzEbzw+h2
         G1WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HpL2qzn8s1pMxSKPVy6BFQOEtm3mwh6KOgnbIGnoQRw=;
        b=myTXIYr0Tqasv5107Q73wjpVvjHXV/EmxnfwkUpUmDhz8joZL9LDzcC+43uJCUK1YA
         oKf/CICL3KKn7jY0wqlWIFmUbrTvT/4omF8witWDFkdNuwrnaSlOI/ghmInfeBtEXDcd
         Xv5JkMIM5U/gnT+COxVTrP+wlog4KqJO1KbuN0Tkl/+RZTPK0X6MuEgI6hVdUsQPK0sf
         QRLLOO2j/EJst81Mw1KZxYNmj6vARBELP+78nDV8D67tbgzBngJIcyP5HZ84UDwZ+wx2
         tVNfXVkOtCSgGF74pDGU47k4cVp7UXrYdVXb9l/Ok9UttQc4Pr+kZ07pXTSVS9m7Edtg
         GQRw==
X-Gm-Message-State: AOAM531dxnK+WBpneO55HWqHocxF1PaBUfiAK8d8OLVPlok2oCnGz802
        0kOq/0ryAatdkVxP7o4nftA5SA==
X-Google-Smtp-Source: ABdhPJy2URfxT8KlUV/UQ4ChP+6mnancHBoU5VMuPGKRmQUQKwehJR4L0S9VQPWrBN+3Ks+JmJMObA==
X-Received: by 2002:adf:b34f:: with SMTP id k15mr9377107wrd.125.1637342341594;
        Fri, 19 Nov 2021 09:19:01 -0800 (PST)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id n1sm332340wmq.6.2021.11.19.09.19.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 09:19:01 -0800 (PST)
Subject: Re: [PATCH 2/6] dt-bindings: nvmem: mediatek: add support for mt8195
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
 <20211107075646.4366-2-chunfeng.yun@mediatek.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <6aacd28e-346a-68e6-7a76-d7337e0480a2@linaro.org>
Date:   Fri, 19 Nov 2021 17:18:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211107075646.4366-2-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/11/2021 07:56, Chunfeng Yun wrote:
> Add compatible for mt8195
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Applied thanks,

--srini

> ---
>   Documentation/devicetree/bindings/nvmem/mtk-efuse.txt | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/mtk-efuse.txt b/Documentation/devicetree/bindings/nvmem/mtk-efuse.txt
> index ec70c5b7a340..39d529599444 100644
> --- a/Documentation/devicetree/bindings/nvmem/mtk-efuse.txt
> +++ b/Documentation/devicetree/bindings/nvmem/mtk-efuse.txt
> @@ -8,6 +8,7 @@ Required properties:
>   	      "mediatek,mt7623-efuse", "mediatek,efuse": for MT7623
>   	      "mediatek,mt8173-efuse" or "mediatek,efuse": for MT8173
>   	      "mediatek,mt8192-efuse", "mediatek,efuse": for MT8192
> +	      "mediatek,mt8195-efuse", "mediatek,efuse": for MT8195
>   	      "mediatek,mt8516-efuse", "mediatek,efuse": for MT8516
>   - reg: Should contain registers location and length
>   - bits: contain the bits range by offset and size
> 
