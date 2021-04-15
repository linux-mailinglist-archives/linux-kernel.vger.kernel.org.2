Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11189361405
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 23:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235729AbhDOVR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 17:17:58 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]:39535 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234959AbhDOVR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 17:17:57 -0400
Received: by mail-oi1-f181.google.com with SMTP id i81so25719039oif.6;
        Thu, 15 Apr 2021 14:17:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fK2xO1LzXOeYiXzPsV7w3g3ABzLHTalsqqUFl8JwTMg=;
        b=STfXal+UI4XBQVaJDHkOui7evi8zQlMOd0eXjy2CpBu/32MHU3m8dqqWtRyVqucbk5
         OIfK7YaKwRM/QvOMzYFlB7u84jSv4rHQ9tjnbegDu10Z+C9u+fVBxIkAq7nIy7yNEKS0
         9WHLV7tCm/uLy6zzQZPDhlnZxYRa1XJRoZxG14HE1153LA/6CkT+VAB+hp49wg4KYvGY
         QoWzWCWXfad9G1Rh7vezI+NOLaVKWJ1i/a40L/qUKalZTV5FvSS2AHD62LWlTghJU6aO
         OQP/DugOg9b9g+pNQ3pH8Jt7VeecTusdGZ9PGLgpArNVDxFfjaWb4JyHPKHvxEMU5dLC
         5Xsg==
X-Gm-Message-State: AOAM532buvDBVDWWqsfvZ6tWgcEagHZC9+Rz7XkMfL6D2Fuf0NBr4p7p
        im1DaLoFTMcoQOlCs6lNRQ==
X-Google-Smtp-Source: ABdhPJwcvCwgfS/zWOl0KWJLgonXvdFuGCFAtbmngGV436lxMksPVRAXYNQIEzAqJjk1ZLE0+Ac9Lg==
X-Received: by 2002:a05:6808:bd6:: with SMTP id o22mr3941544oik.129.1618521452315;
        Thu, 15 Apr 2021 14:17:32 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l204sm877587oia.11.2021.04.15.14.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 14:17:31 -0700 (PDT)
Received: (nullmailer pid 1897885 invoked by uid 1000);
        Thu, 15 Apr 2021 21:17:31 -0000
