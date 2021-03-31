Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B556350203
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 16:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235994AbhCaOQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 10:16:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:59938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235948AbhCaOQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 10:16:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8374560FEA;
        Wed, 31 Mar 2021 14:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617200197;
        bh=eL91uyDgEVR7LcPESV3BoTdsM+880ShbnILq99ubHig=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ffAuPYk7iWufAbgh+MbeMY9VAnT6lFxFK7C5cHXY+nXJJk59UD1vUoloU46zmcoSw
         Hy9jwaGy26ZoqFwsOMIQlf/+LISy7fN72VIx2yVp8iOXc7Iqwq1fhG3jm4P1JaCzvX
         K9ZqiS8IGGEnHAZ3ssIJ4xIPkzDFd7Rimo32pgj3POHlsqrjsRzpOXw3QKZZAKEHoZ
         Wj79pyaYaxIdVBIxmrnBMCAvDZk16NXkYnvVLK0JqkZMB+bYXbehEWHU2pwMO7kM2G
         SU1u+xeo6fsCdPjKOVGhu6xReytWfqUBb4So+I/r5ripJ/DCXHIFh5nhAos4Va4OeT
         ET6V58uSSH4dg==
Received: by mail-ej1-f49.google.com with SMTP id hq27so30300376ejc.9;
        Wed, 31 Mar 2021 07:16:37 -0700 (PDT)
X-Gm-Message-State: AOAM533IBvNBUq4HgkaWmLSekiJOvqOiELvdyx2ZRnrtNRsPXxdoz7VP
        ZdfXM3j6RcwwqyOm/TVBXP1GIWODQVSZrFW/Mg==
X-Google-Smtp-Source: ABdhPJzejcI3xzmZROqjlnBx1vvqU0QBzSUUdnWfIjLGXf048kmTMHFktdrHEhXvDIFX0KiSYxvRaQ/o7vvnbbw1RAY=
X-Received: by 2002:a17:906:7f84:: with SMTP id f4mr3647628ejr.525.1617200195984;
 Wed, 31 Mar 2021 07:16:35 -0700 (PDT)
MIME-Version: 1.0
References: <1615383186-18500-1-git-send-email-argus.lin@mediatek.com> <1615383186-18500-2-git-send-email-argus.lin@mediatek.com>
In-Reply-To: <1615383186-18500-2-git-send-email-argus.lin@mediatek.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 31 Mar 2021 09:16:06 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL-TvUZOZ8Eev5zrq2aA59SLLEMVV3Ypq-07bNccp=NRw@mail.gmail.com>
Message-ID: <CAL_JsqL-TvUZOZ8Eev5zrq2aA59SLLEMVV3Ypq-07bNccp=NRw@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] dt-bindings: mediatek: mt6359: add ASoC mt6359
 ASoC accdet jack document
To:     Argus Lin <argus.lin@mediatek.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Arnd Bergmann <arnd@arndb.de>, Jack Yu <jack.yu@realtek.com>,
        Shuming Fan <shumingf@realtek.com>,
        Dan Murphy <dmurphy@ti.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        "Shane.Chien" <shane.chien@mediatek.com>,
        Chipeng Chang <chipeng.chang@mediatek.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 7:33 AM Argus Lin <argus.lin@mediatek.com> wrote:
>
> This patch adds MediaTek MT6359 ASoC accdet jack document.

Seems this never made it to the DT list so no checks ran. It's got all
sorts of errors:

/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/sound/mt6359-accdet.yaml:
properties:mediatek,four-key-thr: 'oneOf' conditional failed, one must
be fixed:
 'type' is a required property
 Additional properties are not allowed ('maxItems' was unexpected)
/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/sound/mt6359-accdet.yaml:
properties:mediatek,four-key-thr: 'oneOf' conditional failed, one must
be fixed:
 'enum' is a required property
 'const' is a required property
