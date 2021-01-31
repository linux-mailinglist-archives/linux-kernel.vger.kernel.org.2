Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4010309C5D
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 14:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbhAaNgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 08:36:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbhAaMGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 07:06:34 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC24DC0613ED;
        Sun, 31 Jan 2021 04:04:39 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id j18so10257562wmi.3;
        Sun, 31 Jan 2021 04:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ja60oVtMBQPXNGaZwq/ZCDxnj/PFg82fF1SA2lvvHG0=;
        b=Q+KSMbj8Ll7Y1J1WBPSao0L9jVQaSMZi+iBNkyxfi8Sar/qwqcl6BUuJZuxvFs9EDJ
         M2NGcpAfVEz2Bfw2F63/47P7chzjlCD/TYvzLQ4BdhZs1EvpD2dqieil3IleoU6wn1IF
         kqRJyxdoJMPGgP0kivdW2VKCySkbKRE15pCuGyVAu/ApswPPdE45zOu5qQfFNnQXjR7j
         uFv63xRs5YvDVrbYRuLFE87Wg9IaJ+vMSQnltsEXsNLNPiiaKSI/MoLB1soYBVfHQ/27
         2hAB3vxvwCnLCkoHmuf9nEimeatff5guIrAfrKAV0RJ9N/vRYxkHRI/VoFhlMyV9u1Qn
         KNtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ja60oVtMBQPXNGaZwq/ZCDxnj/PFg82fF1SA2lvvHG0=;
        b=L+vw6ESLS/98Un8UDRPlg5UpzI1+SsQnX0cRqpsQke72yWT4EyUbC9wtAJuiG0e8ID
         OpWWZWrsEROHfkzvnqnvC5EThTpd5rgCR0Xmy/E7Qsqu1OqpSJvDwKmyPZui2gRvzVkY
         00Doz8JIcHoIa6sJXAOZLzC73V8dCm37OMTuf9ZAhE04cleiFmrvzl6xQyR4/yhbQfXe
         JPsRq8rCWWHWHrCkboSIkhV3tSDqU/GDZj+n065nX6yThdqnmEhf6vbOqrDAD5UNZUSf
         PKkwN+4ArZL9Fvr2CwqclcJZ2+F+5EmBw6CkUkJlNkxJ3H6ikyxY+EFnoRyqJ5nP4G3U
         J64w==
X-Gm-Message-State: AOAM532FEn60UhNYpqLdUWr4PjUQAooXktJShvYIScq7qb2hAPC6Tg0t
        PeUhHuBQEpSASCKHWdqTDL8=
X-Google-Smtp-Source: ABdhPJzlhERwDG3Ce1iWqB+vncCmORjbDBr85usncQIR5myjv5+PcJ6aSO6zB4lad9aZdWIrSNQz8Q==
X-Received: by 2002:a05:600c:35d6:: with SMTP id r22mr10901735wmq.44.1612094678726;
        Sun, 31 Jan 2021 04:04:38 -0800 (PST)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id u206sm7405206wme.12.2021.01.31.04.04.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jan 2021 04:04:37 -0800 (PST)
Subject: Re: [PATCH v2 1/3] dt-bindings: power: Add domain regulator supply
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Mark Brown <broonie@kernel.org>,
        Weiyi Lu <weiyi.lu@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20210129101208.2625249-1-hsinyi@chromium.org>
 <20210129101208.2625249-2-hsinyi@chromium.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <44920b1f-1232-9bdc-f69b-40f10a2f0b5d@gmail.com>
Date:   Sun, 31 Jan 2021 13:04:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210129101208.2625249-2-hsinyi@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/01/2021 11:12, Hsin-Yi Wang wrote:
> Some power domains (eg. mfg) needs to turn on power supply before power
> on.
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Applied to v5.11-next/soc

Thanks

> ---
>  .../bindings/power/mediatek,power-controller.yaml        | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> index d14cb9bac8497..e529586af5a12 100644
> --- a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> +++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> @@ -82,6 +82,9 @@ patternProperties:
>            be specified by order, adding first the BASIC clocks followed by the
>            SUSBSYS clocks.
>  
> +      domain-supply:
> +        description: domain regulator supply.
> +
>        mediatek,infracfg:
>          $ref: /schemas/types.yaml#/definitions/phandle
>          description: phandle to the device containing the INFRACFG register range.
> @@ -130,6 +133,9 @@ patternProperties:
>                be specified by order, adding first the BASIC clocks followed by the
>                SUSBSYS clocks.
>  
> +          domain-supply:
> +            description: domain regulator supply.
> +
>            mediatek,infracfg:
>              $ref: /schemas/types.yaml#/definitions/phandle
>              description: phandle to the device containing the INFRACFG register range.
> @@ -178,6 +184,9 @@ patternProperties:
>                    be specified by order, adding first the BASIC clocks followed by the
>                    SUSBSYS clocks.
>  
> +              domain-supply:
> +                description: domain regulator supply.
> +
>                mediatek,infracfg:
>                  $ref: /schemas/types.yaml#/definitions/phandle
>                  description: phandle to the device containing the INFRACFG register range.
> 
