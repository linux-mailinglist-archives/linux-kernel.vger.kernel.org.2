Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 474C73A0549
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 22:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbhFHUxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 16:53:05 -0400
Received: from mail-oi1-f179.google.com ([209.85.167.179]:39658 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbhFHUxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 16:53:05 -0400
Received: by mail-oi1-f179.google.com with SMTP id m137so19031874oig.6;
        Tue, 08 Jun 2021 13:50:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=wwiC9g3wdjtEd/NglS+/cMH7OphwcIAcmbuqcv3Ok7k=;
        b=J8LOUbherMDmvXidgkArQhPvt0YqjnnY684fYJ6lNL+Lec7FpIUeEr4jZXEJ5qxber
         p503phu2u0wanSawQNbwsEc/58QKYOhzEEE4AkTHQ4Q/7XXEDPgBn+74dGwnQ3pxLN/x
         l+Ph1q2+jTGFEtS1eZU+BJxK2m1HyrLY38TR9WSylXCaxe8hpjahv1qdqNDlPjaAo0Jg
         y07vpVxbFT6SPj9ZeSNe4zjWWu5Q7ief4Dp8Hb2mDJTyKFaCynVmZ+Dq4i65eG7a0iOA
         bRR66njzibmqXd89k/hHqcVQSHP676zBlXAtE9Ix3zEeSIdKzYOTtVmCH1aVA74Rst+V
         eeyw==
X-Gm-Message-State: AOAM53230duynbxpftLF8TKtn5/hYI0RYC8b0bBaYK95FvteJQJ+OIwo
        5RqMG4Dk/RE8ySbA0cZpXA==
X-Google-Smtp-Source: ABdhPJxBg367eNdR+0mi3NKIw48pRIV9UMfAqjUgOOTnSa4EARGainMEL2UgOd9HbWQFQI5IwpJbiw==
X-Received: by 2002:aca:4d3:: with SMTP id 202mr4164214oie.9.1623185458371;
        Tue, 08 Jun 2021 13:50:58 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b26sm2974012otf.69.2021.06.08.13.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 13:50:57 -0700 (PDT)
Received: (nullmailer pid 1556861 invoked by uid 1000);
        Tue, 08 Jun 2021 20:50:56 -0000
From:   Rob Herring <robh@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     bjorn.andersson@linaro.org, bgoswami@codeaurora.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, perex@perex.cz, devicetree@vger.kernel.org,
        broonie@kernel.org, plai@codeaurora.org, tiwai@suse.de
In-Reply-To: <20210607152836.17154-2-srinivas.kandagatla@linaro.org>
References: <20210607152836.17154-1-srinivas.kandagatla@linaro.org> <20210607152836.17154-2-srinivas.kandagatla@linaro.org>
Subject: Re: [RFC PATCH 01/13] soc: dt-bindings: qcom: add gpr bindings
Date:   Tue, 08 Jun 2021 15:50:56 -0500
Message-Id: <1623185456.792100.1556860.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Jun 2021 16:28:24 +0100, Srinivas Kandagatla wrote:
> Qualcomm Generic Packet router aka GPR is the IPC mechanism found
> in AudioReach next generation signal processing framework to perform
> command and response messages between various processors.
> 
> GPR has concepts of static and dynamic port, all static services like
> APM (Audio Processing Manager), PRM (Proxy resource manager) have
> fixed port numbers where as dynamic services like graphs have dynamic
> port numbers which are allocated at runtime. All GPR packet messages
> will have source and destination domain and port along with opcode
> and payload.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../bindings/soc/qcom/qcom,gpr.yaml           | 74 +++++++++++++++++++
>  1 file changed, 74 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,gpr.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/soc/qcom/qcom,gpr.example.dts:19:18: fatal error: dt-bindings/soc/qcom,gpr.h: No such file or directory
   19 |         #include <dt-bindings/soc/qcom,gpr.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:380: Documentation/devicetree/bindings/soc/qcom/qcom,gpr.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1416: dt_binding_check] Error 2
\ndoc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1488752

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

