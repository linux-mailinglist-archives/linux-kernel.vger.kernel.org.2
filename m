Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9EA334CEA0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 13:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbhC2LRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 07:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbhC2LQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 07:16:57 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2F0C061574;
        Mon, 29 Mar 2021 04:16:56 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id j4-20020a05600c4104b029010c62bc1e20so6461526wmi.3;
        Mon, 29 Mar 2021 04:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hZD7O7xv0sSMIqPZrXXyTfz7eN6fc6s3WRzXvCjxPyE=;
        b=uiCB4H6VmK9ryuN7AOWXE9kJq0jXWFraCJliWmzp8R2o51OVvTJ9Hd9CFLrURFQ+Oe
         CgNAldNeNvBRWloZgxyab4US69T46fK6qnSdgCgejbh96fEQHbEx7Lye6iwLqUjtoRVF
         cLpqU14xaxEhCoOJQDf2jADS5mFtVj1QP4UJ2dZeyKDy3xNNj4uEDfs+fBhb5OsYowJW
         2wJTeMVlByRWgd/BD6RnXA5c22mCBNDJ0QT+2ancYwU9pAu05Hx0SV1+JFjLsfoE/Zg9
         jXKvJec3WMZrOUBHliFggTuuAcJogXAcUeciuWGNnX1xfZNvSTrEfLHqzY/WNArJBoUx
         7KCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hZD7O7xv0sSMIqPZrXXyTfz7eN6fc6s3WRzXvCjxPyE=;
        b=G70CRy0I1EMl5/Gnaze4a3vcrcMGjAmD/k9ZKDdfWsamXu4Iil9p5dLXIu3XR/HVXl
         JupzohAcVR0CbqzRa1mq8k5twqSMkuRtBFOSgP0W+XfbSiAh4uhmjiLhvuqoeTZxOZlL
         gxR1KNouns8NmljLZ1yFbvoreQDgRSjN1bF6DNqwNCfFheUY8wkfwnLkax/r0OkxAosH
         2gdZamG0YmBg/OyeZr0/x+MDWB749ee4YSeqpANvn0om2j4z11Xue6ABxhJNPkTHo8V9
         ZWTMExrS2sgkAu+8psADgo2NVaSLRK6hfKH8fdHSmiVJjtivQJCkrq4Q9Q3T2QDbK7DU
         LfiA==
X-Gm-Message-State: AOAM532akEriflnK6SXz6LfguwlGsUN39ZYdEL7bBiDQo22hp1BHllN4
        wuyZHYGyJV0HP2b8JoYs0IU=
X-Google-Smtp-Source: ABdhPJyugFUfw8eJCOe9rGROZJLludLNJEIo1ORZ4ENfFFWuBE1UrfXXhItnm7h1TslagNU+I9GQ9A==
X-Received: by 2002:a05:600c:4f89:: with SMTP id n9mr24764032wmq.133.1617016615644;
        Mon, 29 Mar 2021 04:16:55 -0700 (PDT)
Received: from ziggy.stardust (80.174.240.175.dyn.user.ono.com. [80.174.240.175])
        by smtp.gmail.com with ESMTPSA id o5sm22852011wrx.60.2021.03.29.04.16.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 04:16:55 -0700 (PDT)
Subject: Re: [PATCH 1/2] dt-bindings: devapc: Update bindings
To:     Nina Wu <nina-cm.wu@mediatek.com>, Rob Herring <robh+dt@kernel.org>
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        Neal Liu <neal.liu@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        Jackson-kt.Chang@mediatek.com
References: <1616743871-8087-1-git-send-email-nina-cm.wu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <8417423c-0462-f3af-b3a0-2af638850d51@gmail.com>
Date:   Mon, 29 Mar 2021 13:16:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1616743871-8087-1-git-send-email-nina-cm.wu@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/03/2021 08:31, Nina Wu wrote:
> From: Nina Wu <Nina-CM.Wu@mediatek.com>
> 
> To support newer hardware architecture of devapc,
> update device tree bindings.
> 
> Signed-off-by: Nina Wu <Nina-CM.Wu@mediatek.com>
> ---
>  .../devicetree/bindings/soc/mediatek/devapc.yaml   | 41 ++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/mediatek/devapc.yaml b/Documentation/devicetree/bindings/soc/mediatek/devapc.yaml
> index 31e4d3c..489f6a9 100644
> --- a/Documentation/devicetree/bindings/soc/mediatek/devapc.yaml
> +++ b/Documentation/devicetree/bindings/soc/mediatek/devapc.yaml
> @@ -20,9 +20,27 @@ properties:
>    compatible:
>      enum:
>        - mediatek,mt6779-devapc
> +      - mediatek,mt8192-devapc
> +
> +  version:
> +    description: The version of the hardware architecture
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [1, 2]
> +    maxItems: 1
> +
> +  slave_type_num:
> +    description: The number of the devapc set
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [1, 4]
> +    maxItems: 1
>  
>    reg:
>      description: The base address of devapc register bank
> +    maxItems: 4
> +
> +  vio_idx_num:
> +    description: The number of the devices controlled by devapc
> +    $ref: /schemas/types.yaml#/definitions/uint32-array

This can all per compatible DT data objects in the driver. Don't add new
properties here.

Regards,
Matthias

>      maxItems: 1
>  
>    interrupts:
> @@ -39,7 +57,10 @@ properties:
>  
>  required:
>    - compatible
> +  - version
> +  - slave_type_num
>    - reg
> +  - vio_idx_num
>    - interrupts
>    - clocks
>    - clock-names
> @@ -53,8 +74,28 @@ examples:
>  
>      devapc: devapc@10207000 {
>        compatible = "mediatek,mt6779-devapc";
> +      version = <1>;
> +      slave_type_num = <1>;
>        reg = <0x10207000 0x1000>;
> +      vio_idx_num = <511>;
>        interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_LOW>;
>        clocks = <&infracfg_ao CLK_INFRA_DEVICE_APC>;
>        clock-names = "devapc-infra-clock";
>      };
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/mt8192-clk.h>
> +
> +    devapc: devapc@10207000 {
> +        compatible = "mediatek,mt8192-devapc";
> +        version = <2>;
> +        slave_type_num = <4>;
> +        reg = <0 0x10207000 0 0x1000>,
> +            <0 0x10274000 0 0x1000>,
> +            <0 0x10275000 0 0x1000>,
> +            <0 0x11020000 0 0x1000>;
> +        vio_idx_num = <367 292 242 58>;
> +        interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&infracfg_ao CLK_INFRA_DEVICE_APC>;
> +        clock-names = "devapc-infra-clock";
> +    };
> 
