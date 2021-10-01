Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2782B41EE56
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 15:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbhJANSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 09:18:46 -0400
Received: from mail-oi1-f179.google.com ([209.85.167.179]:42836 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbhJANSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 09:18:43 -0400
Received: by mail-oi1-f179.google.com with SMTP id x124so11355393oix.9;
        Fri, 01 Oct 2021 06:16:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=s93FCbEY6wiV8iS/EDoBTCM7Mo8XJASc8RhUVRLOCxo=;
        b=rt42qo3y/On5LIqnPcuE+mLBLlRtTBSjfGXhbZ+xJ2sg42++AgZ432ulGbhIhGDxr9
         4jYJU/Klz/0tHxuF4+xO2ceJOGmIsHsb6Xhl5+HcfyLGfLwbRMGwKRGm4OFE3PniqMpu
         qOKIfUI4XF1TONHev5otb88z8/+ymfbGYaW9heusb8zfiFieu201VFhzpiHfojuMRHCf
         ofoWz8KgXu/QW0VTBz+Ik52vR1OCA65uScbX84hDXMpLqxqiN/G0ACAzTR/LERO0wM37
         4f3voamk8Q5pYRCO+gANN3Vb3VyIj6/GMPw8G77wUiqWlXLhERNaMivqRqat5gUl1RO/
         uYng==
X-Gm-Message-State: AOAM531gqeCuAg7EiHpwswI6wYiAFgxmDUfUTv9tqDVOijk1TfF7bR9q
        nbz5xRpkbDGilmGsOGGGIQ==
X-Google-Smtp-Source: ABdhPJxqIZBVEGOYTlvgGELRTch2AV0JHIMbH+6kmz85mv3lykRhU/J6zCE6YTwRePhunB+9Higd6A==
X-Received: by 2002:aca:d686:: with SMTP id n128mr3734516oig.144.1633094219252;
        Fri, 01 Oct 2021 06:16:59 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id c21sm1124500oiy.18.2021.10.01.06.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 06:16:58 -0700 (PDT)
Received: (nullmailer pid 3666441 invoked by uid 1000);
        Fri, 01 Oct 2021 13:16:57 -0000
From:   Rob Herring <robh@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20211001000924.15421-2-leoyang.li@nxp.com>
References: <20211001000924.15421-1-leoyang.li@nxp.com> <20211001000924.15421-2-leoyang.li@nxp.com>
Subject: Re: [PATCH 1/5] dt-bindings: memory: fsl: convert ifc binding to yaml schema
Date:   Fri, 01 Oct 2021 08:16:57 -0500
Message-Id: <1633094217.843390.3666440.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Sep 2021 19:09:20 -0500, Li Yang wrote:
> Convert the txt binding to yaml format and add description.  Drop the
> "simple-bus" compatible string from the example and not allowed by the
> binding any more.  This will help to enforce the correct probe order
> between parent device and child devices, but will require the ifc driver
> to probe the child devices to work properly.
> 
> Signed-off-by: Li Yang <leoyang.li@nxp.com>
> ---
> updates from previous submission:
> - Drop "simple-bus" from binding and only "fsl,ifc" as compatible
> - Fix one identiation problem of "reg"
> - Add type restriction to "little-endian" property
> 
>  .../bindings/memory-controllers/fsl/ifc.txt   |  82 -----------
>  .../bindings/memory-controllers/fsl/ifc.yaml  | 137 ++++++++++++++++++
>  2 files changed, 137 insertions(+), 82 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/fsl/ifc.txt
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/fsl/ifc.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/memory-controllers/fsl/ifc.example.dt.yaml:0:0: /example-0/soc/ifc@ffe1e000/flash@1,0: failed to match any schema with compatible: ['fsl,ifc-nand']
Documentation/devicetree/bindings/memory-controllers/fsl/ifc.example.dt.yaml:0:0: /example-0/soc/ifc@ffe1e000/cpld@3,0: failed to match any schema with compatible: ['fsl,p1010rdb-cpld']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1535102

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

