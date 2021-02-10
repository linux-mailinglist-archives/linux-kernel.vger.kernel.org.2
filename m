Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86D08316B8F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 17:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbhBJQop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 11:44:45 -0500
Received: from mail-oo1-f41.google.com ([209.85.161.41]:36561 "EHLO
        mail-oo1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232468AbhBJQkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 11:40:04 -0500
Received: by mail-oo1-f41.google.com with SMTP id x10so625500oor.3;
        Wed, 10 Feb 2021 08:39:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=hLABr+jMceH1pKsKVWNgeUVRSZCzmjSXfeG61+9prYk=;
        b=QLhstt/9+UaJgym+mT790xjdqB4e42xMDkjhC/3/gDy4jZPTDYikn78nVMLYpPjIgm
         8iUg24mHUCLze58BVMl5EZjEequEerOwKy4JjF/nXqOs3d+NmB2MP+kXA5b+1PR16KTT
         fFdXjF6/ffWWeOP95AAbcamptm3kGY3zPbseMoCA+VdI6VjySQUg/k+z6ekbHTkDWt9l
         NUenSMJLXQBUBspfL1evgDJ4K6CFXN0JJ+eM48bel8THewNUsFqe5lPEWEvM1nf+Nu62
         W3LK4IWyGOV8BO0haRp6pZKb1p/bV7LaXoZy+f49tgrI2v6Im5edxNLaFkp7Tqx2Z0wf
         09cA==
X-Gm-Message-State: AOAM531idh9nXLpKDZhGYk0A9lvxeA5dpsyIDkATkXKpPoOCzm3yJAKs
        Ym/ymKl12FdURNkOOS6NSQ==
X-Google-Smtp-Source: ABdhPJzA1Ih5UrarX2Zd/+htFWKmORb2ZC39mQDt8TDt3wEzv7A8OepEaOs/O4rX1RA3yiSFUY5JUQ==
X-Received: by 2002:a4a:b103:: with SMTP id a3mr2640058ooo.30.1612975162288;
        Wed, 10 Feb 2021 08:39:22 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s2sm444254ooc.5.2021.02.10.08.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 08:39:21 -0800 (PST)
Received: (nullmailer pid 2293398 invoked by uid 1000);
        Wed, 10 Feb 2021 16:39:20 -0000
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, kishon@ti.com, vkoul@kernel.org,
        devicetree@vger.kernel.org
In-Reply-To: <20210210080736.771803-2-narmstrong@baylibre.com>
References: <20210210080736.771803-1-narmstrong@baylibre.com> <20210210080736.771803-2-narmstrong@baylibre.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: phy: add Amlogic G12A Analog MIPI D-PHY bindings
Date:   Wed, 10 Feb 2021 10:39:20 -0600
Message-Id: <1612975160.340384.2293397.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Feb 2021 09:07:35 +0100, Neil Armstrong wrote:
> The Amlogic G12A SoCs embeds an Analog MIPI D-PHY to communicate with DSI
> panels, this adds the bindings.
> 
> This Analog D-PHY works with a separate Digital MIPI D-PHY.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../phy/amlogic,g12a-mipi-dphy-analog.yaml    | 35 +++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/amlogic,g12a-mipi-dphy-analog.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/phy/amlogic,g12a-mipi-dphy-analog.example.dts:22.15-25: Warning (reg_format): /example-0/phy@0:reg: property has invalid length (4 bytes) (#address-cells == 1, #size-cells == 1)
Documentation/devicetree/bindings/phy/amlogic,g12a-mipi-dphy-analog.example.dt.yaml: Warning (pci_device_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/phy/amlogic,g12a-mipi-dphy-analog.example.dt.yaml: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/phy/amlogic,g12a-mipi-dphy-analog.example.dt.yaml: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/phy/amlogic,g12a-mipi-dphy-analog.example.dt.yaml: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/phy/amlogic,g12a-mipi-dphy-analog.example.dt.yaml: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/amlogic,g12a-mipi-dphy-analog.example.dt.yaml: example-0: phy@0:reg:0: [0] is too short
	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml

See https://patchwork.ozlabs.org/patch/1438845

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

