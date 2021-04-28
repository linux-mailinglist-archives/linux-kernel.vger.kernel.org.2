Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA63936E16A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 00:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbhD1WQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 18:16:03 -0400
Received: from mail-oi1-f180.google.com ([209.85.167.180]:46905 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbhD1WP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 18:15:59 -0400
Received: by mail-oi1-f180.google.com with SMTP id m13so64554175oiw.13;
        Wed, 28 Apr 2021 15:15:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=micmvqPn+SqpgZHoJgEbTJSJFTTg/j0ycPZ2KGmnhZo=;
        b=EFz7nibvwxnjeFEUogF1M9JuxYM9LABcqyGNfuevx6MRh8uMQDok/b09fTdjpRVECj
         thnNailLtQfvrVKmS/EaJlyWNfJT6MB6N4rJ7il4wxyhGTDVd83iWT3YPiG7WB2c1aHM
         j30cDfnwNMruVxtsnTxyW/hLhhPyTQ5fvqVln3du1XhHHloDEw2c8kNbuvFVchNN2F9n
         1u2hwLcgqh/zkOXJ/E7M+HxaB46V5q6wKmp6RPMY61HsnkyUDdz56N0Q4zykeAzDXSUs
         y6PBvsOb4PaAP1+j7NvSwNmnlnqwqiAmMwErTLKjh/Qy90hcj0aRTkjYewp7UpG6DVbj
         wZww==
X-Gm-Message-State: AOAM532OGPMEBLngjvluIkdYUVKombPFW4hg2VdI82PN7Zewj17tHPaA
        jyDI6t3HgERRF43b2BOjXA==
X-Google-Smtp-Source: ABdhPJwIlW9bNjDL0v8E0I76y8ds2OAB7nSc30Z18LYc5RHBlcUHd9Rnwiq/QwFlR7dvvyc6EARckw==
X-Received: by 2002:aca:3c55:: with SMTP id j82mr4464517oia.76.1619648113797;
        Wed, 28 Apr 2021 15:15:13 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n37sm281733otn.9.2021.04.28.15.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 15:15:13 -0700 (PDT)
Received: (nullmailer pid 4061035 invoked by uid 1000);
        Wed, 28 Apr 2021 22:15:09 -0000
From:   Rob Herring <robh@kernel.org>
To:     Nandor Han <nandor.han@vaisala.com>
Cc:     robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        srinivas.kandagatla@linaro.org, devicetree@vger.kernel.org
In-Reply-To: <e0f9c2629ad651817a4726cd4f2d8e1775201595.1619617498.git.nandor.han@vaisala.com>
References: <cover.1619617498.git.nandor.han@vaisala.com> <e0f9c2629ad651817a4726cd4f2d8e1775201595.1619617498.git.nandor.han@vaisala.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: nvmem: Add bootcount-nvmem
Date:   Wed, 28 Apr 2021 17:15:09 -0500
Message-Id: <1619648109.794134.4061034.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Apr 2021 16:50:38 +0300, Nandor Han wrote:
> Documents the device tree bindings for `bootcount-nvmem` driver.
> 
> Signed-off-by: Nandor Han <nandor.han@vaisala.com>
> ---
>  .../bindings/nvmem/bootcount-nvmem.yaml       | 66 +++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/bootcount-nvmem.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/nvmem/bootcount-nvmem.example.dts:27.17-34: Warning (reg_format): /example-0/rtc@68/bootcount_nvmem_regs@e:reg: property has invalid length (8 bytes) (#address-cells == 2, #size-cells == 1)
Documentation/devicetree/bindings/nvmem/bootcount-nvmem.example.dts:25.21-29.11: Warning (unit_address_vs_reg): /example-0/rtc@68: node has a unit name, but no reg or ranges property
Documentation/devicetree/bindings/nvmem/bootcount-nvmem.example.dt.yaml: Warning (pci_device_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/nvmem/bootcount-nvmem.example.dt.yaml: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/nvmem/bootcount-nvmem.example.dt.yaml: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/nvmem/bootcount-nvmem.example.dt.yaml: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/nvmem/bootcount-nvmem.example.dt.yaml: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/nvmem/bootcount-nvmem.example.dts:26.52-28.15: Warning (avoid_default_addr_size): /example-0/rtc@68/bootcount_nvmem_regs@e: Relying on default #address-cells value
Documentation/devicetree/bindings/nvmem/bootcount-nvmem.example.dts:26.52-28.15: Warning (avoid_default_addr_size): /example-0/rtc@68/bootcount_nvmem_regs@e: Relying on default #size-cells value
Documentation/devicetree/bindings/nvmem/bootcount-nvmem.example.dt.yaml: Warning (unique_unit_address): Failed prerequisite 'avoid_default_addr_size'

See https://patchwork.ozlabs.org/patch/1471179

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

