Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 793063AA776
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 01:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234597AbhFPXab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 19:30:31 -0400
Received: from mail-io1-f54.google.com ([209.85.166.54]:44604 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234508AbhFPXa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 19:30:29 -0400
Received: by mail-io1-f54.google.com with SMTP id q3so1020365iop.11;
        Wed, 16 Jun 2021 16:28:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xV2j/EdwVr9gYo7BsYPb7ja8r4fncuGCJrMkRrs/+ek=;
        b=XebRvEMUZyg/a4OFiwIlyNkZV+OZyTKcP9saF/Idd2BqZ1vAB61w27nbf5hJo83NJz
         5MVwXMjGit8Rf+VDu/liOmRbvd7kMBteVAkg/nuxF2zUR67J85sYxLxcDoZhH/85WPL6
         QXS15pFgJdbQqVVbOaizcsNnMWToOVm3rxsI98XEJLkWbbxPiyiIyWs8Okgk7WjFVu/u
         217gKRYwIVlTkw0/5S2+5BrVxMHDNvF7lWscXkYC0IXqNRT1/lWLZH6kEZ4FkL02ghzb
         /uHXR7PDcmp9s2hPFL2leCk5RrQlalRW410x+K6uNiG6Xokf0GkAqjux6DW/tKa0tLpx
         bdyQ==
X-Gm-Message-State: AOAM5319gcAy5Vf0w5LO6yEvdIIiXsSHSIaA21zEpfbXJqpygGw+Uqz1
        Q8z5F2FcX/lHGJLDN23uag==
X-Google-Smtp-Source: ABdhPJy3RhIjKN/CDWVX8vYjXN0Rn6x/UxRBlzkJvxqDZVxPyVz+nQXCDwrjbqXkYYHI4y39Ek+SAA==
X-Received: by 2002:a05:6602:38d:: with SMTP id f13mr1377780iov.109.1623886101700;
        Wed, 16 Jun 2021 16:28:21 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id i7sm1341033ilq.50.2021.06.16.16.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 16:28:20 -0700 (PDT)
Received: (nullmailer pid 284524 invoked by uid 1000);
        Wed, 16 Jun 2021 23:28:17 -0000
Date:   Wed, 16 Jun 2021 17:28:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eddie Hung <eddie.hung@mediatek.com>
Subject: Re: [PATCH 1/3] dt-bindings: phy: mediatek: tphy: add support
 hardware version 3
Message-ID: <20210616232817.GA277610@robh.at.kernel.org>
References: <1622791880-20262-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622791880-20262-1-git-send-email-chunfeng.yun@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2021 at 03:31:18PM +0800, Chunfeng Yun wrote:
> The PHYA architecture is updated, and doesn't support slew rate
> calibration anymore on 7nm or advanced process, add a new version
> number to support it.
> Note: the FreqMeter bank is not used but reserved.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  .../devicetree/bindings/phy/mediatek,tphy.yaml     | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml b/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
> index b8a7651a3d9a..939c09296b5f 100644
> --- a/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
> +++ b/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
> @@ -15,7 +15,7 @@ description: |
>    controllers on MediaTek SoCs, includes USB2.0, USB3.0, PCIe and SATA.
>  
>    Layout differences of banks between T-PHY V1 (mt8173/mt2701) and
> -  T-PHY V2 (mt2712) when works on USB mode:
> +  T-PHY V2 (mt2712) / V3 (mt8195) when works on USB mode:
>    -----------------------------------
>    Version 1:
>    port        offset    bank
> @@ -34,7 +34,7 @@ description: |
>    u2 port2    0x1800    U2PHY_COM
>                ...
>  
> -  Version 2:
> +  Version 2/3:
>    port        offset    bank
>    u2 port0    0x0000    MISC
>                0x0100    FMREG
> @@ -59,7 +59,8 @@ description: |
>  
>    SPLLC shared by u3 ports and FMREG shared by u2 ports on V1 are put back
>    into each port; a new bank MISC for u2 ports and CHIP for u3 ports are
> -  added on V2.
> +  added on V2; the FMREG bank for slew rate calibration is not used anymore
> +  and reserved on V3;
>  
>  properties:
>    $nodename:
> @@ -79,8 +80,11 @@ properties:
>                - mediatek,mt2712-tphy
>                - mediatek,mt7629-tphy
>                - mediatek,mt8183-tphy
> -              - mediatek,mt8195-tphy
>            - const: mediatek,generic-tphy-v2

This doesn't look like a good change.

What happens if a DT has the above. It didn't work or didn't support new 
features? Please clarify in the commit the implications of changing 
this. Changing a DT to 'mediatek,generic-tphy-v3' will break existing OS 
if it was looking for v2.

> +      - items:
> +          - enum:
> +              - mediatek,mt8195-tphy
> +          - const: mediatek,generic-tphy-v3
>        - const: mediatek,mt2701-u3phy
>          deprecated: true
>        - const: mediatek,mt2712-u3phy
> @@ -91,7 +95,7 @@ properties:
>      description:
>        Register shared by multiple ports, exclude port's private register.
>        It is needed for T-PHY V1, such as mt2701 and mt8173, but not for
> -      T-PHY V2, such as mt2712.
> +      T-PHY V2/V3, such as mt2712.
>      maxItems: 1
>  
>    "#address-cells":
> -- 
> 2.18.0
