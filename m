Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2301D35A66B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 20:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234819AbhDIS6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 14:58:14 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:43964 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234705AbhDIS6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 14:58:08 -0400
Received: by mail-ot1-f44.google.com with SMTP id s16-20020a0568301490b02901b83efc84a0so6618859otq.10;
        Fri, 09 Apr 2021 11:57:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=LG+U1xS2DK6TLT5pHY8ouyd0GBNLDbIxMC+TQlO4DLE=;
        b=V/yUE4p5zFeyaN6q+eHISnrCD3iuqL8JK6fDUwJ4qpagiM2u2hjroHhBv3G48AOrF5
         j4vfZUoKXYt+1yyH+lmP413kXIFyvJsrtBpp3YESWCzntK7c4UaboZFCLA3TuPa2oWFe
         +5km9fjIXgUNXuHchHQPVxebifxfTcXvMptnTvRsdlkMnS0BePr/GQpXvv4L4QigWabd
         WurZj60eHyyfWVUqxVhX5Cl4lGFGLVqhAUhCFWH3D+6qmGHsO62cIBcN1nhyBwTb+k8z
         4YUDImgBlUJPuJIN0uscAwxDDZLzRizrPuipKiRXVCKydqIU8Rfg+rKNDfklG242wCtM
         aGLw==
X-Gm-Message-State: AOAM532bZbvnxvK77tweJVMZR4iCzJXV1R4E9dzHpXgooMi2glfs1iib
        SNDX59JnQ/Q5AfqU0pfUxSVpP2/g+g==
X-Google-Smtp-Source: ABdhPJwswKFCjImvzKBtfsPVs7k59+eVKtB46FhXaglSRAoS5pX1ifMFoq4LfXdYkMaRUNkNfrjICw==
X-Received: by 2002:a9d:2ae1:: with SMTP id e88mr12943053otb.265.1617994674722;
        Fri, 09 Apr 2021 11:57:54 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t2sm659928ool.18.2021.04.09.11.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 11:57:54 -0700 (PDT)
Received: (nullmailer pid 3960531 invoked by uid 1000);
        Fri, 09 Apr 2021 18:57:53 -0000
From:   Rob Herring <robh@kernel.org>
To:     Jiri Prchal <jiri.prchal@aksignal.cz>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Christian Eggers <ceggers@arri.de>,
        Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20210409154720.130902-4-jiri.prchal@aksignal.cz>
References: <20210409154720.130902-1-jiri.prchal@aksignal.cz> <20210409154720.130902-4-jiri.prchal@aksignal.cz>
Subject: Re: [PATCH 3/3] nvmem: eeprom: add documentation for FRAM
Date:   Fri, 09 Apr 2021 13:57:53 -0500
Message-Id: <1617994673.262904.3960530.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Apr 2021 17:47:20 +0200, Jiri Prchal wrote:
> Added dt binding documentation.
> 
> Signed-off-by: Jiri Prchal <jiri.prchal@aksignal.cz>
> ---
>  Documentation/devicetree/bindings/eeprom/at25.yaml | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/eeprom/at25.example.dts:40.17-27: Warning (reg_format): /example-0/fram@1:reg: property has invalid length (4 bytes) (#address-cells == 1, #size-cells == 1)
Documentation/devicetree/bindings/eeprom/at25.example.dt.yaml: Warning (pci_device_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/eeprom/at25.example.dt.yaml: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/eeprom/at25.example.dt.yaml: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/eeprom/at25.example.dt.yaml: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/eeprom/at25.example.dt.yaml: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/eeprom/at25.example.dt.yaml: example-0: fram@1:reg:0: [1] is too short
	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/eeprom/at25.example.dt.yaml: fram@1: $nodename:0: 'fram@1' does not match '^eeprom@[0-9a-f]{1,2}$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/eeprom/at25.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/eeprom/at25.example.dt.yaml: fram@1: compatible: 'oneOf' conditional failed, one must be fixed:
	['cypress,fm25'] is too short
	'atmel,at25' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/eeprom/at25.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/eeprom/at25.example.dt.yaml: fram@1: 'pagesize' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/eeprom/at25.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/eeprom/at25.example.dt.yaml: fram@1: 'size' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/eeprom/at25.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/eeprom/at25.example.dt.yaml: fram@1: 'address-width' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/eeprom/at25.yaml

See https://patchwork.ozlabs.org/patch/1464448

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