/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/sound/mt6359-accdet.yaml:
properties:mediatek,four-key-thr: 'oneOf' conditional failed, one must
be fixed:
 '$ref' is a required property
 'allOf' is a required property
/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/sound/mt6359-accdet.yaml:
properties:mediatek,accdet-name: 'oneOf' conditional failed, one must
be fixed:
 'type' is a required property
 Additional properties are not allowed ('maxItems' was unexpected)
/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/sound/mt6359-accdet.yaml:
properties:mediatek,accdet-name: 'oneOf' conditional failed, one must
be fixed:
 'enum' is a required property
 'const' is a required property
/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/sound/mt6359-accdet.yaml:
properties:mediatek,accdet-name: 'oneOf' conditional failed, one must
be fixed:
 '$ref' is a required property
 'allOf' is a required property
/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/sound/mt6359-accdet.yaml:
properties:mediatek,eint-use-ext-res: 'oneOf' conditional failed, one
must be fixed:
 'type' is a required property
 Additional properties are not allowed ('maxItems' was unexpected)
/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/sound/mt6359-accdet.yaml:
properties:mediatek,eint-use-ext-res: 'oneOf' conditional failed, one
must be fixed:
 'enum' is a required property
 'const' is a required property
/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/sound/mt6359-accdet.yaml:
properties:mediatek,eint-use-ext-res: 'oneOf' conditional failed, one
must be fixed:
 '$ref' is a required property
 'allOf' is a required property
/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/sound/mt6359-accdet.yaml:
properties:mediatek,tri-key-cdd-thr: 'oneOf' conditional failed, one
must be fixed:
 'type' is a required property
 Additional properties are not allowed ('maxItems' was unexpected)
/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/sound/mt6359-accdet.yaml:
properties:mediatek,tri-key-cdd-thr: 'oneOf' conditional failed, one
must be fixed:
 'enum' is a required property
 'const' is a required property
/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/sound/mt6359-accdet.yaml:
properties:mediatek,tri-key-cdd-thr: 'oneOf' conditional failed, one
must be fixed:
 '$ref' is a required property
 'allOf' is a required property
/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/sound/mt6359-accdet.yaml:
properties:mediatek,pwm-deb-setting: 'oneOf' conditional failed, one
must be fixed:
 'type' is a required property
 Additional properties are not allowed ('maxItems' was unexpected)
/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/sound/mt6359-accdet.yaml:
properties:mediatek,pwm-deb-setting: 'oneOf' conditional failed, one
must be fixed:
 'enum' is a required property
 'const' is a required property
/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/sound/mt6359-accdet.yaml:
properties:mediatek,pwm-deb-setting: 'oneOf' conditional failed, one
must be fixed:
 '$ref' is a required property
 'allOf' is a required property
/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/sound/mt6359-accdet.yaml:
properties:mediatek,eint-num: 'oneOf' conditional failed, one must be
fixed:
 'type' is a required property
 Additional properties are not allowed ('maxItems' was unexpected)
/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/sound/mt6359-accdet.yaml:
properties:mediatek,eint-num: 'oneOf' conditional failed, one must be
fixed:
 'enum' is a required property
 'const' is a required property
/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/sound/mt6359-accdet.yaml:
properties:mediatek,eint-num: 'oneOf' conditional failed, one must be
fixed:
 '$ref' is a required property
 'allOf' is a required property
/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/sound/mt6359-accdet.yaml:
properties:mediatek,mic-vol: 'oneOf' conditional failed, one must be
fixed:
 'type' is a required property
 Additional properties are not allowed ('maxItems' was unexpected)
/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/sound/mt6359-accdet.yaml:
properties:mediatek,mic-vol: 'oneOf' conditional failed, one must be
fixed:
 'enum' is a required property
 'const' is a required property
/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/sound/mt6359-accdet.yaml:
properties:mediatek,mic-vol: 'oneOf' conditional failed, one must be
fixed:
 '$ref' is a required property
 'allOf' is a required property
