Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF0F83379A7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 17:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbhCKQlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 11:41:20 -0500
Received: from mail-io1-f49.google.com ([209.85.166.49]:37797 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhCKQlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 11:41:07 -0500
Received: by mail-io1-f49.google.com with SMTP id y20so4269543iot.4;
        Thu, 11 Mar 2021 08:41:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=wIM7Ieqmfw1uH+6hgx0cLpcvZ20N4K9oMOEFdEs4Wrk=;
        b=Rq5d7HvFNHxqxBQ5lHVw2x8d52JdEfVVmXj22uldNVSLpIXLc8CEG/GNVdJ4RjGN/E
         XvivH9O6xc6Hd5Bc9MKcVi3Z6EGEvfrIIYqORSpvcAxMOoh1Sm+8FSgRaXEzKMmBWzof
         FI+A7XyC/KaaSSYNyNb2Qza6x3YeYqjIoTbHg0ACO/+hFoO8X8QvH6EBgRN824Q2VZnq
         zpwga5sdNzBZIIsQKMfL6eZMiapFoICD/sxdsb00lhOwnEEquv4TPDu4kV+nnQnTz3Yb
         Q/4rPZ3kQp2Jy6cfN5MPxZ9mcR9ynfQnxHPWb7kjzC0vfUbFfBxXZKKDd9iNk6VdriOl
         HrMQ==
X-Gm-Message-State: AOAM530RGTcmM1IlQ72X4k0DTyxlcU76RHz8ExcoJNFdTemlbMUhvWcz
        POF9ryQLgo+yd5Ze6l+Btg==
X-Google-Smtp-Source: ABdhPJw7qMPNwJYupbpC1Z+kkGIkKIdh0UVPqqHA+nZwXstYcIz5NI0KZXrwynN0T6JM0dUa5Qkd9g==
X-Received: by 2002:a05:6602:1406:: with SMTP id t6mr7012640iov.154.1615480866652;
        Thu, 11 Mar 2021 08:41:06 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id l16sm1542750ils.11.2021.03.11.08.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 08:41:04 -0800 (PST)
Received: (nullmailer pid 841928 invoked by uid 1000);
        Thu, 11 Mar 2021 16:41:02 -0000
From:   Rob Herring <robh@kernel.org>
To:     Carlis <zhangxuezhi3@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhangxuezhi1@yulong.com, daniel@ffwll.ch, robh+dt@kernel.org,
        dri-devel@lists.freedesktop.org
In-Reply-To: <1615385315-130920-1-git-send-email-zhangxuezhi3@gmail.com>
References: <1615385315-130920-1-git-send-email-zhangxuezhi3@gmail.com>
Subject: Re: [PATCH] dt-bindings: display: sitronix, st7789v: Add Waveshare 2inch LCD module
Date:   Thu, 11 Mar 2021 09:41:02 -0700
Message-Id: <1615480862.507726.841927.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Mar 2021 22:08:35 +0800, Carlis wrote:
> From: "Carlis" <zhangxuezhi1@yulong.com>
> 
> Document support for the Waveshare 2inch LCD module display, which is a
> 240x320 2" TFT display driven by a Sitronix ST7789V TFT Controller.
> 
> Signed-off-by: Carlis <zhangxuezhi1@yulong.com>
> ---
>  .../bindings/display/sitronix,st7789v.yaml         | 72 ++++++++++++++++++++++
>  1 file changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/sitronix,st7789v.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.example.dt.yaml: panel@0: compatible: 'oneOf' conditional failed, one must be fixed:
	['sitronix,st7789v'] is too short
	'sitronix,st7789v' is not one of ['waveshare,ws-2inch-lcd']
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/sitronix,st7789v.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.example.dt.yaml: panel@0: 'dc-gpios' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/sitronix,st7789v.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.example.dt.yaml: panel@0: 'port', 'power-supply', 'spi-cpha', 'spi-cpol' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/sitronix,st7789v.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/sitronix,st7789v.example.dt.yaml: display@0: compatible:0: 'sitronix,st7789v' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/sitronix,st7789v.example.dt.yaml: display@0: compatible: ['waveshare,ws-2inch-lcd', 'sitronix,st7789v'] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/sitronix,st7789v.example.dt.yaml: display@0: compatible: Additional items are not allowed ('sitronix,st7789v' was unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/sitronix,st7789v.example.dt.yaml: display@0: 'power-supply' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml

See https://patchwork.ozlabs.org/patch/1450539

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

