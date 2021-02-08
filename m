Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC249313DFD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 19:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235949AbhBHSsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 13:48:05 -0500
Received: from mail-oi1-f173.google.com ([209.85.167.173]:37666 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234556AbhBHQ4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 11:56:07 -0500
Received: by mail-oi1-f173.google.com with SMTP id y199so14274357oia.4;
        Mon, 08 Feb 2021 08:55:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=TUzmdT6JqpHqhZVxAjUAhi7ibm9HOBbRawg15CNCwVY=;
        b=ZJ4TPyfhiSZ/Q8kc+oMoynCcQ8FtAOBKN9vwFk2GdNm85cSEAPi6L/7iaFrhCXJpnY
         eYrt1Wv8VlEDUTpJcF0/cfwoqpps9ImSgXbfB85wOtcq6QWDeQ/Q91SwBlbcjct/pBJN
         dck4Tq7PNAweMffNe9s5/HJ9tl01271rp70o0RiUzi6Qs3sCvTeQ8VNVgxYobMTje2xN
         X/JOUbQCp9/mayEFC5CJL1vZ8SYDjTtGZ8wmswpKouktuJNa+c9bnYA1Oly01ldXyDdY
         q6d8vzpga8LOLS2ONUIzxlWB6KC288415EyVJHZjkzugXCfqDOMWcqeH0UKx05RsuttX
         H++g==
X-Gm-Message-State: AOAM533hgAQ5erFPmim0iYFTWQASVb6+MTvlyLaJDZXqAWcb5yUiaqeI
        3h43Z7gNVTMLUMlnnnnlhw==
X-Google-Smtp-Source: ABdhPJx1ss+Mn8AG8RZGWoVUwGiLAhKq6+TUTHdiXRn90wtV5C3ZrPMO/vSmbPN0WrF50yoW5poMvw==
X-Received: by 2002:aca:600a:: with SMTP id u10mr11647189oib.36.1612803326518;
        Mon, 08 Feb 2021 08:55:26 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g11sm3786675oif.9.2021.02.08.08.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 08:55:24 -0800 (PST)
Received: (nullmailer pid 1522087 invoked by uid 1000);
        Mon, 08 Feb 2021 16:55:22 -0000
From:   Rob Herring <robh@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Oleksij Rempel <linux@rempel-privat.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>
In-Reply-To: <20210205234734.3397-4-leoyang.li@nxp.com>
References: <20210205234734.3397-1-leoyang.li@nxp.com> <20210205234734.3397-4-leoyang.li@nxp.com>
Subject: Re: [PATCH 03/15] dt-bindings: memory: fsl: convert ifc binding to yaml schema
Date:   Mon, 08 Feb 2021 10:55:22 -0600
Message-Id: <1612803322.544738.1522086.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 05 Feb 2021 17:47:22 -0600, Li Yang wrote:
> Convert the txt binding to yaml format and add description.  Also
> updated the recommended node name to ifc-bus to align with the
> simple-bus node name requirements.
> 
> Signed-off-by: Li Yang <leoyang.li@nxp.com>
> ---
>  .../bindings/memory-controllers/fsl/ifc.txt   |  82 ----------
>  .../bindings/memory-controllers/fsl/ifc.yaml  | 140 ++++++++++++++++++
>  2 files changed, 140 insertions(+), 82 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/fsl/ifc.txt
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/fsl/ifc.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/memory-controllers/fsl/ifc.example.dts:36.27-49.19: Warning (simple_bus_reg): /example-0/soc/ifc-bus@ffe1e000/flash@0,0: simple-bus unit address format error, expected "0"
Documentation/devicetree/bindings/memory-controllers/fsl/ifc.example.dts:51.27-64.19: Warning (simple_bus_reg): /example-0/soc/ifc-bus@ffe1e000/flash@1,0: simple-bus unit address format error, expected "100000000"
Documentation/devicetree/bindings/memory-controllers/fsl/ifc.example.dts:66.26-71.19: Warning (simple_bus_reg): /example-0/soc/ifc-bus@ffe1e000/cpld@3,0: simple-bus unit address format error, expected "300000000"

See https://patchwork.ozlabs.org/patch/1436960

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

