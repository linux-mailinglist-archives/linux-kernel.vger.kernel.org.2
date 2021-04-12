Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6920F35C76B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 15:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239654AbhDLNU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 09:20:28 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:34656 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239287AbhDLNUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 09:20:22 -0400
Received: by mail-oi1-f178.google.com with SMTP id k18so8469020oik.1;
        Mon, 12 Apr 2021 06:20:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=lGbxJrFzMnc2Fx/IsvHpCVq0F6FhFOgQp1Mj1B5sJic=;
        b=ZD4Umn5+QWv0kqkO0zBrPDDcfnNFgpwjZ6lOS6pTAnPNdrusL9lnyosOA3qD4BcKqw
         RUYoJnzdP7FyoEPacrx/SMp6FEZ5vV82OiSuUUzuaiDltDhxsnnmmOHEESBgYbB7wVmo
         dFnaQ1GNEVkH3JDKPLsbCg9jTOFdBTz4hws+wKd/TLKdwxJMqbqMjrnv1ic5YPMyCjFb
         r/iEBqka7TzK9eaEOzlsxq5HTLKobTTB93HGBt6+6G1dczsXu5QndbOXGkNJojdDzd7u
         gPqFx6BVpMhZfeMztD2z5oPg+Y+Np7fAH3PJnZIiY3d8gB6q2DvxxQW0yrnHIApnym30
         eM1A==
X-Gm-Message-State: AOAM531zoAagsKcUNpVu2GZ0yi8sizOSyC49B0Tyo9AtFt1tJNB8MhKl
        9uiTUwz3+qm4F/0b/XNabg==
X-Google-Smtp-Source: ABdhPJwZndFkIsmVSZKsOGhLjyxjuNqKh1d0bmVhKTaHx1jRM6l3+6e4iJWO8bm8em9IBSkpGj8/Sw==
X-Received: by 2002:aca:bc87:: with SMTP id m129mr19491514oif.29.1618233604163;
        Mon, 12 Apr 2021 06:20:04 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v205sm21386oie.16.2021.04.12.06.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 06:20:03 -0700 (PDT)
Received: (nullmailer pid 3757978 invoked by uid 1000);
        Mon, 12 Apr 2021 13:20:00 -0000
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        matthias.bgg@gmail.com, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org
In-Reply-To: <20210412093928.3321194-2-narmstrong@baylibre.com>
References: <20210412093928.3321194-1-narmstrong@baylibre.com> <20210412093928.3321194-2-narmstrong@baylibre.com>
Subject: Re: [PATCH v2 1/5] dt-bindings: display: mediatek, hdmi: Convert to use graph schema
Date:   Mon, 12 Apr 2021 08:20:00 -0500
Message-Id: <1618233600.211900.3757977.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Apr 2021 11:39:24 +0200, Neil Armstrong wrote:
> Update the mediatek,dpi binding to use the graph schema.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../display/mediatek/mediatek,cec.yaml        |  51 +++++++
>  .../display/mediatek/mediatek,hdmi-ddc.yaml   |  57 ++++++++
>  .../display/mediatek/mediatek,hdmi.txt        | 136 ------------------
>  .../display/mediatek/mediatek,hdmi.yaml       | 131 +++++++++++++++++
>  4 files changed, 239 insertions(+), 136 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,cec.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi-ddc.yaml
>  delete mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi.txt
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi-ddc.example.dt.yaml:0:0: /example-0/i2c@11012000: failed to match any schema with compatible: ['mediatek,mt8173-hdmi-ddc']
Documentation/devicetree/bindings/display/mediatek/mediatek,cec.example.dt.yaml:0:0: /example-0/cec@10013000: failed to match any schema with compatible: ['mediatek,mt8173-cec']

See https://patchwork.ozlabs.org/patch/1465094

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

