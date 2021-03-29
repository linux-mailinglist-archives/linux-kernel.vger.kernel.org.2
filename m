Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C337A34CF4F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 13:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbhC2Lr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 07:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbhC2LrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 07:47:18 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113E1C061574;
        Mon, 29 Mar 2021 04:47:18 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id u5-20020a7bcb050000b029010e9316b9d5so6515774wmj.2;
        Mon, 29 Mar 2021 04:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/+Lj/2HaePE9ZbmLrkf0oDmdmPYd6wO1doOsEpNfmzk=;
        b=PZgKOycvkhuVEF8tOTQP+bdoe4R1L0KUCVi9bDR1Ync5LAYraWl+5ilxmPkKZOltou
         kp14FSZmOi9km59EwQmlxrbWiIj14qKW1Br4KzbWlT6KKbxrkTruUOqA3ljgxwbShptE
         pdlE12Cqk4j4yf+jtK0P2v2gMHY+bDD+O2cpYPTg4C7lpxqk0QlPKUDKS0vNiXqlTZpN
         oZBoo9qEI6zU/Gfpophy1pProg00WYcjFOfUSsIBHp8fd6YfzFOzX1aPt8DL8SWa2esL
         4Mif7iz7yHeb4ZIFBWdfLCN3DrPlV4zQObYTiE+BFexnmIkP6C0YNIMBXDEOv7yYp7T3
         1L8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/+Lj/2HaePE9ZbmLrkf0oDmdmPYd6wO1doOsEpNfmzk=;
        b=ed1wvL8fEYZp2u8fzTguGuuIqz0/k/KjrLhyx0PqYEeUZ/UK/PNyI+GDhVB+1/htY8
         qfi9MSKeGY/PZOjIJwix/kfkMoc+37jRc59mdNzjzaZ+QiaHPKwK70qqiSOtC55zUpEi
         l/YsxKyfSFlHJ0LNponFBuGUQx5lAa7aC1zXsbqcL4ypms/qRpMkDY5apDb1Qd8EkdUQ
         1nhiMHMU83IzgDIGbf3jFw0bQYK90GIUiDBwZX3Rsf7EQPqXLc8Ug7cGg8B6QwTJNGEu
         VFIiJZnjzJ9y7wQVEsrE16/7thxz74ssnBQbejzEdP8KDZPqODa0UUMG/YjVNIhLe+5g
         c6pQ==
X-Gm-Message-State: AOAM533e1Yvoot8UCtqVuKr7qxWyn3t7IzlUl30aQXFi4spPPGexFnSA
        lEtttMXNO/TVwwzbrlTh0O0=
X-Google-Smtp-Source: ABdhPJzE5G8N/olo2jafAg3eQ871kyiQXpS6UKbqstv3IT1K7rSSv/tb4wT1nCl68AXIzS5QCdcyjA==
X-Received: by 2002:a1c:7714:: with SMTP id t20mr24202271wmi.107.1617018436804;
        Mon, 29 Mar 2021 04:47:16 -0700 (PDT)
Received: from ziggy.stardust (80.174.240.175.dyn.user.ono.com. [80.174.240.175])
        by smtp.gmail.com with ESMTPSA id 1sm25030535wmj.2.2021.03.29.04.47.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 04:47:16 -0700 (PDT)
Subject: Re: [PATCH v4 1/4] dt-bindings: arm64: dts: mediatek: Add
 mt8183-kukui-jacuzzi-damu
To:     Hsin-Yi Wang <hsinyi@chromium.org>, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Fabien Parent <fparent@baylibre.com>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Ben Ho <Ben.Ho@mediatek.com>
References: <20210319035245.2751911-1-hsinyi@chromium.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <16cc2611-c2d3-e283-2f40-a424b2067f72@gmail.com>
Date:   Mon, 29 Mar 2021 13:47:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210319035245.2751911-1-hsinyi@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/03/2021 04:52, Hsin-Yi Wang wrote:
> mt8183-kukui-jacuzzi-damu board also known as ASUS Chromebook Flip CM3,
> using mediatek mt8183 SoC.
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Whole series applied to v5.12-next/dts64

Thanks

> ---
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
> index 93b3bdf6eaeb..a86716cdd408 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
> @@ -125,6 +125,10 @@ properties:
>                - google,krane-sku176
>            - const: google,krane
>            - const: mediatek,mt8183
> +      - description: Google Damu (ASUS Chromebook Flip CM3)
> +        items:
> +          - const: google,damu
> +          - const: mediatek,mt8183
>  
>  additionalProperties: true
>  
> 
