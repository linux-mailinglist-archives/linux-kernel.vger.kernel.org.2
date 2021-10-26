Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE4FD43BB10
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 21:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235088AbhJZTkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 15:40:42 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:37687 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbhJZTkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 15:40:40 -0400
Received: by mail-ot1-f47.google.com with SMTP id b4-20020a9d7544000000b00552ab826e3aso234036otl.4;
        Tue, 26 Oct 2021 12:38:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7anbp20VhpEFISp7BgAsV6EJPG6+J1HMLEmCYOo/hT0=;
        b=8PoJ93xPP/Vvz26/w0VYELsmQHCqMVMLi0FJb/snliKAtqnK5INQggQ/Ula0Tm/nhY
         xBN2oQdutEKPW/AQ0+QZKWk5OhbsXY0e9YkbDmJjGM2TnDEH/5OXZ+NnzPkxP05jwoNV
         tOg8FHpiaNHTZdL6kVcSGMRTX39n5/FPFPdAQrg30ZTbWYwkoyTwWb6BRGByJS0JvwCz
         4bQxlR64uXlbg0oUnR2kbKlhM86bPkixmhuQ1CnnPVrB0AHtSjQprRzy+z2QSaTQ05MI
         0LxyWN9sYT9XlpNlNufM6+3ez+N46iBdPlsp+18ZfCyeJCCbiZuouq6pPHYfHtwip5SI
         gf3w==
X-Gm-Message-State: AOAM530dOUYevMH1notnkrgFHKVKUFGOvQTLOnl7RwyR1dXPp6qTPhjz
        NlqUeI1ePeGOuyTsWUyeJw==
X-Google-Smtp-Source: ABdhPJwTt1pkFtye7CZvJrO0zF7kPvPNQfmV3RlknuymPSTwxN9abcq5ilMolzT2PWa7uM55vMhopw==
X-Received: by 2002:a9d:4b94:: with SMTP id k20mr21059144otf.203.1635277096250;
        Tue, 26 Oct 2021 12:38:16 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 16sm4962498oty.20.2021.10.26.12.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 12:38:15 -0700 (PDT)
Received: (nullmailer pid 3102541 invoked by uid 1000);
        Tue, 26 Oct 2021 19:38:14 -0000
Date:   Tue, 26 Oct 2021 14:38:14 -0500
From:   Rob Herring <robh@kernel.org>
To:     George Song <georgesong0119@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        george.song@maximintegrated.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        "george.song" <george.song@analog.com>
Subject: Re: [PATCH 1/2] ALSA SoC MAX98520 dt-bindings : Added device tree
 binding for max98520 Signed-off-by: George Song
 <george.song@maximintegrated.com>
Message-ID: <YXhZJiXmT/duNu/M@robh.at.kernel.org>
References: <20211013060441.18177-1-georgesong0119@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013060441.18177-1-georgesong0119@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 03:04:41PM +0900, George Song wrote:
> From: "george.song" <george.song@analog.com>

Patches must have an author name, commit message, and a Signed-off-by. 
Please use checkpatch.pl which will point out some of this.

> 
> ---
>  .../bindings/sound/maxim,max98520.yaml        | 35 +++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/maxim,max98520.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/maxim,max98520.yaml b/Documentation/devicetree/bindings/sound/maxim,max98520.yaml
> new file mode 100644
> index 000000000000..02481428e2ed
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/maxim,max98520.yaml
> @@ -0,0 +1,35 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/maxim,max98520.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim Integrated MAX98520 Speaker Amplifier Driver
> +
> +maintainers:
> +  - Goerge Song <George.song@maximintegrated.com>
> +
> +properties:
> +  compatible:
> +    const: maxim,max98520
> +
> +  reg:
> +    maxItems: 1
> +    description: I2C address of the device.
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      max98520: amplifier@38 {
> +        compatible = "maxim,max98520";
> +        reg = <0x38>;
> +      };
> +    };
> -- 
> 2.25.1
> 
> 