/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/sound/mt6359-accdet.yaml:
properties:mediatek,eint-trig-mode: 'oneOf' conditional failed, one
must be fixed:
 'type' is a required property
 Additional properties are not allowed ('maxItems' was unexpected)
/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/sound/mt6359-accdet.yaml:
properties:mediatek,eint-trig-mode: 'oneOf' conditional failed, one
must be fixed:
 'enum' is a required property
 'const' is a required property
/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/sound/mt6359-accdet.yaml:
properties:mediatek,eint-trig-mode: 'oneOf' conditional failed, one
must be fixed:
 '$ref' is a required property
 'allOf' is a required property
/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/sound/mt6359-accdet.yaml:
properties:mediatek,three-key-thr: 'oneOf' conditional failed, one
must be fixed:
 'type' is a required property
 Additional properties are not allowed ('maxItems' was unexpected)
/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/sound/mt6359-accdet.yaml:
properties:mediatek,three-key-thr: 'oneOf' conditional failed, one
must be fixed:
 'enum' is a required property
 'const' is a required property
/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/sound/mt6359-accdet.yaml:
properties:mediatek,three-key-thr: 'oneOf' conditional failed, one
must be fixed:
 '$ref' is a required property
 'allOf' is a required property
/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/sound/mt6359-accdet.yaml:
properties:mediatek,key-mode: 'oneOf' conditional failed, one must be
fixed:
 'type' is a required property
 Additional properties are not allowed ('maxItems' was unexpected)
/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/sound/mt6359-accdet.yaml:
properties:mediatek,key-mode: 'oneOf' conditional failed, one must be
fixed:
 'enum' is a required property
 'const' is a required property
/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/sound/mt6359-accdet.yaml:
properties:mediatek,key-mode: 'oneOf' conditional failed, one must be
fixed:
 '$ref' is a required property
 'allOf' is a required property
/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/sound/mt6359-accdet.yaml:
properties:mediatek,eint-comp-vth: 'oneOf' conditional failed, one
must be fixed:
 'type' is a required property
 Additional properties are not allowed ('maxItems' was unexpected)
/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/sound/mt6359-accdet.yaml:
properties:mediatek,eint-comp-vth: 'oneOf' conditional failed, one
must be fixed:
 'enum' is a required property
 'const' is a required property
/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/sound/mt6359-accdet.yaml:
properties:mediatek,eint-comp-vth: 'oneOf' conditional failed, one
must be fixed:
 '$ref' is a required property
/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/sound/mt6359-accdet.yaml:
properties:mediatek,eint-use-ap: 'oneOf' conditional failed, one must
be fixed:
 'type' is a required property
 Additional properties are not allowed ('maxItems' was unexpected)
/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/sound/mt6359-accdet.yaml:
properties:mediatek,eint-use-ap: 'oneOf' conditional failed, one must
be fixed:
 'enum' is a required property
 'const' is a required property
/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/sound/mt6359-accdet.yaml:
properties:mediatek,eint-use-ap: 'oneOf' conditional failed, one must
be fixed:
 '$ref' is a required property
 'allOf' is a required property
/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/sound/mt6359-accdet.yaml:
properties:mediatek,mic-mode: 'oneOf' conditional failed, one must be
fixed:
 'type' is a required property
 Additional properties are not allowed ('maxItems' was unexpected)
/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/sound/mt6359-accdet.yaml:
properties:mediatek,mic-mode: 'oneOf' conditional failed, one must be
fixed:
 'enum' is a required property
 'const' is a required property
/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/sound/mt6359-accdet.yaml:
properties:mediatek,mic-mode: 'oneOf' conditional failed, one must be
fixed:
 '$ref' is a required property
 'allOf' is a required property
/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/sound/mt6359-accdet.yaml:
properties:mediatek,eint-detect-mode: 'oneOf' conditional failed, one
must be fixed:
 'type' is a required property
 Additional properties are not allowed ('maxItems' was unexpected)
