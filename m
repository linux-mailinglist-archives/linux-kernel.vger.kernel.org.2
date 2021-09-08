Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB007403B08
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 15:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351763AbhIHNys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 09:54:48 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:46606 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbhIHNyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 09:54:43 -0400
Received: by mail-ot1-f49.google.com with SMTP id v33-20020a0568300921b0290517cd06302dso3013631ott.13;
        Wed, 08 Sep 2021 06:53:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=7NTl1uWn5/awXs/DGR3BA+sGi0+YNLli0mD4od7vqA8=;
        b=YmQyE1bjIKuJPiWRNuEwreK20NGw0/wriwFdqvxrGaulvhSnaUST961dpx9UNGzTSq
         iwsFu3yukepT7JiVaFXLLxxS1L/SOcS4kEt4gJ31+e6OSLGUfiRdLj7Rt0fRaxJ4DDvo
         skjtHx6KL+3aLSxMx6bogxhVF5Re44dvovJWAmWv5xb2usBUvY5X9ZYdTdUGUPuydGFi
         m37FQt0bNanjDUxxpH+9Azig4BL8MrdqOTTAuuNlPRtHt3UZZcD0GsqpgzySKv3GLFiD
         cyOmFOkWeZxkaygsG8CBt47XCqBwsRqN0SJ7LjxiqWOEij6oO/d7tPHZaIndRTwqym2r
         C92A==
X-Gm-Message-State: AOAM5301EFPPUMUbQ0VoxlwcCicMUg5h4iZQTkjgnzPTQ3nhDYtfguoc
        Um1I/Nc2VajAGlro3k0OVA==
X-Google-Smtp-Source: ABdhPJwpaGH4DkGWSBPtpKhZZlAWlqBgp5WDm3d2MTr483rS75d6QIk2hGWuYvZj6UEBiy/FBjSsVw==
X-Received: by 2002:a9d:4a84:: with SMTP id i4mr3109923otf.247.1631109214986;
        Wed, 08 Sep 2021 06:53:34 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id a13sm53450ooi.3.2021.09.08.06.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 06:53:34 -0700 (PDT)
Received: (nullmailer pid 2031708 invoked by uid 1000);
        Wed, 08 Sep 2021 13:53:33 -0000
From:   Rob Herring <robh@kernel.org>
To:     Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
Cc:     mturquette@baylibre.com, linux-kernel@vger.kernel.org,
        Eugen.Hristev@microchip.com, UNGLinuxDriver@microchip.com,
        Kavyasree.Kotagiri@microchip.com, Manohar.Puri@microchip.com,
        devicetree@vger.kernel.org, sboyd@kernel.org, robh+dt@kernel.org,
        linux-clk@vger.kernel.org
In-Reply-To: <20210908114844.22131-4-kavyasree.kotagiri@microchip.com>
References: <20210908114844.22131-1-kavyasree.kotagiri@microchip.com> <20210908114844.22131-4-kavyasree.kotagiri@microchip.com>
Subject: Re: [PATCH v2 3/3] dt-bindings: clock: lan966x: Add LAN966X Clock Controller
Date:   Wed, 08 Sep 2021 08:53:33 -0500
Message-Id: <1631109213.150695.2031707.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Sep 2021 17:18:44 +0530, Kavyasree Kotagiri wrote:
> This adds the DT bindings documentation for lan966x SoC
> generic clock controller.
> 
> Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
> ---
> v1 -> v2:
> - Updated example provided for clk controller DT node.
> 
>  .../bindings/clock/microchip,lan966x-gck.yaml | 64 +++++++++++++++++++
>  1 file changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/microchip,lan966x-gck.example.dt.yaml: clock-controller@e00c00a8: clocks: [[1], [2], [3]] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1525807

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

