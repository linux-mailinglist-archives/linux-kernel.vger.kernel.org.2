Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E44C03FC93D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 16:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234693AbhHaOBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 10:01:15 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]:35383 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233044AbhHaOA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 10:00:27 -0400
Received: by mail-oi1-f181.google.com with SMTP id r26so24768638oij.2;
        Tue, 31 Aug 2021 06:59:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Pc6KfUdjMc8QEHIil1UQVUj3n0u1lSzF/AXdD89eq1o=;
        b=gVgFnQlLXO4KXegeIzEzAQ2+YVkzbRkB+avAqHERlp4w5/ip8XrlqT9XqKaYkUwkdz
         dEznRElcA5mIHpslFXttVR/OeZUNe3VtwxixFEgUFNt7/kII25mR4LJvoJTjeAy1TyP/
         Hk2aZbiq2QVoVyvZSq0nQR8CL5xrn7bok7GOYkd65qvSFljiJW0ZIi0usuvBo6R/YJ4S
         qcDJNOC/lxePfHshoTg6oVS1k1ekVNURasyITRXLnM9YeS78zkZS3Wxxi0K1MzvXjk+f
         bhXn9j+JEQ69+obNjCAV2+cRl874Vckz6ivr+735ROLbhszfjl60y9qrRD51FS3Db8OU
         0dBQ==
X-Gm-Message-State: AOAM532gbEmbOHR6aaTUiV9eeQxw5iS3j7rh9oAvjm2RStPoP3Wi0ogy
        gJHlKYz/kMmCVzR7B3xZxDBO/Cha5w==
X-Google-Smtp-Source: ABdhPJxN5eTaWdeT8T1E0xvDyOiCmMJZDshPCi5xRlCx4p0/jKRlNwUg4mRaYb042F4HlZqxN/2kiw==
X-Received: by 2002:aca:1802:: with SMTP id h2mr3246052oih.146.1630418369985;
        Tue, 31 Aug 2021 06:59:29 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id n130sm3562611oif.32.2021.08.31.06.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 06:59:29 -0700 (PDT)
Received: (nullmailer pid 75468 invoked by uid 1000);
        Tue, 31 Aug 2021 13:59:28 -0000
Date:   Tue, 31 Aug 2021 08:59:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Christophe Branchereau <cbranchereau@gmail.com>,
        list@opendingux.net, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: display/panel: Add AUO A030JTN01
Message-ID: <YS41wPKzZkq8Z5jo@robh.at.kernel.org>
References: <20210828112640.7248-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210828112640.7248-1-paul@crapouillou.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2021 at 12:26:39PM +0100, Paul Cercueil wrote:
> Add binding for the AUO A030JTN01 panel, which is a 320x480 3.0" 4:3
> 24-bit TFT LCD panel with non-square pixels and a delta-RGB 8-bit
> interface.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  .../bindings/display/panel/auo,a030jtn01.yaml | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/auo,a030jtn01.yaml

This appears to be panel-simple.yaml plus 'reg' (and potentially other 
SPI properties). Perhaps rename to panel-simple-spi.yaml? Maybe there's 
others already?

> 
> diff --git a/Documentation/devicetree/bindings/display/panel/auo,a030jtn01.yaml b/Documentation/devicetree/bindings/display/panel/auo,a030jtn01.yaml
> new file mode 100644
> index 000000000000..21c9d62e3625
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/auo,a030jtn01.yaml
> @@ -0,0 +1,57 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/auo,a030jtn01.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AUO A030JTN01 3.0" (320x480 pixels) 24-bit TFT LCD
> +
> +description: |
> +  The panel must obey the rules for a SPI slave device as specified in
> +  spi/spi-controller.yaml
> +
> +maintainers:
> +  - Paul Cercueil <paul@crapouillou.net>
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: auo,a030jtn01
> +
> +  backlight: true
> +  port: true
> +  power-supply: true
> +  reg: true
> +  reset-gpios: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - power-supply
> +  - reset-gpios
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    panel@0 {
> +      compatible = "auo,a030jtn01";
> +      reg = <0>;
> +
> +      spi-max-frequency = <10000000>;
> +
> +      reset-gpios = <&gpe 4 GPIO_ACTIVE_LOW>;
> +      power-supply = <&lcd_power>;
> +
> +      backlight = <&backlight>;
> +
> +      port {
> +        panel_input: endpoint {
> +          remote-endpoint = <&panel_output>;
> +        };
> +      };
> +    };
> -- 
> 2.33.0
> 
> 
