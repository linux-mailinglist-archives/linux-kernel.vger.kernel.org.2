Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECBC840C5C6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 14:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234068AbhIOM6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 08:58:02 -0400
Received: from mail-oo1-f43.google.com ([209.85.161.43]:41659 "EHLO
        mail-oo1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233792AbhIOM56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 08:57:58 -0400
Received: by mail-oo1-f43.google.com with SMTP id b5-20020a4ac285000000b0029038344c3dso848912ooq.8;
        Wed, 15 Sep 2021 05:56:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=gKYGlH0sO8TMd2WVIji/0jovyk/z2Ux99qybCwIpXlQ=;
        b=yd0T5U38SifuRdNQWlOgZ4PhMeBzE/bYMeIt7PGfFUgfhg2YRMx5pYIgaHYpyXkhed
         or9TgXcvYab+/ufkx5x49TX+rEJPz7ChwPdkfO4IJwhQx4Nwqq7oict1G8ry+ltcxseU
         UrOmAKgRD+sVYxe86ZqjbjZpaJQJuWDPmlHP72+sGmvFJB2MeQIMD9uiPvjyAQKx9Vfy
         4BGBPq8QdOI1LO//ISlPSczFsnX/4ZLeQ/36vDjEoyTFRVasL54ewm29IWZfa0NC7XBS
         6lAm5IzaFg+00aTMvrE4IESKK+uqZViRVIkZ4v7iCuG55zssD1O8o6TYxO68xZwYEMTQ
         eezA==
X-Gm-Message-State: AOAM5305EevsJSfm0TW+MNApapfPXKdahhksBwb3Gx2d0afQjmJOjvrv
        ZHlGTkoG1ll6ooXHf7ucLQ==
X-Google-Smtp-Source: ABdhPJwBcKe6FAzzdW+JMZbCldPlFqnroA0QnWzgDYuWtAqow3T1pZVN7tgj38vcY4EpKsJ9xEj8Uw==
X-Received: by 2002:a4a:3944:: with SMTP id x4mr18293080oog.69.1631710599564;
        Wed, 15 Sep 2021 05:56:39 -0700 (PDT)
Received: from robh.at.kernel.org ([12.252.7.226])
        by smtp.gmail.com with ESMTPSA id i1sm3228028ooo.15.2021.09.15.05.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 05:56:38 -0700 (PDT)
Received: (nullmailer pid 935951 invoked by uid 1000);
        Wed, 15 Sep 2021 12:56:34 -0000
From:   Rob Herring <robh@kernel.org>
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
        linux-clk@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org
In-Reply-To: <20210915090945.250621-1-zhang.lyra@gmail.com>
References: <20210915090945.250621-1-zhang.lyra@gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: clk: sprd: Add bindings for ums512 clock controller
Date:   Wed, 15 Sep 2021 07:56:34 -0500
Message-Id: <1631710594.976170.935950.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Sep 2021 17:09:43 +0800, Chunyan Zhang wrote:
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> 
> Add a new bindings to describe ums512 clock compatible strings.
> 
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
>  .../bindings/clock/sprd,ums512-clk.yaml       | 106 ++++++++++++++++++
>  1 file changed, 106 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml:64:7: [warning] wrong indentation: expected 8 but found 6 (indentation)

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/clock/sprd,ums512-clk.example.dt.yaml:0:0: /example-1/syscon@71000000: failed to match any schema with compatible: ['sprd,ums512-glbregs', 'syscon', 'simple-mfd']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1528270

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

