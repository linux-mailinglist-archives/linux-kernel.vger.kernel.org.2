Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC52F311B38
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 05:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhBFE7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 23:59:13 -0500
Received: from mail-yb1-f180.google.com ([209.85.219.180]:40006 "EHLO
        mail-yb1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbhBFDfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 22:35:38 -0500
Received: by mail-yb1-f180.google.com with SMTP id i71so8773580ybg.7;
        Fri, 05 Feb 2021 19:35:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bWD0Xd1LugmrPim9uT1TIxiY19YbyAjLXKLTF24G3cs=;
        b=aEFQvXg8Do6lrwB9raiRz8itDaZTBRwuDhWL1S/6aDcoFwtXDOb7LbTflYn3G2XCAt
         5dKu2+VDYIL6/SepMFoASr/NsxFMeFWD3IGIFer80aXKgeMXQZEEziDAIJc28X9EcgRX
         TWy7/IpTo/ifQ1KHl7KhFCFA7A+l7VLpbSLZsw4OIkS1DN2MRODrxf8smuXRw1cd3Ba5
         OyEVMGKKnMhQNLw6A8LiLIAVEuyhxAycD7KlQqMw8+XR6cuE9KmSc/3Hyz9Qk8CihRGr
         W47Qp+vNt4wg3djXcdDBNyqY84Uf3sb8o1OgUfU1eDUD5yYvZpLDIKvF/b2MexNQZl6b
         GGiw==
X-Gm-Message-State: AOAM5304zjZ+BI8oxKXrOFCwl8WXZdgX2q0hJQjZmK8LEdRbcirDrr8X
        jveO7nT5z3GFUY0DVp7WfLpX3rQ2Yg==
X-Google-Smtp-Source: ABdhPJx4H3231S2pjcifJwGi+k2xYKRAeq+BOInc+gwPHSJdr5kMBWGsfC5hidReoeOqkxqNElMVZQ==
X-Received: by 2002:a9d:7514:: with SMTP id r20mr4899658otk.318.1612564007144;
        Fri, 05 Feb 2021 14:26:47 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u7sm2067882oib.22.2021.02.05.14.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 14:26:46 -0800 (PST)
Received: (nullmailer pid 3867655 invoked by uid 1000);
        Fri, 05 Feb 2021 22:26:45 -0000
Date:   Fri, 5 Feb 2021 16:26:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mayulong <mayulong1@huawei.com>, devel@driverdev.osuosl.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 18/21] mfd: hi6421-spmi-pmic: move driver from staging
Message-ID: <20210205222645.GB3857395@robh.at.kernel.org>
References: <cover.1611072387.git.mchehab+huawei@kernel.org>
 <e79ffb200c52fc8c8926492cc82ac5dbcda3e3fb.1611072387.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e79ffb200c52fc8c8926492cc82ac5dbcda3e3fb.1611072387.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 05:10:44PM +0100, Mauro Carvalho Chehab wrote:
> This driver is ready for mainstream. So, move it out of staging.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  .../mfd/hisilicon,hi6421-spmi-pmic.yaml       | 135 +++++++++
>  MAINTAINERS                                   |   7 +
>  drivers/mfd/Kconfig                           |  15 +
>  drivers/mfd/Makefile                          |   1 +
>  drivers/mfd/hi6421-spmi-pmic.c                | 281 ++++++++++++++++++
>  drivers/staging/hikey9xx/Kconfig              |  16 -
>  drivers/staging/hikey9xx/Makefile             |   1 -
>  drivers/staging/hikey9xx/hi6421-spmi-pmic.c   | 281 ------------------
>  .../hikey9xx/hisilicon,hi6421-spmi-pmic.yaml  | 135 ---------
>  9 files changed, 439 insertions(+), 433 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml
>  create mode 100644 drivers/mfd/hi6421-spmi-pmic.c
>  delete mode 100644 drivers/staging/hikey9xx/hi6421-spmi-pmic.c
>  delete mode 100644 drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml
> new file mode 100644
> index 000000000000..3b23ad56b31a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml
> @@ -0,0 +1,135 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/hisilicon,hi6421-spmi-pmic.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: HiSilicon 6421v600 SPMI PMIC
> +
> +maintainers:
> +  - Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> +
> +description: |
> +  HiSilicon 6421v600 should be connected inside a MIPI System Power Management
> +  (SPMI) bus. It provides interrupts and power supply.
> +
> +  The GPIO and interrupt settings are represented as part of the top-level PMIC
> +  node.
> +
> +  The SPMI controller part is provided by
> +  drivers/staging/hikey9xx/hisilicon,hisi-spmi-controller.yaml.
> +
> +properties:
> +  $nodename:
> +    pattern: "pmic@[0-9a-f]"
> +
> +  compatible:
> +    const: hisilicon,hi6421v600-spmi

Also, use the compatible string as the filename.
