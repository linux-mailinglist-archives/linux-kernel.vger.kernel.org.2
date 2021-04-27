Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67DA636C688
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 14:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236244AbhD0M5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 08:57:53 -0400
Received: from mail-oo1-f54.google.com ([209.85.161.54]:39665 "EHLO
        mail-oo1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235426AbhD0M5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 08:57:47 -0400
Received: by mail-oo1-f54.google.com with SMTP id g9-20020a4ad3090000b02901ec6daba49aso6221379oos.6;
        Tue, 27 Apr 2021 05:57:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=IwnIBjLdvQmLQ0XqV1p9WKPPT/x2JWfWX4PnoAgtDII=;
        b=E7KIkj+Vke7y67rKLSGizli6IzrGPkM8pOS5XS2hKMusuwIOSh8BY2w+nmGNn5CaHJ
         DIwAxecQZUPOF/Lqbq7XPXf7Ax7HwiM2eBf/Tz188cXtSRvr/8had3iJJbXFdSJUNkM/
         Prdn1zZJ5r1Iiv0cQNRtORLBaxT70RLcPovuCxxGsk0G65I44SzA90kaaShUv9z6PS6Q
         u3scB6eYRDqm8VxgL+ShrEpHsEFKkt6Ci1Gp/HD/kySdZHpkL4seYBJD1YYqLvrU9JDn
         C7bHGrLrGOD7eLs4oBbnnnrQyQZuHZFEZyyTWkCE2D+g/W/Vqun+lh4TNXiZXO8IdhZB
         7DKg==
X-Gm-Message-State: AOAM533HtNtgbod3CKId5Few2xdD9m/9zgfhzzl0QNSkCVhANwcV3JSe
        BDE90jiUBwYoB+KCL9tGNfFyzoAJLg==
X-Google-Smtp-Source: ABdhPJxhZcKv8RAuk4y95GPOowmjvGK1lNeyXZ7wllksdOUf1Kza3OfMNNbRMLkG1Hxzef46g9vRxg==
X-Received: by 2002:a4a:ae01:: with SMTP id z1mr18029118oom.87.1619528224137;
        Tue, 27 Apr 2021 05:57:04 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c26sm1286316otl.61.2021.04.27.05.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 05:57:03 -0700 (PDT)
Received: (nullmailer pid 1346445 invoked by uid 1000);
        Tue, 27 Apr 2021 12:57:01 -0000
From:   Rob Herring <robh@kernel.org>
To:     Nandor Han <nandor.han@vaisala.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, srinivas.kandagatla@linaro.org
In-Reply-To: <942aacf1c51861e5a09db6a6d322666709695df2.1619511801.git.nandor.han@vaisala.com>
References: <cover.1619511801.git.nandor.han@vaisala.com> <942aacf1c51861e5a09db6a6d322666709695df2.1619511801.git.nandor.han@vaisala.com>
Subject: Re: [PATCH 1/4] dt-bindings: nvmem: Add bootcount-nvmem
Date:   Tue, 27 Apr 2021 07:57:01 -0500
Message-Id: <1619528221.583004.1346444.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Apr 2021 11:26:31 +0300, Nandor Han wrote:
> Documents the device tree bindings for `bootcount-nvmem` driver.
> 
> Signed-off-by: Nandor Han <nandor.han@vaisala.com>
> ---
>  .../bindings/nvmem/bootcount-nvmem.yaml       | 72 +++++++++++++++++++
>  1 file changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/bootcount-nvmem.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/nvmem/bootcount-nvmem.example.dts:34.1-2 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:377: Documentation/devicetree/bindings/nvmem/bootcount-nvmem.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1414: dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1470591

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

