Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60C3140279F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 13:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245561AbhIGLOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 07:14:47 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:60068
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233977AbhIGLOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 07:14:46 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8956940199
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 11:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631013219;
        bh=RJvc8ScJoXUAmgUH0tbWv8RtCVfeoLSflGCfFqP0tbs=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=Q4sxVZW/UXotMC4eBAy9vbuYhVCXrgSteLtCg1b++mkFRzcMNWNxV4lkvS/EgzjDD
         WoXqjmGeNbZrHhW7NjeKMoO7DuKTBMpRPoDKECVTTWdVkY1UTIdpmQisRqw3ZXv5Ht
         ZYibe5UKDZgWkRWBgTxpDv+wBB58NatAwafWosYRPbR+VNWCDTYSX1bhz545PyVyRU
         PAmjeSnKmOhyd0bJFSEYJxtfy0L4aLaOIUm0oBN49WbTSEpXtUd6zrFvrEoMASed+W
         wvl94I9f6bKv2pLzdgjFOwinjOKweW0mlfXXa/hI23ZB4UE4znpldVD5BFyI26fS7y
         9rvn3KJ1gCVqg==
Received: by mail-wm1-f69.google.com with SMTP id x125-20020a1c3183000000b002e73f079eefso1061521wmx.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 04:13:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RJvc8ScJoXUAmgUH0tbWv8RtCVfeoLSflGCfFqP0tbs=;
        b=PUjhfUbRvFY2esKeXydegW76HTDItHzvILd9gmtX36NV3lexf89WrOGkxOA7AZhrxK
         nlY+obuEHYMUa3LbHlWMJwJ4tij1Ey7qZK0t0faMm7rwX2Okx9cst4UMeQDEnvxmhNCT
         pdSBWGLOfw+mCFKJt6fuh/LuQ6onExV6dc9oKT63v1JGr3HzVxij9ATbpSj4YoFrSLVq
         FXzpWGNsUZRMj1nuzJZzef84HlhM/LlX2gwwNhUpAg5u2KzSzUDajsers2MrkF8AGsFn
         7ouDyWvyEVCFqmtZU+L5Q/7OFS8X8eRoPOl64gfaRWyHsJ6hicfU5Rn4+uOGi6m3kyKc
         FEbA==
X-Gm-Message-State: AOAM533o+hzK/dLp2zFkGiIATmpIK/sEmnAeDcv0Iq6AutHlozmJbIRx
        m7aq5ZbzfXMfAKOZwIDd7Ea9cLHZ860NiGtMsTCeQ9gtuZbds9OF5KMPTBENCu6bu8iiN47ZSKV
        sIuxrmG+6Ut/cKfxa0VtYjb2/Bv/be0/3nRRli96GFA==
X-Received: by 2002:a5d:4ccc:: with SMTP id c12mr18002444wrt.59.1631013219310;
        Tue, 07 Sep 2021 04:13:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxftBSLmRUfX3ZDzPuMqhFuOKzIZppEB07Pr87IaRh51UhP9+7lgmF0BQ8jxmwYCEciJOND6g==
X-Received: by 2002:a5d:4ccc:: with SMTP id c12mr18002426wrt.59.1631013219162;
        Tue, 07 Sep 2021 04:13:39 -0700 (PDT)
Received: from [192.168.3.211] ([79.98.113.172])
        by smtp.gmail.com with ESMTPSA id b1sm11069471wrh.85.2021.09.07.04.13.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 04:13:38 -0700 (PDT)
Subject: Re: [PATCH v2 1/5] dt-bindings: Add vendor prefix for Airoha
To:     Bert Vermeulen <bert@biot.com>, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Joel Stanley <joel@jms.id.au>, Daniel Palmer <daniel@0x0f.com>,
        Max Merchel <Max.Merchel@tq-group.com>,
        Hao Fang <fanghao11@huawei.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        John Crispin <john@phrozen.org>
References: <20210907102722.47543-1-bert@biot.com>
 <20210907102722.47543-2-bert@biot.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <393fa904-41a9-0ed3-90c3-c03da1c0dd18@canonical.com>
Date:   Tue, 7 Sep 2021 13:13:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210907102722.47543-2-bert@biot.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2021 12:27, Bert Vermeulen wrote:
> From: John Crispin <john@phrozen.org>
> 
> Add vendor prefix "airoha" for Airoha.
> 
> Signed-off-by: John Crispin <john@phrozen.org>
> Signed-off-by: Bert Vermeulen <bert@biot.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index 07fb0d25fc15..e9c956535f97 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -333,6 +333,8 @@ patternProperties:
>      description: EBV Elektronik
>    "^eckelmann,.*":
>      description: Eckelmann AG
> +  "^airoha,.*":
> +    description: Airoha

Wrong ordering.

Best regards,
Krzysztof
