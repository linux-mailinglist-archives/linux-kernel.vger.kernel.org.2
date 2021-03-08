Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3E243314C3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 18:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbhCHRZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 12:25:37 -0500
Received: from mail-il1-f181.google.com ([209.85.166.181]:32910 "EHLO
        mail-il1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbhCHRZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 12:25:20 -0500
Received: by mail-il1-f181.google.com with SMTP id e2so9576476ilu.0;
        Mon, 08 Mar 2021 09:25:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vIVJn0dfzyuEu1fc1pG9IIEiq5Z5cVODUyeYv5JKrec=;
        b=MmsJWvi+ptaq1R2l8wLC95oNNHPH9VkHZN5dKdBabt6NotEd3FUV4B9ktFxIdrpeOk
         P+Kxj45W71ADQCRPRfYt1u4A+6WNEkAGqy9nnKJyLT9kDA7Pn9HsKXV1yuNZxvHxHyi/
         QLb6JCmhJQhmjauxeMKH+ySiY6WY9BL0WKcHyFMXasOfT7MZO9bcirKlD1AH6Y1HDM2i
         ewwakNIPtQENEYX0w0dNfVMhnAGMSM/q++5m9IiTbvTN27X+N41BUMNpHBLjwVFBpT58
         lNrFHNF+4+CfvfypFBZzExrPtDDSOr9NdH5e7h/JhiDEWShtLaovCDUOlwRKgNXnWk1f
         LiyQ==
X-Gm-Message-State: AOAM531JoCCVRBjC8f6Afh5AhHrki9pJB+/QMu9pRxc49SExpJAAABXA
        12DUBu/iUcthMZIVNvPNIg==
X-Google-Smtp-Source: ABdhPJx7pdAdChDvnGroL7a9Jyeo6qMHW8ZnqjNuqGEkpdo4TBM/DOewoxvAoegPEztBQOdvd9G93Q==
X-Received: by 2002:a92:c052:: with SMTP id o18mr21120330ilf.84.1615224320209;
        Mon, 08 Mar 2021 09:25:20 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id o23sm6488114ioo.24.2021.03.08.09.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 09:25:19 -0800 (PST)
Received: (nullmailer pid 2660270 invoked by uid 1000);
        Mon, 08 Mar 2021 17:25:17 -0000
Date:   Mon, 8 Mar 2021 10:25:17 -0700
From:   Rob Herring <robh@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-amarula@amarulasolutions.com,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: Re: [PATCH v3 09/10] dt-bindings: arm: stm32: Add Engicam i.Core
 STM32MP1 EDIMM2.2 Starter Kit
Message-ID: <20210308172517.GA2660220@robh.at.kernel.org>
References: <20210228154323.76911-1-jagan@amarulasolutions.com>
 <20210228154323.76911-10-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210228154323.76911-10-jagan@amarulasolutions.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Feb 2021 21:13:22 +0530, Jagan Teki wrote:
> i.Core STM32MP1 is an EDIMM SoM based on STM32MP157A from Engicam.
> 
> EDIMM2.2 Starter Kit is an EDIMM 2.2 Form Factor Capacitive Evaluation
> Board from Engicam.
> 
> i.Core STM32MP1 needs to mount on top of this Evaluation board for
> creating complete i.Core STM32MP1 EDIMM2.2 Starter Kit.
> 
> Add bindings for it.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v3:
> - none
> 
>  Documentation/devicetree/bindings/arm/stm32/stm32.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
