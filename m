Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEBC6315681
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 20:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233296AbhBITGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 14:06:20 -0500
Received: from mail-ot1-f49.google.com ([209.85.210.49]:43677 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbhBIRxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 12:53:23 -0500
Received: by mail-ot1-f49.google.com with SMTP id l23so6611168otn.10;
        Tue, 09 Feb 2021 09:53:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p0jcMoP1zdNYZ/i9r9D2TVX6lIvZeuJzpwgY33snses=;
        b=NvVgZWjBbQf5422zdoqH5Zx7t92Vs1fywew34O9HXTyHiQa4TpTf2c1B/JHDYQa1r/
         qNE5N1ucrmxgp0PlilLcHKw4h5svIMqdUS3bN0sy3eF78Fmk+3uJ57c0HzjkyHpnhCVI
         jFN/LRtPt14DFrKfaxiQobL4YCDRVhUvJm530u2BRkgvBoIhldbYN2h2ILFdF2+MbdHy
         bNnJPRE0EA1QppZt8kKRMfxxLll8f0jbRCl2uPkofsGUkNssHY5SjbzodBzL0DqXZEpL
         RgGE9U6huh8eSykhea3Kn5TCIlT93LqQEb7gwwun0Fetk/sbfFUZcB8kk5P5Un6rLfki
         hUCg==
X-Gm-Message-State: AOAM532l552/947piWcfDI66F5egL6I2TGxoWsuF/byxhrXEhqZVxjhi
        YnX54qSrF3Cgvk8yiaWqLw==
X-Google-Smtp-Source: ABdhPJwmuWp6tTbWnSQ2IizYcSJo7pRxp1UJAGJBCc/J9iE3yPA1PUXrjaX/PbRV1oI5evxkC1IZrQ==
X-Received: by 2002:a05:6830:191:: with SMTP id q17mr16277282ota.110.1612893158858;
        Tue, 09 Feb 2021 09:52:38 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k21sm2886850otl.27.2021.02.09.09.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 09:52:37 -0800 (PST)
Received: (nullmailer pid 4032920 invoked by uid 1000);
        Tue, 09 Feb 2021 17:52:35 -0000
Date:   Tue, 9 Feb 2021 11:52:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     gabriel.fernandez@foss.st.com
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-clk@vger.kernel.org, marex@denx.de,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Etienne Carriere <etienne.carriere@st.com>,
        linux-arm-kernel@lists.infradead.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Alexandre Torgue <alexandre.torgue@st.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 07/14] dt-bindings: clock: add IDs for SCMI clocks on
 stm32mp15
Message-ID: <20210209175235.GA4032862@robh.at.kernel.org>
References: <20210126090120.19900-1-gabriel.fernandez@foss.st.com>
 <20210126090120.19900-8-gabriel.fernandez@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126090120.19900-8-gabriel.fernandez@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jan 2021 10:01:13 +0100, gabriel.fernandez@foss.st.com wrote:
> From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
> 
> stm32mp15 TZ secure firmware provides SCMI clocks for oscillators, some
> PLL output and few secure aware interfaces.
> This change defines the SCMI clock identifiers used by SCMI agents
> and servers.
> Server SCMI0 exposes clocks and reset controllers for resources under
> RCC[TZEN] configuration control.
> Server SCMI1 exposes clocks for resources under RCC[MCKPROT] control.
> 
> Signed-off-by: Etienne Carriere <etienne.carriere@st.com>
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
> ---
>  include/dt-bindings/clock/stm32mp1-clks.h | 27 +++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
