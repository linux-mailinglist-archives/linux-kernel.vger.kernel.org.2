Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62D5132FCC5
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 20:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbhCFT26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 14:28:58 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:38752 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbhCFT2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 14:28:30 -0500
Received: by mail-ot1-f43.google.com with SMTP id a17so5287791oto.5;
        Sat, 06 Mar 2021 11:28:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=xyiAtqGUhm5WhvdlXAu5lc9wGfvlbIWFApl+PBFJsB0=;
        b=cD39bHbu6s3gn66EC/pWfX+/cdbbVFDDlhlA6dujQEaOTA08KWySoQezJgxJVWHRcB
         8nQDJFDSxgSTI+lB8GRyPZhDV3GPSvT5G1p/TkWjJLZ+cPDafgecFRGaBGuyRibHl/7z
         6kYYwe1Si2uVcRkBT3YLc8gQfLnYry3FtWAOlqVNOwIIrqjMl9Ok81eYXJJVb/zyakZx
         kHzVSAlj6PSadGhwvTbzvu8ojVOrGcus5PjI3SItvYTrfxBxrU9+M55yOzmFR6HwdoAd
         UDrOIpDBqhwWyeZFk0+b8Y46YIwKvwIr9DnniBySrYtUAEat701CgS+NIRV6ska/LL89
         13AQ==
X-Gm-Message-State: AOAM530+G2TpPebDi7CDFMyMfh3AtySmZnp0HzBsWGzk0FXBLEn6MH2Q
        4WC+3a7RUMkV6ULQr0NXnw==
X-Google-Smtp-Source: ABdhPJwliZEDkh8g1tf3lNuUwvOd7FUyIQvQzTzQg1LkJx1/NvzE8AidrB2JtWyHP199xv56OzK8ew==
X-Received: by 2002:a9d:503:: with SMTP id 3mr3855401otw.77.1615058910377;
        Sat, 06 Mar 2021 11:28:30 -0800 (PST)
Received: from robh.at.kernel.org ([172.58.102.249])
        by smtp.gmail.com with ESMTPSA id w11sm1349866ooc.35.2021.03.06.11.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 11:28:29 -0800 (PST)
Received: (nullmailer pid 1058184 invoked by uid 1000);
        Sat, 06 Mar 2021 19:28:21 -0000
From:   Rob Herring <robh@kernel.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Bastien Nocera <hadess@hadess.net>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-usb@vger.kernel.org, Peter Chen <peter.chen@nxp.com>,
        Michal Simek <michal.simek@xilinx.com>,
        devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20210305113832.v6.1.I248292623d3d0f6a4f0c5bc58478ca3c0062b49a@changeid>
References: <20210305193853.2040456-1-mka@chromium.org> <20210305113832.v6.1.I248292623d3d0f6a4f0c5bc58478ca3c0062b49a@changeid>
Subject: Re: [PATCH v6 1/5] dt-bindings: usb: Add binding for Realtek RTS5411 hub controller
Date:   Sat, 06 Mar 2021 12:28:21 -0700
Message-Id: <1615058901.081592.1058183.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 05 Mar 2021 11:38:49 -0800, Matthias Kaehlcke wrote:
> The Realtek RTS5411 is a USB 3.0 hub controller with 4 ports.
> 
> This initial version of the binding only describes USB related
> aspects of the RTS5411, it does not cover the option of
> connecting the controller as an i2c slave.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
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
>  .../bindings/usb/realtek,rts5411.yaml         | 58 +++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/realtek,rts5411.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/realtek,rts5411.example.dt.yaml: hub@1: 'reg' does not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/realtek,rts5411.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/realtek,rts5411.example.dt.yaml: hub@2: 'reg' does not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/realtek,rts5411.yaml

See https://patchwork.ozlabs.org/patch/1448184

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

