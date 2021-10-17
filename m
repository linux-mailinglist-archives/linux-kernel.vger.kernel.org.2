Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84686430A0C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 17:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343970AbhJQPbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 11:31:51 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:46747 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343951AbhJQPbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 11:31:42 -0400
Received: by mail-oi1-f177.google.com with SMTP id o204so20904699oih.13;
        Sun, 17 Oct 2021 08:29:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=VPU+IFl4rLLYv2sOarpRyTDAHLleEPGL84WnvEUxC44=;
        b=s77MQEFjHOULeR0ph38LxG3+9kxVfaroSOtX7HyFcwmZI7IrBl6yGgU7VxzUxduF4o
         oWJddGNWqgSAyqxt69tvtbJlBk8+xJaGO1m7Kt0jq9xPzKQ+TWClxrvc7v89NYL3y6nx
         NnkqQQV504NyAGfFNg1wNXiuX9TR83FLYdnhJQiOqRb+ya24lErNbRP+o347UeeamEYU
         05329icYrmHyxcCs+UGUnjrUIZrCJIAsBQNGBuns5BNl/bacSJRjr0OC4TA+GqP253gF
         XludXQNvZA54NjpAH9sPV9ZEqL6vxkoAJaGAJ320RnC/Ti9NK6e50TtonQBW7wKY6V82
         GI/A==
X-Gm-Message-State: AOAM532QSMfp7vPVx9Zts01iCCIMQEK6ExF0bbn7HHGchaB4ZDYBd/kh
        YjUzwr90Guws4pJPGQdviw==
X-Google-Smtp-Source: ABdhPJzZtyYhtqoQxXXNOcJqBlvAp1S6x2o7gQ2wmOrzqos7znUppF8Htr+idDdtScuGYSuiUBGRGQ==
X-Received: by 2002:aca:ea83:: with SMTP id i125mr24646331oih.26.1634484572722;
        Sun, 17 Oct 2021 08:29:32 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id be2sm2653931oib.1.2021.10.17.08.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 08:29:31 -0700 (PDT)
Received: (nullmailer pid 60702 invoked by uid 1000);
        Sun, 17 Oct 2021 15:29:30 -0000
From:   Rob Herring <robh@kernel.org>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mark Kettenis <kettenis@openbsd.org>,
        Stan Skowronek <stan@corellium.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Mark Kettenis <mark.kettenis@xs4all.nl>
In-Reply-To: <20211017114054.67737-2-sven@svenpeter.dev>
References: <20211017114054.67737-1-sven@svenpeter.dev> <20211017114054.67737-2-sven@svenpeter.dev>
Subject: Re: [PATCH v3 1/2] dt-bindings: mailbox: Add Apple mailbox bindings
Date:   Sun, 17 Oct 2021 10:29:30 -0500
Message-Id: <1634484570.833028.60701.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Oct 2021 13:40:53 +0200, Sven Peter wrote:
> Apple mailbox controller are found on the M1 and are used for
> communication with various co-processors.
> 
> Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> Reviewed-by: Mark Kettenis <kettenis@openbsd.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>  .../bindings/mailbox/apple,mailbox.yaml       | 79 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 80 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml: properties:interrupts: 'oneOf' conditional failed, one must be fixed:
	[{'description': 'send fifo is empty interrupt'}, {'description': 'send fifo is not empty interrupt'}, {'description': 'receive fifo is empty interrupt'}, {'description': 'receive fifo is not empty interrupt'}] is too long
	[{'description': 'send fifo is empty interrupt'}, {'description': 'send fifo is not empty interrupt'}, {'description': 'receive fifo is empty interrupt'}, {'description': 'receive fifo is not empty interrupt'}] is too short
	False schema does not allow 4
	1 was expected
	4 is greater than the maximum of 2
	4 is greater than the maximum of 3
	hint: "minItems" is only needed if less than the "items" list length
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml: properties:interrupt-names: 'oneOf' conditional failed, one must be fixed:
	[{'const': 'send-empty'}, {'const': 'send-not-empty'}, {'const': 'recv-empty'}, {'const': 'recv-not-empty'}] is too long
	[{'const': 'send-empty'}, {'const': 'send-not-empty'}, {'const': 'recv-empty'}, {'const': 'recv-not-empty'}] is too short
	False schema does not allow 4
	1 was expected
	4 is greater than the maximum of 2
	4 is greater than the maximum of 3
	hint: "minItems" is only needed if less than the "items" list length
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml: ignoring, error in schema: properties: interrupts
warning: no schema found in file: ./Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
Documentation/devicetree/bindings/mailbox/apple,mailbox.example.dt.yaml:0:0: /example-0/mailbox@77408000: failed to match any schema with compatible: ['apple,t8103-asc-mailbox']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1542209

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

