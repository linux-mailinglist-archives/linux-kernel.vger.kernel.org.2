Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1F443A054D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 22:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234187AbhFHUxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 16:53:10 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:44608 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbhFHUxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 16:53:09 -0400
Received: by mail-ot1-f53.google.com with SMTP id q5-20020a9d66450000b02903f18d65089fso5477784otm.11;
        Tue, 08 Jun 2021 13:51:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=i5ca9j8lK8pgPSfrs5VSvC3JrrRJ8T082ZN3VrHz6Dk=;
        b=HfQNXHX8RX0CJ41Nk+k2qACqrQ+DdjI0H7InzembT2cZUZqvfauTDpLFV0vtpEXkV4
         aOKYHN3K0nOMW5nt+OVCo+by/au/OGxumGT63fqNv1Z9Z6L2IVtEqKkjgd4g6fC2xiq1
         vyN2TtBF88AaX/XFgc9Nhs7g4bVoXzQmeXiM0WDE+ZWMN1z9KtK+VlSsP+rgllRc5Pk/
         4q0xh4UB/CljTwmHM8001tc6SzxD3Vi0a3tv/ymHFE2OyM+P2QO3HjXVmrHRi9RDkLpY
         SqJCo5XFNsGvrBleH2AGhF9yYaf9AdZqzlBMub062SeUM4dfgbo1607NeLjGyF0Qwr9R
         W2Kg==
X-Gm-Message-State: AOAM531X7u8O5+aQR9tGpbc0wZZbNafdBftxt4GsKFK+VuwyaUK6mZdG
        QIR1PF0Mi9xWnT7QySck9g==
X-Google-Smtp-Source: ABdhPJzxxcXmbBy9S9nq+NtNfhNl9dfkw8KfDjwV+1IBzsnUPC7075IUdOvwQSgV/Hjs1h1CM3uMYg==
X-Received: by 2002:a05:6830:1196:: with SMTP id u22mr19182854otq.247.1623185461539;
        Tue, 08 Jun 2021 13:51:01 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l128sm3033425oif.16.2021.06.08.13.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 13:51:01 -0700 (PDT)
Received: (nullmailer pid 1556864 invoked by uid 1000);
        Tue, 08 Jun 2021 20:50:56 -0000
From:   Rob Herring <robh@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     broonie@kernel.org, devicetree@vger.kernel.org,
        bjorn.andersson@linaro.org, tiwai@suse.de, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, bgoswami@codeaurora.org,
        plai@codeaurora.org, linux-kernel@vger.kernel.org, perex@perex.cz
In-Reply-To: <20210607152836.17154-13-srinivas.kandagatla@linaro.org>
References: <20210607152836.17154-1-srinivas.kandagatla@linaro.org> <20210607152836.17154-13-srinivas.kandagatla@linaro.org>
Subject: Re: [RFC PATCH 12/13] ASoC: qcom: dt-bindings: add audioreach soundcard compatibles
Date:   Tue, 08 Jun 2021 15:50:56 -0500
Message-Id: <1623185456.805853.1556863.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Jun 2021 16:28:35 +0100, Srinivas Kandagatla wrote:
> Add compatible strings for AudioReach DSP firmware based soundcards.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../bindings/sound/qcom,sm8250.yaml           | 43 +++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
In file included from Documentation/devicetree/bindings/sound/qcom,sm8250.example.dts:116:
./scripts/dtc/include-prefixes/dt-bindings/sound/qcom,q6apm.h:5: warning: "MSM_FRONTEND_DAI_MULTIMEDIA1" redefined
    5 | #define MSM_FRONTEND_DAI_MULTIMEDIA1 1
      | 
In file included from Documentation/devicetree/bindings/sound/qcom,sm8250.example.dts:20:
./scripts/dtc/include-prefixes/dt-bindings/sound/qcom,q6asm.h:5: note: this is the location of the previous definition
    5 | #define MSM_FRONTEND_DAI_MULTIMEDIA1 0
      | 
In file included from Documentation/devicetree/bindings/sound/qcom,sm8250.example.dts:116:
./scripts/dtc/include-prefixes/dt-bindings/sound/qcom,q6apm.h:6: warning: "MSM_FRONTEND_DAI_MULTIMEDIA2" redefined
    6 | #define MSM_FRONTEND_DAI_MULTIMEDIA2 2
      | 
In file included from Documentation/devicetree/bindings/sound/qcom,sm8250.example.dts:20:
./scripts/dtc/include-prefixes/dt-bindings/sound/qcom,q6asm.h:6: note: this is the location of the previous definition
    6 | #define MSM_FRONTEND_DAI_MULTIMEDIA2 1
      | 
