Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9F1C44EBAE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 17:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235426AbhKLRAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 12:00:31 -0500
Received: from mail-oi1-f178.google.com ([209.85.167.178]:33356 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235142AbhKLRAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 12:00:30 -0500
Received: by mail-oi1-f178.google.com with SMTP id q25so13434771oiw.0;
        Fri, 12 Nov 2021 08:57:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n9OxRMPgp6pk93jZ1YlEjSWdjPyoXU189+XIXwiTYRw=;
        b=RaBfxHI9CFSa3vWZ86mkjIwDShThJIdL7aIiUqNeXWqggHznkC4lc7yy0Cb93zgItD
         f0VJ6l7Tn91qVeWsXtohuCn82fXO/PyQjGPtLZBdgRW1LznWwqoDn4fMv3y1VkRtdC4X
         DwJEjJRci7cR+8bzH3/bTThc8UgYtKkredr+kQB85UvlmO0pgPb9gYLYm0II3eJdtjzg
         ki+q+sYyaOsTOzO5PDDtxZJj5S+X5uHgt7q8shmA/ylPxV6S+p/Mc+SOyDrzNXeRrEwh
         EkfXpajvRzHboNXNM+FymzUsO+v9gbgI5DNvGYwS+ogGZyJUw9/SsHYjgRIG95WGfFIX
         0jow==
X-Gm-Message-State: AOAM531PAFvsEVjwRmGJiVjMzrgsvsUD8JcYKy/LjDsQkig6Vtl5JNJu
        dauZvrifQGWWVkeruoOAHw==
X-Google-Smtp-Source: ABdhPJw55ryGR39q61JJpTyvJsied/FtWSJDgs9l5hCvlD+IouVp9dNd0acwh0y+I9393pbRkbSMFw==
X-Received: by 2002:a54:4584:: with SMTP id z4mr27648506oib.158.1636736259168;
        Fri, 12 Nov 2021 08:57:39 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id y203sm1407807oia.1.2021.11.12.08.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 08:57:38 -0800 (PST)
Received: (nullmailer pid 3004958 invoked by uid 1000);
        Fri, 12 Nov 2021 16:57:37 -0000
Date:   Fri, 12 Nov 2021 10:57:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: usb: mtk-xhci: add support ip-sleep for
 mt8195
Message-ID: <YY6dAT3OHbu0CO/J@robh.at.kernel.org>
References: <20211102060049.1843-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211102060049.1843-1-chunfeng.yun@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2021 at 02:00:47PM +0800, Chunfeng Yun wrote:
> There are 4 USB controllers on MT8195, each controller's wakeup control is
> different, add some spicific versions for them.

specific

> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  .../devicetree/bindings/usb/mediatek,mtk-xhci.yaml          | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
> index 11f7bacd4e2b..41efb51638d1 100644
> --- a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
> +++ b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
> @@ -146,7 +146,11 @@ properties:
>              2 - used by mt2712 etc, revision 2 following IPM rule;
>              101 - used by mt8183, specific 1.01;
>              102 - used by mt8192, specific 1.02;
> -          enum: [1, 2, 101, 102]
> +            103 - used by mt8195, IP0, specific 1.03;
> +            104 - used by mt8195, IP1, specific 1.04;
> +            105 - used by mt8195, IP2, specific 1.05;
> +            106 - used by mt8195, IP3, specific 1.06;
> +          enum: [1, 2, 101, 102, 103, 104, 105, 106]
>  
>    mediatek,u3p-dis-msk:
>      $ref: /schemas/types.yaml#/definitions/uint32
> -- 
> 2.18.0
> 
> 
