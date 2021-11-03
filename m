Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD9F5444226
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 14:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbhKCNIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 09:08:50 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:44590 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbhKCNIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 09:08:48 -0400
Received: by mail-oi1-f172.google.com with SMTP id bk26so2291185oib.11;
        Wed, 03 Nov 2021 06:06:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=PpBLDGAp8QAvqjVk/77K3sJy+V3+g4vLOJungInEx8s=;
        b=fjAcvMdJFz4wwXD0/evE2Sn3iY8b0Oxfh0g2rdBu/6a1zpLK80PZC7GvWg0BqpxSk9
         Ua/0qYk7fJE1LLKPLrI3cqeU0493qPlmAN4Cho/yZgmiR44fRsPplDYHtSxOBnpV6AwF
         xfCHaldHX6vyyEpzxy2DsMQrK9gYUXobwvVP3tylHNqsfHwSWuY4khdtTUVQ87y3kgrG
         rfrxvmr7EmuFEtR/54wZzy26yb9jPbDUiQts3dsq7Pwl6Y8h8fa/3ti7Efp3pvHNx4HB
         C74bRGMLFeiiWgKbn+oW15cVlu3JYEMWhrOiUKKchgPnT3bttJ9orTErnHGqfJhL1QQH
         TGwQ==
X-Gm-Message-State: AOAM530eBkK5006QiuXVoisJ9X/47/h+/2RK1eiJaHsFN/S31YUUcMMv
        jbGkPRggyQhmN2yjSM+WUfaOj7nnMw==
X-Google-Smtp-Source: ABdhPJyimSDWGg7KmzU+bES0naA0vbL8UJTrICx8Ayuqdr4L7/WXY+qc6zcOsBE8Tr46lUwg1uGHXw==
X-Received: by 2002:a05:6808:d4a:: with SMTP id w10mr10540555oik.168.1635944772004;
        Wed, 03 Nov 2021 06:06:12 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id az10sm504163oib.45.2021.11.03.06.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 06:06:11 -0700 (PDT)
Received: (nullmailer pid 1040289 invoked by uid 1000);
        Wed, 03 Nov 2021 13:06:10 -0000
From:   Rob Herring <robh@kernel.org>
To:     James Lo <james.lo@mediatek.com>
Cc:     linux-kernel@vger.kernel.org,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, srv_heupstream@mediatek.com,
        linux-mediatek@lists.infradead.org
In-Reply-To: <20211103081021.9917-3-james.lo@mediatek.com>
References: <20211103081021.9917-1-james.lo@mediatek.com> <20211103081021.9917-3-james.lo@mediatek.com>
Subject: Re: [RESEND, v13 2/4] dt-bindings: spmi: document binding for the Mediatek SPMI controller
Date:   Wed, 03 Nov 2021 08:06:10 -0500
Message-Id: <1635944770.215632.1040288.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Nov 2021 16:10:19 +0800, James Lo wrote:
> This adds documentation for the SPMI controller found on Mediatek SoCs.
> 
> Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> ---
>  .../bindings/spmi/mtk,spmi-mtk-pmif.yaml      | 76 +++++++++++++++++++
>  1 file changed, 76 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-pmif.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-pmif.example.dt.yaml: spmi@10027000: reg: [[268595200, 3584], [268603392, 256]] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-pmif.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-pmif.example.dt.yaml: spmi@10027000: reg: [[268595200, 3584], [268603392, 256]] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spmi/spmi.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1550144

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

