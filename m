Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9B3411467
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 14:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238049AbhITMaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 08:30:08 -0400
Received: from mail-oi1-f171.google.com ([209.85.167.171]:37843 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233543AbhITMaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 08:30:07 -0400
Received: by mail-oi1-f171.google.com with SMTP id w206so12835982oiw.4;
        Mon, 20 Sep 2021 05:28:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=ozms2Ex7SIIZKhI4xCpLZMFP8jZ9XTQy36/jq76oesw=;
        b=UvKQWsBYDGCFT0DOe2PUMpuwhmZAjYzCJMrD3qDTIb4BrBkJxFMlr91BI1SSB/YYvE
         XHcilZKN/8TN0lOBrYHUuxx/iDekT+8DR98mRW8SCx12yJZnvq5pv9IBUqjMz90F49ED
         ALYrgGB0EIoqqmTmAaGu9rBwXFsAbDWmpAvj9aQUB2k5qFZ9/s5AeYlEWzKeu8i3hc1l
         V9gL76r8q5ZeVtSZ9LUTXmPSfPQFkPWIrMnEQGEdYyFOF8dy/dgmfm0Ib4eMICTi4E/q
         oiOMX/BmOH3QWjah9RxgmrJQHppg8mnQHDrMgH7HNtHZR3UJR2gkmv552FVbk9URqCdQ
         pGdQ==
X-Gm-Message-State: AOAM533rn9iWJy2X4ZNnEq3dlouBMdFfl/kDQ3gi7a7ly8lHFhc+wFGQ
        fGsJTs75kqcNo6/JkRWs6A==
X-Google-Smtp-Source: ABdhPJygC6qxBmPoPi92lcSnNRII66oRcadqdO+MwP1z2M7krf7AnDxfvjaqqWwOKL1QoWzKbFkl6w==
X-Received: by 2002:a54:4018:: with SMTP id x24mr22735687oie.125.1632140920117;
        Mon, 20 Sep 2021 05:28:40 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id q17sm3412265otc.28.2021.09.20.05.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 05:28:38 -0700 (PDT)
Received: (nullmailer pid 4136127 invoked by uid 1000);
        Mon, 20 Sep 2021 12:28:37 -0000
From:   Rob Herring <robh@kernel.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Oleksij Rempel <linux@rempel-privat.de>,
        Tim Harvey <tharvey@gateworks.com>,
        Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>
In-Reply-To: <20210919125536.117743-8-marcel@ziswiler.com>
References: <20210919125536.117743-1-marcel@ziswiler.com> <20210919125536.117743-8-marcel@ziswiler.com>
Subject: Re: [PATCH v3 7/9] dt-bindings: arm: fsl: clean-up all toradex boards/modules
Date:   Mon, 20 Sep 2021 07:28:37 -0500
Message-Id: <1632140917.871356.4136126.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Sep 2021 14:55:34 +0200, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Simplify and unify the distinction between modules and carrier boards.
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
> 
> ---
> 
> Changes in v3:
> - Add Fabio's reviewed-by. Thanks!
> - Add Rob's ack. Thanks!
> 
> Changes in v2:
> - New patch cleaning-up dt-bindings documentation.
> 
>  .../devicetree/bindings/arm/fsl.yaml          | 79 ++++++++++---------
>  1 file changed, 41 insertions(+), 38 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/arm/fsl.yaml:475:111: [warning] line too long (113 > 110 characters) (line-length)
./Documentation/devicetree/bindings/arm/fsl.yaml:612:111: [warning] line too long (113 > 110 characters) (line-length)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1529833

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

