Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B783E331861
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 21:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbhCHUW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 15:22:58 -0500
Received: from mail-io1-f49.google.com ([209.85.166.49]:42521 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbhCHUW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 15:22:56 -0500
Received: by mail-io1-f49.google.com with SMTP id u20so11377259iot.9;
        Mon, 08 Mar 2021 12:22:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jfi2aPqw0ChJqx8vxxHvr5nY7+u1FCowOmUR1NpI1Xk=;
        b=stmLfwruVP27ntFEKhod8eIDAYp5uZzO1aED+TyfJk87uNLd5BQN64acRovwhiYvXz
         pq5AqSozm4BG/MSIWdQpZ6Al9mPgKzEhHR/YoLOKOH+/UorG1YpIcUeWMV6dB+AMopV9
         FQfLUbUwmVflGN39IQPwIy/LUDybGC7Hb3M77umwgOz2Dt0piRLVzVC0YvLDmFNeRdzy
         tyCdQnc81ir0bNzees4YL+3p+khc9RgtVa4U6yOZdHakyRx1kZQ8xIhZDPms5hA/OBhY
         BoNM26gxLi2FjybZQmb17jNnuqBHPxiToyLlw+IABAyOJMYRq32dWLXY2RWj3237nHt4
         Fuvg==
X-Gm-Message-State: AOAM532Yor4zAegIGzXMGobruwnEgXCt1A73KpDMcWi/MzE4DpB9FpsY
        feVEuuWFVCOnMOzdBA/Mug==
X-Google-Smtp-Source: ABdhPJxQfWFWuxQMzuNGDXRT8YnjCNfgHq5hSq5MQJMX+6MHhJRomQb5K0FHQNafxooMET8AsrT7Xg==
X-Received: by 2002:a05:6638:140e:: with SMTP id k14mr9938401jad.31.1615234975633;
        Mon, 08 Mar 2021 12:22:55 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id i67sm6548510ioa.3.2021.03.08.12.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 12:22:55 -0800 (PST)
Received: (nullmailer pid 2899522 invoked by uid 1000);
        Mon, 08 Mar 2021 20:22:53 -0000
Date:   Mon, 8 Mar 2021 13:22:53 -0700
From:   Rob Herring <robh@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Robert Foss <robert.foss@linaro.org>,
        dri-devel@lists.freedesktop.org,
        Andrzej Hajda <a.hajda@samsung.com>,
        devicetree@vger.kernel.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        linux-amarula@amarulasolutions.com,
        Sam Ravnborg <sam@ravnborg.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: display: bridge: Add Chipone ICN6211
 bindings
Message-ID: <20210308202253.GA2899425@robh.at.kernel.org>
References: <20210304092133.21717-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304092133.21717-1-jagan@amarulasolutions.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Mar 2021 14:51:32 +0530, Jagan Teki wrote:
> ICN6211 is MIPI-DSI to RGB Converter bridge from Chipone.
> 
> It has a flexible configuration of MIPI DSI signal input and
> produces RGB565, RGB666, RGB888 output format.
> 
> Add dt-bingings for it.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v4:
> - fixed Laurent comments
> - added regulators
> - replace reset with EN
> - fixed warnings pointed by Robert
> Changes for v3:
> - updated to new dt-bindings style
> 
>  .../display/bridge/chipone,icn6211.yaml       | 99 +++++++++++++++++++
>  MAINTAINERS                                   |  5 +
>  2 files changed, 104 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/chipone,icn6211.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
