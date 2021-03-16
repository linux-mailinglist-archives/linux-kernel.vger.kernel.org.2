Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C730B33DB95
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 18:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239436AbhCPRy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 13:54:59 -0400
Received: from mail-il1-f170.google.com ([209.85.166.170]:40260 "EHLO
        mail-il1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235046AbhCPRyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 13:54:22 -0400
Received: by mail-il1-f170.google.com with SMTP id e7so13504292ile.7;
        Tue, 16 Mar 2021 10:54:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=+kI9PWgxxjp5TX4kZseCNqfbTJcpurWf3Z5A5Al1nrg=;
        b=LhdZQXCYOgqYFqacJpRrnm9d9E973HifJEnt0+vSL/97U2fv0kr2im+mAXbVjIexST
         WeZJkE2/+5ofkRGgZj03fd5BgU+O9meCfJLdCCCTOSZqRdKqW/WFM36R66mz5Eu79WjX
         T4ncM8AWybmD0JRpSSe5zXMFHhYw5b42QaZg/1901d4XWDGSO7y28h8PccD6EQPDCzNq
         R6jlsxKWf4qDQAYQj1xcB6KbPSdGciwcBEqwpy4Exc0C41hmAib6Jl/x6aRc5S2yUT2b
         nbjchAA8aNPpNRdUIUlZ1CoFMyVIiuUu69VyDbXgMHb2qoQDqgOdQdUnznK12AT8pgCK
         j7rw==
X-Gm-Message-State: AOAM531D1BO/fy8iSPFzkjztrgg3eDmbQvv1z1g9aMrsbCSct/SsJ1wx
        AF06jBxuKSRCituSOr0ygQ==
X-Google-Smtp-Source: ABdhPJzj4jwke+G26mZFGHSOiXxtNewCW2IJj+QfJpWnFbUQSSzi2iviqzwbAWxsbu9ZU1nAgGlJbQ==
X-Received: by 2002:a05:6e02:b25:: with SMTP id e5mr4852271ilu.119.1615917261431;
        Tue, 16 Mar 2021 10:54:21 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id h128sm8978507ioa.32.2021.03.16.10.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 10:54:21 -0700 (PDT)
Received: (nullmailer pid 3326127 invoked by uid 1000);
        Tue, 16 Mar 2021 17:54:09 -0000
From:   Rob Herring <robh@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org
In-Reply-To: <20210316105828.16436-2-srinivas.kandagatla@linaro.org>
References: <20210316105828.16436-1-srinivas.kandagatla@linaro.org> <20210316105828.16436-2-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 1/7] ASoC: dt-bindings: wcd938x: add bindings for wcd938x
Date:   Tue, 16 Mar 2021 11:54:09 -0600
Message-Id: <1615917249.257390.3326126.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Mar 2021 10:58:22 +0000, Srinivas Kandagatla wrote:
> Qualcomm WCD9380/WCD9385 Codec is a standalone Hi-Fi audio codec IC
> connected over SoundWire. This device has two SoundWire device RX and
> TX respectively, supporting 4 x ADCs, ClassH, Ear, Aux PA, 2xHPH,
> 7 x TX diff inputs, 8 DMICs, MBHC.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../bindings/sound/qcom,wcd938x.yaml          | 127 ++++++++++++++++++
>  1 file changed, 127 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml: properties:qcom,mbhc-vthreshold-microvolt: 'anyOf' conditional failed, one must be fixed:
	'$ref' is not one of ['maxItems', 'description', 'deprecated']
	'minItems' is not one of ['maxItems', 'description', 'deprecated']
	Additional properties are not allowed ('$ref' was unexpected)
	'minItems' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'multipleOf', 'default', '$ref']
	'maxItems' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'multipleOf', 'default', '$ref']
	1 was expected
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml: ignoring, error in schema: properties: qcom,mbhc-vthreshold-microvolt
warning: no schema found in file: ./Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml

See https://patchwork.ozlabs.org/patch/1453827

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

