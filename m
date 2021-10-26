Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67C4D43B8ED
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 20:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238036AbhJZSGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 14:06:01 -0400
Received: from mail-oi1-f173.google.com ([209.85.167.173]:37766 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236541AbhJZSF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 14:05:57 -0400
Received: by mail-oi1-f173.google.com with SMTP id o83so21827473oif.4;
        Tue, 26 Oct 2021 11:03:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=3as/GuvOWTvyp/VYeOrt16zs8U1QuE2A3YEpnZ5CxsQ=;
        b=3cI1bE3ZLta7GStu7RopFswF8YM2s4c3rub1/k+8cY2diRTPIpP+EwJ138ufbJP9Ry
         or3ZomfkzKW1VL3vJNqSWqiDAGFYay7nZPVcMwnNJrZxOgfmD3E2geqhe47ORfst6Yz1
         ij69xWghIQlF6sPP0l9f2aOMMx9AlztteuvXM3/76Cw28JsYFsZ+p1rcJL4grg6Q6ELB
         oID4rJ9BZw111VsPOuLEScwQY/yeE97BrynUVQyN6qfcC/vtiVwGGxfVwAiadXOT0YDN
         nOVGdUZIeK3t0q1fUVcODzO/2cM33X/rxGpxNOxyZrxN5IuDhhHv/StcGVeVfm39ig5t
         0F4w==
X-Gm-Message-State: AOAM532ZLKY/5ljWN3yz1geWFWzOu03DxieHtGWDhx8GAi0VOwURAWIN
        E934c5kyI7gF455wkPoWoQ==
X-Google-Smtp-Source: ABdhPJwzsHRq95UQ3fhFbv6gBTR2l9kWV9/6zEYmXLz/VmkD3vLwWIAVnFnoRaFdnDJJ4W33cmdkpg==
X-Received: by 2002:a05:6808:1152:: with SMTP id u18mr184570oiu.158.1635271413576;
        Tue, 26 Oct 2021 11:03:33 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id n7sm4733587oij.46.2021.10.26.11.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 11:03:32 -0700 (PDT)
Received: (nullmailer pid 2939413 invoked by uid 1000);
        Tue, 26 Oct 2021 18:03:29 -0000
From:   Rob Herring <robh@kernel.org>
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     Sumit Garg <sumit.garg@linaro.org>, linux-doc@vger.kernel.org,
        devicetree@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Jerome Forissier <jerome@forissier.org>,
        jens.vankeirsbilck@kuleuven.be, op-tee@lists.trustedfirmware.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Etienne Carriere <etienne.carriere@linaro.org>
In-Reply-To: <20211026083138.1818705-3-jens.wiklander@linaro.org>
References: <20211026083138.1818705-1-jens.wiklander@linaro.org> <20211026083138.1818705-3-jens.wiklander@linaro.org>
Subject: Re: [PATCH v7 2/6] dt-bindings: arm: optee: add interrupt property
Date:   Tue, 26 Oct 2021 13:03:29 -0500
Message-Id: <1635271409.203246.2939412.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Oct 2021 10:31:34 +0200, Jens Wiklander wrote:
> Adds an optional interrupt property to the optee binding.
> 
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  .../devicetree/bindings/arm/firmware/linaro,optee-tz.yaml  | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.example.dts:23.31-32 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:385: Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1441: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1546320

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

