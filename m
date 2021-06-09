Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCE223A1ABE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 18:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237503AbhFIQTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 12:19:01 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:34452 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237319AbhFIQS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 12:18:58 -0400
Received: by mail-ot1-f41.google.com with SMTP id v27-20020a056830091bb02903cd67d40070so21378426ott.1;
        Wed, 09 Jun 2021 09:16:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=T6NubXXmP4Pl+8RcuF0TyTLnZQ3F73+5dY/MZouj1JQ=;
        b=IgGSJq7XOix7M6B4ieVVlib0l5ZiC77NG699qCajiZuhHEAaidyycfdsyZC37KYR0X
         nPHfzPB8lEgNu1497nf5InWwswzOsbBjmp/JLwMyqJ6S42Ksj2wKPzNf2Hxd5e7l39C9
         8Ox1sDYisjYQMwIKbiaLiDJRh4Xj/YMmloIJLkyCDWPs54Xmy3H+FywkwE8JHE4Zg7R3
         EFAVwjWPD/NmpiNBn5YhA/Q+pBkwXNKfMDOCKcH5aBKFrY8qmZ9qzXcBn7V38AFs4SRf
         iEJe7Rjm9LpkujyQrnAQM7b4VJVRs16jBDdXtWaXmvVUW3KQDB1sVwyLcYgdHWVBC5Lw
         cEWg==
X-Gm-Message-State: AOAM532/8s/R1pFL5IFSi1AuRo0noGC7+Lw8Lo+PVycDcN+tcHujnPE4
        WIODMXpeufv3ETkOJUXu0g==
X-Google-Smtp-Source: ABdhPJyE3GUID1b2bH9Fjo1YaKuk17805Kd9mlDyJwnE98gcNAbU23W3fIuIPkEB8ATStJfX44i5ow==
X-Received: by 2002:a05:6830:18c2:: with SMTP id v2mr154871ote.153.1623255409915;
        Wed, 09 Jun 2021 09:16:49 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x31sm75163ota.24.2021.06.09.09.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 09:16:49 -0700 (PDT)
Received: (nullmailer pid 3763304 invoked by uid 1000);
        Wed, 09 Jun 2021 16:16:43 -0000
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Siva Durga Prasad Paladugu <sivadur@xilinx.com>,
        linux-mtd@lists.infradead.org,
        Naga Sureshkumar Relli <nagasure@xilinx.com>,
        linux-arm-kernel@lists.infradead.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Amit Kumar Mahapatra <akumarma@xilinx.com>,
        Richard Weinberger <richard@nod.at>,
        Michal Simek <monstr@monstr.eu>, linux-kernel@vger.kernel.org,
        Srinivas Goud <sgoud@xilinx.com>, helmut.grohne@intenta.de,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20210609080112.1753221-10-miquel.raynal@bootlin.com>
References: <20210609080112.1753221-1-miquel.raynal@bootlin.com> <20210609080112.1753221-10-miquel.raynal@bootlin.com>
Subject: Re: [PATCH v22 09/18] dt-binding: memory: pl353-smc: Convert to yaml
Date:   Wed, 09 Jun 2021 11:16:43 -0500
Message-Id: <1623255403.657922.3763303.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Jun 2021 10:01:03 +0200, Miquel Raynal wrote:
> Convert this binding file to yaml schema.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  .../memory-controllers/arm,pl353-smc.yaml     | 133 ++++++++++++++++++
>  .../bindings/memory-controllers/pl353-smc.txt |  45 ------
>  2 files changed, 133 insertions(+), 45 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/arm,pl353-smc.yaml
>  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/memory-controllers/arm,pl353-smc.example.dt.yaml:0:0: /example-0/memory-controller@e000e000/nand-controller@0,0: failed to match any schema with compatible: ['arm,pl353-nand-r2p1']
\ndoc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1489728

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

