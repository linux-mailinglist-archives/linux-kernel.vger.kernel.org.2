Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC003627BF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 20:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244888AbhDPSac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 14:30:32 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:40710 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238226AbhDPSaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 14:30:30 -0400
Received: by mail-ot1-f53.google.com with SMTP id w31-20020a9d36220000b02901f2cbfc9743so26571871otb.7;
        Fri, 16 Apr 2021 11:30:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=+4y5xD6FsO3vC5Ys9vRm1ilGC7bEb0/EsoeiI7VBKsE=;
        b=XfUbKvRMDbvb3webEk1n8tuMAf9lk5KNU8EGuvD15sjwox0jdfKROyZBmORK9WBwwz
         wsfcR0ij6Qte770W3fIfDB0TPoDPEkH6wt/mtKD6NvRjaoWKTgrlrQYdi1Lku3o6VrgG
         dph1B6KuvJeXoVms/uc5KGRRkvEgV+IcZUhyyI9AGfm1s+LfUoJ0n6QU1inNllzu/q0K
         C3mJ4Y5eTFdFFK4vkY7HWbiufNz5JA100x1n1Ff4AxjDpLU8Dwrrt4Pw021guAOQuG+2
         rJOxFNqNXQX9lQuUCJq2pTbgEyQ6f9jXX/OEKzGciCGQweNVIUF503s+409bOK+qWT2q
         3uYw==
X-Gm-Message-State: AOAM533Fyb6jS54vg0OKlW1qU1UXMpGi2x5asULdGp2C3fZu/aTHUQ0y
        FjXGridz8/WCXW6Sb04dTw==
X-Google-Smtp-Source: ABdhPJyn22RcL82sR7wG7S9QbI0HIP2dmwFaaZSa4uAL4UTjFklWGoLWwWVk1Ie+5Q84cXwJAx5pQg==
X-Received: by 2002:a9d:2de8:: with SMTP id g95mr4699080otb.162.1618597804995;
        Fri, 16 Apr 2021 11:30:04 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n104sm1544410ota.27.2021.04.16.11.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 11:30:04 -0700 (PDT)
Received: (nullmailer pid 3708342 invoked by uid 1000);
        Fri, 16 Apr 2021 18:30:01 -0000
From:   Rob Herring <robh@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     devicetree@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20210416114928.27758-5-michael@walle.cc>
References: <20210416114928.27758-1-michael@walle.cc> <20210416114928.27758-5-michael@walle.cc>
Subject: Re: [PATCH 4/5] dt-bindings: mtd: spi-nor: add otp property
Date:   Fri, 16 Apr 2021 13:30:01 -0500
Message-Id: <1618597801.613342.3708340.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Apr 2021 13:49:27 +0200, Michael Walle wrote:
> SPI-NOR flashes may have OTP regions and have a nvmem binding. This
> binding is described in mtd.yaml.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
> Changes since RFC:
>  - new patch
> 
>  Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Unknown file referenced: [Errno 2] No such file or directory: '/usr/local/lib/python3.8/dist-packages/dtschema/schemas/mtd/mtd.yaml'
xargs: dt-doc-validate: exited with status 255; aborting
make[1]: *** Deleting file 'Documentation/devicetree/bindings/spi/st,stm32-qspi.example.dt.yaml'
Unknown file referenced: [Errno 2] No such file or directory: '/usr/local/lib/python3.8/dist-packages/dtschema/schemas/mtd/mtd.yaml'
make[1]: *** [scripts/Makefile.lib:377: Documentation/devicetree/bindings/spi/st,stm32-qspi.example.dt.yaml] Error 255
make[1]: *** Waiting for unfinished jobs....
make[1]: *** Deleting file 'Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.example.dt.yaml'
Unknown file referenced: [Errno 2] No such file or directory: '/usr/local/lib/python3.8/dist-packages/dtschema/schemas/mtd/mtd.yaml'
make[1]: *** [scripts/Makefile.lib:377: Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.example.dt.yaml] Error 255
make: *** [Makefile:1414: dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1467025

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

