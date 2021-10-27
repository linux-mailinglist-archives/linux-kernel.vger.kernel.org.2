Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1F3A43D2F4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 22:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243952AbhJ0Ujo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 16:39:44 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:33399 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243901AbhJ0Ujn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 16:39:43 -0400
Received: by mail-ot1-f48.google.com with SMTP id 107-20020a9d0a74000000b00553bfb53348so5483131otg.0;
        Wed, 27 Oct 2021 13:37:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rX2cDz/wX3SJcEzn8Nu4ObsMyqT3SKyEBfgx7vaoHC0=;
        b=LHyFFXbxg5bIkAWBA/LD7g19uK0MjyZaMtxNsJz0UAzL/qTksmuGYRz3TDsVj7Efb2
         WolbQ5wRTdnRF7BHbE2Nt2KADAoLlSenxTHEsJ1Hp0zhzwSEqA8RagJpc+8yonWYvgqb
         COnOQn2qjb2/2JM8eb6DhS/Ft328EjJzMQmcvMybOWjvvJcflNob/HL/yuTxXPUtgAWH
         gRZbzmacjDunauLi8cqKymX0zy7vW/J//zm8S/iNVNGXEcfXKI54qF4DrdTsSQ7a2T2u
         ccO8O8oG0ocki1MKJhRk04TSSubLL4ueckgkJknpWaByVnC0BAX6RngbgOFRwjVLCqFk
         xyCw==
X-Gm-Message-State: AOAM533iygTnOYXCv0xC0yAM9rD4XVtqQTMRQv7oqdgHfp2ZsGpCq5n8
        lU5lt6SCtCWAHlnlsyjrkw==
X-Google-Smtp-Source: ABdhPJy12B0q9y/jsgaw9j6Z9KG6IRo1plCckYJmB4tG62BmgFFtR7P/gNzCxU8EVI0mHiuMU/KcOw==
X-Received: by 2002:a05:6830:3114:: with SMTP id b20mr26764249ots.163.1635367037476;
        Wed, 27 Oct 2021 13:37:17 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 38sm365362oti.13.2021.10.27.13.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 13:37:16 -0700 (PDT)
Received: (nullmailer pid 2110622 invoked by uid 1000);
        Wed, 27 Oct 2021 20:37:16 -0000
Date:   Wed, 27 Oct 2021 15:37:16 -0500
From:   Rob Herring <robh@kernel.org>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     devicetree@vger.kernel.org, andrew@lunn.ch,
        alexandre.belloni@bootlin.com, linux-phy@lists.infradead.org,
        vkoul@kernel.org, robh+dt@kernel.org, kishon@ti.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: phy: Add lan966x-serdes binding
Message-ID: <YXm4fIRt4NHo7z0F@robh.at.kernel.org>
References: <20211020094229.1760793-1-horatiu.vultur@microchip.com>
 <20211020094229.1760793-2-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020094229.1760793-2-horatiu.vultur@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Oct 2021 11:42:27 +0200, Horatiu Vultur wrote:
> Document the lan966x ethernet serdes phy driver bindings.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  .../phy/microchip,lan966x-serdes.yaml         | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/microchip,lan966x-serdes.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
