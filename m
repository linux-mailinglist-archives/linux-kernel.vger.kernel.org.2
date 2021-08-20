Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4383F34E9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 22:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238779AbhHTUCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 16:02:37 -0400
Received: from mail-oo1-f43.google.com ([209.85.161.43]:41911 "EHLO
        mail-oo1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236881AbhHTUCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 16:02:35 -0400
Received: by mail-oo1-f43.google.com with SMTP id f33-20020a4a89240000b029027c19426fbeso3212760ooi.8;
        Fri, 20 Aug 2021 13:01:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wlbFPYPY/Xtj1KW5rp0UccGo9s5jQlV0fCqX0LEM8rA=;
        b=e/59TO5cJ69b/pa1GrdqAeWrgKfn8mLoOiv2MhI89dMXLbf2LWZPAksP6TWMalF4uD
         kJebtNNCOLBYTTEREwoZ8tTzgbWrV9zMM+UsyuLXA6ANmxIOcFo1QHR+EAnZ4uIfZKRi
         D159CARt5t8vxFw4Z5no3IknwBXbTrnYlEVTp3CgKyWoSi7t4GswiOr2V10qwnX2mF/d
         erO/BUTSUtOYyYLoXOWcoK8++xc2Tg7evBHzS2qzDR+GTV6LpSSOAIC1l5+fyInhzBiB
         rlmozJHRwAQB9hEHYUe3xXNlkDiPHNZLhL+K8c6FrXrpdPW2P9dOLYBrKrcZyH1ZlkNz
         jX4A==
X-Gm-Message-State: AOAM530YgZy0Xi6MVUojjMQivf/qQ3t3LU2nh7n8UDmnzRrlys0E7ogu
        a4zy6dETeItqrJL0Exbtzw==
X-Google-Smtp-Source: ABdhPJys2nyF9UYQYqZJu3h13pyM0x7e7+IP1RxgPq7sPk58kOG6bqF1k5cdEbYjpsmGblW/KXee2Q==
X-Received: by 2002:a4a:bc90:: with SMTP id m16mr17240148oop.33.1629489717171;
        Fri, 20 Aug 2021 13:01:57 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id w15sm1385177oiw.19.2021.08.20.13.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 13:01:56 -0700 (PDT)
Received: (nullmailer pid 3886974 invoked by uid 1000);
        Fri, 20 Aug 2021 20:01:55 -0000
Date:   Fri, 20 Aug 2021 15:01:55 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Cc:     joel@jms.id.au, andrew@aj.id.au, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ryan_chen@aspeedtech.com
Subject: Re: [PATCH v2 1/5] dt-bindings: aspeed: Add eSPI controller
Message-ID: <YSAKM16WLx4UWIQu@robh.at.kernel.org>
References: <20210819080040.31242-1-chiawei_wang@aspeedtech.com>
 <20210819080040.31242-2-chiawei_wang@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210819080040.31242-2-chiawei_wang@aspeedtech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2021 at 04:00:36PM +0800, Chia-Wei Wang wrote:
> Add dt-bindings for Aspeed eSPI controller
> 
> Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> ---
>  .../devicetree/bindings/soc/aspeed/espi.yaml  | 158 ++++++++++++++++++
>  1 file changed, 158 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/aspeed/espi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/aspeed/espi.yaml b/Documentation/devicetree/bindings/soc/aspeed/espi.yaml
> new file mode 100644
> index 000000000000..fec3d37f3ffd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/aspeed/espi.yaml
> @@ -0,0 +1,158 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# # Copyright (c) 2021 Aspeed Technology Inc.
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/soc/aspeed/espi.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Aspeed eSPI Controller
> +
> +maintainers:
> +  - Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> +  - Ryan Chen <ryan_chen@aspeedtech.com>
> +
> +description:
> +  Aspeed eSPI controller implements a slave side eSPI endpoint device
> +  supporting the four eSPI channels, namely peripheral, virtual wire,
> +  out-of-band, and flash.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - aspeed,ast2500-espi
> +          - aspeed,ast2600-espi
> +      - const: simple-mfd
> +      - const: syscon

Is this really 2 sub devices that could be used individually or in a 
different combination? If not, then I'd make all this 1 node.

Rob
