Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E080A318E2D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 16:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbhBKPWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 10:22:36 -0500
Received: from mail-oi1-f173.google.com ([209.85.167.173]:43868 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbhBKO5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 09:57:07 -0500
Received: by mail-oi1-f173.google.com with SMTP id d20so6327544oiw.10;
        Thu, 11 Feb 2021 06:56:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=ZSBE8OrnBCLoband96iararV+OGia8GbEuLjNGcSNuQ=;
        b=lRvl2mR/szs2L5nutS+E6boqRlSvBI+Z5C0xEXEdEOnar54Xjb7SN1JWm73bi4CfhZ
         ZhlNisgf5emSX6jUkru/Gk4KBzDV5SbpeaNCisfA683YC7ODFlu9sWm/BSYcVCvhWwJR
         +M9Pl8l/e16rJza3WU0SteNGus1MUhUO8SBxtb0krWJ1DuLhDn9G3Di+9gv53frlpEsn
         NHcPDTZs9kTwO/WAcu6dCTPfbknJFXrE33OhM0yGOmjfGsE9uLvTXkVxHSfRmCbmDoNo
         7bGjhOlAfZiVE/pGafUBdYOGxJFRtxPhx1qsdcjGVglDJvlxvUO461pp6MlKng7PLBdC
         NmRg==
X-Gm-Message-State: AOAM5316D/PQ8HpSYali78l9Jp2NjQ79I3g/mBQz8uDtM408XTn2RZbV
        QJ/7/7qQpIp3/BPLcdji1w==
X-Google-Smtp-Source: ABdhPJw5esQJRHPAqK32bAwOjgAKr+dsJzP6O7vNUJAokj+oH0iJolY7KBln+P2dMeQum1Dz5zzHYA==
X-Received: by 2002:aca:f12:: with SMTP id 18mr3010740oip.106.1613055383043;
        Thu, 11 Feb 2021 06:56:23 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o98sm1054759ota.0.2021.02.11.06.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 06:56:22 -0800 (PST)
Received: (nullmailer pid 519682 invoked by uid 1000);
        Thu, 11 Feb 2021 14:56:20 -0000
From:   Rob Herring <robh@kernel.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bastien Nocera <hadess@hadess.net>,
        Peter Chen <peter.chen@nxp.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20210210091015.v5.1.I248292623d3d0f6a4f0c5bc58478ca3c0062b49a@changeid>
References: <20210210171040.684659-1-mka@chromium.org> <20210210091015.v5.1.I248292623d3d0f6a4f0c5bc58478ca3c0062b49a@changeid>
Subject: Re: [PATCH v5 1/4] dt-bindings: usb: Add binding for discrete onboard USB hubs
Date:   Thu, 11 Feb 2021 08:56:20 -0600
Message-Id: <1613055380.685661.519681.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Feb 2021 09:10:36 -0800, Matthias Kaehlcke wrote:
> Discrete onboard USB hubs (an example for such a hub is the Realtek
> RTS5411) need to be powered and may require initialization of other
> resources (like GPIOs or clocks) to work properly. This adds a device
> tree binding for these hubs.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
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
>  .../bindings/usb/onboard_usb_hub.yaml         | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/onboard_usb_hub.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/usb/onboard_usb_hub.yaml:16:9: [warning] wrong indentation: expected 10 but found 8 (indentation)

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/onboard_usb_hub.yaml: 'additionalProperties' is a required property
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/onboard_usb_hub.yaml: ignoring, error in schema: 
warning: no schema found in file: ./Documentation/devicetree/bindings/usb/onboard_usb_hub.yaml

See https://patchwork.ozlabs.org/patch/1439137

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

