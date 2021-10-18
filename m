Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7D543276B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 21:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbhJRTUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 15:20:30 -0400
Received: from mail-oi1-f179.google.com ([209.85.167.179]:36509 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232424AbhJRTU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 15:20:27 -0400
Received: by mail-oi1-f179.google.com with SMTP id u69so1227653oie.3;
        Mon, 18 Oct 2021 12:18:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bt90VyLc6tV9HrByFLUwNOwZWxF8o3tcqxJtoTeeT4c=;
        b=KHhbshhIuHQHJo7kuF2ZWpUB5NcyNdh07W/tk8Y8Xbs6GvyO4wPDQ22B4Qth2hYKY7
         YSIu3sWBSWgT85dd/VlIB1EieB6AoRtjGK96j8Yy3zrKPyKWqV7LGjKUXP/bbXab7tBa
         VCQ5XMMYqb1901lRYQTOxMq6grKIGc3IH4eFJHYWqNNK+iiE/IydNp27QEOPuENTpsqs
         fYv/ttnt5wb5NelGbhRpgKWgz+Ko1gdk/EkuP5uDJRKKBpsiCSwKqQLcTwdMP2FtOnc9
         I1/vJSyriFnEf4jBlfjJkYbvaH1D/aYnm3xiLHkCsKtOurjXhL7nZ1YPkyvzn7/wB914
         oOfg==
X-Gm-Message-State: AOAM533HcHJdFctIk1wWncC6G55SOL2SIiOotvDRD8IG4+5YGE6qIdiy
        aRMXgIxWsDocJom4M4OMTg==
X-Google-Smtp-Source: ABdhPJyZEqV1avqCfkUrHC67E7MCfPVFDi4bd9rsxQN5tV/OzzjLhlX1HsHCIW605xDgj3sEaXrbyQ==
X-Received: by 2002:aca:5b56:: with SMTP id p83mr605204oib.119.1634584696145;
        Mon, 18 Oct 2021 12:18:16 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id h91sm3137144otb.38.2021.10.18.12.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 12:18:15 -0700 (PDT)
Received: (nullmailer pid 2787169 invoked by uid 1000);
        Mon, 18 Oct 2021 19:18:14 -0000
Date:   Mon, 18 Oct 2021 14:18:14 -0500
From:   Rob Herring <robh@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     l.stach@pengutronix.de, tharvey@gateworks.com, kishon@ti.com,
        vkoul@kernel.org, galak@kernel.crashing.org, shawnguo@kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: Re: [PATCH v3 6/9] dt-bindings: imx6q-pcie: Add PHY phandles and
 name properties
Message-ID: <YW3IdoS+zHa4x70Z@robh.at.kernel.org>
References: <1634028078-2387-1-git-send-email-hongxing.zhu@nxp.com>
 <1634028078-2387-7-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1634028078-2387-7-git-send-email-hongxing.zhu@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 04:41:15PM +0800, Richard Zhu wrote:
> i.MX8MM PCIe has the PHY. Add a PHY phandle and name properties
> in the binding document.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> index 2911e565b260..99d9863a69cd 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> @@ -128,6 +128,12 @@ properties:
>      enum: [1, 2, 3, 4]
>      default: 1
>  
> +  phys:
> +    description: Phandle of the Generic PHY to the PCIe PHY.

maxItems: 1

And drop 'description'

> +
> +  phy-names:
> +    const: pcie-phy
> +
>    reset-gpio:
>      description: Should specify the GPIO for controlling the PCI bus device
>        reset signal. It's not polarity aware and defaults to active-low reset
> -- 
> 2.25.1
> 
> 
