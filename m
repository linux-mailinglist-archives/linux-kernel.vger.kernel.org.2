Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F62B35CA7D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 17:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243179AbhDLPxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 11:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243013AbhDLPxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 11:53:15 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD00C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 08:52:57 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id u5-20020a7bcb050000b029010e9316b9d5so7183294wmj.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 08:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uV02flmSrRt81WJ4T3wiSuGURL6Hk/SHKuFa7qavV00=;
        b=RjCj+XhW0mahSBR+DCjq261dtioFS3pQNq26EqT2Eme+Qgs1kQY7q87bJJp6ROMlz3
         5TJYBHplQvmY0YB9sIglMsOH5V6KN8wL8vLTUZ+aqt4weVGFL7awcTi24PtR3Gb6H5wD
         a5CsXAlFfYCAtrqLykuU0dVkaBOrQV2/tlGJX2Uu5CL7VEaIAXlUYSRbE7woTcHatmL4
         rGlNPvxo33IMFNfke109vH5LbDqfjBWdYMjWvJMuzN5DpvqtIh3ycy7ch7GmANIvm1zK
         icz6085aChrb+HiSMhFMqdr/qkpO3IZbevQJVTJpM3Rw4ENv25e9DpDZSrOod1km+z8S
         sOkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=uV02flmSrRt81WJ4T3wiSuGURL6Hk/SHKuFa7qavV00=;
        b=ZoMAD1Q3IyUbd/nSL1yTgkP/soBFC7QKW0Vkx7GlmxBICBpQ9Cpj6xLQFbStj85wuI
         tW8AczfNhYCILiXl+3RDSZ8I5uXQ1pcI0ZokEcUg7SQrkbswCpDy14kME8NNvW8t1blq
         GpKMbYrkxjCmSOWs73sbR0S2bxt0Ld1AsFqj+AErroIhHo6FpbFcKdshJv+CblTOCE1G
         SVuQKQVdoVKY9ppR4E+Vtr+zeLE2CPivIlrfz/HUHoJjbxizrYpEHgwa9jQvjdCJ74ef
         WXa/rYZlL2+a80LWyNhuPV2LZlWo0723QEPGdFk9tVUkAN7uET1bVbka1HAS7l/lNI+t
         l3yg==
X-Gm-Message-State: AOAM530YHcmYGIu6tWAsQhs3NssxFRqPNa0whnHl+gddaN+tPOC+vhVR
        g+pHZm6yRTwLoXVswmgDtd36qssbipCoQS3d
X-Google-Smtp-Source: ABdhPJwfbFcviVSfTAbSMAnrXzK7dC+k5xmXgB/S2xxGvTPdrnsrbWO6uw4gslsvMhncxNmUXUSSSg==
X-Received: by 2002:a1c:4d0e:: with SMTP id o14mr4859927wmh.141.1618242775624;
        Mon, 12 Apr 2021 08:52:55 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:90c:e290:4c21:b00e:ff79:bf20? ([2a01:e0a:90c:e290:4c21:b00e:ff79:bf20])
        by smtp.gmail.com with ESMTPSA id g84sm15277215wmf.30.2021.04.12.08.52.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Apr 2021 08:52:55 -0700 (PDT)
Subject: Re: [PATCH v2 1/5] dt-bindings: display: mediatek,hdmi: Convert to
 use graph schema
To:     chunkuang.hu@kernel.org, p.zabel@pengutronix.de,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210412093928.3321194-1-narmstrong@baylibre.com>
 <20210412093928.3321194-2-narmstrong@baylibre.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <415e0331-fc7c-6362-e81d-108f7ff8a654@baylibre.com>
Date:   Mon, 12 Apr 2021 17:52:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210412093928.3321194-2-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2021 11:39, Neil Armstrong wrote:
> Update the mediatek,dpi binding to use the graph schema.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../display/mediatek/mediatek,cec.yaml        |  51 +++++++
>  .../display/mediatek/mediatek,hdmi-ddc.yaml   |  57 ++++++++
>  .../display/mediatek/mediatek,hdmi.txt        | 136 ------------------
>  .../display/mediatek/mediatek,hdmi.yaml       | 131 +++++++++++++++++
>  4 files changed, 239 insertions(+), 136 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,cec.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi-ddc.yaml
>  delete mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi.txt
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,cec.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,cec.yaml
> new file mode 100644
> index 000000000000..408e7dfce409
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,cec.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/mediatek/mediatek,cec.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mediatek HDMI CEC Controller Device Tree Bindings
> +
> +maintainers:
> +  - CK Hu <ck.hu@mediatek.com>
> +  - Jitao shi <jitao.shi@mediatek.com>
> +
> +description: |
> +  The HDMI CEC controller handles hotplug detection and CEC communication.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mediatek,mt7623-hdmi

=> mediatek,mt7623-cec

> +      - mediatek,mt8173-hdmi

=> mediatek,mt8173-cec

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1

[..]

> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi-ddc.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi-ddc.yaml
> new file mode 100644
> index 000000000000..c15b3470d652
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi-ddc.yaml
> @@ -0,0 +1,57 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/mediatek/mediatek,hdmi-ddc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mediatek HDMI DDC Device Tree Bindings
> +
> +maintainers:
> +  - CK Hu <ck.hu@mediatek.com>
> +  - Jitao shi <jitao.shi@mediatek.com>
> +
> +description: |
> +  The HDMI DDC i2c controller is used to interface with the HDMI DDC pins.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mediatek,mt7623-hdmi

=> mediatek,mt7623-hdmi-ddc

> +      - mediatek,mt8173-hdmi

=> mediatek,mt8173-hdmi-ddc

> +
> +  reg:
> +    maxItems: 1


[..]
will repost with these fixes in  a few days,

Neil
