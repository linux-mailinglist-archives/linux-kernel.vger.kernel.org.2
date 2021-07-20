Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 198153CFA3A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 15:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236671AbhGTMcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 08:32:21 -0400
Received: from mail-io1-f49.google.com ([209.85.166.49]:46046 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbhGTMbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 08:31:32 -0400
Received: by mail-io1-f49.google.com with SMTP id z17so17256156iog.12;
        Tue, 20 Jul 2021 06:12:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=abnffZ4MtGwQDAxtUagurofgQJnEps8wWqmtotQHpvs=;
        b=fa7LAoKIML1VN/kQnUU+Nw8tlF6JMazIz/qcgY06QVzyFZ6O7AzEKrfpn5RnTJwVJD
         8IceekUVCVdLAwNn89ELuGRFIYOP5dOnRUqr4HcxBLuaGxtp8TEQmAOb4skJYtnBEscX
         4I62F6NIU2jiQgwkKUd4VALWMibd+hMxm18fgt7I8MDYd0BAOvqYD+MxtwLNZq7HvKcm
         L/vQ462FkArCyHtF5gOnA2t0Qwl4twHYkwLkr7xmhqbTpFpf7NP/dfcvUHlswoTr/JTg
         p2JX+lph2/LFXLRIf+CHXHSRy1PRIhAbWU3XLbFh8SKveoBnSti/S4RYCdTMcVjnWeKh
         RTHA==
X-Gm-Message-State: AOAM531iXs/bxNnMJ4TdCjHMCwgWllUXpukYVYcW3pS+2prNQZXNWBi8
        fgE13e2K8dHUe0t6JyEsbw==
X-Google-Smtp-Source: ABdhPJyKoIf00du5/ZAkd1mRiGtw0/iyDLxUKFdDVMCyrHFwePjpZT3XzrY/eI4EnXfeG3vsDsFrug==
X-Received: by 2002:a05:6602:1814:: with SMTP id t20mr18779191ioh.204.1626786729379;
        Tue, 20 Jul 2021 06:12:09 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id r4sm11231806ilb.42.2021.07.20.06.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 06:12:08 -0700 (PDT)
Received: (nullmailer pid 4121606 invoked by uid 1000);
        Tue, 20 Jul 2021 13:11:58 -0000
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>, linuxarm@huawei.com,
        mauro.chehab@huawei.com, Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>
In-Reply-To: <04943d3dff73e2fd5c9336540cb31d70ccf7b9cf.1626768323.git.mchehab+huawei@kernel.org>
References: <cover.1626768323.git.mchehab+huawei@kernel.org> <04943d3dff73e2fd5c9336540cb31d70ccf7b9cf.1626768323.git.mchehab+huawei@kernel.org>
Subject: Re: [PATCH v6 5/9] dt-bindings: phy: Add bindings for HiKey 970 PCIe PHY
Date:   Tue, 20 Jul 2021 07:11:58 -0600
Message-Id: <1626786718.742548.4121605.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jul 2021 10:09:07 +0200, Mauro Carvalho Chehab wrote:
> Document the bindings for HiKey 970 (hi3670) PCIe PHY
> interface, supported via the pcie-kirin driver.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  .../phy/hisilicon,phy-hi3670-pcie.yaml        | 98 +++++++++++++++++++
>  1 file changed, 98 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/hisilicon,phy-hi3670-pcie.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/hisilicon,phy-hi3670-pcie.example.dt.yaml: pcie-phy@fc000000: 'reg-names' does not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/hisilicon,phy-hi3670-pcie.yaml
\ndoc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1507427

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

