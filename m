Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30FA3355500
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 15:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344431AbhDFNY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 09:24:28 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:43566 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344402AbhDFNYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 09:24:23 -0400
Received: by mail-ot1-f53.google.com with SMTP id s16-20020a0568301490b02901b83efc84a0so5671946otq.10;
        Tue, 06 Apr 2021 06:24:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=WMh9wsTtUk5bjoFe6rmnQ66dAMVkJoEObr181rNizCo=;
        b=k2BBwCXCrqnKmf4rYaNDkoFS9rub1IHTFWArX9hVpNFaBjlgksrni7xZqtYEyQiCvi
         NgVZZJAheUBqFkYy+9C+kf5gxZ7Evr7GTIHI+Xjxg0CzicDGNaEMiq4MryhVyjOs2xkF
         9YmsKo1bpaiBaIcOevKwP2Yi+5rYc5JXMya5+T2G+P8T7zj1SMw8XJxUMsUODQgjTSTV
         bPE3HotwX+N3wGCm9gjgSceF6D8asvkKaU9MIZvtouW7j5zLtq5yhrQHJiDH/m7rV83b
         YoRTpSZtG6hHX9bUDpLJybhn8MtRrdwsSLt/A48YLcWI9FNIwj3A145bb9QUcKKigfRS
         L1pA==
X-Gm-Message-State: AOAM5330TbDBnt7a3Ijp4mvgxh8WZBJBwsIPvubqvPyeQTJQ2O7ay7J+
        1RCQXVfmw0A2OBG9BUbq0Q==
X-Google-Smtp-Source: ABdhPJw6oyIqrB/SR505G75yFdcsa0+9wxt1Z4y+VO2PXVEFRp/jBWqxZmcdvOjPgjDsqwojKjW6lw==
X-Received: by 2002:a9d:5a97:: with SMTP id w23mr26569036oth.314.1617715455706;
        Tue, 06 Apr 2021 06:24:15 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g2sm4623942otn.32.2021.04.06.06.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 06:24:14 -0700 (PDT)
Received: (nullmailer pid 1674500 invoked by uid 1000);
        Tue, 06 Apr 2021 13:24:05 -0000
From:   Rob Herring <robh@kernel.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-usb@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Peter Chen <peter.chen@nxp.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, Bastien Nocera <hadess@hadess.net>,
        Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <20210405124900.v6.1.I248292623d3d0f6a4f0c5bc58478ca3c0062b49a@changeid>
References: <20210405201817.3977893-1-mka@chromium.org> <20210405124900.v6.1.I248292623d3d0f6a4f0c5bc58478ca3c0062b49a@changeid>
Subject: Re: [PATCH v6 1/5] dt-bindings: usb: Add binding for Realtek RTS5411 hub controller
Date:   Tue, 06 Apr 2021 08:24:05 -0500
Message-Id: <1617715445.179283.1674499.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Apr 2021 13:18:13 -0700, Matthias Kaehlcke wrote:
> The Realtek RTS5411 is a USB 3.0 hub controller with 4 ports.
> 
> This initial version of the binding only describes USB related
> aspects of the RTS5411, it does not cover the option of
> connecting the controller as an i2c slave.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> 
> Changes in v7:
> - added type ref for 'companion-hub' property
> 
> Changes in v6:
> - Realtek binding instead of generic onboard_usb_hub
> - added 'companion-hub' property
> - added reference to 'usb-device.yaml'
> - 'fixed' indentation of compatible entries to keep yamllint happy
> - added 'additionalProperties' entry
> - updated commit message
> 
> Changes in v5:
> - updated 'title'
> - only use standard USB compatible strings
> - deleted 'usb_hub' node
> - renamed 'usb_controller' node to 'usb-controller'
> - removed labels from USB nodes
> - added 'vdd-supply' to USB nodes
> 
> Changes in v4:
> - none
> 
> Changes in v3:
> - updated commit message
> - removed recursive reference to $self
> - adjusted 'compatible' definition to support multiple entries
> - changed USB controller phandle to be a node
> 
> Changes in v2:
> - removed 'wakeup-source' and 'power-off-in-suspend' properties
> - consistently use spaces for indentation in example
> 
>  .../bindings/usb/realtek,rts5411.yaml         | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/realtek,rts5411.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/realtek,rts5411.example.dt.yaml: hub@1: 'reg' does not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/realtek,rts5411.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/realtek,rts5411.example.dt.yaml: hub@2: 'reg' does not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/realtek,rts5411.yaml

See https://patchwork.ozlabs.org/patch/1462533

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

