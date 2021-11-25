Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1603445E27F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 22:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351215AbhKYVbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 16:31:46 -0500
Received: from mail-ot1-f52.google.com ([209.85.210.52]:46054 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243987AbhKYV3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 16:29:41 -0500
Received: by mail-ot1-f52.google.com with SMTP id a23-20020a9d4717000000b0056c15d6d0caso11133731otf.12;
        Thu, 25 Nov 2021 13:26:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=enKrWb01zIUlLDcWec9IsDV9nL4gjphxHjIfLcnFxNM=;
        b=r+QTI4KYThx9maxZkYcqHI9stnXA1nTj3vyGYVJpxsk21ZRteG1HK880u/RS3aKYLi
         YcXrRhQrsHRUtKc8EQRfesMvp/begc9Q4OC6Gs5xhtOYAhsheTvsYW8ncKx9Rf0pNm94
         1ms4QQdlP6EaZQ4Cd4QbswHjGQP0KKza0LFUyW65BJJ8UYnivkZ91fE8a0vjNzVfxU2F
         thZwgtzOu1/D/tsthYF/fafkTww0RVfU649cabxNFx32riyaG9zdgXElTc/ZMnTqZIM8
         uy5DUeNcbfs1xbQBvPxESwQXpJHtPmy7IBCp6KvPZCho4nqHVBQFkqOwS1ggW5Hwi3M1
         Jjfg==
X-Gm-Message-State: AOAM533wwgLn6vFSKnVI2CJ0L/rwuyTsk8GeTWcSWlHjixXutYslGaRZ
        izLniblSA2ietm7pPrH2gQ==
X-Google-Smtp-Source: ABdhPJzC8WF3V4q4Zkszhtmy5n3Ib8vaC3VBok3QPb6dv92gkCyEe7pE4+MBOF2mLf3L8Jo3yfdidQ==
X-Received: by 2002:a05:6830:25d6:: with SMTP id d22mr24856709otu.87.1637875589845;
        Thu, 25 Nov 2021 13:26:29 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id z8sm654248oot.7.2021.11.25.13.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 13:26:29 -0800 (PST)
Received: (nullmailer pid 2858315 invoked by uid 1000);
        Thu, 25 Nov 2021 21:26:02 -0000
From:   Rob Herring <robh@kernel.org>
To:     Jayesh Choudhary <j-choudhary@ti.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
In-Reply-To: <20211125121521.31554-1-j-choudhary@ti.com>
References: <20211125121521.31554-1-j-choudhary@ti.com>
Subject: Re: [PATCH v2] ASoC: dt-bindings: davinci-mcasp: convert McASP bindings to yaml schema
Date:   Thu, 25 Nov 2021 14:26:02 -0700
Message-Id: <1637875562.316639.2858314.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Nov 2021 17:45:21 +0530, Jayesh Choudhary wrote:
> Convert the bindings for McASP controllers for TI SOCs
> from txt to YAML schema.
> 
> Adds additional properties 'clocks', 'clock-names', 'power-domains'
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
> v2:
> - changes the commit message
> - modifies the properties 'clocks', 'clock-names', 'dma-names',
>   'dmas', 'interrupts' and 'interrupt-names' according to the
>   arm SOCs
> - adds 'port' and 'num-serializer' as node properties.
> 
>  .../bindings/sound/davinci-mcasp-audio.txt    |  86 ---------
>  .../bindings/sound/davinci-mcasp-audio.yaml   | 179 ++++++++++++++++++
>  2 files changed, 179 insertions(+), 86 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/davinci-mcasp-audio.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.yaml: properties:clock-names: {'minItems': 1, 'maxItems': 3, 'items': [{'const': 'fck'}, {'const': 'ahclkx'}, {'const': 'ahclkr'}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.yaml: ignoring, error in schema: properties: clock-names
warning: no schema found in file: ./Documentation/devicetree/bindings/sound/davinci-mcasp-audio.yaml
Documentation/devicetree/bindings/sound/davinci-mcasp-audio.example.dt.yaml:0:0: /example-0/mcasp0@1d00000: failed to match any schema with compatible: ['ti,da830-mcasp-audio']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1559662

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

