Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A443731568D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 20:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233274AbhBITLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 14:11:15 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:41439 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233364AbhBIRyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 12:54:36 -0500
Received: by mail-ot1-f54.google.com with SMTP id s107so18237448otb.8;
        Tue, 09 Feb 2021 09:53:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5OLpg6/dLCiCZvpRxfwgoYAD7gmTBGuyeOSkVtKIFWY=;
        b=WPxZ6ov62QJmlP+tvw/HTaJ8oo+OKaM79CNL7LR1jPhMuefRBvAjo9ALl3+hnf40ax
         rXuOzYUAk2ryOtWsjtzQURymObFXY3f+JlXLcAJcU2TGhaXEsPEpeoEC450lW3ZsaD/c
         BVNV/HLWXyg23AgGa5zNNLUn8EEXvo3YyyJbezErnbwlaLfaCrcn+Lm1zRU+lKrytVt3
         p2Z0UWQi6DxwAzxIY1rlBU5uOpEGWXtHvW9IpL10T0dTTEQt+Yz166o6bNUoLUtCDvv1
         k29aXZ4gHIlxxJEn1GPQ97BgyR1/k+7hLeZuig/epDv2C21XzDq3oPlohebfDCnODrfB
         fdtw==
X-Gm-Message-State: AOAM533ISO19hLi0DoFO6AjLBxOvY4/1G6JXQ52EuI3UPBNc9l+P4eav
        83WI0z48+L4zRqL+4zjuMQ==
X-Google-Smtp-Source: ABdhPJx8rI+dua6GVjbPf/HNO17WupKmBHDm2AqHofiNnHppJhtWx9h12rQ0cabOmnrryCKVM5QQeA==
X-Received: by 2002:a9d:63c1:: with SMTP id e1mr16232129otl.354.1612893211045;
        Tue, 09 Feb 2021 09:53:31 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g3sm4355428ooi.28.2021.02.09.09.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 09:53:29 -0800 (PST)
Received: (nullmailer pid 4034602 invoked by uid 1000);
        Tue, 09 Feb 2021 17:53:27 -0000
Date:   Tue, 9 Feb 2021 11:53:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     gabriel.fernandez@foss.st.com
Cc:     Etienne Carriere <etienne.carriere@st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Alexandre Torgue <alexandre.torgue@st.com>, marex@denx.de,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
Subject: Re: [PATCH v2 08/14] dt-bindings: reset: add IDs for SCMI reset
 domains on stm32mp15
Message-ID: <20210209175327.GA4034545@robh.at.kernel.org>
References: <20210126090120.19900-1-gabriel.fernandez@foss.st.com>
 <20210126090120.19900-9-gabriel.fernandez@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126090120.19900-9-gabriel.fernandez@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jan 2021 10:01:14 +0100, gabriel.fernandez@foss.st.com wrote:
> From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
> 
> stm32mp15 TZ secure firmware provides SCMI reset domains for
> secure resources. This change defines the SCMI reset domain
> identifiers used by SCMI agents and servers.
> 
> Stm32mp15 TZ secure firmware provides SCMI clocks for oscillators, some
> PLL output and few secure aware interfaces. This change defines the
> SCMI clock identifiers used by SCMI agents and servers.
> 
> Server SCMI0 exposes reset controllers for resources under RCC[TZEN]
> configuration control.
> 
> Signed-off-by: Etienne Carriere <etienne.carriere@st.com>
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
> ---
>  include/dt-bindings/reset/stm32mp1-resets.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
