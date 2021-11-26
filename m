Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C465C45E3EF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 02:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343655AbhKZBUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 20:20:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244254AbhKZBSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 20:18:02 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90906C061746
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 17:14:50 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id v15-20020a9d604f000000b0056cdb373b82so11728204otj.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 17:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mHC9ppagTm7NImXiQs+2uZpgzdRA1KRSenhFtTzEGb4=;
        b=tuOzZ5S+mCLY/AGkCNfNfTvDGpzt/VA7ynFdgPalTQZo/p2a0jtutBdjGcuJFQPFWO
         91ymrNALmy2Bk8eXeWyislh+OsjZVedjgKdhsoRWWsPE39sw4gmyIXvtzRhxmQWXmm5/
         jqKOR+CQJdkw5ZVNbUktrzXGH2Beo4LjHk02yJiPzXK4Kiz+zDOs4gDfZ1qdM9VbFUzr
         86WwB+GsugP+UfTtDl8cp74pG9/Uj3gQ4bmyWhurUynwuPQ5hhY85MHD6nc+8PTImgC4
         eNKl0BxZuP5quLcA3Zq2vQncqQjIyKa/BLXXoOaCDd4tHAcz2rTG+vRGv0bDy0agxofX
         1f1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mHC9ppagTm7NImXiQs+2uZpgzdRA1KRSenhFtTzEGb4=;
        b=q8knjoZ9174Cd5ZcW5Xp9UxabikTq3gOy23bMizarNm3Tu8cXyE0sIZ34n5p8N1jzG
         8l0kwdjD3lJMezCAEQt3mFaQTtJ7ML1DfDwtpLbrSDCPbaHUNO6s2ve4uFf1PI7bsWrA
         ixHetx4mDVOxFAAKPB+bHT9vr+c2pmsmyzaGgqTk9tzElGlsr00TtVbvQkhvxEq+w1rj
         0C64f/qlBCOgHpSl18/c6RptMfeGLx8Ljl8IcqmrJjd0UgofizRUJYdJwwxmbjZqFhwj
         TqqoEXox4w7gaprr/DTYKwA2XXh6NlePtmjQQTeCjzJoHj2FoFvYOgRHLCK4GozYAfkE
         cK+Q==
X-Gm-Message-State: AOAM530E/fGuZkdtcAKN517xijSmv9t5oeZEM/3lFFDZu8tzvHXfNEWt
        yC0UiMl3TBx+uzH011h9TFaiiFfAzz1l5P61aa+GAA==
X-Google-Smtp-Source: ABdhPJzKMXqySnntDR1x0DX+w3CHJ4WW1btKlW2suMdV3Yxh6M4KwRmE179J94pvhVuCM7pYOZZPp8KV3lcO6NEJ5Ro=
X-Received: by 2002:a9d:a42:: with SMTP id 60mr25991905otg.179.1637889289852;
 Thu, 25 Nov 2021 17:14:49 -0800 (PST)
MIME-Version: 1.0
References: <1637834276-10466-1-git-send-email-sugaya.taichi@socionext.com> <1637834276-10466-3-git-send-email-sugaya.taichi@socionext.com>
In-Reply-To: <1637834276-10466-3-git-send-email-sugaya.taichi@socionext.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 26 Nov 2021 02:14:38 +0100
Message-ID: <CACRpkdbgMMKJwS0cUi3D2swHYbbBH6ofSeOhyXy6qiMFrU5a8Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] dt-bindings: pinctrl: add bindings for Milbeaut
 pin controller
To:     Sugaya Taichi <sugaya.taichi@socionext.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        orito.takao@socionext.com,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2021 at 10:58 AM Sugaya Taichi
<sugaya.taichi@socionext.com> wrote:

> Add Device Tree bindings documentation for pin controller of
> the Milbeaut SoCs.
>
> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>

What is weird about this binding is what is not there:
this is just GPIO, where are the pin mux and config
nodes? The driver surely tries to use them.

Please use the existing standard bindings for functions
and groups etc, check the other bindings.

Yours,
Linus Walleij

> ---
>  .../pinctrl/socionext,milbeaut-pinctrl.yaml        | 51 ++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/socionext,milbeaut-pinctrl.yaml
>
> diff --git a/Documentation/devicetree/bindings/pinctrl/socionext,milbeaut-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/socionext,milbeaut-pinctrl.yaml
> new file mode 100644
> index 0000000..78bc2d4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/socionext,milbeaut-pinctrl.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/socionext,milbeaut-pinctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Milbeaut SoCs pin controller
> +
> +maintainers:
> +  - Taichi Sugaya <sugaya.taichi@socionext.com>
> +
> +description: |
> +  Bindings for memory-mapped pin controller of the Milbeaut SoCs.
> +
> +properties:
> +  $nodename:
> +    pattern: "pinctrl"
> +
> +  compatible:
> +    enum:
> +      - socionext,milbeaut-m10v-pinctrl
> +
> +  reg:
> +    maxItems: 1
> +
> +  reg-names:
> +    const: "pinctrl"
> +
> +  gpio-controller: true
> +
> +  "#gpio-cells":
> +    const: 2
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - gpio-controller
> +  - "#gpio-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pinctrl: pinctrl@1d022000 {
> +        compatible = "socionext,milbeaut-m10v-pinctrl";
> +        reg = <0x1d022000 0x1000>;
> +        reg-names = "pinctrl";
> +        gpio-controller;
> +        #gpio-cells = <2>;
> +    };
> --
> 2.7.4
>