In file included from Documentation/devicetree/bindings/sound/qcom,sm8250.example.dts:116:
./scripts/dtc/include-prefixes/dt-bindings/sound/qcom,q6apm.h:7: warning: "MSM_FRONTEND_DAI_MULTIMEDIA3" redefined
    7 | #define MSM_FRONTEND_DAI_MULTIMEDIA3 3
      | 
In file included from Documentation/devicetree/bindings/sound/qcom,sm8250.example.dts:20:
./scripts/dtc/include-prefixes/dt-bindings/sound/qcom,q6asm.h:7: note: this is the location of the previous definition
    7 | #define MSM_FRONTEND_DAI_MULTIMEDIA3 2
      | 
In file included from Documentation/devicetree/bindings/sound/qcom,sm8250.example.dts:116:
./scripts/dtc/include-prefixes/dt-bindings/sound/qcom,q6apm.h:8: warning: "MSM_FRONTEND_DAI_MULTIMEDIA4" redefined
    8 | #define MSM_FRONTEND_DAI_MULTIMEDIA4 4
      | 
In file included from Documentation/devicetree/bindings/sound/qcom,sm8250.example.dts:20:
./scripts/dtc/include-prefixes/dt-bindings/sound/qcom,q6asm.h:8: note: this is the location of the previous definition
    8 | #define MSM_FRONTEND_DAI_MULTIMEDIA4 3
      | 
In file included from Documentation/devicetree/bindings/sound/qcom,sm8250.example.dts:116:
./scripts/dtc/include-prefixes/dt-bindings/sound/qcom,q6apm.h:9: warning: "MSM_FRONTEND_DAI_MULTIMEDIA5" redefined
    9 | #define MSM_FRONTEND_DAI_MULTIMEDIA5 5
      | 
In file included from Documentation/devicetree/bindings/sound/qcom,sm8250.example.dts:20:
./scripts/dtc/include-prefixes/dt-bindings/sound/qcom,q6asm.h:9: note: this is the location of the previous definition
    9 | #define MSM_FRONTEND_DAI_MULTIMEDIA5 4
      | 
In file included from Documentation/devicetree/bindings/sound/qcom,sm8250.example.dts:116:
./scripts/dtc/include-prefixes/dt-bindings/sound/qcom,q6apm.h:10: warning: "MSM_FRONTEND_DAI_MULTIMEDIA6" redefined
   10 | #define MSM_FRONTEND_DAI_MULTIMEDIA6 6
      | 
In file included from Documentation/devicetree/bindings/sound/qcom,sm8250.example.dts:20:
./scripts/dtc/include-prefixes/dt-bindings/sound/qcom,q6asm.h:10: note: this is the location of the previous definition
   10 | #define MSM_FRONTEND_DAI_MULTIMEDIA6 5
      | 
In file included from Documentation/devicetree/bindings/sound/qcom,sm8250.example.dts:116:
./scripts/dtc/include-prefixes/dt-bindings/sound/qcom,q6apm.h:11: warning: "MSM_FRONTEND_DAI_MULTIMEDIA7" redefined
   11 | #define MSM_FRONTEND_DAI_MULTIMEDIA7 7
      | 
In file included from Documentation/devicetree/bindings/sound/qcom,sm8250.example.dts:20:
./scripts/dtc/include-prefixes/dt-bindings/sound/qcom,q6asm.h:11: note: this is the location of the previous definition
   11 | #define MSM_FRONTEND_DAI_MULTIMEDIA7 6
      | 
In file included from Documentation/devicetree/bindings/sound/qcom,sm8250.example.dts:116:
./scripts/dtc/include-prefixes/dt-bindings/sound/qcom,q6apm.h:12: warning: "MSM_FRONTEND_DAI_MULTIMEDIA8" redefined
   12 | #define MSM_FRONTEND_DAI_MULTIMEDIA8 8
      | 
In file included from Documentation/devicetree/bindings/sound/qcom,sm8250.example.dts:20:
./scripts/dtc/include-prefixes/dt-bindings/sound/qcom,q6asm.h:12: note: this is the location of the previous definition
   12 | #define MSM_FRONTEND_DAI_MULTIMEDIA8 7
      | 
Error: Documentation/devicetree/bindings/sound/qcom,sm8250.example.dts:154.5-6 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:380: Documentation/devicetree/bindings/sound/qcom,sm8250.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1416: dt_binding_check] Error 2
\ndoc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1488759

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

