Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2C13EB509
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 14:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240215AbhHMMLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 08:11:42 -0400
Received: from mail-oo1-f51.google.com ([209.85.161.51]:36803 "EHLO
        mail-oo1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234931AbhHMMLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 08:11:36 -0400
Received: by mail-oo1-f51.google.com with SMTP id z3-20020a4a98430000b029025f4693434bso2761956ooi.3;
        Fri, 13 Aug 2021 05:11:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=ps4tCQWbTi6z/V7wGtvsWtnsQ5EYuhPhIq8rzt6bzE4=;
        b=Aq2VGJqxYsIinCO5CRbE0JrSwLM/rIiA9h0s/VyI4omiT3X0ZDU3wxrH1Sm0XmkwYu
         a2xOU2NN3A7Izgj+g2sL3gLlAoyYx6T+B/9Reu4Q1Q8+MnLNDA4Qz5HsYSHbicbL/Ble
         Vc4QzDfSGjcPQ1njZQ4P+uK97Uw453cAfU/LMiWvLxGDa4ZUiR4a3X29yvm07QmcxM4z
         vCcy4SUllZ6KZ135xMUEBXpIEmsG5MR807p6Wog8PNg6uNdt8WhXQBOE2eMtEJFNiXRN
         cUR5/9PeXBA/dAZpIN67rQTx5IG8m4/0zwt0VrYMzGtnXyOMTvs8+7h53Th7OqMsJ53a
         RIfg==
X-Gm-Message-State: AOAM531i6u1MlxOhZGoLsHXi5g/pkhn0q6vUcnEBtbqlbszwO8FJWoje
        inNzVCmdTmA7CW/mT6IMgA==
X-Google-Smtp-Source: ABdhPJwuIzkX42L0KTTWBHJtcuxFY3LWdAixHSSKk0PTOYOGYALNAcw18EaE0c2vkDehFT2Tm+X/aw==
X-Received: by 2002:a05:6820:203:: with SMTP id i3mr1615478oob.53.1628856669235;
        Fri, 13 Aug 2021 05:11:09 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z21sm262122oto.46.2021.08.13.05.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 05:11:08 -0700 (PDT)
Received: (nullmailer pid 3179072 invoked by uid 1000);
        Fri, 13 Aug 2021 12:11:07 -0000
From:   Rob Herring <robh@kernel.org>
To:     Bhaskara Budiredla <bbudiredla@marvell.com>
Cc:     will@kernel.org, linux-arm-kernel@lists.infradead.org,
        mark.rutland@arm.com, sgoutham@marvell.com,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210812174209.1970-3-bbudiredla@marvell.com>
References: <20210812174209.1970-1-bbudiredla@marvell.com> <20210812174209.1970-3-bbudiredla@marvell.com>
Subject: Re: [PATCH 2/2] dt-bindings: perf: Add YAML schemas for Marvell CN10K LLC-TAD pmu bindings
Date:   Fri, 13 Aug 2021 07:11:07 -0500
Message-Id: <1628856667.648308.3179071.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Aug 2021 23:12:09 +0530, Bhaskara Budiredla wrote:
> Add device tree bindings for Last-level-cache Tag-and-data
> (LLC-TAD) unit PMU for Marvell CN10K SoCs.
> 
> Signed-off-by: Bhaskara Budiredla <bbudiredla@marvell.com>
> ---
>  .../bindings/perf/marvell-cn10k-tad.yaml      | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/perf/marvell-cn10k-tad.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/perf/marvell-cn10k-tad.example.dts:19.32-25.11: Warning (unit_address_format): /example-0/tad_pmu@0x87e280000000: unit name should not have leading "0x"
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/perf/marvell-cn10k-tad.example.dt.yaml: example-0: tad_pmu@0x87e280000000:reg:0: [34786, 2147483648, 0, 4096] is too long
	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/perf/marvell-cn10k-tad.example.dt.yaml: example-0: 'tad_pmu@0x87e280000000' does not match any of the regexes: '.*-names$', '.*-supply$', '^#.*-cells$', '^#[a-zA-Z0-9,+\\-._]{0,63}$', '^[a-zA-Z][a-zA-Z0-9,+\\-._]{0,63}$', '^[a-zA-Z][a-zA-Z0-9,+\\-._]{0,63}@[0-9a-fA-F]+(,[0-9a-fA-F]+)*$', '^__.*__$', 'pinctrl-[0-9]+'
	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/dt-core.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/perf/marvell-cn10k-tad.example.dt.yaml: tad_pmu@0x87e280000000: 'tad-cnt', 'tad-page-size', 'tad-pmu-page-size' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/perf/marvell-cn10k-tad.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1516395

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

