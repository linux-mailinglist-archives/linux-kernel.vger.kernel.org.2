Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA293CD613
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 15:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240639AbhGSNHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 09:07:15 -0400
Received: from mail-io1-f41.google.com ([209.85.166.41]:46904 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240613AbhGSNHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 09:07:13 -0400
Received: by mail-io1-f41.google.com with SMTP id p186so19974780iod.13;
        Mon, 19 Jul 2021 06:47:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=nB7ZbOI4FSqOXAkmTXEXRF7DouorW1hBCYJ08VwaO2s=;
        b=nxAIu957UUXQnz+Jcs7dKOG9EIvu0hThdTUUnb30Q0Xan6ANexU4PkiSeKwCoRgxoy
         PRcCkbATNNY2e/4pABRGHRFdV16IrHN/YIXGLKPm5Bwtyxim2WZVFE4MjyQSJOMKkxqF
         6SpuIU9J2jYMX8+ro5aBBQ0j1zWqz8cq8TIWFOTxXx3wGBDT/PRWdYEKwraxmjR1iHe9
         L1enSKWT5svgDO75vFf6UkC2OCLZWUcyy+AXd1jJP3xYiP6SHDGKRMgNVw/gu3buhQhx
         GR6bCwEuEoD8iNQ4WMr4Hq/ehR2FbgjPWlvzUBsVam5HfBjJQa+VnUjReo34byWUaN/H
         5Hdw==
X-Gm-Message-State: AOAM532saOaysgJjTMxwo2+o34b25zHdwZJcot4CIT+wtFV+Wx/2qi/N
        Hw1Exv8scLf8KM586/UXuILOs35h4g==
X-Google-Smtp-Source: ABdhPJwl5Zs9DRWfyfq3WglySNJdiDOiGOS0fbLkd5bzj2ohOzH+U0VYjM83iptp+U9oi5SI107XyQ==
X-Received: by 2002:a05:6602:10e:: with SMTP id s14mr19479252iot.52.1626702472026;
        Mon, 19 Jul 2021 06:47:52 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id m1sm10882067iok.33.2021.07.19.06.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 06:47:51 -0700 (PDT)
Received: (nullmailer pid 1811204 invoked by uid 1000);
        Mon, 19 Jul 2021 13:47:28 -0000
From:   Rob Herring <robh@kernel.org>
To:     Apurva Nandan <a-nandan@ti.com>
Cc:     Pratyush Yadav <p.yadav@ti.com>, Michael Walle <michael@walle.cc>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210718004125.733-1-a-nandan@ti.com>
References: <20210718004125.733-1-a-nandan@ti.com>
Subject: Re: [PATCH] dt-bindings: mtd: spi-nand: Convert to DT schema format
Date:   Mon, 19 Jul 2021 07:47:28 -0600
Message-Id: <1626702448.437777.1811203.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Jul 2021 00:41:25 +0000, Apurva Nandan wrote:
> Convert spi-nand.txt binding to YAML format with an added example.
> 
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> ---
>  .../devicetree/bindings/mtd/spi-nand.txt      |  5 --
>  .../devicetree/bindings/mtd/spi-nand.yaml     | 74 +++++++++++++++++++
>  2 files changed, 74 insertions(+), 5 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mtd/spi-nand.txt
>  create mode 100644 Documentation/devicetree/bindings/mtd/spi-nand.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.example.dt.yaml: spi-flash@1: $nodename:0: 'spi-flash@1' does not match '^flash(@.*)?$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/spi-nand.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.example.dt.yaml: spi-flash@1: 'rx-sample-delay-ns' does not match any of the regexes: '^otp(-[0-9]+)?$', '^partition@', 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/spi-nand.yaml
\ndoc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1506558

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

