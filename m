Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4098336E164
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 00:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbhD1WQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 18:16:00 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:36811 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbhD1WP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 18:15:59 -0400
Received: by mail-ot1-f44.google.com with SMTP id n32-20020a9d1ea30000b02902a53d6ad4bdso4760907otn.3;
        Wed, 28 Apr 2021 15:15:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=zAF2toXP87sFaO/+ZlCZr0PxBU8uD3XenCS7obOMCiU=;
        b=D1xsbvMX197MMIu3n89ynUm9ryufvnZ136iMSuf/2ByUY6TfGFm659oOfalnZMYXkk
         p2Gimu4M37dFp1xHdt5flgQr8rM/0Y7o6Glb5vvxc0Z4WvpicSClYtrLU29MeM0/tLB2
         vYjFvm93J0+V5GALV224irBJ/OCTF9ndpVmOIgbMeEyvhZZlvl42+l2ZW3CYvUNLwJe3
         NP7kPx9T+B2/5vknrm/WPaHmhrOI18sBK8C/a7OHS/moPn44Wyu4v37fWzc4fuo9qznd
         10KRELSOO81mC+T4XqqkhmxIP7dsB/eW2q1bzoIP8X7YYVm0o152fGbW79i00KEes9P6
         IxwQ==
X-Gm-Message-State: AOAM5308CU/WjFg/dPzEvXOSPXH/Bn1120MXuc+R+fr4qzLYdOECeYXQ
        zCFAx1MCmF9yXaz3+uk+FFQHoPWmuQ==
X-Google-Smtp-Source: ABdhPJwdPNXNSpudUFX5xImDtn8XEwOZU/5rOoBkiWPuMoZQH9BChGgxsWK8gHDGHj/eAt4JRncnWw==
X-Received: by 2002:a05:6830:149a:: with SMTP id s26mr26474841otq.349.1619648112129;
        Wed, 28 Apr 2021 15:15:12 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j8sm268455otj.49.2021.04.28.15.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 15:15:11 -0700 (PDT)
Received: (nullmailer pid 4061026 invoked by uid 1000);
        Wed, 28 Apr 2021 22:15:09 -0000
From:   Rob Herring <robh@kernel.org>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20210427224201.32285-1-tsbogend@alpha.franken.de>
References: <20210427224201.32285-1-tsbogend@alpha.franken.de>
Subject: Re: [PATCH] dt-binding: interrupt-controller: Add missing interrupts property
Date:   Wed, 28 Apr 2021 17:15:09 -0500
Message-Id: <1619648109.762240.4061025.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Apr 2021 00:42:00 +0200, Thomas Bogendoerfer wrote:
> Interrupts property is required, so add it.
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> ---
>  .../bindings/interrupt-controller/idt,32434-pic.yaml          | 4 ++++
>  1 file changed, 4 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun4i-a10-ic.example.dt.yaml: interrupt-controller@1c20400: 'oneOf' conditional failed, one must be fixed:
	'interrupts' is a required property
	'interrupts-extended' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun4i-a10-ic.yaml

See https://patchwork.ozlabs.org/patch/1470883

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

