Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B70241C5F8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 15:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344332AbhI2NsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 09:48:17 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:44584 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344271AbhI2NsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 09:48:10 -0400
Received: by mail-ot1-f51.google.com with SMTP id h9-20020a9d2f09000000b005453f95356cso2872954otb.11;
        Wed, 29 Sep 2021 06:46:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=OCt6A/PQC+USQdnm5J8GnEXuMhJ+RqhU0u1UJM6OlKM=;
        b=cgDwB/bIWoaqpwjThU7H2w3d0knGw1DXMgSVJtF+XMmKAx3dNducjw3/MU1fGd6rur
         H2z3hA21Ar6U+2v6H4OPEwXyJ9Smuwz2EJPJ1E8H9IefoX9Ufl46nhAgKRFIStfqnHWX
         CGNxL0pyL2upQSpPUr4tfkwmzt2MBJt6lxcDNjbEHA35htaMxrWhtX34ShRvsmckJFKS
         X1sfoKLyMU8eXwW+d/JP5ut7M6Q8AUoKigsUxS2y5hboKOgvRA7r5aQc5k2XwEjw5Ffz
         qaJ4ta4HCbwQ+L2S57nI23S75p4Ei0HLuWiRcvEHg0cpK7kHWeI1VRAx8BHiQiE7DBxj
         1A0w==
X-Gm-Message-State: AOAM532SDdjwjk4l5gsv6vy1LR3tr4/NdK43EzqVuHt9ScHn8luLIRAy
        L8ao08etwHeWbywyLd4xWw==
X-Google-Smtp-Source: ABdhPJz/BHhDl0VbMiUoiKubksea3lnYfFtqBu5/Mu6JI4wQMVxRosXYvYLsRHQDW2GiEYK59cdHBA==
X-Received: by 2002:a9d:6a4c:: with SMTP id h12mr81568otn.336.1632923189057;
        Wed, 29 Sep 2021 06:46:29 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id o62sm459542ota.14.2021.09.29.06.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 06:46:28 -0700 (PDT)
Received: (nullmailer pid 3674449 invoked by uid 1000);
        Wed, 29 Sep 2021 13:46:25 -0000
From:   Rob Herring <robh@kernel.org>
To:     Guillaume Ranquet <granquet@baylibre.com>
Cc:     linux-mediatek@lists.infradead.org, chunkuang.hu@kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        p.zabel@pengutronix.de, Daniel Vetter <daniel@ffwll.ch>,
        CK Hu <ck.hu@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
        Jitao shi <jitao.shi@mediatek.com>, devicetree@vger.kernel.org
In-Reply-To: <20210929094425.745-3-granquet@baylibre.com>
References: <20210929094425.745-1-granquet@baylibre.com> <20210929094425.745-3-granquet@baylibre.com>
Subject: Re: [PATCH v1 2/4] dt-bindings: display: mediatek: add MT8195 hdmi bindings
Date:   Wed, 29 Sep 2021 08:46:25 -0500
Message-Id: <1632923185.744834.3674448.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Sep 2021 11:44:23 +0200, Guillaume Ranquet wrote:
> Add Mediatek HDMI and HDMI-DDC bindings for MT8195 SoC.
> 
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> ---
>  .../mediatek/mediatek,mt8195-hdmi-ddc.yaml    | 45 +++++++++
>  .../mediatek/mediatek,mt8195-hdmi.yaml        | 98 +++++++++++++++++++
>  2 files changed, 143 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,mt8195-hdmi-ddc.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,mt8195-hdmi.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/mediatek/mediatek,mt8195-hdmi.example.dt.yaml: example-0: hdmi@1c300000:reg:0: [0, 472907776, 0, 4096] is too long
	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/mediatek/mediatek,mt8195-hdmi.example.dt.yaml: hdmi@1c300000: 'ddc-i2c-bus', 'power-domains' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/mediatek/mediatek,mt8195-hdmi.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1534287

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

