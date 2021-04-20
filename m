Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77BB9365971
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 15:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbhDTNCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 09:02:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:56350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232091AbhDTNB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 09:01:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DA9EC613D0;
        Tue, 20 Apr 2021 13:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618923686;
        bh=rtORbGc3mPMhlArrUrjghPvRhVtKXaf7d9TRrasS6l0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VMumAygSE2Ss89tpuyftaMuLsWVlHbuUiOCbE8Ai7UM5E6RsNHIG9Vf4xtaC5qwKr
         O/qTpB4pkucmnZ3hez0dd3jHy+B2ziZ24j2pdzihRTrnG631AEEeFTonndrokzneRV
         fAlejQkAack3j+VindxNlgBzaFt6E33gc8tfDylJhzkcXhrUMNnxV+lZ6QtSmdN5EQ
         +1QNhVUNNq7EWbL1+0+jlludkTmVA2DTA/EPQmmN7+A2XDrkH6E/Edh5Is/S5zN1UY
         Dm+m093pRdDh3yhZFuuV6lxhG7ADpLJlcxGCBoTiokyTGU3rhh236EaQmxjuveju2R
         kvvrKuGcEAYbA==
Received: by mail-qk1-f178.google.com with SMTP id u20so6964803qku.10;
        Tue, 20 Apr 2021 06:01:26 -0700 (PDT)
X-Gm-Message-State: AOAM532WT6gnQe63xUoGePZXcK7WyX/GXoJ7+pOe0StbObSIXubVf7A+
        EbKcqHzZXqEzJFsLhyOuPFlscIl7Po8e5aATzQ==
X-Google-Smtp-Source: ABdhPJytCtVfQJCSrxQnJlrByY2ajWXURyVePKmlcnaE97mOqQU4IvcMx9ee78uVQZawM9qyCusf98X4PqudjDjJq+I=
X-Received: by 2002:ae9:f819:: with SMTP id x25mr9783240qkh.68.1618923685847;
 Tue, 20 Apr 2021 06:01:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210126011759.1605641-1-drinkcat@chromium.org> <20210126091747.v11.1.Ie74d3355761aab202d4825ac6f66d990bba0130e@changeid>
In-Reply-To: <20210126091747.v11.1.Ie74d3355761aab202d4825ac6f66d990bba0130e@changeid>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 20 Apr 2021 08:01:13 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+gWm+94zF1XN2KiRYgAZewiDkCk5B5bhLB=M+-HbD=fA@mail.gmail.com>
Message-ID: <CAL_Jsq+gWm+94zF1XN2KiRYgAZewiDkCk5B5bhLB=M+-HbD=fA@mail.gmail.com>
Subject: Re: [PATCH v11 1/4] dt-bindings: gpu: mali-bifrost: Add Mediatek MT8183
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Fei Shao <fshao@chromium.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        "Kristian H. Kristensen" <hoegsberg@chromium.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 7:18 PM Nicolas Boichat <drinkcat@chromium.org> wrote:
>
> Define a compatible string for the Mali Bifrost GPU found in
> Mediatek's MT8183 SoCs.
>
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> ---
>
> Changes in v11:
>  - binding: power-domain-names not power-domainS-names
>
> Changes in v10:
>  - Fix the binding to make sure sram-supply property can be provided.
>
> Changes in v9: None
> Changes in v8: None
> Changes in v7: None
> Changes in v6:
>  - Rebased, actually tested with recent mesa driver.
>
> Changes in v5:
>  - Rename "2d" power domain to "core2"
>
> Changes in v4:
>  - Add power-domain-names description
>    (kept Alyssa's reviewed-by as the change is minor)
>
> Changes in v3: None
> Changes in v2: None
>
>  .../bindings/gpu/arm,mali-bifrost.yaml        | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
> index 184492162e7e..3e758f88e2cd 100644
> --- a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
> @@ -17,6 +17,7 @@ properties:
>      items:
>        - enum:
>            - amlogic,meson-g12a-mali
> +          - mediatek,mt8183-mali
>            - realtek,rtd1619-mali
>            - rockchip,px30-mali
>        - const: arm,mali-bifrost # Mali Bifrost GPU model/revision is fully discoverable
> @@ -41,6 +42,8 @@ properties:
>
>    mali-supply: true
>
> +  sram-supply: true
> +
>    operating-points-v2: true
>
>    power-domains:
> @@ -87,6 +90,31 @@ allOf:
>      then:
>        required:
>          - resets
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: mediatek,mt8183-mali
> +    then:
> +      properties:
> +        power-domains:
> +          description:
> +            List of phandle and PM domain specifier as documented in
> +            Documentation/devicetree/bindings/power/power_domain.txt
> +          minItems: 3
> +          maxItems: 3

This won't work because the top level schema restricts this to 1. The
top level needs to say:

power-domains:
  minItems: 1
  maxItems: 3

And you need just 'minItems: 3' here and 'maxItems: 1' in the else clause.

And drop the description. That's every 'power-domains' property.

> +        power-domain-names:
> +          items:
> +            - const: core0
> +            - const: core1
> +            - const: core2

Blank line

> +      required:
> +        - sram-supply
> +        - power-domains
> +        - power-domain-names
> +    else:
> +      properties:
> +        sram-supply: false
>
>  examples:
>    - |
> --
> 2.30.0.280.ga3ce27912f-goog
>
