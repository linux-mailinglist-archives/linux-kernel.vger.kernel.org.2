Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20A9B3AA0BB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 18:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbhFPQFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 12:05:21 -0400
Received: from mail-io1-f54.google.com ([209.85.166.54]:46808 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbhFPQFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 12:05:18 -0400
Received: by mail-io1-f54.google.com with SMTP id b14so3536417iow.13;
        Wed, 16 Jun 2021 09:03:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=hcKoNlZ0qCHbgrMWMGVkyiDZS1Csw+8F++6Pzt1IPtw=;
        b=ppBa79DTv5pX/AYaZF0+z0zOKjqCG9VeiIgideZ3/Fd/ce6YfvYzsiiMPxuzCKy4tv
         kgTJbQrgEqirlbqVC9SN3kap5s6w42EYvUGD/J4x8rob/DqdaKHYfdPlROXaQhPWDmVM
         OOJakBSZkNhwNHuStF+WQSqQ/+Uy9mWpnusYM/vZZGrSb7lMEydljKfGFdN/spBnhRfo
         MMOUtF3MNCMwR9dgkjQbJhYXcijbseSewJ7CuMV4r/IgVz8JZLJeq/wGkCMiLPAl9ofK
         TGJKT3Fw5cI1DH3KunWdXAWPV3zyirr+CSTdsrDFTYxafxD5Jx+wWaHPDYga/6FX9stm
         1/hA==
X-Gm-Message-State: AOAM530Puu6fGcWUs8kTixG64xPUEOqDYUXYAbW83LmtUjoGK5v26wbf
        BJle8ThMCXhkg3mT271B7A==
X-Google-Smtp-Source: ABdhPJwY2nyTdfD4LWJR6MfSxx2n8cPcc2zsEpn3eF8j3IDKgGsVmaBx3KbLbue+x9qY8nkNJWQUTw==
X-Received: by 2002:a6b:720f:: with SMTP id n15mr99419ioc.209.1623859391422;
        Wed, 16 Jun 2021 09:03:11 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id l12sm1330204iln.20.2021.06.16.09.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 09:03:10 -0700 (PDT)
Received: (nullmailer pid 3471587 invoked by uid 1000);
        Wed, 16 Jun 2021 16:03:05 -0000
From:   Rob Herring <robh@kernel.org>
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     op-tee@lists.trustedfirmware.org,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        Jerome Forissier <jerome@forissier.org>,
        linux-doc@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, devicetree@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Etienne Carriere <etienne.carriere@linaro.org>
In-Reply-To: <20210616103649.2662395-3-jens.wiklander@linaro.org>
References: <20210616103649.2662395-1-jens.wiklander@linaro.org> <20210616103649.2662395-3-jens.wiklander@linaro.org>
Subject: Re: [PATCH v2 2/7] dt-bindings: arm: Convert optee binding to json-schema
Date:   Wed, 16 Jun 2021 10:03:05 -0600
Message-Id: <1623859385.179062.3471586.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jun 2021 12:36:44 +0200, Jens Wiklander wrote:
> Converts the optee binding to use DT schema format.
> 
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  .../bindings/arm/firmware/linaro,optee-tz.txt | 31 ------------
>  .../arm/firmware/linaro,optee-tz.yaml         | 49 +++++++++++++++++++
>  2 files changed, 49 insertions(+), 31 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml:21:7: [warning] wrong indentation: expected 4 but found 6 (indentation)

dtschema/dtc warnings/errors:
\ndoc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1492865

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

