Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5D7F3435E8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 01:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbhCVAQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 20:16:01 -0400
Received: from mail-il1-f173.google.com ([209.85.166.173]:35686 "EHLO
        mail-il1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbhCVAPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 20:15:43 -0400
Received: by mail-il1-f173.google.com with SMTP id 19so13296090ilj.2;
        Sun, 21 Mar 2021 17:15:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=2p8ffVaXunSY0rD5RmA2O4dVidEFGcmIDp/dRcWKRlA=;
        b=JmYFlOTclbFkapNXCV3ocrlokoBSANUVB/jyB1ZXaCQj1VVHfNFAv1ma5eD+/pQvnc
         PnIm7OblF6vDdHUQPiEnO9Z8BS0EBcIzU259+A87HcP0Hx573jEUDvkCj8XyE81Wyd8t
         cr3cE20HXk93VoKzyzLZa535SXaQeZMoeprOpSztospg8E5Ksw/keV/QRgcovIgTMNk+
         2KVcNd79cKLUCPie1FqtJLipGZ6H5j7rLUS95LLo4yQ27c2CiyPdMhnzgAAhjQCCwqFx
         rZCYrYh58bRP4Kr71tKj14SRlgqopQdlqLEcQpRZPNBByksSZLLqsijX/trtOBrkDlkJ
         BEwg==
X-Gm-Message-State: AOAM532R+ZmR9suSB38qHGoleI4kdOcf0To7UszpRAUqaJ2TXavIW+Vc
        8FnqwbT9yvQA2k2W0lc66rr54qP7aA==
X-Google-Smtp-Source: ABdhPJym/CCY6jjOTsz3gxOpR8jeyAZaxl8iAnBVd4+RbPKLB/UBSaczZ+zg/E65aTopWIGPitGYeA==
X-Received: by 2002:a05:6e02:13cf:: with SMTP id v15mr9627756ilj.118.1616372143214;
        Sun, 21 Mar 2021 17:15:43 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id h193sm6809907iof.9.2021.03.21.17.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 17:15:42 -0700 (PDT)
Received: (nullmailer pid 1475029 invoked by uid 1000);
        Mon, 22 Mar 2021 00:15:37 -0000
From:   Rob Herring <robh@kernel.org>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Hector Martin <marcan@marcan.st>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Stan Skowronek <stan@corellium.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>, Will Deacon <will@kernel.org>
In-Reply-To: <20210320151903.60759-3-sven@svenpeter.dev>
References: <20210320151903.60759-1-sven@svenpeter.dev> <20210320151903.60759-3-sven@svenpeter.dev>
Subject: Re: [PATCH 2/3] dt-bindings: iommu: add DART iommu bindings
Date:   Sun, 21 Mar 2021 18:15:37 -0600
Message-Id: <1616372137.246877.1475028.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Mar 2021 15:20:08 +0000, Sven Peter wrote:
> DART (Device Address Resolution Table) is the iommu found on Apple
> ARM SoCs such as the M1.
> 
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>  .../bindings/iommu/apple,t8103-dart.yaml      | 82 +++++++++++++++++++
>  MAINTAINERS                                   |  6 ++
>  2 files changed, 88 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iommu/apple,t8103-dart.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/iommu/apple,t8103-dart.example.dts:23.25-26 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:349: Documentation/devicetree/bindings/iommu/apple,t8103-dart.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1380: dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1456122

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

