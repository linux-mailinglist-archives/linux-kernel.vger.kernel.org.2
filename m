Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4C236B8B6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 20:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234467AbhDZSH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 14:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234459AbhDZSHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 14:07:20 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBF5C06175F
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 11:06:37 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id x7so56799847wrw.10
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 11:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z/Kwipu1y6TOCAmGCH4eBv1sqy5s6UK9+gQOmGBdFDo=;
        b=tFAA8OM1OMnP4mVo1BUP3TdeKSXg/EB0WafYRtzUUiTKjsWUSQ3QroqS/dybgZJz5x
         0uistVBTmvOSdV/sjTYDOP5Va1MmX7/WqO0JJj+tBOPk5GLQHczf9D8P5whtygJ67rTY
         Xn1LpQA4AeN6syvVSQIdFiCAapyOmzrQqelxryNExRsNAUxIlqXMJwYj+ns6o5CwHKK2
         ylC+cLMlFFWQrWOfS5pjYnUnB/NhnEYOL62/OL4tMLc0yPxaXghMMP4NPRf4+0vQdGOq
         o/LMILSLqmJbvcyuMj+8GgtaWJZ/8VgNqAKdegca6JMGKy9kxT/rfUr+s3QipNmawIWl
         iCfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=z/Kwipu1y6TOCAmGCH4eBv1sqy5s6UK9+gQOmGBdFDo=;
        b=Uz+GTtC7iFjaBFHUMA+TdjKw7TLuIlbx/fHmqvwT93OdE3K8OKPsmN1fKeHL0jELfr
         SsOuqg1xJ6/xH2knqOpaDChLV92X6SY8ZNMB2vQnJQ+cWBlc6a6hesZdLAl66EojhkDN
         LPeBD1UaYJfnuE+VZgeBokFSQtSMA4EdE0jZujBVqRaxmo1lJ+sdv+3Ijh1gYKX20jwT
         crNxkG7G+fnFFcQA4ojwhBlf33gos+txj9328k76WOw0g5MQIMg/mAokCAtV+TTU/B7j
         uy1d3gw7C7sZrR8GctiHOPwKaOUSFphpr3Eyf7qSQsNrth3S9WhK+UL7OkMdOrXTS4HJ
         5A2w==
X-Gm-Message-State: AOAM533p6xePo6CovbXOapYmOrSMaP1cPCWYIyqxZwz3m815Jyv9ZZf8
        bSR6yc+xQtXXurP3mcycu4YBXg==
X-Google-Smtp-Source: ABdhPJzgk2IzpTkyCjHJ4GcBEEoXLGQijoX+9t+CrvlLufNwU/zLqVZ2i9U0e2ub5m3mdqW1C5Dt0g==
X-Received: by 2002:a5d:590a:: with SMTP id v10mr24510931wrd.306.1619460395637;
        Mon, 26 Apr 2021 11:06:35 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:90c:e290:b76e:7362:77c0:ddc3? ([2a01:e0a:90c:e290:b76e:7362:77c0:ddc3])
        by smtp.gmail.com with ESMTPSA id a9sm276663wmj.1.2021.04.26.11.06.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 11:06:33 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] dt-bindings: serial: amlogic,meson-uart: add
 fifo-size property
To:     Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        gregkh@linuxfoundation.org
References: <20210325152410.1795557-1-narmstrong@baylibre.com>
 <20210325152410.1795557-2-narmstrong@baylibre.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <39c92a23-e009-6bc2-a20b-9b0ab3e01c75@baylibre.com>
Date:   Mon, 26 Apr 2021 20:06:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210325152410.1795557-2-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 25/03/2021 16:24, Neil Armstrong wrote:
> On most of the Amlogic SoCs, the first UART controller in the "Everything-Else"
> power domain has 128bytes of RX & TX FIFO, so add an optional property to describe
> a different FIFO size from the other ports (64bytes).
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  .../devicetree/bindings/serial/amlogic,meson-uart.yaml      | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> index 75ebc9952a99..8ece7f420c19 100644
> --- a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> +++ b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> @@ -55,6 +55,12 @@ properties:
>        - const: pclk
>        - const: baud
>  
> +
> +  fifo-size:
> +    description: The fifo size supported by the UART channel.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [64, 128]
> +
>  required:
>    - compatible
>    - reg
> 


Is it ok with the generic fifo-size property ?

Neil
