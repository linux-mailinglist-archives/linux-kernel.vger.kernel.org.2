Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41AB83F9B71
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 17:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234159AbhH0PHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 11:07:19 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:34577 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233587AbhH0PHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 11:07:14 -0400
Received: by mail-ot1-f53.google.com with SMTP id k12-20020a056830150c00b0051abe7f680bso8292945otp.1;
        Fri, 27 Aug 2021 08:06:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=JeoFm8pgLa5crlJAehUM7bhTX8lPHfzpyQS/igOtYdk=;
        b=FDW1ZkcddgK7GCJwa7GjaXTvsph2r0wFZkJAW8S9CeUjn3G6wmBmseq17GGaPyK1vT
         rMvwWaElFW6RjjXdJ3bm6MkIeuAqCZnNgdYBuLvjaDQ3Cw0zFJ3lwtDma82Yxq76e+JU
         Eu2A/UDYyEkm+X7pdRzzpi/anINm6hOV0H1RMWwzwlVhZbfK2Ix125V4yPnX5De7Ukx3
         bun7rtr9Qsi9hpdiR05zfhRQUWUsOIX36hD4cwYGaEenD3UI2/ljn0wZpcelzT200/MV
         2aiTQauU3yNrymyR5qW5zMoH9+bUiAqbsixFLcOipbK1j8aUcB4ucOXFPluyeF8nDQBu
         UO4w==
X-Gm-Message-State: AOAM530BW1Gxkt/R7EbkpmPHADCVoCIk94xlp9U3IjOLQ0jAreEFdI1K
        gnMM2Bplt6GPszV8RCbmbA==
X-Google-Smtp-Source: ABdhPJxQrsMrBY1+6cjfe2LuHLsnAht7j4zzSHvAQ2bTR/rborH83KibfNdlLGBBYCqFpFMjvjBYqA==
X-Received: by 2002:a9d:5c14:: with SMTP id o20mr8145765otk.36.1630076784948;
        Fri, 27 Aug 2021 08:06:24 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id m206sm1388800oif.23.2021.08.27.08.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 08:06:24 -0700 (PDT)
Received: (nullmailer pid 3586827 invoked by uid 1000);
        Fri, 27 Aug 2021 15:06:23 -0000
From:   Rob Herring <robh@kernel.org>
To:     Dhananjay Kangude <dkangude@cadence.com>
Cc:     kishon@ti.com, devicetree@vger.kernel.org, mparab@cadence.com,
        vigneshr@ti.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org
In-Reply-To: <20210826185135.26599-2-dkangude@cadence.com>
References: <20210826185135.26599-1-dkangude@cadence.com> <20210826185135.26599-2-dkangude@cadence.com>
Subject: Re: [PATCH v1] dt-bindings: ufshc: cdns: convert bindings for Cadence UFS host controller
Date:   Fri, 27 Aug 2021 10:06:23 -0500
Message-Id: <1630076783.075029.3586826.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Aug 2021 20:51:35 +0200, Dhananjay Kangude wrote:
> Converted bindings into yaml format for Cadence UFS host controller
> 
> Signed-off-by: Dhananjay Kangude <dkangude@cadence.com>
> ---
>  .../devicetree/bindings/ufs/cdns,ufshc.txt         |   32 --------
>  .../devicetree/bindings/ufs/cdns,ufshc.yaml        |   80 ++++++++++++++++++++
>  2 files changed, 80 insertions(+), 32 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/ufs/cdns,ufshc.txt
>  create mode 100644 Documentation/devicetree/bindings/ufs/cdns,ufshc.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/ufs/ti,j721e-ufs.example.dt.yaml: ufs@4000: 'power-domains' does not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/ufs/cdns,ufshc.yaml

doc reference errors (make refcheckdocs):
Documentation/devicetree/bindings/ufs/ti,j721e-ufs.yaml: Documentation/devicetree/bindings/ufs/cdns,ufshc.txt

See https://patchwork.ozlabs.org/patch/1521296

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