/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/sound/mt6359-accdet.yaml:
properties:mediatek,eint-detect-mode: 'oneOf' conditional failed, one
must be fixed:
 'enum' is a required property
 'const' is a required property
/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/sound/mt6359-accdet.yaml:
properties:mediatek,eint-detect-mode: 'oneOf' conditional failed, one
must be fixed:
 '$ref' is a required property
 'allOf' is a required property


> Signed-off-by: Argus Lin <argus.lin@mediatek.com>
> ---
>  .../bindings/sound/mt6359-accdet.yaml         | 164 ++++++++++++++++++
>  1 file changed, 164 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/mt6359-accdet.yaml
>
> diff --git a/Documentation/devicetree/bindings/sound/mt6359-accdet.yaml b/Documentation/devicetree/bindings/sound/mt6359-accdet.yaml
> new file mode 100644
> index 000000000000..7fb3e8dfb4c5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/mt6359-accdet.yaml
> @@ -0,0 +1,164 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/mt6359-accdet.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mediatek Technologies Inc. MT6359 ASoC accdet jack driver bindings
> +
> +maintainers:
> +  - Chipeng Chang <chipeng.chang@mediatek.com>
> +
> +description: |
> +  This binding describes the Mediatek Technologies MT6359 ASoC
> +  accdet jack driver.
> +
> +properties:
> +  mediatek,accdet-name:
> +    maxItems: 1
> +    description: named as "mt6359-accdet" jack.

Sounds like a constraint. Why do you need this in DT if only 1 value?
And why expose an SoC specific name to userspace (I guess)?

> +
> +  mediatek,mic-vol:
> +    maxItems: 1

This is an array because 'maxItems' is for arrays? It needs a type
reference. Same problem throughout.

> +    description: |
> +      accdet micbias1 voltage.
> +
> +      enum:

The indentation is wrong here, so this is just part of 'description'.

> +        - 0x00 # 1.7v - micbias1 volage is 1.7v.
> +        - 0x01 # 1.8v - micbias1 volage is 1.8v.
> +        - 0x02 # 1.9v - micbias1 volage is 1.9v.
> +        - 0x03 # 2.0v - micbias1 volage is 2.0v.
> +        - 0x04 # 2.1v - micbias1 volage is 2.1v.
> +        - 0x05 # 2.5v - micbias1 volage is 2.5v.
> +        - 0x06 # 2.6v - micbias1 volage is 2.6v.
> +        - 0x07 # 2.7v - micbias1 volage is 2.7v.
> +        - 0x08 # 2.8v - micbias1 volage is 2.8v.
> +        - 0x09 # 2.85v - micbias1 volage is 2.85v.
> +
> +  mediatek,mic-mode:
> +    maxItems: 1
> +    description: |
> +      value as 1, 2, 6 to indicate ACC/DCC mode. default is DCC mode 2.
> +
> +      enum:
> +        - 0x01 # ACC - ACC mode.
> +        - 0x02 # DCC - low cost without in bias.
> +        - 0x06 # DCC - low cost with in bias.
> +
> +  mediatek,pwm-deb-setting:
> +    maxItems: 15
> +    description: |
> +       headset-mode-setting : Indicates customized pwm, debounce setting
> +       accdet pwm_width, pwm_thresh, fall_delay, rise_delay
> +       debounce0, debounce1, debounce3, debounce4
> +       eint pwm_width, eint pwm_thresh
> +       eint deb(debounce0, debounce1, debounce2, debounce3), inv_debounce.

This is a string?

> +
> +  mediatek,eint-use-ap:
> +    maxItems: 1
> +    description: |
> +      indicates to use ap gpio.
> +
> +      enum:
> +        - 0x00 # MT6359 eint detection mode.
> +        - 0x01 # SoC GPIO detection mode.

Would boolean work here?

