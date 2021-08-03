Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEE43DE7CA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 10:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234349AbhHCIBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 04:01:19 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:57006
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234270AbhHCIBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 04:01:15 -0400
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id 0C2783F351
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 08:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627977664;
        bh=xcgPwRTVNnlB9Ca1BryW6jcXJ520XlA+QdA5eYCuNqY=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=q95g+AIWJSMi2bOXes5YTawKvjpAo/z3Sj3DreqUrzeRHfZa/2GkaTfPo+s3JCJ7w
         LmXM0ueWxx/2PQVjn6MRn++8vZZw4y21V1vD6JuaA2GtGx+MZ/h2+TeQIS73kytEX8
         3j4HB4j3hgrh3F6AYXk5ifLW3XZwI9zs+YuyQiWKplHOnR4qXuAU78PwoWB5OABXnc
         5ATNxzytSQNTiwKonY6FJtcQoT6hLBlmCnF/M6nzaUnhZgjeQ8Yp/BKT5FmplNDTOs
         keCopd9gtvAg51oAFkTpCgPieoKDg/4fdH96NpVJ2frQhbm2WVuArQFmuAWH6ltnXE
         uI/iq9z4yaf8A==
Received: by mail-ej1-f72.google.com with SMTP id g21-20020a1709061e15b029052292d7c3b4so5683666ejj.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 01:01:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xcgPwRTVNnlB9Ca1BryW6jcXJ520XlA+QdA5eYCuNqY=;
        b=DIJ0xVD/sE7LeQ881CoQCE/RHSGBTo+wXaKzAaRxMsvGi3VzYdoMeqB6j+8O7jMXr1
         6siKWV7R5gfNUrpdAo5KCbp6wzOuayygUxlm2LY5DCJfUwWz5NzKUJB2J+HYF0uxaiO2
         wVZBZU93qbpqR5wNOO87ZE/WOe0DmJjGvzWmqUCE7K4Xdya/EVAIHDcO+q1yuoyLcdmh
         5fe0dJdEqBBZEQAXfFh+FUZlF8bqZzvwjDiYbvjo6XiVPEzpCS4hmQ+oMeCgsTUR8Ivp
         nT9+vGD0NAzJ2eFnwhTV7dCWKb4OsO2xXmJw7AlwA6MuPDBsgdGTMViocS1B3/NbBhzL
         agSQ==
X-Gm-Message-State: AOAM532ZGwlkA+Ol+YWn4YZC+fiMuQJtW59/lmHLOiFEGV4v1bcU+1pu
        MjboopVignJfw+HxCvDHxBqY6O8tviEXw0N3QCSrAW5eTUVOxUf2FqTogKlaqDTAuDKbJq0z3ux
        NbeRse98zwiQg7xdz6BjxquQeh1rDLQur8fba+gGxdA==
X-Received: by 2002:aa7:d7c1:: with SMTP id e1mr23476341eds.251.1627977663347;
        Tue, 03 Aug 2021 01:01:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwj/qP1Q41wUE0MaM16YNSLHgwdPMzFI76UL7qB1dSy57AzxsYBf1Q0TLraQrcJ7Xxi0YM1oQ==
X-Received: by 2002:aa7:d7c1:: with SMTP id e1mr23476321eds.251.1627977663186;
        Tue, 03 Aug 2021 01:01:03 -0700 (PDT)
Received: from [192.168.8.102] ([86.32.43.172])
        by smtp.gmail.com with ESMTPSA id c7sm7763197edn.45.2021.08.03.01.01.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Aug 2021 01:01:02 -0700 (PDT)
Subject: Re: [PATCH v5 3/5] dt-bindings: vendor-prefixes: Add another prefix
 for Mediatek Co.
To:     Tinghan Shen <tinghan.shen@mediatek.com>, ohad@wizery.com,
        bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        robh+dt@kernel.org, matthias.bgg@gmail.com, shawnguo@kernel.org,
        sam@ravnborg.org, linux@rempel-privat.de, daniel@0x0f.com,
        Max.Merchel@tq-group.com, geert+renesas@glider.be,
        fanghao11@huawei.com
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210803075922.11611-1-tinghan.shen@mediatek.com>
 <20210803075922.11611-4-tinghan.shen@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <f084bd57-c6df-cade-fefd-217897caf88e@canonical.com>
Date:   Tue, 3 Aug 2021 10:01:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210803075922.11611-4-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/08/2021 09:59, Tinghan Shen wrote:
> Add document binding for mediatek.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index 07fb0d25fc15..c4252cd570b0 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -760,6 +760,8 @@ patternProperties:
>      description: MStar Semiconductor, Inc. (acquired by MediaTek Inc.)
>    "^mti,.*":
>      description: Imagination Technologies Ltd. (formerly MIPS Technologies Inc.)
> +  "^mtk,.*":
> +    description: MediaTek Inc.

NAK, you already have one MediaTek Inc. I doubt these are different
companies...


Best regards,
Krzysztof
