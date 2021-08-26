Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 454E83F88DD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 15:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242737AbhHZN1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 09:27:18 -0400
Received: from mail-oi1-f171.google.com ([209.85.167.171]:42935 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242709AbhHZN04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 09:26:56 -0400
Received: by mail-oi1-f171.google.com with SMTP id bi4so749399oib.9;
        Thu, 26 Aug 2021 06:26:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=MVwvIDZK2/7Y4951WHMhhdQzU7LUf/3BWIAcj7PEAtg=;
        b=qNVwjG0oT0MOCfdbB6AWBEv2r468zxYqB1EqrdIZsnm1KCB88huX4jHvl1L1eyh/Wf
         7Uh7yrOo5o5wea3DGmpDGtYcDuS2D11RG9cr0t9Bpf6kp/sL16Cu8LmzYBFxpjQil0zI
         aFb3oD1nkhpImS5rKyC/zZBljBdyyn4nDwkzrR67j3j2sbmv+jES1AIYvB0o4LFMXWzv
         B6wvHa4gx1ULbCs6cIZh8QdD+NviRP+BX9Ijkb5exHK5q+URJdGX+KupyZWR3qu61LUz
         GW2bZdUNeLi0IgID8eXCPeNtX+03zQyXVGrFjOVtjVkloj/AcXdSlvM0C7XyBj7MsbUk
         nbtQ==
X-Gm-Message-State: AOAM531VdCNqqP8H48HvMZj3dLStyavyN/qNmqUgcZXrA8QY33oErm58
        JkqMIOUPP2YZmYFWym2D3g==
X-Google-Smtp-Source: ABdhPJxQgh36d/Z8oPQJ2kZdPSroKU7uJI2G1etE76FJfI7pF24X/EZtJ5/N57d2bHja0Z6MHeT+MA==
X-Received: by 2002:aca:b808:: with SMTP id i8mr10141154oif.62.1629984368953;
        Thu, 26 Aug 2021 06:26:08 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id x1sm554628otu.8.2021.08.26.06.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 06:26:07 -0700 (PDT)
Received: (nullmailer pid 1033392 invoked by uid 1000);
        Thu, 26 Aug 2021 13:26:01 -0000
From:   Rob Herring <robh@kernel.org>
To:     Yifeng Zhao <yifeng.zhao@rock-chips.com>
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-phy@lists.infradead.org, vkoul@kernel.org, heiko@sntech.de,
        michael.riesch@wolfvision.net, kishon@ti.com,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        p.zabel@pengutronix.de, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20210826123844.8464-2-yifeng.zhao@rock-chips.com>
References: <20210826123844.8464-1-yifeng.zhao@rock-chips.com> <20210826123844.8464-2-yifeng.zhao@rock-chips.com>
Subject: Re: [PATCH v1 1/3] dt-bindings: phy: rockchip: Add Naneng combo PHY bindings
Date:   Thu, 26 Aug 2021 08:26:01 -0500
Message-Id: <1629984361.449016.1033391.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Aug 2021 20:38:42 +0800, Yifeng Zhao wrote:
> Add the compatible strings for the Naneng combo PHY found on rockchip SoC.
> 
> Signed-off-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
> ---
> 
>  .../phy/phy-rockchip-naneng-combphy.yaml      | 100 ++++++++++++++++++
>  1 file changed, 100 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.example.dt.yaml:0:0: /example-0/syscon@fdc50000: failed to match any schema with compatible: ['rockchip,rk3568-pipegrf', 'syscon']
Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.example.dt.yaml:0:0: /example-0/syscon@fdc70000: failed to match any schema with compatible: ['rockchip,pipe-phy-grf', 'syscon']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1521096

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