> +
> +  mediatek,eint-detect-mode:
> +    maxItems: 1
> +    description: |
> +      indicates to use ap gpio.
> +
> +      enum:
> +        - 0x00 # detection mode with higher detection power.
> +        - 0x01 # detection mode with lower detection power.
> +        - 0x02 # detection mode with sw moisture detection mode.
> +        - 0x03 # detection mode with hw moisture detection mode1.
> +        - 0x04 # detection mode with hw moisture detection mode2.
> +
> +  mediatek,eint-num:
> +    maxItems: 1
> +    description: |
> +      incicates pmic eint usage.
> +
> +      enum:
> +        - 0x0 # PMIC_EINT0 - use pmic eint0 to trigger plug interrupt.
> +        - 0x1 # PMIC_EINT1 - use pmic eint1 to trigger plug interrupt.
> +        - 0x2 # PMIC_BI_EINT - use pmic eint0/1 to trigger plug interrupt.
> +
> +  mediatek,eint-trig-mode:
> +    maxItems: 1
> +    description: |
> +      incicates pmic eint trigger mode.
> +
> +      enum:
> +        - 0x0 # PMIC_GPIO - use pmic gpio to detect plug status.
> +        - 0x1 # PMIC_INVERTER - use pmic inverter to detect plug status.

Boolean instead?

> +
> +  mediatek,eint-use-ext-res:
> +    maxItems: 1
> +    description: |
> +      select HP_EINT pull up resistance, default 0 use internal resistance.
> +
> +      enum:
> +        - 0x0 # use internal resistor.
> +        - 0x1 # use external resistor.

Boolean?

> +
> +  mediatek,eint-comp-vth:
> +    maxItems: 1
> +    description: |
> +      indicates comparator detection voltage.
> +
> +      enum:
> +        - 0x00 # 2.8v.
> +        - 0x01 # 2.4v.
> +        - 0x02 # 2.0v.
> +        - 0x03 # 0.7v.
> +
> +  mediatek,key-mode:
> +    maxItems: 1
> +    description: |
> +      incicates key mode type.
> +
> +      enum:
> +        - 0x0 # THREE_KEY - support 3-key key mode.
> +        - 0x1 # FOUR_KEY - support 4-key key mode.
> +        - 0x2 # TRI_KEY_CDD - support 3-key google CDD key mode.
> +
> +  mediatek,three-key-thr:
> +    maxItems: 4
> +    description: |
> +      3 key device detection threshold: 0--MD_MAX--UP_MAX--DW_MAX.
> +
> +  mediatek,tri-key-cdd-thr:
> +    maxItems: 4
> +    description: |
> +      3 key CDD device detection threshold: 0--MD_MAX--UP_MAX--DW_MAX.
> +
> +  mediatek,four-key-thr:
> +    maxItems: 4
> +    description: |
> +      4 key device detection threshold: 0--MD_MAX--VOICE_MAX--UP_MAX--DW_MAX.
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    accdet: accdet {

Where does this node go? You've got no compatible, so it's a child of
something else?

> +        mediatek,accdet-name = "mt6359-accdet";
> +        mediatek,mic-vol = <8>;
> +        mediatek,mic-mode = <2>;
> +        mediatek,pwm-deb-setting = <0x500 0x500 1 0x1f0
> +                                    0x800 0x800 0x20 0x44
> +                                    0x4 0x1
> +                                    0x5 0x3 0x3 0x5 0xe>;
> +        mediatek,eint-use-ap = <0>;
> +        mediatek,eint-detect-mode = <4>;
> +        mediatek,eint-num = <0>;
> +        mediatek,eint-trig-mode = <1>;
> +        mediatek,eint-use-ext-res = <0>;
> +        mediatek,eint-comp-vth = <2>;
> +        mediatek,key-mode = <0>;
> +        mediatek,three-key-thr = <0 80 220 400>;
> +        status = "okay";

Don't show status in examples.

> +    };
> +...

> --
> 2.18.0
>
