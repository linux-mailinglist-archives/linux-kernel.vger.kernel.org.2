Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42E4B435529
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 23:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbhJTVRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 17:17:13 -0400
Received: from mail-oi1-f179.google.com ([209.85.167.179]:40453 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbhJTVRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 17:17:09 -0400
Received: by mail-oi1-f179.google.com with SMTP id n63so11265853oif.7;
        Wed, 20 Oct 2021 14:14:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=sHNOzVt1fx+Xjri5iyaSxr/RoKgaKK3mFHN46rZafN8=;
        b=LfKTN+pYNTjjv1YjvTXBUvE/tzVNOHXm+FISP0UQv3bCyVzyswvGSAYAu3DG95VB46
         xh65SCEsha5oLcrs4iGoyrxI8cJV/o17j/Qo2gxbRcC+2HRONr7lDxM8Gag8do6Mj9MD
         oZcA1XNcDZiRTFV2GsZcAt3CGGkrmsxEv6EbAdQdZm6S5mGuCnt8BB4w0QYf3gHkSfEB
         2EKWmLDXCpBAr5CFHuGz4gUPb6n9Js25vnh+CXgCtHkrEdLgz9kp/b+lO330nRBChIzk
         gS2e/cTPl6/HGxqFInD2m8dcEZjertxyQiLFfXcg79uxrmbjjKKeeUKIdlT55oiZGgrW
         ve3Q==
X-Gm-Message-State: AOAM533c3ECih7ZtgX30a4c/CChF1AKYR9KyDHpdqqgUvL4iwacYeV/Z
        UZfBYK3Hlw5A9R/57S1mDQ==
X-Google-Smtp-Source: ABdhPJzY7Ei/WTDlj1Ici196zfQ21aVXJuLp7iksopkG+pytFgBR0cLu1QBEzvJPPg4Jk/Qej01C4w==
X-Received: by 2002:a05:6808:1921:: with SMTP id bf33mr1116860oib.118.1634764494207;
        Wed, 20 Oct 2021 14:14:54 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id e14sm702110otl.22.2021.10.20.14.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 14:14:53 -0700 (PDT)
Received: (nullmailer pid 2962589 invoked by uid 1000);
        Wed, 20 Oct 2021 21:14:47 -0000
From:   Rob Herring <robh@kernel.org>
To:     Etienne Carriere <etienne.carriere@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Cristian Marussi <cristian.marussi@arm.com>,
        devicetree@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>
In-Reply-To: <20211020175747.28449-1-etienne.carriere@linaro.org>
References: <20211020175747.28449-1-etienne.carriere@linaro.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: arm: Add OP-TEE transport for SCMI
Date:   Wed, 20 Oct 2021 16:14:47 -0500
Message-Id: <1634764487.047202.2962588.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Oct 2021 19:57:46 +0200, Etienne Carriere wrote:
> Introduce compatible "linaro,scmi-optee" for SCMI transport channel
> based on an OP-TEE service invocation. The compatible mandates a
> channel ID defined with property "linaro,optee-channel-id".
> 
> Cc: devicetree@vger.kernel.org
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> ---
> Changes since v3:
>  - Add description for linaro,optee-channel-id in patternProperties
>    specifying protocol can optionaly define a dedicated channel id.
>  - Fix DTS example (duplicated phandles issue, subnodes ordering)
>  - Fix typo in DTS example and description comments.
> 
> Changes since v2:
>  - Define mandatory property linaro,optee-channel-id
>  - Rebased on yaml description file
> 
> Changes since v1:
>  - Removed modification regarding mboxes property description.
> ---
>  .../bindings/firmware/arm,scmi.yaml           | 66 +++++++++++++++++++
>  1 file changed, 66 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/firmware/arm,scmi.example.dt.yaml: sram@51000000: 'optee-shm-section@0' does not match any of the regexes: '^([a-z]*-)?sram(-section)?@[a-f0-9]+$', 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sram/sram.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1544001

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

