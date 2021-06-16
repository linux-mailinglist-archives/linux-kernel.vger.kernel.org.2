Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A158E3AA77F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 01:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234619AbhFPXdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 19:33:20 -0400
Received: from mail-io1-f54.google.com ([209.85.166.54]:41584 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234508AbhFPXdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 19:33:19 -0400
Received: by mail-io1-f54.google.com with SMTP id p66so1037892iod.8;
        Wed, 16 Jun 2021 16:31:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xYjPOVFrGcuwzYtCkpC3/ADNpp9HDl4uS6+qpD2/Jyw=;
        b=pw7YViWKbP3uiM9GiWyjQmgHhn/LUyMUG4Xr9b4nNj5jvN3j9/pqkh2tpyWODKRYlV
         mcinVO4HLMNgafBmMR3P9q0FcOqG8LA4pGUp4LU+eaZPlt9xEinqSm2AnOQuqTf7kkPj
         Mjg5cPmyoyWwPXLLcpZIfhDoyAb/sdBOItGuWpiiC1KwqZBqY/Vnl491fPs6x08bPnjm
         OynkiOeYYagSj6mBlOebnEDxi8D6sAkueJavBD0UtCzaC+bxf6THyp2xSvT+6KCmbipt
         f/BcLDGpEawPoH2mt2bEeSxZbI07wy+APzyQzYYOpY7cx4UmSjsqyHAiQ1BnqmAuj3Z4
         KF6g==
X-Gm-Message-State: AOAM531NTViK+m0WO/T8xN3Y5JUe81YpR9Uzk4CSWS1W6cWiwLAOgoY/
        WLCQXkixDGMAlDPsssm/3Q==
X-Google-Smtp-Source: ABdhPJyyUtjrWdXCPRwIyDSdK8eyilrcAdS/kqWlBnMmR3Kq3QNqwcTLrFso8p3R0dLnOz85MLm7Iw==
X-Received: by 2002:a05:6638:3298:: with SMTP id f24mr1587297jav.25.1623886272107;
        Wed, 16 Jun 2021 16:31:12 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id p19sm1953479iob.7.2021.06.16.16.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 16:31:11 -0700 (PDT)
Received: (nullmailer pid 288247 invoked by uid 1000);
        Wed, 16 Jun 2021 23:31:09 -0000
Date:   Wed, 16 Jun 2021 17:31:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, kishon@ti.com, vkoul@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: phy: Add the Amlogic Meson8 HDMI TX PHY
 bindings
Message-ID: <20210616233109.GA285667@robh.at.kernel.org>
References: <20210604190338.2248295-1-martin.blumenstingl@googlemail.com>
 <20210604190338.2248295-2-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604190338.2248295-2-martin.blumenstingl@googlemail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2021 at 09:03:37PM +0200, Martin Blumenstingl wrote:
> Amlogic Meson8, Meson8b and Meson8m2 all include an identical (or at
> least very similar) HDMI TX PHY. The PHY registers are part of the HHI
> register area.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  .../phy/amlogic,meson8-hdmi-tx-phy.yaml       | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/amlogic,meson8-hdmi-tx-phy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/amlogic,meson8-hdmi-tx-phy.yaml b/Documentation/devicetree/bindings/phy/amlogic,meson8-hdmi-tx-phy.yaml
> new file mode 100644
> index 000000000000..18a123b9bb0a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/amlogic,meson8-hdmi-tx-phy.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/phy/amlogic,meson8-hdmi-tx-phy.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Amlogic Meson8, Meson8b and Meson8m2 HDMI TX PHY
> +
> +maintainers:
> +  - Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> +
> +description: |+
> +  The HDMI TX PHY node should be the child of a syscon node with the
> +  required property:
> +
> +  compatible = "amlogic,meson-hhi-sysctrl", "simple-mfd", "syscon"

Is there a sub range of registers for this functionality in 
"amlogic,meson-hhi-sysctrl"? If so, please add a 'reg' property.

> +
> +  Refer to the bindings described in
> +  Documentation/devicetree/bindings/mfd/syscon.yaml
> +
> +properties:
> +  $nodename:
> +    pattern: "^hdmi-phy$"
> +
> +  compatible:
> +    enum:
> +      - amlogic,meson8-hdmi-tx-phy
> +      - amlogic,meson8b-hdmi-tx-phy
> +      - amlogic,meson8m2-hdmi-tx-phy
> +
> +  clocks:
> +    minItems: 1
> +    description:
> +      HDMI TMDS clock
> +
> +  "#phy-cells":
> +    const: 0
> +
> +required:
> +  - compatible
> +  - "#phy-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    hdmi_tx_phy: hdmi-phy {
> +      compatible = "amlogic,meson8-hdmi-tx-phy";
> +      clocks = <&tmds_clock>;
> +      #phy-cells = <0>;
> +    };
> -- 
> 2.31.1
