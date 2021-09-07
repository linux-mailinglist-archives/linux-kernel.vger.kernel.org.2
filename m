Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1D0402E69
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 20:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345928AbhIGSef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 14:34:35 -0400
Received: from mail-oo1-f50.google.com ([209.85.161.50]:37636 "EHLO
        mail-oo1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240131AbhIGSee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 14:34:34 -0400
Received: by mail-oo1-f50.google.com with SMTP id k20-20020a4ad114000000b0029133123994so69907oor.4;
        Tue, 07 Sep 2021 11:33:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1Y7kz7rPiF3VaPntLj2tLYmDViv0USAD/qIq0pAgQr4=;
        b=VK5BGQI13gF5eBqMJcrw3GLIhY7sx0Yb4yblXUFfzLQPZUZQ7VLZnB7u1H833ArphM
         QnBAKCNxYvBNVwoQ484HRaO5DoOiSQg7uC41yQ4PR2HxEnYulzE8rGy5hsViJlGd6vQM
         H7y1DFzRet1HxEHRWiNXxN7nIPL0/gPCgk3dBlEGi+EWYTwACoqeihjiNRsI8GxUdO9B
         Jhw/TNIly5D+p4LBvCZlzQORvGJ47uRcQn/5ikiI5KLODlhY8z2fnzFH0JyuRMSn29QW
         xnpKu9H4BucW8bRHN4f4Xez/MbwS2YSrsOB+FYXrtM3KEMpnB+zRyqcv9RCqBYxc4LNS
         VvZA==
X-Gm-Message-State: AOAM5313ZpwkSGosAfxKdMfShbcTppdfiqitoRb7DgRn6Uf4CdoSLib7
        PPTd+1BoHHR69i1oWAgjIqjckV66hw==
X-Google-Smtp-Source: ABdhPJxlNBSI5uLOTxCRNzYNIaAk3qH4LtZ7Xee0x34y1IfrAyuuQA05q4QHPwlRCmrwT68IUwD7Cw==
X-Received: by 2002:a4a:966d:: with SMTP id r42mr1072671ooi.11.1631039607714;
        Tue, 07 Sep 2021 11:33:27 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id j14sm2374895oor.33.2021.09.07.11.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 11:33:27 -0700 (PDT)
Received: (nullmailer pid 115718 invoked by uid 1000);
        Tue, 07 Sep 2021 18:33:25 -0000
Date:   Tue, 7 Sep 2021 13:33:25 -0500
From:   Rob Herring <robh@kernel.org>
To:     Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: display: Add binding for LG.Philips
 SW43101
Message-ID: <YTewdZBsgmvwSTnb@robh.at.kernel.org>
References: <20210901180644.248177-1-y.oudjana@protonmail.com>
 <20210901180644.248177-3-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210901180644.248177-3-y.oudjana@protonmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2021 at 06:07:30PM +0000, Yassine Oudjana wrote:
> Add a device tree binding for LG.Philips SW43101.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>  .../display/panel/lgphilips,sw43101.yaml      | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/lgphilips,sw43101.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/lgphilips,sw43101.yaml b/Documentation/devicetree/bindings/display/panel/lgphilips,sw43101.yaml
> new file mode 100644
> index 000000000000..da049e9f244e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/lgphilips,sw43101.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: BSD-3-Clause

Not the right license(s). checkpatch.pl will tell you.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/lgphilips,sw43101.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: LG.Philips SW43101 1080x1920 OLED panel
> +
> +maintainers:
> +  - Yassine Oudjana <y.oudjana@protonmail.com>
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: lgphilips,sw43101

Looks like this can be added to panel-simple-dsi.yaml instead. Unless it 
has more than 1 power rail as you didn't document any.

> +
> +  port: true
> +  reg: true
> +  reset-gpios: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - reset-gpios
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    dsi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        panel@0 {
> +            compatible = "lgphilips,sw43101";
> +            reg = <0>;
> +
> +            reset-gpios = <&msmgpio 8 GPIO_ACTIVE_LOW>;
> +
> +            port {
> +                panel_in: endpoint {
> +                    remote-endpoint = <&dsi_out>;
> +                };
> +            };
> +        };
> +    };
> +
> +...
> -- 
> 2.33.0
> 
> 
> 
