Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 687563E30A1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 23:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238496AbhHFVFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 17:05:01 -0400
Received: from mail-io1-f46.google.com ([209.85.166.46]:39482 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbhHFVE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 17:04:59 -0400
Received: by mail-io1-f46.google.com with SMTP id f6so14042760ioc.6;
        Fri, 06 Aug 2021 14:04:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jP3TZKyzFcLB2i0w7DBw/JvVOkdFgDubTV/oEOMEQ0s=;
        b=rU73tg8m622FjdARS/hOA8o+Tn1zQocXGRmYYjk062Bk1cvz1ihdfVDg9mI5iqKvvT
         PWMG1xUN9Unx0Gyd69hgD81GfExMtCiPiob6ge3MIeO+QHiiGUp9QprHGLDtZt8cK1OC
         3zAyeqjiDWvNmby4BPOW7QNqYNf5Rg0Be+bDwr0RRkxRCiWtL3SbSXM0vVIposunBdkn
         gJvyt6Dvc29R5c3L3FYLt2DK7MIMDX74PwtBn+W1v1XlbqvPNodzvXefTVIJmtaPdPyL
         fO3aTz47dCPltZaqzKQFTbZjwr1ZZTi5G/G7kkmdnksNjViz4R1e0enN/rWzeajfLH1f
         K37Q==
X-Gm-Message-State: AOAM5317vH1UrwcD86TyorxFF/YtT5oB+YttOYb5qGQoQOdCGGq/SX6H
        b9oatCMIuXqaYeBpUsbeIi4+8Eni/g==
X-Google-Smtp-Source: ABdhPJznOoUncq6Z9FynO/vhe15eO+Cy5FKHwUSguEUHxgYrL0b99/Mw87O4Agi24ATlQzd+Qt8E6w==
X-Received: by 2002:a02:c9c4:: with SMTP id c4mr9794296jap.67.1628283882876;
        Fri, 06 Aug 2021 14:04:42 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id w13sm5280663ilo.10.2021.08.06.14.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 14:04:42 -0700 (PDT)
Received: (nullmailer pid 1795068 invoked by uid 1000);
        Fri, 06 Aug 2021 21:04:41 -0000
Date:   Fri, 6 Aug 2021 15:04:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bert Vermeulen <bert@biot.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        John Crispin <john@phrozen.org>, Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH 2/5] dt-bindings: arm: econet: Add binding for EN7523 SoC
 and EVB
Message-ID: <YQ2j6fOetplrlMnj@robh.at.kernel.org>
References: <20210730134552.853350-1-bert@biot.com>
 <20210730134552.853350-3-bert@biot.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210730134552.853350-3-bert@biot.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2021 at 03:45:49PM +0200, Bert Vermeulen wrote:
> From: John Crispin <john@phrozen.org>
> 
> Add devicetree binding for Econet EN7523 SoC and evaluation board.
> 
> Signed-off-by: John Crispin <john@phrozen.org>
> Signed-off-by: Bert Vermeulen <bert@biot.com>
> ---
>  .../devicetree/bindings/arm/econet.yaml       | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/econet.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/econet.yaml b/Documentation/devicetree/bindings/arm/econet.yaml
> new file mode 100644
> index 000000000000..39128f959fef
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/econet.yaml
> @@ -0,0 +1,27 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/econet.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: EcoNet SoC based Platforms Device Tree Bindings
> +
> +maintainers:
> +  - Felix Fietkau <nbd@nbd.name>
> +  - John Crispin <john@phrozen.org>

Blank line

> +description: |

Don't need '|' if no formatting to maintain.

> +  Boards with an EcoNet SoC shall have the following properties.
> +
> +properties:
> +  $nodename:
> +    const: '/'
> +  compatible:
> +    oneOf:

Expecting other SoCs soonish? If not, drop 'oneOf'.

> +      - items:
> +          - enum:
> +              - econet,en7523-evb
> +          - const: econet,en7523
> +
> +additionalProperties: true
> +
> +...
> -- 
> 2.25.1
> 
> 
