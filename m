Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F72834FDF0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 12:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234935AbhCaKU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 06:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234929AbhCaKUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 06:20:10 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2E5C061574;
        Wed, 31 Mar 2021 03:20:10 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id j7so19127220wrd.1;
        Wed, 31 Mar 2021 03:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3rXla0hHRtnVRfLF9YfnBTiK94WVn7aEJZMJWrzafGo=;
        b=BxYU+5fteJflK1TOZMykibmAPmMWBqlU6pyq6c3GYkZk+Zc7WDm3U2ZC4JA2TVtmMr
         c+/Zkf7+pMiJG45AOLog4xTM+rQx5jjRD6Y0oAK75WCV0BGt6kHQaCCeFsVPz43Ltfhm
         6aJbFXc+2aZgcGoQy1tAxDXJ7jLC31SdN9szJhmewx8z/8TNG3EAGriL+acp0oAGaB5U
         56drsyzCNjhoHdhJn63DRgqRiqk7WZJWrp6LWoPkEZ8qo9y+/HNUVy9o1bN71kF2Bznm
         jcKMVSTxjXN0TTIWxMD14X6MkUCJfoOSikA2dDFYqC/FOuFm/XbxroO9jJ4UP2dnYWyF
         Uw3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3rXla0hHRtnVRfLF9YfnBTiK94WVn7aEJZMJWrzafGo=;
        b=R/7X/kukN3yhprT7Pj7QzDukYwQyw9Vp0jIDiLUKOr+m1zBuFS1cMwSYtbi3h8vF0y
         +nNFidzynWn8eMu8ouu70k8J8EQyeo+SeBzP9hQ1F6OOgdA0FmvM7KUOtS4EWIB0whj4
         9ElqoiejxksaLywWPL7x6HGuDVTrDkXTCeRCVd9/sNIw6VoW+O/17PV0oaPbOYj1flDT
         DNtTzPKfH4WOL73Y/NYn3BCqH3PemOihPnE/BWPpwPvgufBa93P8byPKQ3kOGg+i7LlU
         P58r2ZWqMQCZMs1goiUJdWGkVW93AOPvunk+2kyxjsWIKPhaFkid/wldfeq3+nkr7cLC
         gaPQ==
X-Gm-Message-State: AOAM533ssMYl1QRTtgcmoc2gCDNWD/IJo2ZaHRFLFgRJCSN20qGO752y
        lrzUpiFwfaaTsKezOUWI4mQ=
X-Google-Smtp-Source: ABdhPJzN80ItuTRHrC4wh+zxjzi0b6qONHFSsilv18FRfi7CBNJJSZ574//AWCzfQl4jVKGUK3m9NQ==
X-Received: by 2002:a5d:628c:: with SMTP id k12mr2765032wru.316.1617186008745;
        Wed, 31 Mar 2021 03:20:08 -0700 (PDT)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id n7sm3662246wrv.71.2021.03.31.03.20.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Mar 2021 03:20:08 -0700 (PDT)
Subject: Re: [PATCH 1/4] dt-bindings: arm64: dts: mediatek: Add
 mt8183-kukui-kakadu
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
        Ben Ho <Ben.Ho@mediatek.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
References: <20210331091327.1198529-1-hsinyi@chromium.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <28e5fe3c-aae5-9c48-74ca-f1c4964a6124@gmail.com>
Date:   Wed, 31 Mar 2021 12:20:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210331091327.1198529-1-hsinyi@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31/03/2021 11:13, Hsin-Yi Wang wrote:
> Kakadu is also known as ASUS Chromebook Detachable CM3.
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>

Whole series applied to v5.12-next/dts64

Thanks!

> ---
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
> index cf24401edb85..9774f44b51d9 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
> @@ -138,6 +138,13 @@ properties:
>            - const: google,juniper-sku16
>            - const: google,juniper
>            - const: mediatek,mt8183
> +      - description: Google Kakadu (ASUS Chromebook Detachable CM3)
> +        items:
> +          - const: google,kakadu-rev3
> +          - const: google,kakadu-rev2
> +          - const: google,kakadu
> +          - const: mediatek,mt8183
> +
>  
>  additionalProperties: true
>  
> 
