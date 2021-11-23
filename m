Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28FAE45A811
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 17:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbhKWQix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 11:38:53 -0500
Received: from mail-io1-f48.google.com ([209.85.166.48]:40619 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234469AbhKWQiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 11:38:20 -0500
Received: by mail-io1-f48.google.com with SMTP id p23so28738444iod.7;
        Tue, 23 Nov 2021 08:35:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=D6T/kSJ9srFChgFgIRsLj0E0OrT4xnoVPNKL7Xh9JN4=;
        b=lZE8ePn3Fp79MS8PYTSW4txafj33OxOrZF9M33gYSiZQw6dp4FWl5etZP1dszfbHex
         JFk5870jCHhe785uLQQvSI+G+mOCPZlEbBz/1yiG/2V07HmB5ATofBJMj5J1UGL1MqHn
         ZFhOpjt1aMAY+Po2tMS8WAIvRp2JZuxFijqxxpqtDMbsSSFFFtWKxFwNza7vgf/pkuly
         NGkVi24iANLdQXGAzumudBtoN7i3crYRd9e/J9KKsdRlPh2Vl8Xt8t7LkdjbFFQLW8ES
         khO6BFq4Xr9Pq8IFFX6CTD/UAWxyQ/ElOrEzWFAIj9zY9QSxExxnZiYWIVnTnyHyz0iJ
         klGA==
X-Gm-Message-State: AOAM532gn7WILFFdgAAI6bbGOcOHYIc+/ceECBu47nnS0Ibx3uG8KWJj
        RXfF0j4Hl3rrGUI2kzcvLg==
X-Google-Smtp-Source: ABdhPJxRUIRmOhuAJyjr0WFtSMk8x/c97hGhx+pkyvVMetgFjebYdZNJ0ZQRHk7wLwVxAUZ0Wp9bgw==
X-Received: by 2002:a02:ab8f:: with SMTP id t15mr8110328jan.147.1637685312081;
        Tue, 23 Nov 2021 08:35:12 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id y21sm6846548ioj.41.2021.11.23.08.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 08:35:11 -0800 (PST)
Received: (nullmailer pid 3442930 invoked by uid 1000);
        Tue, 23 Nov 2021 16:34:29 -0000
From:   Rob Herring <robh@kernel.org>
To:     Jayesh Choudhary <j-choudhary@ti.com>
Cc:     lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
In-Reply-To: <20211122091525.2290-1-j-choudhary@ti.com>
References: <20211122091525.2290-1-j-choudhary@ti.com>
Subject: Re: [PATCH] ASoC: dt-bindings: davinci-mcasp: convert McASP bindings to yaml schema
Date:   Tue, 23 Nov 2021 09:34:29 -0700
Message-Id: <1637685269.740254.3442929.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Nov 2021 14:45:25 +0530, Jayesh Choudhary wrote:
> Convert the bindings for McASP controllers for TI SOCs
> from txt to YAML schema.
> 
> Adds additional properties 'clocks', 'clock-names', 'power-domains'
> and '#sound-dai-cells' which were not there in txt file.
> Adds 'dmas' and 'dma-names' in the example which were not there in
> txt file.
> Changes 'interrupts' and 'interrupt-names' from optional to
> required properties.
> 
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> ---
>  .../bindings/sound/davinci-mcasp-audio.txt    |  86 ----------
>  .../bindings/sound/davinci-mcasp-audio.yaml   | 161 ++++++++++++++++++
>  2 files changed, 161 insertions(+), 86 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/davinci-mcasp-audio.yaml
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/1557927


mcasp@0: clock-names: Additional items are not allowed ('ahclkx', 'ahclkr' were unexpected)
	arch/arm/boot/dts/am571x-idk.dt.yaml
	arch/arm/boot/dts/am571x-idk.dt.yaml
	arch/arm/boot/dts/am5729-beagleboneai.dt.yaml
	arch/arm/boot/dts/am5729-beagleboneai.dt.yaml
	arch/arm/boot/dts/am572x-idk.dt.yaml
	arch/arm/boot/dts/am572x-idk.dt.yaml
	arch/arm/boot/dts/am574x-idk.dt.yaml
	arch/arm/boot/dts/am574x-idk.dt.yaml
	arch/arm/boot/dts/am57xx-beagle-x15.dt.yaml
	arch/arm/boot/dts/am57xx-beagle-x15.dt.yaml
	arch/arm/boot/dts/am57xx-beagle-x15-revb1.dt.yaml
	arch/arm/boot/dts/am57xx-beagle-x15-revb1.dt.yaml
	arch/arm/boot/dts/am57xx-beagle-x15-revc.dt.yaml
	arch/arm/boot/dts/am57xx-beagle-x15-revc.dt.yaml
	arch/arm/boot/dts/am57xx-cl-som-am57x.dt.yaml
	arch/arm/boot/dts/am57xx-cl-som-am57x.dt.yaml
	arch/arm/boot/dts/am57xx-sbc-am57x.dt.yaml
	arch/arm/boot/dts/am57xx-sbc-am57x.dt.yaml
	arch/arm/boot/dts/dra71-evm.dt.yaml
	arch/arm/boot/dts/dra71-evm.dt.yaml
	arch/arm/boot/dts/dra72-evm.dt.yaml
	arch/arm/boot/dts/dra72-evm.dt.yaml
	arch/arm/boot/dts/dra72-evm-revc.dt.yaml
	arch/arm/boot/dts/dra72-evm-revc.dt.yaml
	arch/arm/boot/dts/dra76-evm.dt.yaml
	arch/arm/boot/dts/dra76-evm.dt.yaml
	arch/arm/boot/dts/dra7-evm.dt.yaml
	arch/arm/boot/dts/dra7-evm.dt.yaml

mcasp@0: clock-names: Additional items are not allowed ('ahclkx' was unexpected)
	arch/arm/boot/dts/am571x-idk.dt.yaml
	arch/arm/boot/dts/am571x-idk.dt.yaml
	arch/arm/boot/dts/am571x-idk.dt.yaml
	arch/arm/boot/dts/am571x-idk.dt.yaml
	arch/arm/boot/dts/am571x-idk.dt.yaml
	arch/arm/boot/dts/am571x-idk.dt.yaml
	arch/arm/boot/dts/am5729-beagleboneai.dt.yaml
	arch/arm/boot/dts/am5729-beagleboneai.dt.yaml
	arch/arm/boot/dts/am5729-beagleboneai.dt.yaml
	arch/arm/boot/dts/am5729-beagleboneai.dt.yaml
	arch/arm/boot/dts/am5729-beagleboneai.dt.yaml
	arch/arm/boot/dts/am5729-beagleboneai.dt.yaml
	arch/arm/boot/dts/am572x-idk.dt.yaml
	arch/arm/boot/dts/am572x-idk.dt.yaml
	arch/arm/boot/dts/am572x-idk.dt.yaml
	arch/arm/boot/dts/am572x-idk.dt.yaml
	arch/arm/boot/dts/am572x-idk.dt.yaml
	arch/arm/boot/dts/am572x-idk.dt.yaml
	arch/arm/boot/dts/am574x-idk.dt.yaml
	arch/arm/boot/dts/am574x-idk.dt.yaml
	arch/arm/boot/dts/am574x-idk.dt.yaml
	arch/arm/boot/dts/am574x-idk.dt.yaml
	arch/arm/boot/dts/am574x-idk.dt.yaml
	arch/arm/boot/dts/am574x-idk.dt.yaml
	arch/arm/boot/dts/am57xx-beagle-x15.dt.yaml
	arch/arm/boot/dts/am57xx-beagle-x15.dt.yaml
	arch/arm/boot/dts/am57xx-beagle-x15.dt.yaml
	arch/arm/boot/dts/am57xx-beagle-x15.dt.yaml
	arch/arm/boot/dts/am57xx-beagle-x15.dt.yaml
	arch/arm/boot/dts/am57xx-beagle-x15.dt.yaml
	arch/arm/boot/dts/am57xx-beagle-x15-revb1.dt.yaml
	arch/arm/boot/dts/am57xx-beagle-x15-revb1.dt.yaml
	arch/arm/boot/dts/am57xx-beagle-x15-revb1.dt.yaml
	arch/arm/boot/dts/am57xx-beagle-x15-revb1.dt.yaml
	arch/arm/boot/dts/am57xx-beagle-x15-revb1.dt.yaml
	arch/arm/boot/dts/am57xx-beagle-x15-revb1.dt.yaml
	arch/arm/boot/dts/am57xx-beagle-x15-revc.dt.yaml
	arch/arm/boot/dts/am57xx-beagle-x15-revc.dt.yaml
	arch/arm/boot/dts/am57xx-beagle-x15-revc.dt.yaml
	arch/arm/boot/dts/am57xx-beagle-x15-revc.dt.yaml
	arch/arm/boot/dts/am57xx-beagle-x15-revc.dt.yaml
	arch/arm/boot/dts/am57xx-beagle-x15-revc.dt.yaml
	arch/arm/boot/dts/am57xx-cl-som-am57x.dt.yaml
	arch/arm/boot/dts/am57xx-cl-som-am57x.dt.yaml
	arch/arm/boot/dts/am57xx-cl-som-am57x.dt.yaml
	arch/arm/boot/dts/am57xx-cl-som-am57x.dt.yaml
	arch/arm/boot/dts/am57xx-cl-som-am57x.dt.yaml
	arch/arm/boot/dts/am57xx-cl-som-am57x.dt.yaml
	arch/arm/boot/dts/am57xx-sbc-am57x.dt.yaml
	arch/arm/boot/dts/am57xx-sbc-am57x.dt.yaml
	arch/arm/boot/dts/am57xx-sbc-am57x.dt.yaml
	arch/arm/boot/dts/am57xx-sbc-am57x.dt.yaml
	arch/arm/boot/dts/am57xx-sbc-am57x.dt.yaml
	arch/arm/boot/dts/am57xx-sbc-am57x.dt.yaml
	arch/arm/boot/dts/dra71-evm.dt.yaml
	arch/arm/boot/dts/dra71-evm.dt.yaml
	arch/arm/boot/dts/dra71-evm.dt.yaml
	arch/arm/boot/dts/dra71-evm.dt.yaml
	arch/arm/boot/dts/dra71-evm.dt.yaml
	arch/arm/boot/dts/dra71-evm.dt.yaml
	arch/arm/boot/dts/dra72-evm.dt.yaml
	arch/arm/boot/dts/dra72-evm.dt.yaml
	arch/arm/boot/dts/dra72-evm.dt.yaml
	arch/arm/boot/dts/dra72-evm.dt.yaml
	arch/arm/boot/dts/dra72-evm.dt.yaml
	arch/arm/boot/dts/dra72-evm.dt.yaml
	arch/arm/boot/dts/dra72-evm-revc.dt.yaml
	arch/arm/boot/dts/dra72-evm-revc.dt.yaml
	arch/arm/boot/dts/dra72-evm-revc.dt.yaml
	arch/arm/boot/dts/dra72-evm-revc.dt.yaml
	arch/arm/boot/dts/dra72-evm-revc.dt.yaml
	arch/arm/boot/dts/dra72-evm-revc.dt.yaml
	arch/arm/boot/dts/dra76-evm.dt.yaml
	arch/arm/boot/dts/dra76-evm.dt.yaml
	arch/arm/boot/dts/dra76-evm.dt.yaml
	arch/arm/boot/dts/dra76-evm.dt.yaml
	arch/arm/boot/dts/dra76-evm.dt.yaml
	arch/arm/boot/dts/dra76-evm.dt.yaml
	arch/arm/boot/dts/dra7-evm.dt.yaml
	arch/arm/boot/dts/dra7-evm.dt.yaml
	arch/arm/boot/dts/dra7-evm.dt.yaml
	arch/arm/boot/dts/dra7-evm.dt.yaml
	arch/arm/boot/dts/dra7-evm.dt.yaml
	arch/arm/boot/dts/dra7-evm.dt.yaml

mcasp@0: clock-names: ['fck', 'ahclkx', 'ahclkr'] is too long
	arch/arm/boot/dts/am571x-idk.dt.yaml
	arch/arm/boot/dts/am571x-idk.dt.yaml
	arch/arm/boot/dts/am5729-beagleboneai.dt.yaml
	arch/arm/boot/dts/am5729-beagleboneai.dt.yaml
	arch/arm/boot/dts/am572x-idk.dt.yaml
	arch/arm/boot/dts/am572x-idk.dt.yaml
	arch/arm/boot/dts/am574x-idk.dt.yaml
	arch/arm/boot/dts/am574x-idk.dt.yaml
	arch/arm/boot/dts/am57xx-beagle-x15.dt.yaml
	arch/arm/boot/dts/am57xx-beagle-x15.dt.yaml
	arch/arm/boot/dts/am57xx-beagle-x15-revb1.dt.yaml
	arch/arm/boot/dts/am57xx-beagle-x15-revb1.dt.yaml
	arch/arm/boot/dts/am57xx-beagle-x15-revc.dt.yaml
	arch/arm/boot/dts/am57xx-beagle-x15-revc.dt.yaml
	arch/arm/boot/dts/am57xx-cl-som-am57x.dt.yaml
	arch/arm/boot/dts/am57xx-cl-som-am57x.dt.yaml
	arch/arm/boot/dts/am57xx-sbc-am57x.dt.yaml
	arch/arm/boot/dts/am57xx-sbc-am57x.dt.yaml
	arch/arm/boot/dts/dra71-evm.dt.yaml
	arch/arm/boot/dts/dra71-evm.dt.yaml
	arch/arm/boot/dts/dra72-evm.dt.yaml
	arch/arm/boot/dts/dra72-evm.dt.yaml
	arch/arm/boot/dts/dra72-evm-revc.dt.yaml
	arch/arm/boot/dts/dra72-evm-revc.dt.yaml
	arch/arm/boot/dts/dra76-evm.dt.yaml
	arch/arm/boot/dts/dra76-evm.dt.yaml
	arch/arm/boot/dts/dra7-evm.dt.yaml
	arch/arm/boot/dts/dra7-evm.dt.yaml

mcasp@0: clock-names: ['fck', 'ahclkx'] is too long
	arch/arm/boot/dts/am571x-idk.dt.yaml
	arch/arm/boot/dts/am571x-idk.dt.yaml
	arch/arm/boot/dts/am571x-idk.dt.yaml
	arch/arm/boot/dts/am571x-idk.dt.yaml
	arch/arm/boot/dts/am571x-idk.dt.yaml
	arch/arm/boot/dts/am571x-idk.dt.yaml
	arch/arm/boot/dts/am5729-beagleboneai.dt.yaml
	arch/arm/boot/dts/am5729-beagleboneai.dt.yaml
	arch/arm/boot/dts/am5729-beagleboneai.dt.yaml
	arch/arm/boot/dts/am5729-beagleboneai.dt.yaml
	arch/arm/boot/dts/am5729-beagleboneai.dt.yaml
	arch/arm/boot/dts/am5729-beagleboneai.dt.yaml
	arch/arm/boot/dts/am572x-idk.dt.yaml
	arch/arm/boot/dts/am572x-idk.dt.yaml
	arch/arm/boot/dts/am572x-idk.dt.yaml
	arch/arm/boot/dts/am572x-idk.dt.yaml
	arch/arm/boot/dts/am572x-idk.dt.yaml
	arch/arm/boot/dts/am572x-idk.dt.yaml
	arch/arm/boot/dts/am574x-idk.dt.yaml
	arch/arm/boot/dts/am574x-idk.dt.yaml
	arch/arm/boot/dts/am574x-idk.dt.yaml
	arch/arm/boot/dts/am574x-idk.dt.yaml
	arch/arm/boot/dts/am574x-idk.dt.yaml
	arch/arm/boot/dts/am574x-idk.dt.yaml
	arch/arm/boot/dts/am57xx-beagle-x15.dt.yaml
	arch/arm/boot/dts/am57xx-beagle-x15.dt.yaml
	arch/arm/boot/dts/am57xx-beagle-x15.dt.yaml
	arch/arm/boot/dts/am57xx-beagle-x15.dt.yaml
	arch/arm/boot/dts/am57xx-beagle-x15.dt.yaml
	arch/arm/boot/dts/am57xx-beagle-x15.dt.yaml
	arch/arm/boot/dts/am57xx-beagle-x15-revb1.dt.yaml
	arch/arm/boot/dts/am57xx-beagle-x15-revb1.dt.yaml
	arch/arm/boot/dts/am57xx-beagle-x15-revb1.dt.yaml
	arch/arm/boot/dts/am57xx-beagle-x15-revb1.dt.yaml
	arch/arm/boot/dts/am57xx-beagle-x15-revb1.dt.yaml
	arch/arm/boot/dts/am57xx-beagle-x15-revb1.dt.yaml
	arch/arm/boot/dts/am57xx-beagle-x15-revc.dt.yaml
	arch/arm/boot/dts/am57xx-beagle-x15-revc.dt.yaml
	arch/arm/boot/dts/am57xx-beagle-x15-revc.dt.yaml
	arch/arm/boot/dts/am57xx-beagle-x15-revc.dt.yaml
	arch/arm/boot/dts/am57xx-beagle-x15-revc.dt.yaml
	arch/arm/boot/dts/am57xx-beagle-x15-revc.dt.yaml
	arch/arm/boot/dts/am57xx-cl-som-am57x.dt.yaml
	arch/arm/boot/dts/am57xx-cl-som-am57x.dt.yaml
	arch/arm/boot/dts/am57xx-cl-som-am57x.dt.yaml
	arch/arm/boot/dts/am57xx-cl-som-am57x.dt.yaml
	arch/arm/boot/dts/am57xx-cl-som-am57x.dt.yaml
	arch/arm/boot/dts/am57xx-cl-som-am57x.dt.yaml
	arch/arm/boot/dts/am57xx-sbc-am57x.dt.yaml
	arch/arm/boot/dts/am57xx-sbc-am57x.dt.yaml
	arch/arm/boot/dts/am57xx-sbc-am57x.dt.yaml
	arch/arm/boot/dts/am57xx-sbc-am57x.dt.yaml
	arch/arm/boot/dts/am57xx-sbc-am57x.dt.yaml
	arch/arm/boot/dts/am57xx-sbc-am57x.dt.yaml
	arch/arm/boot/dts/dra71-evm.dt.yaml
	arch/arm/boot/dts/dra71-evm.dt.yaml
	arch/arm/boot/dts/dra71-evm.dt.yaml
	arch/arm/boot/dts/dra71-evm.dt.yaml
	arch/arm/boot/dts/dra71-evm.dt.yaml
	arch/arm/boot/dts/dra71-evm.dt.yaml
	arch/arm/boot/dts/dra72-evm.dt.yaml
	arch/arm/boot/dts/dra72-evm.dt.yaml
	arch/arm/boot/dts/dra72-evm.dt.yaml
	arch/arm/boot/dts/dra72-evm.dt.yaml
	arch/arm/boot/dts/dra72-evm.dt.yaml
	arch/arm/boot/dts/dra72-evm.dt.yaml
	arch/arm/boot/dts/dra72-evm-revc.dt.yaml
	arch/arm/boot/dts/dra72-evm-revc.dt.yaml
	arch/arm/boot/dts/dra72-evm-revc.dt.yaml
	arch/arm/boot/dts/dra72-evm-revc.dt.yaml
	arch/arm/boot/dts/dra72-evm-revc.dt.yaml
	arch/arm/boot/dts/dra72-evm-revc.dt.yaml
	arch/arm/boot/dts/dra76-evm.dt.yaml
	arch/arm/boot/dts/dra76-evm.dt.yaml
	arch/arm/boot/dts/dra76-evm.dt.yaml
	arch/arm/boot/dts/dra76-evm.dt.yaml
	arch/arm/boot/dts/dra76-evm.dt.yaml
	arch/arm/boot/dts/dra76-evm.dt.yaml
	arch/arm/boot/dts/dra7-evm.dt.yaml
	arch/arm/boot/dts/dra7-evm.dt.yaml
	arch/arm/boot/dts/dra7-evm.dt.yaml
	arch/arm/boot/dts/dra7-evm.dt.yaml
	arch/arm/boot/dts/dra7-evm.dt.yaml
	arch/arm/boot/dts/dra7-evm.dt.yaml

mcasp@0: clocks: [[155, 0, 0], [155, 0, 24], [155, 0, 28]] is too long
	arch/arm/boot/dts/am5729-beagleboneai.dt.yaml

mcasp@0: clocks: [[156, 0, 0], [156, 0, 24], [156, 0, 28]] is too long
	arch/arm/boot/dts/am57xx-cl-som-am57x.dt.yaml
	arch/arm/boot/dts/dra71-evm.dt.yaml

mcasp@0: clocks: [[157, 0, 0], [157, 0, 24], [157, 0, 28]] is too long
	arch/arm/boot/dts/am57xx-beagle-x15.dt.yaml
	arch/arm/boot/dts/am57xx-beagle-x15-revb1.dt.yaml
	arch/arm/boot/dts/am57xx-beagle-x15-revc.dt.yaml
	arch/arm/boot/dts/dra72-evm.dt.yaml
	arch/arm/boot/dts/dra72-evm-revc.dt.yaml
	arch/arm/boot/dts/dra76-evm.dt.yaml
	arch/arm/boot/dts/dra7-evm.dt.yaml

mcasp@0: clocks: [[158, 0, 0], [158, 0, 24], [158, 0, 28]] is too long
	arch/arm/boot/dts/am571x-idk.dt.yaml
	arch/arm/boot/dts/am572x-idk.dt.yaml
	arch/arm/boot/dts/am574x-idk.dt.yaml
	arch/arm/boot/dts/am57xx-sbc-am57x.dt.yaml

mcasp@0: clocks: [[91, 340, 0], [156, 0, 24], [91, 340, 28]] is too long
	arch/arm/boot/dts/dra71-evm.dt.yaml

mcasp@0: clocks: [[91, 348, 0], [91, 348, 24]] is too long
	arch/arm/boot/dts/dra71-evm.dt.yaml

mcasp@0: clocks: [[91, 364, 0], [91, 364, 24]] is too long
	arch/arm/boot/dts/dra71-evm.dt.yaml

mcasp@0: clocks: [[91, 388, 0], [91, 388, 24]] is too long
	arch/arm/boot/dts/dra71-evm.dt.yaml

mcasp@0: clocks: [[91, 396, 0], [91, 396, 24]] is too long
	arch/arm/boot/dts/dra71-evm.dt.yaml

mcasp@0: clocks: [[91, 504, 0], [91, 504, 24]] is too long
	arch/arm/boot/dts/dra71-evm.dt.yaml

mcasp@0: clocks: [[91, 508, 0], [91, 508, 24]] is too long
	arch/arm/boot/dts/dra71-evm.dt.yaml

mcasp@0: clocks: [[92, 340, 0], [155, 0, 24], [92, 340, 28]] is too long
	arch/arm/boot/dts/am5729-beagleboneai.dt.yaml

mcasp@0: clocks: [[92, 340, 0], [156, 0, 24], [92, 340, 28]] is too long
	arch/arm/boot/dts/am57xx-cl-som-am57x.dt.yaml

mcasp@0: clocks: [[92, 340, 0], [157, 0, 24], [92, 340, 28]] is too long
	arch/arm/boot/dts/am57xx-beagle-x15.dt.yaml
	arch/arm/boot/dts/am57xx-beagle-x15-revb1.dt.yaml
	arch/arm/boot/dts/am57xx-beagle-x15-revc.dt.yaml
	arch/arm/boot/dts/dra72-evm.dt.yaml
	arch/arm/boot/dts/dra72-evm-revc.dt.yaml
	arch/arm/boot/dts/dra7-evm.dt.yaml

mcasp@0: clocks: [[92, 340, 0], [158, 0, 24], [92, 340, 28]] is too long
	arch/arm/boot/dts/am571x-idk.dt.yaml
	arch/arm/boot/dts/am572x-idk.dt.yaml
	arch/arm/boot/dts/am574x-idk.dt.yaml
	arch/arm/boot/dts/am57xx-sbc-am57x.dt.yaml

mcasp@0: clocks: [[92, 348, 0], [92, 348, 24]] is too long
	arch/arm/boot/dts/am571x-idk.dt.yaml
	arch/arm/boot/dts/am5729-beagleboneai.dt.yaml
	arch/arm/boot/dts/am572x-idk.dt.yaml
	arch/arm/boot/dts/am574x-idk.dt.yaml
	arch/arm/boot/dts/am57xx-beagle-x15.dt.yaml
	arch/arm/boot/dts/am57xx-beagle-x15-revb1.dt.yaml
	arch/arm/boot/dts/am57xx-beagle-x15-revc.dt.yaml
	arch/arm/boot/dts/am57xx-cl-som-am57x.dt.yaml
	arch/arm/boot/dts/am57xx-sbc-am57x.dt.yaml
	arch/arm/boot/dts/dra72-evm.dt.yaml
	arch/arm/boot/dts/dra72-evm-revc.dt.yaml
	arch/arm/boot/dts/dra7-evm.dt.yaml

mcasp@0: clocks: [[92, 364, 0], [92, 364, 24]] is too long
	arch/arm/boot/dts/am571x-idk.dt.yaml
	arch/arm/boot/dts/am5729-beagleboneai.dt.yaml
	arch/arm/boot/dts/am572x-idk.dt.yaml
	arch/arm/boot/dts/am574x-idk.dt.yaml
	arch/arm/boot/dts/am57xx-beagle-x15.dt.yaml
	arch/arm/boot/dts/am57xx-beagle-x15-revb1.dt.yaml
	arch/arm/boot/dts/am57xx-beagle-x15-revc.dt.yaml
	arch/arm/boot/dts/am57xx-cl-som-am57x.dt.yaml
	arch/arm/boot/dts/am57xx-sbc-am57x.dt.yaml
	arch/arm/boot/dts/dra72-evm.dt.yaml
	arch/arm/boot/dts/dra72-evm-revc.dt.yaml
	arch/arm/boot/dts/dra7-evm.dt.yaml

mcasp@0: clocks: [[92, 388, 0], [92, 388, 24]] is too long
	arch/arm/boot/dts/am571x-idk.dt.yaml
	arch/arm/boot/dts/am5729-beagleboneai.dt.yaml
	arch/arm/boot/dts/am572x-idk.dt.yaml
	arch/arm/boot/dts/am574x-idk.dt.yaml
	arch/arm/boot/dts/am57xx-beagle-x15.dt.yaml
	arch/arm/boot/dts/am57xx-beagle-x15-revb1.dt.yaml
	arch/arm/boot/dts/am57xx-beagle-x15-revc.dt.yaml
	arch/arm/boot/dts/am57xx-cl-som-am57x.dt.yaml
	arch/arm/boot/dts/am57xx-sbc-am57x.dt.yaml
	arch/arm/boot/dts/dra72-evm.dt.yaml
	arch/arm/boot/dts/dra72-evm-revc.dt.yaml
	arch/arm/boot/dts/dra7-evm.dt.yaml

mcasp@0: clocks: [[92, 396, 0], [92, 396, 24]] is too long
	arch/arm/boot/dts/am571x-idk.dt.yaml
	arch/arm/boot/dts/am5729-beagleboneai.dt.yaml
	arch/arm/boot/dts/am572x-idk.dt.yaml
	arch/arm/boot/dts/am574x-idk.dt.yaml
	arch/arm/boot/dts/am57xx-beagle-x15.dt.yaml
	arch/arm/boot/dts/am57xx-beagle-x15-revb1.dt.yaml
	arch/arm/boot/dts/am57xx-beagle-x15-revc.dt.yaml
	arch/arm/boot/dts/am57xx-cl-som-am57x.dt.yaml
	arch/arm/boot/dts/am57xx-sbc-am57x.dt.yaml
	arch/arm/boot/dts/dra72-evm.dt.yaml
	arch/arm/boot/dts/dra72-evm-revc.dt.yaml
	arch/arm/boot/dts/dra7-evm.dt.yaml

mcasp@0: clocks: [[92, 504, 0], [92, 504, 24]] is too long
	arch/arm/boot/dts/am571x-idk.dt.yaml
	arch/arm/boot/dts/am5729-beagleboneai.dt.yaml
	arch/arm/boot/dts/am572x-idk.dt.yaml
	arch/arm/boot/dts/am574x-idk.dt.yaml
	arch/arm/boot/dts/am57xx-beagle-x15.dt.yaml
	arch/arm/boot/dts/am57xx-beagle-x15-revb1.dt.yaml
	arch/arm/boot/dts/am57xx-beagle-x15-revc.dt.yaml
	arch/arm/boot/dts/am57xx-cl-som-am57x.dt.yaml
	arch/arm/boot/dts/am57xx-sbc-am57x.dt.yaml
	arch/arm/boot/dts/dra72-evm.dt.yaml
	arch/arm/boot/dts/dra72-evm-revc.dt.yaml
	arch/arm/boot/dts/dra7-evm.dt.yaml

mcasp@0: clocks: [[92, 508, 0], [92, 508, 24]] is too long
	arch/arm/boot/dts/am571x-idk.dt.yaml
	arch/arm/boot/dts/am5729-beagleboneai.dt.yaml
	arch/arm/boot/dts/am572x-idk.dt.yaml
	arch/arm/boot/dts/am574x-idk.dt.yaml
	arch/arm/boot/dts/am57xx-beagle-x15.dt.yaml
	arch/arm/boot/dts/am57xx-beagle-x15-revb1.dt.yaml
	arch/arm/boot/dts/am57xx-beagle-x15-revc.dt.yaml
	arch/arm/boot/dts/am57xx-cl-som-am57x.dt.yaml
	arch/arm/boot/dts/am57xx-sbc-am57x.dt.yaml
	arch/arm/boot/dts/dra72-evm.dt.yaml
	arch/arm/boot/dts/dra72-evm-revc.dt.yaml
	arch/arm/boot/dts/dra7-evm.dt.yaml

mcasp@0: clocks: [[94, 340, 0], [157, 0, 24], [94, 340, 28]] is too long
	arch/arm/boot/dts/dra76-evm.dt.yaml

mcasp@0: clocks: [[94, 348, 0], [94, 348, 24]] is too long
	arch/arm/boot/dts/dra76-evm.dt.yaml

mcasp@0: clocks: [[94, 364, 0], [94, 364, 24]] is too long
	arch/arm/boot/dts/dra76-evm.dt.yaml

mcasp@0: clocks: [[94, 388, 0], [94, 388, 24]] is too long
	arch/arm/boot/dts/dra76-evm.dt.yaml

mcasp@0: clocks: [[94, 396, 0], [94, 396, 24]] is too long
	arch/arm/boot/dts/dra76-evm.dt.yaml

mcasp@0: clocks: [[94, 504, 0], [94, 504, 24]] is too long
	arch/arm/boot/dts/dra76-evm.dt.yaml

mcasp@0: clocks: [[94, 508, 0], [94, 508, 24]] is too long
	arch/arm/boot/dts/dra76-evm.dt.yaml

mcasp@0: dma-names: ['tx'] is too short
	arch/arm/boot/dts/omap4-droid4-xt894.dt.yaml
	arch/arm/boot/dts/omap4-droid-bionic-xt875.dt.yaml
	arch/arm/boot/dts/omap4-duovero-parlor.dt.yaml
	arch/arm/boot/dts/omap4-kc1.dt.yaml
	arch/arm/boot/dts/omap4-panda-a4.dt.yaml
	arch/arm/boot/dts/omap4-panda.dt.yaml
	arch/arm/boot/dts/omap4-panda-es.dt.yaml
	arch/arm/boot/dts/omap4-sdp.dt.yaml
	arch/arm/boot/dts/omap4-sdp-es23plus.dt.yaml
	arch/arm/boot/dts/omap4-var-dvk-om44.dt.yaml
	arch/arm/boot/dts/omap4-var-stk-om44.dt.yaml

mcasp@0: dmas: [[119, 8]] is too short
	arch/arm/boot/dts/omap4-droid4-xt894.dt.yaml
	arch/arm/boot/dts/omap4-droid-bionic-xt875.dt.yaml
	arch/arm/boot/dts/omap4-kc1.dt.yaml

mcasp@0: dmas: [[124, 8]] is too short
	arch/arm/boot/dts/omap4-duovero-parlor.dt.yaml

mcasp@0: dmas: [[127, 8]] is too short
	arch/arm/boot/dts/omap4-panda-a4.dt.yaml
	arch/arm/boot/dts/omap4-panda.dt.yaml
	arch/arm/boot/dts/omap4-sdp.dt.yaml
	arch/arm/boot/dts/omap4-sdp-es23plus.dt.yaml

mcasp@0: dmas: [[130, 8]] is too short
	arch/arm/boot/dts/omap4-var-dvk-om44.dt.yaml
	arch/arm/boot/dts/omap4-var-stk-om44.dt.yaml

mcasp@0: dmas: [[132, 8]] is too short
	arch/arm/boot/dts/omap4-panda-es.dt.yaml

mcasp@0: interrupt-names: ['tx'] is too short
	arch/arm/boot/dts/omap4-droid4-xt894.dt.yaml
	arch/arm/boot/dts/omap4-droid-bionic-xt875.dt.yaml
	arch/arm/boot/dts/omap4-duovero-parlor.dt.yaml
	arch/arm/boot/dts/omap4-kc1.dt.yaml
	arch/arm/boot/dts/omap4-panda-a4.dt.yaml
	arch/arm/boot/dts/omap4-panda.dt.yaml
	arch/arm/boot/dts/omap4-panda-es.dt.yaml
	arch/arm/boot/dts/omap4-sdp.dt.yaml
	arch/arm/boot/dts/omap4-sdp-es23plus.dt.yaml
	arch/arm/boot/dts/omap4-var-dvk-om44.dt.yaml
	arch/arm/boot/dts/omap4-var-stk-om44.dt.yaml

mcasp@0: interrupts: [[0, 109, 4]] is too short
	arch/arm/boot/dts/omap4-droid4-xt894.dt.yaml
	arch/arm/boot/dts/omap4-droid-bionic-xt875.dt.yaml
	arch/arm/boot/dts/omap4-duovero-parlor.dt.yaml
	arch/arm/boot/dts/omap4-kc1.dt.yaml
	arch/arm/boot/dts/omap4-panda-a4.dt.yaml
	arch/arm/boot/dts/omap4-panda.dt.yaml
	arch/arm/boot/dts/omap4-panda-es.dt.yaml
	arch/arm/boot/dts/omap4-sdp.dt.yaml
	arch/arm/boot/dts/omap4-sdp-es23plus.dt.yaml
	arch/arm/boot/dts/omap4-var-dvk-om44.dt.yaml
	arch/arm/boot/dts/omap4-var-stk-om44.dt.yaml

mcasp@0: 'num-serializer' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/am335x-cm-t335.dt.yaml
	arch/arm/boot/dts/am335x-sbc-t335.dt.yaml

mcasp@0: 'port' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/am335x-sl50.dt.yaml

mcasp@0: 'rt-num-evt' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/am335x-wega-rdk.dt.yaml

mcasp@100000: interrupt-names:0: 'tx' was expected
	arch/arm/boot/dts/da850-enbw-cmc.dt.yaml
	arch/arm/boot/dts/da850-evm.dt.yaml
	arch/arm/boot/dts/da850-lcdk.dt.yaml
	arch/arm/boot/dts/da850-lego-ev3.dt.yaml

mcasp@100000: interrupt-names: ['common'] is too short
	arch/arm/boot/dts/da850-enbw-cmc.dt.yaml
	arch/arm/boot/dts/da850-evm.dt.yaml
	arch/arm/boot/dts/da850-lcdk.dt.yaml
	arch/arm/boot/dts/da850-lego-ev3.dt.yaml

mcasp@100000: interrupts: [[54]] is too short
	arch/arm/boot/dts/da850-enbw-cmc.dt.yaml
	arch/arm/boot/dts/da850-evm.dt.yaml
	arch/arm/boot/dts/da850-lcdk.dt.yaml
	arch/arm/boot/dts/da850-lego-ev3.dt.yaml

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

