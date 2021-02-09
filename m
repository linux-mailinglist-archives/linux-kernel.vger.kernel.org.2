Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4427B3156BC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 20:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233683AbhBIT0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 14:26:04 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:35499 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233076AbhBIRzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 12:55:40 -0500
Received: by mail-oi1-f180.google.com with SMTP id l3so10393144oii.2;
        Tue, 09 Feb 2021 09:55:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RQUHj+BXtANW6albug9w4Bx+rstlxLjWFqakR1XfA0o=;
        b=FqW2iG+lnwMqySOCO6AhTmWfeJy18kxtd0JDTuTGuXk1GdQ4eue4FGSgd7D3nD3CrV
         P4HS3nZnYPqkG4xn+6t3gLztCayckpdJhr5E8ErVx9lJL60C5gaaPSD2NY+XiyYFEL7P
         qKoTbh9NBO10VrQKswazxoNPBz5k2NP3UbGZwJNBiGXI1+7R+jyXWDS2PMwmILM+yd6l
         i9yeu5jOGBy1CXJonOIeVfF1qieXtb++HbctCETddbC5LvsfZppOd2iQp5zKCeVPqGF1
         5d6Rclw0nVyYlRXNq2+stZ20wkY7xr3Cm4GF0l0IuCnwkb6U6uQ6U0HTMSVKZMscXJbw
         CxBg==
X-Gm-Message-State: AOAM532Ez5gyGVKXfgvvYytg5hiBPUUe9x2dYuNv55VkpojBj51pJ+aO
        ObiI+RcNOWxyhNHTdPlqWjUa5mn2oQ==
X-Google-Smtp-Source: ABdhPJz/nOQledHdl47iQx6sITmSHInVk2gRA33JBekAqpASydJExVmQ7LdPeUIVMWimUp96wXN6mQ==
X-Received: by 2002:aca:220e:: with SMTP id b14mr3286454oic.130.1612893295896;
        Tue, 09 Feb 2021 09:54:55 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w134sm1409488oia.56.2021.02.09.09.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 09:54:53 -0800 (PST)
Received: (nullmailer pid 4037202 invoked by uid 1000);
        Tue, 09 Feb 2021 17:54:52 -0000
Date:   Tue, 9 Feb 2021 11:54:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     gabriel.fernandez@foss.st.com
Cc:     Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        devicetree@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        marex@denx.de, Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Etienne Carriere <etienne.carriere@st.com>,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 09/14] dt-bindings: reset: add MCU HOLD BOOT ID for
 SCMI reset domains on stm32mp15
Message-ID: <20210209175452.GA4037138@robh.at.kernel.org>
References: <20210126090120.19900-1-gabriel.fernandez@foss.st.com>
 <20210126090120.19900-10-gabriel.fernandez@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126090120.19900-10-gabriel.fernandez@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jan 2021 10:01:15 +0100, gabriel.fernandez@foss.st.com wrote:
> From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
> 
> Add ID to SCMI0 to exposes reset controller for the MCU HOLD BOOT resource.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
> ---
>  include/dt-bindings/reset/stm32mp1-resets.h | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
