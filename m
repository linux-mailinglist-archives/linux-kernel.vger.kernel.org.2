Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8B133E14A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 23:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbhCPWUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 18:20:02 -0400
Received: from mail-io1-f50.google.com ([209.85.166.50]:45874 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbhCPWTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 18:19:38 -0400
Received: by mail-io1-f50.google.com with SMTP id a7so38907511iok.12;
        Tue, 16 Mar 2021 15:19:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=oYgQtLAcDkuiiVRZNURhrrpQnYuhErdiIXEJ4Ufn24g=;
        b=cLdIMxpRFFxAvRtKXubq/Pm0vF/PZwRsj7ASntPhpTSWYqHFGD/lQGPJshilXkaRUe
         IKHH/BVFAUuvCRnC7jfpKMNPo2mxYVLh9ZxXUlpTTN7r1sgQiyLx+v2HqZeKxmp5C7vE
         7ffyZgIEBKPbWDmH74q2Zxm5SjR+DM4Doaw83fzlUMJwdt5bFUbFARk2/q3VeNb3YdJK
         /5S+Du8hDmNsl5hTek8kkGZapc3L/WYuPwfzJYLzMVm8SDkFyNSOKAEKBb7FayxFhnvc
         fz3qcmuUhe8Zu00H1gAlB8DgWp5CP0hh80bO3YN729/SRENdjkj6WTFUb8jwKlwrNU8V
         6TLQ==
X-Gm-Message-State: AOAM531M3ikLKuU3BBhl1/U//X+KEVow9wtaa+wLkaysglpZ62lPo/p4
        5fPQtafZvO+e7BPeOUcn6z1+gyAFzA==
X-Google-Smtp-Source: ABdhPJz4K6Y8JD6lcRDjBOoDjvVLizQXfXiKGk1a1rv79FMAkLG2rir+/YbIhr+/u31qoR1eVKZoHw==
X-Received: by 2002:a5d:93cc:: with SMTP id j12mr4932416ioo.15.1615933177701;
        Tue, 16 Mar 2021 15:19:37 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id n16sm8831040ilq.71.2021.03.16.15.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 15:19:37 -0700 (PDT)
Received: (nullmailer pid 3784287 invoked by uid 1000);
        Tue, 16 Mar 2021 22:19:34 -0000
Date:   Tue, 16 Mar 2021 16:19:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH robh next] dt-bindings: usb: add USB controller port
Message-ID: <20210316221934.GA3768880@robh.at.kernel.org>
References: <20210309121311.7263-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210309121311.7263-1-zajec5@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2021 at 01:13:11PM +0100, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> USB bindings already allow specifying USB device hard wired to a
> specific controller port but they don't allow describing port on its
> own.
> 
> This fixes:
> arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dt.yaml: usb@23000: port@1: 'compatible' is a required property
>         From schema: Documentation/devicetree/bindings/usb/generic-xhci.yaml
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
> Please check if I got the $nodename part right. Somehow I don't see any
> errors / warnings when using:
> 
> something@1 {
> 	reg = <1>;
> };

$nodename may not work in child nodes of a schema.

> ---
>  .../devicetree/bindings/usb/usb-hcd.yaml      |  4 +-
>  .../devicetree/bindings/usb/usb-port.yaml     | 39 +++++++++++++++++++
>  2 files changed, 42 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/usb/usb-port.yaml
> 
> diff --git a/Documentation/devicetree/bindings/usb/usb-hcd.yaml b/Documentation/devicetree/bindings/usb/usb-hcd.yaml
> index 56853c17af66..b0c6a79cad57 100644
> --- a/Documentation/devicetree/bindings/usb/usb-hcd.yaml
> +++ b/Documentation/devicetree/bindings/usb/usb-hcd.yaml
> @@ -33,7 +33,9 @@ patternProperties:
>    "^.*@[0-9a-f]{1,2}$":
>      description: The hard wired USB devices
>      type: object
> -    $ref: /usb/usb-device.yaml
> +    oneOf:
> +      - $ref: /usb/usb-port.yaml
> +      - $ref: /usb/usb-device.yaml
>  
>  additionalProperties: true
>  
> diff --git a/Documentation/devicetree/bindings/usb/usb-port.yaml b/Documentation/devicetree/bindings/usb/usb-port.yaml
> new file mode 100644
> index 000000000000..68fe16c8703e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/usb-port.yaml
> @@ -0,0 +1,39 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/usb-port.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: USB port on USB controller
> +
> +maintainers:
> +  - Rafał Miłecki <rafal@milecki.pl>
> +
> +description: |
> +  This binding describes a single USB controller port that doesn't have any
> +  device hard wired.
> +
> +properties:
> +  $nodename:
> +    pattern: "^port@[0-9a-f]{1,2}$"

Unfortunately, 'port' is used elsewhere, so this would be applied 
any node that matches. That's not really a problem as this is simple 
enough, but then what does it buy us?

I'd be fine just dropping 'compatible' as required in usb-device.yaml.

> +
> +  reg:
> +    description: number of USB controller port
> +    maxItems: 1
> +
> +required:
> +  - reg
> +
> +additionalProperties: true
> +
> +examples:
> +  - |
> +    usb@11270000 {
> +        reg = <0x11270000 0x1000>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        port@1 {
> +            reg = <1>;
> +        };
> +    };
> -- 
> 2.26.2
> 
