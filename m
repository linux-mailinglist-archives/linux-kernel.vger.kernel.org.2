Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCFBD460253
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 00:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356544AbhK0XSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 18:18:54 -0500
Received: from mail-oi1-f178.google.com ([209.85.167.178]:44775 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243890AbhK0XQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 18:16:49 -0500
Received: by mail-oi1-f178.google.com with SMTP id be32so26395815oib.11;
        Sat, 27 Nov 2021 15:13:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=mNLXmAuw2le1DMdoTmdRUdw966ZM06MjQHIDAN6H6sc=;
        b=Ot8R1ACZHJailN4TOVuod1dstfDSNhdBpjMMwTxhCkgUzVjWcwN8Rx4rKS75dNgL0I
         NoLRMwinv50FdCsdcmokiqgbTLpZwKHOW1gZaJ16PmRnldCVe6URXIi8C3hI6T0+kIWN
         v4MAkC3PMfcmcKWWXUrP4GK9BRCswk4xFmOiAxQC5KOu4Ogi/4XZXkE+ITo8OrHYnOpq
         HhQ2t+1QppaHYdB6cYsQblUdpZ1aMGKjNnAij/PWLvaAW+mD7/0DyloxDN3MOVhHmP3h
         kzjTx9rudeODYRBG/WOmzUSZSMkWUk5TMWJSuvAJqTobWcH379KoYUWVPifEHBXEk/cB
         DQRw==
X-Gm-Message-State: AOAM5317v9oWyn9kbib6AO9nfQs5jPB678Vk9e261J1XOiLp6j4D/glU
        S26K8Zxz8mBS934UsmKbtI/XI/BHMA==
X-Google-Smtp-Source: ABdhPJwLzQha3gR0/9AGa/spXfNJ2uRy6JioEynsPKhT3FucyEg7mQhtiD3wb4/JGxTbSDFwVYB9uQ==
X-Received: by 2002:a05:6808:3b7:: with SMTP id n23mr32525918oie.160.1638054814398;
        Sat, 27 Nov 2021 15:13:34 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id j5sm1694720oou.23.2021.11.27.15.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Nov 2021 15:13:33 -0800 (PST)
Received: (nullmailer pid 1973545 invoked by uid 1000);
        Sat, 27 Nov 2021 23:13:22 -0000
From:   Rob Herring <robh@kernel.org>
To:     Jayesh Choudhary <j-choudhary@ti.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, alsa-devel@alsa-project.org,
        broonie@kernel.org, lgirdwood@gmail.com
In-Reply-To: <20211126050228.6257-1-j-choudhary@ti.com>
References: <20211126050228.6257-1-j-choudhary@ti.com>
Subject: Re: [PATCH v3] ASoC: dt-bindings: davinci-mcasp: convert McASP bindings to yaml schema
Date:   Sat, 27 Nov 2021 16:13:22 -0700
Message-Id: <1638054802.120379.1973544.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Nov 2021 10:32:28 +0530, Jayesh Choudhary wrote:
> Convert the bindings for McASP controllers for TI SOCs
> from txt to YAML schema.
> 
> Adds additional properties 'clocks', 'clock-names', 'power-domains',
> '#sound-dai-cells', 'num-serializer' and 'port' which were not there
> in the txt file.
> Adds 'dmas' and 'dma-names' in the example which were not there in
> the txt file.
> Changes 'interrupts' and 'interrupt-names' from optional to
> required properties.
> 
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> ---
> Changelog:
> v3:
> - removes maxItems from 'clock-names'
> 
> v2:
> - changes the commit message
> - modifies the properties 'clocks', 'clock-names', 'dma-names',
>   'dmas', 'interrupts' and 'interrupt-names' according to the
>   arm SOCs
> - adds 'port' and 'num-serializer' as node properties
> 
>  .../bindings/sound/davinci-mcasp-audio.txt    |  86 ---------
>  .../bindings/sound/davinci-mcasp-audio.yaml   | 178 ++++++++++++++++++
>  2 files changed, 178 insertions(+), 86 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/davinci-mcasp-audio.yaml
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/1559951


mcasp@0: 'rt-num-evt' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/am335x-wega-rdk.dt.yaml

mcasp@2b00000: 'op-mode' is a required property
	arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dt.yaml
	arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dt.yaml
	arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dt.yaml
	arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dt.yaml

mcasp@2b00000: 'serial-dir' is a required property
	arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dt.yaml
	arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dt.yaml
	arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dt.yaml
	arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dt.yaml

mcasp@2b00000: 'tdm-slots' is a required property
	arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dt.yaml
	arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dt.yaml
	arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dt.yaml
	arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dt.yaml

mcasp@2b10000: 'op-mode' is a required property
	arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dt.yaml
	arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dt.yaml
	arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dt.yaml
	arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dt.yaml

mcasp@2b10000: 'serial-dir' is a required property
	arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dt.yaml
	arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dt.yaml
	arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dt.yaml
	arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dt.yaml

mcasp@2b10000: 'tdm-slots' is a required property
	arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dt.yaml
	arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dt.yaml
	arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dt.yaml
	arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dt.yaml

mcasp@2b20000: 'op-mode' is a required property
	arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dt.yaml
	arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dt.yaml
	arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dt.yaml
	arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dt.yaml

mcasp@2b20000: 'serial-dir' is a required property
	arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dt.yaml
	arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dt.yaml
	arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dt.yaml
	arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dt.yaml

mcasp@2b20000: 'tdm-slots' is a required property
	arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dt.yaml
	arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dt.yaml
	arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dt.yaml
	arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dt.yaml

