Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3E90402EAD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 21:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345278AbhIGTDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 15:03:31 -0400
Received: from mail-oo1-f50.google.com ([209.85.161.50]:45586 "EHLO
        mail-oo1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbhIGTD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 15:03:29 -0400
Received: by mail-oo1-f50.google.com with SMTP id m14-20020a4ad50e000000b002912a944a47so80533oos.12;
        Tue, 07 Sep 2021 12:02:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Uf9oAMweWSvXHeUJ78rjsUAw0orQH67zgtFYqz1QUvI=;
        b=NYVMB56QyzUhBhopyXJKd0DOK9Lv1iZMutp92UaY9MLiOmLvDlv8LvpFQj2nD05LOw
         nCtEGsYGxjCdADBCKMf8ySTMWACTyQ7z46Bh0IajZWntXRn76VQTfHzg1VkEfZf9JVHd
         3BYngQ/TddPG42fU40hYmZK/APhhdm1grGnjwo3M6OPA5K/DUEOBhLvr/ErdYovyK+jb
         tFkiXB7QLcOAdMVUh26sf9EtoAHgGR5lOMcezYL2rI+OUj8WXAJcsVHqXi+39LHxWJEY
         yLzI0f1nslQdx5jppI38T070mQ/Oo5n0d9qC7F9HHwC4/691aPjZTzYL/cT/dYNajOAi
         c+5g==
X-Gm-Message-State: AOAM530k3plAQwt7Ki8eM9ot2U3B0PKL06MGhMah/rKinuG2OOuEbQyl
        51vBVKmNWtp9bE0WaliymA==
X-Google-Smtp-Source: ABdhPJzzEU9OPNW0P0QTHLeD3TNxPLYcOxjSNkaHogHMEA8afDB76z0jrTVRTxpd0RpUYsiQFZRXLg==
X-Received: by 2002:a4a:db68:: with SMTP id o8mr1124351ood.98.1631041342612;
        Tue, 07 Sep 2021 12:02:22 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id b24sm2280646oic.33.2021.09.07.12.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 12:02:21 -0700 (PDT)
Received: (nullmailer pid 162836 invoked by uid 1000);
        Tue, 07 Sep 2021 19:02:20 -0000
Date:   Tue, 7 Sep 2021 14:02:20 -0500
From:   Rob Herring <robh@kernel.org>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Nikhil Devshatwar <nikhil.nd@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v5 4/6] phy: dt-bindings: cdns,dphy: make clocks optional
 for Rx mode
Message-ID: <YTe3PDnhtBcRj9ti@robh.at.kernel.org>
References: <20210902185543.18875-1-p.yadav@ti.com>
 <20210902185543.18875-5-p.yadav@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210902185543.18875-5-p.yadav@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Sep 2021 00:25:41 +0530, Pratyush Yadav wrote:
> The clocks are not used by the DPHY when used in Rx mode so make them
> optional for it by using a conditional based on compatible.
> 
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> 
> ---
> 
> Changes in v5:
> - Make clocks a required property based on the compatible.
> 
> Changes in v3:
> - Add Rob's Ack.
> 
> Changes in v2:
> - Re-order subject prefixes.
> 
>  .../devicetree/bindings/phy/cdns,dphy.yaml          | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
