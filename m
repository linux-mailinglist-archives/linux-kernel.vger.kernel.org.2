Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1155D3B92AB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 16:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbhGAOFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 10:05:43 -0400
Received: from mail-il1-f177.google.com ([209.85.166.177]:46900 "EHLO
        mail-il1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbhGAOFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 10:05:42 -0400
Received: by mail-il1-f177.google.com with SMTP id t12so6422884ile.13;
        Thu, 01 Jul 2021 07:03:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=VRXNiq96Mf6FxPX7Y/PomxvV3ZtFTsWrlFbJZRhnpHI=;
        b=FXF7Dk1uZwRz0FTtc6vvFqh5E75VR43dOAlQbBUOdpl7z3UvqhHwyBWp5GCXTS7Fov
         iQ1RI3I8ENOxXE60XxSnTCdKXFOT1IlbBD/9XNwOMimAslt6ZoU4sPb557NnksTdxsht
         e3ibtFiT2NC5dFLkSF8I3AqiPCeqv1hD9Sm3QIdwbn0A5jTFo0X3AUPqD4By19kJULTE
         NXDubyHJVgurLEvojraVgfatClABi3HyMAIwVIHMDqcS1PAM2XwR3zqEdUSgCzOmzYz2
         +vx7uORLTZCZPHZLrWbt7L67SIFGrCk8cx8IGbe+nonrCtQN+B/u/2fN+7NWzGumRFse
         cWdg==
X-Gm-Message-State: AOAM533pFtPqWjcuNrJdtLa1A3+tCIe4TSX0ERH/ohxAVRHbVLV/8ASG
        DvRbRHOeLCZxwGKKf0wcUw==
X-Google-Smtp-Source: ABdhPJz11CrcTuArbwbsEd4i11UQNsajjU7M6YpaEEnrcFZED9/0iLNTEA/vVLbN74nS/cq2HnUyOA==
X-Received: by 2002:a92:6705:: with SMTP id b5mr29248288ilc.55.1625148190925;
        Thu, 01 Jul 2021 07:03:10 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id a10sm10052933ioo.9.2021.07.01.07.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 07:03:10 -0700 (PDT)
Received: (nullmailer pid 2278692 invoked by uid 1000);
        Thu, 01 Jul 2021 14:02:43 -0000
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-staging@lists.linux.dev, devicetree@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>, linuxarm@huawei.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        mauro.chehab@huawei.com
In-Reply-To: <35b9f9169889c1f4d51eff8bf2035450c9e02576.1624606660.git.mchehab+huawei@kernel.org>
References: <cover.1624606660.git.mchehab+huawei@kernel.org> <35b9f9169889c1f4d51eff8bf2035450c9e02576.1624606660.git.mchehab+huawei@kernel.org>
Subject: Re: [PATCH v8 02/12] spmi: hisi-spmi-controller: move driver from staging
Date:   Thu, 01 Jul 2021 08:02:43 -0600
Message-Id: <1625148163.497219.2278691.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jun 2021 09:45:54 +0200, Mauro Carvalho Chehab wrote:
> The Hisilicon 6421v600 SPMI driver is ready for mainstream.
> 
> So, move it from staging.
> 
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  .../spmi/hisilicon,hisi-spmi-controller.yaml  |  73 ++++
>  MAINTAINERS                                   |   7 +
>  drivers/spmi/Kconfig                          |   9 +
>  drivers/spmi/Makefile                         |   1 +
>  drivers/spmi/hisi-spmi-controller.c           | 367 ++++++++++++++++++
>  drivers/staging/hikey9xx/Kconfig              |  11 -
>  drivers/staging/hikey9xx/Makefile             |   1 -
>  .../staging/hikey9xx/hisi-spmi-controller.c   | 367 ------------------
>  .../hikey9xx/hisilicon,hi6421-spmi-pmic.yaml  |   2 +-
>  .../hisilicon,hisi-spmi-controller.yaml       |  73 ----
>  10 files changed, 458 insertions(+), 453 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spmi/hisilicon,hisi-spmi-controller.yaml
>  create mode 100644 drivers/spmi/hisi-spmi-controller.c
>  delete mode 100644 drivers/staging/hikey9xx/hisi-spmi-controller.c
>  delete mode 100644 drivers/staging/hikey9xx/hisilicon,hisi-spmi-controller.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:

\ndoc reference errors (make refcheckdocs):
Warning: Documentation/devicetree/bindings/spmi/hisilicon,hisi-spmi-controller.yaml references a file that doesn't exist: Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml
Documentation/devicetree/bindings/spmi/hisilicon,hisi-spmi-controller.yaml: Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml

See https://patchwork.ozlabs.org/patch/1496992

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

