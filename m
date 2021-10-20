Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7222A434CAB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 15:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbhJTNwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 09:52:46 -0400
Received: from mail-oi1-f180.google.com ([209.85.167.180]:34337 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbhJTNwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 09:52:43 -0400
Received: by mail-oi1-f180.google.com with SMTP id v77so9730392oie.1;
        Wed, 20 Oct 2021 06:50:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=jLTSb3KEYnCRlQ01oYFy7OkpNs2aWBBSeM7tBxCTpD8=;
        b=g64d079oc9lbqRRJ7oi83yfyxrxyqlCQKwC3Kk4TqbNK9GePrr3hAsGZoXdu+s3dMg
         Oc35EoPuqSJn4Bh4k8186/6p6es6UR2Y+JZT7YDF7qGOpFpptrunp6nqDKaR33/HftYN
         RuHAJ9lsHqu4ieMBTetK08+FR/BLPrxi17jIPUOWrztgM557nPiuVTihoJ6xoR+Csjtg
         Mk07SOl07dobALCeOrHMkpAd3bSNbk6fWtmUX2lT+nsyZEmidOY/3qoqzntq5WmNCpL0
         2/umzAzycXVsqYWKC8g6APQONyOA4Mk57P9DlNWV3JrFe9nLmfZizKvNPkWWYiJY4K+q
         yTOg==
X-Gm-Message-State: AOAM531wzx4K7PWggM/fKVvGmbdjDIU3wwC3aniaPNnICegTiAu9NPbc
        GLrxJyqRbhZRfvwdEs/TZA==
X-Google-Smtp-Source: ABdhPJwS8b8/9bct2qZ/+hc4vStE7P565pOQsKf7sXcrPBm2vGWkW+CqezjlGdG+8JVNIlAgfkiBiA==
X-Received: by 2002:aca:3741:: with SMTP id e62mr9560890oia.107.1634737827694;
        Wed, 20 Oct 2021 06:50:27 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id v13sm488307otn.41.2021.10.20.06.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 06:50:26 -0700 (PDT)
Received: (nullmailer pid 2259920 invoked by uid 1000);
        Wed, 20 Oct 2021 13:50:23 -0000
From:   Rob Herring <robh@kernel.org>
To:     YC Hung <yc.hung@mediatek.com>
Cc:     linux-kernel@vger.kernel.org, broonie@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, daniel.baluta@nxp.com,
        allen-kh.cheng@mediatek.com, trevor.wu@mediatek.com,
        tiwai@suse.com, matthias.bgg@gmail.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org
In-Reply-To: <20211020115155.9909-3-yc.hung@mediatek.com>
References: <20211020115155.9909-1-yc.hung@mediatek.com> <20211020115155.9909-3-yc.hung@mediatek.com>
Subject: Re: [PATCH 2/2] dt-bindings: dsp: mediatek: Add mt8195 DSP binding support
Date:   Wed, 20 Oct 2021 08:50:23 -0500
Message-Id: <1634737823.680277.2259919.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Oct 2021 19:51:55 +0800, YC Hung wrote:
> This describes the mt8195 DSP device tree node.
> 
> Signed-off-by: YC Hung <yc.hung@mediatek.com>
> ---
>  .../bindings/dsp/mtk,mt8195-dsp.yaml          | 138 ++++++++++++++++++
>  1 file changed, 138 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dsp/mtk,mt8195-dsp.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dsp/mtk,mt8195-dsp.yaml: properties:sound: 'anyOf' conditional failed, one must be fixed:
	'type' is a required property
	'$ref' is a required property
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dsp/mtk,mt8195-dsp.yaml: ignoring, error in schema: properties: sound
warning: no schema found in file: ./Documentation/devicetree/bindings/dsp/mtk,mt8195-dsp.yaml
Documentation/devicetree/bindings/dsp/mtk,mt8195-dsp.example.dt.yaml:0:0: /example-0/adsp@10803000: failed to match any schema with compatible: ['mediatek,mt8195-dsp']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1543854

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

