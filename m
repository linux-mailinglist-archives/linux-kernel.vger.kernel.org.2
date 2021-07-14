Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94C7E3C8B9A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 21:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240163AbhGNT0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 15:26:37 -0400
Received: from mail-il1-f177.google.com ([209.85.166.177]:41920 "EHLO
        mail-il1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbhGNT0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 15:26:36 -0400
Received: by mail-il1-f177.google.com with SMTP id p3so2695203ilg.8;
        Wed, 14 Jul 2021 12:23:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8RzzEoAvTjRDMM8g7dcAMWcyrwovE5xMLGvQy5nCAsY=;
        b=Qna23t6sKx1Tf8vMvqIvZNiTDoUYJFjNcvMtCpyx0O02DWKIe0Su1UXawGqLqXgVQw
         Ou/fjIVX+RiFIrhQnnPqAOalKQG0LIhgiUWuisqHSNupooh0CXLgh/4CytK82igXuFXb
         qaxHuWV8cVoQqEdufO9FRDWtHTgadjfzj89KAwyngB4hzdlzKN8Mumv8V0ciVlSPxvqm
         ulbst0rHFd2szyXOGFGGL9YLBi4muUoUgyXyuS7hPD2pQFep0yDy/sk8iePqoPE/aPwT
         m/67jBql/vpLV/NQWzQ0H4hZ7wIbvURFvfohQi/xbJVcCavL5eYMB1FYylwCdlZ8mhKP
         wShA==
X-Gm-Message-State: AOAM531EIMo3dq50CHI7/DiGtXBpRUl638mgZhbZO9d0G+I1LZpMzll4
        PZnrVvbIbZUkBrR76wdZeQ==
X-Google-Smtp-Source: ABdhPJw5YTRfrNHFOvE4pdW8tnu15HjAyjf3k9XWYpDzVtRFjxea1nofvTyWdxwErGoY6HGqUB77eg==
X-Received: by 2002:a92:da86:: with SMTP id u6mr7869518iln.265.1626290623218;
        Wed, 14 Jul 2021 12:23:43 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id a11sm1878207ilf.79.2021.07.14.12.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 12:23:42 -0700 (PDT)
Received: (nullmailer pid 3059435 invoked by uid 1000);
        Wed, 14 Jul 2021 19:23:39 -0000
Date:   Wed, 14 Jul 2021 13:23:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, punit1.agrawal@toshiba.co.jp,
        yuji2.ishikawa@toshiba.co.jp, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] dt-bindings: clock: Add DT bindings for PLL of
 Toshiba Visconti TMPV770x SoC
Message-ID: <20210714192339.GA3052504@robh.at.kernel.org>
References: <20210624034337.282386-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20210624034337.282386-3-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210624034337.282386-3-nobuhiro1.iwamatsu@toshiba.co.jp>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 12:43:35PM +0900, Nobuhiro Iwamatsu wrote:
> Add device tree bindings for PLL of Toshiba Visconti TMPV770x SoC series.
> 
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> ---
>  .../clock/toshiba,tmpv770x-pipllct.yaml       | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/toshiba,tmpv770x-pipllct.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/toshiba,tmpv770x-pipllct.yaml b/Documentation/devicetree/bindings/clock/toshiba,tmpv770x-pipllct.yaml
> new file mode 100644
> index 000000000000..e88c9e4c4982
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/toshiba,tmpv770x-pipllct.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/toshiba,tmpv770x-pipllct.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Toshiba Visconti5 TMPV770X PLL Controller Device Tree Bindings
> +
> +maintainers:
> +  - Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> +
> +description:
> +  Toshia Visconti5 PLL controller which supports the PLLs on TMPV770X.
> +
> +properties:
> +  compatible:
> +    const: toshiba,tmpv7708-pipllct
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#clock-cells':
> +    const: 1
> +
> +  osc2-clk-frequency:
> +    description: Frequency of the OSC2 oscillator.

This is an external input? This should be a fixed-clock and this node 
needs 'clocks' to connect it.

> +
> +required:
> +  - compatible
> +  - reg
> +  - "#clock-cells"
> +  - osc2-clk-frequency
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        pipllct: pipllct@24220000 {

clock-controller@...

> +            compatible = "toshiba,tmpv7708-pipllct";
> +            reg = <0 0x24220000 0 0x820>;
> +            #clock-cells = <1>;
> +            osc2-clk-frequency = <20000000>;
> +        };
> +    };
> +...
> -- 
> 2.32.0
> 
> 
