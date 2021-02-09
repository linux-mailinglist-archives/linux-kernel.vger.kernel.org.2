Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5E663156BB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 20:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233281AbhBITWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 14:22:16 -0500
Received: from mail-oo1-f45.google.com ([209.85.161.45]:34143 "EHLO
        mail-oo1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233092AbhBIR47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 12:56:59 -0500
Received: by mail-oo1-f45.google.com with SMTP id x23so4463139oop.1;
        Tue, 09 Feb 2021 09:56:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vBG1WNZ+VYDg58Hj0p0C8XiVqBI5eXydWO/NFf/WXAw=;
        b=fABRR1tikxdvOZTDSRUQLYcn2A/OKITUgcpLOHPwS+Rq4O2heGSNv6yG+ro9w7/JrI
         Y3xrNz9KyGZlvV4pMzTZzgj51UFd5oWSyRSLpsid13FcVrrj/9ltDorlll4+1LRYGIlo
         4lhLozOhYAj6aCpPxAJSU8QaeFCHm50YU7c9GLBIv7l4QEbslc7UzpaBNaHq5CbjevCF
         MAhdB6+ERWbFVAWDFaMubLtdbZ14dZCvLiqUMm4yoH8DiPwoGAgLSf/QM4hXvIo62Xsq
         6mu8ADP1FHZ8EHnB3ZjbVmejarOrUDmuItakAVgsg6QHIQtUXbZJJwzqbVWSauccJ2Uf
         h0jw==
X-Gm-Message-State: AOAM531Fu4p51zqKacB8q7ryDKMnVQdkN3vxSsF2o7DubSr+2SJgVHer
        91SUHerob7hyC8sR2Nxzdw==
X-Google-Smtp-Source: ABdhPJwDyWG7JxVSQrPKKUjAO9gUPF8tm8MuPSOj8dj3+6IQC3cBmate/FqH6XfP1vsC+kwAHHQdBA==
X-Received: by 2002:a4a:c489:: with SMTP id f9mr16497336ooq.49.1612893377147;
        Tue, 09 Feb 2021 09:56:17 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a63sm4498903otc.75.2021.02.09.09.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 09:56:15 -0800 (PST)
Received: (nullmailer pid 4039705 invoked by uid 1000);
        Tue, 09 Feb 2021 17:56:14 -0000
Date:   Tue, 9 Feb 2021 11:56:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     gabriel.fernandez@foss.st.com
Cc:     Stephen Boyd <sboyd@kernel.org>, marex@denx.de,
        Etienne Carriere <etienne.carriere@st.com>,
        devicetree@vger.kernel.org,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-clk@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH v2 13/14] dt-bindings: clock: stm32mp1 new compatible for
 secure rcc
Message-ID: <20210209175614.GA4039647@robh.at.kernel.org>
References: <20210126090120.19900-1-gabriel.fernandez@foss.st.com>
 <20210126090120.19900-14-gabriel.fernandez@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126090120.19900-14-gabriel.fernandez@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jan 2021 10:01:19 +0100, gabriel.fernandez@foss.st.com wrote:
> From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
> 
> Introduce new compatible string "st,stm32mp1-rcc-secure" for
> stm32mp1 clock driver when the device is configured with RCC
> security support hardened.
> 
> Signed-off-by: Etienne Carriere <etienne.carriere@st.com>
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
> ---
>  .../devicetree/bindings/clock/st,stm32mp1-rcc.yaml          | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
