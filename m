Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEC3A380A23
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 15:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233899AbhENNIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 09:08:16 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:33311 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbhENNIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 09:08:15 -0400
Received: by mail-ot1-f52.google.com with SMTP id i23-20020a9d68d70000b02902dc19ed4c15so22395329oto.0;
        Fri, 14 May 2021 06:07:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=xGVTJIe3IpvtYlWDXjmgrXNvgrVnvtut7WrcSggOBcA=;
        b=jCGKJHKqhEgKaRVT788cFKFKT77BNgKipRH//LXvb0zaTjJ0Z9QnKQx67nnPD9Z9nc
         OXbLPfkj6HxrfwyXHpG+A5RJoIPTckPwXeia4b+DT1BzR7ZZummwzN52rFt/5Vhu/9mm
         RcbprDDD/Os/MOkXpFphrk001KENtXc8TNyzmStHdXOex1cAOYKd99FWOtlFaMLQwR6f
         GVVSSIh4rmqaHggfecZH5zOJAgUzHvq0osSExAA3uegPbwbjL7Nl4jdlGd7RloFOeeAg
         fuVDkvSFcO/SPHOn9NGI3A+i1amoQ6n/s8dzVmMNODyL6A8mV0EkFcDA4mBcEPXw1zJ6
         rI3A==
X-Gm-Message-State: AOAM530r5cfMx00mTQbKPNGSgniBdlx135NQ6zjbk3AlryjaC9LZNTsv
        738zF1sZ0uX0D9F/L1gup95SaN4iQA==
X-Google-Smtp-Source: ABdhPJwqX2eYj0l12uVBWQ1hPm0AcmqocVEheIW3yuo8nFdY+rUt4unWcqrsga7ds2xsj4uzighyzA==
X-Received: by 2002:a9d:4911:: with SMTP id e17mr39944015otf.38.1620997622254;
        Fri, 14 May 2021 06:07:02 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d207sm1262089oob.7.2021.05.14.06.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 06:07:01 -0700 (PDT)
Received: (nullmailer pid 3936696 invoked by uid 1000);
        Fri, 14 May 2021 13:06:56 -0000
From:   Rob Herring <robh@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        broonie@kernel.org
In-Reply-To: <20210514103405.29927-2-srinivas.kandagatla@linaro.org>
References: <20210514103405.29927-1-srinivas.kandagatla@linaro.org> <20210514103405.29927-2-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v5 1/9] ASoC: dt-bindings: wcd938x: add bindings for wcd938x
Date:   Fri, 14 May 2021 08:06:56 -0500
Message-Id: <1620997616.615521.3936695.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 May 2021 11:33:57 +0100, Srinivas Kandagatla wrote:
> Qualcomm WCD9380/WCD9385 Codec is a standalone Hi-Fi audio codec IC
> connected over SoundWire. This device has two SoundWire device RX and
> TX respectively, supporting 4 x ADCs, ClassH, Ear, Aux PA, 2xHPH,
> 7 x TX diff inputs, 8 DMICs, MBHC.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../bindings/sound/qcom,wcd938x.yaml          | 149 ++++++++++++++++++
>  1 file changed, 149 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml: properties:qcom,mbhc-buttons-vthreshold-microvolt: 'anyOf' conditional failed, one must be fixed:
	'$ref' is not one of ['maxItems', 'description', 'deprecated']
		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
	'minItems' is not one of ['maxItems', 'description', 'deprecated']
		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
	Additional properties are not allowed ('$ref' was unexpected)
		hint: Arrays must be described with a combination of minItems/maxItems/items
	'minItems' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'multipleOf', 'default', '$ref']
	'maxItems' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'multipleOf', 'default', '$ref']
	1 was expected
		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
	hint: cell array properties must define how many entries and what the entries are when there is more than one entry.
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml: ignoring, error in schema: properties: qcom,mbhc-buttons-vthreshold-microvolt
warning: no schema found in file: ./Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml
Documentation/devicetree/bindings/sound/qcom,wcd938x.example.dt.yaml:0:0: /example-0/codec: failed to match any schema with compatible: ['qcom,wcd9380-codec']

See https://patchwork.ozlabs.org/patch/1478395

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

