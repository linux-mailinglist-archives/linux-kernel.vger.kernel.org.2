Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBAF23CA10C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 16:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238185AbhGOPC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 11:02:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:44926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232108AbhGOPC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 11:02:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0380A613C4;
        Thu, 15 Jul 2021 14:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626361175;
        bh=WMxp2mwdoS59oGTgmTOoatfl2kEPCVJQHmcJAPofolE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZBmp0De0rFI6Db5Ijr5HTiY9MlYZE8GbKeXRy88vvId1Pka3/KFbWGhadfkefsaxw
         TUuP0TpgkJr8bAZxOetm379o/n+g3Sh+ku01hioD6KxzgbFKX0Kz8tp6SHmJy3E2M1
         MPRM+eZ1eULpOUZq6U+JVgAm0I0vEt0jkp4e4xaz9UMaxsYyz0MdpGVAyq2JjE4KKy
         de5F19VOZsA+iNxYIJGqWSUZMjIlEaqMFp37/sZ3NX1pnvkw3aljXz865NXG7JLHr2
         I5G2WDPhsZwl89eKztyo3cjFLdl1MN1hC0f52w6+LdyFXlr9mnVcAzlg5eEL6hv1Am
         mmpnIop7GB5Xg==
Received: by mail-ed1-f47.google.com with SMTP id l1so8505142edr.11;
        Thu, 15 Jul 2021 07:59:34 -0700 (PDT)
X-Gm-Message-State: AOAM532IjvjdFAu2OU0wXbd34GqDHagGc9gf4+7H3suNJT9G88UR6ZkV
        uvEraTh/tMpeET26JsQwYySQIe67iHilNhCFHw==
X-Google-Smtp-Source: ABdhPJxVlRe46NOy1Ube4hjuFH34iW+65Ma8iQickH4l8U2hHk9BLGF4gQPCHr6bzZ9JPx4mTaQ83Em5YixfhRrxDE8=
X-Received: by 2002:aa7:cb19:: with SMTP id s25mr7688335edt.194.1626361173534;
 Thu, 15 Jul 2021 07:59:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210715141802.880911-1-daniel.baluta@oss.nxp.com> <20210715141802.880911-4-daniel.baluta@oss.nxp.com>
In-Reply-To: <20210715141802.880911-4-daniel.baluta@oss.nxp.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 15 Jul 2021 08:59:21 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+r0Tw46=iW8etyR9H=V7M+sE=dguqsEMm3R4B=Xg=qSA@mail.gmail.com>
Message-ID: <CAL_Jsq+r0Tw46=iW8etyR9H=V7M+sE=dguqsEMm3R4B=Xg=qSA@mail.gmail.com>
Subject: Re: [PATCH 3/3] dt-bindings: dsp: fsl: Document newly introduced fsl,properties
To:     Daniel Baluta <daniel.baluta@oss.nxp.com>
Cc:     Linux-ALSA <alsa-devel@alsa-project.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        kai.vehmanen@linux.intel.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Daniel Baluta <daniel.baluta@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2021 at 8:18 AM Daniel Baluta <daniel.baluta@oss.nxp.com> wrote:
>
> From: Daniel Baluta <daniel.baluta@nxp.com>
>
> Document firmware-name, tplg-name and machine-drv-name properties.

That's obvious from the diff.

Why do you need these?

>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  .../devicetree/bindings/dsp/fsl,dsp.yaml      | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml b/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
> index 7afc9f2be13a..8095aa178e7c 100644
> --- a/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
> +++ b/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
> @@ -60,6 +60,22 @@ properties:
>        used by DSP (see bindings/reserved-memory/reserved-memory.txt)
>      maxItems: 1
>
> +  firmware-name:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description:
> +      If present, name of the file within the firmware search path containing
> +      the DSP firmware loaded by SOF at DSP boot time.
> +
> +  tplg-name:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description:
> +      Should contain the audio topology file name loaded by SOF driver.

Is this some format the DSP requires? Why do we need a separate file?
This is defined by the board or user config?

> +
> +  machine-drv-name:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description:
> +      Contains the ASoC machine driver name used by SOF to handle DSP audio scenario.

Umm, no.

> +
>  required:
>    - compatible
>    - reg
> @@ -69,6 +85,8 @@ required:
>    - mboxes
>    - mbox-names
>    - memory-region
> +  - tplg-name
> +  - machine-drv-name
>
>  additionalProperties: false
>
> @@ -90,4 +108,6 @@ examples:
>          mbox-names = "txdb0", "txdb1", "rxdb0", "rxdb1";
>          mboxes = <&lsio_mu13 2 0>, <&lsio_mu13 2 1>, <&lsio_mu13 3 0>, <&lsio_mu13 3 1>;
>          memory-region = <&dsp_reserved>;
> +        tplg-name = "sof-imx8-wm8960.tplg";
> +        machine-drv-name = "asoc-simple-card";
>      };
> --
> 2.27.0
>
