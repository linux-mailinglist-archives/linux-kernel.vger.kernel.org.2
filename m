Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9AE32F512
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 22:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbhCEVDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 16:03:36 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:37688 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbhCEVDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 16:03:03 -0500
Received: by mail-ot1-f45.google.com with SMTP id g8so3141389otk.4;
        Fri, 05 Mar 2021 13:03:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q4Vo/k2UOYrk5i6EEEpAeutaTULw+6QseZp2vB7Fqss=;
        b=T+ZZ4Mr8H8n7fKSASPKl0ssHUTFTMQgEAxzNYV74QUW2C5eNHLrZfkk2ZR+CS172ky
         3FJKP5H49uoXcGpcSmUYqzzjy2kHKNmKXrxQWWV5wKlVR/po06zIjHGehr4Zii4O+drI
         VpkH8J2zgQ0qzIGIARQT6VAnBrJ4LkQLQ2+CoePI7lzVRKpB1lFMDsypl4sfDlMk66As
         Efy4ZL4KnLPlvlguL8UxeQq4Uxr1AjUkz2pWFgpeUxrEfxHk41JBuuMni5ii4C8BTfiD
         6qAHrlPigHO+N3tkCnR1oiTktP15SmfWHCYWLjCYIMliowiy4F5jvetO+Ni3hxjRQX0k
         cbwg==
X-Gm-Message-State: AOAM533KctFy4lPktUM272DBj+dmjvsJkdVlJrYGXy1pmKy3+5HaH44G
        jXC0HTuq53d5KrwmDiV0ZA==
X-Google-Smtp-Source: ABdhPJz7GeCc2JU/MJcqc2xMSng+GSVsVQvkRth8p0S8NjafOivJ57+2O5zRkaktno2IC+LUSq7rqA==
X-Received: by 2002:a05:6830:1c6e:: with SMTP id s14mr9200779otg.265.1614978182979;
        Fri, 05 Mar 2021 13:03:02 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v2sm296098ota.59.2021.03.05.13.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 13:03:02 -0800 (PST)
Received: (nullmailer pid 638441 invoked by uid 1000);
        Fri, 05 Mar 2021 21:03:00 -0000
Date:   Fri, 5 Mar 2021 15:03:00 -0600
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
Subject: Re: [PATCH v6 19/34] xlink-core: Add xlink core device tree bindings
Message-ID: <20210305210300.GB622142@robh.at.kernel.org>
References: <20210212222304.110194-1-mgross@linux.intel.com>
 <20210212222304.110194-20-mgross@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210212222304.110194-20-mgross@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021 at 02:22:49PM -0800, mgross@linux.intel.com wrote:
> From: Seamus Kelly <seamus.kelly@intel.com>
> 
> Add device tree bindings for keembay-xlink.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Reviewed-by: Mark Gross <mgross@linux.intel.com>
> Signed-off-by: Mark Gross <mgross@linux.intel.com>
> Signed-off-by: Seamus Kelly <seamus.kelly@intel.com>
> ---
>  .../bindings/misc/intel,keembay-xlink.yaml    | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/intel,keembay-xlink.yaml
> 
> diff --git a/Documentation/devicetree/bindings/misc/intel,keembay-xlink.yaml b/Documentation/devicetree/bindings/misc/intel,keembay-xlink.yaml
> new file mode 100644
> index 000000000000..5ac2e7fa5b5e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/intel,keembay-xlink.yaml
> @@ -0,0 +1,29 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright (c) Intel Corporation. All rights reserved.
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/misc/intel,keembay-xlink.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Intel Keem Bay xlink
> +
> +maintainers:
> +  - Seamus Kelly <seamus.kelly@intel.com>
> +
> +description: |
> +  The Keem Bay xlink driver enables the communication/control sub-system
> +  for internal and external communications to the Intel Keem Bay SoC.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - const: intel,keembay-xlink
> +
> +additionalProperties: False
> +
> +examples:
> +  - |
> +    xlink {
> +        compatible = "intel,keembay-xlink";

A node with only a compatible is almost always abusing DT just to 
instantiate your driver.

Rob
