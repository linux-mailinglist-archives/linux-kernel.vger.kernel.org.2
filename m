Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67576317138
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 21:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbhBJUVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 15:21:48 -0500
Received: from mail-oo1-f44.google.com ([209.85.161.44]:43526 "EHLO
        mail-oo1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233343AbhBJUUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 15:20:01 -0500
Received: by mail-oo1-f44.google.com with SMTP id x19so791853ooj.10;
        Wed, 10 Feb 2021 12:19:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=noYHEwVngp0MCW7P3WaZktPMzdf19liz0sKGmntgNy0=;
        b=WETYwA36nqbuvDPAr/db36o/gr64wa7ihlHu00nMKK8wtgkQ63VuQflo64csJ5C8FP
         iFYKyXyNHO0C7oXvhrVrQw7ebZcMETdqckeicfU0KN7tYo+KQ44Jz+11TEj52aAjHQsK
         J6TGxSd9AtfhdtyfhD9zmEbP/zi8qyMB04hAMiFB+nWGVBrJTYaOidl6gj2VTd1md9eB
         SHs5J7GkffpCR+dTVryO1WYoMYnLiL4/yA3suaOqElG5sss9MN9AmbHNdC/UToXFkg0B
         qlKYM6DkWE6kzlbyzgnSxXkdM64lt1ENFQmDkI0sLA3twP0H6Sv0S/6JvimM89mFuw1B
         Tpig==
X-Gm-Message-State: AOAM530OQ19oO0XJ8F4ST64wo59aGTowdkzdUBYa85TM4YKrW/LiaQ0E
        1odiuIWTJ+a22HhO1AeTbA==
X-Google-Smtp-Source: ABdhPJy8wefpU5pDQ9Fp79GZwiz6/pTPGaxuaccPU03yNTblR5fx4HkuOdEx1FI8cQ2sBeqrA2kysA==
X-Received: by 2002:a4a:d10c:: with SMTP id k12mr3365088oor.74.1612988358484;
        Wed, 10 Feb 2021 12:19:18 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t71sm669600oih.45.2021.02.10.12.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 12:19:17 -0800 (PST)
Received: (nullmailer pid 2690943 invoked by uid 1000);
        Wed, 10 Feb 2021 20:19:16 -0000
Date:   Wed, 10 Feb 2021 14:19:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Vinod Koul <vkoul@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: phy: phy-stm32-usbphyc: add
 #clock-cells property
Message-ID: <20210210201916.GA2690885@robh.at.kernel.org>
References: <20210208114659.15269-1-amelie.delaunay@foss.st.com>
 <20210208114659.15269-2-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210208114659.15269-2-amelie.delaunay@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 08 Feb 2021 12:46:58 +0100, Amelie Delaunay wrote:
> usbphyc provides a unique clock called ck_usbo_48m.
> STM32 USB OTG needs a 48Mhz clock (utmifs_clk48) for Full-Speed operation.
> ck_usbo_48m is a possible parent clock for USB OTG 48Mhz clock.
> 
> ck_usbo_48m is available as soon as the PLL is enabled.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
> ---
> Changes in v3:
> - remove #clock-cells from required properties
> ---
>  Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