Date:   Thu, 15 Apr 2021 16:17:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nishanth Menon <nm@ti.com>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>, s-anna@ti.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V2] dt-bindings: mailbox: ti,secure-proxy: Convert to yaml
Message-ID: <20210415211731.GA1892348@robh.at.kernel.org>
References: <20210413224535.30910-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210413224535.30910-1-nm@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 05:45:35PM -0500, Nishanth Menon wrote:
> Convert the ti,secure-proxy to yaml for better checks and documentation.
> Differences being mostly in the examples:
> - I've dropped the example usage of mailbox client, it is better done in
>   tisci node definition
> - Switched reg usage for address-cells and size-cells 1 - aligned with
>   schema checks as well
> - included header in example for buildable example
> 
> While at this, lets make sure to support upto 100 rx threads even though
> typically upto 1 threads is practically in use.
> 
> NOTE: The following checkpatch warning is generated since we do include the header
> in the example, but this is a false positive warning.
>   WARNING: DT binding docs and includes should be a separate patch. See: Documentation/devicetree/bindings/submitting-patches.rst
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> Changes since V1: (Thanks Suman for some offline comments)
> - Strengthened interrupt-names property to be on rails
> - More documentation (we dont want an information loss between txt and
>   yaml)
> - Added a max interrupts of 100, which is a rather conservative limit on
>   current devices, but who knows..
> - Commit message updates
> - compatible is a simpler const.
> - interrupt-names are required property - makes no sense in not knowing
>   which interrupts belong to which thread irqs.
> 
> V1: https://lore.kernel.org/linux-arm-kernel/20210413171230.5872-1-nm@ti.com/
> 
>  .../bindings/mailbox/ti,secure-proxy.txt      | 50 ------------
>  .../bindings/mailbox/ti,secure-proxy.yaml     | 79 +++++++++++++++++++
>  2 files changed, 79 insertions(+), 50 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mailbox/ti,secure-proxy.txt
>  create mode 100644 Documentation/devicetree/bindings/mailbox/ti,secure-proxy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/ti,secure-proxy.txt b/Documentation/devicetree/bindings/mailbox/ti,secure-proxy.txt
> deleted file mode 100644
> index 6c9c7daf0f5c..000000000000
> --- a/Documentation/devicetree/bindings/mailbox/ti,secure-proxy.txt
> +++ /dev/null
> @@ -1,50 +0,0 @@
> -Texas Instruments' Secure Proxy
> -========================================
> -
> -The Texas Instruments' secure proxy is a mailbox controller that has
> -configurable queues selectable at SoC(System on Chip) integration. The
> -Message manager is broken up into different address regions that are
> -called "threads" or "proxies" - each instance is unidirectional and is
> -instantiated at SoC integration level by system controller to indicate
> -receive or transmit path.
> -
> -Message Manager Device Node:
> -===========================
> -Required properties:
> ---------------------
> -- compatible:		Shall be "ti,am654-secure-proxy"
> -- reg-names 		target_data - Map the proxy data region
> -			rt - Map the realtime status region
> -			scfg - Map the configuration region
> -- reg:			Contains the register map per reg-names.
> -- #mbox-cells		Shall be 1 and shall refer to the transfer path
> -			called thread.
> -- interrupt-names:	Contains interrupt names matching the rx transfer path
> -			for a given SoC. Receive interrupts shall be of the
> -			format: "rx_<PID>".
> -- interrupts:		Contains the interrupt information corresponding to
> -			interrupt-names property.
> -
> -Example(AM654):
> -------------
> -
> -	secure_proxy: mailbox@32c00000 {
> -		compatible = "ti,am654-secure-proxy";
> -		#mbox-cells = <1>;
> -		reg-names = "target_data", "rt", "scfg";
> -		reg = <0x0 0x32c00000 0x0 0x100000>,
> -		      <0x0 0x32400000 0x0 0x100000>,
> -		      <0x0 0x32800000 0x0 0x100000>;
> -		interrupt-names = "rx_011";
> -		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
> -	};
> -
> -	dmsc: dmsc {
> -		[...]
> -		mbox-names = "rx", "tx";
> -		# RX Thread ID is 11
> -		# TX Thread ID is 13
> -		mboxes= <&secure_proxy 11>,
> -			<&secure_proxy 13>;
> -		[...]
> -	};
> diff --git a/Documentation/devicetree/bindings/mailbox/ti,secure-proxy.yaml b/Documentation/devicetree/bindings/mailbox/ti,secure-proxy.yaml
> new file mode 100644
> index 000000000000..08a4837fdfcc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/ti,secure-proxy.yaml
> @@ -0,0 +1,79 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mailbox/ti,secure-proxy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments' Secure Proxy
> +
> +maintainers:
> +  - Nishanth Menon <nm@ti.com>
> +
> +description: |
> +  The Texas Instruments' secure proxy is a mailbox controller that has
> +  configurable queues selectable at SoC(System on Chip) integration. The
> +  Message manager is broken up into different address regions that are
> +  called "threads" or "proxies" - each instance is unidirectional and is
> +  instantiated at SoC integration level by system controller to indicate
> +  receive or transmit path.
> +
> +properties:
> +  $nodename:
> +    pattern: "^mailbox@[0-9a-f]+$"
> +
> +  compatible:
> +    const: ti,am654-secure-proxy
> +
> +  "#mbox-cells":
> +    const: 1
> +    description:
> +      Contains the secure proxy thread ID used for the specific transfer path.
> +
> +  reg-names:
> +    items:
> +      - const: target_data
> +      - const: rt
> +      - const: scfg
> +
> +  reg:
> +    minItems: 3
> +
> +  interrupt-names:
> +    minItems: 1
> +    maxItems: 100
> +    items:
> +      - pattern: "^rx_[0-9]{3}$"

Need to drop the '-' to make this apply to all entries. Otherwise, it's 
just the first one.

> +    description:
> +      Contains the interrupt name information for the Rx interrupt path for
> +      secure proxy thread in the form 'rx_<PID>'.
> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 100
> +    description:
> +      Contains the interrupt information for the Rx interrupt path for secure
> +      proxy.
> +
> +required:
> +  - compatible
> +  - reg-names
> +  - reg
> +  - interrupt-names
> +  - interrupts
> +  - "#mbox-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    secure_proxy: mailbox@32c00000 {
> +          compatible = "ti,am654-secure-proxy";
> +          #mbox-cells = <1>;
> +          reg-names = "target_data", "rt", "scfg";
> +          reg = <0x32c00000 0x100000>,
> +                <0x32400000 0x100000>,
> +                <0x32800000 0x100000>;
> +          interrupt-names = "rx_011";
> +          interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
> +    };
> -- 
> 2.31.0
> 
