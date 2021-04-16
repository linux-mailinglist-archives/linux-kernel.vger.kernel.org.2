Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2D436230C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 16:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245034AbhDPOnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 10:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244946AbhDPOnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 10:43:19 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047ACC061763;
        Fri, 16 Apr 2021 07:42:33 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id o21-20020a1c4d150000b029012e52898006so4709841wmh.0;
        Fri, 16 Apr 2021 07:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Lx7hg/JBTOUY6NQVwUXFQgNKj1wjLMxdVCIC1wg2uVk=;
        b=EvXWQU/Qlfk18FjDjxRmA+QW+Bx3wnGUsvoMuCUiagV+PDkkt6eBRdGlZUj6xe7kko
         4y5hWL0G0e2gqNFPKuHtAeBbc/gc6sAAd9+PujrFaVM8fcrpgl4YXulq6S0x2Erw2qWX
         ltgqE30B8msjW4ImVDMG2p5zWg2pelzOht4Kl6d1dkdWBKiJJzgl1oK3ftyNXr+nMhot
         8FMSFdSQyxBwIVkMmKFpafA6IWhrsyIUsvOpdSaRNIlxvuLRDXNvgjEhxQfLKNIq0CvP
         kjmSscSTKlUrYIO1a9VCvQs/rx++O0p9LeihRTvVPZQETpaQVqUaHcRSpoK8q/7kfmW5
         NXEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Lx7hg/JBTOUY6NQVwUXFQgNKj1wjLMxdVCIC1wg2uVk=;
        b=hXkYEWXdI5ewxCQNBpd5iqdxEVGug2n0paGukn+eTKRuiGc3xfKktRPRG0BmD2Pqw7
         g9JfGaEpArQhX8YpFqZe5UMkhEcVsNxZnb3KHJsS3F0c5RFoFwkPhmSLKrzuwON4yipd
         /wMnC7sz5AoCKN2+d2d4/rurlK2HOT5BY3S5d22YicxU0rYcrbzHQlOIPcOLBn+J7+7p
         qnZYvlTyZAo0BjC0BIuNQp3sW3+i9XPkHIBgPKuFk4aaKvUhUama/NGcwk/jnKU64T8x
         U9MEOj4Z0DTrPRVCARcHYTqtthYJVFnxtccKbif1dgISWNoBSPacuBdZ7yYVmLa4Ns1M
         WIcA==
X-Gm-Message-State: AOAM5308cfLA62MQBzSB1yDb4V9fAyWR+y/abliKFXJNxouW/VyRRzF0
        KueizE1hAQ+5zluSVr7/row=
X-Google-Smtp-Source: ABdhPJwPqelGlwrzQ0/PPn5lnVFbfg3aSHUs1UfWSE9VW8vBKpb0fKRIiCPDCxB9PvGjPQgOBfgw6Q==
X-Received: by 2002:a05:600c:4145:: with SMTP id h5mr8611177wmm.53.1618584151776;
        Fri, 16 Apr 2021 07:42:31 -0700 (PDT)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id v189sm9667455wmg.9.2021.04.16.07.42.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Apr 2021 07:42:31 -0700 (PDT)
Subject: Re: [PATCH 4/8] dt-bindings: arm64: dts: mediatek: Add
 mt8183-kukui-jacuzzi-kenzo
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
        Ben Ho <Ben.Ho@mediatek.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
References: <20210415093519.1920877-1-hsinyi@chromium.org>
 <20210415093519.1920877-4-hsinyi@chromium.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <face0af7-8630-31fa-4975-a80311257d13@gmail.com>
Date:   Fri, 16 Apr 2021 16:42:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210415093519.1920877-4-hsinyi@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/04/2021 11:35, Hsin-Yi Wang wrote:
> Kenzo is known as Acer Chromebook 311.
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
> index 0870490aa350..39e4a99ebb37 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
> @@ -137,9 +137,11 @@ properties:
>          items:
>            - const: google,damu
>            - const: mediatek,mt8183
> -      - description: Google Juniper (Acer Chromebook Spin 311)
> +      - description: Google Juniper (Acer Chromebook Spin 311) / Kenzo (Acer Crhomebook 311)

Crhomebook -> Chromebook :)

>          items:
> -          - const: google,juniper-sku16
> +          - enum:
> +              - google,juniper-sku16
> +              - google,juniper-sku17
>            - const: google,juniper
>            - const: mediatek,mt8183
>        - description: Google Kakadu (ASUS Chromebook Detachable CM3)
> 
