Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABFEC3FD936
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 14:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243961AbhIAMHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 08:07:20 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:34574 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243892AbhIAMHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 08:07:19 -0400
Received: by mail-oi1-f176.google.com with SMTP id p2so3472584oif.1;
        Wed, 01 Sep 2021 05:06:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=M3T4yrG7zQ/orfLEy+dtJ3O+/bOtwc3PAJxag5037YY=;
        b=Y94kWbvkLYdY2bRatqcp5WgSdza4ADOnN2HbXfw9djkizzbZhtafVNZ0KLLO1thxPk
         y0ZVEAxKhNEg77WfM06MzkbeFEe005i28NyFYjoNs3fKkZpcVXPDWJc+DEpVwckP36HW
         txgPYvqa1pMPQlMC7pfnqQWeAfEIDEGudrU5CBuECjfuwtv/cEKMqSRZiCQole/FQwoX
         kmQDjgqRZvARQDv9A5vgqXb/LoBVm5UUtf8I6aKY4UdDkofWqbSe4BBwFVxRUr9kDorM
         DTDu4pcNZmoIbcvuc0cKi5v/98CFOHL2Fmt0ENirMJOtxKebU9saYSEnOriq1nHTVUXk
         bfiA==
X-Gm-Message-State: AOAM5304JisrW6rXQ7UAfHtS6W/m4J90iNMtba3okjZcN+Oji1O2HFQt
        /Q6B0VErHazK+iWbBwgUWQ==
X-Google-Smtp-Source: ABdhPJwunR5Oi9U858lSr+FGBBEaPHCwSaIHZ8qexSKC4A6YcEqQPvtO7EN46LQRqXcwBNS1fp/c0Q==
X-Received: by 2002:aca:b80b:: with SMTP id i11mr6967474oif.26.1630497982327;
        Wed, 01 Sep 2021 05:06:22 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id v29sm4314843ooe.31.2021.09.01.05.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 05:06:21 -0700 (PDT)
Received: (nullmailer pid 1876487 invoked by uid 1000);
        Wed, 01 Sep 2021 12:06:19 -0000
From:   Rob Herring <robh@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-clk@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev, Maxime Ripard <mripard@kernel.org>
In-Reply-To: <20210901053951.60952-2-samuel@sholland.org>
References: <20210901053951.60952-1-samuel@sholland.org> <20210901053951.60952-2-samuel@sholland.org>
Subject: Re: [RFC PATCH 1/7] dt-bindings: rtc: sun6i: Add H616 and R329 compatibles
Date:   Wed, 01 Sep 2021 07:06:19 -0500
Message-Id: <1630497979.405519.1876486.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Sep 2021 00:39:45 -0500, Samuel Holland wrote:
> For these new SoCs, start requiring a complete list of input clocks.
> 
> For H616, this means bus, hosc, and pll-32k. For R329, this means ahb,
> bus, and hosc; and optionally ext-osc32k.
> 
> I'm not sure how to best represent this in the binding...
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>  .../bindings/rtc/allwinner,sun6i-a31-rtc.yaml | 55 +++++++++++++++++--
>  include/dt-bindings/clock/sun50i-rtc.h        | 12 ++++
>  2 files changed, 61 insertions(+), 6 deletions(-)
>  create mode 100644 include/dt-bindings/clock/sun50i-rtc.h
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Traceback (most recent call last):
  File "/usr/local/bin/dt-doc-validate", line 67, in <module>
    ret = check_doc(f)
  File "/usr/local/bin/dt-doc-validate", line 33, in check_doc
    for error in sorted(dtschema.DTValidator.iter_schema_errors(testtree), key=lambda e: e.linecol):
  File "/usr/local/lib/python3.8/dist-packages/dtschema/lib.py", line 723, in iter_schema_errors
    cls(meta_schema).annotate_error(error, meta_schema, error.schema_path)
  File "/usr/local/lib/python3.8/dist-packages/dtschema/lib.py", line 706, in annotate_error
    schema = schema[p]
KeyError: 'properties'
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/rtc/allwinner,sun6i-a31-rtc.yaml: ignoring, error in schema: allOf: 5: if: properties
warning: no schema found in file: ./Documentation/devicetree/bindings/rtc/allwinner,sun6i-a31-rtc.yaml
Documentation/devicetree/bindings/rtc/allwinner,sun6i-a31-rtc.example.dt.yaml:0:0: /example-0/rtc@1f00000: failed to match any schema with compatible: ['allwinner,sun6i-a31-rtc']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1522863

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

