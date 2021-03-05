Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6FB32F534
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 22:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbhCEVMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 16:12:12 -0500
Received: from mail-ot1-f50.google.com ([209.85.210.50]:38437 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbhCEVLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 16:11:48 -0500
Received: by mail-ot1-f50.google.com with SMTP id a17so3170155oto.5;
        Fri, 05 Mar 2021 13:11:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uKjq62oG1M+UJlNb/42Jphmibl02E1oJqMtrd1v/u3w=;
        b=GJnKo210zk4FqCLsjeThdGl8lzOTRD9COaczddImJV9xMZlL4PlPaWOibb2QH3k0YZ
         n2SE0Zh7AhMbMSZNPOApLtmwMEqmFIMCVecsE7/2QlUXnz7P80OiZHpJBxcVodTrHPE+
         XgfV4kPa5N7qhvlahVwi9G6IFpGL/QabJ5EeLzt0xMh1etQSYNRohwVybd7GaiBqfxhg
         0pB1LsYVxn7SydpIzPKViHckPD9blybWJPJthWsCaD2w3YLJma1Wd33gAICqPDPn+OF7
         3t2z+WVd5CEMCHaSQ3T6h5op5dptp5vVXEsIwOpvnA4XE5YcvD1X5d7U8MieL7QNiHrz
         8vKw==
X-Gm-Message-State: AOAM531uaW+8Ix16y7a1xbvUXPT1YORl8iMF9KAPXJuY3JlKUDZxYi+7
        2fqUo++MeVH8wtUFuLkWMg==
X-Google-Smtp-Source: ABdhPJymfTGlaTKStCYTTPEvB0kmVfiZiofdZtu33DKklWoBVzTryzlQTlge+HaRSguivy9uI3pd5w==
X-Received: by 2002:a9d:7512:: with SMTP id r18mr9752602otk.90.1614978708188;
        Fri, 05 Mar 2021 13:11:48 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l69sm859482otc.23.2021.03.05.13.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 13:11:46 -0800 (PST)
Received: (nullmailer pid 654717 invoked by uid 1000);
        Fri, 05 Mar 2021 21:11:45 -0000
Date:   Fri, 5 Mar 2021 15:11:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     mgross@linux.intel.com
Cc:     markgross@kernel.org, arnd@arndb.de, bp@suse.de,
        damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        palmerdabbelt@google.com, paul.walmsley@sifive.com,
        peng.fan@nxp.com, shawnguo@kernel.org, jassisinghbrar@gmail.com,
        linux-kernel@vger.kernel.org,
        Seamus Kelly <seamus.kelly@intel.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 17/34] xlink-ipc: Add xlink ipc device tree bindings
Message-ID: <20210305211145.GA649830@robh.at.kernel.org>
References: <20210212222304.110194-1-mgross@linux.intel.com>
 <20210212222304.110194-18-mgross@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210212222304.110194-18-mgross@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021 at 02:22:47PM -0800, mgross@linux.intel.com wrote:
> From: Seamus Kelly <seamus.kelly@intel.com>

Please make the subjects consistent.

> 
> Add device tree bindings for the xLink IPC driver which enables xLink to
> control and communicate with the VPU IP present on the Intel Keem Bay
> SoC.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Reviewed-by: Mark Gross <mgross@linux.intel.com>
> Signed-off-by: Mark Gross <mgross@linux.intel.com>
> Signed-off-by: Seamus Kelly <seamus.kelly@intel.com>
> ---
>  .../misc/intel,keembay-xlink-ipc.yaml         | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/intel,keembay-xlink-ipc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/misc/intel,keembay-xlink-ipc.yaml b/Documentation/devicetree/bindings/misc/intel,keembay-xlink-ipc.yaml
> new file mode 100644
> index 000000000000..70a3061d024d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/intel,keembay-xlink-ipc.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright (c) Intel Corporation. All rights reserved.
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/misc/intel,keembay-xlink-ipc.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Intel Keem Bay xlink IPC
> +
> +maintainers:
> +  - Kelly Seamus <seamus.kelly@intel.com>

Name doesn't match the author.

> +
> +description: |
> +  The Keem Bay xlink IPC driver enables the communication/control sub-system
> +  for internal IPC communications within the Intel Keem Bay SoC.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - const: intel,keembay-xlink-ipc

Don't need oneOf nor items, just const.

> +
> +  memory-region:
> +    items:
> +      - description: reference to the CSS xlink IPC reserved memory region.
> +      - description: reference to the MSS xlink IPC reserved memory region.
> +
> +  intel,keembay-vpu-ipc-id:
> +    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    description: The numeric ID identifying the VPU within the xLink stack.
> +
> +  intel,keembay-vpu-ipc-name:
> +    $ref: "/schemas/types.yaml#/definitions/string"
> +    description: User-friendly name for the VPU within the xLink stack.
> +
> +  intel,keembay-vpu-ipc:
> +    $ref: "/schemas/types.yaml#/definitions/phandle"
> +    description: reference to the corresponding intel,keembay-vpu-ipc node.

Is there more than one?

> +
> +additionalProperties: False
> +
> +examples:
> +  - |
> +    xlink-ipc {
> +        compatible = "intel,keembay-xlink-ipc";
> +        memory-region = <&css_xlink_reserved>,
> +                        <&mss_xlink_reserved>;
> +        intel,keembay-vpu-ipc-id = <0x0>;
> +        intel,keembay-vpu-ipc-name = "vpu-slice-0";

I assume the 0 id is the same as the 0 here? If so, there's not really 
any reason to put this into DT. You can generate the string if needed in 
the driver.

> +        intel,keembay-vpu-ipc = <&vpuipc>;
> +    };
> -- 
> 2.17.1
> 
