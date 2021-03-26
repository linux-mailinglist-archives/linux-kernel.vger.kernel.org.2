Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94654349DC8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 01:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbhCZA3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 20:29:24 -0400
Received: from mail-io1-f51.google.com ([209.85.166.51]:44630 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbhCZA3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 20:29:00 -0400
Received: by mail-io1-f51.google.com with SMTP id v26so3725914iox.11;
        Thu, 25 Mar 2021 17:29:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HqP361nCuW7IrybuNXs/MVht6WlPAUMBMTJUt5NbOBY=;
        b=I6zXN7xIncv/8CssIGBh4PPLCdw6Oa5rSg00e/hjF12rL4SruR9Hj5oSo+rnrhDPlK
         m9D5tCZJfEfGIrh8aKRREH3gxutJsa1VbbTDdXupYKp5ogCssJlu7H6oHpBPyMrIwE1u
         rkxHiHun/2PrbGMNlPjvlXrCEGHKCFZ815n/Kpq0puzcttKP7ZvDo7zxfS1q9CcnV1Xz
         bVoaxNex1qKb+04IMkbYYReQ5gG/rYo8OQ9rsgRFH1fcoaeE2mg3B++usnuNBl6WxjDT
         r7m8nmk4TiiEinV3yxMmgWKRVtAu8REJb+VtmchV0t9qf6EVc513pJZ2ExFejqEYSTGI
         vzjg==
X-Gm-Message-State: AOAM5325dpoA0uw0j8tSwNg6jmiVeMCdJTHu5sbqSAvbWgolM/bBfwds
        UhD4C53QKJCfMqhMUEFIA1mD1ZxA+w==
X-Google-Smtp-Source: ABdhPJw6W3NHdAqO/y5OThYoAM4qmj7MMyJPG3HX8vVwI93D07pwvhmlBcQDFuiXigdabDHe9NnU5Q==
X-Received: by 2002:a6b:7c4a:: with SMTP id b10mr8401982ioq.170.1616718540205;
        Thu, 25 Mar 2021 17:29:00 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id k7sm3417611ils.35.2021.03.25.17.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 17:28:59 -0700 (PDT)
Received: (nullmailer pid 2033074 invoked by uid 1000);
        Fri, 26 Mar 2021 00:28:51 -0000
Date:   Thu, 25 Mar 2021 18:28:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 1/2] dt-bindings: phy: add vbus-supply optional property
 to phy-stm32-usbphyc
Message-ID: <20210326002851.GA2031564@robh.at.kernel.org>
References: <20210317160954.15487-1-amelie.delaunay@foss.st.com>
 <20210317160954.15487-2-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210317160954.15487-2-amelie.delaunay@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 05:09:53PM +0100, Amelie Delaunay wrote:
> This patch adds vbus-supply optional property to phy sub-nodes.
> A regulator for USB VBUS may be needed for host mode.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
> ---
>  Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.yaml b/Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.yaml
> index 018cc1246ee1..ad2378c30334 100644
> --- a/Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.yaml
> +++ b/Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.yaml
> @@ -71,6 +71,9 @@ patternProperties:
>        phy-supply:
>          description: regulator providing 3V3 power supply to the PHY.
>  
> +      vbus-supply:
> +        description: regulator providing 5V Vbus to the USB connector.

Unless Vbus is powering the phy, then this only belongs in the USB 
connector node.

> +
>        "#phy-cells":
>          enum: [ 0x0, 0x1 ]
>  
> -- 
> 2.17.1
> 
