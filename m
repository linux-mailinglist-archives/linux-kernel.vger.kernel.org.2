Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC3DA397C4E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 00:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235015AbhFAWOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 18:14:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:58762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234994AbhFAWOU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 18:14:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 63A45613CE
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 22:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622585558;
        bh=Ad1eL1AWJAJdVUmJWLiNYCF4IHJrI7COz5qOwTt6Eh0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RcF0/5ucU/MfZVJzdsgF8W7SL41bbbgJHjM16UafjAHYGpigrwWasRijqMvGxILC+
         d3X23KohVuEK0rLAI/ij5tQ6BAVIQycm41wqjs9W4yy6OMHyKH1CFKGY39t8bX2le1
         AWaRoRP4SvIqouNIthvSvegHCf2XhV7eo9Iwy+yh9mvHLuGIAOWADbor/h7qwdvFr0
         Mf4ovIHTHONKe6xCcT6Ko2aC17M3TaOn2lUuJsarITTVHXscg1N88LaXZuvc4JMdJT
         V891FiA2hvMqmSCohQQtEexmY8oknW6QhXB7VoYhGHUd3VjCBsVtA+g2Q7p0+O2Xgi
         t6o4wFsYJ99tQ==
Received: by mail-qt1-f171.google.com with SMTP id v4so456961qtp.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 15:12:38 -0700 (PDT)
X-Gm-Message-State: AOAM531ItSErKFqGWDgdE/AidLyhW1N6F670mkJjMQ9g2DtcVIDuk78e
        6uuh6QEyFzJsVS74n5lzoitm+JPf6iQ8plepRA==
X-Google-Smtp-Source: ABdhPJxR1YinCY6PnianMxJxJpENLezl1ZuF3RZth4wnJfNAzP312Hdgv2hMUZKjgcdWK3iRazgXSZw6ZmaRrClnf5Y=
X-Received: by 2002:ac8:5894:: with SMTP id t20mr21406179qta.134.1622585557523;
 Tue, 01 Jun 2021 15:12:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1615713499.git.wilken.gottwalt@posteo.net> <b7a1f5532e0ae474473858055fd9bbabff9e1449.1615713499.git.wilken.gottwalt@posteo.net>
In-Reply-To: <b7a1f5532e0ae474473858055fd9bbabff9e1449.1615713499.git.wilken.gottwalt@posteo.net>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 1 Jun 2021 17:12:26 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+z=VApY+5oXYaLzndfBf=EueiA_d+5=1GSjKqcLOPO-g@mail.gmail.com>
Message-ID: <CAL_Jsq+z=VApY+5oXYaLzndfBf=EueiA_d+5=1GSjKqcLOPO-g@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] dt-bindings: hwlock: add sun6i_hwspinlock
To:     Wilken Gottwalt <wilken.gottwalt@posteo.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 14, 2021 at 4:30 AM Wilken Gottwalt
<wilken.gottwalt@posteo.net> wrote:
>
> Adds documentation on how to use the sun6i_hwspinlock driver for sun6i
> compatible series SoCs.

To repeat what I said on v5: please Cc DT patches to the DT list so
checks run and they get in my queue.

Now this is breaking dt_binding_check in linux-next, so drop, revert or fix it.

>
> Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
> ---
> Changes in v7:
>   - changed dt documentation to the name of the compatible string
>
> Changes in v6:
>   - fixed formating and name issues in dt documentation
>
> Changes in v5:
>   - changed binding to earliest known supported SoC sun6i-a31
>   - dropped unnecessary entries
>
> Changes in v4:
>   - changed binding to sun8i-a33-hwpinlock
>   - added changes suggested by Maxime Ripard
>
> Changes in v3:
>   - changed symbols from sunxi to sun8i
>
> Changes in v2:
>   - fixed memory ranges
> ---
>  .../allwinner,sun6i-a31-hwspinlock.yaml       | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwlock/allwinner,sun6i-a31-hwspinlock.yaml
>
> diff --git a/Documentation/devicetree/bindings/hwlock/allwinner,sun6i-a31-hwspinlock.yaml b/Documentation/devicetree/bindings/hwlock/allwinner,sun6i-a31-hwspinlock.yaml
> new file mode 100644
> index 000000000000..733c3d01e56c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwlock/allwinner,sun6i-a31-hwspinlock.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwlock/allwinner,sun6i-hwspinlock.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SUN6I hardware spinlock driver for Allwinner sun6i compatible SoCs
> +
> +maintainers:
> +  - Wilken Gottwalt <wilken.gottwalt@posteo.net>
> +
> +description:
> +  The hardware unit provides semaphores between the ARM cores and the embedded
> +  companion core on the SoC.
> +
> +properties:
> +  compatible:
> +    const: allwinner,sun6i-a31-hwspinlock
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - resets
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    hwlock@1c18000 {
> +        compatible = "allwinner,sun6i-a31-hwspinlock";
> +        reg = <0x01c18000 0x1000>;
> +        clocks = <&ccu CLK_BUS_SPINLOCK>;
> +        resets = <&ccu RST_BUS_SPINLOCK>;

Error: Documentation/devicetree/bindings/hwlock/allwinner,sun6i-a31-hwspinlock.example.dts:22.28-29
syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:402:
Documentation/devicetree/bindings/hwlock/allwinner,sun6i-a31-hwspinlock.example.dt.yaml]
Error 1


You need to include the headers for the defines.



Rob
