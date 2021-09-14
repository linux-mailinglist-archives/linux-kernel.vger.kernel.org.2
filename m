Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF3C40AE8B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 15:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbhINNGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 09:06:09 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:40609 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233329AbhINNEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 09:04:35 -0400
Received: by mail-ot1-f47.google.com with SMTP id l16-20020a9d6a90000000b0053b71f7dc83so18244883otq.7;
        Tue, 14 Sep 2021 06:03:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=qnHLQlvfnxtVztuIYHK3ms7723UZCgnD6L/P89ZAJ0Q=;
        b=NhDQPE8Fx0+1ADnFh1H/eyZWwGtX/ssqeJ0VkuXriie1dZipkBsCPolkBw6+VMtPWz
         OL+SPSwZf9Fvz+/PMTwvbTTKGxw1OIPONyP/XxnL3Ss7ivJQ2PsOwXJGFqcJ7LEjrQ90
         tZKbqck/t2VGaCUTz4suBy/v8BsUmD/ONm1zxiqifxTLKi2cugru3qNK8GrRc7OomHa0
         QVzLdQ7pBsy+Fn8PulGjLaCe37mU6YBEvpAKTb9dkkbawvXjO/spHq9zq8Q+gjm3uRjU
         sBtocPgP6d7Q/MR9Cd2grnidqlohSdOyib49BvpYBSk8Why+o9bNb3hCqTx86YCgNNJL
         RA0A==
X-Gm-Message-State: AOAM532E3EBefG/2gecwnuXXY8MzZbTNSwGkd3lfCPsc/zTip4NWCX4W
        BXEcPzUaXlI21KKch09Wzg==
X-Google-Smtp-Source: ABdhPJx3NHf07YIw3RCc7Pa9JkTx4rPLNld3KvTBFvKz5sEfnX7HKpFTXMjEwHTpGXsdoYsDROG6Aw==
X-Received: by 2002:a05:6830:78c:: with SMTP id w12mr14116178ots.196.1631624597467;
        Tue, 14 Sep 2021 06:03:17 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 99sm2628745otd.2.2021.09.14.06.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 06:03:15 -0700 (PDT)
Received: (nullmailer pid 3002728 invoked by uid 1000);
        Tue, 14 Sep 2021 13:03:14 -0000
From:   Rob Herring <robh@kernel.org>
To:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc:     srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20210914090338.5945-3-hsin-hsiung.wang@mediatek.com>
References: <20210914090338.5945-1-hsin-hsiung.wang@mediatek.com> <20210914090338.5945-3-hsin-hsiung.wang@mediatek.com>
Subject: Re: [PATCH v12 2/5] dt-bindings: spmi: document binding for the Mediatek SPMI controller
Date:   Tue, 14 Sep 2021 08:03:14 -0500
Message-Id: <1631624594.142122.3002727.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Sep 2021 17:03:35 +0800, Hsin-Hsiung Wang wrote:
> This adds documentation for the SPMI controller found on Mediatek SoCs.
> 
> Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> ---
> changes since v11:
> - No change.
> ---
>  .../bindings/spmi/mtk,spmi-mtk-pmif.yaml      | 76 +++++++++++++++++++
>  1 file changed, 76 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-pmif.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-pmif.example.dt.yaml: example-0: spmi@10027000:reg:0: [0, 268595200, 0, 3584] is too long
	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-pmif.example.dt.yaml: example-0: spmi@10027000:reg:1: [0, 268603392, 0, 256] is too long
	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-pmif.example.dt.yaml: spmi@10027000: reg: [[0, 268595200, 0, 3584], [0, 268603392, 0, 256]] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spmi/spmi.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-pmif.example.dt.yaml: spmi@10027000: reg: [[0, 268595200, 0, 3584], [0, 268603392, 0, 256]] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-pmif.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1527797

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

