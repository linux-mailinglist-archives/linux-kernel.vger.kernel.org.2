Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B72D3A1AC6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 18:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237600AbhFIQTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 12:19:21 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:37629 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237569AbhFIQTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 12:19:07 -0400
Received: by mail-ot1-f46.google.com with SMTP id 102-20020a9d0eef0000b02903fccc5b733fso1430451otj.4;
        Wed, 09 Jun 2021 09:16:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=CHX5KZWTpPcC/yJko/I/+4jvnHoXctpkINpWSG1gYOU=;
        b=cjvEn7aUOSAtgDSHRORTN1FHkDjhi8oSyn5ebaao6ViDJ0/Mi/5C1dZ1HxzeyhJFF/
         f51Tn2MM127iDIuGAtG+Vaxo3hZXgdsCKBWrL5Lp0RpkP/EPtN8JIsugAUqTQPG45eAa
         vmQ8KwC2S3+/H3F1L19uap2BCuoi1WLC7SsQVV3wk8eHqGx8DhJpeqKqAFUu+uvOq1Z9
         PTIpATScBWWjysERkWLXS1pq9xu6y6rUYhk6WY0c9THh1u85++2Ffe/L/ekrOaYPCF8n
         C4NUeMRWknHqQRXdZpFN1pnlqixb6jBY3lkj+FK9hnFLbMMNV0BN41Np+hkaBt7aLjqd
         AmhQ==
X-Gm-Message-State: AOAM533zYXGED4sZo0mippQVTWY6RXYdWnwlwUJ9KTq2530FlbMP+kVR
        EXRf07gScbOxfeT7pn6Q5g==
X-Google-Smtp-Source: ABdhPJxVyGxyGLGNx7gbHhTpkRi1VCa2iO+S92c5wEEUjPoMljEIPQVGMfNm0TNIzliApcqPK7juEQ==
X-Received: by 2002:a9d:7a5:: with SMTP id 34mr140930oto.371.1623255415676;
        Wed, 09 Jun 2021 09:16:55 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p25sm34364ood.4.2021.06.09.09.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 09:16:55 -0700 (PDT)
Received: (nullmailer pid 3763306 invoked by uid 1000);
        Wed, 09 Jun 2021 16:16:43 -0000
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kumar Mahapatra <akumarma@xilinx.com>,
        linux-mtd@lists.infradead.org, helmut.grohne@intenta.de,
        Siva Durga Prasad Paladugu <sivadur@xilinx.com>,
        Richard Weinberger <richard@nod.at>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Srinivas Goud <sgoud@xilinx.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Michal Simek <monstr@monstr.eu>,
        Naga Sureshkumar Relli <nagasure@xilinx.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>
In-Reply-To: <20210609080112.1753221-18-miquel.raynal@bootlin.com>
References: <20210609080112.1753221-1-miquel.raynal@bootlin.com> <20210609080112.1753221-18-miquel.raynal@bootlin.com>
Subject: Re: [PATCH v22 17/18] dt-bindings: mtd: pl353-nand: Describe this hardware controller
Date:   Wed, 09 Jun 2021 11:16:43 -0500
Message-Id: <1623255403.668043.3763305.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Jun 2021 10:01:11 +0200, Miquel Raynal wrote:
> Add a yaml description of this NAND controller which is described as a
> subnode of the SMC bus.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  .../bindings/mtd/arm,pl353-nand-r2p1.yaml     | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.example.dt.yaml:0:0: /example-0/memory-controller@e000e000: failed to match any schema with compatible: ['arm,pl353-smc-r2p1', 'arm,primecell']
\ndoc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1489731

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

