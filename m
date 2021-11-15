Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 899064505E3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 14:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbhKONr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 08:47:27 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:39728 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbhKONp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 08:45:58 -0500
Received: by mail-ot1-f45.google.com with SMTP id r10-20020a056830080a00b0055c8fd2cebdso27526109ots.6;
        Mon, 15 Nov 2021 05:42:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=1XUBk5dND8WMgCnXdXyvWeYm6VJhK9ji7tENzoDG3gg=;
        b=1A5gorZloK3w5ooVojngowFnx3GYMNafttABd9EtV3Qy0Dih54Lwkm+vZbtPhkB5WY
         NyrdrbwgDxO2c9zbzdW7oApalfGsqA0Ax3Hx7ctwArP0GKAeRFbWxhOXzD+R66p//Dl6
         TYSU9C44HtCAEqmQzeDs1xXuIXJm3b07Sr/rj0VlFp/bnna8CO6FdJ+lsjXSif9cUk8p
         0tVsDi70tOkVWF34LngGzSlvasXgFpM/ogxINRSFkKJhwPXBB5EgHn3qR1am8CojIih2
         iQQ4IVid83jdmb+NiuZFg1PwKsoE5U4xHPODLZrKoBU/02t6kyqZvX2+sJI+wFbfkB1X
         d9KQ==
X-Gm-Message-State: AOAM530NNkZELvh8QVB7KSb9BLV1rtW4mzzvfVsJzdZjYUPyDTdtldL+
        elnwFolHNoF8Lp8dXdv0GQ==
X-Google-Smtp-Source: ABdhPJwjLQPGbiNHm2MtihChqN7jAyE1W7XudAKR26/0iCsaIZo9ezOTSDEjak404pOwjMT6GOth7A==
X-Received: by 2002:a05:6830:4a3:: with SMTP id l3mr27726777otd.229.1636983757695;
        Mon, 15 Nov 2021 05:42:37 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 9sm3095876oij.16.2021.11.15.05.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 05:42:37 -0800 (PST)
Received: (nullmailer pid 595908 invoked by uid 1000);
        Mon, 15 Nov 2021 13:42:35 -0000
From:   Rob Herring <robh@kernel.org>
To:     James Lo <james.lo@mediatek.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        srv_heupstream@mediatek.com, Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20211115042030.30293-3-james.lo@mediatek.com>
References: <20211115042030.30293-1-james.lo@mediatek.com> <20211115042030.30293-3-james.lo@mediatek.com>
Subject: Re: [PATCH v15 2/4] dt-bindings: spmi: document binding for the Mediatek SPMI controller
Date:   Mon, 15 Nov 2021 07:42:35 -0600
Message-Id: <1636983755.172933.595907.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Nov 2021 12:20:28 +0800, James Lo wrote:
> This adds documentation for the SPMI controller found on Mediatek SoCs.
> 
> Signed-off-by: James Lo <james.lo@mediatek.com>
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
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spmi/spmi.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-pmif.example.dt.yaml: spmi@10027000: reg: [[268595200, 3584], [268603392, 256]] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-pmif.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1555114

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

